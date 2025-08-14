Return-Path: <linux-kernel+bounces-769338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAC4B26D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34F260490B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE47166F1A;
	Thu, 14 Aug 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwNF5N45"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05D42FB996
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190508; cv=none; b=IkZW01aWJegNmZDFLPZTW4iOaQUEkR/NZGaIJa2RSqfuY/hf/DTWOtpCEbqAD7R8F85duANC1JiYxqj1MH+eg/tm1JbRp4Mfst4WniJ9DYM6K5SwC56T1KGH+eJ9sKdtD9t/9a8S9Hh/FffQOV3s8NNs15UVgkMm45QJbcOEQOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190508; c=relaxed/simple;
	bh=jT3m5K+Ef31oWsbdFFjTWYvI3Z4rXVgoNphKGWGsA2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzYcH7oGGZsAaqwvXiC623Oqf0RGgXgJe7i+1KmUDT8tmpHzCmzO2qYc1IZ6mzB3hpUUsR+NVORbU89AiIazmFnGm393V+EaIvQqvfUendkn344zXVc7xpEspOV7wyz+O5OAUZ40ucF8QffPPYiofpgdLTo96OR0+83UYOxUApc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwNF5N45; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755190507; x=1786726507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jT3m5K+Ef31oWsbdFFjTWYvI3Z4rXVgoNphKGWGsA2M=;
  b=QwNF5N45m9E1m338oWdC2bDSWJsZNW6iGEnIP2bRdNL6MjsrEAREoH7e
   x/yJt3FE5IeM3CcHcdNVRDEnQpqOCC+ooSQPdSaUkHSjR7nbKo3R8bQOr
   XDKq7GRP/2/RLWPaH3/ICMvgGOT6DYmnnb1ytPtD1jY4MmvSMB1J8Gzp1
   lBL/xOHH3ymstIA51DV+SFKt6GY564Rtn6KLUKtd1fJ+QaM1tSvsJspI8
   cOdYL4d65UNUROMC03rMuK6C6tWcfjD4xTBH/VvOoZfHQK0hhmh0uAaB9
   hILZybQ20eAvQlEpsMEAlld1c9agzAmBj5wNr2YxlQ8ukRqjCbu21pkcz
   w==;
X-CSE-ConnectionGUID: 9Y0KYvkKQvGwKEgKUoG7Eg==
X-CSE-MsgGUID: TBe9Q3OQROS59n/xB6gpcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="75084610"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="75084610"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 09:55:06 -0700
X-CSE-ConnectionGUID: fm3nSnitQASW4lpcPWl5vg==
X-CSE-MsgGUID: RIjFKAtOTr6H/9dHmilPzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="171043953"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO desk) ([10.124.223.76])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 09:55:06 -0700
Date: Thu, 14 Aug 2025 09:54:59 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/bugs: Use early_param for spectre_v2
Message-ID: <20250814165459.uhrxpcybihzddbgt@desk>
References: <20250811142659.152248-1-david.kaplan@amd.com>
 <20250811142659.152248-3-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811142659.152248-3-david.kaplan@amd.com>

On Mon, Aug 11, 2025 at 09:26:58AM -0500, David Kaplan wrote:
> Most of the mitigations in bugs.c use early_param for command line parsing.
> Rework the spectre_v2 and nospectre_v2 command line options to be
> consistent with the others.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 151 +++++++++++++++++++------------------
>  1 file changed, 78 insertions(+), 73 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 6bfe199b9f3e..19a3891953c3 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1827,7 +1827,8 @@ enum spectre_v2_mitigation_cmd {
>  	SPECTRE_V2_CMD_IBRS,
>  };
>  
> -static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
> +static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init =
> +	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ? SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
>  
>  enum spectre_v2_user_mitigation_cmd {
>  	SPECTRE_V2_USER_CMD_NONE,
> @@ -2035,112 +2036,118 @@ static const char * const spectre_v2_strings[] = {
>  	[SPECTRE_V2_IBRS]			= "Mitigation: IBRS",
>  };
>  
> -static const struct {
> -	const char *option;
> -	enum spectre_v2_mitigation_cmd cmd;
> -	bool secure;
> -} mitigation_options[] __initconst = {
> -	{ "off",		SPECTRE_V2_CMD_NONE,		  false },
> -	{ "on",			SPECTRE_V2_CMD_FORCE,		  true  },
> -	{ "retpoline",		SPECTRE_V2_CMD_RETPOLINE,	  false },
> -	{ "retpoline,amd",	SPECTRE_V2_CMD_RETPOLINE_LFENCE,  false },
> -	{ "retpoline,lfence",	SPECTRE_V2_CMD_RETPOLINE_LFENCE,  false },
> -	{ "retpoline,generic",	SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
> -	{ "eibrs",		SPECTRE_V2_CMD_EIBRS,		  false },
> -	{ "eibrs,lfence",	SPECTRE_V2_CMD_EIBRS_LFENCE,	  false },
> -	{ "eibrs,retpoline",	SPECTRE_V2_CMD_EIBRS_RETPOLINE,	  false },
> -	{ "auto",		SPECTRE_V2_CMD_AUTO,		  false },
> -	{ "ibrs",		SPECTRE_V2_CMD_IBRS,              false },
> -};
> -
>  static void __init spec_v2_print_cond(const char *reason, bool secure)
>  {
>  	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) != secure)
>  		pr_info("%s selected on command line.\n", reason);
>  }
>  
> -static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
> -{
> -	enum spectre_v2_mitigation_cmd cmd;
> -	char arg[20];
> -	int ret, i;
> +static bool nospectre_v2 __ro_after_init;
>  
> -	cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
> -	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
> -		return SPECTRE_V2_CMD_NONE;
> +static int __init nospectre_v2_parse_cmdline(char *str)
> +{
> +	nospectre_v2 = true;
> +	spectre_v2_cmd = SPECTRE_V2_CMD_NONE;
> +	return 0;
> +}
> +early_param("nospectre_v2", nospectre_v2_parse_cmdline);
>  
> -	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
> -	if (ret < 0)
> -		return cmd;
> +static int __init spectre_v2_parse_cmdline(char *str)
> +{
> +	if (!str)
> +		return -EINVAL;
>  
> -	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
> -		if (!match_option(arg, ret, mitigation_options[i].option))
> -			continue;
> -		cmd = mitigation_options[i].cmd;
> -		break;
> -	}
> +	if (nospectre_v2)
> +		return 0;
>  
> -	if (i >= ARRAY_SIZE(mitigation_options)) {
> -		pr_err("unknown option (%s). Switching to default mode\n", arg);
> -		return cmd;
> -	}
> +	if (!strcmp(str, "off"))
> +		spectre_v2_cmd = SPECTRE_V2_CMD_NONE;
> +	else if (!strcmp(str, "on"))
> +		spectre_v2_cmd = SPECTRE_V2_CMD_FORCE;
> +	else if (!strcmp(str, "retpoline"))
> +		spectre_v2_cmd = SPECTRE_V2_CMD_RETPOLINE;
> +	else if (!strcmp(str, "retpoline,amd") ||
> +		 !strcmp(str, "retpoline,lfence"))
> +		spectre_v2_cmd = SPECTRE_V2_CMD_RETPOLINE_LFENCE;
> +	else if (!strcmp(str, "retpoline,generic"))
> +		spectre_v2_cmd = SPECTRE_V2_CMD_RETPOLINE_GENERIC;
> +	else if (!strcmp(str, "eibrs"))
> +		spectre_v2_cmd = SPECTRE_V2_CMD_EIBRS;
> +	else if (!strcmp(str, "eibrs,lfence"))
> +		spectre_v2_cmd = SPECTRE_V2_CMD_EIBRS_LFENCE;
> +	else if (!strcmp(str, "eibrs,retpoline"))
> +		spectre_v2_cmd = SPECTRE_V2_CMD_EIBRS_RETPOLINE;
> +	else if (!strcmp(str, "auto"))
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
> +	else if (!strcmp(str, "ibrs"))
> +		spectre_v2_cmd = SPECTRE_V2_CMD_IBRS;
> +	else
> +		pr_err("Ignoring unknown spectre_v2 option (%s).", str);

All of the below should go in spectre_v2_select_mitigation() after all
features are detected because ...

> -	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
> -	     cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
> -	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
> -	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
> -	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
> +	if ((spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
>  	    !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
>  		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
> -		       mitigation_options[i].option);
> -		return SPECTRE_V2_CMD_AUTO;
> +			str);
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
>  	}
>  
> -	if ((cmd == SPECTRE_V2_CMD_EIBRS ||
> -	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
> -	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
> +	if ((spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
>  	    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {

... X86_FEATURE_IBRS_ENHANCED is not enumerated yet in early_param processing.

>  		pr_err("%s selected but CPU doesn't have Enhanced or Automatic IBRS. Switching to AUTO select\n",
> -		       mitigation_options[i].option);
> -		return SPECTRE_V2_CMD_AUTO;
> +		       str);
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
>  	}
>  
> -	if ((cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
> -	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE) &&
> +	if ((spectre_v2_cmd == SPECTRE_V2_CMD_RETPOLINE_LFENCE ||
> +	     spectre_v2_cmd == SPECTRE_V2_CMD_EIBRS_LFENCE) &&
>  	    !boot_cpu_has(X86_FEATURE_LFENCE_RDTSC)) {

and this. So in essence, spectre_v2_parse_cmdline() should only record what
user wanted.

>  		pr_err("%s selected, but CPU doesn't have a serializing LFENCE. Switching to AUTO select\n",
> -		       mitigation_options[i].option);
> -		return SPECTRE_V2_CMD_AUTO;
> +		       str);
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
>  	}
>  
> -	if (cmd == SPECTRE_V2_CMD_IBRS && !IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY)) {
> +	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && !IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY)) {
>  		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
> -		       mitigation_options[i].option);
> -		return SPECTRE_V2_CMD_AUTO;
> +		       str);
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
>  	}
>  
> -	if (cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
> +	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
>  		pr_err("%s selected but not Intel CPU. Switching to AUTO select\n",
> -		       mitigation_options[i].option);
> -		return SPECTRE_V2_CMD_AUTO;
> +		       str);
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
>  	}
>  
> -	if (cmd == SPECTRE_V2_CMD_IBRS && !boot_cpu_has(X86_FEATURE_IBRS)) {
> +	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && !boot_cpu_has(X86_FEATURE_IBRS)) {
>  		pr_err("%s selected but CPU doesn't have IBRS. Switching to AUTO select\n",
> -		       mitigation_options[i].option);
> -		return SPECTRE_V2_CMD_AUTO;
> +		       str);
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
>  	}
>  
> -	if (cmd == SPECTRE_V2_CMD_IBRS && cpu_feature_enabled(X86_FEATURE_XENPV)) {
> +	if (spectre_v2_cmd == SPECTRE_V2_CMD_IBRS && cpu_feature_enabled(X86_FEATURE_XENPV)) {
>  		pr_err("%s selected but running as XenPV guest. Switching to AUTO select\n",
> -		       mitigation_options[i].option);
> -		return SPECTRE_V2_CMD_AUTO;
> +		       str);
> +		spectre_v2_cmd = SPECTRE_V2_CMD_AUTO;
>  	}
>  
> -	spec_v2_print_cond(mitigation_options[i].option,
> -			   mitigation_options[i].secure);
> -	return cmd;
> +	/* Print a warning if forcing an option.  AUTO is not forcing. */
> +	if (spectre_v2_cmd == SPECTRE_V2_CMD_AUTO)
> +		return 0;
> +
> +	if (spectre_v2_cmd == SPECTRE_V2_CMD_FORCE)
> +		spec_v2_print_cond(str, true);
> +	else
> +		spec_v2_print_cond(str, false);
> +
> +	return 0;
>  }
> +early_param("spectre_v2", spectre_v2_parse_cmdline);

