Return-Path: <linux-kernel+bounces-888085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9BDC39CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638E3188F2F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D2230BF58;
	Thu,  6 Nov 2025 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYxF1QJ5"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A530BB87
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421199; cv=none; b=c2yp6BjOtz8n/qXMZB64sl51pGsbiua5P4iwtyMhaF+IhOowrwIfvRl2s3CK+QuwmDNyXkGxqwWpFFm6dGidmWWi79g52CHl0ZGcvBa8NT3HNG5kURi5jQ2FHCDi1NZNJbz8LMyIZf6mZAyX6PpN4Uok9EzxMYo9MJjBJeTkEvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421199; c=relaxed/simple;
	bh=oV/uCyiXDIYRvsKWqGRc79hCinj9TaE2L+uKP4rIeuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y7eUkddhU7sklMTR04s8smDggXt6eLhE68Q/dpd5x7nuWqiSAZ2VK0EIdckzz5O8mKzsqxH4WGj4mIz59hskfUhrUsGK/u5DYqB1k0k2Dlab2kpVeeU+KqYg013n5iAYoGjMKSYkuWyD7DnY11nAluuPOAj0u0fiSS5MMCTnSL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYxF1QJ5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso480305f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762421196; x=1763025996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTfnmqLLBQUziLnW7toPvhEtgFkPURAm/YXUL7zo4/U=;
        b=GYxF1QJ5vGNGgsmLyJI8qaMYqXg2p/YSP7RC1KxxS5BpKq5jQ/JkYavoXImDJ5Tio8
         mK3z6KcRMs5kO0OwfkDocL2YRKIjnroRKrA1ueyFuEzr6zmRmny7UriYeStehkGsq6dS
         SSjC9sM8zvWAY9AUU/L/ufS8RK7LD39/41NbXwj8/7RFSWXlc3MWGndfcCZr2G3nrkBI
         L42qCKcYQFcg3FPbaN73qGNHphpNQf0Uo1bH1XAMfrP4vz/PJJ8zdLDqwZ3XM0s9FMDm
         xW7g1jOzV+xBsP4ZRniogZS7/X9SxMFAVZnQo2nyK+XdYCXHzAkVw1vHJxgQtb8rzQIQ
         yHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762421196; x=1763025996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTfnmqLLBQUziLnW7toPvhEtgFkPURAm/YXUL7zo4/U=;
        b=HHPw4gstzcgpLH3O+4BA76f7gv3DF+CIM/0blSg9QFUTAarywc6npJaZO7DWMmOt32
         1B0a5Xp+yfaHHaB12yMb5dfuVwr24cflWtoI28ACO6ra0nvX9XGpMZzt+mZC72YaE5/s
         hIyIN/S3p6a4a9PTCD/J54V4OXPD48pn1TKdhdIMCzlkLuz51ajaB94+c6tn/WpadP/3
         w5uBY7GCyKlNmc8c8LRYcDUfUaAx1j7qhT2u71Vv55oMzT93OMVCr98futNVVyTS5894
         ++eNOpQ+1tN06arcPhfWdanZIzivY1zfrim5FyEB8J5mOZc9c0gbThwyZNone1WK9MSL
         V4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKXpJCVj0vyu3GHNLkAcAZmRXcDz6Vu1s/lSntmQ1p7wRv49dohvUHCcqbX8Vwo/RoRY73c0X7TbtTu1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/SWhiM32szyGwy4tZFT/obtP2lMQlSvnGCcCae9xkFG4hwtD7
	6BfiHljONQP3nhVlG0lCE12JirGEVLM7rXRgRJ/eJ0ZUexyqeAphshS+
X-Gm-Gg: ASbGncv8CKc3hq+B+2K44kISKRup7p2yO+1C3+PW4XI/mRwUYtxOSIJXxmLINo+Snxh
	OxABYDrTgdWNVXT3rRWOgneqmH7VXcJ8b86K9mADzGjnTRRX1VQkUc180Ik6x9znEJgPLgvYdPd
	SA8T7+N2pVNS4H//aZjzx655b5YAO1IQZYaLH9hu88UNkvNwu1eK5B4Y71DJnXsC7uDJvF77Nbn
	sbiDO5/VRX6Sfm1/lNbuMXE8jB+svQso0Hk96ZK9xzXAfA5bYjfn6+QRn7Ogn2o4qnnUIei2km0
	FaEOnnhA407s4Xx9G9C1RUpboBC3n2BRvS06WF6i8SaALsTVjHknElYSSC10SQyxnJZxACi0aCb
	UNNCyqMA8yNMPMS7vwBmp5oXUzeCkxBOyEblx/hC0wqGpLo7bznLjZxv6hl7yW9vpPKMJGfIC4C
	eKzxVEJki/tT/wcPEZEHNHtEDJyZSmN1haOaf/Y80Jp2M64r6IhBCi3vtyGaRKWD4=
X-Google-Smtp-Source: AGHT+IGMaUiW5fqqkcqSBikEJW/07NdGg3Zf+azE3ISNavq333YcI2a1vkCo/QHX/eah9LaYZSQezw==
X-Received: by 2002:a05:6000:644:b0:3ea:6680:8fb9 with SMTP id ffacd0b85a97d-429eb13bb36mr1990785f8f.3.1762421195472;
        Thu, 06 Nov 2025 01:26:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4037c7sm3741652f8f.3.2025.11.06.01.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 01:26:35 -0800 (PST)
Date: Thu, 6 Nov 2025 09:26:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 u.kleine-koenig@baylibre.com, Nicolas Pitre <npitre@baylibre.com>, Oleg
 Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Biju Das
 <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Thomas
 Gleixner <tglx@linutronix.de>, Li RongQing <lirongqing@baidu.com>,
 Khazhismel Kumykov <khazhy@chromium.org>, Jens Axboe <axboe@kernel.dk>,
 x86@kernel.org
Subject: Re: [PATCH v5 next 7/9] lib: mul_u64_u64_div_u64() optimise
 multiply on 32bit x86
Message-ID: <20251106092633.6058001e@pumpkin>
In-Reply-To: <DE009601-0605-4A6E-99B3-E8A789F85BF6@zytor.com>
References: <20251105201035.64043-1-david.laight.linux@gmail.com>
	<20251105201035.64043-8-david.laight.linux@gmail.com>
	<DE009601-0605-4A6E-99B3-E8A789F85BF6@zytor.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Nov 2025 15:45:29 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On November 5, 2025 12:10:33 PM PST, David Laight <david.laight.linux@gmail.com> wrote:
> >gcc generates horrid code for both ((u64)u32_a * u32_b) and (u64_a + u32_b).
> >As well as the extra instructions it can generate a lot of spills to stack
> >(including spills of constant zeros and even multiplies by constant zero).
> >
> >mul_u32_u32() already exists to optimise the multiply.
> >Add a similar add_u64_32() for the addition.
> >Disable both for clang - it generates better code without them.
> >
> >Move the 64x64 => 128 multiply into a static inline helper function
> >for code clarity.
> >No need for the a/b_hi/lo variables, the implicit casts on the function
> >calls do the work for us.
> >Should have minimal effect on the generated code.
> >
> >Use mul_u32_u32() and add_u64_u32() in the 64x64 => 128 multiply
> >in mul_u64_add_u64_div_u64().
> >
> >Signed-off-by: David Laight <david.laight.linux@gmail.com>
> >Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
> >---
> >
> >Changes for v4:
> >- merge in patch 8.
> >- Add comments about gcc being 'broken' for mixed 32/64 bit maths.
> >  clang doesn't have the same issues.
> >- Use a #define for define mul_add() to avoid 'defined but not used'
> >  errors.
> >
> > arch/x86/include/asm/div64.h | 19 +++++++++++++++++
> > include/linux/math64.h       | 11 ++++++++++
> > lib/math/div64.c             | 40 +++++++++++++++++++++++-------------
> > 3 files changed, 56 insertions(+), 14 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
> >index 6d8a3de3f43a..30fd06ede751 100644
> >--- a/arch/x86/include/asm/div64.h
> >+++ b/arch/x86/include/asm/div64.h
> >@@ -60,6 +60,12 @@ static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
> > }
> > #define div_u64_rem	div_u64_rem
> > 
> >+/*
> >+ * gcc tends to zero extend 32bit values and do full 64bit maths.
> >+ * Define asm functions that avoid this.
> >+ * (clang generates better code for the C versions.)
> >+ */
> >+#ifndef __clang__
> > static inline u64 mul_u32_u32(u32 a, u32 b)
> > {
> > 	u32 high, low;
> >@@ -71,6 +77,19 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
> > }
> > #define mul_u32_u32 mul_u32_u32
> > 
> >+static inline u64 add_u64_u32(u64 a, u32 b)
> >+{
> >+	u32 high = a >> 32, low = a;
> >+
> >+	asm ("addl %[b], %[low]; adcl $0, %[high]"
> >+		: [low] "+r" (low), [high] "+r" (high)
> >+		: [b] "rm" (b) );
> >+
> >+	return low | (u64)high << 32;
> >+}
> >+#define add_u64_u32 add_u64_u32
> >+#endif
...
> 
> By the way have you filed gcc bug reports for this?

As in the need for the asm() above?
No...
I doubt one was filed when the mul version was added either.
ISTR that some very recent gcc versions were a bit better, but it depends
on minor code changes and compiler options.

I suspect that internally gcc sometimes keeps a 64bit value as two 32bit
ones, but at other times it is assigned to a 64bit internal register.
If the latter happens it always promotes a 32bit value to 64 bits and
assigns to another 64bit register.
At that point it won't split the 64bit registers - so a lot of spills to
stack happen when it tries to assign real registers.
So breath on an 'A' (dx:ax) constraint and the generated code is horrid.

Even the lo | (u64)hi << 32 can generate 'or' instructions.

The same happens for int128 on 64bit.

	David



