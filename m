Return-Path: <linux-kernel+bounces-586261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6F5A79D12
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 09:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1513B0458
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 07:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F73C24113D;
	Thu,  3 Apr 2025 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Cv5XRfCt"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE43241139
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665763; cv=none; b=OMNryJNy1GxpG/cER9WAoSps9M6F3fzh2wOL+igUORAk9Z6938DAebV9ZEXTpDsnxnnKdWPsMh/U+4WX7ZqY2zdF6nr9zFiaTp01wGGSM0v2u0yhKqzvwRop4epjWKSCJB8pFpv+dQkk6TxQEqtG/UWDYvKtvNTCdN7tEF6CdPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665763; c=relaxed/simple;
	bh=ltWoWX7Mu7x+lPl36hL447GpCEWPhHjZVYkHkR2L6vs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NHEpvYiRf8f9L6KR90xR+vTsJpDGYi4DrNfsM3uMlPuaJQajV7Z9GgnxRnasA9+O/NDFIwPsM1ZoJJ2kA71luCqOmDehl3V7OKnCuX17JfTdz9PSS6C0HEgjsplPwnhZHt9r7ht6gjvi5repCiKqqqArbxcNWleBHfWLkXK1i04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Cv5XRfCt; arc=none smtp.client-ip=43.163.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743665753; bh=CQjxyMm42s533cft5gR6e75CqVkywADkjZjFWbmTt8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cv5XRfCtCtSLU4xMnj6iAeGaMCTBbdZmc4bg5iBX51SiSi1zH7axO69CPHze3zy/g
	 CgDY1itlyd5gJB6fhMJChdV1jgPUH0sopDpQ/VxlrJfOFeYDVNkrVYWkcOtXx2vqrq
	 E3PJ36BdYW8wGjkGTShhls76Sv+br6Vittu+fJhw=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 59A3AEE8; Thu, 03 Apr 2025 15:22:26 +0800
X-QQ-mid: xmsmtpt1743664946t87kxi3vy
Message-ID: <tencent_E1DB827652FCCE94848F4109798FC8E5780A@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgKlJdiKWyCWh3m7Uj1elCf2fIuSzZhap9yIAAAEvhMbuMC+TC8Q
	 BFl3AOybv+wVMAk1baX/4zID/N9jA1gUnMKh32v7hgpuySrY8UVVEhH8ZuILPIjh5vXFHkdg2Xkm
	 eh12quqSoKwb05nRx7gtSun9Cnp229yPoq6ACvdm0BhUBT4kxkv9CDmIPtAA2NMVuKO9Rac8TBDy
	 V8iHibelb0QWTetIxXu7TFJN9aF5ZpwlW0odh334+iFLtL7sgzlZflEw7Wkd42SUOeIwrGb2Q2dN
	 9CSTcZZDngyB6Qic21PNRm6AyGg2tXjC73hpennEhYFyYdZ1h+jvAKYJ9Xs7IQjOmZryQ0fgMo8E
	 btpra4Uk0s9kdkgloSS0CkyBUVK03Mx5Ff4ngcuBp/9NUDMt+CwGOZMSKIfz/h5qaWdUDQjsricO
	 A0Hx32jhYjnGkZZUb8+JH60Rs14uPGUsA6KLwfKJY3nLI8kzxGjkk6Su8VYBoqdELF4yJfGBwyFR
	 Xe0zzl6j2q7z/vnT6eshP4gxinQ5GGwVNzNtW/oJPpccsg4P89IRSp02nsvXY/BLkRohuiI5+K+X
	 aOEK7Xo6JZvdvEO32K8ulBOjLzdVaBfsBYxU6sXbpCCmfoCOOJBlGYv2GXQxntBl0nS83CJkc9Jb
	 LASx24Kwx1ZxQxTxMhdaM2eI7zzghIR0aqpA1fMv7fr6t6oPi+lCSW1vBnHEbgmHYxkRNyh0PSyv
	 3G1iNnPrmsuROZAvAjIoV2tiwDm43RgDuuYcxGdrzUYeGZMzHUTKghR123EIZr+UcdI91QlBpJSx
	 0n55wJvEbtidd3VybjETiCEXlfCO3DSFBIQq/Y8npob+uWpJWgv8xw0I+CLFGFZx0GfSt1zrUwz7
	 JJ8C3KSCBvw3PTN6auttkmKfCGz4H62z49sxp0wwrBfDLjssNjj4A8kZfB1eUcPPUXtGUluI0k2u
	 RXpMwUu9U4+wT8i8Q+4K9MxhVbAN0ayjC6UYJimWmVLnh0i5GwnoFabpTCoLESTrmt9vw2hE0KGF
	 6OLdQshA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v4 3/3] nvme: add per-controller sysfs interface for APST configuration
Date: Thu,  3 Apr 2025 15:22:25 +0800
X-OQ-MSGID: <20250403072225.1209213-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_A9D89C90E6484E0EBFED4F67D6EF4589F506@qq.com>
References: <tencent_A9D89C90E6484E0EBFED4F67D6EF4589F506@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

Currently, APST (Autonomous Power State Transition) parameters are
configured as module parameters affecting all controllers uniformly,
 This lacks flexibility for heterogeneous systems.

This patch introduces per-controller sysfs attributes under each NVMe
controller's sysfs directory:
- apst_primary_timeout_ms
- apst_secondary_timeout_ms
- apst_primary_latency_tol_us
- apst_secondary_latency_tol_us

The attributes allow runtime configuration of: Timeout values for
primary/secondary states.

The existing module parameters are retained for backward compatibility
but now only serve as default values for new controllers.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/nvme/host/core.c  | 16 ++++++++++------
 drivers/nvme/host/nvme.h  |  4 ++++
 drivers/nvme/host/sysfs.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 19438da102e5..f6ef73ed88e6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2608,22 +2608,22 @@ static int nvme_configure_host_options(struct nvme_ctrl *ctrl)
  * timeout value is returned and the matching tolerance index (1 or 2) is
  * reported.
  */
-static bool nvme_apst_get_transition_time(u64 total_latency,
+static bool nvme_apst_get_transition_time(struct nvme_ctrl *ctrl, u64 total_latency,
 		u64 *transition_time, unsigned *last_index)
 {
-	if (total_latency <= apst_primary_latency_tol_us) {
+	if (total_latency <= ctrl->apst_primary_latency_tol_us) {
 		if (*last_index == 1)
 			return false;
 		*last_index = 1;
-		*transition_time = apst_primary_timeout_ms;
+		*transition_time = ctrl->apst_primary_timeout_ms;
 		return true;
 	}
 	if (apst_secondary_timeout_ms &&
-		total_latency <= apst_secondary_latency_tol_us) {
+		total_latency <= ctrl->apst_secondary_latency_tol_us) {
 		if (*last_index <= 2)
 			return false;
 		*last_index = 2;
-		*transition_time = apst_secondary_timeout_ms;
+		*transition_time = ctrl->apst_secondary_timeout_ms;
 		return true;
 	}
 	return false;
@@ -2729,7 +2729,7 @@ int nvme_configure_apst(struct nvme_ctrl *ctrl)
 		 * for higher power states.
 		 */
 		if (apst_primary_timeout_ms && apst_primary_latency_tol_us) {
-			if (!nvme_apst_get_transition_time(total_latency_us,
+			if (!nvme_apst_get_transition_time(ctrl, total_latency_us,
 					&transition_ms, &last_lt_index))
 				continue;
 		} else {
@@ -4857,6 +4857,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->ka_last_check_time = jiffies;
 
 	mutex_init(&ctrl->apst_lock);
+	ctrl->apst_primary_timeout_ms = apst_primary_timeout_ms;
+	ctrl->apst_secondary_timeout_ms = apst_secondary_timeout_ms;
+	ctrl->apst_primary_latency_tol_us = apst_primary_latency_tol_us;
+	ctrl->apst_secondary_latency_tol_us = apst_secondary_latency_tol_us;
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7f8e10f5bf7a..ed9afc3c6781 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -387,6 +387,10 @@ struct nvme_ctrl {
 	/* Power saving configuration */
 	struct mutex apst_lock;
 	u64 ps_max_latency_us;
+	u64 apst_primary_timeout_ms;
+	u64 apst_secondary_timeout_ms;
+	u64 apst_primary_latency_tol_us;
+	u64 apst_secondary_latency_tol_us;
 	bool apst_enabled;
 
 	/* PCIe only: */
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 20146eb4c671..77912e95aff8 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -684,6 +684,39 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
 #endif
 
+#define nvme_apst_show_and_store_function(field)				\
+static ssize_t field##_show(struct device *dev,		\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
+\
+	return sysfs_emit(buf, "%llu\n", ctrl->field);	\
+}									\
+									\
+static ssize_t field##_store(struct device *dev,		\
+			     struct device_attribute *attr,		\
+			     const char *buf, size_t size)		\
+{									\
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
+	u64 data = 0;					\
+	int err;						\
+\
+	err = kstrtou64(buf, 0, &data);		\
+	if (err < 0)						\
+		return err;						\
+							\
+	mutex_lock(&ctrl->apst_lock);		\
+	ctrl->field = data; 	\
+	mutex_unlock(&ctrl->apst_lock);		\
+	return size;			\
+}									\
+static DEVICE_ATTR_RW(field);
+
+nvme_apst_show_and_store_function(apst_primary_timeout_ms);
+nvme_apst_show_and_store_function(apst_secondary_timeout_ms);
+nvme_apst_show_and_store_function(apst_primary_latency_tol_us);
+nvme_apst_show_and_store_function(apst_secondary_latency_tol_us);
+
 static ssize_t apst_update_store(struct device *dev,
 					      struct device_attribute *attr,
 					      const char *buf, size_t size)
@@ -735,6 +768,11 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+
+	&dev_attr_apst_primary_timeout_ms.attr,
+	&dev_attr_apst_secondary_timeout_ms.attr,
+	&dev_attr_apst_primary_latency_tol_us.attr,
+	&dev_attr_apst_secondary_latency_tol_us.attr,
 	&dev_attr_apst_update.attr,
 	NULL
 };
-- 
2.25.1


