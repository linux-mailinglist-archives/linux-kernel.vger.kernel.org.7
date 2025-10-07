Return-Path: <linux-kernel+bounces-844462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA97BC1F98
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6463D4E1AC4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B7F2E6CA5;
	Tue,  7 Oct 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OgWsgG8/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DCC2D6607;
	Tue,  7 Oct 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851885; cv=none; b=XWBwEnmGwG1eic9JhPT0bJ6ilrphqcXaIALefa7iRWXisiJJ+jptputK4MEf9Osq0Te0+JYDX/hAQmn5x0zdhSGarEvm701/5r6+eYGbKuTwhR7odSkh/XdfmMax2r5wQpP/LU1Y8JdtYGvg6Wf2GmCT9oULQ4dReUnbKTYtS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851885; c=relaxed/simple;
	bh=tdvi4W0xjX37x+KyKt5JT1k5u+Wzab6OWefO1NyCTMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjGQmw6GEQsVKXydOLDZNY98kOKy4UA11n08vrHmwYxIoINPphHpQcYO3Cj3reBJPP28sc/GB5tbULwi59YJrJXl5GsVvSsoHEJjsIEJDRYyiww+RdAI1RRdc/4pNCOlS3k3Jabd1F1bntW7I8j4V/kwJYmjDfobnoE1DaiWmh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OgWsgG8/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759851875;
	bh=tdvi4W0xjX37x+KyKt5JT1k5u+Wzab6OWefO1NyCTMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OgWsgG8/2zlJTXxDwMQaGCO9N4mZ2PHYuIKJfKDy/qtc5dnikAJwJn7AHudLWcNmr
	 qcCbRrqte4yOi/ab4r6sKUP98DIeF5mSYzzKZ8fwZJvZTqZRbVTh1YfIxptw7Vkm5K
	 nD6ty+pwCnfAfyR3l5cwMiHD0QVhIjospljKQ1/MUL3z1blLmqIUPT9KnrmKnePkIU
	 rBUWDo49xHg5ZYISCSWSzK88XviPtVfpRGjcwf3OTnrzzamwj6e/k/5O1B9BdWTUEj
	 x15i9hUBUt92SONWztJfCm1DqkWRZDyqe1faitrUCXS6recp8ClqE386PBCl8Msarj
	 ag3zuuzuTuJMA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 49DBC17E10B7;
	Tue,  7 Oct 2025 17:44:34 +0200 (CEST)
Date: Tue, 7 Oct 2025 17:44:29 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@mailbox.org>, phasta@kernel.org, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 intel-xe@lists.freedesktop.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Leo Liu <Leo.Liu@amd.com>, =?UTF-8?B?TWHDrXJh?=
 Canal <mcanal@igalia.com>, Matthew Brost <matthew.brost@intel.com>, Michal
 =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>, Michel =?UTF-8?B?RMOkbnpl?=
 =?UTF-8?B?cg==?= <michel.daenzer@mailbox.org>, Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Rob Clark <robdclark@gmail.com>,
 Tejun Heo <tj@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Alex
 Deucher <alexander.deucher@amd.com>, Lucas De Marchi
 <lucas.demarchi@intel.com>, Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?=
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, Liviu
 Dudau <liviu.dudau@arm.com>, Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqunf@netflix.com>,
 =?UTF-8?B?R3LDqWdvaXJlIFDDqWFu?= <gpean@netflix.com>, Simona Vetter
 <simona@ffwll.ch>, airlied@gmail.com
Subject: Re: [RFC v8 00/21] DRM scheduling cgroup controller
Message-ID: <20251007174429.0fc0ad84@fedora>
In-Reply-To: <aa7dedae-8f31-49f9-ad73-009cb8550b93@kernel.org>
References: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
	<DD5CCG4MIODH.1718JI1Z7GH8T@kernel.org>
	<4453e5989b38e99588efd53af674b69016b2c420.camel@mailbox.org>
	<20250930121229.4f265e0c@fedora>
	<DD62YFG2CJ36.1NFKRTR2ZKD6V@kernel.org>
	<20250930135736.02b69c65@fedora>
	<aa7dedae-8f31-49f9-ad73-009cb8550b93@kernel.org>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Oct 2025 16:44:59 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> On 9/30/25 1:57 PM, Boris Brezillon wrote:
> > Can you remind me what the problem is? I thought the lifetime issue was
> > coming from the fact the drm_sched ownership model was lax enough that
> > the job could be owned by both drm_gpu_scheduler and drm_sched_entity
> > at the same time.  
> 
> I don't think that's (directly) a thing from the perspective of the drm_sched
> design. A job should be either in the entity queue for the pending_list of the
> scheduler.
> 
> However, different drivers do implement their own lifetime (and ownership) model
> on top of that, because they ultimately have to deal with jobs being either tied
> to the entity or the scheduler lifetime, which is everything else but strait
> forward in error cases and tear down paths.
> 
> And the fundamental problem why drivers implement their own rules on top of this
> is because it is hard to deal with jobs being tied to entirely different
> lifetime model depending on their state.
> 
> So, what I'm saying is that from the perspective of the component itself it's
> probably fine, but for the application in drivers it's the root cause for a lot
> of the hacks we see on top of the scheduler in drivers.
> 
> Some of those hacks even make their way into the scheduler [1].
> 
> [1]
> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/gpu/drm/scheduler/sched_main.c#L1439
> 
> >> Instead, I think the new Jobqueue should always own and always dispatch jobs
> >> directly and provide some "control API" to be instructed by an external
> >> component (orchestrator) on top of it when and to which ring to dispatch jobs.  
> > 
> > Feels to me that we're getting back to a model where the JobQueue needs
> > to know about the upper-layer in charge of the scheduling. I mean, it
> > can work, but you're adding some complexity back to JobQueue, which I
> > was expecting to be a simple FIFO with a dep-tracking logic.  
> 
> Yes, the Jobqueue would need an interface to the orchestrator. I rather have the
> complexity encapsulated in the Jobqueue, rather than pushing the complexity to
> drivers by having a more complex lifetime and ownership model that leaks into
> drivers as mentioned above.
> 
> > I have a hard time seeing how it can fully integrate in this
> > orchestrator model. We can hook ourselves in the JobQueue::run_job()
> > and schedule the group for execution when we queue a job to the
> > ringbuf, but the group scheduler would still be something on the side.  
> 
> Can you please expand a bit more on the group model?
> 
> My understanding is that you have a limited number of firmware rings (R) and
> each of those rings has N slots, where N is the number of queue types supported
> by the GPU.

Honestly, the naming is a bit confusing, because for us, the ring
buffer is what gets attached to each queue and contains the jobs to be
executed on that queue. But other than this naming issue, that's pretty
much it, yes.

> 
> So, you need something that can schedule "groups" of queues over all available
> firmware rings, because it would be pointless to schedule each individual queue
> independently, as a firmware ring has slots for each of those. Is that correct?

It's not just that it would be pointless, it's not even an option,
because there are inter-queue synchronization mechanisms that only work
if the queues belong to the same group.

