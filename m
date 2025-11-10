Return-Path: <linux-kernel+bounces-894091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B77B3C49431
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2090B4E80C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860652F0C6C;
	Mon, 10 Nov 2025 20:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VRORgA2S"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A952EF654
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762807032; cv=none; b=dO7bFZ8lF9wTf6dlfbieaOu8j4ayhhGieKhFastKQTzNXe5pZU7TomnukN26pSlZ8Y+iTH1lyWxEYKROYFXCHdMQU84h4/1KSRo62+tEvkVe5lN1WCUZUZMpA7hRyGYMy5aBVwV0cF10qXPJBaYTFFclR2MbcCu21CBDurPV3Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762807032; c=relaxed/simple;
	bh=3QRzL6KiVufSbSlXjca3DhGEofbmZoco/KcHN4Hlibw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bDp04BgKclwKE8tfiRxO0jmzgEsjrLhomgT9RoFULYHajNJ3hzFC/XxvmuUQh3ObbJC6CpFwaM1jqAgI25mzcCcRdqWXbPAxr0Nxd3f+3ROyZAP9QpEy6N/gBVvoRfQ5JzaSghZ0nutdITgGD5r++ljGOFQsh+3Ddb5K5+roC+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VRORgA2S; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-43323851d03so13457935ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762807029; x=1763411829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7JWVgDY7ZOp5yY1nE+ehHytyqrFQTQY2al6sgpKXpc=;
        b=VRORgA2SUSWzWbL+k8jK2zxAzLSSw3xwE8Tzh6HDEGl+fHmi/rVDul1plC4/fWvm2P
         0tvjiRe5Y2Gq6VLgK3xIKGVGGYCibwVQ4/UuLu0o21Dk8f1XHtJI1Wxe+f+EhNUtviG8
         fd4UsJbNH7LCVCZSBJcR3cFtcVS5Kjc2NPWE+0hXTdgx2t2i/HeELR8Cp6pw0UONKo8G
         24bjxZZFabrLul2UWh/IgxU0d72mhwqZQizm4LwQzMaq9qD8AXzSV6OqfiHOMvPZacop
         VMpY21Q9a24+NhkZZNLqUmW/cO3vjtDQtYC8CRT6YMRFpek+bFJjMH1U3HlnzgKg8DRH
         vaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762807029; x=1763411829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7JWVgDY7ZOp5yY1nE+ehHytyqrFQTQY2al6sgpKXpc=;
        b=J5Xi7LmuSG53BQwjA90bnBwayqLGeU1VAAlGYeOor1JCmPrtUdShc76mLHJTeZce+k
         6ySLQdo0twCxRqRLaZpLPdC3zWqhHPtRhYxjAV5X4zJMnKxaQ1hq4HN2S4MQyvbodT96
         3bBpjliESsCZR0kyTouEoh1cg66iXIDzyMOzDQhf9JqZNukKLXu8xp0XdDjwk2yWCWSp
         NjA14lLKsJpw605SH9RLSP5oKbZQ3uyLV5RkPchRTYt9IhEk7tSOf3L+oNGO+4551G8K
         BZbzL9MU5JTxdjxgRuP5ifCrdXQZTgvyMTHbEokp+G6Y6ZFonSMYxAkxAlbDdYyUbCwt
         4faA==
X-Forwarded-Encrypted: i=1; AJvYcCUnFYPI9GRx1//i4pu6VgG/KTsZ7akudV0MEdbTnARZ1C/kHark2PV9rVYS+5jWhzZc+t8jHRKCJ6KPjLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj65JoJAeY1H/OKJZDcIdHE1I7N3jA3Uix2/g0wses7p6DS2HK
	+vs9HYJMTrWTJZrDeNCvzsd17OUQHJAvNDCeXDSVaCN/7G7ZJ0ZKWjKgoJeXZA0fp04eZPSHv6v
	ZGf16
X-Gm-Gg: ASbGnct2Q9pu4VOkRNRPvjwVSHy0sSmUxjZeSu69HWeyaEG/nGJsAuOInCSZm7kUfbt
	t5QqSTmhQGjTdAXHFcMvUAEHfuYZGpoprYdbgh+SP/9fwDk1v5GjEK2smj2g57VLOTqYslzOqvW
	keL2dty5pFdZZtz446LN+6yfh2pGqnDVLKprAyCG5XgNdKIgfpNIx6IAq+KlYQpK2CWZlE0VBV3
	/27+SvKngghiCiFfZmem0u6ljGKEaGaS8pmxfzij46fiQNlXtftRSbDXrdoaIPSYWWGBIbgJxXR
	KVj0RAGTJZ9l4c7nUPk+2PS/Mzhx+AImTCr++o0oW88ev7a1w6pxw7xPLO/NkqAhkz1+LM7NEss
	zlGxvjC5vrHDRUwKMc8vWZo2OWvUGlp8N2slk0pyY8eJ+4L4zs0htj8hoxYlrK5X02/odKKbBvc
	hF3xCN0j4=
X-Google-Smtp-Source: AGHT+IHb7gCQ9TEEs+ynvDaT6nNTImVkj2v/QbrKYdL6dahq+P6/ageh0RV5Q2qbponGv+x9wHYXgA==
X-Received: by 2002:a05:6e02:17ca:b0:433:5a9d:dac6 with SMTP id e9e14a558f8ab-43367e7166fmr139020985ab.27.1762807028949;
        Mon, 10 Nov 2025 12:37:08 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b746806d41sm5409820173.20.2025.11.10.12.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 12:37:08 -0800 (PST)
Message-ID: <bb64cc89-194f-4626-a048-0692239f65dd@kernel.dk>
Date: Mon, 10 Nov 2025 13:37:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] memory leak in iovec_from_user (2)
To: syzbot <syzbot+3c93637d7648c24e1fd0@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <69122a59.a70a0220.22f260.00fd.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <69122a59.a70a0220.22f260.00fd.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/25 11:09 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4a0c9b339199 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12af5342580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
> dashboard link: https://syzkaller.appspot.com/bug?extid=3c93637d7648c24e1fd0
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16af5342580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13664412580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/bfd02a09ef4d/disk-4a0c9b33.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ed9a1334f973/vmlinux-4a0c9b33.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e503329437ee/bzImage-4a0c9b33.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3c93637d7648c24e1fd0@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff88812638cc20 (size 32):
>   comm "syz.0.17", pid 6104, jiffies 4294942640
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 0):
>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>     slab_post_alloc_hook mm/slub.c:4975 [inline]
>     slab_alloc_node mm/slub.c:5280 [inline]
>     __do_kmalloc_node mm/slub.c:5641 [inline]
>     __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
>     kmalloc_noprof include/linux/slab.h:961 [inline]
>     kmalloc_array_noprof include/linux/slab.h:1003 [inline]
>     iovec_from_user lib/iov_iter.c:1309 [inline]
>     iovec_from_user+0x108/0x140 lib/iov_iter.c:1292
>     __import_iovec+0x71/0x350 lib/iov_iter.c:1363
>     io_import_vec io_uring/rw.c:99 [inline]
>     __io_import_rw_buffer+0x1e2/0x260 io_uring/rw.c:120
>     io_import_rw_buffer io_uring/rw.c:139 [inline]
>     io_rw_do_import io_uring/rw.c:314 [inline]
>     io_prep_rw+0xb5/0x120 io_uring/rw.c:326
>     io_prep_rwv io_uring/rw.c:344 [inline]
>     io_prep_readv+0x20/0x80 io_uring/rw.c:359
>     io_init_req io_uring/io_uring.c:2248 [inline]
>     io_submit_sqe io_uring/io_uring.c:2295 [inline]
>     io_submit_sqes+0x354/0xe80 io_uring/io_uring.c:2447
>     __do_sys_io_uring_enter+0x83f/0xcf0 io_uring/io_uring.c:3514
>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>     do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f

This one doesn't make any sense to me. The reproducer given only uses
a single segment, and hence could never hit the allocation path for
an iovec, it'd always just use the embedded vec?!

-- 
Jens Axboe


