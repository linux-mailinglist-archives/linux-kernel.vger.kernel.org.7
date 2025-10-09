Return-Path: <linux-kernel+bounces-847298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8FFBCA7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D8619E88E5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26722EB844;
	Thu,  9 Oct 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N62wVRNU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC912D97B8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032742; cv=none; b=rp5k2TiVtNBPIcE5t04FK0Eha3B1oB50bMR+eaS98UPxx27ZDFTxU66pDtoTFXnG4Pe8W2Y43mXugHGiGgFD7+zCO3l2NbkmtGkZjO8Wcs4ohngVB2a8iaKLfxx2YZSPN84cRfxt7YGOHdjPVYshyBRaJxESXXRAvly3YYKIUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032742; c=relaxed/simple;
	bh=4iu98YH2RTlfczivUJyQn3of+NKeJBZVqosA2EOZwkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ux/uiCLGUmxlLYY5PwPJztjeAvEWD2pAieenOpH+ap/dy0+TJAasoH/gJ2jr2480Ug+kXk1g7Ut1rzMEp0H5TBfe/WoDGaHW3xrqc+G+bpkbXtD6pmBAqS/pSnfcIrJ4gcqpbwfXM3pJ37QxtV5DxWJPww9fBYUgUX09UqXGEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N62wVRNU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760032741; x=1791568741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4iu98YH2RTlfczivUJyQn3of+NKeJBZVqosA2EOZwkI=;
  b=N62wVRNUoUbDUKHa17+rjPJU2yR1wSQ41aLpSesxkKHj2HUb3B+w5S42
   pvhU11Ud8V5ZNoBuJ3T01RzYdIiyqP4Dqza1IE7oo7Jj3G1HrU84m4EJH
   usRw8ZJgapB1NO3LKKphDRCMbWXFpQlbbP6xGkKTSpP+AfJvi6D5M3+Ps
   8lqwqZDJM0w17t8i7bgDQdmgtZLwP+W6F48hi9s4B7vAKoStR1/UD54SX
   9UBJprvrD5YexA4qQKf328QhloJhARGzlb8speqIlZYpJu10sgl4KJ2zj
   YKha7IW6jqVRlHogsnwMoT32qdD2/LFq3CKid2t+5ui+M2wwiBa3bDU9K
   w==;
X-CSE-ConnectionGUID: TWc1GRS6RyOCeNtHhKyRpg==
X-CSE-MsgGUID: Q/fDo0UfS0icIldwZJrCvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="72864522"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="72864522"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 10:59:00 -0700
X-CSE-ConnectionGUID: nieMSY7cTYSTiTmcFIvxfQ==
X-CSE-MsgGUID: mvGfB2bNRNyzbdSgQKnUug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="179885879"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO desk) ([10.124.221.52])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 10:58:58 -0700
Date: Thu, 9 Oct 2025 10:58:52 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] x86/tsx: Make tsx_ctrl_state static
Message-ID: <20251009175852.bpqdfqbrun4kkclh@desk>
References: <cover.1758906115.git.ptesarik@suse.com>
 <8b7d5f2baf55334a06da558afc7e12f3a78ae7ef.1758906115.git.ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b7d5f2baf55334a06da558afc7e12f3a78ae7ef.1758906115.git.ptesarik@suse.com>

On Fri, Sep 26, 2025 at 08:01:01PM +0200, Petr Tesarik wrote:
> Move all definitions related to tsx_ctrl_state to tsx.c. They are
> never referenced outside this file.
> 
> No functional change.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  arch/x86/kernel/cpu/cpu.h |  9 ---------
>  arch/x86/kernel/cpu/tsx.c | 10 +++++++++-
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
> index bc38b2d56f26a..5c7a3a71191a1 100644
> --- a/arch/x86/kernel/cpu/cpu.h
> +++ b/arch/x86/kernel/cpu/cpu.h
> @@ -42,15 +42,6 @@ extern const struct cpu_dev *const __x86_cpu_dev_start[],
>  			    *const __x86_cpu_dev_end[];
>  
>  #ifdef CONFIG_CPU_SUP_INTEL
> -enum tsx_ctrl_states {
> -	TSX_CTRL_ENABLE,
> -	TSX_CTRL_DISABLE,
> -	TSX_CTRL_RTM_ALWAYS_ABORT,
> -	TSX_CTRL_NOT_SUPPORTED,
> -};
> -
> -extern __ro_after_init enum tsx_ctrl_states tsx_ctrl_state;
> -
>  extern void __init tsx_init(void);
>  void tsx_ap_init(void);
>  void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c);
> diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> index 49782724a9430..167dfd38b87a2 100644
> --- a/arch/x86/kernel/cpu/tsx.c
> +++ b/arch/x86/kernel/cpu/tsx.c
> @@ -19,7 +19,15 @@
>  #undef pr_fmt
>  #define pr_fmt(fmt) "tsx: " fmt
>  
> -enum tsx_ctrl_states tsx_ctrl_state __ro_after_init = TSX_CTRL_NOT_SUPPORTED;
> +enum tsx_ctrl_states {
> +	TSX_CTRL_ENABLE,
> +	TSX_CTRL_DISABLE,
> +	TSX_CTRL_RTM_ALWAYS_ABORT,
> +	TSX_CTRL_NOT_SUPPORTED,
> +};
> +
> +static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =
> +	TSX_CTRL_NOT_SUPPORTED;

Nit, this can be on the same line:

static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init = TSX_CTRL_NOT_SUPPORTED;

It is still under the 100 character limit.

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

