Return-Path: <linux-kernel+bounces-863736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2123BF8F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05073B8DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4300029E109;
	Tue, 21 Oct 2025 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VnfOjQSo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B85296BD5
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082801; cv=none; b=TdY9K2YhplCkEhSkzyRrFw+5jlSZR1qqxjFhlcbkaqyL8PEwrQiIYak10XBq+VCXp+xbz60QyL02pB0qMEtvMXmWTAs8ro2oFWFz05Xwy5jkr2KwMOsKBl29sNWJL49dbgxPEYMfMBxivzN9/pf4QUKhjR1dBk3NCJZCf9BZqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082801; c=relaxed/simple;
	bh=c96y7LtRhZ9y5IbVNkHX5Ncnp0OQYwuRsGhEKLGrjmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8Bzq2ynfjSg59z3eOqye70LsIU3lfEEIHEEWPCXnBNKRugwxCUGDWz5BvjxBNJdoOEI91u3SecqD8R1nQN2JQcLNrqQMrOJWbwSy7X+a4VNirpnZbAitPUtdzuK5FzhKwX/+3/Yttt/ONADhxp1vtJl/9SONTjXx3mYBiH8+is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VnfOjQSo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761082800; x=1792618800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c96y7LtRhZ9y5IbVNkHX5Ncnp0OQYwuRsGhEKLGrjmE=;
  b=VnfOjQSowj7ZpUSdLjV2uaHwEVZbpxlQnsqGHupMy17w0G3jxXWyki5z
   7aOZ85TYpGuarCOpd4RHC27L5T9HDcYE+obuECFnoajX4o/VnV76SvIZI
   u6hvM8fQLaln2+eVn+/yy3Y1ixgxXtn8XIiBjJxPhRqiws/KqyYOPCwFh
   Riu+vRxm6ZF5/V/Il/Kto+yiC+xA82mM75ILov84bTw1MOiYptttw1fi0
   d5+N1OwQs/nIL22VJlqngyjRIi2GqE07BWM+L5SkOYpLtJm/4ybZeCsc6
   5LSGpEZO+Z3a6tyjBwgd5D5pTfpzFaTB0IBreO2/OwI8mv0kStJY0aD8c
   Q==;
X-CSE-ConnectionGUID: kdt+dZ8BRyCOvedi209jBg==
X-CSE-MsgGUID: YUlzTw9FQuqhkNPKWepekA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62923175"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="62923175"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 14:39:57 -0700
X-CSE-ConnectionGUID: WL9FFkjsRwqdpdy6HecLjA==
X-CSE-MsgGUID: 4aAAcozCRvqXMAPSuq535A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="184099257"
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
Subject: [RFC PATCH 3/3] drm/sched: Prevent adding dependencies to an armed job
Date: Tue, 21 Oct 2025 14:39:52 -0700
Message-Id: <20251021213952.746900-4-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021213952.746900-1-matthew.brost@intel.com>
References: <20251021213952.746900-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to the DMA scheduler documentation, once a job is armed, it
must be pushed. Drivers should avoid calling the failing code path that
attempts to add dependencies after a job has been armed. This change
enforces that rule.

Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 676484dd3ea3..436cb2844161 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -873,7 +873,8 @@ EXPORT_SYMBOL(drm_sched_job_arm);
  * @job: scheduler job to add the dependencies to
  * @fence: the dma_fence to add to the list of dependencies.
  *
- * Note that @fence is consumed in both the success and error cases.
+ * Note that @fence is consumed in both the success and error cases. This
+ * function cannot be called if the job is armed.
  *
  * Returns:
  * 0 on success, or an error on failing to expand the array.
@@ -886,6 +887,10 @@ int drm_sched_job_add_dependency(struct drm_sched_job *job,
 	u32 id = 0;
 	int ret;
 
+	/* Do not allow additional dependencies when job is armed */
+	if (WARN_ON_ONCE(job->sched))
+		return -EINVAL;
+
 	if (!fence)
 		return 0;
 
-- 
2.34.1


