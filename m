Return-Path: <linux-kernel+bounces-774186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C915B2AFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E603AE9FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26917320CCE;
	Mon, 18 Aug 2025 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeXTIgll"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303763115A3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538926; cv=none; b=b1W5/opf9tdPF1NwwR4z4TuAiOjjyVjIOwxCEvb8sUbmmKJlUiI4M0A9X4dVUYa7Q/3Gfzplpa5YrMx1BlXk8KXK+3tZifWVvjLxrZMX5DNuwJqakcEa2LWP3iFGoidxtT1l52vcMHroO5+jop1oy9FQCcx2KqeBEgRmPwOryPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538926; c=relaxed/simple;
	bh=LbtR3P8SaBsWjgvH8LAVEysttbIz8gVtRuCE3CgLZzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkJc+OTEKtp6yusrgm5Mu3AnyfFtQMDgYKh/j07cEvqdt+gkFpEW2MfXTFDej4ydmOMUWeZRaedCSTKoT61eVVGWTXrs8b3UJKTw/A3jrlyyY2jEgwYgp+ff7tzJBX73vz3F07s3Y/kSJDazR9KUR446O/hsRwkrJX3imySNZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeXTIgll; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755538925; x=1787074925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LbtR3P8SaBsWjgvH8LAVEysttbIz8gVtRuCE3CgLZzk=;
  b=UeXTIgll/d1AdSs1i2Wa7X6oZdmUdYTMTnXgw4mOTZ8bbjyzT6eGBhRL
   vsLdvA3WgG5q3p3dVI5ehNXyhFv3vYgL7NHIQxynruWW6eaEDlah8osKg
   y4R0QQ9wv2eSiUmmHJmOQedjQPRuUopR2mIrdnpPGUKjfbvqOs0Vrb0rj
   Rol9JY0TYE7+aI82i2bMk+SwTYCS/CM+eZ67XCodmD9bmx2D6l6kmxZbY
   gHnu/Dt8AfcbP0ftMpv9lRA8DCuNZtnoJslZm4Th1fyqA/noU+g44+okU
   lI91eHXwwtcRzLTf1eSZZcdlKPi4/Lmb+FYEji0IbJHBOr5aZIDl8g7c9
   w==;
X-CSE-ConnectionGUID: 7irktuVFQFOTZrhz3/h05Q==
X-CSE-MsgGUID: sdbB+EVQQkSUBahmDK7h0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="61583744"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="61583744"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 10:42:04 -0700
X-CSE-ConnectionGUID: aTGO48EcSoC0KCd8EU2CzQ==
X-CSE-MsgGUID: qlv2DHr1RveGk8SBWSFOlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="171869148"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO desk) ([10.124.220.33])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 10:42:04 -0700
Date: Mon, 18 Aug 2025 10:41:57 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/bugs: Simplify SSB cmdline parsing
Message-ID: <20250818174157.c6bzy5bgw54fopgi@desk>
References: <20250811142659.152248-1-david.kaplan@amd.com>
 <20250811142659.152248-4-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811142659.152248-4-david.kaplan@amd.com>

On Mon, Aug 11, 2025 at 09:26:59AM -0500, David Kaplan wrote:
> Simplify the SSB command line parsing by selecting a mitigation directly,
> as is done in most of the simpler vulnerabilities.  Use early_param instead
> of cmdline_find_option for consistency with the other mitigation
> selections.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 118 ++++++++++++-------------------------
>  1 file changed, 39 insertions(+), 79 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 19a3891953c3..3766dff9a699 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2625,16 +2625,8 @@ void cpu_bugs_smt_update(void)
>  #undef pr_fmt
>  #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
>  
> -static enum ssb_mitigation ssb_mode __ro_after_init = SPEC_STORE_BYPASS_NONE;
> -
> -/* The kernel command line selection */
> -enum ssb_mitigation_cmd {
> -	SPEC_STORE_BYPASS_CMD_NONE,
> -	SPEC_STORE_BYPASS_CMD_AUTO,
> -	SPEC_STORE_BYPASS_CMD_ON,
> -	SPEC_STORE_BYPASS_CMD_PRCTL,
> -	SPEC_STORE_BYPASS_CMD_SECCOMP,
> -};
> +static enum ssb_mitigation ssb_mode __ro_after_init =
> +	IS_ENABLED(CONFIG_MITIGATION_SSB) ? SPEC_STORE_BYPASS_PRCTL : SPEC_STORE_BYPASS_NONE;

Other mitigations default to "AUTO", but not this one. Isn't that something
that attack-vector controls rely on?

