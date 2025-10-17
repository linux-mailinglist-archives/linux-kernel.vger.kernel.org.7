Return-Path: <linux-kernel+bounces-858282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 400A4BE9957
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B97BA35D15F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0FD2F692B;
	Fri, 17 Oct 2025 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WRGG8VsL"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998D8337112
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714017; cv=none; b=iJcE1RfSGJWXOBJF3TansyBBTLhh73EJXmBpC0fxV+oSpcrb/tFe1zAHB9YHpdtUyHPgO09CEADm9khIJ6tP25zDmlhrpTIDxp7u8bi7A/PR8F4OmeimiGoX4lYUIMqNTLxIwvCn9SBNCvwGggwdGlRRandhCrv0yYWtTaeKuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714017; c=relaxed/simple;
	bh=giNbJg6fQci1ggj093iRNITcX3JLQrm3IigJqYtGpNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mi9Bf6yC2crkXQM/N+wAet97Lhtez+HlISn/LmT1J1XqQ29EP+5ggvhprAsTEqEt3UAmZWX6IwlEBK/631D0Y4CkuMGKkTxo4L8dXWAg8oLge58XIYc89f5GmETi3IV8gVO67myBMuhxjczGpelpF3+re6xpjPjEBCNooNoajlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WRGG8VsL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47114a40161so20502785e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760714014; x=1761318814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zAqRSzJq3nW7dmbcqoRXO+cq6eesO6HDoZRngQ9qdT0=;
        b=WRGG8VsLA+pWEVtdHDyewAyQkuH37nD217+mNVCEWwdlJyp3XJ5rt1AoBraY16252W
         38l5xlq3POQ8RAqPTO/vkGWaDIIjIwGmN4TAqfnPPbBL+cgMITYKYhwVfm9kjYYWh9N1
         avkFW5hmT10/XFOpJjP9klTge3fN6S5X3wa2R2CarUnDWMd43DrI4kQ42rhKSo6gUuuO
         dT4ps0uRwP3TPQA404DaBX3NavPvbcrPsqFaWOGIiTsqmSMOupYIzki/VUGIN647Q7nv
         U/fhmCtW/WfZ0yfl/R1L7j13HT4GDGtuRhHee8GnPIKv3vGFiSGGlZPh8w3HQ7qLqvxi
         O5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760714014; x=1761318814;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAqRSzJq3nW7dmbcqoRXO+cq6eesO6HDoZRngQ9qdT0=;
        b=MF3FvGKfmlMXY/utH68l3zheuOh9W4RObkx6x8mdFi75JqTf7NMgk8Yw22rcgL3b6N
         0/wogsa4gsfh1bu5zP5HjuztME9uTEo6+ySAgLzyBge5zB5DguAYvSbE3KDRtUaPbwu4
         yfD4V9rC16GTOq5rfQDRPvkwtz/2Mx/42s8BktK9CtXoTIwTeI8laUdwDqwkImHUxKoi
         75yDrg/qcCHTYzTH+4Wi642BANF5HuYiFEr6YitGc+V/vkIzjYNt4w1dWfOht3dCXyMH
         lrwjxOftQBW8xCRilBuwB7ugKmvKVtPVxfG8x/XuCBHqXTHongt34nuN2jqEtpM0ObA2
         AGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN+5JA0YKm0C4JaNh2wOvKFkELvn3LEDTTF+c9J3HfHu5TcVgB3VuoMEIOca0FtlKe7YXSAKA7okQ3yA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwscDuQ7NejGjxCjhzFht5/zMVoACcJcLvmQxFUHLVIjgcSIl0z
	oFrtEfRGVP6kFMj6irLPxZTa80z019t7+6uixRWLMRkEZyuOXKQmf39uXroKoAl78+k=
X-Gm-Gg: ASbGncvVbzTqZs4saQ0eHRvQd3zfsObv9+8rL8Nyvi3nJnVo4us3S5RCw3DPgbc9e7v
	Les7LjkxEcUjNstS5fU/W0YWLcEVFkv4kVXU5uonJCMe5p4OJPFAvk33306vBoRkqseCyerDf73
	bP7G1e+2O26iltTVy+j/k9XwVWsHQlkTrKO9aa/dPNoxIK2rWGqihYUAX4SZU1VIlc+rtb4WIET
	tA5gpRMl7vjUTtLQnOHkctf8VIEuPPtC851gf0SmFVPx8uivVVB2yh23J34f2VrUyJ2utpRNFQh
	TS8nptasJJyxWDmveNGF9Iu9sK52cwNVnS5gOlfZn7lyOWP5J903pQuYIlFxiP9RnGlIh66HLdM
	F+/M00H4TvlTCzmb2v/iZFmbl0am74ILTO2i9Yu2GhK2Qrpj9WFB0NCJDhMtV0V7S/ZVPnzX5G5
	439JD1UF+5IDXCD5rgIBUeSazZIXwUXRSwJZoOJQ==
X-Google-Smtp-Source: AGHT+IEZr89WG9t9OZyL37lU4AQbgkUjLhOy4o+GbkY+fEnEvobO180kf4++0OZHlxwfDq/kBvXvTg==
X-Received: by 2002:a05:600c:5009:b0:46e:50ce:a353 with SMTP id 5b1f17b1804b1-471178788f0mr27511195e9.14.1760714013781;
        Fri, 17 Oct 2025 08:13:33 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c34sm95442415e9.10.2025.10.17.08.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 08:13:33 -0700 (PDT)
Message-ID: <1c73c8b2-02ad-44ab-ba9b-44b12f3e09fd@suse.com>
Date: Fri, 17 Oct 2025 18:13:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/56] x86/bugs: Reset SSB mitigations
To: David Kaplan <david.kaplan@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Graf <graf@amazon.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-9-david.kaplan@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20251013143444.3999-9-david.kaplan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/25 17:33, David Kaplan wrote:
> Add function to reset SSB mitigations back to their boot-time defaults.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>   arch/x86/kernel/cpu/bugs.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 4ca46f58e384..cc7b1b67d22d 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -380,6 +380,16 @@ static void x86_amd_ssb_disable(void)
>   		wrmsrq(MSR_AMD64_LS_CFG, msrval);
>   }
>   
> +static void x86_amd_ssb_enable(void)
> +{
> +	u64 msrval = x86_amd_ls_cfg_base;
> +
> +	if (boot_cpu_has(X86_FEATURE_VIRT_SSBD))
> +		wrmsrl(MSR_AMD64_VIRT_SPEC_CTRL, 0);
> +	else if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
> +		wrmsrl(MSR_AMD64_LS_CFG, msrval);

nit: No need for the local msrval variable, just pass x86_amd_ls_cfg_base.

> +}
> +
>   #undef pr_fmt
>   #define pr_fmt(fmt)	"MDS: " fmt
>   
> @@ -2672,6 +2682,17 @@ static void __init ssb_apply_mitigation(void)
>   	}
>   }
>   
> +#ifdef CONFIG_DYNAMIC_MITIGATIONS
> +static void ssb_reset_mitigation(void)
> +{
> +	setup_clear_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
> +	x86_spec_ctrl_base &= ~SPEC_CTRL_SSBD;
> +	nossb = false;
> +	ssb_mode = IS_ENABLED(CONFIG_MITIGATION_SSB) ?
> +		SPEC_STORE_BYPASS_AUTO : SPEC_STORE_BYPASS_NONE;
> +}
> +#endif
> +
>   #undef pr_fmt
>   #define pr_fmt(fmt)     "Speculation prctl: " fmt
>   
> @@ -2916,6 +2937,8 @@ void x86_spec_ctrl_setup_ap(void)
>   
>   	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
>   		x86_amd_ssb_disable();
> +	else
> +		x86_amd_ssb_enable();

Does it mean SSB hasn't been working correctly up until now since 
_enable function has been missing?

<snip>

