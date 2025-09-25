Return-Path: <linux-kernel+bounces-833185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB37BA15EB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389A816EA25
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBA331E885;
	Thu, 25 Sep 2025 20:36:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E59D303C87;
	Thu, 25 Sep 2025 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832589; cv=none; b=Xiwvojz2NUUAd0bxS2l6K3J9mRtwQ0s8Cqe0D2HTdO2y0931VuDaBlW4jSLd0H4jkKIH+s6U1HJoVX3pkXpAZQJvUFznc0/6182ABdsSCodkYyjlVBl46IViQWaJ9HoBc1aWEjC2dvbLSDc8mNZMANXuLCymGn9NpwqCUuhTZ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832589; c=relaxed/simple;
	bh=bUuDv9Cj31qwosKQlIYpDeI5XqkB/KdNSJdev/qZzu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVvslTmD07xFZC6pvk1R8OaJDVxRYFpuAyLoNSgMapeEXmUqd7wqEAAj9APOHxXUq/C3DOipreEAzuWQGKY3xptIxFtERiT3Agk53zvIA6f1OoNCvNZF8/L6Om30TA6tPG8kIjuhn//p3LT2Lepj0Q36QDShczGSCm5DwGntfvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A72041692;
	Thu, 25 Sep 2025 13:36:18 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 094F33F694;
	Thu, 25 Sep 2025 13:36:23 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 02/10] firmware: arm_scmi: Reduce the scope of protocols mutex
Date: Thu, 25 Sep 2025 21:35:46 +0100
Message-ID: <20250925203554.482371-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925203554.482371-1-cristian.marussi@arm.com>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the mutex dedicated to the protection of the list of registered
protocols is held during all the protocol initialization phase.

Such a wide locking region is not needed and causes problem when trying to
initialize notifications from within a protocol initialization routine.

Reduce the scope of the protocol mutex.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 53 +++++++++++++++---------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index bd56a877fdfc..71ee25b78624 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -17,6 +17,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitmap.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/export.h>
@@ -2179,10 +2180,13 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	if (ret)
 		goto clean;
 
-	ret = idr_alloc(&info->protocols, pi, proto->id, proto->id + 1,
-			GFP_KERNEL);
-	if (ret != proto->id)
-		goto clean;
+	/* Finally register the initialized protocol */
+	scoped_guard(mutex, &info->protocols_mtx) {
+		ret = idr_alloc(&info->protocols, pi, proto->id, proto->id + 1,
+				GFP_KERNEL);
+		if (ret != proto->id)
+			goto clean;
+	}
 
 	/*
 	 * Warn but ignore events registration errors since we do not want
@@ -2243,25 +2247,22 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 static struct scmi_protocol_instance * __must_check
 scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 {
-	struct scmi_protocol_instance *pi;
+	struct scmi_protocol_instance *pi = ERR_PTR(-EPROBE_DEFER);
 	struct scmi_info *info = handle_to_scmi_info(handle);
+	const struct scmi_protocol *proto;
 
-	mutex_lock(&info->protocols_mtx);
-	pi = idr_find(&info->protocols, protocol_id);
-
-	if (pi) {
-		refcount_inc(&pi->users);
-	} else {
-		const struct scmi_protocol *proto;
-
-		/* Fails if protocol not registered on bus */
-		proto = scmi_protocol_get(protocol_id, &info->version);
-		if (proto)
-			pi = scmi_alloc_init_protocol_instance(info, proto);
-		else
-			pi = ERR_PTR(-EPROBE_DEFER);
+	scoped_guard(mutex, &info->protocols_mtx) {
+		pi = idr_find(&info->protocols, protocol_id);
+		if (pi) {
+			refcount_inc(&pi->users);
+			return pi;
+		}
 	}
-	mutex_unlock(&info->protocols_mtx);
+
+	/* Fails if protocol not registered on bus */
+	proto = scmi_protocol_get(protocol_id, &info->version);
+	if (proto)
+		pi = scmi_alloc_init_protocol_instance(info, proto);
 
 	return pi;
 }
@@ -2294,10 +2295,11 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
 	struct scmi_info *info = handle_to_scmi_info(handle);
 	struct scmi_protocol_instance *pi;
 
-	mutex_lock(&info->protocols_mtx);
-	pi = idr_find(&info->protocols, protocol_id);
-	if (WARN_ON(!pi))
-		goto out;
+	scoped_guard(mutex, &info->protocols_mtx) {
+		pi = idr_find(&info->protocols, protocol_id);
+		if (WARN_ON(!pi))
+			return;
+	}
 
 	if (refcount_dec_and_test(&pi->users)) {
 		void *gid = pi->gid;
@@ -2316,9 +2318,6 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
 		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
 			protocol_id);
 	}
-
-out:
-	mutex_unlock(&info->protocols_mtx);
 }
 
 void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
-- 
2.51.0


