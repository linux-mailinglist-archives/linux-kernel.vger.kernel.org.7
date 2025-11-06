Return-Path: <linux-kernel+bounces-888147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5BBC39F03
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD4D1A43A16
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E130CD8F;
	Thu,  6 Nov 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSh7My8M"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B254B30B520
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422740; cv=none; b=oR3zoAywY6gAHupxpZZF5azFPsjOnS9vLPNFfmOOWq+ixruZS/rdVFiMp6tU/kg3GZ/Q+qGlNpRE40K7LFUaQWEsiGxejs1mmjavxF09S1FmNQi8nm1cgQ4sk1kiDUA1fmL74qAF4jPB685T2cd8Ea5Sh9yBM65I+iU11ymT5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422740; c=relaxed/simple;
	bh=2JPNVuXRa83dWHryn2MausnFZU9uM+6ByRbLK/1wR5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDHIlNdreQLEJw22uxNgA132L0xICEIQkWNdU97wvvOCKgxrfU39C6ZeFGP3wQfPAwTGVaX8alDMri98okPRmQ62TT4tZQia4YSJI7pCnuy85U4AkrqvRyuADZk7Br+soddn6bWkpL+Vpg6Y806e7CH3rfxnvDpjTtfbS8K08XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSh7My8M; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so497627f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762422737; x=1763027537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmhHo+mWdVmWZSHBPuqlaAeG0cuVqWMg6mQPwD7IX0U=;
        b=CSh7My8Mfqz2zWjE6TFwy7XSOK+CqEcE043QrvEhz1zlQaxKzhH066cKeTs8jcZEHh
         U0T/ynlOi/rUiYjRxBL13setsb3b8kOu+qngU1K2WdO5zBlq1LtnlOVoD63Jg5zYBkde
         kC+KF43Gqto8MTgi1Hw1JdZMxiTbTJTNLYXuvbC7Yoy7kpCoM1gYUGO4h5TsfHBFYjdj
         +sRrXBme6b0FfOHZMZRfD7hl6hFhzKlGtjuGK1Rmu1FDpPIJWbAbeM5cEh+8MoMI1Q3b
         EwklYZYmGpWi14iseO0pyq9O+iCnzjKkDY3LWpFVBrdPGkWDpnpzVNyo4hEpCkMb6kFL
         272A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422737; x=1763027537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmhHo+mWdVmWZSHBPuqlaAeG0cuVqWMg6mQPwD7IX0U=;
        b=OA87XlCC0Vgp/6WmuA3fB9UNK11llmFA9NGcYorK/doF8uggh03ngpfFOcxepL+bdy
         EzLNONVzsBuPnlraMX7gVnrO8z/o9b/5sfPYzwtXRQEcmsEieDmYpUqj6hJnT9ogJTEI
         tTb3oMDCcyiuoGtQhBvZ36/Q6MVAIT0hYr+yOChB2S9ax2RIgbsTea435bsOJLMvtcit
         jmJ4tkYZNqWIEO6NtvHnRd1rSxJbNOsBYFQ9HiSKLNf/eMw51gKUiampMgM66rGoZXgq
         CLDa23CNsc0/gZPinfykd/wI2V7NUf5kKQ1GyYqIMA6GuY4UzP4wBYA5EeFtHwg+qdc4
         UlLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwXfOMh7e6wuhGbgetJVXZQXqZRxrRf5TNVjUCSU0n/FgLto3MUHxnN9C62aQfn4cibvCTa6gdiJf2IiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpi9D2M0KBj6O2Zj+y65vuJfXQ5m0GCpgh+G4q/FRltX4AYCVb
	jOYjnFUwyv6di5E4kA4JS2ITlPtBMCuWwoizlQipgKEEH9LE1yfp1JdU
X-Gm-Gg: ASbGncvbAEECymlHJCc4H+xBrN38tygqlRoNFqlp+mP9lPbzNoFFgz3s7cybn/A6KLu
	VXLFnUeLs+Lc9jYmqBPEeNPD94JSTQZGNW25/7N4B7rK1/yN/jCQpMBwxZ/TsmgKKnbYR+CZ9Jf
	ZEAWqgFZibN7Rw1z3zIj2oM+GN+MqRG0ewSdPxH52t6KiSmC0rV8NmxdWBKovs2Emz7IGMZjU0F
	KTLBgBX3i5U1gj8SBczH+1ZPIw+M4deUDrNFSiA4eWU9wCCTBjojvWuntXlzPXU8Oryoc9+o+F2
	2LNdPUI1Cn/SWuC+v5Jc3XVMpzsBFophULmDp6aFWXd4I+sG9naj8eC2mI08myFx1GNnyjrBjCB
	NWpgYWN+gxWEOJV0OHp2IPaWQJitbmfNoJbuWL37AzGWN2AbTVzHe3JBlQtqx7yiRbscxy8ttw4
	+movDzxT4Cgxvv34MKLioWKrkb1W0KXhnNf1khnUhatHf26OTLbMUA2AfXj1aP8t4=
X-Google-Smtp-Source: AGHT+IECda4r0X99ujPeDLA7DGJaVTqCNRobN0pa7OPBZWVyCyos/lpSyKVZdx6UEzou5TIJR4yG+w==
X-Received: by 2002:a05:6000:64d:b0:3ff:d5c5:6b01 with SMTP id ffacd0b85a97d-429e32e44e4mr5008746f8f.19.1762422736615;
        Thu, 06 Nov 2025 01:52:16 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb4771c4sm4097546f8f.23.2025.11.06.01.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 01:52:16 -0800 (PST)
Date: Thu, 6 Nov 2025 09:52:14 +0000
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
Subject: Re: [PATCH v5 next 4/9] lib: Add mul_u64_add_u64_div_u64() and
 mul_u64_u64_div_u64_roundup()
Message-ID: <20251106095214.2b9c9b8c@pumpkin>
In-Reply-To: <128901BE-2651-4335-935F-34A5B50D811E@zytor.com>
References: <20251105201035.64043-1-david.laight.linux@gmail.com>
	<20251105201035.64043-5-david.laight.linux@gmail.com>
	<128901BE-2651-4335-935F-34A5B50D811E@zytor.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 05 Nov 2025 16:26:05 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On November 5, 2025 12:10:30 PM PST, David Laight <david.laight.linux@gma=
il.com> wrote:
> >The existing mul_u64_u64_div_u64() rounds down, a 'rounding up'
> >variant needs 'divisor - 1' adding in between the multiply and
> >divide so cannot easily be done by a caller.
> >
> >Add mul_u64_add_u64_div_u64(a, b, c, d) that calculates (a * b + c)/d
> >and implement the 'round down' and 'round up' using it.
> >
> >Update the x86-64 asm to optimise for 'c' being a constant zero.
> >
> >Add kerndoc definitions for all three functions.
> >
> >Signed-off-by: David Laight <david.laight.linux@gmail.com>
> >Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
> >---
> >
> >Changes for v2 (formally patch 1/3):
> >- Reinstate the early call to div64_u64() on 32bit when 'c' is zero.
> >  Although I'm not convinced the path is common enough to be worth
> >  the two ilog2() calls.
> >=20
> >Changes for v3 (formally patch 3/4):
> >- The early call to div64_u64() has been removed by patch 3.
> >  Pretty much guaranteed to be a pessimisation.
> >
> >Changes for v4:=20
> >- For x86-64 split the multiply, add and divide into three asm blocks.
> >  (gcc makes a pigs breakfast of (u128)a * b + c)
> >- Change the kerndoc since divide by zero will (probably) fault.
> >
> >Changes for v5:
> >- Fix test that excludes the add/adc asm block for constant zero 'add'.
> >
> > arch/x86/include/asm/div64.h | 20 +++++++++------
> > include/linux/math64.h       | 48 +++++++++++++++++++++++++++++++++++-
> > lib/math/div64.c             | 14 ++++++-----
> > 3 files changed, 67 insertions(+), 15 deletions(-)
> >
> >diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
> >index 9931e4c7d73f..6d8a3de3f43a 100644
> >--- a/arch/x86/include/asm/div64.h
> >+++ b/arch/x86/include/asm/div64.h
> >@@ -84,21 +84,25 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
> >  * Will generate an #DE when the result doesn't fit u64, could fix with=
 an
> >  * __ex_table[] entry when it becomes an issue.
> >  */
> >-static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> >+static inline u64 mul_u64_add_u64_div_u64(u64 rax, u64 mul, u64 add, u6=
4 div)
> > {
> >-	u64 q;
> >+	u64 rdx;
> >=20
> >-	asm ("mulq %2; divq %3" : "=3Da" (q)
> >-				: "a" (a), "rm" (mul), "rm" (div)
> >-				: "rdx");
> >+	asm ("mulq %[mul]" : "+a" (rax), "=3Dd" (rdx) : [mul] "rm" (mul));
> >=20
> >-	return q;
> >+	if (!statically_true(!add))
> >+		asm ("addq %[add], %[lo]; adcq $0, %[hi]" :
> >+			[lo] "+r" (rax), [hi] "+r" (rdx) : [add] "irm" (add));
> >+
> >+	asm ("divq %[div]" : "+a" (rax), "+d" (rdx) : [div] "rm" (div));
> >+
> >+	return rax;
> > }
> >-#define mul_u64_u64_div_u64 mul_u64_u64_div_u64
> >+#define mul_u64_add_u64_div_u64 mul_u64_add_u64_div_u64
...
>=20
> For the roundup case, I'm somewhat curious how this compares with doing:

I guess you are referring to the x86-64 asm version (left above).

>    cmp $1, %rdx
>    sbb $-1, %rax
>=20
> ... after the division. At least it means not needing to compute d - 1,
> saving an instruction as well as a register.

> Unfortunately using an lea instruction to compute %rax (which otherwise
>  would incorporate both) isn't possible since it doesn't set the flags.
>=20
> The cmp; sbb sequence should be no slower than add;
> adc =E2=80=93 I'm saying "no slower" because %rdx is never written to,
> so I think this is provably a better sequence; whether or not it is
> measurable is another thing (but if we are tweaking this stuff...)

I wanted the same function as the non-x64-64 version and 'multiply and add'
possibly has other uses.

The instruction to calculate 'd - 1' (if not a constant) will usually
execute in parallel with an earlier instruction (eg the multiply)
so will be pretty much 'zero cost'.
The add/adc pair are in the 'register dependency chain' - so add a clock ea=
ch.
The same is true for your cmp/sbb pair.

(Except on pre-broadwell Intel cpu where adc/sbb are two clocks.
I've lost the full reference, the initial changes fixed 'adc $0,x' and
generated the carry flag immediately and only delayed the result.
The doc said 'adc $0,reg' not 'adc $const,reg' - so maybe the sbb $-1
was two clocks for longer.)

	David

