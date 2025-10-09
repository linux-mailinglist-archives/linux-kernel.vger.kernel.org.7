Return-Path: <linux-kernel+bounces-846295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49231BC77C6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7293E6D64
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54304293C44;
	Thu,  9 Oct 2025 06:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bs1HyzuV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AFE28E571
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989882; cv=none; b=MLyzCePxabJzn1q5H8XUOooGcC670/Nv93uo5KHx7t6TlfsbR7a7YhbVnNCsovQ2Ctsnwwkkm+chgC/QfbuHJCx7+FH9xE9bAIov/alZ9Jy6R0rok4UhIqX1s7G6WDHgbWK5CZGzGLn8zvu7P1rhBG1TJvW4RT5Lmbi3wXHdfj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989882; c=relaxed/simple;
	bh=YL+0zTQV2cCrw6w3DDtrszQnwQQe3CfuAxyQTWyVVMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3/vFYiT2puMgMSFQL6INHubFphT8gUgKd2JAu8Ny7N2j7s8PHrEVlEUsUzBjpRoF/MCg397vfUgod6iqu4lkwYPtOgOu59S500zilEjYwsrgTrevE7rx3IFDB9CFVgjiVUnGIg9QhhSGEm00UWkjK4F2m781AFD64Nz/em5+zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bs1HyzuV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759989881; x=1791525881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YL+0zTQV2cCrw6w3DDtrszQnwQQe3CfuAxyQTWyVVMw=;
  b=bs1HyzuVTfOXuWlzvD1s3mu3MRWm9Tgcaw846hljI+SwpT9BmMC/f+XA
   rnPUvH4gX3EZHW0cbFIeDaBNnJ38/0QC48c3sU/sYoA+ujM4VAeKjr02U
   Is9LZvLgo4hRH6JKAypwmk9KxcB9Ov5Ag+MHJg9R450JiwgGBpXLPRaiX
   KpEX16rHPXFv41ipWUg7LwhFImN7pl6rZDEWt+DqjZWAxWA7SIrqwrL2w
   pEFlIxYokcyCIXz/UYv8DQoYdXg9079m9sdvo5LhYWPdCvP1RgDJi3jLY
   JEiJdJZdtV6UZ3iWhu5Ex4CQBhC1Sy/9RMxn5dzHEDR3PXNFjI30AE9XZ
   Q==;
X-CSE-ConnectionGUID: ITp8dvx4Q4CMzFwaeSKZLA==
X-CSE-MsgGUID: LEXx7OxsQzGfcDjQCIpdSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="73620121"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="73620121"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 23:04:40 -0700
X-CSE-ConnectionGUID: tsWIBUrhQCalcTif+YLI3w==
X-CSE-MsgGUID: jGJRev0oTYSF7hrrYQSAVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="185003925"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 23:04:39 -0700
Date: Wed, 8 Oct 2025 23:04:32 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, 
	"Kaplan, David" <David.Kaplan@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Klaus Kusche <klaus.kusche@computerix.info>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <pnobm2r4icma6xzxvzklxoyoy3a4yhhxuxdoq2srmz6rpnegms@qneijnfu6fmz>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251008102136.GAaOY7MBd4_VBPBNtG@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008102136.GAaOY7MBd4_VBPBNtG@fat_crate.local>

On Wed, Oct 08, 2025 at 12:21:36PM +0200, Borislav Petkov wrote:
> On Tue, Oct 07, 2025 at 05:14:29PM -0700, Josh Poimboeuf wrote:
> > Isn't that what CONFIG_CPU_MITIGATIONS=n already does today?
> 
> I'd like =n to mean, code is not compiled in.
> 
> We do have some savings:
> 
>    text	   data	    bss	    dec	    hex	filename
> 136442490	9737118		36764336	182943944	ae780c8	vmlinux 	# CONFIG_CPU_MITIGATIONS is not set
> 138493310	10692818	37741668	186927796	b244ab4	vmlinux		# CONFIG_CPU_MITIGATIONS=y

I guess bulk of these savings are comming from CALL_THUNKS that force 16
byte function alignment.

> but look at bugs.o:
> 
> # CONFIG_CPU_MITIGATIONS is not set	599K arch/x86/kernel/cpu/bugs.o
> # CONFIG_CPU_MITIGATIONS=y		625K arch/x86/kernel/cpu/bugs.o
> 
> and those unused 600K still go into vmlinux:

Thats a lot. OTOH, most of the bugs.c is __init code, do you think it is
still problematic?

