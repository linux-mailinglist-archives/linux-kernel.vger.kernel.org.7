Return-Path: <linux-kernel+bounces-861652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56164BF342D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 419814FD15B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFA032F74F;
	Mon, 20 Oct 2025 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVNMrkAv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E5328B4A;
	Mon, 20 Oct 2025 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989503; cv=none; b=M9zN6w2I/vWxjOXNUBxYeIXjnCqLGvdDFRe79uOxVJVOvcT1zlSEL/9u8SjlcyvALC5ugncykFeg0CFro/jNMEqvUVKRickFRwUvRI+DQwDeoYknx/tKRTL0MpyO5uujW4sxutI+MLruDVaKaDfkG+dHZopnGpnLAQliyKh9zys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989503; c=relaxed/simple;
	bh=RlV65ikxRr47oX9Migjybv1V2We0BdbRY3X2uOWfVlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0PMinGOgp3oG0AMURndIB2W/1A4RqfagSee9DtfKVI2dyN10YwtGNkT1SznqA4cCUDenQ1vksxflQkQzT0FeY9UlvioUmx0uc7cVvZwfKK0Mjw26G4u/WIoRF90uHvV1hO22/4dkxaVCQIxZLuv1wezk9kY5bs/Fab05xtol7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVNMrkAv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760989502; x=1792525502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RlV65ikxRr47oX9Migjybv1V2We0BdbRY3X2uOWfVlU=;
  b=nVNMrkAv3WTPFv/Pm4gtHZFUGn92f8rqxZ6mKVzw4iNnZIU4pxRM8TJ6
   cHIuf0PSDCYfPzfLSrF4x3CpvOLGYZCideXVZ3YaqVzPdlwka46C1tx07
   ExY7aGJUCzPm+G69cK4KqTJTDww9k82AeqOq0lKoubB5gfQzRVHujtLsg
   l/Gp9HpDpydOhsCwh7HRNA2ExKK+tQMtPlJ7EgzJnTJDzpk1z7TDtokxf
   qhkto0XhKMbzQL0C0okY2X+GB3NuGMcHZqizRuoCc1w34xss1oSnzncRp
   VNIZ63hDHgS2t5ToQ2KWfJlRP0n29e1paHjw2ezwJa3X9uWUt+eY7xcQ1
   A==;
X-CSE-ConnectionGUID: yVrVHjpCQEixK9aPmnxbQQ==
X-CSE-MsgGUID: WviUuVmVT8WWJrYmADiADA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73403575"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="73403575"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 12:45:01 -0700
X-CSE-ConnectionGUID: isk7uufpR+ekF7o1gkIXgg==
X-CSE-MsgGUID: XOMTcv+YS0qZg8TzfBBmAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="183817614"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO desk) ([10.124.220.167])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 12:45:00 -0700
Date: Mon, 20 Oct 2025 12:44:54 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
	Brendan Jackman <jackmanb@google.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/its: use Sapphire Rapids+ feature to opt out
Message-ID: <20251020194446.w2s5f6nr7i7vw4ve@desk>
References: <20251017011253.2937710-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017011253.2937710-1-jon@nutanix.com>

On Thu, Oct 16, 2025 at 06:12:49PM -0700, Jon Kohler wrote:
> A VMM may not expose ITS_NO or BHI_CTL, so guests cannot rely on those
> bits to determine whether they might be migrated to ITS-affected
> hardware. Rather than depending on a control that may be absent, detect
> ITS-unaffected hosts via a CPU feature that is exclusive to Sapphire
> Rapids and newer processors.

BHI_CTRL is also exclusive to Sapphire Rapids and newer processors. Why
wouldn't it be exposed to guests but BUS_LOCK_DETECT would be?

Not exposing BHI_CTRL has another disadvantage that guests would deploy the
BHB-clear sequence when they could have used cheaper hardware mitigation
for BHI.

> Use X86_FEATURE_BUS_LOCK_DETECT as the canary: it is present on
> Sapphire Rapids+ parts and provides a reliable indicator that the guest
> won't be moved to ITS-affected hardware.

I am puzzled why BUS_LOCK_DETECT is more reliable than BHI_CTRL?

