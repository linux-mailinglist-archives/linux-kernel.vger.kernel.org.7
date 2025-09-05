Return-Path: <linux-kernel+bounces-802863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE934B457AD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C187C6A3C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D92F350823;
	Fri,  5 Sep 2025 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LZx99oRA"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D71FE444
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074821; cv=none; b=sSTEA3yVmxPyPmj2BlXt8WMBHenBrA3E4XrFwHM/5FtMi0KeezsypVDVyDLI7eayVat5gae4gkfVKxKoxGDbUcEj6evaMdUJZFMzr6n/R4/D9bfwz6p1tUm2Wqy6gietulrMsiNoupXody8UGMwX4TuuXYN6Oy+C3eGAp/NX8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074821; c=relaxed/simple;
	bh=oHOTTPExMQImJmzFtGSl2bugeWJp0tEccYalf3LU7b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+pyGHtAZI/3mmgY9uhnWXj7gETMvilDBzz2BFeEfisAnLzKtx3ngF6RLDLUIldNjVwi681ffLAQwQe1dDdyNI7bkhsZf9USHs72Wq1QNchmUcmbKAU3YHhjBst7wSPrhVO1hyT1kXV48EdqkQJ6Z/+dnQV7Ee9lnnLfPn/geFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LZx99oRA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 53EA240E01E8;
	Fri,  5 Sep 2025 12:20:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dtZlmLK8XpmJ; Fri,  5 Sep 2025 12:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757074656; bh=lP3bBvdRK+Uf3nvlk9NuJSKDhTy/BCK4LnNy+ZcBC+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZx99oRA/xcpteFWmoO8X+J/OXqazZ1r13+hxHwS4PJCjVcHCwPcxvPHJR97zRanY
	 aT4r1Bh4OZBGJH1lPd1F77bouJb8S/mj9wd0tHmw6vb8g0aSCyA/qRdLY++RYENBhQ
	 Pzkf/YYEqcpsiedg+X7aSv4a3ryQ02w6FAU6QOq2ZxP4s2HpZtoG0/jrq7qi8SpLrW
	 hfKMNCu8Z0ENE2uyjgzki2+BD9aWsAFU1I4QmUiIABJ6p/P7VSDnuTZVsN7pEbaJRw
	 wNJ+oSt59QjpOh0owaGnt//fvUjYJf4dgjBNfEFA4jXj7yPddXrqZCx8TiR17Y8AUY
	 tCX7IIO36CLJLfJ+cAIHXwy1hDg8SpRXukZdOpn7RVwn10zNJYVgAKewuUPgmfVulm
	 vSCknhYbKpiBb1+i2pDISlmDJLI4GsZLUPu8ogL5MPRbbhl1dvzs0WyHqQRM5ae9d4
	 M7+29chUahW5oKCRtN3t7GiCYcOkJMty8aHHF8xUOmp73dKy5MWrAsgmctH3qjKbr8
	 futqm2FuRzdrju5t8Fxluv8EsIfIg5tYXUb9g17ahsyl7LyrxmJFtEAcagXxIRzG/G
	 iX9NkW5tggKZD2OFoPy9fDhBcvceRH3JGwAUEYC9X9B/6BeYbSvZk+o3wQBMOEbIl2
	 4LpEUVBbkbPoJetBQNNpIFxM=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C081A40E01AC;
	Fri,  5 Sep 2025 12:17:29 +0000 (UTC)
Date: Fri, 5 Sep 2025 14:17:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH -tip] x86: Remove code depending on
 __GCC_ASM_FLAG_OUTPUTS__
Message-ID: <20250905121723.GCaLrU04lP2A50PT-B@fat_crate.local>
References: <20250828072958.3922703-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828072958.3922703-1-ubizjak@gmail.com>

On Thu, Aug 28, 2025 at 09:29:29AM +0200, Uros Bizjak wrote:
> diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
> index 371f7906019e..1f80a62be969 100644
> --- a/arch/x86/include/asm/cmpxchg_32.h
> +++ b/arch/x86/include/asm/cmpxchg_32.h
> @@ -46,8 +46,7 @@ static __always_inline u64 __cmpxchg64_local(volatile u64 *ptr, u64 old, u64 new
>  	bool ret;							\
>  									\
>  	asm_inline volatile(_lock "cmpxchg8b %[ptr]"			\
> -		     CC_SET(e)						\
> -		     : CC_OUT(e) (ret),					\
> +		     : "=@ccz" (ret),					\

Any particular reason you're not using =@cce here?

I know, they're equivalent but why then switch to =@ccz?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

