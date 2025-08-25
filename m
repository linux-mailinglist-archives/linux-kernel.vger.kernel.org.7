Return-Path: <linux-kernel+bounces-785538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9A9B34C91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AEB71B235A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6DF275AFC;
	Mon, 25 Aug 2025 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jZH9/6ae"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A542877D9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154906; cv=none; b=hAbnsLpWKxFIsswBVjSY3JhPTP9KMa8TSzK22hG8QpBygU1q3Xu4hkYttrZ6POABRpuwXRT+HO+Dfb+68z5ItEdmNRIlWlofTvvWRBT84ztS3z3pgv16dfyokKje1JBHK15tGQK8PWMxDqWHYg6H/UUEar01QLoc4k8uH3FrWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154906; c=relaxed/simple;
	bh=ws0OH/LPbfD0uWhZ3//ck7/pwntfVUXedOFJRthyTE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R8/uYQK6OJuLJDJUzyTGmO8kXoFtMQfMERb+W7NzHY2GWalHTzQZ2+GthTgpvZZ8pQMzQ1sJ3kqP8GqKAj+k+DTTFFH1KeV0FnpgvxYutkPZF03+zHrgR2rX3nqNste21AqwyZ+/TiX5yiD2li9Nn4GP6yPDOplUgU8RP8QlV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jZH9/6ae; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ea25a7fff0so8642955ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756154903; x=1756759703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/dnllQLN8cDpaKVqJzQZtSLrZ7j3LLHfYLifC1ogCM=;
        b=jZH9/6aeiq6scjXh74JMeDRknBu0YK1nVmdvthVMAlC1uKD6/6YiXbcN0d9uOFhQ8y
         n5VOI0KFRdom7vcCh2mFTkp2sEjBeLtvrpwmjhGTwmMURUIf+hINw3wtrwFg0VAZvVFJ
         DnogJpcDUJSSM4JQ5eeutJ85KJnu2jhLgUnKiMuACh3rtdaPxU6Hb5AmPv7aHB4l8mNu
         IvEzWzVGgskyavxiDt7E+Sqw275JD1aC7EtvEnGuIrA5LEDxWYauZo36SBhv+aKCCKmh
         qp7eK8YXq5krcHBKgokh3yv5r2zCwcezlUnx5OFFgipygHxemWQ6ZEwnTtwt5qxHNkMl
         BZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154903; x=1756759703;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/dnllQLN8cDpaKVqJzQZtSLrZ7j3LLHfYLifC1ogCM=;
        b=LFZib8luzQg8kZSv0tK2LybbHpOw1DMfiTmx+aals2zWXYkRpdC90kxp8C/GJ4Y7Ld
         Wiy8o5QJIBLxcl9lt+HvHzVaAbVUI5EZ2LRx/jKBcoyIgaGpqMmG96clegMgxPmRwaVB
         6AyoTTr5b5eFOWGQ9svPYDl2jBpfope46VNPzM67MDwqrRYAVLPa4o4ZgjSI0xEJbuxa
         AA9sP/GyoOKJIp5DK0HfXPffUzk+DhaiEk89hH5hlmeAsGh7BKn+/GUSfNqk6IDIi7L8
         rRg9B6WOjkHrFA6ZhlCa6LJEBi59LsSmRs5A0orgLgzr2GEXZKqQXrkOvokjFjflbnmp
         zeMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXl4b5a2YUvdrPE7pljPtgYdCQrVQYaPAOwzOONFD93GvcfqNQs1L4JWOZRdOYhKoyhP8T/EP81p1i3E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIRdJGAP3g/5av3sUnGlBoetYq61aR40UZqTGPfD80Lcxb8UQ
	YopJ5Qv94mq7/PsAZxkUqHax402eQTta1JkBePyW9Yma9w3RqhN3H2sEfI1qLKieUSo=
X-Gm-Gg: ASbGncvUeR3pqqcY6aidg7SwjzmsXsImsq+k2jVGThvH7tN+M4nMm8RGdZa0+T/tMtY
	OEBJ2RHEzl2jEA90dHX2Z2rfmSJf+tKcH+REPuuUqxPKkX1vYWklkyfoCU4ttwOfQw0x8ylcZId
	FtkONYLNH6w0LoY9Qb1POXoUyf8kUdUiaIdOT/gr8kOr1aRyRQ5D++q2/lCbU9tVF59oWBPXRTS
	MvJrxa1ZNH2Cd2U+aLwuxqqFajN1zUVoa9Ln4MrO/QoQdqHWv6hhGhoUN6D8w0QcXefVekz4i8E
	EmAApc2YJ+wkYkISkcsRBY3fwV3BP5Ze3MR4U8yQgcN5ZNcMdZBtsJwuSIAVkEimyM//vcq9EIc
	JGbEpMIYQPCFIOA==
X-Google-Smtp-Source: AGHT+IGz/OLusjKqnvYuytsepj0QasUaFhQNGeebbI4cWxx4cpCIdsaTdG9b8SEzhdQW1utDLqTgxw==
X-Received: by 2002:a05:6e02:1582:b0:3eb:cca5:5586 with SMTP id e9e14a558f8ab-3ebcca5874cmr83676445ab.17.1756154902655;
        Mon, 25 Aug 2025 13:48:22 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4effe70csm53084775ab.51.2025.08.25.13.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:48:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Thomas Fourier <fourier.thomas@gmail.com>, linux-alpha@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-block@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Ian Molton <spyro@f2s.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Denis Efremov <efremov@linux.com>, 
 Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20250825163545.39303-1-andriy.shevchenko@linux.intel.com>
References: <20250825163545.39303-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] floppy: A couple of cleanups
Message-Id: <175615490112.25116.3742797696959119744.b4-ty@kernel.dk>
Date: Mon, 25 Aug 2025 14:48:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 25 Aug 2025 18:32:54 +0200, Andy Shevchenko wrote:
> There are a few places in architecture code for the floppy driver
> that may be cleaned up. Do it so.
> 
> Assumed to route via Andrew Morton's tree as floppy is basically orphaned.
> 
> Changelog v2:
> - combined separate patches sent earlier into a series
> - added tags (Helge, Geert)
> - fixed typo in the commit message (Geert)
> 
> [...]

Applied, thanks!

[1/3] floppy: Remove unused CROSS_64KB() macro from arch/ code
      commit: d74968780bf287958e2815be5f088dd6c7b7aa19
[2/3] floppy: Replace custom SZ_64K constant
      commit: 8e7ee0f6fa33934373c1c37e8cfb71cff2acea09
[3/3] floppy: Sort headers alphabetically
      commit: d4399e6eb27a803b73d17fe984448a823b4d3a30

Best regards,
-- 
Jens Axboe




