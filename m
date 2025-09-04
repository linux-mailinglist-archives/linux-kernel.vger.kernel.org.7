Return-Path: <linux-kernel+bounces-800730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC61FB43B44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EAB177BC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764452D7DCD;
	Thu,  4 Sep 2025 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XSBcXVvk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674B2D0C9A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988015; cv=none; b=Hu+Rf3/NNfLQlNbHcjNtQAYq2j/CSm/Et6VXsAlrQgAHwLxHbYe7dqPwe+lilBMilM191lucDY6PyNHly2iqe+oLT4CXTxE+iKflk3DkRvlfv3AP0jtxlklG9gUtHliWJgBMBuedGpJ7eGZtRlc9wUPr9ekrEFjeLTnTxvAAwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988015; c=relaxed/simple;
	bh=dGaxnwDc1UTsfN5tgg40DErGoAILkqkBdGg9Q5eHUVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXpoX3ebUUilWTUc1NgLpTgY82b7TUjtccNczPtdgELi/eev+6SB4OjkJuhpzQ2pWOgr2mLDX2DoMi0WXL7an+fT6QL5mw6KX/F1OZ8nzQggaQn68/baP0QVpg0jtWyZQCXZ53tlnU3bhQ6SQNRg8Ta+k+b7tXOj9RTWeCiGBj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XSBcXVvk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A8D1840E01BB;
	Thu,  4 Sep 2025 12:13:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id X5Lfc-Z7aB7y; Thu,  4 Sep 2025 12:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756988007; bh=HwImBea0Pxd9tUsfNJTSFd6GGaQnM6wbr1zT9zpJBSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XSBcXVvkFmoPCNF1FMBpZWuDS7uTBwpL3WlRpb3eOnjQ9P/8NOjJu6Ing6L5mI9+f
	 6wXxzDBpbA5p/N4RymAtuzixzsEIOXgMCyUozYfojrdGttRJhgzhKCSCoVp2BZOiaE
	 WgWQeL0Wyifpu1tKvgTTK/bO29ik7/OOTSdirAjDTjasIIm+zp/bS8dXPLDV7j9I2V
	 VYs3qXcwx4St+lNKbn87L5BE/JtcmyuY84Pgcgd3gQpUJgcemsqRpx3MsbkRh3LpoU
	 dH9/s3CxrCmZJjB260BN4TQjyrkKRM1pF+3O7Q1vPmKr76Azruh3OgQEi3pZU1qoa0
	 WQX8+SPSePhBIOLmWciFoAh0vIr5HJbdsHiiIuI6jKHmnSxZy+yyt6WvlVCp2K1eBm
	 djZT+0tppyeLEnJGiaKeucduavAvL4Ql4cCQGit2ThGZG3lYG2IaX7BMyqTJDQxnXI
	 okKBzPOzLHk8oTDWse+Rx71rfkRK85A6mK1gvrG9IdJieOUyr4MelkK64pMBEqX+S8
	 p7T8XFcQhx81xAUcG2tAyP32xIV3phSZd0tNJ2p4TYqStQBsOKQUlchRp0UW9QAA+1
	 wtvoCCha/b159RjELTV2FXwbKIK/M0TqyypNdBSMO7c16FNJQzTnJmEghAGLIb6Sz6
	 1GOUecnRmpN9EMzCBzfUPsxc=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 502B740E00DA;
	Thu,  4 Sep 2025 12:13:19 +0000 (UTC)
Date: Thu, 4 Sep 2025 14:13:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, chao.gao@intel.com,
	abusse@amazon.de
Subject: Re: [PATCH v5 3/7] x86/microcode/intel: Establish staging control
 logic
Message-ID: <20250904121318.GKaLmCXlU4kwhsxG9h@fat_crate.local>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
 <20250823155214.17465-4-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250823155214.17465-4-chang.seok.bae@intel.com>

On Sat, Aug 23, 2025 at 08:52:06AM -0700, Chang S. Bae wrote:
> When microcode staging is initiated, operations are carried out through
> an MMIO interface. Each package has a unique interface specified by the
> IA32_MCU_STAGING_MBOX_ADDR MSR, which maps to a set of 32-bit registers.
> 
> Prepare staging with the following steps:
> 
>   1.  Ensure the microcode image is 32-bit aligned to match the MMIO
>       register size.
> 
>   2.  Identify each MMIO interface based on its per-package scope.
> 
>   3.  Invoke the staging function for each identified interface, which
>       will be implemented separately.
> 
> Also, define cpu_primary_thread_mask for the CONFIG_SMP=n case, allowing
> consistent use when narrowing down primary threads to locate the
> per-package interface.

This paragraph is stale now and can go.

> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index b65c3ba5fa14..0356155f9264 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -913,6 +913,8 @@
>  #define MSR_IA32_UCODE_WRITE		0x00000079
>  #define MSR_IA32_UCODE_REV		0x0000008b
>  
> +#define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5

Doesn't look sorted to me.

> +
>  /* Intel SGX Launch Enclave Public Key Hash MSRs */
>  #define MSR_IA32_SGXLEPUBKEYHASH0	0x0000008C
>  #define MSR_IA32_SGXLEPUBKEYHASH1	0x0000008D
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 371ca6eac00e..d309fb1f058f 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -299,6 +299,54 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
>  	return size ? NULL : patch;
>  }
>  
> +/*
> + * Handle the staging process using the mailbox MMIO interface.
> + * Return the result state.
> + */
> +static enum ucode_state do_stage(u64 mmio_pa)
> +{
> +	pr_debug_once("Staging implementation is pending.\n");
> +	return UCODE_ERROR;
> +}
> +
> +static void stage_microcode(void)
> +{
> +	unsigned int pkg_id = UINT_MAX;
> +	enum ucode_state ret;
> +	int cpu, err;
> +	u64 mmio_pa;
> +
> +	if (!IS_ALIGNED(get_totalsize(&ucode_patch_late->hdr), sizeof(u32)))
> +		return;
> +
> +	lockdep_assert_cpus_held();
> +
> +	/*
> +	 * The MMIO address is unique per package, and all the SMT
> +	 * primary threads are online here. Find each MMIO space by
> +	 * their package ids to avoid duplicate staging.
> +	 */
> +	for_each_cpu(cpu, cpu_primary_thread_mask) {
> +		if (topology_logical_package_id(cpu) == pkg_id)
> +			continue;

<---- newline here.

> +		pkg_id = topology_logical_package_id(cpu);
> +
> +		err = rdmsrq_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &mmio_pa);
> +		if (WARN_ON_ONCE(err))
> +			return;
> +
> +		ret = do_stage(mmio_pa);
> +		if (ret != UCODE_OK) {
> +			pr_err("Error: staging failed with %s for CPU%d at package %u.\n",
> +			       ret == UCODE_TIMEOUT ? "timeout" : "error state",

What does "error state" mean?

Are we going to dump additional error state so that it is clear why it failed?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

