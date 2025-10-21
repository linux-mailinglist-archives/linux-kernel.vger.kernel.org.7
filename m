Return-Path: <linux-kernel+bounces-863734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB07BF8F54
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EC77351E49
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E6B296BB2;
	Tue, 21 Oct 2025 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwIyxUmw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D42428CF52
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082800; cv=none; b=YkuFHeFuZCsdv2yw8WvrwHU0ulGskffAvT+gqpFv95mwHszUxBgQiIZsq9TfEJ2uy88K5fE1EHC4Bp4VLfwsS7i4lzh8UqDX1xetnqAjYL7nja6f1T+hBH+o8JJKkJcpPuMM83MWaCrqCuql+4YA7G+2ot4AxWcKGSfpPgG19dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082800; c=relaxed/simple;
	bh=/3gsznqjETCpL20UYfZwzexm+NaWvwrW1/yQ+wV6JyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cgbofxvgwUYHZHvXnzcZZt2DhUrvlMcU+UdUiQHYo8tI6QQgZ+XSL04wL0CTUBOM06LiFsfj3gzzqamUCNEuT0+nk8nfIr97y5V82/6zUKDkfVZYwjlcM6wInLP3b7UFIFEuCnn7N3Ce7xKolImRjJ2+l0fSK7gsHlkZUWtbLzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwIyxUmw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761082799; x=1792618799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/3gsznqjETCpL20UYfZwzexm+NaWvwrW1/yQ+wV6JyY=;
  b=CwIyxUmwjc0SY7muHzTtIJQL5q0YzXZ1Wq79x+YAuvLkJIMIngjzpO4R
   XbtTDAJNWFLXXGIi9zssbMhdPANe83a8ZW5u+eZfgitU2KH5dB+lvKjL0
   RlbY4Z1oqGfHVL831zouFeMUOdvxzikkIbuXr0TnEHd2wGtXb4+uXEThk
   GFu62xC0Y4HZvDc0VE99i1vXi89TdxCzWcriIRA0uq5/SyS0FJOHDS2L7
   A4rqu1bakMuT7uXBDYsAlsK30YNgHFKijusUa8c4lHrPXVOvunwoe+mpm
   YoS/yNcEoTOQXykMYwU+FWozUmCJ0jZo0SBGc8hKY9aud3yfEt2uUOl1e
   w==;
X-CSE-ConnectionGUID: CFC0ae1wSc2+/JkYM3OSUQ==
X-CSE-MsgGUID: wqFyziUCTYCLvhD20thkFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62923172"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="62923172"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 14:39:56 -0700
X-CSE-ConnectionGUID: vBqdgJ5qTUKDgNHJC/1Vnw==
X-CSE-MsgGUID: WNCBPE2aRt+VeBntHPyDbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="184099254"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 14:39:56 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: jiangshanlai@gmail.com,
	tj@kernel.org,
	simona.vetter@ffwll.ch,
	christian.koenig@amd.com,
	pstanner@redhat.com,
	dakr@kernel.org
Subject: [RFC PATCH 1/3] workqueue: Add an interface to taint workqueue lockdep with reclaim
Date: Tue, 21 Oct 2025 14:39:50 -0700
Message-Id: <20251021213952.746900-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021213952.746900-1-matthew.brost@intel.com>
References: <20251021213952.746900-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers often use workqueues that are in the reclaim path (e.g., DRM
scheduler workqueues). It is useful to teach lockdep that memory cannot
be allocated on these workqueues. Add an interface to taint workqueue
lockdep with reclaim.

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 include/linux/workqueue.h | 19 +++++++++++++++++++
 kernel/workqueue.c        |  9 +++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index dabc351cc127..954c7eb7e225 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -553,6 +553,25 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
 						1, lockdep_map, ##args))
 #endif
 
+
+#ifdef CONFIG_LOCKDEP
+/**
+ * taint_reclaim_workqueue - taint workqueue lockdep map with reclaim
+ * @wq: workqueue to taint with reclaim
+ * gfp: gfp taint
+ *
+ * Drivers often use workqueues that are in the reclaim path (e.g., DRM
+ * scheduler workqueues). It is useful to teach lockdep that memory cannot be
+ * allocated on these workqueues.
+ */
+extern void taint_reclaim_workqueue(struct workqueue_struct *wq, gfp_t gfp);
+#else
+static inline void taint_reclaim_workqueue(struct workqueue_struct *wq,
+					   gfp_t gfp)
+{
+}
+#endif
+
 /**
  * alloc_ordered_workqueue - allocate an ordered workqueue
  * @fmt: printf format for the name of the workqueue
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 45320e27a16c..fea410c20b71 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5846,6 +5846,15 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags,
 	return wq;
 }
 EXPORT_SYMBOL_GPL(alloc_workqueue_lockdep_map);
+
+void taint_reclaim_workqueue(struct workqueue_struct *wq, gfp_t gfp)
+{
+	fs_reclaim_acquire(gfp);
+	lock_map_acquire(wq->lockdep_map);
+	lock_map_release(wq->lockdep_map);
+	fs_reclaim_release(gfp);
+}
+EXPORT_SYMBOL_GPL(taint_reclaim_workqueue);
 #endif
 
 static bool pwq_busy(struct pool_workqueue *pwq)
-- 
2.34.1


