Return-Path: <linux-kernel+bounces-583959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B413FA781F3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375AA3B0500
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55324215779;
	Tue,  1 Apr 2025 18:07:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D83121420A;
	Tue,  1 Apr 2025 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743530849; cv=none; b=bJd7HnI/AOd3LKwTFSx4mDzuM/grywqiPjAp6Abp1bTF7jEC8L/dKnslqjNXgOtfm2kRg3IWsZcDLeXwKGwun2g3mzlCme6/f0uHFMGU/liodZWfB2LFwsmnHLDrBivhbo2EIBC9U8baeZ79QBFRn8vsv1BShQ4JIMpbcrrEmsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743530849; c=relaxed/simple;
	bh=Boy1T4jiR3LJNhAva+eYE616avm04Cyr6Hz6QoAZyNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hiVEXeADRWTzKK2l/7UxxJyuazF+6vnYtO7ovRMmDbS9eJteTZepYv4kuqbMgeT9N9VNZGc/K3pI5gHZegTKwQiOp9nO8g/Gj15cnu6WLSIihvMDHgUG4kq72QtYVP0EtMnho6jxlRYMZs95Vf/1ibXf4qXjq6qsUinRTQxeNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8A7014BF;
	Tue,  1 Apr 2025 11:07:27 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE5E33F59E;
	Tue,  1 Apr 2025 11:07:22 -0700 (PDT)
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
Subject: [PATCH v4 4/7] coresight: perf: Support AUX trace pause and resume
Date: Tue,  1 Apr 2025 19:07:05 +0100
Message-Id: <20250401180708.385396-5-leo.yan@arm.com>
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

This commit supports AUX trace pause and resume in a perf session for
Arm CoreSight.

First, we need to decide which flag can indicate the CoreSight PMU event
has started.  The 'event->hw.state' cannot be used for this purpose
because its initial value and the value after hardware trace enabling
are both 0.

On the other hand, the context value 'ctxt->event_data' stores the ETM
private info.  This pointer is valid only when the PMU event has been
enabled. It is safe to permit AUX trace pause and resume operations only
when it is not a NULL pointer.

To achieve fine-grained control of the pause and resume, only the tracer
is disabled and enabled.  This avoids the unnecessary complexity and
latency caused by manipulating the entire link path.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 45 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f4cccd68e625..2dcf1809cb7f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -365,6 +365,18 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 			continue;
 		}
 
+		/*
+		 * If AUX pause feature is enabled but the ETM driver does not
+		 * support the operations, clear this CPU from the mask and
+		 * continue to next one.
+		 */
+		if (event->attr.aux_start_paused &&
+		    (!source_ops(csdev)->pause_perf || !source_ops(csdev)->resume_perf)) {
+			dev_err_once(&csdev->dev, "AUX pause is not supported.\n");
+			cpumask_clear_cpu(cpu, mask);
+			continue;
+		}
+
 		/*
 		 * No sink provided - look for a default sink for all the ETMs,
 		 * where this event can be scheduled.
@@ -450,6 +462,15 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	goto out;
 }
 
+static int etm_event_resume(struct coresight_device *csdev,
+			     struct etm_ctxt *ctxt)
+{
+	if (!ctxt->event_data)
+		return 0;
+
+	return coresight_resume_source(csdev);
+}
+
 static void etm_event_start(struct perf_event *event, int flags)
 {
 	int cpu = smp_processor_id();
@@ -463,6 +484,14 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (!csdev)
 		goto fail;
 
+	if (flags & PERF_EF_RESUME) {
+		if (etm_event_resume(csdev, ctxt) < 0) {
+			dev_err(&csdev->dev, "Failed to resume ETM event.\n");
+			goto fail;
+		}
+		return;
+	}
+
 	/* Have we messed up our tracking ? */
 	if (WARN_ON(ctxt->event_data))
 		goto fail;
@@ -545,6 +574,16 @@ static void etm_event_start(struct perf_event *event, int flags)
 	return;
 }
 
+static void etm_event_pause(struct coresight_device *csdev,
+			    struct etm_ctxt *ctxt)
+{
+	if (!ctxt->event_data)
+		return;
+
+	/* Stop tracer */
+	coresight_pause_source(csdev);
+}
+
 static void etm_event_stop(struct perf_event *event, int mode)
 {
 	int cpu = smp_processor_id();
@@ -555,6 +594,9 @@ static void etm_event_stop(struct perf_event *event, int mode)
 	struct etm_event_data *event_data;
 	struct coresight_path *path;
 
+	if (mode & PERF_EF_PAUSE)
+		return etm_event_pause(csdev, ctxt);
+
 	/*
 	 * If we still have access to the event_data via handle,
 	 * confirm that we haven't messed up the tracking.
@@ -899,7 +941,8 @@ int __init etm_perf_init(void)
 	int ret;
 
 	etm_pmu.capabilities		= (PERF_PMU_CAP_EXCLUSIVE |
-					   PERF_PMU_CAP_ITRACE);
+					   PERF_PMU_CAP_ITRACE |
+					   PERF_PMU_CAP_AUX_PAUSE);
 
 	etm_pmu.attr_groups		= etm_pmu_attr_groups;
 	etm_pmu.task_ctx_nr		= perf_sw_context;
-- 
2.34.1


