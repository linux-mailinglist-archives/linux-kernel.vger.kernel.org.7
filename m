Return-Path: <linux-kernel+bounces-733182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C14B07140
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F80E189B7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3062F199D;
	Wed, 16 Jul 2025 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COWU1UJp"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30A2F0028
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656949; cv=none; b=Um+uucbZvoVzijks5JXFtGJcdfeMjhVBv97zqi5HBxsnTHiWhsnCfGRV3Ajcd60fgbk37ETn6eEDxJIleOhxzsosrBAtoZusMMYHMKBO0GSoKSfVBYKBTbqNUy3VMO++CFvgNDyYrS4pxLYriVodS45hRU9dymalJoUc/EeDqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656949; c=relaxed/simple;
	bh=mlno4CH0IHBcIPXpPJkLJyBuOor1DgbPJpcT93X79q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4aH0/vQXluPnKC5DpOwtZ2kVM1xtirRfLT5MyH7P6hfC98ACdZkuzWaKwQCtRM0WqIHkjKE4v492zWJJoThcei8/HQc0KdgR0iE0052SicrwxTzEh64vSzIpjvphx35GHiyKTHJENNrBgcBLGN7RtupnEbuJlD7XLxjLYsdb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COWU1UJp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo11279613a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752656946; x=1753261746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihJ+f1NCJBZ9WcLY7Jx42k6HJUZFV7Gfk0PAA31DN8c=;
        b=COWU1UJpj2+rt4rQ+KCbrgp05aFfoakpPx2C7+EAelwTMi16v93bIG/onSKMdW7i6P
         almUp7JaY9xvSS3KOvoHoPMeTy/4F3GrJ19vx+8QPkJ3Mc/o4O6wP43NnAsC7zcxFBps
         NXNgbut6k2VObtxOa8dgxdp39ivyNlih0rs2CfTWarlu2hKJfGYo1ttwqwtKSPV3zgiX
         dmw/fz0swb59HSK+aCYuX92Ee5ab5HeCdPffs95EpqTJfFrk2WjJICeT7gwYFrYCFZU6
         zgpscMYf5WUUD/kKRGHPqkFy0nY2X/3lA5+jqjA9Tc0BzaRUGsMLzwM0xjMy+1PSXHKL
         iTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656946; x=1753261746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ihJ+f1NCJBZ9WcLY7Jx42k6HJUZFV7Gfk0PAA31DN8c=;
        b=uJ8im6WAOwvpi6cqooHv5o1yfgKjE0IJkpBAyiaxLPoDL3JrdHeJ4rszoReaMb0O+R
         HQWYg4rYZGBBYeh4yrgJUMHt2HeVNLrSd5CAw2NePfbAf0gpY+ppntyyphx3mEWyC4EN
         v3QHCYn1nA/0lZ3ZtS1qNQaQVP0Ln59QggIDuHp+Q7WRleMldKXS8DY+op3B5iUF/f/g
         N/F+2WG0AWSqlGuC7xe/4W0CPqWzSbh8naluw9j/Mwis02tDIbO72F3re0T+Zta9NJKq
         B6WxCyEON8rtLid7Z/2Hh17BxDm2D1OYAdEYEHR68iYa5m3LLvgIO3hdy6pdM8fBa/MK
         jGUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7szrK/QqAjj133r6Nr/rjgBpLYQbDRtiKbFuwUIFK2ZQXnUowlB0x0/yiJYeamK9o19P4QIZt3CrCgYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9+BpZ9Njf4MBhJiR60Mg7tLKwWYIssr8osQk6RD3Qzm6m+07
	5C2e3hG5rLN3UKu10q4dE+fBxn8Iltn7SdHYYfGkZjr6V4/t+FGLNqO/
X-Gm-Gg: ASbGncvEVIBLkex75/PzfC8UIPaRGjTljlqNHLelp6bznT2AQpIujSWx3/8HGfG3x1v
	iBgaF7Pa494hoRCEZOHV+U4kUZrzNEmy9nEooySf4chjRkqpQDo/ukop8vYt3qqH2hrywGwQMHk
	aPqAcUV2uqGkhfVtgkHkc/VWjjQeMLGNU8K/JjLWXNRGzs6fDf59OEivmgIJuh8QUxA8jZyTkym
	rIRJW/r/aIcKnKHaLDXRnMUa9LSEQ5xnoxuDwby1Wo84MwMWtsjPzkfdf4h31vWKcIkdgEqgGdj
	4smbuJqNapFLZjaA4EiTtmK3/QkHf9f1YzgR+iooa7owlfokjzjx/Hjb1GtyiUsppeNh9HoAuJC
	Qlg5pTjIyAfrQuPiEIpFx3rQwAyAG0ULB2GM+MLjbJiZU7Vbu
X-Google-Smtp-Source: AGHT+IHQrLA+Eh7cceyTetqJZ6SXtm0nq51LdTyMZs48YkixndfHnbVTKtN1Bm5Jd2lzHTAEkAZrUA==
X-Received: by 2002:a05:6402:164d:b0:60c:5853:5b7f with SMTP id 4fb4d7f45d1cf-61285dfca8dmr1328144a12.32.1752656945247;
        Wed, 16 Jul 2025 02:09:05 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c973360bsm8584453a12.45.2025.07.16.02.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:09:04 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: bp@alien8.de
Cc: andrew.cooper3@citrix.com,
	ardb@kernel.org,
	brgerst@gmail.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	khaliidcaliy@gmail.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	ubizjak@gmail.com,
	x86@kernel.org
Subject: Re: [PATCH v3] x86/boot: Avoid writing to cr4 twice in startup_64()
Date: Wed, 16 Jul 2025 09:07:20 +0000
Message-ID: <20250716090755.668-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716014504.GAaHcEIIUgNOdu_n2s@fat_crate.local>
References: <20250716014504.GAaHcEIIUgNOdu_n2s@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > > diff
> > > <https://lore.kernel.org/lkml/20250715181709.1040-1-khaliidcaliy@gmail.com/#iZ31arch:x86:kernel:head_64.S>
> > > --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S index
> > > 4390a28f7dad..dfb5390e5c9a 100644 --- a/arch/x86/kernel/head_64.S +++
> > > b/arch/x86/kernel/head_64.S @@ -222,12 +222,9 @@
> > > SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)  
> > >  	/* Even if ignored in long mode, set PSE uniformly on all logical CPUs. */
> > >  	btsl	$X86_CR4_PSE_BIT, %ecx
> > > - movq %rcx, %cr4 - - /* - * Set CR4.PGE to re-enable global
> > > translations. - */ + /* Set CR4.PGE to re-enable global translations. */  	btsl	$X86_CR4_PGE_BIT, %ecx
> > > +  	movq	%rcx, %cr4
> > 
> > The comments are at best misleading, but you've broken the TLB flush
> > being performed which depends on the double write.
> > 
> > This logic is intentionally performing a write with CR4.PGE=0 followed
> > by one with CR4.PGE=1 to flush all global mappings.
> Thanks both of you for the catch - I didn't realize that fact. Zapped now.
>
> So yeah, maybe there should be a comment explaining this subtlety.
>
> Thx.

I think the comment is misplaced. It is better if we move starting from "from the SDM"
to below the endif. The second move the comment above it isn't useful also everyone knows 
what PGE bit does, so it is better if we replace with the above misplaced comment.

Thanks
Khalid Ali

