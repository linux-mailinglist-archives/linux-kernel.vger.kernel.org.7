Return-Path: <linux-kernel+bounces-668018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D7CAC8CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 13:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7861C0009A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39A321FF22;
	Fri, 30 May 2025 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ub4tqPOS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C50374D1;
	Fri, 30 May 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603831; cv=none; b=s8ZzHD7kLHUmxVvIuBl4uei2wMHj2WyesMHAMu/LT4zUlz4FLRG4LOsPg3YuwfnxyhZIwUIt/u9AC/BgCByiVAs5p3ro1pNWfIyShxomRi6eSch0DBX4ctLF2G4AoPdt4jKwqb9XnVSpzUJREMF9ed4dTZl6VSswm83u2TaUg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603831; c=relaxed/simple;
	bh=q29bzwk69xJGsp+snWqF7VSlkCsPgkVSbEQVYtdjF1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eED6uvm3Hf4EITXAN/11BRzuQiLR3CnyW6Yv3Vi78qHIUrAQ195FtOzlPA3doG4eMUahjI2fMwmP5Y7MqCzjpzWppXZDTgJ+f7anxqAT7kZfmhKMxBGK/X6s9P9UfO4umry+C1Kk7tDu6M35nlrRkA1bWZXEMZCFX4ldiVZOYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ub4tqPOS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D8DF840E01A8;
	Fri, 30 May 2025 11:17:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id X3A_6v7cukEa; Fri, 30 May 2025 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748603820; bh=kDWmnRvHUCItuhvHdDEViZU/241goO0alVdG+41ptlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ub4tqPOS4S9GJyioHz472TThyxGN38nZmFoM1OXIEtJBRSBogDeWlXWFh3JQPhO6U
	 BuKLSM/IOylLcu0oBPQpciGilfZ3rHMkmAt2TNHlioz1MomKxGk/RzDloyUByI5xcC
	 p7rh5mEeUmFzS112GN3hiPWRj6FtHiWz2RspAntI0Iu4DjraLmLu0y46Hrmgab2/og
	 CaGTVlf1KcBdoVWqCeLW0C0GMo6nOBP9pqikMiHvqQMVnfr+eTX58SMBgCRXyx6DoA
	 q5WAAych4ehdgEGDFE3Vs2telmwF8fmiF++elGAFtmM2iZGTmELKFEta7gVLdwGz/2
	 SGrHE+6ZXOkTN8XtDwZEpAVVUH03BCi9oKCEutrwef/If0CoENC9ylrdRdHuVNCbB6
	 i0SdI/evjL0YnSUcSIuE+EIkQEmRl7WfV7k1F54RkGsK92P4qPji91CcveIiEaqEmR
	 pkWYwl/OLbJYIaE446VEqH/WBzdW6YIQMPKOedNsN4O8SEE6MS0/bVPafbVpaOsI1X
	 tY4fkna0KK0XmC8F14EGXO82aq2RTTBDImbUVzAEfIB2AWtA2qO49x+/oUUu8FXSFy
	 zm8+kmV2agN6oAOjFJiFBgV1r4vcW2OWF57off8MXwRQpVe97k1p6gGuVbzIXVCgjx
	 oUvwySW0zDzin8fJmae1SwwE=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B466C40E015E;
	Fri, 30 May 2025 11:16:51 +0000 (UTC)
Date: Fri, 30 May 2025 13:16:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFT PATCH v3 12/21] x86/sev: Unify SEV-SNP hypervisor feature
 check
Message-ID: <20250530111645.GAaDmTneZG7KOX0ApR@fat_crate.local>
References: <20250512190834.332684-23-ardb+git@google.com>
 <20250512190834.332684-35-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512190834.332684-35-ardb+git@google.com>

On Mon, May 12, 2025 at 09:08:47PM +0200, Ard Biesheuvel wrote:
> diff --git a/arch/x86/boot/startup/sev-shared.c b/arch/x86/boot/startup/sev-shared.c
> index 70ad9a0aa023..560985ef8df6 100644
> --- a/arch/x86/boot/startup/sev-shared.c
> +++ b/arch/x86/boot/startup/sev-shared.c
> @@ -66,16 +66,10 @@ sev_es_terminate(unsigned int set, unsigned int reason)
>  		asm volatile("hlt\n" : : : "memory");
>  }
>  
> -/*
> - * The hypervisor features are available from GHCB version 2 onward.
> - */
> -u64 get_hv_features(void)
> +static u64 __head get_hv_features(void)
>  {
>  	u64 val;
>  
> -	if (ghcb_version < 2)
> -		return 0;

Why?

> -
>  	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
>  	VMGEXIT();
>  
> @@ -86,6 +80,31 @@ u64 get_hv_features(void)
>  	return GHCB_MSR_HV_FT_RESP_VAL(val);
>  }
>  
> +u64 __head snp_check_hv_features(void)
> +{
> +	/*
> +	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
> +	 * features.
> +	 */
> +	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED) {
> +		u64 hv_features;
> +
> +		hv_features = get_hv_features();
> +		if (!(hv_features & GHCB_HV_FT_SNP))
> +			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> +
> +		/*
> +		 * Running at VMPL0 is required unless an SVSM is present and
> +		 * the hypervisor supports the required SVSM GHCB events.
> +		 */
> +		if (snp_vmpl > 0 && !(hv_features & GHCB_HV_FT_SNP_MULTI_VMPL))
> +			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
> +
> +		return hv_features;
> +	}
> +	return 0;
> +}
> +
>  int svsm_perform_msr_protocol(struct svsm_call *call)
>  {
>  	u8 pending = 0;
> diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
> index 753cd2094080..0ae04e333f51 100644
> --- a/arch/x86/boot/startup/sme.c
> +++ b/arch/x86/boot/startup/sme.c
> @@ -533,6 +533,8 @@ void __head sme_enable(struct boot_params *bp)
>  	if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
>  		snp_abort();
>  
> +	sev_hv_features = snp_check_hv_features();

Is this writing the sev_hv_features declared in

arch/x86/boot/startup/sev-startup.c

?

arch/x86/boot/startup/sev-startup.c:45:u64 sev_hv_features __ro_after_init;
arch/x86/boot/startup/sme.c:536:        sev_hv_features = snp_check_hv_features();
arch/x86/coco/sev/core.c:980:   if (!(sev_hv_features & GHCB_HV_FT_SNP_AP_CREATION))
arch/x86/include/asm/sev-internal.h:5:extern u64 sev_hv_features;
arch/x86/include/asm/sev.h:428:extern u64 sev_hv_features;

I'm confused.

If sev_hv_features is startup code, why isn't it accessed this way...?

/me goes and looks forward in the set...

oh my, that is coming.

> +
>  	/* Check if memory encryption is enabled */
>  	if (feature_mask == AMD_SME_BIT) {
>  		if (!(bp->hdr.xloadflags & XLF_MEM_ENCRYPTION))
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index fa7fdd11a45b..fc4f6f188d42 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1264,17 +1264,6 @@ void __init sev_es_init_vc_handling(void)
>  	if (!sev_es_check_cpu_features())
>  		panic("SEV-ES CPU Features missing");
>  
> -	/*
> -	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
> -	 * features.
> -	 */
> -	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> -		sev_hv_features = get_hv_features();
> -
> -		if (!(sev_hv_features & GHCB_HV_FT_SNP))
> -			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
> -	}

I guess we would've terminated earlier anyway so that's probably ok...

> -
>  	/* Initialize per-cpu GHCB pages */
>  	for_each_possible_cpu(cpu) {
>  		alloc_runtime_data(cpu);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

