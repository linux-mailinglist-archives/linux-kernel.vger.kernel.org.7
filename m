Return-Path: <linux-kernel+bounces-753640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8D5B185D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6982A1C247A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8466819CCEC;
	Fri,  1 Aug 2025 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sdazmD5x"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4B1189902
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754065913; cv=none; b=JG/pw4lTb2A6iDHShXe6hkK4xS/xeqzwfwk4weYUrvT7W5ZT8Od5L+KSP2zHZqF79pF/5yQ9p57gR5g61crPxv5B3zMnFe90vJ7H2RgqjbqVAmPdg6UsIKELELp/4lw7DbEefg92KiU7kQLn6RJYIQdRh+L31dVO/YP3R9Pu1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754065913; c=relaxed/simple;
	bh=6hEkeN4SJSpxJSAVhU28lk309YvI51c5hc4D7f3JTM0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iGPQ51houFDEez2gVDmJ4xcqOXnsl0nWJR5vFQc/QlxJEsA7DAhziddY+sIYCuFCV9Hk8s/aEo5dHvc1K818LMA6hokF68n2gp4Lzf2jCLnylaBZvTmocb8RANA26NoBDNM6F7096bQnU2IutESwNlBqAULz0qPKKKnDtdjpGmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sdazmD5x; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-881570be6a5so33102739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754065910; x=1754670710; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dmze8JSbkhnZOjJ2MGDZak6RjJrqfUwPzsMaderEcdU=;
        b=sdazmD5x+WmM4rYDCEqxyJqvbaGGSLazllDchFQ/0Wx0s9kg3ZfXjDA03m+w7NGOEW
         2JugTxA4Dwd+A5l/WuBaVa+Mq/CosiMpxP4NnXwMi3fLk1w+IwLCD2wPvjYBPVYy4RwB
         +5VPi8qP5TsRG0SIVfY95FtURq9LrC7IwE6odyho2xYfElae865uvRfrga9GvGWhtEHS
         zC6zqUpSUHeiOMzp46R1k1LTYQ1R7X5Ec876NdHZY0HR79GQUYVQoUdWoO0WQ+Et5Ckk
         J0BDNQKq54t9hvxDMq5+DareeDXBJ6cOTkuhb6sHbtM8QDqSnN0NGDRa3TEjEozBhvxv
         Lt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754065910; x=1754670710;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dmze8JSbkhnZOjJ2MGDZak6RjJrqfUwPzsMaderEcdU=;
        b=GA1lWH9/3KnswoNt6sDmWqOU5+dGTYiH8m9QqUMX7GMiBnMNbljuNpkzRtWnHsdycX
         rorE4IcFhdDEu+Xdi5nHQ1hCxYJUYk0PIMnL6QrdxVeub4bfZFBdFpCIExeriPmy7hQI
         vGO6gAJoJEwt2WYZaNW97WU6bX+iJlFl6DrS6aiJo2/jHYRZ0iEI2GNMv7eu6pc9EmP9
         TIIzC38tWJZB7RFqYBK2Vbx6kDA5aM4eYCX85EZkkUej7WQ0BsPO7WTZ6EXfyXJwZBpR
         aL723yfbUQXPg8P707jfd0NuqzkL1pF5JhiEN9BM0dbjLzmD0jXUC5Ve3NE6bXhbpoIK
         Lhqw==
X-Forwarded-Encrypted: i=1; AJvYcCXfyfeU70QcJ72W8daUzVsSipM2XwftYm9n/j93ReXGJM9tx7fgyvyM4EhraiqAN3PU1nVg7K00lfYg9AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZVNtsEzjYqGrjxMXJOqqomSJMEarNc0gGrKOKVnOWqdBURPP
	WEkcq3Q09iD8l8S8eJwUkSLIlkFVbX1ZzfY8xwej7Kqc3/uuZYxsOYSJhlWWjeTB1nctcVJrdCP
	4hKGm
X-Gm-Gg: ASbGnctKPHuntxC6W4OAyuCxCcJxI9ZRLxJKtVkpYwita/TqLijDLyuk+nLWhz6GNtq
	iH/XHIHuZrZ7kZ3nBc81JwD5j56GIHiS4QjQTkmu35KVLgCy0Clm29lgzKuI45t71mX2sHHf8Rb
	q6fu8Tx7mWh8Vc0HrcrgxIrSoAE/8v+vJ2Pgc6MjIn0BdSelDyVnU3oDzBpDhw7p2ZsiwC9v8wp
	cCKNvHJVMQoFp6FZPDgkoALb50O6iW53Eo8/gnQ1XCGDxYYXY3kAXhP7tAwOjD6h+20yqQcoTSF
	GiquwKpO+8u9JsmsuTVL3GMQo9xp7bY2MlACI1hf4jsBENnIqsLRH393bbtla+mGjtU5gm92y4G
	Y7JMsBmEstC99VH2hUA==
X-Google-Smtp-Source: AGHT+IH/Kh7/mkL0Tt6+UNLWcBElFJw8/hHxPE2lY1Z918yM1IGVUgyZ114xF7oqCq2jdC0X9PJJgQ==
X-Received: by 2002:a05:6602:4818:b0:875:d675:55f2 with SMTP id ca18e2360f4ac-88168344737mr18187439f.7.1754065910405;
        Fri, 01 Aug 2025 09:31:50 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8814defb6ddsm131712439f.12.2025.08.01.09.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 09:31:49 -0700 (PDT)
Message-ID: <97100307-8297-45b2-8f0b-d3b7ef109805@kernel.dk>
Date: Fri, 1 Aug 2025 10:31:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: "open list:XDP SOCKETS (AF_XDP)" <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: bpf leaking memory
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Current -git (any within the last day or two) leaks memory at boot,
as reported by kmemleak, see below. This is running debian unstable
on aarc64.

unreferenced object 0xffff0000c820d000 (size 64):
  comm "systemd", pid 1, jiffies 4294667980
  hex dump (first 32 bytes):
    01 00 00 00 00 00 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 84021ac):
    kmemleak_alloc+0x3c/0x50
    __kmalloc_node_track_caller_noprof+0x370/0x500
    krealloc_noprof+0x238/0x300
    kvrealloc_noprof+0x44/0x100
    do_check_common+0x2668/0x2d50
    bpf_check+0x2464/0x2ec0
    bpf_prog_load+0x5c8/0xba8
    __sys_bpf+0x9c0/0x20a0
    __arm64_sys_bpf+0x24/0x60
    invoke_syscall.constprop.0+0x44/0x100
    el0_svc_common.constprop.0+0x3c/0xe0
    do_el0_svc+0x20/0x30
    el0_svc+0x30/0xe0
    el0t_64_sync_handler+0x98/0xe0
    el0t_64_sync+0x170/0x178
unreferenced object 0xffff0000c8ccd900 (size 64):
  comm "systemd", pid 1, jiffies 4294667983
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8e80d088):
    kmemleak_alloc+0x3c/0x50
    __kmalloc_node_track_caller_noprof+0x370/0x500
    krealloc_noprof+0x238/0x300
    kvrealloc_noprof+0x44/0x100
    do_check_common+0x2668/0x2d50
    bpf_check+0x2464/0x2ec0
    bpf_prog_load+0x5c8/0xba8
    __sys_bpf+0x9c0/0x20a0
    __arm64_sys_bpf+0x24/0x60
    invoke_syscall.constprop.0+0x44/0x100
    el0_svc_common.constprop.0+0x3c/0xe0
    do_el0_svc+0x20/0x30
    el0_svc+0x30/0xe0
    el0t_64_sync_handler+0x98/0xe0
    el0t_64_sync+0x170/0x178
unreferenced object 0xffff0000c8fc0300 (size 64):
  comm "systemd", pid 1, jiffies 4294668000
  hex dump (first 32 bytes):
    01 00 00 00 29 00 00 20 00 00 00 00 00 00 00 00  ....).. ........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 335bd269):
    kmemleak_alloc+0x3c/0x50
    __kmalloc_node_track_caller_noprof+0x370/0x500
    krealloc_noprof+0x238/0x300
    kvrealloc_noprof+0x44/0x100
    do_check_common+0x2668/0x2d50
    bpf_check+0x2464/0x2ec0
    bpf_prog_load+0x5c8/0xba8
    __sys_bpf+0x9c0/0x20a0
    __arm64_sys_bpf+0x24/0x60
    invoke_syscall.constprop.0+0x44/0x100
    el0_svc_common.constprop.0+0x3c/0xe0
    do_el0_svc+0x20/0x30
    el0_svc+0x30/0xe0
    el0t_64_sync_handler+0x98/0xe0
    el0t_64_sync+0x170/0x178
unreferenced object 0xffff0000c8c84980 (size 64):
  comm "systemd", pid 1, jiffies 4294668003
  hex dump (first 32 bytes):
    01 00 00 00 23 00 00 00 00 00 00 00 00 00 00 00  ....#...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 3cc2e52e):
    kmemleak_alloc+0x3c/0x50
    __kmalloc_node_track_caller_noprof+0x370/0x500
    krealloc_noprof+0x238/0x300
    kvrealloc_noprof+0x44/0x100
    do_check_common+0x2668/0x2d50
    bpf_check+0x2464/0x2ec0
    bpf_prog_load+0x5c8/0xba8
    __sys_bpf+0x9c0/0x20a0
    __arm64_sys_bpf+0x24/0x60
    invoke_syscall.constprop.0+0x44/0x100
    el0_svc_common.constprop.0+0x3c/0xe0
    do_el0_svc+0x20/0x30
    el0_svc+0x30/0xe0
    el0t_64_sync_handler+0x98/0xe0
    el0t_64_sync+0x170/0x178

-- 
Jens Axboe



