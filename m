Return-Path: <linux-kernel+bounces-809088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A170B50853
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD07563A32
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E03225BEF1;
	Tue,  9 Sep 2025 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="crDgdZbs"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2925BEE1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453937; cv=none; b=CtnIWoR7f14moTequ5pSCt/p/U3s7SaukvjDjZRMtYrmYgveBQvsY9MvhjJjZ8MiNiwPowOWnSHSHXReobLp7peCoDBVaOW64UPyH7r/2iLx7pVESFTXQ0mLEDCqWkyclDo3dQfNbPwngKqbCM7dCMyKRdKKDTzSESP98nMbj3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453937; c=relaxed/simple;
	bh=tkiGPKoIfPsjHKQr4V6cHDyIiMGu3pe01XoHkNH/+fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CptKoHtETk/zGfMCzoFsA1PC32riT/U2520nE9qxhrsKVNEG5nigPFh6B43sE83bl3wLsnA8xGpvUIn0G+yPca1Si5USTobVt3ReTfAIrvkFKKVM9ybTdxFtU6JfHUgAJSRhV4uSKQSo9HdeOFbbCA0gNM9QZs/AJobw4TdbjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=crDgdZbs; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 14:38:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757453932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NTM71oMbNyUkRHheO/uqdI5DLErUii+Czn15g0wg9AQ=;
	b=crDgdZbsogfGO5+IcUCtFk+8CXNjrmdRZRO3QAnTm05eCWfkRYB6kVmhZF4YJXhY4tGFwO
	evuORkOrt5lbtdmONWJsCfK7ZSdZLO/ddmuN04DgvfZKJnWgVuOulxyHhiJh1h3k6y/mIP
	vPjegCqUupYvQ3wyesJ62JE2/p1Xa0U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: Jinqian Yang <yangjinqian1@huawei.com>, yuzenghui@huawei.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, liuyonglong@huawei.com,
	wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 1/3] KVM: arm64: Make ID_AA64MMFR1_EL1.HCX writable
 from userspace
Message-ID: <aMCeY0vvWTORB6E_@linux.dev>
References: <20250909034415.3822478-1-yangjinqian1@huawei.com>
 <20250909034415.3822478-2-yangjinqian1@huawei.com>
 <aL_SIwQiz3QO1fKe@linux.dev>
 <86ldmoc4x7.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ldmoc4x7.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 11:10:28AM +0100, Marc Zyngier wrote:
> On Tue, 09 Sep 2025 08:07:15 +0100,
> Oliver Upton <oliver.upton@linux.dev> wrote:
> > 
> > On Tue, Sep 09, 2025 at 11:44:13AM +0800, Jinqian Yang wrote:
> > > Allow userspace to downgrade HCX in ID_AA64MMFR1_EL1. Userspace can
> > > only change this value from high to low.
> > > 
> > > Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>
> > 
> > I'm not sure our quality of emulation is that great in this case. We
> > have no way of trapping the register and it is always stateful. Better
> > yet, our RESx infrastructure doesn't account for the presence of
> > FEAT_HCX and we happily merge the contents with the host's HCRX.
> 
> Yeah, that's not good, and definitely deserves a fix.
> 
> > We should make a reasonable attempt at upholding the architecture before
> > allowing userspace to de-feature FEAT_HCX.
> 
> My concern here is the transitive implications of FEAT_HCX being
> disabled: a quick look shows about 20 features that depend on
> FEAT_HCX, and we don't really track this. I can probably generate the
> dependency graph, but that's not going to be small. Or very useful.
> 
> However, we should be able to let FEAT_HCX being disabled without
> problem if the downgrading is limited to non-EL2 VMs. Same thing for
> FEAT_VHE.
> 
> What do you think?

So I'm a bit worried about making fields sometimes-writable, it creates
a very confusing UAPI behavior. On top of that, our writable masks are
currently static.

What if we treat the entire register as RES0 in this case? It seems to
be consistent with all the underlying bits / features being NI. A
mis-described VM isn't long for this world anyway (e.g. FEAT_SCTLR2 && !FEAT_HCX)
and in that case I'd prefer an approach that keeps the KVM code as
simple as possible.

We do, after all, expect some level of sanity from userspace of feature
dependencies as we do not enforce the dependency graph at the moment.
Hell, this could be useful for someone cross-migrating a nested VM from
a machine w/o FEAT_HCX to one that has it.

Thanks,
Oliver

