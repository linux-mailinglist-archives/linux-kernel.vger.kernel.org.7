Return-Path: <linux-kernel+bounces-871404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39189C0D26C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A89654EC78D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCF629B8DC;
	Mon, 27 Oct 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PbDe90Fo"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D304438B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564685; cv=none; b=qtmHFKrskiHKsts22+RoC1cJFaWlxgFKL44ygRg85KixPA7fANXyd+fWxQpYTswFtuDPqoaU5IWHklYday20z6WxKiDLkQQW8XXOsrJLuHi8MatM4EwxxkDzKhZxRKfOqVut13bRt2TrKgRWwZ42RzthlHDe+QgRn/t0SRM4F/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564685; c=relaxed/simple;
	bh=BJ8Pv5X0OaLgGBVGx2SMuWEQLfEPYiev4P8bkf4oXUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odoh4CEudbJL/cjbzjYV7yf1aXAbjhI6WqD7JoGQFYPU2Xu/2jUek5l7Qf5GKJwWp46vL4n8/b/l3de1I94+Lye2Gm+FuI90ydxEJQZlkx5ranIKdaWMxrnDBTR1T/JxPRK+UqPUT9lpzrSC1rpbllFSYctjVR/rZxayljedai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PbDe90Fo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4711f3c386eso34217215e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761564681; x=1762169481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XPaq6cxeFxQm6lh9mdW+gXBrhE5f3bPtB2RAParXU/0=;
        b=PbDe90Foqiqr0+f40gv4jrvdRDq6PLY9wA094kkTL1oqwUWrCumuX/ED2qoAkU6yyY
         0GWUyfZW8/gVDn9f8WYYnYA8mHeElhPy/bymLLTkHbGGn3RtvdWfhuZtWNLswkrulyUZ
         qPwrGFqRnZth2y1AzGBDLJgthqg8IPutSyyE6DVMLBzitDyTz/q3yoXPjgA7wY2eooTQ
         7SGGuagWNjpQRLrO4w9FUWhVltkx/emUTgsbjH/JI7MWzFmYPDV0zCtsB9KwCQfzkBQy
         BRbbRsv4APm6aX1iEbKslHSknM4MTwfJhtP7ZC3RZ0mPF+ARNNB6aPQJRceO3kDApA7V
         BPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761564681; x=1762169481;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPaq6cxeFxQm6lh9mdW+gXBrhE5f3bPtB2RAParXU/0=;
        b=ftIWpEVlR10jGp6XOuBqShflrTGGej9yoarEebBUPQzO/GVx8IlHrQxBMPcPGTlXyX
         WICgHJGyO75KBoxHZxpRyo3oOkE3pNA/7FrGKTOfm1QrqBG31p+XnNj/fY7lp6UDy8xa
         ehvrrpy/qoVcpaEtmAXiNQ5tcEUOrCP/6pdz4oST3dX9GaN1Q/ifi9eUxcEDUkZBLENS
         YALfpD2A2eB4jAdOZmT7NdpaSpMeAzfyACFVV85iOBjcLhSrCVFmrlK3lTDFle7YtATH
         4WwrJxv7OcEFns8SS4gAnWRCC00meLQFQQf73VDTpJ2blfPdt18Thu/E1c1WWb2DIb/D
         fsUA==
X-Forwarded-Encrypted: i=1; AJvYcCXE2EZfCGaYHg623bQAZLjDZRtdrjXZoewQEdOxDlP2IqOxmJ/lLY/bx0AOnFsHa1BgncoLL8f5yOTEw84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/6egZICqeCUGJLqPjoU/kz8o4uASjeTiyK+9oCtx1253XdKy
	ZaFfbor362YVwXwuj7u5Z3C34a/vPCyEXyi05SrqNkXioNtr0t9WcQl0Wh5U+Kfi6iI=
X-Gm-Gg: ASbGnctC/OzDm/8hiDyu/wFP475lNFGMQnCm1kiUSsRozg0EYiR8LrKurmBJUvv/DO3
	KAB7c2wZNQxpsmyB3kqN20wTljDgy85iGAbK8ayufO9xGCEz+TAki76aRCFDu6MLewno83+pz9e
	aeqVSVt/UC4PLXtvfGs+YG2XXbakimcsKW0EGWWKleIPVfd68PdJ+E63+lYGAkrOEMceLABVaUz
	k0+hjnf6IA2ImivKRgyJS3u90Hm0ttJFdwlHACosGuCOk5rgBXXu4Srk2sj8KvibJLP9dtVctHE
	rMSd3ZG5a/LxQRYPruHOjCjM2gt3ndsv0UYVBpnwM2XNn7tvjthlmJa5W+28gboBfQVAdmO5eb3
	Ew4iBTNW5h0WitRX4Oo8iSan3rusGoLkV892W0VXDOx/W2r5HoK02IVP+IwdE5fPZzXC+wktmrX
	o7QnM+JtGDmEHev8TtGs/JyxOp/gF0P/vpDhRhr3hO+igj67Ta
X-Google-Smtp-Source: AGHT+IEjIICk8/yoxusCPc0p/b1UuM0TXk8ogSXpvg2+HWTR8GiEv4RJxrp6+Cw3SSVZr/ZjGz0vDw==
X-Received: by 2002:a05:600c:c171:b0:476:651d:27e6 with SMTP id 5b1f17b1804b1-476651d2868mr55602975e9.36.1761564681124;
        Mon, 27 Oct 2025 04:31:21 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd47853csm133380895e9.13.2025.10.27.04.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 04:31:20 -0700 (PDT)
Message-ID: <23c26b13-f195-4363-bfc1-92282459f1bb@suse.com>
Date: Mon, 27 Oct 2025 13:31:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 52/56] x86/bugs: Support parsing mitigation options
To: David Kaplan <david.kaplan@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: Alexander Graf <graf@amazon.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel@vger.kernel.org
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-53-david.kaplan@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20251013143444.3999-53-david.kaplan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/25 17:34, David Kaplan wrote:
> Add arch-specific function for determining if an option is related to a
> mitigation and parsing it.  These will be used for parsing a string of
> options for re-evaluating cpu mitigations.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>   arch/x86/include/asm/bugs.h |  2 ++
>   arch/x86/kernel/cpu/bugs.c  | 56 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 58 insertions(+)
> 
> diff --git a/arch/x86/include/asm/bugs.h b/arch/x86/include/asm/bugs.h
> index 2e1a7d282e51..1e142a676335 100644
> --- a/arch/x86/include/asm/bugs.h
> +++ b/arch/x86/include/asm/bugs.h
> @@ -13,5 +13,7 @@ static inline int ppro_with_ram_bug(void) { return 0; }
>   extern void cpu_bugs_smt_update(void);
>   void arch_cpu_reset_mitigations(void);
>   void cpu_bugs_update_speculation_msrs(void);
> +bool arch_is_mitigation_opt(char *param);
> +int arch_parse_mitigation_opt(char *param, char *val);
>   
>   #endif /* _ASM_X86_BUGS_H */
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 2f82261d033d..26ceb42e0cfb 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -3991,6 +3991,62 @@ void __warn_thunk(void)
>   }
>   
>   #ifdef CONFIG_DYNAMIC_MITIGATIONS
> +struct mitigation_info {
> +	char *param;
> +	int (*parse)(char *str);
> +};
> +
> +static struct mitigation_info mitigation_parsers[] = {
> +	{"mds", mds_cmdline},
> +	{"tsx_async_abort", tsx_async_abort_parse_cmdline},
> +	{"mmio_stale_data", mmio_stale_data_parse_cmdline},
> +	{"reg_file_data_sampling", rfds_parse_cmdline},
> +	{"srbds", srbds_parse_cmdline},
> +	{"gather_data_sampling", gds_parse_cmdline},
> +	{"nospectre_v1", nospectre_v1_cmdline},
> +	{"retbleed", retbleed_parse_cmdline},
> +	{"indirect_target_selection", its_parse_cmdline},
> +	{"spectre_v2_user", spectre_v2_user_parse_cmdline},
> +	{"nospectre_v2", nospectre_v2_parse_cmdline},
> +	{"spectre_v2", spectre_v2_parse_cmdline},
> +	{"spectre_bhi", spectre_bhi_parse_cmdline},
> +	{"nospec_store_bypass_disable", nossb_parse_cmdline},
> +	{"spec_store_bypass_disable", ssb_parse_cmdline},
> +	{"l1tf", l1tf_cmdline},
> +	{"spec_rstack_overflow", srso_parse_cmdline},
> +	{"tsa", tsa_parse_cmdline},
> +	{"vmscape", vmscape_parse_cmdline}
> +};
> +
> +static struct mitigation_info *get_mitigation_info(char *param)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mitigation_parsers); i++) {
> +		if (parameq(param, mitigation_parsers[i].param))
> +			return &mitigation_parsers[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +bool arch_is_mitigation_opt(char *param)
> +{
> +	return get_mitigation_info(param);

nit: This has an implied conversion from a pointer to a bool, should it 
be return get_mitigation_info != NULL

It would work either ways but being explicit is better?

> +}
> +
> +int arch_parse_mitigation_opt(char *param, char *val)
> +{
> +	struct mitigation_info *info = get_mitigation_info(param);
> +
> +	if (!info) {
> +		pr_warn("Ignoring non-mitigation option %s\n", param);

nit: Do we want to be that verbose?

> +		return 0;
> +	}
> +
> +	return info->parse(val);
> +}
> +
>   void arch_cpu_reset_mitigations(void)
>   {
>   	spectre_v1_reset_mitigation();


