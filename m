Return-Path: <linux-kernel+bounces-785365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FC7B3499F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312E93AABA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A2A3090F4;
	Mon, 25 Aug 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="O/boIG51"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B472FC88C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144929; cv=none; b=kjJMJ0///5PHqkrPmtnhVY8LhWft1FIVasEoe8nCXr+jGcI1AhdrQERE5YtKH3Xd3Uq+s4fQftz+PtP0Um6us1fNSDLXtAcxl9+dGSptirXfipa4m59rrCkbvSKEZIkJ+VLpktNgnPOxWGjOEUWN5U7qNRzsjoBMbTkxT/Sn3NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144929; c=relaxed/simple;
	bh=oevji0E4Q5tyxcwlMJQ9MePak4Gq5tVdvvdnvHgY4k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDKcucEe5YUJVycr4WBNZWrEVqV3gtn78qFcgjEStMm4aFmmrvAPAsSfKnsMgUnegN++ob/MCyV70BOjUnD4nNxPrKgYTdSRM/4HouZEoRgOjlN2EfxKIUHq+zHWlGKzJzpYXXXDQ/8yHhLfplzMsdLQomA0TVz7pxlfCCh9UCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=O/boIG51; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.202] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57PI1Xa3635997
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 25 Aug 2025 11:01:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57PI1Xa3635997
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025082201; t=1756144894;
	bh=W16AtjCx1pojIgSKlaSQ3APF3nRLtq5Z+w4AEVQkU2o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O/boIG51xiQOva98NH9cgpYSaVopbylZ4ha9VKIokUnbK1LHwkg9F0ezZ5XaVptAb
	 NxF2p3Bh+fAIbIWRrNdaQpFaaY4gYQx9wLYfqZiBf+qko1WECdNPiBWcsOoXqJEigs
	 T5Cd+/uYsqxUnphf2rbnxGsp8OJ1wGrNEsemJGzi87I5/qHlWq5Y3BvxcngyjcfbjD
	 Q6z643r/i88ft5bp7Ylhy2O2fM4kW6h5A+XGSrRbld6GR8R4OGD1zaxO4GD2yWJehO
	 DQR/ZSba4ZrFUhF2Mq4EgaruE/ubfuE4U+pIkVyWrGhGvAOiad3j8VIJBvnJsQWKdZ
	 G3hDMNHE9e2yg==
Message-ID: <50f68d28-beb4-4dab-b077-e9e2ba1ae9ee@zytor.com>
Date: Mon, 25 Aug 2025 11:01:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/boot: clean up whitespace in a20.c
To: Harry Fellowes <harryfellowes1@gmail.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
References: <20250825174641.16030-1-harryfellowes1@gmail.com>
Content-Language: en-US
From: Xin Li <xin@zytor.com>
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20250825174641.16030-1-harryfellowes1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/2025 10:46 AM, Harry Fellowes wrote:
> Remove trailing whitespace and fix blank lines in arch/x86/boot/a20.c
> reported by checkpatch.pl.
> 
> No functional changes.
> 
> Signed-off-by: Harry Fellowes <harryfellowes1@gmail.com>
> ---
>   arch/x86/boot/a20.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/boot/a20.c b/arch/x86/boot/a20.c
> index a2b6b428922a..15bbd4ac55cc 100644
> --- a/arch/x86/boot/a20.c
> +++ b/arch/x86/boot/a20.c
> @@ -135,29 +135,29 @@ int enable_a20(void)
>   		  (legacy free, etc.) */
>   	       if (a20_test_short())
>   		       return 0;
> -	
> +

This is good.

>   	       /* Next, try the BIOS (INT 0x15, AX=0x2401) */
>   	       enable_a20_bios();
>   	       if (a20_test_short())
>   		       return 0;
> -	
> -	       /* Try enabling A20 through the keyboard controller */
> +
> +/* Try enabling A20 through the keyboard controller */

Why?  We do tabs at the beginning.

>   	       kbc_err = empty_8042();
>   
>   	       if (a20_test_short())
>   		       return 0; /* BIOS worked, but with delayed reaction */
> -	
> -	       if (!kbc_err) {
> +
> +if (!kbc_err) {

...

>   		       enable_a20_kbc();
>   		       if (a20_test_long())
>   			       return 0;
>   	       }
> -	
> -	       /* Finally, try enabling the "fast A20 gate" */
> +
> +/* Finally, try enabling the "fast A20 gate" */

...

>   	       enable_a20_fast();
>   	       if (a20_test_long())
>   		       return 0;
>          }
> -
> -       return -1;
> +
> +return -1;

Fix one but then add four, not a good deal.


>   }


