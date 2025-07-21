Return-Path: <linux-kernel+bounces-739749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79291B0CA65
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D825169377
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6689F2C08D0;
	Mon, 21 Jul 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTmkWuA1"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F271917F1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122059; cv=none; b=nFHET0Q7lPpjN0sGpvh6Og5RauRA4XDeUOB71MT9hiStUULEBWawS/nZDYPIBEsJvfLv8c6h+WG307QMyDtolHSPlWeTf6wiAGWQ3P/Jf1zkscRxg1CloG4XoD2qwbDbozxJQAzAmssqapXZK2fAs/FcjvUrwq4AdrxU6I8yjl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122059; c=relaxed/simple;
	bh=E26YmQCm8xPZWHxySpT9spSfYvDiVOC7z1z91yt4wwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLWfzrYddDD3JPuR6ETQCWQJUx08+ia2SoNTv2mQbtf9IWpt7xKGB1tH4EbocFQjRApOYxwXYJnWd2FE+mBYpXOWnngxvEsPobW2UvRJym+FNAZmBf1aFOq7nsL+dRzmtrzIS9qtXzZqpcfBTAoYDmmEt9RcBh7WH5+X9B1MP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTmkWuA1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45634205adaso22450755e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753122056; x=1753726856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2qtbBedzP2vdcPV+O/ffafYzBvYMBfynCmjWx8T7y0=;
        b=cTmkWuA1sNU7aLez22x9b7BiBvmQjBpTm62vNWEGCBJ/H7dlDVOhedg9qghscNqVAe
         j+w0wc//avgH07N5++c61jt77Z0CBhDOUxSI4MuVGiL+I1uOuZEPq//YD2rtGrV1wrIS
         PBLt10DI6FrgPEEImpRhKODlX1ociPwHb0PyuDiV4KoRLoZb8ci8c7F+Q3PskM7/RqBc
         Zmj0Tk4iFeskk/PeRcv6a8j/210j79qomYba5x55eJpXfOM0w340Snc9cjFKZ3eBjZTH
         nC2Mp9E1H7ww6N8j59yB3xBA5rj9SoOR1VxHQClGItISbCGWoY1AXMdlzUEk3CE/p2wB
         kiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753122056; x=1753726856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2qtbBedzP2vdcPV+O/ffafYzBvYMBfynCmjWx8T7y0=;
        b=W2Oqd6uemAfDNm27iTfOekgXACsE147nc9lfIFRT0QOtqOWiEgjfJZN95KQv8I4Aim
         US30Wzg7CuVUN/FOVzTIMYiQ8QHOCu7qI1iMzyMK3xNEJzH+Wah8H1+TSDUyCh33QRV+
         GMuFeKkj2R25L4yiEI6dbPssvh3z5ZRvbAVREAWtK3cXiQcssEPkNNqN7QFdXMPh7FKR
         Y2G+u0m+rGlJ6NA6df95z1DJnD8eumiJjdKizklb53Cv2+3DeYJ3C0BgoBgFleORcsYW
         a1Cswe37Ain1IaqAfbDzh6maMvuQzJmQHS+gT8QOuouzSKO0o+385wNy5a7Qdu6ddvO3
         KMfw==
X-Forwarded-Encrypted: i=1; AJvYcCWhR+cn8tVfBnmYDFzxRrmrkG/gEj41+Z6KjyT+ZtSxalVC1lkOWFggkHYI49FIrVDXW8p8ODGWdqhLbDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmvS4Ktye8NjIKtlgLvUy9eezV4HiEtHa3l8kc6+ncfoF6/Qwr
	c2wmmT2/Qgvefw0Z2yz8H4m6VW9DWpwj9OzuwHhIu/7v6old61A17DKH
X-Gm-Gg: ASbGncsQKiT7G+GaVm9/IvrqH4m3CJxzm18yCNoB5VmXW30oaXYpu06SU8iAimd0xCy
	uq9AzKTd7aDGH5E1AqQWd3RmqnZZ3JLijfgcEPCQ70xOCAwm0M9B19e38cflDZnhJf4F0/2JVbo
	MKOcXx+ffqZ4kyhLnVq7vdhENqaPH1SFXZkkoXTY/kXXLjGGNwVUVkzRyditR6YvTYb6EwbvK8U
	J12GL8aKw39AV92vk4RrSgJvtjPIRV8sM10xbvQbnBtBTLOOjrfp1qeMmIobqCCMSAukjD9xdNE
	uG/VKo8Hh8Gdl1Tgsgbh2b2vfwIMyddW5OKfeDVotUOmLFjjkuba1daXl+32TGTav05U+dHQDJw
	XModiRzAgiG+Fk40ezbTjsCSoOoYNy567QFvOSpcLgfwImYRydmAnkeJAAPM2
X-Google-Smtp-Source: AGHT+IEd/6ta9O786EMu+fE7PMR+7mYyb/Re4Xg6yoWK+YC28i39GLPPRIxbwrHOAS4Fq/aP0DKJbw==
X-Received: by 2002:a05:6000:2006:b0:3b3:9c94:eff8 with SMTP id ffacd0b85a97d-3b60e51c895mr15615483f8f.27.1753122056089;
        Mon, 21 Jul 2025 11:20:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b740c51sm107573725e9.19.2025.07.21.11.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 11:20:55 -0700 (PDT)
Date: Mon, 21 Jul 2025 19:20:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Li,Rongqing" <lirongqing@baidu.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250721192053.58843751@pumpkin>
In-Reply-To: <20250721130422.GA31640@redhat.com>
References: <20250721130422.GA31640@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 15:04:22 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> Change mul_u64_u64_div_u64() to return ULONG_MAX if the result doesn't
> fit u64, this matches the generic implementation in lib/math/div64.c.

Not quite, the generic version is likely to trap on divide by zero.
I think it would be better to always trap (eg BUG_ON(!div)).

Alternatively have a function that returns (ok, overflow, infinity, NaN) to
its caller - passing the buck.
Although, perhaps, in a way that the the callers can ignore.
The trouble there is that (an ignored) ~(u64)0 is likely to cause another
arithmetic overflow with even more consequences.

So I'm not at all sure what it should look like or whether 0 is a better
error return (esp for div == 0).

Even for the scheduler that recently trapped here, the 64bit sum was
about the wrap and the very small value returned then almost certainly
wouldn't have been handled correctly.
(So that code needs fixing anyway to avoid the overflow.) 

> 
> Reported-by: "Li,Rongqing" <lirongqing@baidu.com>
> Link: https://lore.kernel.org/all/78a0d7bb20504c0884d474868eccd858@baidu.com/
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/x86/include/asm/div64.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
> index 9931e4c7d73f..dfd25cfd1c33 100644
> --- a/arch/x86/include/asm/div64.h
> +++ b/arch/x86/include/asm/div64.h
> @@ -79,20 +79,27 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
>  
>  #else
>  # include <asm-generic/div64.h>
> +# include <asm/asm.h>
> +# include <asm/bug.h>
>  
>  /*
> - * Will generate an #DE when the result doesn't fit u64, could fix with an
> - * __ex_table[] entry when it becomes an issue.
> + * Returns ULONG_MAX when the result doesn't fit u64.
>   */
>  static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
>  {
> +	int ok = 0;
>  	u64 q;
>  
> -	asm ("mulq %2; divq %3" : "=a" (q)
> -				: "a" (a), "rm" (mul), "rm" (div)
> -				: "rdx");
> +	asm ("mulq %3; 1: divq %4; movl $1,%1; 2:\n"

The "movl $1,%1" is a 5 byte instruction.
Better to use either 'incl' or get the constraints right for 'movb'
(both 2 bytes).

> +		_ASM_EXTABLE(1b, 2b)
> +		: "=a" (q), "+r" (ok)
> +		: "a" (a), "rm" (mul), "rm" (div)
> +		: "rdx");
>  
> -	return q;
> +	if (ok)
> +		return q;
> +	WARN_ON_ONCE(!div);

I think you need to WARN for overflow as well as divide by zero.

	David

> +	return ~(u64)0;
>  }
>  #define mul_u64_u64_div_u64 mul_u64_u64_div_u64
>  


