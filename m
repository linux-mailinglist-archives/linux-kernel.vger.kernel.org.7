Return-Path: <linux-kernel+bounces-818025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF25B58BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C237AFCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1512222AA;
	Tue, 16 Sep 2025 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fugi7cRn"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23331D63CD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988648; cv=none; b=J4B2EmnpLv6ZEIqy0MfqRqQIQRhPoRFwC5kVLFoZzoL3RItWtPfNhOgdRCEE/q66an+tCzbW8ign905Gtdmu+HGz5dAV9PcO6MJyb/JmegqDJpYZ6M8Agfjjm/gZf4vWO0p3YzJaeZB4kQ01l30CQFhFhHLAeA3TpiExlgnjt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988648; c=relaxed/simple;
	bh=2OQhBrSRArJQ1Ru2x8IxYne5QF4vrSh8Ef8nzC+tceM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mexIVVoDMuGxKU+cgnlzJNMuzlCHd7EOWLW4/LJFhW61np7yjo18hx1elrkKLU/1C/cs8rdp2zXwPlckA9I6r1tFsFtGeI85Qw3YeRvf+SiAAJdydnWjdXY0tY80xWT0haDYepKlgIl/gn+GX0bf47aCK7sUpRZ4Hab8bwTajsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fugi7cRn; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757988642; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ace3VQl9Qd7WAPxbz6HMw52CfIbRMCyc/gIuBLwG5oU=;
	b=Fugi7cRng6knv2/1IaGkMwivKgGcXVfwvPVkp6Anzd9NKHggKKOfp9i+e3zm9hUSRPolaH5FMzv82pdXSSSpwXdO7jSQebedu9L5AY6RvDSdvVrM2/e0AxYw/97YGU4IbnJ8/QJj4rRkyQ5de/mBNgE6s//WfL0eSltU8GuLNu8=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Wo6baSE_1757988641 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Sep 2025 10:10:41 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] drm/xe: Remove duplicate header files
Date: Tue, 16 Sep 2025 10:10:39 +0800
Message-ID: <20250916021039.1632766-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./drivers/gpu/drm/xe/xe_tlb_inval.c: xe_tlb_inval.h is included more than once.
./drivers/gpu/drm/xe/xe_pt.c: xe_tlb_inval_job.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=24705
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=24706
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/xe/xe_pt.c        | 3 +--
 drivers/gpu/drm/xe/xe_tlb_inval.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 01eea8eb1779..a1c88f9a6c76 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -13,14 +13,13 @@
 #include "xe_drm_client.h"
 #include "xe_exec_queue.h"
 #include "xe_gt.h"
-#include "xe_tlb_inval_job.h"
 #include "xe_migrate.h"
 #include "xe_pt_types.h"
 #include "xe_pt_walk.h"
 #include "xe_res_cursor.h"
 #include "xe_sched_job.h"
-#include "xe_sync.h"
 #include "xe_svm.h"
+#include "xe_sync.h"
 #include "xe_tlb_inval_job.h"
 #include "xe_trace.h"
 #include "xe_ttm_stolen_mgr.h"
diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
index e6e97b5a7b5c..918a59e686ea 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
@@ -10,11 +10,10 @@
 #include "xe_force_wake.h"
 #include "xe_gt.h"
 #include "xe_gt_printk.h"
+#include "xe_gt_stats.h"
 #include "xe_guc.h"
 #include "xe_guc_ct.h"
 #include "xe_guc_tlb_inval.h"
-#include "xe_gt_stats.h"
-#include "xe_tlb_inval.h"
 #include "xe_mmio.h"
 #include "xe_pm.h"
 #include "xe_tlb_inval.h"
-- 
2.43.7


