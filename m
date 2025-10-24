Return-Path: <linux-kernel+bounces-868013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC3AC0426E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0953B84D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEEE261393;
	Fri, 24 Oct 2025 02:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hv3Ne8UL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83E265606
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273664; cv=none; b=UBym/vXhRbVqHdVKrlSPjCdECW3/ZzUUIjz5Ks/QKESCqAY7OYvurqBxMvR6ISuSCXOOAZdbj3rwSl+/f5xyVfgC1fDMXkj6mRjAV/TIxB3/TuL2caHOK7H7lCsq9ydtRxqOmMrXCb2A5K3wzZwLDglFZrJTTeoskGIUVCt/stQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273664; c=relaxed/simple;
	bh=8YFtz6v8jIblfbwJI3OsToIjDVoBzVcovG3KIsIKfOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEY4HngVCAyaG1+okEtr+kJJxIRdDPmC4teq2Pk9dG6VAtZrzD8RJsF73z4DcVGl/PEUTZnRJWTDqqryveUE8iGbG44AwbZHOZehiJTpz+udtikPjVLC4nI/N2VrLqI2nwul1alX9DnFDrfUBIl8H9Wfu63tQaf1GZ7UY3V76W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hv3Ne8UL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761273662; x=1792809662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8YFtz6v8jIblfbwJI3OsToIjDVoBzVcovG3KIsIKfOE=;
  b=hv3Ne8ULPhe0Hc9J61DUlOx8xRy6fCj1iaFzZZhpvSBVqvgg2qILK8+N
   Vw7RnSQODUSioA8+oPuEZMtDkChe9IrcD2N1/Lf+36jFM1FNUGIaj+gpU
   bn2ABezYsmXIqoYL5/OrwjlkaYzX9XF6ttY2ALGTe89tWdQ9lhnpir5rU
   7AoYK0sROc18h66wGSmwUDHDVGBIFzxntM8/1V5GB2iZ/oXsT82kKore7
   FzFqDpXIHPcWd4keS1Yccsco0ApCOA+0UdLFH/xu9Oob0piDZbBv0gHso
   a4W8snvteHY39U5B1aga2kEe0k1E4AoRMyJ3Vznxs1jDOW1bsZ0caCCvE
   Q==;
X-CSE-ConnectionGUID: 5q70VdVeRJOGpcjV882vSQ==
X-CSE-MsgGUID: 37cF9gZOQlOlD1DcGAofgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63548183"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="63548183"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 19:41:01 -0700
X-CSE-ConnectionGUID: egCfYXu3QcuzL56y3VX8Jw==
X-CSE-MsgGUID: ef/zJqLyTtGueZOwY7SzIg==
X-ExtLoop1: 1
Received: from jjgreens-desk21.amr.corp.intel.com (HELO desk) ([10.124.221.191])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 19:41:01 -0700
Date: Thu, 23 Oct 2025 19:40:54 -0700
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
Subject: Re: [RFC PATCH 14/56] x86/bugs: Reset GDS mitigations
Message-ID: <20251024024054.6gum6dmztyrd6u46@desk>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-15-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013143444.3999-15-david.kaplan@amd.com>

On Mon, Oct 13, 2025 at 09:34:02AM -0500, David Kaplan wrote:
> Add function to reset GDS mitigations back to their boot-time defaults.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 112553058ccc..e765ac0b9240 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1182,6 +1182,18 @@ static void __init gds_apply_mitigation(void)
>  	pr_info("%s\n", gds_strings[gds_mitigation]);
>  }
>  
> +#ifdef CONFIG_DYNAMIC_MITIGATIONS
> +static void gds_reset_mitigation(void)
> +{
> +	/* To cause the MSR bit to be cleared. */
> +	gds_mitigation = GDS_MITIGATION_OFF;
> +	if (x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)
> +		update_gds_msr();

This also needs to check for GDS_MITIGATION_FULL_LOCKED, otherwise in the
locked case it would trigger this warning in update_gds_msr():

	WARN_ON_ONCE(mcu_ctrl != mcu_ctrl_after);

