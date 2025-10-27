Return-Path: <linux-kernel+bounces-871312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391C3C0CE01
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B5C1894A47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035602EFDBA;
	Mon, 27 Oct 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhxPZcnv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D225F984
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559540; cv=none; b=lfQXRhF8PAcH/WeHXDdB6o8Eq5aFueiwBQmgrQtResJZjhY9Efn9VueEt+WvhbsT2Sjuv+dLmy6d25CFr77GPAyPhvhG9LqX8U+Y2EMBI9M2qZcazRVSO+8Os+GvF5xO85A52pewnREXpW1uW1DuhfFU8D/eeaIWj9oPqQqGRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559540; c=relaxed/simple;
	bh=eHA0hlYfdYZE/4LDQg1sbznUefERn3QEhxPIRLem2e4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HE/mst84oZSWTifZfUhydFxqwhfwVLlkQ0XCh7grkt+sHuUHFCRjIXmuKPBuiKWxYeWdAZVUtJRrAQKrYAY+hqkKWGfsTYRmX2o0sZNDHrFK1FFUAzzWla+XpXZGTc8+A6Cphm7GkDmHR2monjXzV8J/Oo1UYhY2Bch2ySsg4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhxPZcnv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761559538; x=1793095538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eHA0hlYfdYZE/4LDQg1sbznUefERn3QEhxPIRLem2e4=;
  b=PhxPZcnv5VC6xbpngnNb+Wr+CA/7ud7+i4R9Sv8iTL7FmXOiglieilKI
   O/osoOhk3ohnKJI0Rca+iPtAkQGPPWYhmF+XmhfG36K5ZPLrGZYau++5B
   VRiOlfnLXb55ZLPuasjmGcAX3MCfFbWdR5g7WJCdg8XK1zM/4mRkq93/v
   a5P2GcETlX4b4hUSR9j6XxXzXO9WOwNV2FCJLN5jPaK43sAlsSKAtfCAL
   cD6ietBLGDIIOb0ko8hSmIrIcW0jpzJuU1RWJ0xxdxuhBiqFWgJjIdbqz
   7DZ9VVhA9o0ejKLtY+S1kGI48MEa/BzrxUUPJQvsiW9hsZiRCnRTr/RNH
   A==;
X-CSE-ConnectionGUID: +EJo5Cu1ShqdnQRxaU0V1Q==
X-CSE-MsgGUID: WiZfcVZdS+uAD0TRQS1GkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86264387"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="86264387"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 03:05:37 -0700
X-CSE-ConnectionGUID: GYJkGqFpS4yIICYnpwQgsw==
X-CSE-MsgGUID: Az4NuaHTTFO6h6LxJ3vaVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="215656140"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 27 Oct 2025 03:05:33 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5DCC195; Mon, 27 Oct 2025 11:05:32 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Aaron Lu <ziqianlu@bytedance.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] sched/fair: Remove dead code which might prevent from building
Date: Mon, 27 Oct 2025 11:05:29 +0100
Message-ID: <20251027100529.1806944-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang, in particular, is not happy about dead code:

kernel/sched/fair.c:5233:19: error: unused function 'cfs_rq_throttled' [-Werror,-Wunused-function]
 5233 | static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
      |                   ^~~~~~~~~~~~~~~~
1 error generated.

kernel/sched/fair.c:6736:19: error: unused function 'cfs_rq_throttled' [-Werror,-Wunused-function]
 6736 | static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
      |                   ^~~~~~~~~~~~~~~~
1 error generated.

Remove a leftover from the previous cleanup.

Fixes: fe8d238e646e ("sched/fair: Propagate load for throttled cfs_rq")
Fixes: eb962f251fbb ("sched/fair: Task based throttle time accounting")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/sched/fair.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 273e2871b59e..0370f11e5c25 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5230,7 +5230,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
-static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 
 static void
 requeue_delayed_entity(struct sched_entity *se);
@@ -6733,11 +6732,6 @@ static void dequeue_throttled_task(struct task_struct *p, int flags) {}
 static bool enqueue_throttled_task(struct task_struct *p) { return false; }
 static void record_throttle_clock(struct cfs_rq *cfs_rq) {}
 
-static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
-{
-	return 0;
-}
-
 static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
 {
 	return false;
-- 
2.50.1


