Return-Path: <linux-kernel+bounces-844927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D757CBC311E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 02:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C531881ED7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 00:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31DE1E9B3F;
	Wed,  8 Oct 2025 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pONNbh0T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7971E7C38
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882472; cv=none; b=nLcOyF4J18oBGdJM75dyTSOPxVODqPrP9PADXQ04EaoaGLH8XMGmrmwLW3B5O8AEJDhLnlDgXvJENbUyT5p1bUs/cAtoY8POal8a9pmFrMrgzFEsCYkLoN0MV2P1NBxbi5cP1EogDnljijt81qzeikT3NNYPsxkeX2PTxDkGrDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882472; c=relaxed/simple;
	bh=noaNR+tXTDyT2MUl9g79bBK6OJaozaTOKjCXS6VWRt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmnmK3HqqbmxWC6XfQLAlmB+kMYSYjWepshEuqj9JHE1NJIZV285jI5VmjvBVWEb5A2k/veCBQI4l7G9kL/J8FA6KyGx4zQkIgcWFy5lpumFTxOp+NI58zbXWCCtqPon3gKK935wC+ayrfiQBAbVBbhB5qyWg6/red4zlw1W9Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pONNbh0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF38C4CEF1;
	Wed,  8 Oct 2025 00:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759882471;
	bh=noaNR+tXTDyT2MUl9g79bBK6OJaozaTOKjCXS6VWRt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pONNbh0T9yXPn3qM1umy+e243MNnjZnc2NFm9A9WYAEhH2Wzsww9AN4lOUI/9D2b0
	 9Z/cPsVTdjOLo1vIVLmMY9X8wL+J76fjItlKxE6tOtX5VjfB/dwoFhaoY11+umwGwq
	 44M1AhND3+wjjp6vh5ra9mYxuHbUlGyCDd5KNSo9LBcXdvbkIFT3+pnVNZ8ZW/ueNx
	 nWEVp/iaYExeqKO1VEHEXNsJPQ25eA6OfcKCw+W/IM7WACRFsFJUzH+2xV8iRs2oPn
	 h9i5NUVyY++zHhmMF43MqO3UzJwDnHgVIrpZg1xiRRq8X++YMFzbrRG6ZeyhW2A0Bh
	 GDCYHMmOAOyAw==
Date: Tue, 7 Oct 2025 17:14:29 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>, "Kaplan, David" <David.Kaplan@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, 
	Klaus Kusche <klaus.kusche@computerix.info>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/bugs: Qualify RETBLEED_INTEL_MSG
Message-ID: <sb7p6quwxkn4w4etgsxlqd6fcsia4xobf73d3fnybxafxrmvwi@ajg5lkdxtnfy>
References: <20251003171936.155391-1-david.kaplan@amd.com>
 <20251006131126.GBaOO__iUbQHNR6QhW@fat_crate.local>
 <LV3PR12MB9265B9AA81E01A539214764A94E3A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20251006140442.GDaOPMemqB7SRJSHWL@fat_crate.local>
 <20251007182257.ywrqrrhgrtrviila@desk>
 <20251007221229.GAaOWQTadGWlZSeAo_@fat_crate.local>
 <20251007230821.5shpa3pusyzaohb2@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007230821.5shpa3pusyzaohb2@desk>

On Tue, Oct 07, 2025 at 04:08:21PM -0700, Pawan Gupta wrote:
> On Wed, Oct 08, 2025 at 12:12:29AM +0200, Borislav Petkov wrote:
> > On Tue, Oct 07, 2025 at 11:22:57AM -0700, Pawan Gupta wrote:
> > > IMO, rather than targeting the mitigation enabling code it might make more
> > > sense to compile out the actual mitigations scattered accross the kernel.
> > > This may also improve performance by reducing the code footprint, and can
> > > also help getting a cleaner disassembly.

Isn't that what CONFIG_CPU_MITIGATIONS=n already does today?

> > Probably... however, it needs to be done smartly because sprinkling ifdeffery
> > and turning what is an already unreadable mess into a bigger abomination,
> > won't fly. Perhaps split out the mitigations glue into separate compilation
> > units and build-disable them... we'll see.
> 
> Ya, that would be better.

On a sort of related note, it's confusing that there are two completely
different classes of MITIGATION options which get conflated:

1) compile the kernel with support for certain mitigations:

    MITIGATION_RETPOLINE
    MITIGATION_RETHUNK
    MITIGATION_PAGE_TABLE_ISOLATION
    MITIGATION_UNRET_ENTRY
    MITIGATION_CALL_DEPTH_TRACKING
    MITIGATION_IBPB_ENTRY
    MITIGATION_IBRS_ENTRY
    MITIGATION_SRSO
    MITIGATION_SLS

2) enable bug-specific runtime defaults:

    MITIGATION_GDS
    MITIGATION_RFDS
    MITIGATION_SPECTRE_BHI
    MITIGATION_MDS
    MITIGATION_TAA
    MITIGATION_MMIO_STALE_DATA
    MITIGATION_L1TF
    MITIGATION_RETBLEED
    MITIGATION_SPECTRE_V1
    MITIGATION_SPECTRE_V2
    MITIGATION_SRBDS
    MITIGATION_SSB
    MITIGATION_ITS
    MITIGATION_TSA
    MITIGATION_VMSCAPE

In general, #1 uglify the kernel.  And some #2 depend on #1.

IMO, we should rename the #1 options.  For example:

  MITIGATION_RETPOLINE -> X86_UGLY_INDIRECT_THUNKS
  MITIGATION_RETHUNK   -> X86_UGLY_RETURN_THUNKS

  etc...

Then one only needs to grep their .config file for UGLY to understand
why their disassembly is so inscrutable ;-)

-- 
Josh

