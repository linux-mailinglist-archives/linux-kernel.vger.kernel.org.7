Return-Path: <linux-kernel+bounces-651138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 943F1AB9A94
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 12:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D783B906A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 10:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B902236454;
	Fri, 16 May 2025 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFxwAOXh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA60442C
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747392849; cv=none; b=V0fatXHX3HmJIcuZZUf5DX0w7eYF3ZI+yxEYzHdy9Uf64YF1rynPQrXioteBACU6NoKCnsUoWdH628oGYoWcsy1R8K+UWqYpr10jaYtVjmZgTXkp7Mv+gXEJTHvKURjsf6pw6JvHQRwpVdLrdruP5lb+dHCcnnJ5D0CpSSYONUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747392849; c=relaxed/simple;
	bh=ohc7DfDIiQvdNb0dPe1MlJPp2M1+sDApTZIAeaQEVZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMTIRZNdp09kJK7Sl3IPytLf34zKM0m9G0BAgNlFALyLY0qknV0l2Qltcig8drWvCK6Bejnb2KSU7stnPDdCsh9WG3Ifo1Q3ViHqi9wz6duSmXVjuXRaRU+o5NhkhaJQh5/REMeUlt1f4/Pd56koMTmQSYQILnm8Z97f7k6WCCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFxwAOXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D00BC4CEE4;
	Fri, 16 May 2025 10:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747392849;
	bh=ohc7DfDIiQvdNb0dPe1MlJPp2M1+sDApTZIAeaQEVZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFxwAOXhSLpKcmSjFxSe38/EmugB/y4Bof2khjyqSZjTgTgG3bJnpHuSnPP/TDfgj
	 kPvyQGxJSB7MabEM4bmwq/hh2Pf+g3lfH0zah2/RnbZYTXu1SfSDFxCK14iUVzh1zu
	 ItMge9aGk/Pvsgl0R83sOOQdzgjdUw2fLO2+IKOxod6OLRTIckCBFjHLRyn3UU3+bH
	 4zfNRkJvMurCXhZuoXhMDziFQqslOwY0Op6eBGGY3NN83tBliHoNYNnLk5Z+pEaIuC
	 rWRjhY0kHGlVexot5A3c/WXIRXeE8xI//D4C9dVJMpFWp0qY2TtMILV3nV3Oo0Bic2
	 QUmPwcorDjuug==
Date: Fri, 16 May 2025 12:54:00 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Philipp Stanner <phasta@kernel.org>, Lyude Paul <lyude@redhat.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: Re: [PATCH v2 2/6] drm/sched: Prevent teardown waitque from blocking
 too long
Message-ID: <aCcZSA79X9Nk2mzh@pollux>
References: <20250424095535.26119-2-phasta@kernel.org>
 <20250424095535.26119-4-phasta@kernel.org>
 <1297389f-70f6-4813-8de8-1a0c4f92250a@igalia.com>
 <aCcLMhS5kyD60PEX@pollux>
 <e152d20b-c62e-47d9-a891-7910d1d24c6a@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e152d20b-c62e-47d9-a891-7910d1d24c6a@igalia.com>

On Fri, May 16, 2025 at 11:19:50AM +0100, Tvrtko Ursulin wrote:
> 
> On 16/05/2025 10:53, Danilo Krummrich wrote:
> > On Fri, May 16, 2025 at 10:33:30AM +0100, Tvrtko Ursulin wrote:
> > > On 24/04/2025 10:55, Philipp Stanner wrote:
> > > > +	 * @kill_fence_context: kill the fence context belonging to this scheduler
> > > 
> > > Which fence context would that be? ;)
> > 
> > There's one one per ring and a scheduler instance represents a single ring. So,
> > what should be specified here?
> 
> I was pointing out the fact not all drivers are 1:1 sched:entity.

I'm well aware, but how is that relevant? Entities don't have an associated
fence context, but a GPU Ring (either hardware or software) has, which a
scheduler instance represents.

> Thought it would be obvious from the ";)".

I should read from ";)" that you refer to a 1:N-sched:entity relationship (which
doesn't seem to be related)?

> > > Also, "fence context" would be a new terminology in gpu_scheduler.h API
> > > level. You could call it ->sched_fini() or similar to signify at which point
> > > in the API it gets called and then the fact it takes sched as parameter
> > > would be natural.
> > 
> > The driver should tear down the fence context in this callback, not the while
> > scheduler. ->sched_fini() would hence be misleading.
> 
> Not the while what? Not while drm_sched_fini()?

*whole

> Could call it sched_kill()
> or anything. My point is that we dont' have "fence context" in the API but
> entities so adding a new term sounds sub-optimal.

In the callback the driver should neither tear down an entity, nor the whole
scheduler, hence we shouldn't call it like that. sched_kill() is therefore
misleading as well.

It should be named after what it actually does (or should do). Feel free to
propose a different name that conforms with that.

> > > We also probably want some commentary on the topic of indefinite (or very
> > > long at least) blocking a thread exit / SIGINT/TERM/KILL time.
> > 
> > You mean in case the driver does implement the callback, but does *not* properly
> > tear down the fence context? So, you ask for describing potential consequences
> > of drivers having bugs in the implementation of the callback? Or something else?
> 
> I was proposing the kerneldoc for the vfunc should document the callback
> must not block, or if blocking is unavoidable, either document a guideline
> on how long is acceptable. Maybe even enforce a limit in the scheduler core
> itself.

Killing the fence context shouldn't block.

