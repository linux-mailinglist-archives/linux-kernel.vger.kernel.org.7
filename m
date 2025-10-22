Return-Path: <linux-kernel+bounces-865665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83617BFDB37
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D1C1A619D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F74E2E8B64;
	Wed, 22 Oct 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghidSBky"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7CD2E7F29
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155172; cv=none; b=ayJXKiHWIlARxPNuAxBW0oPayoswRWvF/IIvFscktnkaC3Po+m5SUi01uF6tn/mvg7fR9CqWNpQKT7DDJPWir2kxsTWbJvMndMp9rbX0I76TA/oGJNXQorSarR+1FAuPSgw6uPgLNpYtYc+5TQ9YV1iRXYLvghtZcujO8scPAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155172; c=relaxed/simple;
	bh=qrix3pfqeHlYkHu5gf3ihlFO9JyiWdEausne67ag9Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuRkdnwBrdVCr098Qqu6ifmFxbgm9CvPdt4kC3foKmulSkneLl+0kayTK2kY7JvE4+gpJ8zOOwNOE1qFACJCNngP62owOPqWiT9jW5EyFDmMqsWtp8NuhU0yqGfoEQcdaRupAmSb6reW8lFUY8maDpUt7bcAnReEPHMVt9aNus0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghidSBky; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761155171; x=1792691171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qrix3pfqeHlYkHu5gf3ihlFO9JyiWdEausne67ag9Ew=;
  b=ghidSBky2/5tjcFM4xcWL3fLN3/RAVU2WRnS0B0/twQcwqvt4Yx3lFW3
   YE7RuaVx2DOsLUbcN0ivlRuNEyOMt3zhdGi29azK6SxSc6bk2ds6B0//7
   EdEmy88BQkUlcmrl7V3QMvIqqMowD7m1cnDH8kxx3DvG5Bo24sNtPwRQj
   +wADXfEBIMxONLvrpd0WbczZLFTG9A6NCdgBmBXoaiCDw7Aec6kSVFbIp
   n+QwQo0uW4y/epDA0RsOmPidkF48/sXlQWOfe3lu6swX873uKFgo7GJS6
   kGzcPENtpSRcTUHetT/T3Od80OXWcMbvsk6Cfz/VbtjMuLy5lUO1Ymdc9
   g==;
X-CSE-ConnectionGUID: WkWhFjeqTa6FZCy9OPv1mw==
X-CSE-MsgGUID: w6gol5B5Rj6mTmfuNj9VjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88779599"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="88779599"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 10:46:10 -0700
X-CSE-ConnectionGUID: V5jGYZIaSRedtosDZisc0A==
X-CSE-MsgGUID: 4RfXQNktRd61S3fAMcvNhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="183154329"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO desk) ([10.124.221.85])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 10:46:10 -0700
Date: Wed, 22 Oct 2025 10:46:03 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] x86/tsx: Get the tsx= command line parameter with
 early_param()
Message-ID: <20251022174603.mx7sze3w5e24obps@desk>
References: <cover.1761127696.git.ptesarik@suse.com>
 <befa0b859777267a11c90aebde6a3bedce276b90.1761127696.git.ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <befa0b859777267a11c90aebde6a3bedce276b90.1761127696.git.ptesarik@suse.com>

On Wed, Oct 22, 2025 at 12:26:13PM +0200, Petr Tesarik wrote:
> Use early_param() to get the value of the tsx= command line parameter. It
> is an early parameter, because it must be parsed before tsx_init(), which
> is called long before kernel_init(), where normal parameters are parsed.
> 
> Although cmdline_find_option() from tsx_init() works fine, the option is
> later reported as unknown and passed to user space. The latter is not a
> real issue, but the former is confusing and makes people wonder if the tsx=
> parameter had any effect and double-check for typos unnecessarily.
> 
> The behavior changes slightly if "tsx" is given without any argument (which
> is invalid syntax). Prior to this patch, the kernel logged an error message
> and disabled TSX. With this patch, the kernel still issues a warning
> (Malformed early option 'tsx'), but TSX state is unchanged. The new
> behavior is consistent with other parameters, e.g. "tsx_async_abort".
> 
> Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  arch/x86/kernel/cpu/tsx.c | 52 ++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> index 8be08ece2214..74ba4abac7e9 100644
> --- a/arch/x86/kernel/cpu/tsx.c
> +++ b/arch/x86/kernel/cpu/tsx.c
> @@ -20,13 +20,17 @@
>  #define pr_fmt(fmt) "tsx: " fmt
>  
>  enum tsx_ctrl_states {
> +	TSX_CTRL_AUTO,
>  	TSX_CTRL_ENABLE,
>  	TSX_CTRL_DISABLE,
>  	TSX_CTRL_RTM_ALWAYS_ABORT,
>  	TSX_CTRL_NOT_SUPPORTED,
>  };
>  
> -static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init = TSX_CTRL_NOT_SUPPORTED;
> +static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =
> +	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO) ? TSX_CTRL_AUTO :
> +	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF) ? TSX_CTRL_DISABLE :
                                                 ^
						 The extra space I had in
						 the version I sent was
						 intentional.

> +	TSX_CTRL_ENABLE;

Also this can stay on the same line.

	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_AUTO) ? TSX_CTRL_AUTO    :
	IS_ENABLED(CONFIG_X86_INTEL_TSX_MODE_OFF)  ? TSX_CTRL_DISABLE : TSX_CTRL_ENABLE;

IMO, this is so much more easier to read.

