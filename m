Return-Path: <linux-kernel+bounces-869585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071B1C083CF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9423ACF0C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC3A2F616F;
	Fri, 24 Oct 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D8pWoZMO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF1F305960
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761344846; cv=none; b=chEZZGgXNkWXvPog9pZEYqW4ndpafMfhEuhVmPYS81uTNPA/+O5hcZk17X9CtYrX62R3ILl3pTbYAzLmTTlowTZ05R5vRK8uN4W4JYgeTeTwqH+3hqu0yZIdSXXGi5tP/dV3vlDphsqS/24EyIpAv+mWqokE0dOiFNT3RuhxTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761344846; c=relaxed/simple;
	bh=wAC54swC6d7LHWKR5AmWrdxKkuBXj07FCxvfsF6o518=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlqnsBWSGdvN7YVfgc0F/vCWxp9kuqHGn5430CdpsZJAr9MRl3qdGT0r5pg0M3NpJrNJDRHCmf96ydfV5JQg6WPYhb1iOhmhFZ3ZrihRiIRUBx6GTNCn/zo9mcRij6vBoa82M0s38d0bMfasDdSsuAE4GFH5qa6vRwgYjmvZs9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D8pWoZMO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761344845; x=1792880845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wAC54swC6d7LHWKR5AmWrdxKkuBXj07FCxvfsF6o518=;
  b=D8pWoZMONzU9r+iWBLL/34vgCbV6/+g2gmWFrG6rEA2gDan3GpCaQCV+
   5UBaQet/Wr1S8hLDN48KDqrTQ3siuTmhDgSd2CCWRGhRaA9lXIJ+4l8h5
   Bhek2mRTtRJa/aaNXFc3JkkZMr1iMLsvwwoOpIhkxht2VUSCJDPc94bnX
   Y9jc97UNDp5A+X5Ng2DOrxVTfsl+tsqYH3BaAmy2Nx7yWIqtvA7+7ba4D
   nlwGEErJPXSM/ygqPqFdIrtomOqYw5T5RP78okuUrwb7FIS7o4hgZo5Ec
   LX9DvX23Zmtr7E+eMLmKuaNOpW4N8UHVACZHfRMvggDh78K/0XvsHvxi/
   A==;
X-CSE-ConnectionGUID: qGI74LflTm29DXyjSiYX2g==
X-CSE-MsgGUID: LvmaGBwDRi+OrcFoaa9Jog==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74132746"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="74132746"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 15:27:24 -0700
X-CSE-ConnectionGUID: pr3mLnktShSgR90d/bNopw==
X-CSE-MsgGUID: wOK5IfhEToeFHHoDZQDTjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="188598368"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO desk) ([10.124.222.23])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 15:27:23 -0700
Date: Fri, 24 Oct 2025 15:27:17 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
	David Kaplan <david.kaplan@amd.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] x86/bugs: Remove dead code which might prevent
 from building
Message-ID: <20251024222717.sgmqfpyas3gekgqf@desk>
References: <20251024125959.1526277-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024125959.1526277-1-andriy.shevchenko@linux.intel.com>

On Fri, Oct 24, 2025 at 02:59:59PM +0200, Andy Shevchenko wrote:
> Clang, in particular, is not happy about dead code:
> 
> arch/x86/kernel/cpu/bugs.c:1830:20: error: unused function 'match_option' [-Werror,-Wunused-function]
>  1830 | static inline bool match_option(const char *arg, int arglen, const char *opt)
>       |                    ^~~~~~~~~~~~
> 1 error generated.
> 
> Remove a leftover from the previous cleanup.
> 
> Fixes: 02ac6cc8c5a1 ("x86/bugs: Simplify SSB cmdline parsing")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index e08de5b0d20b..d7fa03bf51b4 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1827,13 +1827,6 @@ void unpriv_ebpf_notify(int new_state)
>  }
>  #endif
>  
> -static inline bool match_option(const char *arg, int arglen, const char *opt)
> -{
> -	int len = strlen(opt);
> -
> -	return len == arglen && !strncmp(arg, opt, len);
> -}

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

