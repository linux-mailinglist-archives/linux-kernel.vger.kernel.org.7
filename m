Return-Path: <linux-kernel+bounces-583957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F65A781ED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D793AF299
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836B22147E0;
	Tue,  1 Apr 2025 18:07:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC49211299;
	Tue,  1 Apr 2025 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743530845; cv=none; b=g6+H1Wn6r83a9SkfbonlB6U4Zwbe6aYDzFso+LDK8I+SbhPPW2gWykKIhjpiD5He8rn+UPywoFSOioPfdmLQJzHy1ecjgGHZ12LgSHBAFEJJV2ZMioOtfQBjn62/k4EIYDetf+tKGSAAvBzkj3MhIIAIOiJ9JJeF9eGq1Mo6Taw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743530845; c=relaxed/simple;
	bh=fBYgxHtV2usJg59JLQg6x0XcYL/TYuICXQshUMBh6i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a1naPL7wbIFB/egCkyflvL6xxmibSCKNFGgpybQYcYChDKMRySjxb4iOju+DipLQQrEU1HI78ppuV3ZqfcwyqJonqZ6Rrli5MrYLCxQXWFuAWPJcI+sTNp0o+vTP5AVw/RzRADb0inrgfNhX/KVXac3un7610qrs5q/TIb3tZHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE32312FC;
	Tue,  1 Apr 2025 11:07:25 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FE1E3F59E;
	Tue,  1 Apr 2025 11:07:21 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 3/7] coresight: etm4x: Hook pause and resume callbacks
Date: Tue,  1 Apr 2025 19:07:04 +0100
Message-Id: <20250401180708.385396-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401180708.385396-1-leo.yan@arm.com>
References: <20250401180708.385396-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add callbacks for pausing and resuming the tracer.

A "paused" flag in the driver data indicates whether the tracer is
paused.  If the flag is set, the driver will skip starting the hardware
trace.  The flag is always set to false for the sysfs mode, meaning the
tracer will never be paused in the case.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-etm4x.h      |  2 ++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 53cb0569dbbf..5b69446db947 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -577,7 +577,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, trcpdcr | TRCPDCR_PU, TRCPDCR);
 	}
 
-	rc = etm4_enable_trace_unit(drvdata);
+	if (!drvdata->paused)
+		rc = etm4_enable_trace_unit(drvdata);
 done:
 	etm4_cs_lock(drvdata, csa);
 
@@ -820,6 +821,9 @@ static int etm4_enable_perf(struct coresight_device *csdev,
 
 	drvdata->trcid = path->trace_id;
 
+	/* Populate pause state */
+	drvdata->paused = !!READ_ONCE(event->hw.aux_paused);
+
 	/* And enable it */
 	ret = etm4_enable_hw(drvdata);
 
@@ -846,6 +850,9 @@ static int etm4_enable_sysfs(struct coresight_device *csdev, struct coresight_pa
 
 	drvdata->trcid = path->trace_id;
 
+	/* Tracer will never be paused in sysfs mode */
+	drvdata->paused = false;
+
 	/*
 	 * Executing etm4_enable_hw on the cpu whose ETM is being enabled
 	 * ensures that register writes occur when cpu is powered.
@@ -1080,10 +1087,43 @@ static void etm4_disable(struct coresight_device *csdev,
 		coresight_set_mode(csdev, CS_MODE_DISABLED);
 }
 
+static int etm4_resume_perf(struct coresight_device *csdev)
+{
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct csdev_access *csa = &csdev->access;
+
+	if (coresight_get_mode(csdev) != CS_MODE_PERF)
+		return -EINVAL;
+
+	etm4_cs_unlock(drvdata, csa);
+	etm4_enable_trace_unit(drvdata);
+	etm4_cs_lock(drvdata, csa);
+
+	drvdata->paused = false;
+	return 0;
+}
+
+static void etm4_pause_perf(struct coresight_device *csdev)
+{
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct csdev_access *csa = &csdev->access;
+
+	if (coresight_get_mode(csdev) != CS_MODE_PERF)
+		return;
+
+	etm4_cs_unlock(drvdata, csa);
+	etm4_disable_trace_unit(drvdata);
+	etm4_cs_lock(drvdata, csa);
+
+	drvdata->paused = true;
+}
+
 static const struct coresight_ops_source etm4_source_ops = {
 	.cpu_id		= etm4_cpu_id,
 	.enable		= etm4_enable,
 	.disable	= etm4_disable,
+	.resume_perf	= etm4_resume_perf,
+	.pause_perf	= etm4_pause_perf,
 };
 
 static const struct coresight_ops etm4_cs_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index bd7db36ba197..ac649515054d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -983,6 +983,7 @@ struct etmv4_save_state {
  * @state_needs_restore: True when there is context to restore after PM exit
  * @skip_power_up: Indicates if an implementation can skip powering up
  *		   the trace unit.
+ * @paused:	Indicates if the trace unit is paused.
  * @arch_features: Bitmap of arch features of etmv4 devices.
  */
 struct etmv4_drvdata {
@@ -1036,6 +1037,7 @@ struct etmv4_drvdata {
 	struct etmv4_save_state		*save_state;
 	bool				state_needs_restore;
 	bool				skip_power_up;
+	bool				paused;
 	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
 };
 
-- 
2.34.1


