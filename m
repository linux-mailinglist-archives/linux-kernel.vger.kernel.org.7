Return-Path: <linux-kernel+bounces-774623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D142B2B525
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF971961D69
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784A727C158;
	Mon, 18 Aug 2025 23:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mffIIZQB"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F49922B8D0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755561530; cv=none; b=SSo2OeYET9Ep058y8lfQPkL1fV6/As/6VC7sRqLbn6jIEV33MgB4mgz+OijouDuvRAA5fpXHwrWMBeo0SjUcaDhzG1y9SyMn/9NMVnOoUclV1zByU2o8ldQ2tOt44Y1MfRAA5v/9OqaNHp1Cup+Mjw1RuF4A40S1h6QnbYF3sec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755561530; c=relaxed/simple;
	bh=glVk/hY3UV087gQCtno8h+R3ZP+p7PuN1b//8T9JP7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vA2EDCTiN6kTu9JSwcZ27nGAFkAkp0/fmBaa4BDZUymm4WDFJNzhvjhIUVixQbh0tPzmg/Xz2Nzvrrdgn3FQvLMrvotIliZHpY8ilEzCiInx0F8vV4RNpvUaO4Hh8+P0ln0x55zE1z1SDKvrNrbnPUg1S14UvSdkpcCvq2DEL5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mffIIZQB; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e575ff1b80so21786645ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755561528; x=1756166328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i19yi9n59eMxo8uVt+mvLfPM1/Jk8FxebqQQMeUMWso=;
        b=mffIIZQBPNk6uCAAQSeq90VMwd+6Vm8I5APcRrg+MvbgbrVGOqT+e1VEkMDFn3TQCn
         2FPd+ucQLZ+e/0lkXeqHTvjAcpyeEFc3Z/Pel8E7USfdvtWYUko64R4PvpFMUkikAbGm
         YOWbpOpIRakQzg/XkXKAd2QVlFlHtoPMxu9wh0URzJ2T4fTDIVZQasfNH0WmRh4MJGHP
         E3Hb7RKdbryPQTTsdz0P5Y0fQhJTGnBbyV6dTDe5zHoPoauUgUHAPk/SR7kq+4iuxdUD
         nbRDRtJ6HWPSotQnB/IvudTZgopRER4k1GDsBByztdnVwxjxzGWQInb1rNUO+MhsFoCo
         sGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755561528; x=1756166328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i19yi9n59eMxo8uVt+mvLfPM1/Jk8FxebqQQMeUMWso=;
        b=LZcqTDOcAgpQz0tn3F5rdxFezvqDdnXbStB9K5Hu+/tImz4igVSg6ZMcfsHMRqorm6
         FBLMd+bbeRPlwuxIj0yoWwIcPYRp8PoG95Jeb0kvbjRqTao0uy58Rfu1JrHh7fJXG08p
         70wWM2WUv/WhnSCR1DNVujg0QFXycJ7Ooy4wN8MdH5o7FnOp0R4VDs3ShDjPC8gITrU/
         3qwFGCQwpDK0XDZD+goRA25fSZpB4oG9zKfaVVTINjIjDNE8LmvwjQqodYvAjH6UoGAF
         CCekPAg5w5PE9vF3GyjsjxQiUPRp7thgOT/7xGLbpWiO77sbuD/eNMD1FEeJfNtN0sqb
         pMkw==
X-Forwarded-Encrypted: i=1; AJvYcCVNV/9qN1TYokCTcrjaCezuVawLJ0l20WWm6jdM72Zbe9YHOXD4Hp3IoGs7ryIjQpjhQ15Hnx1ybSRmHvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrI58juANVVog9JDxyMPgwGxTHO6OTkK9nN7EKyAaFbo1fZDU5
	BJWsqwwrez62ci15R5OaIaYJmpvAJzlbHEOs4TZrno7lpzsS4lC3pasDD/yOsDIO6A==
X-Gm-Gg: ASbGncub4TTGq2deNrt2WjuCkKYe1glzoFHz1SBZj1sfREVATROi2/5zDi0B06iKjCB
	A1KYDZDKjulisarmGCLqPdRTLWYM9Y0fHPK5jJHHgugGsaZuT+5ej8b4u4Ho2dL+AnNsk9PMDn3
	R7E3pkNuwqa50VPARWRK6hCbkn/vWqhxChNKR5E8NhNb40mr/EzC0aahkwayc81ytwGyE2+BF8T
	R4oP5DcF0zkHHSeO9o63nPktTwvxyxABu5RKx1qNLo7sM4j+3leJHgE5p0j+RE4xCcrnObZUWMT
	pyBsYLtgYad3YI0vQ2FRQyzX8gS/IDvPaMToxZgSSpfWUe3FOIboETphkH9SL48KE+z2LRduHSU
	Yg8CdOfeLPg0Az/CcGNKUOOLT4ZmZ2H1rEmXUpgtLHj+Yr4o8Q9yMmM+65mQN/caOcF+Ej3zw1w
	==
X-Google-Smtp-Source: AGHT+IEz/EI+LZtyAIW9MjYSAxlsQgeLXFtkoryUpRnIuhRS73z7iBfg2JLP0JM/2ebqh0wR5R8r8g==
X-Received: by 2002:a05:6e02:1947:b0:3e5:7de6:c348 with SMTP id e9e14a558f8ab-3e6765ce30dmr12922565ab.3.1755561528238;
        Mon, 18 Aug 2025 16:58:48 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94781b7csm2898883173.15.2025.08.18.16.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 16:58:47 -0700 (PDT)
Date: Mon, 18 Aug 2025 16:58:45 -0700
From: Justin Stitt <justinstitt@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-hardening@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] MIPS: arc: Replace deprecated strcpy() with memcpy()
Message-ID: <yisgcmjp5cj27yozthudyrdpfcovhcrgpqbyip5kcum4aa7qwl@52bccatjuiak>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
 <20250817183728.612012-5-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817183728.612012-5-thorsten.blum@linux.dev>

Hi,

On Sun, Aug 17, 2025 at 08:37:15PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use memcpy() instead.
> 
> Use pr_debug() instead of printk(KERN_DEBUG) to silence a checkpatch
> warning.

I'd like to see more reasoning for why you chose memcpy() here. With api
refactors like this I think most folks want to know if 1) there is any
functional change and 2) why you chose the api.

> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/mips/fw/arc/cmdline.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/mips/fw/arc/cmdline.c b/arch/mips/fw/arc/cmdline.c
> index 155c5e911723..86b0e377b713 100644
> --- a/arch/mips/fw/arc/cmdline.c
> +++ b/arch/mips/fw/arc/cmdline.c
> @@ -42,12 +42,13 @@ static char __init *move_firmware_args(int argc, LONG *argv, char *cp)
>  {
>  	char *s;
>  	int actr, i;
> +	size_t len;
>  
>  	actr = 1; /* Always ignore argv[0] */
>  
>  	while (actr < argc) {
> -		for(i = 0; i < ARRAY_SIZE(used_arc); i++) {
> -			int len = strlen(used_arc[i][0]);
> +		for (i = 0; i < ARRAY_SIZE(used_arc); i++) {
> +			len = strlen(used_arc[i][0]);
>  
>  			if (!strncmp(prom_argv(actr), used_arc[i][0], len)) {
>  			/* Ok, we want it. First append the replacement... */
> @@ -57,8 +58,9 @@ static char __init *move_firmware_args(int argc, LONG *argv, char *cp)
>  				s = strchr(prom_argv(actr), '=');
>  				if (s) {
>  					s++;
> -					strcpy(cp, s);
> -					cp += strlen(s);
> +					len = strlen(s);
> +					memcpy(cp, s, len + 1);
> +					cp += len;
>  				}
>  				*cp++ = ' ';
>  				break;
> @@ -74,6 +76,7 @@ void __init prom_init_cmdline(int argc, LONG *argv)
>  {
>  	char *cp;
>  	int actr, i;
> +	size_t len;
>  
>  	actr = 1; /* Always ignore argv[0] */
>  
> @@ -86,14 +89,15 @@ void __init prom_init_cmdline(int argc, LONG *argv)
>  
>  	while (actr < argc) {
>  		for (i = 0; i < ARRAY_SIZE(ignored); i++) {
> -			int len = strlen(ignored[i]);
> -
> +			len = strlen(ignored[i]);
>  			if (!strncmp(prom_argv(actr), ignored[i], len))
>  				goto pic_cont;
>  		}
> +
>  		/* Ok, we want it. */
> -		strcpy(cp, prom_argv(actr));
> -		cp += strlen(prom_argv(actr));
> +		len = strlen(prom_argv(actr));
> +		memcpy(cp, prom_argv(actr), len + 1);
> +		cp += len;
>  		*cp++ = ' ';
>  
>  	pic_cont:
> @@ -105,6 +109,6 @@ void __init prom_init_cmdline(int argc, LONG *argv)
>  	*cp = '\0';
>  
>  #ifdef DEBUG_CMDLINE
> -	printk(KERN_DEBUG "prom cmdline: %s\n", arcs_cmdline);
> +	pr_debug("prom cmdline: %s\n", arcs_cmdline);
>  #endif
>  }
> -- 
> 2.50.1
> 
>

Thanks
Justin

