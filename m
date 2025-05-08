Return-Path: <linux-kernel+bounces-640058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B8FAAFFEE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 18:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BA69C34F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFEC27CB18;
	Thu,  8 May 2025 16:07:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F85527AC47
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720449; cv=none; b=jk9UG7h9PQCHou1yu4aLo8i+E69qpmMetR60+AV9GdLhIGLqsg1krgILYJWP4Q/apNBHu9M1cDyRQPuOZ15yBip+CEubgf7l/lfI/jKWYoFl+Zyl5ASJtrsxlj5Ki2lbAbpnNgbNFhX+RskH+T45PdG7GOxjFpDto/S8/1Kl4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720449; c=relaxed/simple;
	bh=g2HdK6UHZQUgdwlah1zRHqAnikMxYB2BsiKBDt8GLZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjQmQLXlLFFh9qJ5VVq7fLCCziusV44fWFOZQ3Btdlh6xtY8J+XhpnDnO90T8tlrdeS/7aX2wDHLOc/VhM2Er4M5GNchSxVjY4ZOmjVf6UyXwW5R1Nq1+F4PI8g8oFaWB2GqE94VVE0JUySg555D9aWA9SADX8zeceBarunIL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C5B9236D;
	Thu,  8 May 2025 09:07:17 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 313073F5A1;
	Thu,  8 May 2025 09:07:25 -0700 (PDT)
Date: Thu, 8 May 2025 17:07:22 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: Marc Zyngier <maz@kernel.org>, Per Larsen <perl@immunant.com>,
	Sudeep Holla <sudeep.holla@arm.com>, armellel@google.com,
	catalin.marinas@arm.com, kernel-team@android.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, qperret@google.com,
	sebastianene@google.com, will@kernel.org, yuzenghui@huawei.com,
	Per Larsen <perlarsen@google.com>
Subject: Re: [PATCH 1/3] KVM: arm64: Restrict FF-A host version renegotiation
Message-ID: <20250508-condor-of-angelic-pleasure-bfb5c4@sudeepholla>
References: <CA+AY4XcaJa1_U3qXQUBj4wZJYc9hKmRX8FTNeDvV2auEnC_WrA@mail.gmail.com>
 <86r017h00e.wl-maz@kernel.org>
 <aBnNXyJn818ZEKOS@google.com>
 <8634dfh47q.wl-maz@kernel.org>
 <20250508-spectral-sage-whippet-4f7ac2@sudeepholla>
 <CAMP5XgcCg+kB7tPwSYUcjfZqR_734cGEs_KX4st9SQOVLBV-Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMP5XgcCg+kB7tPwSYUcjfZqR_734cGEs_KX4st9SQOVLBV-Yw@mail.gmail.com>

On Thu, May 08, 2025 at 08:45:01AM -0700, Arve Hjønnevåg wrote:
> On Thu, May 8, 2025 at 2:27 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > (just adding some additional info not particularly impacting the $subject
> >  change implementation)
> >
> > On Thu, May 08, 2025 at 09:55:05AM +0100, Marc Zyngier wrote:
> > > On Tue, 06 May 2025 10:29:41 +0100,
> > > Per Larsen <perl@immunant.com> wrote:
> > > >
> >
> > [...]
> >
> > > > Asssuming we drop this patch from the series and apply the rest, the
> > > > hypervisor and host can negotiate FF-A 1.2. If the host then calls
> > > > FFA_VERSION a second time to request FF-A 1.1, the hypervisor would
> > > > return version 1.2 (without this patch).
> > >
> > > Why would it do that? Once a particular version has been negotiated, I
> > > expect to be immutable.
> > >
> >
> > Not suggesting that we need to support this, but it is technically possible
> > today by loading FF-A as a module—first inserting and removing a module with
> > v1.2 support, then loading one with v1.1 support. It can ever throw error
> > as not supported to keep it simple.
> >
> 
> I'm not sure how what you are suggesting here is different from what
> this patch does. This patch does not alter what versions the host can
> negotiate. The hypervisor already disallows negotiating a different
> version once has_version_negotiated is set, the return code just
> doesn't always reflect this. If you try to load the 1.0 driver in the
> host after unloading the 1.1 driver similar to what you describe
> above, then this CL will let the 1.0 driver know that the hypervisor
> does not support 1.0 (I use 1.1 to 1.0 as the example here since this
> is an issue even without the next CL in this patch series that bumps
> the hypervisor supported version to 1.2). Without this CL, the 1.0
> driver will now proceed making other ffa calls using 1.0 data
> structures that the hypervisor will incorrectly interpret as 1.1 data
> structures.
> 
> With this CL, loading a 1.2 driver after the initial 1.1 driver will
> work as it did before by returning version 1.1 to the 1.2 driver to
> let it know that _it_ needs to downgrade to 1.1. if it wants to
> proceed. Loading the 1.0 driver after 1.1 will now fail at the version
> negotiation stage however. This will be clearer, and more correct,
> than getting FFA_RET_INVALID_PARAMETERS return codes from other ffa
> calls when passing valid 1.0 parameters to those calls.
> 

Thanks for the detailed explanation. Sorry I didn't look at the change itself
and I might have made assumptions as I just read

  |  If the host then calls FFA_VERSION a second time to request FF-A 1.1,
  |  the hypervisor would return version 1.2 (without this patch).

So, my point was just that it is OK to even report it as NOT_SUPPORTED
if FF-A proxy doesn't want to deal with all the compatibility for simplicity.

-- 
Regards,
Sudeep

