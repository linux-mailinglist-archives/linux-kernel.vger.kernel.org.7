Return-Path: <linux-kernel+bounces-861722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE38BF379A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68B924F381A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2241A76BC;
	Mon, 20 Oct 2025 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRzS8A8U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1A2D9482;
	Mon, 20 Oct 2025 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992837; cv=none; b=on5hdF2c4D6mr5Uw+dRlRk4hpYm86kWG+3pfk90G54XXKT3xhBE/jfLVN3m4/N+GvdsJy59NYxAkuGWzljBrHNhnyQ1QB/zCro2LyKzzJN9mxyPTI6gh0JDEgw2Mtmo4ckVV8FxxQj5ac3246TyKIEkUI+w1sxIzKt71C8ucVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992837; c=relaxed/simple;
	bh=24Vr+z8X2OjCkhbKv/RGORptzkJB/zizrQWThqPMu50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u07QWTS2g1GAA5BsgbJW+WKiccOuJf6d2kRWCFShV2Pbr/2tLMue1crV0OQclCmgTZ/8v1VPtP8DLnPzswT4LP4/dFEHJE/TtRSjqV2xfEO9hPCRxXTdi8FdkJRhxAQcNkpDaouL18qFLCZQ010tLOqFmle4ayx9DkSuladVibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRzS8A8U; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760992835; x=1792528835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=24Vr+z8X2OjCkhbKv/RGORptzkJB/zizrQWThqPMu50=;
  b=ZRzS8A8UFKBtg9SpVssgW5eKZLr+Od3Rw5J9owuYqhYqwnPPquTJ6DLW
   B5Rl1TFKdipUK8MTx/p52nwa/6jz1lwXiFaxrlrBKCwVbdx63dGc73aaD
   lE/ZvADeNK1dIaQEpakqAzdYV5/SBxRm+tPz8oVPP8qNb7pP52ir4DZW8
   UErqFd5AoKdKNyvnVxL3mLuAZgZc/yuvXpiPjei7ZLuvEX+3w7POlAYUn
   4KlA6MadrSD6zK32esSpeA+M7oa1UJub76hv3vImlqml4/uOiO1zo7A+Z
   SCl3fABqat1HkytNH17VOkWdHqD2mWB8L1rCllxW3DUwTcuovx24WKoir
   w==;
X-CSE-ConnectionGUID: FGx7jnZ5Sjq7CYaGMI1K8w==
X-CSE-MsgGUID: pFFPOZGCS/2uHNEnVpwSLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74235378"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="74235378"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 13:40:34 -0700
X-CSE-ConnectionGUID: C4M0oGTJQc2NzxAo+eHsxw==
X-CSE-MsgGUID: Wv7JWW/iSGm06SaRmVCCag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="183827708"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO desk) ([10.124.220.167])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 13:40:33 -0700
Date: Mon, 20 Oct 2025 13:40:26 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Brian Gerst <brgerst@gmail.com>,
	Brendan Jackman <jackmanb@google.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Message-ID: <20251020204026.a7xuhnagsqo4otpx@desk>
References: <20251017011253.2937710-1-jon@nutanix.com>
 <20251020194446.w2s5f6nr7i7vw4ve@desk>
 <EA2E1D80-07A3-459D-B330-A667821E7C05@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EA2E1D80-07A3-459D-B330-A667821E7C05@nutanix.com>

On Mon, Oct 20, 2025 at 07:54:41PM +0000, Jon Kohler wrote:
> 
> 
> > On Oct 20, 2025, at 3:44 PM, Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > On Thu, Oct 16, 2025 at 06:12:49PM -0700, Jon Kohler wrote:
> >> A VMM may not expose ITS_NO or BHI_CTL, so guests cannot rely on those
> >> bits to determine whether they might be migrated to ITS-affected
> >> hardware. Rather than depending on a control that may be absent, detect
> >> ITS-unaffected hosts via a CPU feature that is exclusive to Sapphire
> >> Rapids and newer processors.
> > 
> > BHI_CTRL is also exclusive to Sapphire Rapids and newer processors. Why
> > wouldn't it be exposed to guests but BUS_LOCK_DETECT would be?
> > 
> > Not exposing BHI_CTRL has another disadvantage that guests would deploy the
> > BHB-clear sequence when they could have used cheaper hardware mitigation
> > for BHI.
> 
> Yes, I know, but given that BHI_CTRL comes via a spec_ctrl value change, it
> has a negative effect at any guests live migrated in that never A) updated their
> guest kernel to know about the new speculation controls and/or B) have updated
> but have not yet soft rebooted and/or

Since ITS is newer than BHI_CTRL, deploying ITS mitigation unnecessarily
shouldn't be a problem for A) and B), right?

> C) have updated, have soft rebooted, but the BHI_CTRL isn’t actually
> available because the system hasn’t cold-booted the VM(s) (see comments
> below).

This looks to be the main problem scenario.

> In any of those three situations, subsequent guest/host transitions become
> penalized. Now, from a security perspective, thats irrelevant because one
> could say that if you really want to be secure, you have to do the work to make
> sure all these cold boots are done, but that is far easier said than done in general
> enterprise virtualization workloads.
> 
> Meaning, *if* a host opts into enabling BHI at all, they will penalize any guest
> workload that hasn’t done the work to do the proper enablement cover to cover.
> Less of a problem for hyperscaler who could control what launch/where, much
> much harder for non-hyperscalers who might live migrate in extremely long tailed
> workloads that feel like a federal project just to get a guest reboot, not to mention
> a guest cold boot.

That seems orthogonal to the problem at hand, but I feel the pain. IIUC,
you are referring to the wrmsr(SPEC_CTRL) at guest entry/exit because that
have different MSR values. Host with BHI_DIS_S=1 and guest without it? Do
you think adding support for virtual-SPEC_CTRL in QEMU would help here?

> >> Use X86_FEATURE_BUS_LOCK_DETECT as the canary: it is present on
> >> Sapphire Rapids+ parts and provides a reliable indicator that the guest
> >> won't be moved to ITS-affected hardware.
> > 
> > I am puzzled why BUS_LOCK_DETECT is more reliable than BHI_CTRL?
> 
> Because BUS_LOCK_DETECT (or any other feature from commit [1]) was
> available day 1 of the SPR QEMU model, whereas BHI_CTRL wasn’t added
> until commit [2]. That means any VMM that added SPR support “day 1” has
> the feature set from [1] at minimum, and it also means that if a guest VM was
> *started* on that QEMU version, but never power cycled, it will never see 
> BHI_CTRL, even if it is available to be picked up in the latest model scheme.
> 
> I can’t speak to other VMMs (e.g. vmw, hyperv, hyperscalers) and how they do
> it, but I suspect there are similar challenges around post-launch feature/bit
> additions that require the VM to be completely cold-booted.

Ok, that makes BUS_LOCK_DETECT a better choice than BHI_CTRL. I think it
be better to replace BHI_CTRL with BUS_LOCK_DETECT.

---
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1755f91a5643..e8fc4a4055bf 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1355,8 +1355,8 @@ static bool __init vulnerable_to_its(u64 x86_arch_cap_msr)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return false;
 
-	/* None of the affected CPUs have BHI_CTRL */
-	if (boot_cpu_has(X86_FEATURE_BHI_CTRL))
+	/* None of the affected CPUs have BUS_LOCK_DETECT */
+	if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
 		return false;
 
 	/*

