Return-Path: <linux-kernel+bounces-894148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07371C495B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9493D3AA251
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C372F999F;
	Mon, 10 Nov 2025 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MKzCW+zR"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511A92F8BF0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808804; cv=none; b=ZCkJla8TRjxS5Sj54F6O3KY/qwp66K8at5u2Wag7LNtWvPfUjkt0yobmHAGWkZdd4WzmKyUL7DsatgIecGixDjRYkRUiplyhxZAHa+zGsibn2pcoKyucYbYdsi0KvmEBdF6duEsFWFu9Vp5db+uykC49S20I8CF4Hcy/0O0VTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808804; c=relaxed/simple;
	bh=p9eImnkzVajZji6ba/40drjhN77svtSkMv7pWURCLRA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=KouCDiv/HUK2RHinZkfsi7V3kLIhk50LUrVaypggGJrr69Uyi+YuYTRKZMqX+9yxOFEL5InjIG7yub6wFeZYBxHbTr5mWwmj1gEiVO6slMy7RuqWo5JZAOfO5kK6Q+iCmh7QnejokzyMkIbqikh0qjCLxFaVIn++q5w3u9sSzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MKzCW+zR; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-43320651e53so29320605ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762808800; x=1763413600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAnchgHMxAbZYlLtY/QgEWE40Wk8QbLD4OHQ8Memgrg=;
        b=MKzCW+zRAkaqkyKyqUI0azF458FNsxnV7Is5TNI4u0FMKTceD55fvRvt+BHflE7Cb/
         cTWLlyAOUVtMh0fxwQMI3sCOQbriZbLVL62dhdicaZv2/41rDHLavTpFb0DAdADoQnw+
         9vOD2o5j8U+1oUaEVNR1VlsyAYlwt60F10opKc3pCnfhr67zmSvVd7Tr9X39JfHQ/Hj9
         Viv7cSHo43eYOjgdgsnvPdFYUQpRU8R5Ten5j117lm93cDfiTExD1F9+nKp/BvjtzwaD
         RTDkdMfSMPU+wMdz2+td8wu0KW4fXGKQjXL91MHCQ1rt0hKLYcVaLi0BI7zHS/9DlxXh
         yacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762808800; x=1763413600;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAnchgHMxAbZYlLtY/QgEWE40Wk8QbLD4OHQ8Memgrg=;
        b=m2+ZRalDLb9Zz5uKVCq4sG5FTIvoDZ8S0iahmD3IvcS2GmkgQp1fp46Mr4XPPG2+3g
         d6UpFRhVBRrwjUXAWimYeVnvc9yWk5Pc0I/9Dkp6e48hHfvpUgyq/mHVLlf/LcHD5OOD
         FkEcGu2yFxzOw6mKXa2dC9W7NdAwnKiinlA6WMe+KwhQsHerMLxsKCzC9J92fR9tJUzX
         yLYNI9deoM4o36Vwj6H22+K9ZTUZRwcZDUY7oz4OqI0zMTpyHZhl/03t0HmBqLsN/vCo
         8cBoKHgGkDPd3dyWZThcIzZwF81Kf2uyWfJEICnrvL2QyCRiW4jDrgPKYgZB7Cd1oS5a
         ZkHg==
X-Forwarded-Encrypted: i=1; AJvYcCXIRUjs8rsty3hEWvKPTvGpkqKE89xGhmkdTKva85o0UuyDSrBlzd/Y3cmo5bn/qv0PU/s0nzDZTC5PkwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfAn2G9FadXViQk5OErYxTbnfV0FJLb0UqjoNAZtavSQ0iM53b
	WwoAmHQwIILc6Lmu682wLE65OEueR7VBN2uctGyDacsdJC60UXtpD4dev52wJS86jeE=
X-Gm-Gg: ASbGncu84AvTFR8qSPJV2Fd58DuAPTBIZT5Wk63jW2CGRImBYz4JRGy0iy1ZpBEiElP
	FzRu1k9WoQBS98F1+36ogcVnq8fpZjW5bEreJQDVEEipeJ1kb/7LWiSmAuq0kz+BUCfoOonL3Yb
	NuIFdlV6GTsjZIXTC7jO0yBAE2DH39e7QOASPMIDLIBJ/Zn0I1x0jdyug2rOqLO0tjLM2Vvhchy
	SFQGq0JnG4y74cFzg4RY4EFss/OQ+MwGduU/snRjVJZzSxDdovHvw2pZ5+1Rz1urTAgC9kw6T1A
	pHauPZE6O62rztVko6oMIv3OZ2IGePIznOu7jNxxnCDnrz/NMwET766piA7g8ogf8TFGEOWMHz8
	+9jlpx9FBBXRPGDBn1k8QKRSB9rU24lJZNSQMrYv9CKCUx2Fq/+o9GPuCJqEbOv4LYTLXZMPQ7U
	zqoPGmTliHQZwx38PnLg==
X-Google-Smtp-Source: AGHT+IE6VCGeW4hCnKDcdc4Jk9D7a1Cpq0cNJpchGvwnc4BuBlnuVqINxxc8VIDdhMLc+uNFs0RpLg==
X-Received: by 2002:a05:6e02:3e8d:b0:433:79e4:7adb with SMTP id e9e14a558f8ab-43379e47d20mr105680505ab.11.1762808800259;
        Mon, 10 Nov 2025 13:06:40 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-433754f1e7dsm28354825ab.11.2025.11.10.13.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 13:06:38 -0800 (PST)
Message-ID: <dc9790ff-70de-470a-b4a1-d85dc5b1cb23@kernel.dk>
Date: Mon, 10 Nov 2025 14:06:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] memory leak in iovec_from_user (2)
From: Jens Axboe <axboe@kernel.dk>
To: syzbot <syzbot+3c93637d7648c24e1fd0@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <69122a59.a70a0220.22f260.00fd.GAE@google.com>
 <bb64cc89-194f-4626-a048-0692239f65dd@kernel.dk>
Content-Language: en-US
In-Reply-To: <bb64cc89-194f-4626-a048-0692239f65dd@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/25 1:37 PM, Jens Axboe wrote:
> On 11/10/25 11:09 AM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    4a0c9b339199 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=12af5342580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3c93637d7648c24e1fd0
>> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16af5342580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13664412580000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/bfd02a09ef4d/disk-4a0c9b33.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/ed9a1334f973/vmlinux-4a0c9b33.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/e503329437ee/bzImage-4a0c9b33.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+3c93637d7648c24e1fd0@syzkaller.appspotmail.com
>>
>> BUG: memory leak
>> unreferenced object 0xffff88812638cc20 (size 32):
>>   comm "syz.0.17", pid 6104, jiffies 4294942640
>>   hex dump (first 32 bytes):
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace (crc 0):
>>     kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>>     slab_post_alloc_hook mm/slub.c:4975 [inline]
>>     slab_alloc_node mm/slub.c:5280 [inline]
>>     __do_kmalloc_node mm/slub.c:5641 [inline]
>>     __kmalloc_noprof+0x3e3/0x6b0 mm/slub.c:5654
>>     kmalloc_noprof include/linux/slab.h:961 [inline]
>>     kmalloc_array_noprof include/linux/slab.h:1003 [inline]
>>     iovec_from_user lib/iov_iter.c:1309 [inline]
>>     iovec_from_user+0x108/0x140 lib/iov_iter.c:1292
>>     __import_iovec+0x71/0x350 lib/iov_iter.c:1363
>>     io_import_vec io_uring/rw.c:99 [inline]
>>     __io_import_rw_buffer+0x1e2/0x260 io_uring/rw.c:120
>>     io_import_rw_buffer io_uring/rw.c:139 [inline]
>>     io_rw_do_import io_uring/rw.c:314 [inline]
>>     io_prep_rw+0xb5/0x120 io_uring/rw.c:326
>>     io_prep_rwv io_uring/rw.c:344 [inline]
>>     io_prep_readv+0x20/0x80 io_uring/rw.c:359
>>     io_init_req io_uring/io_uring.c:2248 [inline]
>>     io_submit_sqe io_uring/io_uring.c:2295 [inline]
>>     io_submit_sqes+0x354/0xe80 io_uring/io_uring.c:2447
>>     __do_sys_io_uring_enter+0x83f/0xcf0 io_uring/io_uring.c:3514
>>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>     do_syscall_64+0xa4/0xfa0 arch/x86/entry/syscall_64.c:94
>>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> This one doesn't make any sense to me. The reproducer given only uses
> a single segment, and hence could never hit the allocation path for
> an iovec, it'd always just use the embedded vec?!

Ah nevermind, I see what this is now. We can still alloc for lower
counts, if we don't have a persistent one already.

-- 
Jens Axboe


