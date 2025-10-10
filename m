Return-Path: <linux-kernel+bounces-848660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B14BCE47C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756A1405DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1BE241665;
	Fri, 10 Oct 2025 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aa+mkSfP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60D227BB9
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760122053; cv=none; b=n0p9mqn5vpq339oWLhFHqFFxkzgBjLp1jkvuAzJN5mCFJWekhVkINLkHvib0LgUibV+2bcCUxhITB3Wky7iaTlzsz++bRnE22PQ5suiQsoOum+auJQuPI4/fvYkROg9+7cz5FOnA3YU8sWRr3KY9Drbj2H7gyL5U846YOXpLYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760122053; c=relaxed/simple;
	bh=+C8MHFN7alGE2ttgvWQ69VfSvOw2ma9mSBP8U87T+8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1+MkIcxaIyAgGfa/1k8pzu3Fs6QyOLcW68GTdyJ4vvT6kJejVuPeUW9I25DYytAsqP5Q9mZfr5dlSZHlGyRYEO8PGhIaRyXFXDkDLnWwWGW/4QcQHO7CRtQmIu8KA95x8Tt0uVLdQRWDEl53Kj8fq0a6/FRuF1cO/TBjUvkKhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aa+mkSfP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760122051; x=1791658051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+C8MHFN7alGE2ttgvWQ69VfSvOw2ma9mSBP8U87T+8w=;
  b=Aa+mkSfPK584J5BFKyp8IUnXDCjryA8H1bE6BMellnwiLEFiv5aYxFiR
   YHYPcgfSHFCQj2Du0c/PJ84A62sjRFyLLGpnaHbsURE4ZwC4Pm97DIaSp
   xYEdH3KVjFVh+Wb+qOQeNwydQqtcpfomHYuf9WRQi9t4+CQDvPVDJDD7p
   QJ1xNMsCxQI4faEUmk+XsIDJJ+ocgDPS6BXddj9R8Qkk4SrlV0k+B0Ho3
   zAsEzFm26PUYitQHEBaGt1EGqSCR2Hp2NKTuIFe15lCu/SMcXIWwKf1WR
   JjJcTQQRLNvfcwlyot2KZWwzjqDeI7lUcrctNHIoZ+gW/WY/TaOMjbXoc
   A==;
X-CSE-ConnectionGUID: d9NbSFtvQAWu/79DUjVPPQ==
X-CSE-MsgGUID: kVC/vD8sQWS7EsLOtEbTLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="79788780"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="79788780"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 11:47:31 -0700
X-CSE-ConnectionGUID: hnloXv4GSMqMicqTtQB6FQ==
X-CSE-MsgGUID: fH/kv7+jQeisZtDuB1bfqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="186175193"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 11:47:30 -0700
Date: Fri, 10 Oct 2025 11:47:25 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "Kaplan, David" <David.Kaplan@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Klaus Kusche <klaus.kusche@computerix.info>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <jlwwd3ohjr7a6lnd4ehu4lp7ys7tm7f6rlaxyc75725thvil4k@pf3bm243ncys>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251009053336.ghcmhgsprtkgydas@desk>
 <xhxfkzrrn62xkd6moiapfueookui5f63x4lmzgkmnf3mbxilb5@kk4rylukegii>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhxfkzrrn62xkd6moiapfueookui5f63x4lmzgkmnf3mbxilb5@kk4rylukegii>

On Thu, Oct 09, 2025 at 06:10:42PM -0700, Josh Poimboeuf wrote:
> On Wed, Oct 08, 2025 at 10:33:36PM -0700, Pawan Gupta wrote:
> > On Tue, Oct 07, 2025 at 05:14:29PM -0700, Josh Poimboeuf wrote:
> > > On Tue, Oct 07, 2025 at 04:08:21PM -0700, Pawan Gupta wrote:
> > >   MITIGATION_RETPOLINE -> X86_UGLY_INDIRECT_THUNKS
> > >   MITIGATION_RETHUNK   -> X86_UGLY_RETURN_THUNKS
> > > 
> > >   etc...
> > > 
> > > Then one only needs to grep their .config file for UGLY to understand
> > > why their disassembly is so inscrutable ;-)
> > 
> > :-) Agree, this is ugly. One way to handle this could be two levels of
> > Kconfig options like below:
> > 
> > * CONFIG_MITIGATION_FOO			- Compiles out the mitigation
> 
> Maybe, though compiling out individual features would be complicated by
> the fact that we have dependencies between several of the mitigations,
> as evidenced by *_update_mitigation().

My thought was separate them out as:

- Generic mitigation like,
  CONFIG_MITIGATION_CLEAR_CPU_BUFFERS
  ...
  which are not directly user selectable.

- Vulnerability based mitigation like,
  CONFIG_MITIGATION_MDS
  CONFIG_MITIGATION_TAA
  CONFIG_MITIGATION_MMIO
  CONFIG_MITIGATION_TSA
  ...
  which are user selectable, and does:
  
    select CONFIG_MITIGATION_CLEAR_CPU_BUFFERS

  When none from this category is selected,
  CONFIG_MITIGATION_CLEAR_CPU_BUFFERS stays unset. All of VERW sites can
  then use CONFIG_MITIGATION_CLEAR_CPU_BUFFERS to not generate NOPs/JMPs as
  well.

> >   * CONFIG_MITIGATION_FOO_DEFAULT	- Sets the bootup default
> 
> I'm wondering if we can just get rid of the compiled-in defaults.  Do
> people really need that anymore, now that we have the attack vector
> controls?  We could instead have
> 
>   CONFIG_CPU_MITIGATIONS_OFF
>   CONFIG_CPU_MITIGATIONS_AUTO
>   CONFIG_CPU_MITIGATIONS_AUTO_NOSMT
> 
>   CONFIG_CPU_MITIGATIONS_USER_USER
>   CONFIG_CPU_MITIGATIONS_USER_KERNEL
>   CONFIG_CPU_MITIGATIONS_GUEST_HOST
>   CONFIG_CPU_MITIGATIONS_GUEST_GUEST
> 
> ... which should cover the main cases.  And of course there's always
> CONFIG_CMDLINE for more customization.

That works too.

> >   select X86_UGLY_INDIRECT_THUNKS
> 
> Unfortunately it's not always straightforward enough to say "mitigation
> FOO always needs X ugly feature".
> 
> For example, newer CPUs mitigate Spectre v2 with enhanced IBRS, so they
> don't necessarily need all the retpoline and legacy IBRS stuff.  So
> CONFIG_MITIGATION_SPECTRE_V2 shouldn't enable those unconditionally.

A more conservative approach can work here that selects a supporting
mitigation even though not all CPUs need it.

> Instead, CONFIG_MITIGATION_SPECTRE_V2 could enable a submenu which then
> allows the user to enable retpoline, IBRS on entry, etc, with each
> having help text describing what generations of CPUs it would be the
> default for, to help guide the user to choose sane defaults depending on
> their CPU:
> 
>   * CONFIG_MITIGATION_SPECTRE_V2
>     * CONFIG_MITIGATION_SPECTRE_V2_RETPOLINE
>       select CONFIG_BUILD_INDIRECT_THUNKS
>     * CONFIG_MITIGATION_SPECTRE_V2_IBRS
>       select CONFIG_BUILD_IBRS_ENTRY

That would be good if a kernel is built for certain specific CPU(s). This
may not be ideal for distro kernels.

