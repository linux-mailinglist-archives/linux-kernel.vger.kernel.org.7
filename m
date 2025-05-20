Return-Path: <linux-kernel+bounces-656070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB54ABE14E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 18:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870151BA6955
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 16:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5341126FA4B;
	Tue, 20 May 2025 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Slj6PXmg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FFA22083;
	Tue, 20 May 2025 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760078; cv=none; b=IfPQggtFNEeuWNPdTh7vkEUceCqLLOU9zlVIZ+wkmSdxHm1Cao03SY4bA9zGwAtxQsTbRGwjlIDnsCiS6FY74hHS5olCA/GWwq7ZI0mLMa95grSemY+pvuV0gLjpTs+lK/kQ/yy2C3oVf4+W/IsZLv2a1Do0IFSvtAsccwxP2K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760078; c=relaxed/simple;
	bh=AgPyKTUIDuQsDQnW4AKRQwM1++hGLJl4xtmOoexecE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZHtOKJKPy5/AoRsjSsad6WxVqIckol1TR7f00kvIPwiVwgq9J7NXj5Qwv+bydHeGS/ympDFRXTPBIqmeYtx3ZrI3MbiefaLW7qFjRCtfTFF58WXIp08N5z+v3gl2jE8syD6CroyRYlX1nng+enM1FhBENiVmNp9zwe3Ti8W9t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Slj6PXmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D82C4CEE9;
	Tue, 20 May 2025 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747760078;
	bh=AgPyKTUIDuQsDQnW4AKRQwM1++hGLJl4xtmOoexecE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Slj6PXmgELBMEgspF7nxXwNY7G/+TwoSIPPWQDRm1Dttzp2u5IZucLVSnTm2PsKr+
	 qk8s3dvppe6G6U3tTuIp6SUaamN369d/+mstmRzCWWeLMO/elg0aaQSQPW+9yPXLHX
	 ln52GP/xau4kRnD2kwpzO8Twv9Ls8F8LmRA1Ob/x3wDpdVycK2yEeP19a7anbxTzN3
	 9ijZy/5zaTOALNXBFTmFg09GJ7Vf728+4rmwp4IJFtxGIl7u7tjYd3aaJWGqG4cDMq
	 NvIRI8qRvhBiP7sSuSGNVcjuxHmlTRvzAGcVu1KLR6H7vfQ/ain1Ys3sTgJBmeDbTm
	 GJ6xgxBuDYfBw==
Date: Tue, 20 May 2025 18:54:32 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Cc: Connor Abbott <cwabbott0@gmail.com>, Rob Clark <robdclark@chromium.org>,
	phasta@kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	open list <linux-kernel@vger.kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v4 04/40] drm/sched: Add enqueue credit limit
Message-ID: <aCyzyAPbQ1SYbo4q@pollux>
References: <20250514170118.40555-5-robdclark@gmail.com>
 <51f87f358fa1b7ef8db8b67ee6cde38ae071fbe8.camel@mailbox.org>
 <CAJs_Fx771FFVDVFMn8YJkR9f9Ad-UQspJ9KKQw4u6Cu4TA7YPA@mail.gmail.com>
 <CACu1E7EL+E-M0N-EAN9Bx7u9O6_pECQQdPE2ph575idhVb2Szg@mail.gmail.com>
 <aCYkk4Y7feltfp79@pollux>
 <CAF6AEGsoG_W3A3+BHV4n5EKZQazFubrCyfrtxVUH7+H4-j7i5A@mail.gmail.com>
 <aCY42rgJC4sQ4tp4@pollux>
 <CAF6AEGubHkdhfJz=bAZvctO1aTKDLwRsRyPzkoVrQ7tA6dRbKw@mail.gmail.com>
 <aCwqAGLLCC2ZLSBK@pollux>
 <CAF6AEGspvuTHU0t9z__p_HkdRNi=cXir3t453AbR6DFNzDpgvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGspvuTHU0t9z__p_HkdRNi=cXir3t453AbR6DFNzDpgvw@mail.gmail.com>

On Tue, May 20, 2025 at 09:07:05AM -0700, Rob Clark wrote:
> On Tue, May 20, 2025 at 12:06 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Thu, May 15, 2025 at 12:56:38PM -0700, Rob Clark wrote:
> > > On Thu, May 15, 2025 at 11:56 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > >
> > > > On Thu, May 15, 2025 at 10:40:15AM -0700, Rob Clark wrote:
> > > > > On Thu, May 15, 2025 at 10:30 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > > > > >
> > > > > > (Cc: Boris)
> > > > > >
> > > > > > On Thu, May 15, 2025 at 12:22:18PM -0400, Connor Abbott wrote:
> > > > > > > For some context, other drivers have the concept of a "synchronous"
> > > > > > > VM_BIND ioctl which completes immediately, and drivers implement it by
> > > > > > > waiting for the whole thing to finish before returning.
> > > > > >
> > > > > > Nouveau implements sync by issuing a normal async VM_BIND and subsequently
> > > > > > waits for the out-fence synchronously.
> > > > >
> > > > > As Connor mentioned, we'd prefer it to be async rather than blocking,
> > > > > in normal cases, otherwise with drm native context for using native
> > > > > UMD in guest VM, you'd be blocking the single host/VMM virglrender
> > > > > thread.
> > > > >
> > > > > The key is we want to keep it async in the normal cases, and not have
> > > > > weird edge case CTS tests blow up from being _too_ async ;-)
> > > >
> > > > I really wonder why they don't blow up in Nouveau, which also support full
> > > > asynchronous VM_BIND. Mind sharing which tests blow up? :)
> > >
> > > Maybe it was dEQP-VK.sparse_resources.buffer.ssbo.sparse_residency.buffer_size_2_24,
> >
> > The test above is part of the smoke testing I do for nouveau, but I haven't seen
> > such issues yet for nouveau.
> 
> nouveau is probably not using async binds for everything?  Or maybe
> I'm just pointing to the wrong test.

Let me double check later on.

> > > but I might be mixing that up, I'd have to back out this patch and see
> > > where things blow up, which would take many hours.
> >
> > Well, you said that you never had this issue with "real" workloads, but only
> > with VK CTS, so I really think we should know what we are trying to fix here.
> >
> > We can't just add new generic infrastructure without reasonable and *well
> > understood* justification.
> 
> What is not well understood about this?  We need to pre-allocate
> memory that we likely don't need for pagetables.
> 
> In the worst case, a large # of async PAGE_SIZE binds, you end up
> needing to pre-allocate 3 pgtable pages (4 lvl pgtable) per one page
> of mapping.  Queue up enough of those and you can explode your memory
> usage.

Well, the general principle how this can OOM is well understood, sure. What's
not well understood is how we run in this case. I think we should also
understand what test causes the issue and why other drivers are not affected
(yet).

> > > There definitely was one where I was seeing >5k VM_BIND jobs pile up,
> > > so absolutely throttling like this is needed.
> >
> > I still don't understand why the kernel must throttle this? If userspace uses
> > async VM_BIND, it obviously can't spam the kernel infinitely without running
> > into an OOM case.
> 
> It is a valid question about whether the kernel or userspace should be
> the one to do the throttling.
> 
> I went for doing it in the kernel because the kernel has better
> knowledge of how much it needs to pre-allocate.
> 
> (There is also the side point, that this pre-allocated memory is not
> charged to the calling process from a PoV of memory accounting.  So
> with that in mind it seems like a good idea for the kernel to throttle
> memory usage.)

That's a very valid point, maybe we should investigate in the direction of
addressing this, rather than trying to work around it in the scheduler, where we
can only set an arbitrary credit limit.

> > But let's assume we agree that we want to avoid that userspace can ever OOM itself
> > through async VM_BIND, then the proposed solution seems wrong:
> >
> > Do we really want the driver developer to set an arbitrary boundary of a number
> > of jobs that can be submitted before *async* VM_BIND blocks and becomes
> > semi-sync?
> >
> > How do we choose this number of jobs? A very small number to be safe, which
> > scales badly on powerful machines? A large number that scales well on powerful
> > machines, but OOMs on weaker ones?
> 
> The way I am using it in msm, the credit amount and limit are in units
> of pre-allocated pages in-flight.  I set the enqueue_credit_limit to
> 1024 pages, once there are jobs queued up exceeding that limit, they
> start blocking.
> 
> The number of _jobs_ is irrelevant, it is # of pre-alloc'd pages in flight.

That doesn't make a difference for my question. How do you know 1024 pages is a
good value? How do we scale for different machines with different capabilities?

If you have a powerful machine with lots of memory, we might throttle userspace
for no reason, no?

If the machine has very limited resources, it might already be too much?

