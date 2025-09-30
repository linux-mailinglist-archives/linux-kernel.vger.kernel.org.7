Return-Path: <linux-kernel+bounces-837559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF857BAC93A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04097A1A32
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CD92F99B5;
	Tue, 30 Sep 2025 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLUglUGT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCDD7D07D;
	Tue, 30 Sep 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229918; cv=none; b=NR8KecIa5SAFXnCAN+m23xxq8/WC6q4+TOKNFIrLNbfQqno5PJq4oZIywGoqQq2mqXyeUTmTDndPaSCT5DOB3vhcUYK9RUiVJeWrqIgdfmD78Mhsf2iHH81+BOm9jHJRpn3hUu4BhuBjGXRIJ9CJWgSoZrKXBM1h0LmzhpR54bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229918; c=relaxed/simple;
	bh=IVeKxWEut+Emb9nnqz0yfG5v42zVqYoCwYVmlUPF938=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=AwZLQ2plZLJGBstyujNm7ywjQU6gfmZz/cj9hgD1BIDO4vRAloOInRTr/KhR5UFrTpwfgyf4DVF8573qUAkBgjVAaaiagEAdhl1j3wHI8/CiJOK3kY40DECANECp2u6ojOv6YrQl7dLGcqEA6n89DdeIad+QegV2IYm7vhYTd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLUglUGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BC3C4CEF0;
	Tue, 30 Sep 2025 10:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759229917;
	bh=IVeKxWEut+Emb9nnqz0yfG5v42zVqYoCwYVmlUPF938=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=qLUglUGTY+iCDhsOWbxYlW691Zbullyv4GDGSkWQOpYwsuuOxyWeYm6D+g14/zeke
	 KdUrSOoM4ttNdCtP2bj0sT2eNPIA8841BS1E4LtGbaTE9gh329bC77/WVznvyWf6oH
	 e2s0P/8Xuz//t5eUBgh1cNeIELhetCeSbaNm903Zu9NK/taHhAbfPg8z1b5bulhM0J
	 ONaOkIpGxY/obvelLf+sw2sWYMALVjMkYz7efV5JsnMfnPjlp2HHe7nz7OpwLWeAmN
	 6/wl7Zu4QL+e9zhu0q1GMsiOCiaUHXtw04lNnHUlGPTggCyHQmEDfBR+zODwwLhs1Y
	 JNTuKJ3tKeZ0g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Sep 2025 12:58:29 +0200
Message-Id: <DD62YFG2CJ36.1NFKRTR2ZKD6V@kernel.org>
Subject: Re: [RFC v8 00/21] DRM scheduling cgroup controller
Cc: "Philipp Stanner" <phasta@mailbox.org>, <phasta@kernel.org>, "Tvrtko
 Ursulin" <tvrtko.ursulin@igalia.com>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, <kernel-dev@igalia.com>,
 <intel-xe@lists.freedesktop.org>, <cgroups@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Leo Liu" <Leo.Liu@amd.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, "Matthew Brost"
 <matthew.brost@intel.com>, =?utf-8?q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, =?utf-8?q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, "Pierre-Eric Pelloux-Prayer"
 <pierre-eric.pelloux-prayer@amd.com>, "Rob Clark" <robdclark@gmail.com>,
 "Tejun Heo" <tj@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Alex Deucher" <alexander.deucher@amd.com>,
 "Lucas De Marchi" <lucas.demarchi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "Rob Herring" <robh@kernel.org>,
 "Steven Price" <steven.price@arm.com>, "Liviu Dudau" <liviu.dudau@arm.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Boqun Feng" <boqunf@netflix.com>,
 =?utf-8?q?Gr=C3=A9goire_P=C3=A9an?= <gpean@netflix.com>, "Simona Vetter"
 <simona@ffwll.ch>, <airlied@gmail.com>
To: "Boris Brezillon" <boris.brezillon@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
 <DD5CCG4MIODH.1718JI1Z7GH8T@kernel.org>
 <4453e5989b38e99588efd53af674b69016b2c420.camel@mailbox.org>
 <20250930121229.4f265e0c@fedora>
In-Reply-To: <20250930121229.4f265e0c@fedora>

On Tue Sep 30, 2025 at 12:12 PM CEST, Boris Brezillon wrote:
> So, my take on that is that what we want ultimately is to have the
> functionality provided by drm_sched split into different
> components that can be used in isolation, or combined to provide
> advanced scheduling.
>
> JobQueue:
>  - allows you to queue jobs with their deps
>  - dequeues jobs once their deps are met
> Not too sure if we want a push or a pull model for the job dequeuing,
> but the idea is that once the job is dequeued, ownership is passed to
> the SW entity that dequeued it. Note that I intentionally didn't add
> the timeout handling here, because dequeueing a job doesn't necessarily
> mean it's started immediately. If you're dealing with HW queues, you
> might have to wait for a slot to become available. If you're dealing
> with something like Mali-CSF, where the amount of FW slots is limited,
> you want to wait for your execution context to be passed to the FW for
> scheduling, and the final situation is the full-fledged FW scheduling,
> where you want things to start as soon as you have space in your FW
> queue (AKA ring-buffer?).
>
> JobHWDispatcher: (not sure about the name, I'm bad at naming things)
> This object basically pulls ready-jobs from one or multiple JobQueues
> into its own queue, and wait for a HW slot to become available. If you
> go for the push model, the job gets pushed to the HW dispatcher queue
> and waits here until a HW slot becomes available.
> That's where timeouts should be handled, because the job only becomes
> active when it gets pushed to a HW slot. I guess if we want a
> resubmit mechanism, it would have to take place here, but give how
> tricky this has been, I'd be tempted to leave that to drivers, that is,
> let them requeue the non-faulty jobs directly to their
> JobHWDispatcher implementation after a reset.
>
> FWExecutionContextScheduler: (again, pick a different name if you want)
> This scheduler doesn't know about jobs, meaning there's a
> driver-specific entity that needs to dequeue jobs from the JobQueue
> and push those to the relevant ringbuffer. Once a FWExecutionContext
> has something to execute, it becomes a candidate for
> FWExecutionContextScheduler, which gets to decide which set of
> FWExecutionContext get a chance to be scheduled by the FW.
> That one is for Mali-CSF case I described above, and I'm not too sure
> we want it to be generic, at least not until we have another GPU driver
> needing the same kind of scheduling. Again, you want to defer the
> timeout handling to this component, because the timer should only
> start/resume when the FWExecutionContext gets scheduled, and it should
> be paused as soon as the context gets evicted.

This sounds pretty much like the existing design with the Panthor group
scheduler layered on top of it, no?

Though, one of the fundamental problems I'd like to get rid of is that job
ownership is transferred between two components with fundamentally differen=
t
lifetimes (entity and scheduler).

Instead, I think the new Jobqueue should always own and always dispatch job=
s
directly and provide some "control API" to be instructed by an external
component (orchestrator) on top of it when and to which ring to dispatch jo=
bs.

The group scheduling logic you need for some Mali GPUs can either be implem=
ented
by hooks into this orchestrator or by a separate component that attaches to=
 the
same control API of the Jobqueue.

> TLDR; I think the main problem we had with drm_sched is that it had
> this clear drm_sched_entity/drm_gpu_scheduler separation, but those two
> components where tightly tied together, with no way to use
> drm_sched_entity alone for instance, and this led to the weird
> lifetime/ownership issues that the rust effort made more apparent. If we
> get to design something new, I think we should try hard to get a clear
> isolation between each of these components so they can be used alone or
> combined, with a clear job ownership model.

This I agree with, but as explained above I'd go even one step further.

