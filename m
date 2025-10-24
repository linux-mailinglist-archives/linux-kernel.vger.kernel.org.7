Return-Path: <linux-kernel+bounces-868478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72240C05478
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631951A064C9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F353093DB;
	Fri, 24 Oct 2025 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVU3Pt0M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9A3093C4
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297170; cv=none; b=rv5gQ4/8uEqV9Ub0VNFc26YGLA2qAyrZOwh22hT2XmIyzIgM5QGtub2xiC3b5znGNJYdrgEr1tBWGXHYihijZrb4GmlqZoiH6Sz8Do3dfBG6FI0vG3QN84oB3onWJ9XZ1s/SQX5LP9FnjUOhXQhDFCLrtoz3or0cVPIBnLvm0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297170; c=relaxed/simple;
	bh=Ozm05SxkZxt26rRgt0rundnqpjUV/C1QshOmD/4rhBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NePW+8tUFaKFzpxPJrA4RBM7t08ZHc+2DRDdlhJ1JETnFpsZ8N+jD2fmz4b44+oooRp5MoQkaKXruwWaUQeuJs8rIBBkJNi/NAKLSbBC25KY/Xz6rkb5Fbls1PxefIYahWGfiwElkWd5s52i9OWGuI8bmp1/HcTS1StV6oPE+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVU3Pt0M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761297166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkU3ioUgK+VHZR3DCdmR7NHTzlTFyd7GcfkliM+XZiA=;
	b=iVU3Pt0MN9homrw0+EUAoKdl8WvhrUg54y/eaW6cUj6XWLo0N1k+V6LSSc8TQMNkE3Nchn
	YN+S/QXJc5vJGVz/FIGG4Elz+046nP9Es/K0MXbH7PbuWa9fhaVxc9OduRWqR7tP9nFemw
	e5CXox4PQWPR9oA28MHPVMCFhqLcLuM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-0SpJ8a-RMGyBNYyPjihihQ-1; Fri, 24 Oct 2025 05:12:44 -0400
X-MC-Unique: 0SpJ8a-RMGyBNYyPjihihQ-1
X-Mimecast-MFC-AGG-ID: 0SpJ8a-RMGyBNYyPjihihQ_1761297164
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4710d174c31so19416565e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297163; x=1761901963;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vkU3ioUgK+VHZR3DCdmR7NHTzlTFyd7GcfkliM+XZiA=;
        b=Wg9cfcaEQnmjRhtfTCKcpdJ4VoFfU089V5tjDjm4TM8jaoaMA5qDAc4bF6ROpFGE4S
         h6XRGsr0sYoIiO5DAt1eLZGdyV1Pnzk5TeM7aAdXsg6P5P/10pm/fWqNpwwML6q9tgsh
         OIrVUpnGB33MYTiHnW0VbD1IfvS7auwALv2nOacKBDRmA9XiFvXW8XmQzUmGdQKP7yBE
         gd9+6u3eCUnH3B5J9H1nrw07b1mQ1Vubjm1Z4I3qUy+BjESK2NEB94OIzfZTbhAqqhyV
         k8vmKimm2OSwWlVQK9L42TwQg8dUeFaHqMwL/MNGf6ph7R7ISbIc4QlTTgUYtrLjDikX
         h0xg==
X-Forwarded-Encrypted: i=1; AJvYcCWil0V3qDuHyx/WHqKGC0RLynDXCELvCGV2B24zAz34xsvKBGqw3Stnq5FsdIXlMbZXG44cEyjBpHQU9hE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2k2BI0dlBuhIEWMnEmVuYJMUmaPPBSMw7Y2RIam05+9AzPhsV
	DNGvoy3J9ZleZVd744AHCOkrf1Dn4WkuglycuKHVz4Zhd/K3Emde7UkKxyGShjJfXDNgTModLyC
	lkt8xqHTxE674ouzUf7WnM+Gmktx1cWzhIfiMEWbS2mqfTADavmlWnd6AkfFNnPxf6Q==
X-Gm-Gg: ASbGncs1ekirzn0A2nNkuEE4BC2G7cyn2KxSFe0egO7KmCZqr2tcnb6h876gtZPBcqC
	LhaFZMBCS2lVxAPnnk91tKhcfSEwsaGFQRXZy5boR586OLQOlUqFUDzk9d9+0GbKp6XMyLHSolL
	dSFzBy/6Bnd7sWZm9T5Ro5Fr8+GNPX9MM5ShgexGGCrqLyxDTNNVQYPSQw8KqtP3LJSdxk+/7CH
	ccqbrGjDcNv36gNjXhBbH+MXzsSiYzkVpwG17nIqjK0lBYT/yRrz7ZhiSucF2c3l5f2HevlckmY
	E42rAd8D6xDGlR9754IULp+XU6trDcb8rYZB46KC9bZzqD95lCs2yhU8R5q/lakzvQFIncZDrre
	jwzHABOB+p23cMEXau7wQwNPYNo2bcfbPPZ7ZdApFbfWcURJ4
X-Received: by 2002:a05:600c:1d9b:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-471178a7d96mr192426645e9.15.1761297163414;
        Fri, 24 Oct 2025 02:12:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk+fSRolcY0NNtjOv+A6jY0TifUo1IUlQFgOJfyvIO3r4FooxJiUzetHGHvE598YSETgteOw==
X-Received: by 2002:a05:600c:1d9b:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-471178a7d96mr192426325e9.15.1761297162752;
        Fri, 24 Oct 2025 02:12:42 -0700 (PDT)
Received: from ?IPv6:2001:16b8:3ded:3c00:4c70:8ae9:4a46:47ae? ([2001:16b8:3ded:3c00:4c70:8ae9:4a46:47ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494b02475sm81039965e9.4.2025.10.24.02.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:12:41 -0700 (PDT)
Message-ID: <bd2fda6dc370432e5478c891514bce5d8a0d8b76.camel@redhat.com>
Subject: Re: [PATCH v2] drm/sched: Extend and update documentation
From: Philipp Stanner <pstanner@redhat.com>
To: Matthew Brost <matthew.brost@intel.com>, Philipp Stanner
 <phasta@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>,  dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,  linux-media@vger.kernel.org, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Date: Fri, 24 Oct 2025 11:12:40 +0200
In-Reply-To: <aPqdr98ANKN53GKm@lstrano-desk.jf.intel.com>
References: <20251023143803.150978-2-phasta@kernel.org>
	 <aPqdr98ANKN53GKm@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-23 at 14:27 -0700, Matthew Brost wrote:
> On Thu, Oct 23, 2025 at 04:38:04PM +0200, Philipp Stanner wrote:
> > From: Philipp Stanner <pstanner@redhat.com>
> >=20
> > The various objects and their memory lifetime used by the GPU scheduler
> > are currently not fully documented.
> >=20
> > Add documentation describing the scheduler's objects. Improve the
> > general documentation at a few other places.
> >=20
> > Co-developed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>=20
> This is great documentation=E2=80=94thanks for writing it up. It clarifie=
s
> several bugs I've noticed in multiple NPU drivers over the past year
> related to reclaim, making it clear that these behaviors are not
> allowed.=C2=A0
>=20

Good to hear that we're in line here.

> Also, check out [1], which enforces some of the reclaim rules
> outlined here.

Will take a look hopefully next week.

>=20
> A couple of minor nits below, but I'm inclined to RB.
>=20
> [1] https://patchwork.freedesktop.org/series/156284/
>=20
> > ---
> > Changes in v2:
> > =C2=A0 - Fix some typos. (Bagas Sanjava)
> > ---
> > =C2=A0Documentation/gpu/drm-mm.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 36 ++++
> > =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 229 ++++++++++++++++++++=
++---
> > =C2=A0include/drm/gpu_scheduler.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
> > =C2=A03 files changed, 239 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rs=
t
> > index d55751cad67c..95ee95fd987a 100644
> > --- a/Documentation/gpu/drm-mm.rst
> > +++ b/Documentation/gpu/drm-mm.rst
> > @@ -556,12 +556,48 @@ Overview
> > =C2=A0.. kernel-doc:: drivers/gpu/drm/scheduler/sched_main.c
> > =C2=A0=C2=A0=C2=A0 :doc: Overview
> >=20
> >=20

[=E2=80=A6]

> > =C2=A0
> > +
> > +/**
> > + * DOC: Entity Object
> > + *
> > + * The entity object (&struct drm_sched_entity) is a container for job=
s which
> > + * should execute sequentially. Drivers should create an entity for ea=
ch
> > + * individual context they maintain for command submissions which can =
run in
> > + * parallel.
> > + *
> > + * The lifetime of the entity *should not* exceed the lifetime of the
> > + * userspace process it was created for and drivers should call the
> > + * drm_sched_entity_flush() function from their file_operations.flush(=
)
> > + * callback. It is possible that an entity object is not alive anymore
> > + * while jobs previously fetched from it are still running on the hard=
ware.
>=20
> This is not how Xe has implemented it. Instead, on FD close (or queue
> close, for that matter), we trigger our entity through a GPU command and
> immediately timeout all jobs,
>=20

How can Xe "timeout all jobs"? Are you interfering with the scheduler's
timeout work item?

Anyways, the docu just says "It is possible", not that it's typical. So
the docu is fine here, agreed?

>  signaling them accordingly. Technically,
> the object entity can outlive the FD, but the effects of the FD close
> are externally visible. The complete teardown process can outlive the FD
> as well, since it involves multiple ping-pong steps with our firmware. I
> believe this approach is also valid.
>=20
> > + *
> > + * This is done because all results of a command submission should bec=
ome
> > + * visible externally even after a process exits. This is normal POSIX
> > + * behavior for I/O operations.
> > + *
> > + * The problem with this approach is that GPU submissions contain exec=
utable
> > + * shaders enabling processes to evade their termination by offloading=
 work to
> > + * the GPU. So when a process is terminated with a SIGKILL the entity =
object
> > + * makes sure that jobs are freed without running them while still mai=
ntaining
> > + * correct sequential order for signaling fences.
> > + *
> > + * All entities associated with a scheduler have to be torn down befor=
e that
> > + * scheduler.
> > + */
> > +
> > +/**
> > + * DOC: Hardware Fence Object
> > + *
> > + * The hardware fence object is a dma_fence provided by the driver thr=
ough
> > + * &struct drm_sched_backend_ops.run_job. The driver signals this fenc=
e once the
> > + * hardware has completed the associated job.
> > + *
> > + * Drivers need to make sure that the normal dma_fence semantics are f=
ollowed
> > + * for this object. It's important to note that the memory for this ob=
ject can
> > + * *not* be allocated in &struct drm_sched_backend_ops.run_job since t=
hat would
> > + * violate the requirements for the dma_fence implementation. The sche=
duler
> > + * maintains a timeout handler which triggers if this fence doesn't si=
gnal
> > + * within a configurable amount of time.
> > + *
> > + * The lifetime of this object follows dma_fence refcounting rules. Th=
e
> > + * scheduler takes ownership of the reference returned by the driver a=
nd
> > + * drops it when it's not needed any more.
> > + *
> > + * See &struct drm_sched_backend_ops.run_job for precise refcounting r=
ules.
> > + */
> > +
> > +/**
> > + * DOC: Scheduler Fence Object
> > + *
> > + * The scheduler fence object (&struct drm_sched_fence) encapsulates t=
he whole
> > + * time from pushing the job into the scheduler until the hardware has=
 finished
> > + * processing it. It is managed by the scheduler. The implementation p=
rovides
> > + * dma_fence interfaces for signaling both scheduling of a command sub=
mission
> > + * as well as finishing of processing. &struct drm_sched_fence.finishe=
d is the
> > + * fence typically used to synchronize userspace, e.g., in a &struct d=
rm_syncobj.
>=20
> Is it ever not the finished fence? Early in Xe, I originally used the
> hardware fence, and it caused all sorts of trouble. One reason the DRM
> scheduler is a well-designed system is that the finished fence can be
> installed universally.

Agreed, we can say that it's always the finished fence.

(you should never call the GPU scheduler a "well-designed system",
though xD)

>=20
> I also suggest we add a wrapper to access the finished fence, so drivers
> don=E2=80=99t need to dig deep into scheduler objects to retrieve it.

Yes, ACK. I actually once had a patch somewhere which adds such a
wrapper and uses it in Nouveau. I can digg for it; but feel free to
provide one if you have some cycles.

>=20
> > + *
> > + * The lifetime of this object also follows normal dma_fence refcounti=
ng rules.
> > + */
> > +
> > +/**
> > + * DOC: Scheduler and Run Queue Objects
> > + *
> > + * The scheduler object itself (&struct drm_gpu_scheduler) does the ac=
tual
> > + * scheduling: it picks the next entity to run a job from and pushes t=
hat job
> > + * onto the hardware. Both FIFO and RR selection algorithms are suppor=
ted, with
> > + * FIFO being the default and the recommended one.
> > + *
> > + * The lifetime of the scheduler is managed by the driver using it. Be=
fore
> > + * destroying the scheduler the driver must ensure that all hardware p=
rocessing
> > + * involving this scheduler object has finished by calling for example
> > + * disable_irq(). It is *not* sufficient to wait for the hardware fenc=
e here
> > + * since this doesn't guarantee that all callback processing has finis=
hed.
> > + *
> > + * The run queue object (&struct drm_sched_rq) is a container for enti=
ties of a
> > + * certain priority level. This object is internally managed by the sc=
heduler
> > + * and drivers must not touch it directly. The lifetime of a run queue=
 is bound
> > + * to the scheduler's lifetime.
> > + *
> > + * All entities associated with a scheduler must be torn down before i=
t. Drivers
> > + * should implement &struct drm_sched_backend_ops.cancel_job to avoid =
pending
> > + * jobs (those that were pulled from an entity into the scheduler, but=
 have not
> > + * been completed by the hardware yet) from leaking.
> > =C2=A0 */
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * DOC: Flow Control
> > =C2=A0 *
> > =C2=A0 * The DRM GPU scheduler provides a flow control mechanism to reg=
ulate the rate
> > - * in which the jobs fetched from scheduler entities are executed.
> > + * at which jobs fetched from scheduler entities are executed.
> > =C2=A0 *
> > - * In this context the &drm_gpu_scheduler keeps track of a driver spec=
ified
> > - * credit limit representing the capacity of this scheduler and a cred=
it count;
> > - * every &drm_sched_job carries a driver specified number of credits.
> > + * In this context the &struct drm_gpu_scheduler keeps track of a driv=
er
> > + * specified credit limit representing the capacity of this scheduler =
and a
> > + * credit count; every &struct drm_sched_job carries a driver-specifie=
d number
> > + * of credits.
> > =C2=A0 *
> > - * Once a job is executed (but not yet finished), the job's credits co=
ntribute
> > - * to the scheduler's credit count until the job is finished. If by ex=
ecuting
> > - * one more job the scheduler's credit count would exceed the schedule=
r's
> > - * credit limit, the job won't be executed. Instead, the scheduler wil=
l wait
> > - * until the credit count has decreased enough to not overflow its cre=
dit limit.
> > - * This implies waiting for previously executed jobs.
> > + * Once a job is being executed, the job's credits contribute to the
> > + * scheduler's credit count until the job is finished. If by executing=
 one more
> > + * job the scheduler's credit count would exceed the scheduler's credi=
t limit,
> > + * the job won't be executed. Instead, the scheduler will wait until t=
he credit
> > + * count has decreased enough to not overflow its credit limit. This i=
mplies
> > + * waiting for previously executed jobs.
> > =C2=A0 */
> > =C2=A0
> > +/**
> > + * DOC: Error and Timeout handling
> > + *
>=20
> Should this section mention DRM_GPU_SCHED_STAT_NO_HANG usage?

Yes, it should.

>=20
> > + * Errors are signaled by using dma_fence_set_error() on the hardware =
fence
> > + * object before signaling it with dma_fence_signal(). Errors are then=
 bubbled
> > + * up from the hardware fence to the scheduler fence.
> > + *
> > + * The entity allows querying errors on the last run submission using =
the
> > + * drm_sched_entity_error() function which can be used to cancel queue=
d
> > + * submissions in &struct drm_sched_backend_ops.run_job as well as pre=
venting
> > + * pushing further ones into the entity in the driver's submission fun=
ction.
> > + *
> > + * When the hardware fence doesn't signal within a configurable amount=
 of time
> > + * &struct drm_sched_backend_ops.timedout_job gets invoked. The driver=
 should
> > + * then follow the procedure described in that callback's documentatio=
n.
> > + *
> > + * (TODO: The timeout handler should probably switch to using the hard=
ware
> > + * fence as parameter instead of the job. Otherwise the handling will =
always
> > + * race between timing out and signaling the fence).
> > + *
>=20
> This might be a bit invasive, and honestly, I'm not sure if the
> subsystem can handle it. I'd leave out this TODO for now. We can't
> predict the future, so it's probably best not to try in the
> documentation.

Yes. I think that TODO is actually surplus now that we have NO_HANG.


P.

>=20
> Matt
>=20
> > + * The scheduler also used to provided functionality for re-submitting=
 jobs
> > + * and, thereby, replaced the hardware fence during reset handling. Th=
is
> > + * functionality is now deprecated. This has proven to be fundamentall=
y racy
> > + * and not compatible with dma_fence rules and shouldn't be used in ne=
w code.
> > + *
> > + * Additionally, there is the function drm_sched_increase_karma() whic=
h tries
> > + * to find the entity which submitted a job and increases its 'karma' =
atomic
> > + * variable to prevent resubmitting jobs from this entity. This has qu=
ite some
> > + * overhead and resubmitting jobs is now marked as deprecated. Thus, u=
sing this
> > + * function is discouraged.
> > + *
> > + * Drivers can still recreate the GPU state in case it should be lost =
during
> > + * timeout handling *if* they can guarantee that forward progress will=
 be made
> > + * and this doesn't cause another timeout. But this is strongly hardwa=
re
> > + * specific and out of the scope of the general GPU scheduler.
> > + */
> > =C2=A0#include <linux/export.h>
> > =C2=A0#include <linux/wait.h>
> > =C2=A0#include <linux/sched.h>
> > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> > index fb88301b3c45..a97351435d9e 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -458,8 +458,8 @@ struct drm_sched_backend_ops {
> > =C2=A0	struct dma_fence *(*run_job)(struct drm_sched_job *sched_job);
> > =C2=A0
> > =C2=A0	/**
> > -	 * @timedout_job: Called when a job has taken too long to execute,
> > -	 * to trigger GPU recovery.
> > +	 * @timedout_job: Called when a hardware fence didn't signal within a
> > +	 * configurable amount of time. Triggers GPU recovery.
> > =C2=A0	 *
> > =C2=A0	 * @sched_job: The job that has timed out
> > =C2=A0	 *
> > @@ -506,7 +506,6 @@ struct drm_sched_backend_ops {
> > =C2=A0	 * that timeout handlers are executed sequentially.
> > =C2=A0	 *
> > =C2=A0	 * Return: The scheduler's status, defined by &enum drm_gpu_sche=
d_stat
> > -	 *
> > =C2=A0	 */
> > =C2=A0	enum drm_gpu_sched_stat (*timedout_job)(struct drm_sched_job *sc=
hed_job);
> > =C2=A0
> > --=20
> > 2.49.0
> >=20


