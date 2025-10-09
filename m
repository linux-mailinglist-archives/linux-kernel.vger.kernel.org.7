Return-Path: <linux-kernel+bounces-847357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D598BBCA9C6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34A4189C477
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C7824677D;
	Thu,  9 Oct 2025 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGCAseqb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACB0A31
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035903; cv=none; b=QJVQKXRkOrO1O4nTFnKCQKwe8Olbj2Ppy1OH0OoJyiqV7RZwSWCiFGomuudmZJwSznYq0vETkkGA93jaqShwGBc0rcO4sXQF3IVK4plkXiZFTasPyOrwOVAjVQVY1AuRwAS3OBDUmLq2UpJv+2TeRkDS+48q/WDGxyLcUIEtfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035903; c=relaxed/simple;
	bh=+8DQ1rdPBCsqlPlvKSOmFMMm1CihXWFpKFeQRTzrxDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzohAeipKA1XWmPyfUh+92hR0jBr3yD3vn1EHxVedXJsNrMjFY64B2rlV5pPbABqiFSa02Zc5ofQHz9cF4VKah/ayyNY+usUBNjf5PDfWFogpqig7DzaiQ17FQInmCb1D34R7h7pVxUM04rbK9YIP40mPH5NhRjwXm8WcF1GiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGCAseqb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760035901; x=1791571901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+8DQ1rdPBCsqlPlvKSOmFMMm1CihXWFpKFeQRTzrxDA=;
  b=aGCAseqb5GIl/nn1I5IzyLkh2G2oarAb8Qwky0zKwe9TY18W16eaLvjv
   EX3Vp7RjKtZxIjp8S0zG4MPqiS/HdajJCPNSI1mIWpUeMMr0WhCAC0W0j
   wJzEx4oTWdQdrVW/uMS1w/31Zc56g0uP7tMCzXHQd/0wlDUuTS/rmCyop
   fM+xJj1savh1JHYNYrUk82PpunSGhSQOeu+PY7B5zPjQ05qwrCLsPGfc1
   vuItD+ysCTTQjW3B0Li8mFFwQHdNM0tm51MeNkQ1+QMt37h3iHAUilMxj
   KQDN3eEvU7JNY0iL81eXag3rfDbb/iJblyFWsYxzNhWlMZiIw1x/GVQ1H
   w==;
X-CSE-ConnectionGUID: AWcf3eXCRiqSV8am3oyWWw==
X-CSE-MsgGUID: BwXRxFqFTdSuG3di8gfuuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11577"; a="73687504"
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="73687504"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 11:51:41 -0700
X-CSE-ConnectionGUID: dN7/l47MT4ar3RirsmX4uA==
X-CSE-MsgGUID: n1SjkPRWSmu49jPj7OL+AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="180384386"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO desk) ([10.124.221.52])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 11:51:41 -0700
Date: Thu, 9 Oct 2025 11:51:34 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/tsx: Get the tsx= command line parameter with
 early_param()
Message-ID: <20251009185134.fb4evjrk76rwxv37@desk>
References: <cover.1758906115.git.ptesarik@suse.com>
 <63118e583443490a285fd194baeae874d65eff87.1758906115.git.ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63118e583443490a285fd194baeae874d65eff87.1758906115.git.ptesarik@suse.com>

On Fri, Sep 26, 2025 at 08:01:02PM +0200, Petr Tesarik wrote:
> Use early_param() to get the value of the tsx= command line parameter.
> Although cmdline_find_option() works fine, the option is later reported
> as unknown and passed to user space. The latter is not a real issue, but
> the former is confusing and makes people wonder if the tsx= parameter had
> any effect and double-check for typos unnecessarily.
> 
> The behavior changes slightly if "tsx" is given without any argument (which
> is invalid syntax). Prior to this patch, the kernel logged an error message
> and disabled TSX. With this patch, the parameter is ignored. The new
> behavior is consistent with other parameters, e.g. "tsx_async_abort".
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  arch/x86/kernel/cpu/tsx.c | 41 ++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
> index 167dfd38b87a2..bb407331f64b5 100644
> --- a/arch/x86/kernel/cpu/tsx.c
> +++ b/arch/x86/kernel/cpu/tsx.c
> @@ -20,14 +20,14 @@
>  #define pr_fmt(fmt) "tsx: " fmt
>  
>  enum tsx_ctrl_states {
> +	TSC_CTRL_UNSPECIFIED,

s/TSC/TSX/

>  	TSX_CTRL_ENABLE,
>  	TSX_CTRL_DISABLE,
>  	TSX_CTRL_RTM_ALWAYS_ABORT,
>  	TSX_CTRL_NOT_SUPPORTED,
>  };
>  
> -static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =
> -	TSX_CTRL_NOT_SUPPORTED;
> +static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init;
>  
>  static void tsx_disable(void)
>  {
> @@ -164,11 +164,28 @@ static void tsx_dev_mode_disable(void)
>  	}
>  }
>  
> -void __init tsx_init(void)
> +static int __init tsx_parse_cmdline(char *str)
>  {
> -	char arg[5] = {};
> -	int ret;
> +	if (!str)
> +		return -EINVAL;
> +
> +	if (!strcmp(str, "on")) {
> +		tsx_ctrl_state = TSX_CTRL_ENABLE;
> +	} else if (!strcmp(str, "off")) {
> +		tsx_ctrl_state = TSX_CTRL_DISABLE;
> +	} else if (!strcmp(str, "auto")) {
> +		tsx_ctrl_state = x86_get_tsx_auto_mode();

NACK, this introduces a subtle bug. With this change x86_get_tsx_auto_mode()
would return TSX_CTRL_ENABLE always, irrespective of whether the CPU has
X86_BUG_TAA or not. This is because early_param() is executed before
cpu_set_bug_bits().

> +	} else {
> +		tsx_ctrl_state = TSX_CTRL_DISABLE;
> +		pr_err("invalid option, defaulting to off\n");
> +	}
>  
> +	return 0;
> +}
> +early_param("tsx", tsx_parse_cmdline);

Rather, a patch to add a comment would be better.

---
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 49782724a943..8fd1c16a38ec 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -194,6 +194,11 @@ void __init tsx_init(void)
 		return;
 	}
 
+	/*
+	 * Cmdline is not processed via early_param() to ensure
+	 * cpu_set_bug_bits() is executed already. And x86_get_tsx_auto_mode()
+	 * returns the appropriate default based on X86_BUG_TAA.
+	 */
 	ret = cmdline_find_option(boot_command_line, "tsx", arg, sizeof(arg));
 	if (ret >= 0) {
 		if (!strcmp(arg, "on")) {

