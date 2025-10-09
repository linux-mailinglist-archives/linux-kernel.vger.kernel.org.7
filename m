Return-Path: <linux-kernel+bounces-846269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD036BC76FF
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF3444F0C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DED25CC58;
	Thu,  9 Oct 2025 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRyYd/AX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9D54279
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759988025; cv=none; b=GmTReMgtHePNdOBeiwzt7hzqsG5H8P3RH7nLXSYTqHTa6zOGEaBOk+P6paH7NHUNWzHCch5hzrPzcX9zl9UVpYS/HXs1nsTdeBEsl356uFiYfNH3DeI+jHyCZyvC6gX7e6YNQfamoODJxOhW4WutLuQ71GS7vbJwLueP/AyMVTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759988025; c=relaxed/simple;
	bh=Z2vlM+XN8sLM91x1W/u5Iv07npkhKpqxbBNkugxEY6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfKNsVQwnT1q9939x42FAkst0DDpQFgdre6rlvMPUXxFT24JYY2VeG0BHSDz5+u6I5CXm9fsQFdsKdgwg57iwSKWCut+bvnNeQxl7K0Am9jzJ97MjrDhUB5ABRboJ0/BRmdjYY4EGpRPH084H4e84wfMVXzsaaAZsHrs326xS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRyYd/AX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759988024; x=1791524024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z2vlM+XN8sLM91x1W/u5Iv07npkhKpqxbBNkugxEY6o=;
  b=JRyYd/AXus7qLElsxaFJDLt6pkArdYUWVqNQn5PQt5rYbFI38WmxICZ1
   traFcBzrVSvbiwEI13i21jkGozR73p4Go3WT4PCT2nFDOBMILilET1GKp
   ua3ERYmlS4qBYR3yT57nMYEbB+14hpvUNWW+gm+74Xdo+05BWI5YrONpR
   8A81jAVjr5Tsgqt8gp0b6MRV0P0JJf/BArfw5UJA9luEyCMKcwcSZVsrE
   wx21L/qe8viO0ZXV3B81pyZxSKpzHwGVbKYtm7WLfkR+oQqFWoRSaAzHH
   hV50X1Fjjr0fZRIBzcbl/DQnJRfb+51ifPEWrT6ByU2+dbUhL1RchCazT
   w==;
X-CSE-ConnectionGUID: p13V6e4UQbqc/A2xk0fnJQ==
X-CSE-MsgGUID: y6U5LsqfR2e+1KiNZSeE4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="65836658"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="65836658"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 22:33:43 -0700
X-CSE-ConnectionGUID: OIR2p2aGS3SEW4npVDIiog==
X-CSE-MsgGUID: WoiAD0xDRVu0rNcngpzgEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="211574644"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO desk) ([10.124.220.183])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 22:33:42 -0700
Date: Wed, 8 Oct 2025 22:33:36 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Klaus Kusche <klaus.kusche@computerix.info>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <20251009053336.ghcmhgsprtkgydas@desk>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>

On Tue, Oct 07, 2025 at 05:14:29PM -0700, Josh Poimboeuf wrote:
> On Tue, Oct 07, 2025 at 04:08:21PM -0700, Pawan Gupta wrote:
> > On Wed, Oct 08, 2025 at 12:12:29AM +0200, Borislav Petkov wrote:
> > > On Tue, Oct 07, 2025 at 11:22:57AM -0700, Pawan Gupta wrote:
> > > > IMO, rather than targeting the mitigation enabling code it might make more
> > > > sense to compile out the actual mitigations scattered accross the kernel.
> > > > This may also improve performance by reducing the code footprint, and can
> > > > also help getting a cleaner disassembly.
> 
> Isn't that what CONFIG_CPU_MITIGATIONS=n already does today?

Not entirely, looking at entry_64.o for example, I see 243 NOPs with
CONFIG_CPU_MITIGATIONS=n. I suspect a lot of them are due to ALTERNATIVEs
for mitigations. In the same file, clear_bhb_loop() is not compliled out
and adds ~160 bytes.

Another example is process.c which still contains below functions:

0000000000000000 <speculation_ctrl_update_tif>:
00000000000008b0 <speculative_store_bypass_ht_init>:
0000000000000980 <speculation_ctrl_update>:
0000000000000c30 <speculation_ctrl_update_current>:

> > > Probably... however, it needs to be done smartly because sprinkling ifdeffery
> > > and turning what is an already unreadable mess into a bigger abomination,
> > > won't fly. Perhaps split out the mitigations glue into separate compilation
> > > units and build-disable them... we'll see.
> > 
> > Ya, that would be better.
> 
> On a sort of related note, it's confusing that there are two completely
> different classes of MITIGATION options which get conflated:
> 
> 1) compile the kernel with support for certain mitigations:
> 
>     MITIGATION_RETPOLINE
>     MITIGATION_RETHUNK
>     MITIGATION_PAGE_TABLE_ISOLATION
>     MITIGATION_UNRET_ENTRY
>     MITIGATION_CALL_DEPTH_TRACKING
>     MITIGATION_IBPB_ENTRY
>     MITIGATION_IBRS_ENTRY
>     MITIGATION_SRSO
>     MITIGATION_SLS
> 
> 2) enable bug-specific runtime defaults:
> 
>     MITIGATION_GDS
>     MITIGATION_RFDS
>     MITIGATION_SPECTRE_BHI
>     MITIGATION_MDS
>     MITIGATION_TAA
>     MITIGATION_MMIO_STALE_DATA
>     MITIGATION_L1TF
>     MITIGATION_RETBLEED
>     MITIGATION_SPECTRE_V1
>     MITIGATION_SPECTRE_V2
>     MITIGATION_SRBDS
>     MITIGATION_SSB
>     MITIGATION_ITS
>     MITIGATION_TSA
>     MITIGATION_VMSCAPE
> 
> In general, #1 uglify the kernel.  And some #2 depend on #1.
> 
> IMO, we should rename the #1 options.  For example:
> 
>   MITIGATION_RETPOLINE -> X86_UGLY_INDIRECT_THUNKS
>   MITIGATION_RETHUNK   -> X86_UGLY_RETURN_THUNKS
> 
>   etc...
> 
> Then one only needs to grep their .config file for UGLY to understand
> why their disassembly is so inscrutable ;-)

:-) Agree, this is ugly. One way to handle this could be two levels of
Kconfig options like below:

* CONFIG_MITIGATION_FOO			- Compiles out the mitigation
  * CONFIG_MITIGATION_FOO_DEFAULT	- Sets the bootup default
  select X86_UGLY_INDIRECT_THUNKS

Then supporting mitigation like INDIRECT_THUNKS would only be enabled if
there is a dependent mitigation enabled.

