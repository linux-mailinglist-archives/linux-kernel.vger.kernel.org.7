Return-Path: <linux-kernel+bounces-844853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F72BBC2EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20EA034ECB6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECA7258CCB;
	Tue,  7 Oct 2025 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5CynVio"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A5246BC6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759878510; cv=none; b=ASV3IVG9SucvaZ/q16kqwg3kYbZQWDtEkzgVVsG1HbFDY3n83+eV1yKlkjoD1fWu5NO/A3DKFvhFvtd0QgGjtQCFxe8iEeGHAikiVBS227cMvguUfeIbzsLFPxXzTf806PCGfHgXRN45J2oAVmVnwBqkmA7TpvDqSOOhrvEM9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759878510; c=relaxed/simple;
	bh=soOmVCbO7QTs8TxuBs4s0PjW28ZnWv3SoKaI0sgqt9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZsl7WwI173clAEZRQiAy2Y5mzI3bImFdG7y+QT7Ygup/0qbDpSj5s76zSHRQ9Hs6ZLySBUDTWQfmvFtRCX9IsRa6ZeEl2PPio7PoXShX6MyV1Ony+YoGJpaHqItagWsOPngq53jOfQ7X5AROUmtkV2CbDUrcU5eZH3y9mmSLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5CynVio; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759878509; x=1791414509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=soOmVCbO7QTs8TxuBs4s0PjW28ZnWv3SoKaI0sgqt9E=;
  b=M5CynViouhS6gxmwIm7x/YXzCt2Mu4n7KT1M8O5UaSAKiU1pFLZnXf+4
   yU8zx0etjNabmpivFYuxwOzd6Zod8qEC0zkzToqn1hKgTKj3XKV3v7L3O
   w7hrlJBl5lMBokdMRbzOFCaiuk9Qukn0JsNmVvb82ZBJj7LreMiti/Ue1
   K0Xm8QRhtVnzAlyqjEzmW6Y86hE0SBSLsirMk7D4JByWahuDJAtLkvFiU
   EH5zi+tB3Er1v3fcB557cyUIoOaN5UDDXKiLyhDDMawXXMYw4nvQxi2Ow
   eL4QfXnD2PX6iUKzZTCN4r8swzfHydHLqRrj/BQ8XnX4V4tQL9+Cr16vD
   g==;
X-CSE-ConnectionGUID: wQiSuf0MQ7mwiE6+VdVGig==
X-CSE-MsgGUID: HTiofkU4T168cxWGmOn1LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65896803"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65896803"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 16:08:28 -0700
X-CSE-ConnectionGUID: pc98mw6kRgWkE3bSXePJsA==
X-CSE-MsgGUID: tItqf3L3S+ipB6e7apZ6Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,322,1751266800"; 
   d="scan'208";a="180231640"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO desk) ([10.124.220.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 16:08:27 -0700
Date: Tue, 7 Oct 2025 16:08:21 -0700
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
Message-ID: <20251007230821.5shpa3pusyzaohb2@desk>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>

On Wed, Oct 08, 2025 at 12:12:29AM +0200, Borislav Petkov wrote:
> On Tue, Oct 07, 2025 at 11:22:57AM -0700, Pawan Gupta wrote:
> > Even when CPU mitigations are disabled there is still some handling
> > required for mitigations like GDS that requires a write to MSR to ensure
> > correct behavior.
> 
> When mitigations are compiled out there are no mitigations by definition.

GDS microcode mitigation is enabled by default, for disabling the
mitigation an MSR write is required.

> So whatever you're talking about must be something else which should
> happen in vendor code.

Perhaps yes when bugs.c is compiled out.

> > IMO, rather than targeting the mitigation enabling code it might make more
> > sense to compile out the actual mitigations scattered accross the kernel.
> > This may also improve performance by reducing the code footprint, and can
> > also help getting a cleaner disassembly.
> 
> Probably... however, it needs to be done smartly because sprinkling ifdeffery
> and turning what is an already unreadable mess into a bigger abomination,
> won't fly. Perhaps split out the mitigations glue into separate compilation
> units and build-disable them... we'll see.

Ya, that would be better.

