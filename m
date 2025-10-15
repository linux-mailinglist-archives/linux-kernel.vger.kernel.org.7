Return-Path: <linux-kernel+bounces-854168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B3ABDDBEA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 548A1504DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D38E3195FD;
	Wed, 15 Oct 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvYFwl6s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A68302CA2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520007; cv=none; b=VyHQQifcRWNBsckJs5/+vuNZROJi+Y8LhLXz/OfUFDo4UVdfCIscSOZ5Ny7PPGwImI9X4V6A31VEOVSX5Y+thyiyeMqPExUM1aeV8DpwLnyxI+abDOPGQBJZkjtBc2G8A3YxuEVNdhldBjsHsz0c0Hfpsp0yUKNtavZvRmKFMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520007; c=relaxed/simple;
	bh=KFLBr9oHLUDWKHkYETCDph/T5w/KuYX51hvKqwOIrDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TOEMnSMMjtgm7N09c+FLwVf/K5gEfbGTdiWBA1pH0yDrG0yaF0Ctcmjl1kWWa8icpzd44ZMcs4V104XXqtTtqe1okAjNI3otRUzRXqgmaftR9M8rP3K2C0VeeUCSnODCaipTN+tL2xfaETdyRVyssCU2DnRfHIeKCXNwI2H2C+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvYFwl6s; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760520006; x=1792056006;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KFLBr9oHLUDWKHkYETCDph/T5w/KuYX51hvKqwOIrDU=;
  b=BvYFwl6sglUepCeadxmmUHaU02RLR3JS/a2GPFobH+3p4bupxtWsFppL
   kYigFv69bl7qQ6GPnJynqEkV+DlJUgUYUzGf5Hy4qOlstB9CY8klJVS3p
   VKQo2kxIdXXZ+dfUMze2bLnZZZdbp8YTk/mi7WG/5+JjHscWYsziK4n6U
   QK9O8C75k5dp/C+KxBJLIIEuDT/oXd3KtzlBx3mentw809gmn5EC3XXgk
   pMfW1UWMde8eYKsVnWP2MoSn247grfDjCZioF+ufkbl2MCH5zJqtmPHwz
   gKBGTIwuNLPEchLNKNHFZemb6NQOtRkKaR6WFJkKoZafSDthvd1ipDJjZ
   Q==;
X-CSE-ConnectionGUID: KxQStfEuR4eUrZIvqaHVAg==
X-CSE-MsgGUID: fuCmnYFGRSGJZXj8yXmF/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66517395"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="66517395"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:20:00 -0700
X-CSE-ConnectionGUID: PRlNHBlhSCyOPFqKWiFkLA==
X-CSE-MsgGUID: uhH72m9vTv+MPEyaG8jCMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="213066488"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 15 Oct 2025 02:19:56 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 163DB96; Wed, 15 Oct 2025 11:19:55 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] sched: Remove never used code in mm_cid_get()
Date: Wed, 15 Oct 2025 11:19:34 +0200
Message-ID: <20251015091935.2977229-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang is not happy with set but unused variable (this is visible
with `make W=1` build:

kernel/sched/sched.h:3744:18: error: variable 'cpumask' set but not used [-Werror,-Wunused-but-set-variable]

It seems like the variable was never be used along with the assignment that
does not have side effects as far as I can see. Remove those altogether.

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/sched/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f5d07067f60..361f9101cef9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3740,11 +3740,9 @@ static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
 			     struct mm_struct *mm)
 {
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	struct cpumask *cpumask;
 	int cid;
 
 	lockdep_assert_rq_held(rq);
-	cpumask = mm_cidmask(mm);
 	cid = __this_cpu_read(pcpu_cid->cid);
 	if (mm_cid_is_valid(cid)) {
 		mm_cid_snapshot_time(rq, mm);
-- 
2.50.1


