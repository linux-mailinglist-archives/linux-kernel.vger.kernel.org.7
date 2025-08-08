Return-Path: <linux-kernel+bounces-760250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BA1B1E87B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15C03B6E82
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF59278E7B;
	Fri,  8 Aug 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OIERPGqt"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE891DFF7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656684; cv=none; b=qQ+ZW4RFZ9Y5pmannah8qzo7ooUviXEwM8Sy5Wu7g6tJJstVnALz4R+Khpg/Jzh329c6UX1KkacQuxNeZh+3KhHD4PpSsLBxYpXdYUFpo9nqjR6lGlRc0pzM1LW/ghWrTvsVSieYwr6D+iTtonVVfFsCWrOlrgnLJk1N8kVQUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656684; c=relaxed/simple;
	bh=npalT/8QO6lw78o58J3uBApiPSfitDFzKf7CTMqMokQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4JRJQB0vS8wfm8647Hu7q2vmcCX+r/pIr8/uZYRsLFL3VxbvXa25GKdtI1G4vM6Mwv339oWj+ZcDsN/0OV21TIykIJ1b1QcCcJxDwGgLX9AWzVeOypsx8/74B3+AMSvj4rQPC+UxOVuytXaI3509WNmWa4Zhbs+iAqtpbRmPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OIERPGqt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2402bbb4bf3so24938765ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754656682; x=1755261482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nYv65QLcd8UEW5OR9mcPXDLjPJAlMx7YfY+s3XfWB8=;
        b=OIERPGqtaFnaJwMO+uiLgFHWVY/wnJKn56ewf/rbKol0vT2fbu8Ja4lW8ATfFIwapg
         mXoVE20liGVynYxvNRfuGlWHouGmBdf4BlmWxD7DQxqAyTXRotBykXrMcj+p9N/SvzUA
         C3kBYpx2HcjwOvEboTF3rOHjmrQI2iZ68AWOayTJQU+fbo0sGjfrG+t9eGYOBvsvYQ3V
         9H97DvqIhdaLqIHQ/RTNovCb4UhPWU97iQBAqUbcA8EhMmwb8ycXwtNZ+MfiqzYUobaa
         CwsA+xbPuNRGfqp0DIgJ4tafh90hHK1q7PUNnoIX7wu1iFaI4MKm+EMo9U0xTRNR7pdL
         QuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754656682; x=1755261482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nYv65QLcd8UEW5OR9mcPXDLjPJAlMx7YfY+s3XfWB8=;
        b=J29p/egPDc67PphrdAh1lR/O8Y8ukJuiMbmUSp8KqlYSsQbphpxqVpPv4JBh2Ak8g/
         O/GiTp7b+befU0//J4ZRum/cb00LmdEwYmo9abO4DzX4OOGHs0dOsmnUJN3Z8RfkoK9R
         YOoXMJTmmj7tIM8ZdkGp6rKIuxu9iYiFuZj9s4ayOURjQRumJK3HFynZ1f1QX73LeSls
         QHHj728pqNABsSndhUFUNPuxoFugADEYcSp/426dHqBkHU0SLlBqCVKMG4xim+ybfykY
         8ifiELNfqF2CFJD5j8r+8U7x8vbIuJfWKh3vRyUqiXustTS2jycUGJWYZ5LyT4BX1tm/
         aoCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTpvE3bZ6SLa8NJyNBQRpA2DzxbeJmrxrzuugMB81oe9AIccIZBW8lhzuNu+bnV1dwBbCGkSAVjwFSop4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjScSVZNEIVjTfVjKmBbFi9XfOgqK4Yb8xEksAP0RtQLs5vvOU
	O8Lbdr2rEyEpgPPzZD2GbRfJiqr5B/2qUgH5QaOvEHqRaMmzTXhyBVOCnctvFpYKmcc=
X-Gm-Gg: ASbGncsnNa29398XjF5xyhcR8hh/szsxGiBAvAoSVl/a+oNvMYMnFvNZd04VRou3W5Q
	aHbgMdW7ae47Zc+KFagxGvYTBlWZvLGJ/SqYMre2XdxpjJA+iuB5rCAx1/15QX6vK6N/lP5WDPq
	Lf7evMPkVCpHHl4eIQwutAFDPosS1wa5t9sB1FVQQA/8AH2s/+60gL4awKcEgDdAqyvh8WzzbvF
	vMY+iRx7O2635DX0ZBe18hYpKd2bREoX0zumDTbgVuAKupnu09PrX1Y16jRBkhY9Rkkux2M0i//
	rwU2gORfxEQc7PwrS0byaBJo5UlQ9/sKAVHKH8SnFa6YH26+1P+mfru+qDDt8+bgfbGBESExxeH
	NjBVoC21r8xyBAHwvKSRv
X-Google-Smtp-Source: AGHT+IFe3L6GdF8vbl9AdxCmgfV+mpm1iGs/ucyZNOfOA8Sh66cHUp/+TjdrbyUid8dxHNkBZLN/jw==
X-Received: by 2002:a17:902:d481:b0:223:619e:71da with SMTP id d9443c01a7336-242c225767emr50293615ad.49.1754656681999;
        Fri, 08 Aug 2025 05:38:01 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0fb3csm207239045ad.61.2025.08.08.05.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 05:38:01 -0700 (PDT)
Message-ID: <c04ad55a-7c66-4e30-bc22-e05682eeb10e@kernel.dk>
Date: Fri, 8 Aug 2025 06:38:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] WARNING in __vmap_pages_range_noflush
To: syzbot <syzbot+23727438116feb13df15@syzkaller.appspotmail.com>
Cc: asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6895eebc.050a0220.7f033.0061.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6895eebc.050a0220.7f033.0061.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/25 6:34 AM, syzbot wrote:
>> On 8/8/25 2:17 AM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    6e64f4580381 Merge tag 'input-for-v6.17-rc0' of git://git...
>>> git tree:       upstream
>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=166ceea2580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=5549e3e577d8650d
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=23727438116feb13df15
>>> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10202ea2580000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140a9042580000
>>
>> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git> 
> 
> want either no args or 2 args (repo, branch), got 5

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git


diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index 725dc0bec24c..2e99dffddfc5 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -156,7 +156,7 @@ static int io_region_allocate_pages(struct io_ring_ctx *ctx,
 				    unsigned long mmap_offset)
 {
 	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN;
-	unsigned long size = mr->nr_pages << PAGE_SHIFT;
+	size_t size = (size_t) mr->nr_pages << PAGE_SHIFT;
 	unsigned long nr_allocated;
 	struct page **pages;
 	void *p;

-- 
Jens Axboe

