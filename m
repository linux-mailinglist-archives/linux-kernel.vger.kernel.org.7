Return-Path: <linux-kernel+bounces-779025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D25B2EE0C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AE01C233F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AFD261B70;
	Thu, 21 Aug 2025 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+MnbAwZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD943253B64
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757105; cv=none; b=IAEd8vIWbdaHXzESdxGd3tvVlsVC7ltl8Rgx7GM2WVpBn7+QsBCaP4VzdlzkOAQqZy7RHvZq3LCDQD8g5vgzqZ0GrCNKHCgjxGemXvXK+5DZNs/oo4YeFJOaHIQhorksf4Q70sdIG75Oj1hFdS5oCE4dMV2VftAX8Gq+FH6ntts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757105; c=relaxed/simple;
	bh=a5NB4YSnjNykT3B7T37kW69kXSRi/DEs+BwKmL5VXzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEg/oUcJgb2MKfCmP6ccENUuX44VdA05B/F4GqHd1qhTZ4lFm6ieu1UPxUG3he6kYltqNj8CXGUqAVEWLROIP6gCFqe278UDe8P9Tef0v/wt44RAkyTWrYknQ+4aEA87msba64wd65ZzbanV8hnsTPg80ALQAL277WYN/aUfUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+MnbAwZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755757104; x=1787293104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a5NB4YSnjNykT3B7T37kW69kXSRi/DEs+BwKmL5VXzQ=;
  b=M+MnbAwZZL0S3tL1Y4nEg6TS6VF0vRFtpc7dWg5XEoYTAhyUnG4deHNR
   OCJI9WzWfNMYnDToqvgWphGTmzBBVS3b3D2MUbvnpult3GkeNCUWUPnHD
   ePACOLFY2m68hQgbx9RMD10bVmFgxGeWsA8KA5qtIA5Z0l1OTBmGJlzxh
   jJunv7nLD1hZGZFojr6qOP6FJxYXuN1GRiQCM3h8VL+jgrWUdvmmcSkJE
   gVVZt+p16WV7lZU/1RdRO79uFex6oKYpvGbYr7cArf3iUmcv6egZiA1vU
   3dg8jKQ5vgIevF6a8ExZSyYt2lxZYQfInZbsb4YQwo/YL7hg8XXTq2DK+
   g==;
X-CSE-ConnectionGUID: 0FsvIJoQThO8Jp8WBLek0g==
X-CSE-MsgGUID: wmv0nSCvQLGyMhtc7VkQew==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69137212"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="69137212"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 23:18:23 -0700
X-CSE-ConnectionGUID: uAFHpS/OS0GnYLggw9sLyw==
X-CSE-MsgGUID: B8Jq0RsrQLOYYPsrms6H1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="173590857"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 23:18:22 -0700
Date: Wed, 20 Aug 2025 23:18:17 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Bugs clean-up
Message-ID: <xbegna7ztb525ri2l76pd3uyh4rdmtj76enf4ad4ekvilkxygp@h3uoy2hjyfqy>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819192200.2003074-1-david.kaplan@amd.com>

On Tue, Aug 19, 2025 at 02:21:55PM -0500, David Kaplan wrote:
> Patches 1-3 focus on cleaning up parameter parsing.  Most mitigations use
> early_param but a few older ones do not and look at boot_command_line
> directly.  Modify those to be consistent with the newer ones.
> 
> Patch 4 adds missing attack vector controls for spec store bypass.
> 
> Patch 5 cleans up straggling unnecessary calls to cpu_mitigations_off().
> 
> Changes from v1
>    - Removed spec_*_print_cond() functions
>    - Fixed bugs pointed out by Pawan
>    - Added last 2 patches
> 
> David Kaplan (5):
>   x86/bugs: Use early_param for spectre_v2_user
>   x86/bugs: Use early_param for spectre_v2
>   x86/bugs: Simplify SSB cmdline parsing
>   x86/bugs: Add attack vector controls for SSB
>   x86/bugs: Remove uses of cpu_mitigations_off()

For the series:

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

