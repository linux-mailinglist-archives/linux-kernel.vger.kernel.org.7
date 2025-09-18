Return-Path: <linux-kernel+bounces-798952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B35B1B4253D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91ABD188C1B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131482405F8;
	Wed,  3 Sep 2025 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="mTew4Jh/"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C1235BEE;
	Wed,  3 Sep 2025 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913021; cv=none; b=BRQcgGK/FejeYIx3k7tNk7MIGFHgB2b9H9zTRGRL3Ee3ueV5Nnm5uXQhGqiwFBVK9KgfTIHm9/vstdqbmcuTfxRv+qfhxvOisvlQUj86ebd5RHN9sArhH+IpW+SHlC+JzEW/nQ0bJ1AgjmM3p8I8JYfTkXoMq5sA0yEOQJq8s3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913021; c=relaxed/simple;
	bh=TvDta4McjhnzuEy2xW4GYu/T8VPhO/wxHBtycv4d2N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uBA4siDNU58WaRfXX0+5j30L8eOtVAiDVI9ZJv7jjitvryWS88l9VYmQfovsE/wAjeB+RCONybRIKVcrvrmiaawa1WuTQ7TSgl2oKujCX9DMlY3lxxSYnSDvA/MjSZORRXrtvlSEqIeEfZsooGEcqkM/xWl9DQA+VT9EGdaCP0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=mTew4Jh/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4MRKQulej780VJfP2ETWJfXfA8Y35D1SCqdJePPKBTw=; b=mTew4Jh/RJBULbtWgapEOZgCm1
	91cq91MPcwUWLsa3P6TvUsUHlS5ifplR/vl4g3cUlU8i7wldHVHp2oowJ6gcMaK40QMvH/RR7Z4BC
	H1eysI07s1DYMb7McxD+HYQSDt+nsyaDYTEtnfhI09MJpNK5OCVbBcs+PQTlKmWEfV1iw/T9ScyUq
	Mf8fJZDDhVn71a2wQw70ZlQdfdAIVPmhR2p5+0WtsPxlsCSMOq4Cfb6gdF09dl36V0z6Z1iXbEbKo
	b4ZbisxgBF2P0Y+ICmSOq5qmr2G8RUfM0vr4H6XF+IjMg+i0cKfQdr9psWUwNh427zG3TM0eHKzeq
	9zUyMPyg==;
Received: from [84.66.36.92] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utpKd-006GYJ-1s; Wed, 03 Sep 2025 17:23:31 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com,
	intel-xe@lists.freedesktop.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Leo Liu <Leo.Liu@amd.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	Philipp Stanner <phasta@kernel.org>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Rob Clark <robdclark@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: [RFC v8 00/21] DRM scheduling cgroup controller
Date: Wed,  3 Sep 2025 16:23:06 +0100
Message-ID: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is another respin of this old work^1 which since v7 is a total rewrite and
completely changes how the control is done.

Now it builds upon the independent "fair" DRM scheduler work I have been posting
recently^2. I am including those patches in this series for completeness.

-> It also means people only interested into the cgroup portion probably only
   need to look at the last nine patches.

   And of those nine the last three are examples of how DRM scheduler based
   DRM drivers can be wired up with the cgroup controller. Simpler version for
   amdgpu which uses the scheduler for scheduling, and a bit more complicated
   for a firmware scheduler driver such as Intel xe.

To illustrate the runtime effects I ran the Unigine Heaven benchmark in
parallel with the deferredmultisampling Vulkan demo, each in its own cgroup.
First the scheduling weights were the default 100 and 100 respectively, and we
look at the GPU utilisation:

  https://people.igalia.com/tursulin/drmcgroup-100-100.png

It is about equal or therabout since it oscillates at runtime as the benchmark
scenes change.

Then we change drm.weight of the deferredmultisampling cgroup to 1:

  https://people.igalia.com/tursulin/drmcgroup-100-1.png

There we see around 75:25 in favour of Unigine Heaven. (Although it also
oscillates as explained above).

Or another way to show how nicely it works is to run two instances of Unigine
Heaven in parallel. One can then play with assigning different GPU shares to
each instance by tweaking the drm.weight control file at runtime. Assuming the
two benchmarks belong to different cgroups of course.

It is also important to note that the control is not nowhere as precise and
accurate as with the CPU controller, and that the "fair" DRM scheduler is not
guaranteed to be fair due limitations of GPU scheduling.

Going into the implementation, since v7 it is much simpler than before since the
mechanism of time budgets and over-budget signalling is completely gone and
replaced with notifying clients directly about their assigned relative
scheduling weights.

This connects really nicely with the fair DRM scheduler RFC since we can simply
mix in the scheduling weight with the existing scheduling entity priority based
runtime to vruntime scaling factors.

It also means there is much less code in the controller itself.

Another advantage is that it is really easy to wire up individual drivers which
use the DRM scheduler in the hardware scheduling mode. Amdgpu support is
included near the end of the series in the form of two patches adding helpers to
the DRM scheduler, and one patch wiring up the driver to use them.

For the drivers which use firmware scheduling, such as for example Intel xe, I
have also provided an example of how they could be wired up. Concretely, we can
make them track the lowest and highest scheduling weight clients per device, and
assign low and high scheduling priority to those respectively. Last two patches
in the series demonstrate exactly that. This cannot provide fine grained weights
but is effective for basic use cases and does not preclude a smarter
implementation in the future. (Also note that for the purpose of an RFC the xe
implementation is not fully complete and requires cgroup weights to be modified
after DRM clients are opened. Ie. first start clients, then re-configure cgroups
in order to see the effects.)

On the userspace interface side of things it is the same as before. We have
drm.weight as an interface, taking integers from 1 to 10000, the same as CPU and
IO cgroup controllers.

About the use cases, it is the same as before. With this we would be able to run
a workload in the background and make it compete less with the foreground load.
Be it explicitly or when integrating with Desktop Environments some of which
already have cgroup support for tracking foreground vs background windows or
similar.

I would be really interested if people would attempt to try this out, either
directly the amdgpu support as provided in the series, or by wiring up other
drivers.

P.S.
About the CC list. This is a large series so I will put most people on Cc only
in the cover letter as a ping of a kind. Who is interested to read more can find
the series in the archives or in my git repository.

The code is also available at https://gitlab.freedesktop.org/tursulin/kernel/-/tree/drm-sched-cfs?ref_type=heads

1)
https://lore.kernel.org/dri-devel/20231024160727.282960-1-tvrtko.ursulin@linux.intel.com/

2)
https://lore.kernel.org/dri-devel/20250425102034.85133-1-tvrtko.ursulin@igalia.com/

v8:
 * Wired up xe as an example on how firmware schedulers can benefit.
 * Rebased on top of latest fair DRM scheduler.
 * Documented the purpose of delayed update weights worker and reduce the delay.
 * Use cgroup_taskset_for_each_leader().
 * Use destination group from cgroup_taskset_for_each_leader in drmcs_attach().

Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
CC: Leo Liu <Leo.Liu@amd.com>
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: Michel Dänzer <michel.daenzer@mailbox.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Tejun Heo <tj@kernel.org>

Tvrtko Ursulin (21):
  drm/sched: Add some scheduling quality unit tests
  drm/sched: Add some more scheduling quality unit tests
  drm/sched: Implement RR via FIFO
  drm/sched: Consolidate entity run queue management
  drm/sched: Move run queue related code into a separate file
  drm/sched: Free all finished jobs at once
  drm/sched: Account entity GPU time
  drm/sched: Remove idle entity from tree
  drm/sched: Add fair scheduling policy
  drm/sched: Break submission patterns with some randomness
  drm/sched: Remove FIFO and RR and simplify to a single run queue
  drm/sched: Embed run queue singleton into the scheduler
  cgroup: Add the DRM cgroup controller
  cgroup/drm: Track DRM clients per cgroup
  cgroup/drm: Add scheduling weight callback
  cgroup/drm: Introduce weight based scheduling control
  drm/sched: Add helper for tracking entities per client
  drm/sched: Add helper for DRM cgroup controller weight notifications
  drm/amdgpu: Register with the DRM scheduling cgroup controller
  drm/xe: Allow changing GuC scheduling priority
  drm/xe: Register with the DRM scheduling cgroup controller

 Documentation/admin-guide/cgroup-v2.rst       |  22 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  27 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c       |   8 +-
 drivers/gpu/drm/drm_file.c                    |  11 +
 drivers/gpu/drm/scheduler/Makefile            |   2 +-
 drivers/gpu/drm/scheduler/sched_entity.c      | 168 ++--
 drivers/gpu/drm/scheduler/sched_fence.c       |   2 +-
 drivers/gpu/drm/scheduler/sched_internal.h    |  86 +-
 drivers/gpu/drm/scheduler/sched_main.c        | 398 +--------
 drivers/gpu/drm/scheduler/sched_rq.c          | 356 ++++++++
 drivers/gpu/drm/scheduler/tests/Makefile      |   3 +-
 .../gpu/drm/scheduler/tests/tests_scheduler.c | 824 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_device.c                |  18 +
 drivers/gpu/drm/xe/xe_device_types.h          |  15 +
 drivers/gpu/drm/xe/xe_exec_queue.c            |  80 ++
 drivers/gpu/drm/xe/xe_exec_queue.h            |   5 +
 drivers/gpu/drm/xe/xe_gpu_scheduler_types.h   |   1 +
 drivers/gpu/drm/xe/xe_guc_submit.c            |  49 +-
 drivers/gpu/drm/xe/xe_pm.c                    |   4 +
 include/drm/drm_drv.h                         |  26 +
 include/drm/drm_file.h                        |  11 +
 include/drm/gpu_scheduler.h                   |  75 +-
 include/linux/cgroup_drm.h                    |  29 +
 include/linux/cgroup_subsys.h                 |   4 +
 init/Kconfig                                  |   5 +
 kernel/cgroup/Makefile                        |   1 +
 kernel/cgroup/drm.c                           | 443 ++++++++++
 34 files changed, 2239 insertions(+), 484 deletions(-)
 create mode 100644 drivers/gpu/drm/scheduler/sched_rq.c
 create mode 100644 drivers/gpu/drm/scheduler/tests/tests_scheduler.c
 create mode 100644 include/linux/cgroup_drm.h
 create mode 100644 kernel/cgroup/drm.c

-- 
2.48.0


