Return-Path: <linux-kernel+bounces-760242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3195AB1E86A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52667B05C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6E6275AE0;
	Fri,  8 Aug 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DgrEjQZF"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1031EA84
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754656446; cv=none; b=tMaaXZD0rDC2aZ5KLrlTYueBtmLbykwHDIDxKqHv6+PCdxhJXbQBZjPaZ+MhLeg8fa5hkbdmCwC7ZXbk6SQhiQco2lkcCDAEOwfRgututQ/Vp5HiJnTfMhR3deuVB/xMMQnbociP6Ep38q0Kh5mUmCnipI9+czODPA0o9KXlA+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754656446; c=relaxed/simple;
	bh=/xkuneluVVx9fAsF8Zj89/WnnbURABxwxYJgT0D9YFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HCOGsfpamLjnsc8wtqHx00E/79MEB9tcZz58fWWAiuWXn+xAHQ4n3aNZwG6OQTbUEAV9r6b87dad/WHQXmDY56pYGSx/SQNYjgE0fydP39rGBzBnhwWffEGjb0xog6B2Nqa2cR0IjUh0q1GzUkt7n1xZ6zYT8VdsffIQf4N6fLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DgrEjQZF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2405c0c431cso19225485ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754656442; x=1755261242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5oY5RPIvCXM/fVkS8LQFDoid0eM/3tQKi7MItp5JPAM=;
        b=DgrEjQZFLIjjJaGz0ljkM6iMAGok0BYRo4QAmOOYPqn4pdfyGAjXMY5OJ9Vf9dJdPa
         8F1aoHx4+30iEaD2Mo7Di9FZQ+pxMNzu77OcsDJK+0+hhgFrxnRiGoEW2TbrqUWf/rPb
         aWSCqMoTa+nYM/+qTWy09jC5qf9MfKgTqxgrGQQLpLPSzuaYx2620QU5RlZIBjaVpRmR
         dlvooXe1lYq08rLf2LMVk1abV0ocWjt2hOAQmB7KMsw9XXhqbHHpd6SsaO8MpEfEN449
         MiXvWxrz5X7HqRzHShX23I1JfBtod9yuzNw/7rwiY6Qherh8h37M5qzOpec58At3aki8
         JXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754656442; x=1755261242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oY5RPIvCXM/fVkS8LQFDoid0eM/3tQKi7MItp5JPAM=;
        b=ErJb9ogChNPQpxLks/lAtgq85wzsqvCTa820apg2RkfGZIft5dQNFNgp140tNjfYkY
         xO6nmoer66w12PIpjfxqJRJSNaPCb5RG/J9rZgbKop9DN5CH39NIAk4Ej038UHdOatdq
         23YCjgxtPRng3B4ePKsYdd6Gj0NMpk8m8Y7qRL9p0mqKQ5VAJKsZG+oXn2m78gozkiL9
         fi0vxxTP5xR8TAgRzgtSWlPdVjBjB3hHYF8AbFvzK5Uqhnqk5PA2ATMjhtCZUGTtMA80
         k/l4Rc1g43kc2cF5zCUmGWHdFPieE4p8iobFG2fIDutCxyNbB9cjn6qniKyELNUujkvu
         MuKw==
X-Forwarded-Encrypted: i=1; AJvYcCWpYgDpSTuLCZ+FDf89aIpziPeUzFz6J/ATJoteBqAcSGR9XXqP29cP0/Yi8TAQG/M72eYSpIITI7hIhOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ+cuzK+Vpea1xBoaKChJgATxJBeeAyV+7vv8rzY6rIhSuPgMh
	+PuPCRgI3T/X1IHzul9wIrEO9mL2r32f15+2qfSHzYRAoYC3hhS8nAzzZTixHAgSmYM=
X-Gm-Gg: ASbGncvXdQ4+H3lldmE+d1PWw+3Xzp4BkqeLO8OtbT6UGiZcbwfdwHx+7n15m6/Ee1j
	ZzglEjnQWKeIW2s9icKgsBhAglH49OZ01ULsquTtRF9+LAWq6QYHip2dQs4DQJCScwwOsOxIdN9
	8LDZAdEylMtwC9zOWKpoegkS9kf60JP3kSh6hJc+Qs19Z1PRDTTZZvRKyrZvXsfNuV0tltkOUYh
	QDsjJKzCxtHVcQBwefvfJUW5T8KDh8H30qcGRSGSgZcdFdx1+98Tffw2YX7BjyplNA7qJsq5BVa
	nDmXlU+vaZQPvYAmqMYrxZtKfyMymPV4zHX/IvSY0sEYw13aZrsVU6lIGaD9i4P6Q9U/3seofs+
	95xJFV/MB4rBgkCo3bE7/gHYKoFZWLSQ=
X-Google-Smtp-Source: AGHT+IGpiB4zOK6SXLQl2escTn7fOCLfI55rRpKX8NF0N0y4n0sgdGMyGxmyXX8twpyiEEUJ/ANfhQ==
X-Received: by 2002:a17:902:ec82:b0:240:8f4:b36e with SMTP id d9443c01a7336-242c2219e8emr45402115ad.34.1754656442435;
        Fri, 08 Aug 2025 05:34:02 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7b2700sm17859310a12.15.2025.08.08.05.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 05:34:01 -0700 (PDT)
Message-ID: <af7cf1fe-3019-40f2-9650-d3e82c6c5294@kernel.dk>
Date: Fri, 8 Aug 2025 06:34:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] WARNING in __vmap_pages_range_noflush
To: syzbot <syzbot+23727438116feb13df15@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6895b298.050a0220.7f033.0059.GAE@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6895b298.050a0220.7f033.0059.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/25 2:17 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6e64f4580381 Merge tag 'input-for-v6.17-rc0' of git://git...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=166ceea2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5549e3e577d8650d
> dashboard link: https://syzkaller.appspot.com/bug?extid=23727438116feb13df15
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10202ea2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140a9042580000

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git> 

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

