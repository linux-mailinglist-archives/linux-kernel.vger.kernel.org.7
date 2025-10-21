Return-Path: <linux-kernel+bounces-863735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD273BF8F57
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B1374E7EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD429B776;
	Tue, 21 Oct 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvZkWawf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF528D82A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761082800; cv=none; b=jYsD0MSg3RgWbYefRYAxl1tBadevy+pQY2RQnrAuN823ik0k8aoSdxHGxly9Kjce5t9v66Qfu3yNHUF92NTDkKrjgtCPzKABjni99Nvjctr/xiRcGLDpm+mfw6ZwzJLjEIx8E6EegEL1EIIGyxzoeZaIfvu2Ua6r3apDyBBbwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761082800; c=relaxed/simple;
	bh=iW/BcUJLCLLlHu2nMhEhUz1mgvhc+oR29dpeVfRwugQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asjovs7+ZjJn0rLl3qgoWlQI85IIL1nyUcWL5thiN35Qq6lEGUJzeYZe4JnNF3/6vM2CkSwzc1SQMA4Lb3Ej45IZcekq/6n1Ae/qr3wKeKgnZxVFXKFqGPLtkQAvhOxhghHsz5APTXysKM/5nwn6CkBnLw/3WcrbiGLhDfecd7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvZkWawf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761082799; x=1792618799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iW/BcUJLCLLlHu2nMhEhUz1mgvhc+oR29dpeVfRwugQ=;
  b=EvZkWawfOvhZSc4kvqcfHM6ifCSaArLD98iSKjLvcdzd6a5TSczaTcrL
   WTMvtOkskOnE9k0lTkTMcI/+UYh0moIUraKtKGrcYX7YC7K0lKDCpeW0J
   kSLXwZt/fqqlpdgcH5q403NH17+KcvQfCeCvdQhRUPAzxQlY2cJ4wDl+I
   1cOPO33i5DqZ3IdF0kDabrsF4GnAUMSPq3GurfN0patut1XJjbV8PXBO4
   MeKa3Yx/928wkROmueSwL205eVplzvpcoedvuhfACiQqLWpZ7K+LXu8iZ
   CLahExdwIEFMFc5abIVMuOnrZxplgHl4wUCakbAREJqcCrK8AEshlXESF
   Q==;
X-CSE-ConnectionGUID: WOjj5WLES8Gzwcw5cO0Gjw==
X-CSE-MsgGUID: 9O4UztQCQUyEgkkDOEg22A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62923174"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="62923174"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 14:39:57 -0700
X-CSE-ConnectionGUID: 5kZ3gezoRQ2L5SMtTVCJOg==
X-CSE-MsgGUID: 7LQ0VDHOTzmkZBnZ5Rs0Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="184099255"
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
Subject: [RFC PATCH 2/3] drm/sched: Taint workqueues with reclaim
Date: Tue, 21 Oct 2025 14:39:51 -0700
Message-Id: <20251021213952.746900-3-matthew.brost@intel.com>
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

Multiple drivers seemingly do not understand the role of DMA fences in
the reclaim path. As a result, DRM scheduler workqueues, which are part
of the fence signaling path, must not allocate memory. This patch
teaches lockdep to recognize these rules in order to catch driver-side
bugs.

Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c39f0245e3a9..676484dd3ea3 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1368,6 +1368,9 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	atomic64_set(&sched->job_id_count, 0);
 	sched->pause_submit = false;
 
+	taint_reclaim_workqueue(sched->submit_wq, GFP_KERNEL);
+	taint_reclaim_workqueue(sched->timeout_wq, GFP_KERNEL);
+
 	sched->ready = true;
 	return 0;
 Out_unroll:
-- 
2.34.1


