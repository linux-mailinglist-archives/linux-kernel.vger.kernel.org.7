Return-Path: <linux-kernel+bounces-658768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EA6AC070A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 10:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3F04A775A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 08:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2471264625;
	Thu, 22 May 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSd/dhHd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668E254AF4
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902478; cv=none; b=Cm4R72j0jTKe1PfRaRRdVtDK3mkstl4IqSKuBEzo3eWXJLnmg7JVMrr3vWgXZLlYUCeHYiKJaeWSt7vjlHrSW07xlsja6EBSYGvy1PrNPa88LE39GbKVGp3WgidyS9uNM568ZjcfxT9jwMAm+f3y/aCD1WqbiXxg0LK5o9tTw/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902478; c=relaxed/simple;
	bh=KtqwWNe4Z4Kx61HwvlqatDdD4BtnGXUSu6BdNXm1Ni0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byqkBRT32lc6qy2hxuP/O7AOTbJC8YtzZ+6hGvphXPNtWNf3fV1I8IH3H7teNpT6fb3mMUrP00cqRvhZX4i34PCRnhXGFpWdLLRkPjRKhQLKVeJB4REC1h9yawpToKjEw89KbxJ7Qnw3wETsAGeihHNSDrHs0f3+mE/98E187OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSd/dhHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39977C4CEE4;
	Thu, 22 May 2025 08:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747902477;
	bh=KtqwWNe4Z4Kx61HwvlqatDdD4BtnGXUSu6BdNXm1Ni0=;
	h=From:To:Cc:Subject:Date:From;
	b=mSd/dhHd3ci05CgYvx15lgIJJ7WUnTeOViLJjw/M7uTORBDWNhKR7/1qIT0/lktKl
	 vzr3veNnn4zNh8DwSwgN5YG7eGqKFpk3wl9jnFeWaOQDMT4OCnkxfHLIr6aTNh+lmk
	 2krewhU9Nvye5hs/5sA2qDEZQw94MmAlWDickUWL59lbiAOVm474Jq+h9cghWHT6PZ
	 SjtL3tDAfFQA9B3QDyWzh4J8OjoBezXBmjHIKHeMhz30acCMQWmlWNlTN766FjqTor
	 RZAwAG6TDA2cdW16Jv5WYrcyLkB6H1CxbrmhMrZctMkhOOlxpKjkzAabw79XBwyjXB
	 4yM2mxs/4cN0A==
From: Philipp Stanner <phasta@kernel.org>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Fix memory leaks in drm_sched_fini()
Date: Thu, 22 May 2025 10:27:38 +0200
Message-ID: <20250522082742.148191-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog below.

I experimented with the alternative solution (cancel_job() callback) and
maintain the position that this approach is more stable and robust,
despite more code added. I feel more comfortable with it regarding
stability and the possiblity of porting more drivers.

Changes in v3:
  - Fix and simplify cleanup callback in unit tests. Behave like a
    driver would: cancel interrupts (hrtimer), then simply run into
    drm_sched_fini().
  - Use drm_mock_sched_complete() as a centralized position to signal
    fences.
  - Reorder pending_list-is-empty warning patch for correct behavior. (Tvrtko)
  - Rename cleanup callback so that it becomes clear that it's about
    signaling all in-flight fences. (Tvrtko, Danilo, Me)
  - Add more documentation for the new functions.
  - Fix some typos.

Changes in v2:
  - Port kunit tests to new cleanup approach (Tvrtko), however so far
    still with the fence context-kill approach (Me. to be discussed.)
  - Improve len(pending_list) > 0 warning print. (Me)
  - Remove forgotten RFC comments. (Me)
  - Remove timeout boolean, since it's surplus. (Me)
  - Fix misunderstandings in the cover letter. (Tvrtko)

Changes since the RFC:
  - (None)

Howdy,

as many of you know, we have potential memory leaks in drm_sched_fini()
which have been tried to be solved by various parties with various
methods in the past.

In our past discussions, we came to the conclusion, that the simplest
solution, blocking in drm_sched_fini(), is not possible because it could
cause processes ignoring SIGKILL and blocking for too long (which could
turn out to be an effective way to generate a funny email from Linus,
though :) )

Another idea was to have submitted jobs refcount the scheduler. I
investigated this and we found that this then *additionally* would
require us to have *the scheduler* refcount everything *in the driver*
that is accessed through the still running callbacks; since the driver
would want to unload possibly after a non-blocking drm_sched_fini()
call. So that's also no solution.

This RFC here is a new approach, somewhat based on the original
waitque-idea. It looks as follows:

1. Have drm_sched_fini() block until the pending_list becomes empty with
   a waitque, as a first step.
2. Provide the scheduler with a callback with which it can instruct the
   driver to kill the associated fence context. This will cause all
   pending hardware fences to get signalled. (Credit to Danilo, whose
   idea this was)
3. In drm_sched_fini(), first switch off submission of new jobs and
   timeouts (the latter might not be strictly necessary, but is probably
   cleaner).
4. Then, call the aformentioned callback, ensuring that free_job() will
   be called for all remaining jobs relatively quickly. This has the
   great advantage that the jobs get cleaned up through the standard
   mechanism.
5. Once all jobs are gone, also switch off the free_job() work item and
   then proceed as usual.

Furthermore, since there is now such a callback, we can provide an
if-branch checking for its existence. If the driver doesn't provide it,
drm_sched_fini() operates in "legacy mode". So none of the existing
drivers should notice a difference and we remain fully backwards
compatible.

Our glorious beta-tester is Nouveau, which so far had its own waitque
solution, which is now obsolete. The last two patches port Nouveau and
remove that waitque.

I've tested this on a desktop environment with Nouveau. Works fine and
solves the problem (though we did discover an unrelated problem inside
Nouveau in the process).

Tvrtko's unit tests also run as expected (except for the new warning
print in patch 3), which is not surprising since they don't provide the
callback.

I'm looking forward to your input and feedback. I really hope we can
work this RFC into something that can provide users with a more
reliable, clean scheduler API.

Philipp

Philipp Stanner (5):
  drm/sched: Fix teardown leaks with waitqueue
  drm/sched/tests: Port tests to new cleanup method
  drm/sched: Warn if pending list is not empty
  drm/nouveau: Add new callback for scheduler teardown
  drm/nouveau: Remove waitque for sched teardown

 drivers/gpu/drm/nouveau/nouveau_abi16.c       |   4 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c         |   2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.c       |  39 ++++---
 drivers/gpu/drm/nouveau/nouveau_sched.h       |  12 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c        |   8 +-
 drivers/gpu/drm/scheduler/sched_main.c        | 108 +++++++++++++++---
 .../gpu/drm/scheduler/tests/mock_scheduler.c  |  67 ++++-------
 drivers/gpu/drm/scheduler/tests/sched_tests.h |   4 +-
 include/drm/gpu_scheduler.h                   |  19 +++
 9 files changed, 170 insertions(+), 93 deletions(-)

-- 
2.49.0


