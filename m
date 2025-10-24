Return-Path: <linux-kernel+bounces-868018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E1CC0429E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAFF3B4388
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC42494FF;
	Fri, 24 Oct 2025 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1t4beNo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F7828DC4
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274167; cv=none; b=tKXuSQVqnO1wlmud0+FfVUBtoh3WJ8u2b5GfBDultdM6JKcsYbqEwxyUoX/UDqhDpjc+XTvC4z1lDLfgSNfucscugG9K4oQSIRbK3+NyE4h4yBDG1DyaZejDwHG4gX5Rwgzl1LbsdjkfiACa5XvMyVMSiEeHj0O8hf0hTL4zkb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274167; c=relaxed/simple;
	bh=umPnZ23S2CY2D4YwC3KQkBJGEZGvTH6AJLWcUajq5AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkFquaNU2JALthAzZz7/WkET+GL6/gOrEsYJ36s1qlTWVAHzMSHzsdy50c4/s4Vfkr2GcUyOU0a6Q0zSQG7wRKpszemq70/isu20g9wZPaUnaQ0Dtktg6BlNsd+CYfzVXR88uPs6h7ju+FJ0z155wV7T/s8z/alqXouySdyNQxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1t4beNo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761274166; x=1792810166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=umPnZ23S2CY2D4YwC3KQkBJGEZGvTH6AJLWcUajq5AY=;
  b=m1t4beNotuLWCq/BnqxxN/Xx40VQ0GSYXG3a+cIJKlLKIA/wFLA4ebCf
   Gkp1Xt6Ldf2/JaavS6rPj9H6VR7RermlfEc8iF83TK3PT3OpsJ9gl2JB7
   F+/Ca6mVknj6TzFm7z7VrgWO8xlVM2zxcIONogtTwQrhmvAiAfQPOPJOe
   +/+AcnfrnfGPFLfWouDOqUQGLS8GPBr+z69Or/QGs7iS7MYvkm/frGcG7
   +QGMGQB4m3BgWFgRmQNQ9JX3950m0hIgeBLd28Sqsr68Rnue73N/4GUxQ
   PfnIE7wEQGeySBr/2PEum6a5tAcBh7X4GsZKymGURaY3w1gnMhoyNzH1+
   w==;
X-CSE-ConnectionGUID: wvvWGm6yQ/aCtbwtYyyJuA==
X-CSE-MsgGUID: I5Nyw3UvQb6u0uyR0m/zDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74800097"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="74800097"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 19:49:25 -0700
X-CSE-ConnectionGUID: Kb7s3EV9TXa/Sc9YWXQjqw==
X-CSE-MsgGUID: 32ZPg7teSFaljG0F5J1hMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="188377668"
Received: from jjgreens-desk21.amr.corp.intel.com (HELO desk) ([10.124.221.191])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 19:49:25 -0700
Date: Thu, 23 Oct 2025 19:49:18 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 15/56] x86/bugs: Reset BHI mitigations
Message-ID: <20251024024918.5ytpa7vrcny6tngt@desk>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-16-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013143444.3999-16-david.kaplan@amd.com>

On Mon, Oct 13, 2025 at 09:34:03AM -0500, David Kaplan wrote:
> Add function to reset BHI mitigations back to their boot-time defaults.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index e765ac0b9240..67561e5c2154 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2360,6 +2360,17 @@ static void __init bhi_apply_mitigation(void)
>  	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_VMEXIT);
>  }
>  
> +#ifdef CONFIG_DYNAMIC_MITIGATIONS
> +static void bhi_reset_mitigation(void)
> +{
> +	/* RRSBA already cleared in spectre_v2_reset_mitigation() */
> +	setup_clear_cpu_cap(X86_FEATURE_CLEAR_BHB_VMEXIT);
> +	setup_clear_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);

Also needs to reset SPEC_CTRL_BHI_DIS_S in x86_spec_ctrl_base.

An alternative is to add spec_ctrl_reset_mitigation() that resets
x86_spec_ctrl_base for SPEC_CTRL_MITIGATIONS_MASK. To be consistent with
reset functions of other mitigations, probably also reset the MSR.

> +	bhi_mitigation = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ?
> +		BHI_MITIGATION_AUTO : BHI_MITIGATION_OFF;
> +}

