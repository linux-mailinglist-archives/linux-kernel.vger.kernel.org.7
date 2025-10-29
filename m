Return-Path: <linux-kernel+bounces-875919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73277C1A204
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F5518968ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B13D337BB1;
	Wed, 29 Oct 2025 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aAAX7Bhe"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4DB2D0611
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761739066; cv=none; b=Vn+lCxVCIwaASA7NGHTlJXf37B1t8xkRQCfpHwbNy/OY/FHdLiJ5vBWcPkmLWQjusL3njHmEb7XNvK/EeOFBg+2g54ruOCNJysWBNFACgAjcuHs42sPg8GNVmu/MklCjgPjoBAhOz9WWOaUb60aEAU/dN7WedbeerT9yixzrV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761739066; c=relaxed/simple;
	bh=cU6CUeX0WDZCOmqHQ4fKt2cp+Z4CkhdPcJlg6nz2cTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFqguF7TzPvBku75TbYX43sYjaIz3MjLXDlWS/9io+nw1MJe7ULjXW2ilbxTmDb7RJlwMOrYg17T8tlTUymEU9699k9csPcf9QP7/3T2YCspHWKHkJrNhAqYXJ+Evs+FpV3f0+W43AoiuHcHXuEx7vjTE/uUfgAxFL/9nk80wks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aAAX7Bhe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3A24C40E00DA;
	Wed, 29 Oct 2025 11:57:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kxTD_tmuFiYK; Wed, 29 Oct 2025 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761739057; bh=uxMWbr+yPlEQ0CzH2y8lP/730Ox/Qwdjd32apfHt8L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAAX7BheLbrXVmy5ALc+q1c5OPUbRcmE0bSVmBTUAeMZlluVZZUKIuK2qOHj16aie
	 0Fq9uumSb5HzboWusWm8fQODoEkB8baiD5kO767o+yN3lu8WfMbaZYSUF71jsa2vbE
	 t2yMP3U6TctC/EOF/OwnHthAF2DiCmdqX0rSxAOQWKdJ1BzyzomkPWKrozkY0d8QBj
	 M5dWShM8LSo3JUl4kJWzo8aFMzQMhPmftQYdmNR5M2PqswekwokciGNaPB8bdaIV94
	 al+GTP1F2s7Wh6VR9f6RFPOAx4QOAVOSWBtwfv8RcUaaldqNVAhfMELFuzDuPZGsDZ
	 KesShhyZpNooLyDXSD2ubv8CJQdxFoM7Z9/MItyMLKP4wS7F69umjqe7N/pbCMODDZ
	 kCO13n2bUITPQi1WXeM9w5Pmq4bSO/nFrNjm/uDhwg/NmfYJyrhhnQdx6wdlDro+9f
	 H46SRuNeGFY5r7pQvuv+fjOPqnybN/GHMpf5eQYPJKYj5Q8Qa+YduesyNaTTzygL/v
	 DKNLOc7kC1wVxsGc8fykJl7I4OZr5TOe33vtsfdeYWEc89esmA84Y70TW2D9BM+Pzm
	 7vTPzYQ3NYQmbGpRATMj9NMTDCf/qAorl8kDTDTsUnt5xxWPY6jdJcMYZFhBS4hAgE
	 pZKRbA/Fx1BwUiVbLG1R3kMo=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9919440E021B;
	Wed, 29 Oct 2025 11:57:25 +0000 (UTC)
Date: Wed, 29 Oct 2025 12:57:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 04/56] x86/bugs: Reset spectre_v1 mitigations
Message-ID: <20251029115719.GEaQIBH1j4vVEQLas9@fat_crate.local>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-5-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013143444.3999-5-david.kaplan@amd.com>

On Mon, Oct 13, 2025 at 09:33:52AM -0500, David Kaplan wrote:
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 6a526ae1fe99..9d5c6a3e50e1 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -46,6 +46,8 @@
>   *				   may want to change based on other choices
>   *				   made.  This function is optional.
>   *   <vuln>_apply_mitigation() -- Enable the selected mitigation.
> + *   <vuln>_reset_mitigation() -- Undo's the apply_mitigation step, this is used

"Undoes" no?

> + *				  with runtime mitigation patching.
>   *
>   * The compile-time mitigation in all cases should be AUTO.  An explicit
>   * command-line option can override AUTO.  If no such option is
> @@ -1247,6 +1249,15 @@ static void __init spectre_v1_apply_mitigation(void)
>  	pr_info("%s\n", spectre_v1_strings[spectre_v1_mitigation]);
>  }
>  
> +#ifdef CONFIG_DYNAMIC_MITIGATIONS
> +static void spectre_v1_reset_mitigation(void)
> +{
> +	setup_clear_cpu_cap(X86_FEATURE_FENCE_SWAPGS_USER);
> +	setup_clear_cpu_cap(X86_FEATURE_FENCE_SWAPGS_KERNEL);
> +	spectre_v1_mitigation = SPECTRE_V1_MITIGATION_AUTO;
> +}
> +#endif

Right, let's see in the end what is easier: we have the cross-dependencies
between mitigations so having separate "undo" functions might require them to
run in reverse order to the "apply" functions. I can imagine a single "undo"
function would be easier because you have everything in one place.

We'll see.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

