Return-Path: <linux-kernel+bounces-732399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A688B0663B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F7F4A1A63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0C517BA1;
	Tue, 15 Jul 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ma5jwMUo"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4862594BD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605122; cv=none; b=VY0KBvDSCFn2TxHTUXbLbnU4K753Z66KrePVLuYenUmVT2PRp/rQ680R/sNxIovU5HQUIFYYsVOfEBxFbV9MTldZid6A8cC2JDaNw0wvLHqHg3gxpCtgKQnfyHTOhOAfJA0iiOD4A/tTUjnqk3Rv+vHMXNCrIbIxpU30BRNQnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605122; c=relaxed/simple;
	bh=Lp8X8iS//QXadXp2OjuckD8RI9Ff2IynHRNUcrPj4oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFeaQIJMQ5Le3Ox+SBhsSTpRwdH2a4l8Bm77HFYM1zOPlchQRFCNF3UuRBEbEXan8oSvRcghcjVXegKU8PtC2VqBJmHe8bDw+Ws6SusMOCVBQEKb/lQUjm0z3uOUMH8DtbZ9WvMfum6HcR9rzCeJBPFXtwIUf0j+LXTNUSJIPrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ma5jwMUo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acb5ec407b1so1030922866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752605119; x=1753209919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+pV9pB7/V7BR/QvtNxKWFJjaLB2loX9Mg2hQZp2wDLo=;
        b=Ma5jwMUoC+3qoZ6+T0V2OYVRX7n05QwkjruGSog1a0VttNkHq+qOL7WZk3ECK1Bxct
         Fxi91mCxGHp9Jd2cNH/l7h1zN7xRLidEHjiCT2h8yoH+gypM/e3jONtpFUIYm59K1Eok
         GtDSPHMOMvtf+OZqj8firXtGt+5+PWBaEY9FaQcXKHqukoDgQEQON7I+1Ho2+WtJxBPR
         XAU8uoX6irAEMqPFQw1nKnPCYzXqKHcTUYCWI3nGdVzx+itvZuRdMFZ2DRqehM6TxPI8
         X0nG8UDtZGRlVFzWkOfLS4qLJ0MaNDa41Vyj4MHPEHm1JINRrkSXR4WLlyguLHlHWmMj
         oc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752605119; x=1753209919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pV9pB7/V7BR/QvtNxKWFJjaLB2loX9Mg2hQZp2wDLo=;
        b=ad3vsaR8JznIASL1X0ICa+t4hMYNbiB+S5GFJxX52wDDJtUUZhCKqJ6AJgpiVd/TRg
         8KTVm1N8iSOgvu9Vaap/qd8p7kQgMVa4KT8Uh5P/35YBAFy1Vuzb8ymoH3iFH9JtXFPl
         R8fX6lCseIdD+YuHi0orHsZLPwInS9YJYOHFSiGUsKVWu/6a22SAPVO8SmpR2oU7ibwt
         kObZahZfGNWhAynoE9Ui261k6S73+gKtooiF/1l1D2V1tOsnLt8C1c8MCkKdkadCSwNi
         ZiK/6ZjwQVn6a09tLL4gY2g9O7d21KxFEqL5i9q16pV30IdEkw07rkRYjWJ9/xNNVk9x
         4TOw==
X-Forwarded-Encrypted: i=1; AJvYcCX2x5C6tAVpjg3InLmG65/5wRCbwLgyXvw8wlanC4Xc+zlaoaeEzNowlrIMpztzhOQSHrwmJX9QF5YBZKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw6FdwHz03h7cqJW6NLxOp8SrgrWW9VhBra0NlP7inuU7dkkkF
	N1aI93ytzjnmF6GvsNqnUcwm/2fvucZQTMRFeROb8epU65Bbo8rLsbMoyBE1xBhGX6Q=
X-Gm-Gg: ASbGncurReBdhOBwNKNMm+k4Ab1Df9H6AzhPO8GPq/1PqagHLoJpLh2d/1XNG2R9c0l
	RpEWHC1JXOe8hvnlkl0lDdcOZEF+1UBhsiyfAKaUK2vpWElEB8Xxxa/fADp2n3xn2zhcQuGWGfl
	Xkz7CqjnMHm2rNh2N8tVrxZ4zPn8h+63h5L2OwBJ2AMstUSMlW3H/dhHWGcOKNqS91tpEBD1fjL
	Y7BaouA4bD4QZ2g2PMXB5MROyvzBEt/P+sfR+WDJSpZiyJG6iwGkVKuuqSD+RADyKN8llEobMsp
	Lgjv042jMJX91aTkmU8yz/ZSloskPcbn2wcPVV97n90Vdv8+rE5bvumNBqQ4EqwlSInywk/usMu
	FZOafy2v8C4t27APbob8OCps=
X-Google-Smtp-Source: AGHT+IEl3/6sArvJ8Cz8e50b4ECcD1aSlN1W0uIdstbJ+RqnRKNL0PIbbXyoDNvHxYjK5qSDJBlK5w==
X-Received: by 2002:a17:906:cae3:b0:ae3:163a:f69a with SMTP id a640c23a62f3a-ae9c9b19656mr49900666b.33.1752605118859;
        Tue, 15 Jul 2025 11:45:18 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.209.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82652b9sm1054888166b.78.2025.07.15.11.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 11:45:18 -0700 (PDT)
Message-ID: <61ad89f2-543a-46ba-881c-baf81299c5b8@suse.com>
Date: Tue, 15 Jul 2025 21:45:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/boot: Avoid writing to cr4 twice in startup_64()
To: Khalid Ali <khaliidcaliy@gmail.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, ardb@kernel.org, ubizjak@gmail.com,
 brgerst@gmail.com, linux-kernel@vger.kernel.org
References: <20250715181709.1040-1-khaliidcaliy@gmail.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20250715181709.1040-1-khaliidcaliy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.07.25 г. 21:16 ч., Khalid Ali wrote:
> From: Khalid Ali <khaliidcaliy@gmail.com>
> 
> When Initializing cr4 bit PSE and PGE, cr4 is written twice for	
> each bit. This is redundancy.
> 
> Instead, set both bits first and write CR4 once, avoiding redundant
> writes. This makes consistent with cr0 writes, which is set bits and
> write once.
> 
> Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
> ---
>   arch/x86/kernel/head_64.S | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 4390a28f7dad..dfb5390e5c9a 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -222,12 +222,9 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
>   
>   	/* Even if ignored in long mode, set PSE uniformly on all logical CPUs. */
>   	btsl	$X86_CR4_PSE_BIT, %ecx
> -	movq	%rcx, %cr4
> -
> -	/*
> -	 * Set CR4.PGE to re-enable global translations.
> -	 */
> +	/* Set CR4.PGE to re-enable global translations. */
>   	btsl	$X86_CR4_PGE_BIT, %ecx
> +	
>   	movq	%rcx, %cr4
>   
>   #ifdef CONFIG_SMP


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

