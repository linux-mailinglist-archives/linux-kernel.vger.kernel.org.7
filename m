Return-Path: <linux-kernel+bounces-760243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCE9B1E86B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6D47B07FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFECF279335;
	Fri,  8 Aug 2025 12:34:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA881DFF7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656447; cv=none; b=JOo2lyDzuciA54CkLPLgwxGF6QyzLKXsMUoucm31t7myh+LvNSPateSCziINMIKQBPOLhSXDNo80IN028nb6wL2fbAzT8f/uvyqAYnHuaVggOhs4cwRSgNVeOCMTRaVE3GDUUuW1eSk43SpfJstps94wRcZ1qaHGLC6WcRHNtao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656447; c=relaxed/simple;
	bh=xGj2r9yQ1Wt1TFQZQve671G0WdSK9M1huBggd4W4EdM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=JegOn8VYJNrt/MjJbTXCBt/BzS36tHOIuTl1xvVeL8NsMLevzTKzUB1lGJM8df/HV94mzJsaFd1CyD6Ui5tZkukHzheYvRTYwGtAXeFI/eNxq9c/Uu+hyRBTfHmgCiVhaVmrqGpmatk6jvZmSk5TI1uhjPZZThWHoashkq8/WrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8817ecc1b33so451681339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754656445; x=1755261245;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L303936goaW8DRBeh1Tb7JruAw41qWahy4Yr8OwMpP0=;
        b=JZmdRm7jqdkO9CTeK4eHewpfwyBRHU6W3NjEi2bgmvbUeFsHCj5o2UdbEsLeCb3v8d
         /jxEdkMGS24FEDg7JLmsGLwdX8eLffLnl1ASXVCz6vYJrDHAy946kJ31KraswZe3moZv
         yv5oYEmTN3goZt7s3suafBouuRshotjIRaU9scyqM4PMM1w2cEp6UevPTd9ZmWN6ltq+
         0zwZ2O0P+05Df2013deWGKQw3sRAag1d/nEu7WVYFG/t58amlgJfO6XYCop20qCrxE5T
         euTCD5uQ9b6cvIyAZ/tmAydrEiWWho1rouDc7F0frAjImX7cP5Dl3yFMXyy3c5b5KUlz
         ji1g==
X-Forwarded-Encrypted: i=1; AJvYcCXI3pET+zYj53pUgIKevwQOntfU+Fw8TnU91wRDQxM2ZYjJCADIPzMBR0nS6/YjYBY4NyiUs7RJo1LPoaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISp/BBKFYY/ca5lHGrkodSAoKO0Ta3hL4vhg200llCo9THxEw
	UkP7nNX3xb4YHVFXs79j5+zZilja9CgGg9qoEirz5QNNOFMOWAOTmnVCu4tP3BslgBaFB47JE1v
	cnJwGNAC+4rK3PcNBh2BG9PDfZC8CzIr/Jv8ovMLweAIr5Hl7uckkCHYBtks=
X-Google-Smtp-Source: AGHT+IGZwq70OCelaUCm+iF1G+3p85RF3a+RFQWMGMHQznr+vFTf3cT2gyZAAw7PR4k0BFLHgihAA/KtR62JrneyLO6PYFDfMlS/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1687:b0:3e3:cc3b:4c67 with SMTP id
 e9e14a558f8ab-3e5330b656emr50445175ab.8.1754656444643; Fri, 08 Aug 2025
 05:34:04 -0700 (PDT)
Date: Fri, 08 Aug 2025 05:34:04 -0700
In-Reply-To: <af7cf1fe-3019-40f2-9650-d3e82c6c5294@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6895eebc.050a0220.7f033.0061.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] WARNING in __vmap_pages_range_noflush
From: syzbot <syzbot+23727438116feb13df15@syzkaller.appspotmail.com>
To: axboe@kernel.dk
Cc: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On 8/8/25 2:17 AM, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    6e64f4580381 Merge tag 'input-for-v6.17-rc0' of git://git...
>> git tree:       upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=166ceea2580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=5549e3e577d8650d
>> dashboard link: https://syzkaller.appspot.com/bug?extid=23727438116feb13df15
>> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10202ea2580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140a9042580000
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git> 

want either no args or 2 args (repo, branch), got 5

>
> diff --git a/io_uring/memmap.c b/io_uring/memmap.c
> index 725dc0bec24c..2e99dffddfc5 100644
> --- a/io_uring/memmap.c
> +++ b/io_uring/memmap.c
> @@ -156,7 +156,7 @@ static int io_region_allocate_pages(struct io_ring_ctx *ctx,
>  				    unsigned long mmap_offset)
>  {
>  	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN;
> -	unsigned long size = mr->nr_pages << PAGE_SHIFT;
> +	size_t size = (size_t) mr->nr_pages << PAGE_SHIFT;
>  	unsigned long nr_allocated;
>  	struct page **pages;
>  	void *p;
>
> -- 
> Jens Axboe

