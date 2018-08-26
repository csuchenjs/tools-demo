package main

import (
	"bufio"
	"fmt"
	"io"
	"net"
	"os"
	"strings"
	"time"

	"github.com/tatsushid/go-fastping"
)

func getIPAddr(p *fastping.Pinger, hostname string) (string, time.Duration) {
	var address string
	var t time.Duration
	ra, err := net.ResolveIPAddr("ip4:icmp", hostname)
	if err != nil {
		fmt.Println(err)
		return "", 0
	}
	p.AddIPAddr(ra)
	p.OnRecv = func(addr *net.IPAddr, rtt time.Duration) {
		address = addr.String()
		t = rtt
		//fmt.Printf("IP Addr: %s receive, RTT: %v\n", address, rtt)
	}
	p.OnIdle = func() {
		//fmt.Println("finish")
	}
	err = p.Run()
	if err != nil {
		fmt.Println(err)
	}
	p.RemoveIPAddr(ra)
	return address, t
}

func readFile(filename string) []string {
	file, err := os.Open(filename)
	if err != nil {
		fmt.Println(err)
		return nil
	}
	defer file.Close()

	var records []string
	reader := bufio.NewReader(file)
	for {
		line, _, err := reader.ReadLine()
		if err == io.EOF {
			break
		}
		records = append(records, string(line))
	}
	return records
}

func pingIPFromFile(filename string) {
	records := readFile(filename)
	if len(records) == 0 {
		fmt.Println("no records in file")
		return
	}

	tmpFilename := filename + ".ping"
	file, err := os.OpenFile(tmpFilename, os.O_CREATE|os.O_WRONLY, 0666)
	if err != nil {
		fmt.Println(err)
		return
	}

	p := fastping.NewPinger()
	writer := bufio.NewWriter(file)
	for _, r := range records {
		if strings.HasPrefix(r, "//") {
			writer.WriteString(r + "\r\n")
			continue
		}

		items := strings.Split(r, "\t")
		if len(items) <= 1 {
			writer.WriteString(r + "\r\n")
			continue
		}

		fmt.Printf("Resolving %v...\t", items[0])
		addr, rtt := getIPAddr(p, items[0])
		fmt.Printf("ping addr: %v, time: %v\n", addr, rtt)
		writer.WriteString(items[0] + "\t" + addr + "\t" + rtt.String() + "\t" + items[len(items)-1] + "\r\n")
	}

	err = writer.Flush()
	if err != nil {
		fmt.Println(err)
		return
	}

	// move file
	file.Close()
	err = os.Rename(tmpFilename, filename)
	if err != nil {
		fmt.Println(err)
		return
	}
	// copy filename+ping to filename
	// delete filename+ping
}

func main() {
	if os.Args[1] == "-f" {
		pingIPFromFile(os.Args[2])
	} else if os.Args[1] == "-s" {
		p := fastping.NewPinger()
		addr, rtt := getIPAddr(p, os.Args[2])
		fmt.Printf("IP Addr: %s receive, time: %v\n", addr, rtt)
	} else {
		fmt.Println("invalid args")
		os.Exit(-1)
	}
}
