Return-Path: <linux-kernel+bounces-876105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66823C1AA09
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520B41A2409E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF1D3358CC;
	Wed, 29 Oct 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XmiicT+2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lt27ZaoR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC6325720
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743337; cv=none; b=VbRiLGhYIM/PfxAPemhTWE5lgRvfR7R/mYAOQ87Vy7X+jAURrJWY4mxqGt5cvqO2B39YRmqdO9O6xQDn1gLlNTHs6be9Hn3GnqGUkt6+T5jOlCYazVLnH32fJpdgnWnUgsFFjtvQwtUkz55m21waQUPViXuTC8vs9kZ8ocsDsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743337; c=relaxed/simple;
	bh=lOMZrAvliOx196QfFodbWxahcAy1e8Bn8F3erdtH+6U=;
	h=Message-ID:From:To:Cc:Subject:Date; b=TCz1IrB94M9OJZjPH9BUxndRYeG+2//utnLFlVSfgbjkppOfLYFu57Xv23QSeh/KY22OHF5HaT0lNLT9xt/JvN6p+gGBbFzrfwpvwOuRKMYYyb9fe4UGSsi74pgT9Evfuv6YBy/mTa4IfI1wR50aR7ucgFb9qucFdl6syvf4qsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XmiicT+2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lt27ZaoR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029123717.886619142@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=E6uGlIXEHEXRuZxhLdmeFaBOnt/rFab9tzTHxBT66W8=;
	b=XmiicT+2/1RFy4wMTg4TAnWEFS9Ajj7ZbkwZPFeQ/nHs+ViweuIPAE8ew0PUySc/bb8HUB
	TEEO9LZjvcWkh7+kRm+VpBno760DTtDVlvHHuXkcyGcSWLGViWVLUdHTbaueBz91Iixt+S
	2Zr9uXH7n6Gw/6af3eciIioWAVw2s4r54zuuOljgsyWaSu3jtlqgIT6nlEo2Kxd/Fe3Nr8
	06yT+HNbZCJlWatdtnGz0T5toZeV7yZ5dVwzN4lTa8iDUVDjwoJScOgxpicLESVngFkgyw
	APeQkyAjv9x8y1h9GkO4D5/2aAGl89fcHLDaVia1ui1rqrWF416vD6Sx8wG4Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=E6uGlIXEHEXRuZxhLdmeFaBOnt/rFab9tzTHxBT66W8=;
	b=Lt27ZaoRK7SXc2Wm0HU3b/UnlkwNs97gJPAePKKAzIEcTQorGe8vvOen8SmYOKok69tnm/
	Sow7+Yd8neFXe4CQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [patch V3 00/20] sched: Rewrite MM CID management
Date: Wed, 29 Oct 2025 14:08:52 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up on V2 series which can be found here:

    https://lore.kernel.org/20251022104005.907410538@linutronix.de

The V1 cover letter contains a detailed analyisis of the issues:

    https://lore.kernel.org/20251015164952.694882104@linutronix.de

TLDR: The CID management is way to complex and adds significant overhead
into scheduler hotpaths.

The series rewrites MM CID management in a more simplistic way which
focusses on low overhead in the scheduler while maintaining per task CIDs
as long as the number of threads is not exceeding the number of possible
CPUs.

The series is based on the V6 series of the rseq rewrite:

    https://lore.kernel.org/20251027084220.785525188@linutronix.de

which is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/rseq

The series on top of the tip core/rseq branch is available from git as
well:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/cid

Changes vs. V2:

   - Rename to cpumask/bitmap_weighted_or() - Yury

   - Zero the bitmap with length of bitmap_size(nr_possible_cpus()) -
     Shrikanth
   
   - Move cpu_relax() out of for() as that fails to build when cpu_relax()
     is a macro. - Shrikanth

   - Picked up Reviewed/Acked-by tags where appropriate

Thanks,

	tglx
---
Thomas Gleixner (20):
      sched/mmcid: Revert the complex CID management
      sched/mmcid: Use proper data structures
      sched/mmcid: Cacheline align MM CID storage
      sched: Fixup whitespace damage
      sched/mmcid: Move scheduler code out of global header
      sched/mmcid: Prevent pointless work in mm_update_cpus_allowed()
      cpumask: Introduce cpumask_weighted_or()
      sched/mmcid: Use cpumask_weighted_or()
      cpumask: Cache num_possible_cpus()
      sched/mmcid: Convert mm CID mask to a bitmap
      signal: Move MMCID exit out of sighand lock
      sched/mmcid: Move initialization out of line
      sched/mmcid: Provide precomputed maximal value
      sched/mmcid: Serialize sched_mm_cid_fork()/exit() with a mutex
      sched/mmcid: Introduce per task/CPU ownership infrastrcuture
      sched/mmcid: Provide new scheduler CID mechanism
      sched/mmcid: Provide CID ownership mode fixup functions
      irqwork: Move data struct to a types header
      sched/mmcid: Implement deferred mode change
      sched/mmcid: Switch over to the new mechanism

 include/linux/bitmap.h         |   15 
 include/linux/cpumask.h        |   26 +
 include/linux/irq_work.h       |    9 
 include/linux/irq_work_types.h |   14 
 include/linux/mm_types.h       |  125 ------
 include/linux/rseq.h           |   27 -
 include/linux/rseq_types.h     |   71 +++
 include/linux/sched.h          |   19 
 init/init_task.c               |    3 
 kernel/cpu.c                   |   15 
 kernel/exit.c                  |    1 
 kernel/fork.c                  |    7 
 kernel/sched/core.c            |  815 +++++++++++++++++++----------------------
 kernel/sched/sched.h           |  395 ++++++++-----------
 kernel/signal.c                |    2 
 lib/bitmap.c                   |    6 
 16 files changed, 727 insertions(+), 823 deletions(-)



