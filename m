Return-Path: <linux-kernel+bounces-720203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2323FAFB880
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8FC1AA62A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBEF1DDC18;
	Mon,  7 Jul 2025 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddoJmrOo"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7B2E370C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905069; cv=none; b=RgBgoYlIUbtJlKClztOIR2/qjQRZ9H/Egt1OACO8vpXLTbTA4KEvEJvVe8d8m6d6Ux63F2ehbChAags77O6LNVy6OCgC7xJ7fzcS7mHVbosUx8P98JDnEYBaEXtp0E3CVE0lgx90+mjfFJQjkf6+goBayp9SYHthgIo/IJDvyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905069; c=relaxed/simple;
	bh=XZbnKWyFZhZtbahv5e3vtqR6XmGL4qjI2x8T7SqxLO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifiKqhxux4IWOsB+nGcShuZG0JAcR+hbERPK9SiJZGqftiRRJYTTWNMCdwn5kaoleRyfuyzgqzx4H5ADMbaxA94kTw9xgSNVTAhnuSyhS/YpMcl/7ASllPWi7c7dKXzcHWZ02rxe/xTv8SuTnqKTF/r/Pqd6wE0P6FL84Z+wwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddoJmrOo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2363616a1a6so30758215ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 09:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751905066; x=1752509866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plhscmn8unqBogHCLfe3zzhmsxB9tOjf382Kqk10WmM=;
        b=ddoJmrOo/NKf6frhzJnt1gDMEmvfML+fjBzj2meFRX8aHi0OlwNcWiVaq1iukEQslf
         mTsdUnOdLmhWKTIl3/6H65kgz2lwOk0Cs23TMz09kI0sAIc8R3Yr1Tlzs7FJMVfOQ6gF
         /NMEqQ1+wDn3hjOTlAx5KMG8tRGqVTv8Qe5V6jftW9rjhsbnBE1DJzO6yQwuV6zk+9Yr
         mZCzbypUMWOTUrJL897g+YE9PmP2PoKXaYXsKS+vvfxjwBl6me0+MIHbsOmcKAgNRJna
         b9AT3lH1ZiU3Ji4YGnvS5IUMM7L0U4ZrnxbAXQJ+Y1Qde2A9kX1inOteILOvl/0JeKiH
         stXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751905066; x=1752509866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plhscmn8unqBogHCLfe3zzhmsxB9tOjf382Kqk10WmM=;
        b=Zk8hMTJr1hswdphb0T0MWzt3s/bWvfGAldcGbQqFzJepo8sojUcN7i2lU8GmGDKG4T
         p3ILUm88dp7gAy3aKn30AkWvtqJ/N511VjRVKHRXOJjv6UiM2tK8fSIUv8eH/2ymdbvp
         RG8tw7j1QDzA6P9s35z2z0/9XXionfJ5nyloj2myfYKNRDFh75VplZnXvBx2bEF9qlmZ
         aedcf9zJgj2QIYthMujTImZTuOXMxeXy+42T135dFklb3aTygNAehfr6pfNG3HtMypvY
         QEiHfiO8nZS44YYpjXiDOQQ/Q74VuxRledXQh5CRbqgH3jkSzSEEzA7tEOvA0gtuOExT
         9GSA==
X-Forwarded-Encrypted: i=1; AJvYcCVK0dTcgLy247gI0a4IHDvFPxLFXNXV9kTtcN5YDh7/d3VXj0bYBr5t0ajKGbXZulzioJ9IZNA8tHVqE0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRH9INyLwDYIsVt1GrhXxAN8orPWpmCaWNlnKo2CvvD60c8fBx
	cBnnYa0xkNjRuwco+prYC012dfjrSS2nVM2qLWpr+eD4X/w8DUpnSvjp
X-Gm-Gg: ASbGncscZc5ziGW+V4lsnpzUeoYqjDntE6Kd446ZNNbHeMUk3Xvo2Y5uwpyJIWv48tZ
	A0k/f2+pEPxZIUydTEH1VZHjQ7vcQnI3BjZ/5Mq+S0G38Fo3yPW7twAjbadJ4EYOyZAVKhmUQQt
	ULc0G7wBromdGJpw8D59whhw21fq7obsMf2CzAtHMkocAlniDUQ2yTgSKSj8WMxzGUR7kIxpAhI
	Ch+8MekQwZEdDBX3/qTdcNPjMSmAuhVEB4EtIybwXX8vRhItpRNkr87k7X9xI5ARL4Ujyig/Uxk
	7emOID9VGTgQ7BVnuez4KjZMKCsQ0Iggl8vuXhIx791HdXjyA4ps95d79lTf4w==
X-Google-Smtp-Source: AGHT+IF1moARBkgm2lhQ9mBywi0r3o93XpJWFbU3tfKbOXZ3T+6OukiapWmLixUD8Kkr0uNvuebhpQ==
X-Received: by 2002:a17:903:b07:b0:234:948b:91c7 with SMTP id d9443c01a7336-23c875d2f93mr217129395ad.51.1751905065725;
        Mon, 07 Jul 2025 09:17:45 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450a61sm9260195a12.8.2025.07.07.09.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 09:17:45 -0700 (PDT)
Date: Mon, 7 Jul 2025 12:17:42 -0400
From: Yury Norov <yury.norov@gmail.com>
To: mailhol.vincent@wanadoo.fr
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] bits: Split asm and non-asm GENMASK*() and unify
 definitions
Message-ID: <aGvzHdDACM1Cw97f@yury>
References: <20250609-consolidate-genmask-v2-0-b8cce8107e49@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609-consolidate-genmask-v2-0-b8cce8107e49@wanadoo.fr>

On Mon, Jun 09, 2025 at 11:45:44AM +0900, Vincent Mailhol via B4 Relay wrote:
> This is a subset of below series:
> 
>   bits: Fixed-type GENMASK_U*() and BIT_U*()
>   Link: https://lore.kernel.org/r/20250308-fixed-type-genmasks-v6-0-f59315e73c29@wanadoo.fr
> 
> Yury suggested to split the above series in two steps:
> 
>   #1 Introduce the new fixed type GENMASK_U*() (already merged upstream)
>   #2 Consolidate the existing GENMASK*()
> 
> This new series is the resulting step #2 following the split.
> 
> And thus, this series consolidate all the non-asm GENMASK*() so that
> they now all depend on GENMASK_TYPE() which was introduced in step #1.
> 
> To do so, I had to split the definition of the asm and non-asm
> GENMASK(). I think this is controversial. So I initially implemented a
> first draft in which both the asm and non-asm version would rely on
> the same helper macro, i.e. adding this:
> 
>   #define __GENMASK_TYPE(t, w, h, l)		\
>   	(((t)~_ULL(0) << (l)) &			\
>   	 ((t)~_ULL(0) >> (w - 1 - (h))))
> 
> to uapi/bits.h. And then, the different GENMASK()s would look like
> this:
> 
>   #define __GENMASK(h, l) __GENMASK_TYPE(unsigned long, __BITS_PER_LONG, h, l)
> 
> and so on.
> 
> I implemented it, and the final result looked quite ugly. Not only do
> we need to manually provide the width each time, the biggest concern
> is that adding this to the uapi is asking for trouble. Who knows how
> people are going to use this? And once it is in the uapi, there is
> virtually no way back.
> 
> Adding to this, that macro can not even be generalised to u128
> integers, whereas after the split, it can.
> 
> And so, after implementing both, the asm seems way cleaner than the
> non-asm split and is, I think, the best compromise.
> 
> Aside from the split, the asm's GENMASK() and GENMASK_ULL() are left
> untouched. While there are some strong incentives to also simplify
> these as pointed by David Laight in this thread:
> 
>   https://lore.kernel.org/all/20250309102312.4ff08576@pumpkin/
> 
> this series deliberately limit its scope to the non-asm variants.
> 
> Here are the bloat-o-meter stats:
> 
>   $ ./scripts/bloat-o-meter vmlinux_before.o vmlinux_after.o
>   add/remove: 0/0 grow/shrink: 4/2 up/down: 5/-9 (-4)
>   Function                                     old     new   delta
>   intel_psr_invalidate                         352     354      +2
>   mst_stream_compute_config                   1589    1590      +1
>   intel_psr_flush                              707     708      +1
>   intel_dp_compute_link_config                1338    1339      +1
>   intel_drrs_activate                          398     395      -3
>   cfg80211_inform_bss_data                    5137    5131      -6
>   Total: Before=23333846, After=23333842, chg -0.00%
> 
> (done with GCC 12.4.1 on an x86_64 defconfig)

So, I'm still concerned about that split for C and asm implementations.
But seemingly nobody else does, and after all it's a nice consolidation.

I've moved this in bitmap-for-next for testing. Thank you Vincent for
your work.

Thanks,
Yury

