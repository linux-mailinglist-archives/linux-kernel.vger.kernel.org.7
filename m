Return-Path: <linux-kernel+bounces-812307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A497B535FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5095DA04B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AEC340D9B;
	Thu, 11 Sep 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IJrjlpFx"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1796340DB7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601795; cv=none; b=GdJ6xYmMF62bLUop5vH4lIR/VZ8gWk1R7mUJOSYIMGXri7pbqNhRvDOf2jdYu6oMK5l/NYwnVMIqL0pElQfTqbr2T9F68Z9NgswHCxKVXfklWsiphvB5LkgWm1nnp0ugox+vzOmcyIdNUKEVLv6IM+vqRnglL25OJJsNo41Tmes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601795; c=relaxed/simple;
	bh=V6FD0d3JgbZXKHC+xUSTnDcPYnDX6VNwyniSodQFA3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaBfvotPHuv2xsggVErFBLtQC0b0ihaYy9oUoXNojI4x6NF3k1FsNeopzk1qKzCcJJci7odtllu126efbtWZ1T74jwZlvAyg5fxCz3SPCJUQ0sC0lfDMAbVWjVgTB2+Ie/PRbX0SPCVbbiYBIZV63OM3rV1fSa6I4WvBgOhfGcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IJrjlpFx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45de56a042dso5545825e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757601791; x=1758206591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nL/0YN+s3DP2N6NxTAsYAkeIEs7a8heXoKnclmsN4gg=;
        b=IJrjlpFxYt2+GHGiWozBj+4rTCQdLjp55QlaVqhsUeLS4s+0MrZ3LTQ6V0rmGSlofP
         zgocB073IQrdWJ5wQe2+t9ZVyV4UKGxI+sYlOhf1ctkXx/3+excOTf7cKweJFcESNCCT
         njwEMKE2lE2A/n7UjVwjTpA2jMs2fWOWL20p9yLbcd2u/LRJG4qUJuRwM8kquwjbi/GT
         S2B5GqA0JqbGHIycVQtpAoMktJ07bd2dH0J5GTXdw/xpl+6SgHWj2rIuqZadoIgoLTCa
         ym5uyUS7Ex+HAGhjcflcqen2rxuBOyuufstxDGdnd4/NEcjDLpQjGRLdmZKisHPKA4Gr
         Y5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601791; x=1758206591;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nL/0YN+s3DP2N6NxTAsYAkeIEs7a8heXoKnclmsN4gg=;
        b=bOAFPNO0jCQcKIZKbvabNMrCmv7wRp9o0iPMd9xAY5Hs1kWFOpcDAI+MOqYzEC00da
         0ocVABF43uYJB6SKT9nnf8YS9+GHvm+2Ks+nVPhes6TNeH/nrBetQmi/h7zgQVX9lQ7e
         dpzuwDb0nzp5hm919lhNVAc1TW2LM5stRxu9Csu7jS3HVUzlJanL8IDcqJGj5k5E4q3w
         myAJX0jc8d81nW4IIi2nXWpL95TJxqriDLc4i2VOjA3h6Y/QmHSsD9csYdSsE53L8DtZ
         /5s8QMtGK79w0VPT3H3bk7jC7AvWAaR7oQlqoZoi8to3WfIoLUFmn2Hg319KDDxKHBc4
         x9ig==
X-Gm-Message-State: AOJu0YyWqO3QPDDAX+57REVbxFMCMoGj6kOlh0kZHXHiFK+HVIVbp+gt
	4aEJVFAyM4tMo+DEKQxnjpI2xsBxanU8vgC/f5kmIkv1s/TWZb3JS9ctU3EPjinjlGs=
X-Gm-Gg: ASbGncs91job5oEXu3sG4aTDg31TKwzTZTYIj4bME9svyskEGWProNKXDETisYbmuMl
	jZvCgy3kV0BEO5gf5WA4IGwCZqMNYhsZJmu8J6f4S4gmJLV/qqRb6N260KXgTLYwEUojDoLq0il
	y6yhSMPWW6YjA9LHUiUsA6/JwdGHfGcq0IW+ProU1UBFYZco0XgskBpv/d0+Ma6xjBhHCyheyty
	8QcCFFJM1AIOgPNn7mYwBFZNfFfpRVJbaUjzoLJScwh19fRkpldO8hmtemZDMFpHN9YFhICtglF
	yPPmxcHMv4HGDyB7lLbhgoIWb275g7MdhOUIpxZHyDmh4RVMav9Hr+5kCgXQraW/ZRw031WDrrN
	qhdE9CYkeU+OX3V5pm70vtsRFxvSWVpW6rYC/tWH8EqD0dw==
X-Google-Smtp-Source: AGHT+IFzH+V8s0sYRpmkvChDZV6cgGCwMXzJuS0qZEWWciIhM/GLC66m7Zo+tfDPNhyBgLig/B9WtQ==
X-Received: by 2002:a05:6000:430c:b0:3e7:632a:f3fe with SMTP id ffacd0b85a97d-3e7632af44bmr1679160f8f.61.1757601791055;
        Thu, 11 Sep 2025 07:43:11 -0700 (PDT)
Received: from [10.20.0.214] (ivokam.ddns.nbis.net. [109.121.139.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d7affsm2876729f8f.48.2025.09.11.07.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 07:43:10 -0700 (PDT)
Message-ID: <e85965a9-3aa5-4368-95bc-c46ab18a25fa@suse.com>
Date: Thu, 11 Sep 2025 17:42:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/15] x86/mce/amd: Remove redundant reset_block()
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-12-eef5d6c74b9c@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250908-wip-mca-updates-v6-12-eef5d6c74b9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8.09.25 г. 18:40 ч., Yazen Ghannam wrote:
> Many of the checks in reset_block() are done again in the block reset
> function. So drop the redundant checks.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>


> ---
> 
> Notes:
>      Link:
>      https://lore.kernel.org/r/20250825-wip-mca-updates-v5-17-865768a2eef8@amd.com
>      
>      v5->v6:
>      * No change.
>      
>      v4->v5:
>      * No change.
>      
>      v3->v4:
>      * New in v4.
> 
>   arch/x86/kernel/cpu/mce/amd.c | 28 +++++++---------------------
>   1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 34268940c88a..9ca4079ff342 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -812,29 +812,11 @@ static void amd_deferred_error_interrupt(void)
>   	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
>   }
>   
> -static void reset_block(struct threshold_block *block)
> -{
> -	struct thresh_restart tr;
> -	u32 low = 0, high = 0;
> -
> -	if (!block)
> -		return;
> -
> -	if (rdmsr_safe(block->address, &low, &high))
> -		return;


This is being replaced by rdmsr, I guess it's safe because the fact we 
are processing a block which has been on the bank list means it's 
unlikely the rdmsr will fault.


> -
> -	if (!(high & MASK_OVERFLOW_HI))
> -		return;

nit: However, now, if mask overflow is not set a write to the msr will 
be performed, with the effect that IntType is going to be cleared (hi &= 
~MASK_INT_TYPE_HI; in threshold_restart_block), and MASK_COUNT_EN_HI 
will be set, that's different than the existing code, albeit it might be 
ok.
> -
> -	memset(&tr, 0, sizeof(tr));
> -	tr.b = block;
> -	threshold_restart_block(&tr);
> -}
> -
>   static void amd_reset_thr_limit(unsigned int bank)
>   {
>   	struct threshold_bank **bp = this_cpu_read(threshold_banks);
>   	struct threshold_block *block, *tmp;
> +	struct thresh_restart tr;
>   
>   	/*
>   	 * Validate that the threshold bank has been initialized already. The
> @@ -844,8 +826,12 @@ static void amd_reset_thr_limit(unsigned int bank)
>   	if (!bp || !bp[bank])
>   		return;
>   
> -	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj)
> -		reset_block(block);
> +	memset(&tr, 0, sizeof(tr));
> +
> +	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj) {
> +		tr.b = block;
> +		threshold_restart_block(&tr);
> +	}
>   }
>   
>   /*
> 


