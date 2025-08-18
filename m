Return-Path: <linux-kernel+bounces-774249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F99B2B06C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF4C683B25
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEDA7404E;
	Mon, 18 Aug 2025 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KE9JaQre"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FDA125B2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541888; cv=none; b=erz9++0S1n1Hp8fIAdtW9rVhzZhC2CU+YxyQXq7UsW+v+IvCzDm8S5+1Cgo7pqkMnnP9AKDqdqy3zR6/Z+VtpNI0m/1ODX+lXcryUpuWnikVxSoIEWZVkqxAJ3f9+scYzZHZmmisYPEzp74SPteDCPa4NOQUu2fgNq3Je5nnIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541888; c=relaxed/simple;
	bh=5qH1WXqXNDKUBIxH3jOpJAOIJkCz/0HUTVg0VdGaCgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFaqO3A1Tk27QsRV1b41yBTaN7gikjMm4i3CVqGu/V2fwseW+ft4EktK+rn9OwlNjsZGFfASFBhe1nOVImnHGLGe9ejt4DZqd83bldV3Gs/XOPR4a/amK9IBLTmpal6+wCX4NuPAg2cldupOuR2IceWwaOxyL1ocv5njP4ujtQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KE9JaQre; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755541887; x=1787077887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5qH1WXqXNDKUBIxH3jOpJAOIJkCz/0HUTVg0VdGaCgs=;
  b=KE9JaQreUtzFlwdsC9GfJX9skfWyxW5FjUKbB70desaCpx46ztbafBX0
   FyVsGU3Gc7E9bb1yengAErBKMfU25zE9g/a6nfLhLIbOwa1IfciP+o21A
   +raClyouEMtaUV8i/g/xMkoz6svrT4YOYToSKbnp7Y65ny1BTCbb7zrLB
   TzHRL/6RVkAANoOd+E8zwobt77GawRkqng494JUuiKC8F6dIBEwv6nG9I
   tVv4d6sdzBP/UaSDIeQvaIYBHeBF6DMNDJcwAvuuymSQ9pAqLuYN6iaOM
   yM7yk5k43ZYdjvPcEflryejC9ZJTKaZZWTxKe9KqFc6rB47dw4xSxrnHd
   g==;
X-CSE-ConnectionGUID: ezeY9GznTWG1rQbzqnhvLw==
X-CSE-MsgGUID: 5hq6L5NsQyWeeR0PskZZFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57486357"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57486357"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 11:31:27 -0700
X-CSE-ConnectionGUID: BUsUQZdhT5ue299kFgWATQ==
X-CSE-MsgGUID: iZYTd31tSUmyHS/GubUxMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="168001309"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO desk) ([10.124.220.33])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 11:31:26 -0700
Date: Mon, 18 Aug 2025 11:31:20 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] x86/bugs: Simplify SSB cmdline parsing
Message-ID: <20250818183120.gxeptjocg6ur6jvo@desk>
References: <20250811142659.152248-1-david.kaplan@amd.com>
 <20250811142659.152248-4-david.kaplan@amd.com>
 <20250818174157.c6bzy5bgw54fopgi@desk>
 <LV3PR12MB92653604B5839C580C4BA1949431A@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3PR12MB92653604B5839C580C4BA1949431A@LV3PR12MB9265.namprd12.prod.outlook.com>

On Mon, Aug 18, 2025 at 05:55:35PM +0000, Kaplan, David wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Sent: Monday, August 18, 2025 12:42 PM
> > To: Kaplan, David <David.Kaplan@amd.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Peter
> > Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; Ingo
> > Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> > x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 3/3] x86/bugs: Simplify SSB cmdline parsing
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Mon, Aug 11, 2025 at 09:26:59AM -0500, David Kaplan wrote:
> > > Simplify the SSB command line parsing by selecting a mitigation directly,
> > > as is done in most of the simpler vulnerabilities.  Use early_param instead
> > > of cmdline_find_option for consistency with the other mitigation
> > > selections.
> > >
> > > Signed-off-by: David Kaplan <david.kaplan@amd.com>
> > > ---
> > >  arch/x86/kernel/cpu/bugs.c | 118 ++++++++++++-------------------------
> > >  1 file changed, 39 insertions(+), 79 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > > index 19a3891953c3..3766dff9a699 100644
> > > --- a/arch/x86/kernel/cpu/bugs.c
> > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > @@ -2625,16 +2625,8 @@ void cpu_bugs_smt_update(void)
> > >  #undef pr_fmt
> > >  #define pr_fmt(fmt)  "Speculative Store Bypass: " fmt
> > >
> > > -static enum ssb_mitigation ssb_mode __ro_after_init =
> > SPEC_STORE_BYPASS_NONE;
> > > -
> > > -/* The kernel command line selection */
> > > -enum ssb_mitigation_cmd {
> > > -     SPEC_STORE_BYPASS_CMD_NONE,
> > > -     SPEC_STORE_BYPASS_CMD_AUTO,
> > > -     SPEC_STORE_BYPASS_CMD_ON,
> > > -     SPEC_STORE_BYPASS_CMD_PRCTL,
> > > -     SPEC_STORE_BYPASS_CMD_SECCOMP,
> > > -};
> > > +static enum ssb_mitigation ssb_mode __ro_after_init =
> > > +     IS_ENABLED(CONFIG_MITIGATION_SSB) ?
> > SPEC_STORE_BYPASS_PRCTL : SPEC_STORE_BYPASS_NONE;
> >
> > Other mitigations default to "AUTO", but not this one. Isn't that something
> > that attack-vector controls rely on?
> 
> I hadn't modified SSB in the initial attack vector series because SSB
> mitigation was never actually turned on (set to
> SPEC_STORE_BYPASS_DISABLE) by default.  The default option requires
> applications to opt-in to mitigation.

I think of it as mitigation being conditionally enabled (for applications
opting in).

> However this probably could be done better by saying that ssb defaults to
> SPEC_STORE_BYPASS_PRCTL if the user->user vector is enabled...and
> otherwise it is SPEC_STORE_BYPASS_NONE, since the default ssb mitigation
> is only for applications that want to protect themselves.
>
> I can do that in a separate patch in this series after this clean-up
> patch if that sounds reasonable.

Sounds good to me. Thanks.

