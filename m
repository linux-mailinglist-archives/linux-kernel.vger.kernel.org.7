Return-Path: <linux-kernel+bounces-844629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E609BC25FB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080283BF91D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E662E7BDF;
	Tue,  7 Oct 2025 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBpN8GEl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A352B661
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861387; cv=none; b=ZlCvpkd+5Q21LBFGGFKJP1WXtCUwYXK7qOL+d5Ie94KKoMGjJavM6rdmmQsDh97qlOZiFkqy+wcsLAglKMOB2hPCibWyyiuW3xaeA38Z6Weu89yS07oUn5sVhgplQg4zpaAMEIuzUvLQakji/hXjem1XGLYrSYNFlTHQMAT3WUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861387; c=relaxed/simple;
	bh=lxcxiGcnSQhOw8q03P3pElZ1Cb5DunYGWxewnXa2vaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcX7djRQtFE4M3WahgeLRjE6aHnfjjAgAzLiRDJ539hDzYPbChvq485PUD6Qze0sOFCP4FlmtVdOWBOaRV1kL/Y/pznEQgA/ft8HKWU82f8SNXA1o/E9fkvb9mtYl7HOlN+rZntaeI1pXGXorAuwFl/SXd6pJPRazo7n/1VwnHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBpN8GEl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759861385; x=1791397385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lxcxiGcnSQhOw8q03P3pElZ1Cb5DunYGWxewnXa2vaM=;
  b=MBpN8GElGQAzxI3Zjx0EIgaRdpFbcFMU+q1w1gFX/fj30YgyFPffzdif
   /YvQ29VMzQiEu9esifzw9P8BuK7PJRdaT5K8TNV6hmvfty/uTmn/hR+kP
   xIjE78j2hESlgDLZi2HpBTcliISADUP6hWtSvUDcf5Su63bClk9ljHxrf
   AKO+GozEUz+AwOYLesSZigYtFY4ZrGn2xl0DgITVIpdSfUPi2iCKjdAMH
   LRmu2yRBC0R2K+F8IcZsF1QrvI7JIx/eVOxsBKHbKOCnw4MnDuIHRa0sj
   TKgTcz6eT+h9Eqh/q32JY9BBv7aH9y6nWvbWFs6A15VZccfYBy83SbaXz
   A==;
X-CSE-ConnectionGUID: OShHspBwS7u4my7+l/sJnQ==
X-CSE-MsgGUID: qvLi9QPsSeCw7FHHI1XZtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="84672028"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="84672028"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:23:04 -0700
X-CSE-ConnectionGUID: QfymVmV3RqyMzqeo7g+8Rg==
X-CSE-MsgGUID: V5GmDUPsTaKpxLpp9bKntg==
X-ExtLoop1: 1
Received: from jdoman-mobl3.amr.corp.intel.com (HELO desk) ([10.124.220.94])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 11:23:03 -0700
Date: Tue, 7 Oct 2025 11:22:57 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Klaus Kusche <klaus.kusche@computerix.info>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <20251007182257.ywrqrrhgrtrviila@desk>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>

On Mon, Oct 06, 2025 at 04:04:42PM +0200, Borislav Petkov wrote:
> On Mon, Oct 06, 2025 at 01:58:55PM +0000, Kaplan, David wrote:
> > Sounds rather yucky. 
> 
> I'll give it a try at some point and see how ugly it becomes...
> 
> > What about just not calling cpu_select_mitigations() if
> > CONFIG_CPU_MITIGATIONS=n?  Then you won't get any print messages either I'd
> > think.
> 
> I want to not compile in that code at all if CPU_MITIGATIONS=off, actually.

Even when CPU mitigations are disabled there is still some handling
required for mitigations like GDS that requires a write to MSR to ensure
correct behavior. So not all of bugs.c can be compiled out easily.

IMO, rather than targeting the mitigation enabling code it might make more
sense to compile out the actual mitigations scattered accross the kernel.
This may also improve performance by reducing the code footprint, and can
also help getting a cleaner disassembly.

