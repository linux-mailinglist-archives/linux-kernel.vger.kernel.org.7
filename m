Return-Path: <linux-kernel+bounces-614550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8330CA96DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 16:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B393A590E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EE2284B5B;
	Tue, 22 Apr 2025 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRp8LA9o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA9B284B49
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330886; cv=none; b=L1OluLI7+JYigrZrdDFsLdwIl51gkl4QjfaHqkt2h6MSkLWFeuw7MEOvOnPRKm7XuG9fmhMX0HLfRyIZZ/gL+mqvhY1OLQoziyJdEg6nst4S/obgyzh8L+vFUshK7i/CDPShcCx2m5ifYldSczV8LdREiVw+0iEI/FqxLl568vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330886; c=relaxed/simple;
	bh=uWfX0ErRug4zOOOQ6zXCSlswe2nijkFFt5NPEHGiwds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuC2H3hP9N2elQFrVfwAj/BUsSpkbCoaFKUi4qKpr85gy9vP1DnEG+AdeKkToVhTTfRS5sBydpviqx33x/dQ6i+tH5ATwWWyFWGPueWL8/WT0UgLFXrUnk26eZKorUzh3B9RdA0gBAF29127fC7l86s9hU0qf29EKwh0PFAuUgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRp8LA9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ED7C4CEEC;
	Tue, 22 Apr 2025 14:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745330886;
	bh=uWfX0ErRug4zOOOQ6zXCSlswe2nijkFFt5NPEHGiwds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRp8LA9ocamWlKaIvygZzF5AlszGxiUspDVw2pzTJF1iaRABvfqOZw0biDF83onqt
	 naUFG0GXRxP0Yrv+jCrreRem3AB1yDSac3gHnCnZ5RKB7d/aEwhMqYxJ/lxpE/tVX+
	 +ysfrjW2BCPR7dPOCbE3J21X8o95Ta0i8fy0UG6EHHxRGTHLin3AOmqABe4OCz7r/c
	 6jOzDM9Dp7sIj2CjhO0LIvg9V+U18dIyDbCL4o6yFtyLnPvvCgobAej/uZZyODl3LE
	 EdD87EgFV9otCJm90IyiYIX/JOC0SiqZnHNbMM3/VzeRYXUx0aJDnLobV2wfjntdHG
	 hC6wshZMDO1UA==
Date: Tue, 22 Apr 2025 16:08:01 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: phasta@kernel.org, Lyude Paul <lyude@redhat.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] drm/sched: Warn if pending list is not empty
Message-ID: <aAeiwZ2j2PhEwhVh@cassiopeiae>
References: <aADv4ivXZoJpEA7k@pollux>
 <83758ca7-8ece-433e-b904-3d21690ead23@igalia.com>
 <aAEUwjzZ9w9xlKRY@cassiopeiae>
 <0e8313dc-b1bb-4ce7-b5b7-b8b3e027adb7@igalia.com>
 <0bfa746ca37de1813db22e518ffb259648d29e02.camel@mailbox.org>
 <5a5d4a33-2f7b-46e4-8707-7445ac3de376@igalia.com>
 <aAd54jUwBwgc-_g2@cassiopeiae>
 <d3c0f721-2d19-4a1c-a086-33e8d6bd7be6@igalia.com>
 <aAeMVtdkrAoMrmVk@cassiopeiae>
 <52574769-2120-41a1-b5dc-50a42da5dca6@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52574769-2120-41a1-b5dc-50a42da5dca6@igalia.com>

On Tue, Apr 22, 2025 at 02:39:21PM +0100, Tvrtko Ursulin wrote:
> 
> On 22/04/2025 13:32, Danilo Krummrich wrote:
> > On Tue, Apr 22, 2025 at 01:07:47PM +0100, Tvrtko Ursulin wrote:
> > > 
> > > On 22/04/2025 12:13, Danilo Krummrich wrote:
> > > > On Tue, Apr 22, 2025 at 11:39:11AM +0100, Tvrtko Ursulin wrote:
> > > > > Question I raised is if there are other drivers which manage to clean up
> > > > > everything correctly (like the mock scheduler does), but trigger that
> > > > > warning. Maybe there are not and maybe mock scheduler is the only false
> > > > > positive.
> > > > 
> > > > So far the scheduler simply does not give any guideline on how to address the
> > > > problem, hence every driver simply does something (or nothing, effectively
> > > > ignoring the problem). This is what we want to fix.
> > > > 
> > > > The mock scheduler keeps it's own list of pending jobs and on tear down stops
> > > > the scheduler's workqueues, traverses it's own list and eventually frees the
> > > > pending jobs without updating the scheduler's internal pending list.
> > > > 
> > > > So yes, it does avoid memory leaks, but it also leaves the schedulers internal
> > > > structures with an invalid state, i.e. the pending list of the scheduler has
> > > > pointers to already freed memory.
> > > > 
> > > > What if the drm_sched_fini() starts touching the pending list? Then you'd end up
> > > > with UAF bugs with this implementation. We cannot invalidate the schedulers
> > > > internal structures and yet call scheduler functions - e.g. drm_sched_fini() -
> > > > subsequently.
> > > > 
> > > > Hence, the current implementation of the mock scheduler is fundamentally flawed.
> > > > And so would be *every* driver that still has entries within the scheduler's
> > > > pending list.
> > > > 
> > > > This is not a false positive, it already caught a real bug -- in the mock
> > > > scheduler.
> > > 
> > > To avoid furher splitting hairs on whether real bugs need to be able to
> > > manifest or not, lets move past this with a conclusion that there are two
> > > potential things to do here:
> > 
> > This is not about splitting hairs, it is about understanding that abusing
> > knowledge about internals of a component to clean things up is *never* valid.
> > 
> > > First one is to either send separately or include in this series something
> > > like:
> > > 
> > > diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> > > b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> > > index f999c8859cf7..7c4df0e890ac 100644
> > > --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> > > +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> > > @@ -300,6 +300,8 @@ void drm_mock_sched_fini(struct drm_mock_scheduler
> > > *sched)
> > >                  drm_mock_sched_job_complete(job);
> > >          spin_unlock_irqrestore(&sched->lock, flags);
> > > 
> > > +       drm_sched_fini(&sched->base);
> > > +
> > >          /*
> > >           * Free completed jobs and jobs not yet processed by the DRM
> > > scheduler
> > >           * free worker.
> > > @@ -311,8 +313,6 @@ void drm_mock_sched_fini(struct drm_mock_scheduler
> > > *sched)
> > > 
> > >          list_for_each_entry_safe(job, next, &list, link)
> > >                  mock_sched_free_job(&job->base);
> > > -
> > > -       drm_sched_fini(&sched->base);
> > >   }
> > > 
> > >   /**
> > > 
> > > That should satisfy the requirement to "clear" memory about to be freed and
> > > be 100% compliant with drm_sched_fini() kerneldoc (guideline b).
> > > 
> > > But the new warning from 3/5 here will still be there AFAICT and would you
> > > then agree it is a false positive?
> > 
> > No, I do not agree.
> > 
> > Even if a driver does what you describe it is not the correct thing to do and
> > having a warning call it out makes sense.
> > 
> > This way of cleaning things up entirely relies on knowing specific scheduler
> > internals, which if changed, may fall apart.
> > 
> > > Secondly, the series should modify all drivers (including the unit tests)
> > > which are known to trigger this false positive.
> > 
> > Again, there are no false positives. It is the scheduler that needs to call
> > free_job() and other potential cleanups. You can't just stop the scheduler,
> > leave it in an intermediate state and try to clean it up by hand relying on
> > knowledge about internals.
> 
> Sorry I don't see the argument for the claim it is relying on the internals
> with the re-positioned drm_sched_fini call. In that case it is fully
> compliant with:
> 
> /**
>  * drm_sched_fini - Destroy a gpu scheduler
>  *
>  * @sched: scheduler instance
>  *
>  * Tears down and cleans up the scheduler.
>  *
>  * This stops submission of new jobs to the hardware through
>  * drm_sched_backend_ops.run_job(). Consequently,
> drm_sched_backend_ops.free_job()
>  * will not be called for all jobs still in drm_gpu_scheduler.pending_list.
>  * There is no solution for this currently. Thus, it is up to the driver to
> make
>  * sure that:
>  *
>  *  a) drm_sched_fini() is only called after for all submitted jobs
>  *     drm_sched_backend_ops.free_job() has been called or that
>  *  b) the jobs for which drm_sched_backend_ops.free_job() has not been
> called
>  *
>  * FIXME: Take care of the above problem and prevent this function from
> leaking
>  * the jobs in drm_gpu_scheduler.pending_list under any circumstances.
> 
> ^^^ recommended solution b).

This has been introduced recently with commit baf4afc58314 ("drm/sched: Improve
teardown documentation") and I do not agree with this. The scheduler should
*not* make any promises about implementation details to enable drivers to abuse
their knowledge about component internals.

This makes the problem *worse* as it encourages drivers to rely on
implementation details, making maintainability of the scheduler even worse.

For instance, what if I change the scheduler implementation, such that for every
entry in the pending_list the scheduler allocates another internal object for
${something}? Then drivers would already fall apart leaking those internal
objects.

Now, obviously that's pretty unlikely, but I assume you get the idea.

The b) paragraph in drm_sched_fini() should be removed for the given reasons.

AFAICS, since the introduction of this commit, driver implementations haven't
changed in this regard, hence we should be good.

So, for me this doesn't change the fact that every driver implementation that
just stops the scheduler at an arbitrary point of time and tries to clean things
up manually relying on knowledge about component internals is broken.

However, this doesn't mean we can't do a brief audit.

- Danilo

