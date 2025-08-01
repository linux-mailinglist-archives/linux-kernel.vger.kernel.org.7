Return-Path: <linux-kernel+bounces-753609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF4BB1853C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FDAF7AAC64
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC127A918;
	Fri,  1 Aug 2025 15:49:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D581422DD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063343; cv=none; b=CHX8J/YvNFEIA0PQ10s6yZ5eiyMTUK4vSR+m+E7iz9kuZrbRYcxcALOYVUG1PxGCSAH/S3G8tnecYuhuiQHrScFkwyVTRs+yXtFnDgEIEPtNMp/t/46gEE2U/wwJz+b70ecSj4bbCOutGk5TcUYu0MmjT5/WTCrdD48DA9+R/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063343; c=relaxed/simple;
	bh=WIxhnb6h+wHjI00rCKfvaKKI3YIBCRmDOkTedwTX0Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGsyeN4XCZJgojtAAzB6L/4beOebopipo3D26rvjYYm9327lgkxNslk0wL0HI48YhQaWxJD6O9qVzc/7Q9geCrRO2MWTE2yO0GuydykkZQkPhr+rwCmygVKcMELs64CICowhS4Elko4FZ1K6d7S1t0HYclrS0+V++QRLGoLoXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E4CC4CEE7;
	Fri,  1 Aug 2025 15:49:00 +0000 (UTC)
Date: Fri, 1 Aug 2025 16:48:58 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
	ryan.roberts@arm.com, kevin.brodsky@arm.com,
	yangyicong@hisilicon.com, joey.gouly@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	david@redhat.com, mark.rutland@arm.com, urezki@gmail.com
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
Message-ID: <aIzh6ixbKR5TnnPb@arm.com>
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aIpPsg1Kij8Knnjl@arm.com>
 <9169f4a1-1ad3-4ef0-8d16-eabebfa64cf0@arm.com>
 <aIuihRzw1xvZ-PaY@arm.com>
 <c53ec40c-1fe4-4092-a876-61d5b37d8b02@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c53ec40c-1fe4-4092-a876-61d5b37d8b02@arm.com>

On Fri, Aug 01, 2025 at 05:45:53PM +0530, Dev Jain wrote:
> On 31/07/25 10:36 pm, Catalin Marinas wrote:
> > A control dependency would work as well without a barrier, i.e.:
> > 
> > 	if (READ_ONCE(*ptdump_lock_key)) {
> > 		mmap_lock();
> > 		mmap_unlock();
> > 		WRITE_ONCE(*pte_page, 0);
> > 	} else {
> > 		WRITE_ONCE(*pte_page, 0);
> > 	}
> > 
> > but the compiler is probably free to only issue a single WRITE_ONCE()
> > irrespective of the ptdump_lock_key check.
> > 
> > Of course, using smp_load_acquire(ptdump_lock_key) would also work.
> > 
> > However, things get fuzzier as we don't have a classic load from the
> > ptdump_lock_key but rather a patched instruction. We need to guarantee
> > that t2' is issued after the t2 branch when the instruction is patched.
> > The kick_all_cpus_sync() on the static key disable path doesn't help us
> > since P0 (T2 in your description) may see the patched branch/nop and go
> > straight to the WRITE_ONCE(*pte_page). Not sure what barrier helps here
> > (after more sleep, I may have a better idea tomorrow).
> 
> Got it. The hole in my proof is not with Case 2 but with Case 1: the assumption
> in the reasoning is that pmd_free() will be observed after the patched-in
> read lock/unlock, but that will happen when patching-in happens, for which
> we need to observe the branch before the pmd_free(), but that isn't guaranteed
> since there is no barrier between the if block and the pmd_free(), nor is there any
> control dependency, like you describe above. So, in pud_free_pmd_page, the entire block from "pmdp = table"
> till "pmd_free()" can be observed before the observation of the branch.
> 
> Reading tools/memory-model/Documentation/control-dependencies.txt, I interpret that the
> compiler is free to hoist out the WRITE_ONCE() out of the control block, and then
> we have the same problem, BUT I tested with herd and the test passes :)

I don't think the tool reorders the litmus test events based on what a
compiler may generate. However, with instruction patching we don't even
have a control dependency - there's no check of the ptdump_lock_key but
a replacement of an unconditional branch with a NOP (or vice-versa).

Anyway, email to the memory model experts in Arm sent (you are on copy).

-- 
Catalin

