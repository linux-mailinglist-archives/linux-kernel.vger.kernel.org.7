Return-Path: <linux-kernel+bounces-767847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10FBB259C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A598628E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FA31E47A5;
	Thu, 14 Aug 2025 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1GXo08W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B02FF65E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141587; cv=none; b=NRJ2u7kInMzJql8FQmDei5TnuTy9IVKt4VHcj/WgJEq/dL4J2XIKEAx0loV22JP32u0nrmBULS8jdvhQh9pbNjsEMdrK7l6gXCcUXGKTy5ryxnPx+v7JD6N2RYypy22Yv0AluqTCedgS5WO+h5JWc1+diAoTqGiM29R6E7sdiQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141587; c=relaxed/simple;
	bh=E7R6y5p94ab29eUjB7JP8FZNiSbdJt2x6K4FaQ0Cr1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoAmADGhFSfQHIg5neHUHxxdFV+q8aJzjGcUGjumbcJ3+ivI026KGVdqjEaWNql/iIwIY/dOGKDqFZrcu9diTHgz38q0ntSjmPsbL/cC+TFz8oeCHb50HUau7d3danseJJzKMf9tOgxTGjYznKGkvVt4cGL5Dr0lAZfff8zn6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1GXo08W; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755141586; x=1786677586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E7R6y5p94ab29eUjB7JP8FZNiSbdJt2x6K4FaQ0Cr1c=;
  b=F1GXo08WKXesgTfGDWJygVj/Kk2a+gnkvofJbn707FR0dyIvF9LXsgog
   75o4QDGApLmHLSMPcJHDw2K9d1gbkt1A8OQivVtvXapojAqLVFobDIynj
   Xw1mEgvWHKvOBArgeLNAdZWHy9854p/8lEn7PR1UhsNa61mdgRySSzMid
   BofwQFfh1sTID67DR4RrnPyih7L9JkO3koPEWKUdQdfV9TMCU4YQVhDQr
   bepDjmqJVU/VxhOc7gi3Rk/VsL+G3J9m9kqvqefPQkJlyp7NzJEqq68DB
   8bQB1KuyOgjyzWbimHsHvrhrDwFFxoq4rObsVXAE+qcpPElINS8MBYUI2
   A==;
X-CSE-ConnectionGUID: xK7h7nm3SbK6Pc+bHZyhVg==
X-CSE-MsgGUID: 31Jsr4zVSLauhbnoa6cueQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="45029757"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="45029757"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 20:19:45 -0700
X-CSE-ConnectionGUID: XC7lEYgLSOmdVbhYFQVutg==
X-CSE-MsgGUID: hn7ZSL4IQfKSmT/YlnHkjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170783391"
Received: from jjgreens-desk15.amr.corp.intel.com (HELO desk) ([10.124.223.1])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 20:19:45 -0700
Date: Wed, 13 Aug 2025 20:19:39 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/bugs: Use early_param for spectre_v2_user
Message-ID: <20250814031939.wkkmztyurgtnhjx6@desk>
References: <20250811142659.152248-1-david.kaplan@amd.com>
 <20250811142659.152248-2-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811142659.152248-2-david.kaplan@amd.com>

On Mon, Aug 11, 2025 at 09:26:57AM -0500, David Kaplan wrote:
> Most of the mitigations in bugs.c use early_param to parse their command
> line options.  Modify spectre_v2_user to use early_param for consistency.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 62 ++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index b74bf937cd9f..6bfe199b9f3e 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1829,7 +1829,7 @@ enum spectre_v2_mitigation_cmd {
>  
>  static enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
>  
> -enum spectre_v2_user_cmd {
> +enum spectre_v2_user_mitigation_cmd {
>  	SPECTRE_V2_USER_CMD_NONE,
>  	SPECTRE_V2_USER_CMD_AUTO,
>  	SPECTRE_V2_USER_CMD_FORCE,
> @@ -1839,6 +1839,9 @@ enum spectre_v2_user_cmd {
>  	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,
>  };
>  
> +static enum spectre_v2_user_mitigation_cmd spectre_v2_user_cmd __ro_after_init =
> +	SPECTRE_V2_USER_CMD_AUTO;
> +
>  static const char * const spectre_v2_user_strings[] = {
>  	[SPECTRE_V2_USER_NONE]			= "User space: Vulnerable",
>  	[SPECTRE_V2_USER_STRICT]		= "User space: Mitigation: STIBP protection",
> @@ -1847,50 +1850,45 @@ static const char * const spectre_v2_user_strings[] = {
>  	[SPECTRE_V2_USER_SECCOMP]		= "User space: Mitigation: STIBP via seccomp and prctl",
>  };
>  
> -static const struct {
> -	const char			*option;
> -	enum spectre_v2_user_cmd	cmd;
> -	bool				secure;
> -} v2_user_options[] __initconst = {
> -	{ "auto",		SPECTRE_V2_USER_CMD_AUTO,		false },
> -	{ "off",		SPECTRE_V2_USER_CMD_NONE,		false },
> -	{ "on",			SPECTRE_V2_USER_CMD_FORCE,		true  },
> -	{ "prctl",		SPECTRE_V2_USER_CMD_PRCTL,		false },
> -	{ "prctl,ibpb",		SPECTRE_V2_USER_CMD_PRCTL_IBPB,		false },
> -	{ "seccomp",		SPECTRE_V2_USER_CMD_SECCOMP,		false },
> -	{ "seccomp,ibpb",	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,	false },
> -};
> -
>  static void __init spec_v2_user_print_cond(const char *reason, bool secure)
>  {
>  	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) != secure)
>  		pr_info("spectre_v2_user=%s forced on command line.\n", reason);
>  }
>  
> -static enum spectre_v2_user_cmd __init spectre_v2_parse_user_cmdline(void)
> +static int __init spectre_v2_parse_user_cmdline(char *str)
>  {
> -	char arg[20];
> -	int ret, i;
> +	if (!str)
> +		return -EINVAL;
>  
>  	if (!IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2))
>  		return SPECTRE_V2_USER_CMD_NONE;
>  
> -	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
> -				  arg, sizeof(arg));
> -	if (ret < 0)
> -		return SPECTRE_V2_USER_CMD_AUTO;
> +	if (!strcmp(str, "auto"))
> +		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_AUTO;
> +	else if (!strcmp(str, "off"))
> +		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_NONE;
> +	else if (!strcmp(str, "on"))
> +		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_FORCE;
> +	else if (!strcmp(str, "prctl"))
> +		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_PRCTL;
> +	else if (!strcmp(str, "prctl,ibpb"))
> +		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_PRCTL_IBPB;
> +	else if (!strcmp(str, "seccomp"))
> +		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_SECCOMP;
> +	else if (!strcmp(str, "seccomp,ibpb"))
> +		spectre_v2_user_cmd = SPECTRE_V2_USER_CMD_SECCOMP_IBPB;
> +	else
> +		pr_err("Ignoring unknown spectre_v2_user option (%s).", str);

Should return from here? Otherwise, spec_v2_user_print_cond() will print
the unknown option as forced:

	pr_info("spectre_v2_user=%s forced on command line.\n", reason);

>  
> -	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
> -		if (match_option(arg, ret, v2_user_options[i].option)) {
> -			spec_v2_user_print_cond(v2_user_options[i].option,
> -						v2_user_options[i].secure);
> -			return v2_user_options[i].cmd;
> -		}
> -	}
> +	if (spectre_v2_user_cmd == SPECTRE_V2_USER_CMD_FORCE)
> +		spec_v2_user_print_cond(str, true);
> +	else
> +		spec_v2_user_print_cond(str, false);

I don't see the need for spec_v2_user_print_cond(), should it be zapped?

And then just do:

	if (spectre_v2_user_cmd != SPECTRE_V2_USER_CMD_FORCE)
		pr_info("spectre_v2_user=%s forced on command line.\n", str);

I also feel that the original print is a bit confusing (code-wise), because
it prints "forced" when the user opts for anything other than
"on"(CMD_FORCE). I think the intent was to inform the user that a partially
secure option is chosen.

> -	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
> -	return SPECTRE_V2_USER_CMD_AUTO;
> +	return 0;
>  }

