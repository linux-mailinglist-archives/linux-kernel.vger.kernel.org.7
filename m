Return-Path: <linux-kernel+bounces-847247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA2DBCA586
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBCD94E7BE7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3B70830;
	Thu,  9 Oct 2025 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZTwpBpe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7223BCF7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030021; cv=none; b=mEpVhhZa5cHeaJONYZAJWALCz5ePRYIt4mf1pVz4S5LXCf5Kq6DSb0tqr/Ke9W1ZMSijPe44mwdIPt9kfRIGrCXB+McbKZb17w5WzaA1aNgMuzJJr5C2BHPnrdh+aBgGPaq7/6ail7hJYQsMOtDVqESJMiQPxcPBc2ELvnHSHJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030021; c=relaxed/simple;
	bh=XVWzHrtvsM3ZOFYaaTfLKyy4NiHdMVouDpFRrIpFw88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cwk1ANdqnNIE9TY8uCOzSWlzct+8imI+uJThMoCWkFB2y2Mo7GwVuwXJb5H1wvH923L9+5ZLrwXPnnma5+/MfljC/RlJDsqDsKv1oVSfmmu+sFUtPepXjOpydfVtlTMpXWvPnNeCSL094L7ZckegdNl6/7GrtDdFCc2w13Fn5Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZTwpBpe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760030019; x=1791566019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XVWzHrtvsM3ZOFYaaTfLKyy4NiHdMVouDpFRrIpFw88=;
  b=PZTwpBpe2v769F2R5UC47THz/Ztm+uP7veZztcT7eQLqtIoyB5rbk/Gw
   GpPTzLZfeqh1bf5RO4ZroZJ6U3Tmnv/8jdXpu4chNZgLlBN1ZsEs2FVsY
   nrEazbjfSExDu9t1kJdKIY3WTMXvO/bAqAUk4VlYKoBInoSF5LwBeSgoq
   qtuVwn2GtyFY7QqiXfG8vm8bAIdH6SblVz9qY4TW6n0PQosMz4jopRr8K
   i14JqZE3KCI3knx4m8du4M/sKYmoRs9zEj9NM37HCR2Nsx/9JR9JyCgQ2
   QaP8eUH8eEtxcIcqgigEW3ZdxPvazzBVKVuqmq6Ihfrh+/pOImM+NEOAa
   Q==;
X-CSE-ConnectionGUID: KkOea2UTRh+zwDvzyz2Asw==
X-CSE-MsgGUID: AM6Xdr1cQZmf2LeQQBe7fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66077636"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66077636"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 10:13:38 -0700
X-CSE-ConnectionGUID: cuGYk029Qh6eB2UrSEX5AA==
X-CSE-MsgGUID: XcaczV4JQkuSXGpzCmys1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,217,1754982000"; 
   d="scan'208";a="180792808"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO desk) ([10.124.221.52])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 10:13:38 -0700
Date: Thu, 9 Oct 2025 10:13:31 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kaplan, David" <David.Kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Klaus Kusche <klaus.kusche@computerix.info>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <20251009171331.vplg2zcfystojcxo@desk>
References: <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251008102136.GAaOY7MBd4_VBPBNtG@fat_crate.local>
 <pnobm2r4icma6xzxvzklxoyoy3a4yhhxuxdoq2srmz6rpnegms@qneijnfu6fmz>
 <20251009101557.GAaOeLXYDjOnyFTWdg@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009101557.GAaOeLXYDjOnyFTWdg@fat_crate.local>

On Thu, Oct 09, 2025 at 12:15:57PM +0200, Borislav Petkov wrote:
> On Wed, Oct 08, 2025 at 11:04:32PM -0700, Pawan Gupta wrote:
> > Thats a lot. OTOH, most of the bugs.c is __init code, do you think it is
> > still problematic?
> 
> What is wrong with aiming to not have dead code in the kernel if it can be
> removed cleanly?

Nothing wrong with that. There are certain things (like I mentioned
earlier) that needs to be moved out of bugs.c.

