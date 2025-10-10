Return-Path: <linux-kernel+bounces-848706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEEABCE623
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267C619A8143
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F903016E3;
	Fri, 10 Oct 2025 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhqe0o29"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E0426F293
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124270; cv=none; b=kOLLhfiWAxAfCbU/46kcqDB7p8iigd8lexneDrgWMR6qXKlhGO4bBhZEUskvGAB2agQeP/+YhEvDdbbn6ndFTFI7FR5EcdbnZmotdU4RvrxtIfMwwbGe4D5NRCmAEUvAh0bO7HseMgbjjbrV7nrgloKRYit3mGAIlQse+aXq5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124270; c=relaxed/simple;
	bh=XnigtyMUFjn2MDY33dm/0+K54kKUpMQwSEWZ6YNSDTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZgf1KR6305TCxE6jjrmT9AypFROZfpbMzn+mb2rqCcQwcOveEfQzD7Srlfh5frrj8XbZwKht4SJeGrL1nln6UlHEFjLeRjlfDQCdSRq4JIMFN3AY8HL6Ami6AkLMO4MSbIwjB6pa86j9fDpQ+fY4IkkmFywykklYtuGz/2sPBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhqe0o29; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760124268; x=1791660268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XnigtyMUFjn2MDY33dm/0+K54kKUpMQwSEWZ6YNSDTY=;
  b=lhqe0o293Tq1YbNpN6Eo6a7CJJWnocw4SFTPZsbrJ+kQNaG3XFnQASIz
   QJYFPISeJEwSbh8LEAbBLSq/MHjlHu/bEZ4DuH5K/WTY7nsqdIYF5yFvC
   2dYl78r/5hWUb2FtDG7UZUJWogzoFy11mTebc8o7AszFpLO35ClRX3IPU
   YVgN69cfM/ASJ5U2LwZT+utnHnx8/fG2JNPtjFkR3jtBPKYiFYUojZgR8
   AQOeg4DP3Xkl/K0OFRcuFs6RM+ss3eWChiMh/OhV0g9uvFI24ZqB96RMi
   Vrd7DevErkc+MgBuMM1PKMeSo7NcsoLO528F+NRGZZi8rHOJbLh41CI+W
   Q==;
X-CSE-ConnectionGUID: MncuBOG1TLqLe88g6Qa2cA==
X-CSE-MsgGUID: Wf1//R8STraYRWKzVtVT3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="73789581"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="73789581"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 12:24:20 -0700
X-CSE-ConnectionGUID: GNt5g6FcTju+U0Toi1Jxxw==
X-CSE-MsgGUID: 43B3lJb9TPSwrso3uN3zJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="180169146"
Received: from smoehrl-linux.amr.corp.intel.com (HELO desk) ([10.124.221.161])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 12:24:19 -0700
Date: Fri, 10 Oct 2025 12:24:13 -0700
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
Message-ID: <20251010192413.5kx7hkysj3wsvxmq@desk>
References: <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
 <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
 <20251009053336.ghcmhgsprtkgydas@desk>
 <xhxfkzrrn62xkd6moiapfueookui5f63x4lmzgkmnf3mbxilb5@kk4rylukegii>
 <jlwwd3ohjr7a6lnd4ehu4lp7ys7tm7f6rlaxyc75725thvil4k@pf3bm243ncys>
 <zrbzofjxeuioxhbruhaoacbyfbpclkbntiblg6jjirr4v2c2uu@aeyo5bdb44et>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zrbzofjxeuioxhbruhaoacbyfbpclkbntiblg6jjirr4v2c2uu@aeyo5bdb44et>

On Fri, Oct 10, 2025 at 12:19:12PM -0700, Josh Poimboeuf wrote:
> On Fri, Oct 10, 2025 at 11:47:25AM -0700, Pawan Gupta wrote:
> > > Instead, CONFIG_MITIGATION_SPECTRE_V2 could enable a submenu which then
> > > allows the user to enable retpoline, IBRS on entry, etc, with each
> > > having help text describing what generations of CPUs it would be the
> > > default for, to help guide the user to choose sane defaults depending on
> > > their CPU:
> > > 
> > >   * CONFIG_MITIGATION_SPECTRE_V2
> > >     * CONFIG_MITIGATION_SPECTRE_V2_RETPOLINE
> > >       select CONFIG_BUILD_INDIRECT_THUNKS
> > >     * CONFIG_MITIGATION_SPECTRE_V2_IBRS
> > >       select CONFIG_BUILD_IBRS_ENTRY
> > 
> > That would be good if a kernel is built for certain specific CPU(s). This
> > may not be ideal for distro kernels.
> 
> Why not?  A distro can just enable everything:

Ahh, right.

>   CONFIG_MITIGATION_SPECTRE_V2=y
>   CONFIG_MITIGATION_SPECTRE_V2_RETPOLINE=y
>   CONFIG_MITIGATION_SPECTRE_V2_IBRS=y
> 
> and then if/when some older HW ages out of being supported by the
> distro, they can start disabling things.

Yup, that makes sense.

