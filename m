Return-Path: <linux-kernel+bounces-583197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC77A777D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 11:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8D8188C8F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D377A1EFF94;
	Tue,  1 Apr 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WgDz5MMh"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18D61624D5
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500017; cv=none; b=gf61OMzkYXcLKv8Bm/UGJCyRecPBdEo1eanP1qdCje9H6G6oRC68Nat+72RspiP3bn1QfmCo3pk0z3+GCgLJ2luS7VjeV5d1QsqQf54CrqF0GVZ7PNAR1nXbo+IZyb+hCNT7RRb3NB9XXJjpKooJY9PXdPr/LzIBwfwl+bOajJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500017; c=relaxed/simple;
	bh=tjvcp4POZcgFYSJi6w8QFtqD88zOShmsfmbQ949KIF8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=koZrroD8qzJBqBASaeDEVVWM+VRl4UgZwT9rHaFwaLaZnkwvC3V0uOi1XgL3qqmsHsCC35196Rx7QxP1UPgi+zetrnPi9ffk41ITSGJDcnzbKWMoFwz2QJLgpZPb1mmlRuvOBWEAwChZI3d+MTPxx/EGvybsRE4RIWuFgkAE708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WgDz5MMh; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743500009; bh=QEYVKhECladfxjqyKQSzAOMcOlFrMVaRY3xj2wEcNhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WgDz5MMh82Mv7X5fG5PXPmMymuq738j7zT05yyU3Q0U0HlPM7sC+7ARNW23OyAo41
	 U4IR08PRABBpyt3zWv3mIcphzzzpxMq70BYdCc77WP1wCswVejKJdhaEOsRSb5Mu0s
	 K4h2vl4onzbKs9JqRmgzaXGYwXoobZrXXfNY86Pg=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 6CC3BEF9; Tue, 01 Apr 2025 17:27:12 +0800
X-QQ-mid: xmsmtpt1743499632trvvhpf3l
Message-ID: <tencent_1B8B23E13980B65C9D11BFCA253F636E4208@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjdaSckX8XONgCXT6acTC9p1TuZ1I/AgH3J44VKB3DA3dBdicJwN
	 kQ85NILCbkJYqYK0PCkm4ZvBhPmC/qLjQzwC+IzjvlVB8NvEJvGvC3YTBjrsLBo4WzyXjdlDkG9x
	 y2rpuMiVchYqXoFbdGHxJ4rFFLgjXU2dwvDZB2nekpdAB0RbnUjG9GyPR7qyqZdc51LZFJJ3H3b8
	 dikSdMpBg7EqlWIrWm944DaUm0xZkepk8DVM3z8Ce7Dg8JjwbWeeT/pLoVmERU20/RSGhwQW5ku0
	 xkIlr2XmsDchUAEV5neyV9UfiBw3+gQ1AuxN+DlQeL/tcaOBVpzJM183o5BpWsxAzJYTEGpG+h5v
	 8bfLXjOLxf7OMyBExbPeBLTeuKodnTQ+NizdT8e8+OveCppjV48/x2SzJrokbbjAWfs1Epw0N6mr
	 1psVfY4Y0qTrUDN9w6RHqun1NRIMFOjKAtdDHYhG40N95+ABgLOzjiPQkamGpgYzrIs27/E005bd
	 BULjDzER0Kse/ECavuZu5jYEDOBaNmjXxznatcq1dskBe/l/mLXdmARcDZOPORQw+OsiizpHdddw
	 j46w9IS3aREPyqn0wpleff62nkIH2yvc7NjSqKk2ROfwsXDeKQhzYWhfIIyFeSsjtmhHsddLZZhw
	 FWaD0NBt18zZGYl+S9bwCN17jPcR6IcZoq8G8ZMWaRA/0TP+eJCSk0flyZNXRdRCSUBUy2FwrMPQ
	 +neerZmSojOxUg43/u+zXwWUZZQfxAX4/pKdi+nw/WyDChPyr6A22IHmiYuV5h1rSmBmwDky/9wm
	 f6Q/7LHj0YKRs64tBCHXU7sF4BZvj3GbcAqwc36Wu8kYkDg3UU2BW0mn8fwCXAicK9UvcFzbBWK1
	 Adhya+wM3cwMcjq7GhPn5uqnjtGPEDZfRQbaQiN9oqbA0/LSra5XJ16aUW1kmW6ub9kH56BdgEss
	 mfYnucMO8ZfC2PRvwSTOYfmE8wNNA2+haXPdFfDhQ=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v3 3/3] nvme: add per-controller sysfs interface for APST configuration
Date: Tue,  1 Apr 2025 17:27:11 +0800
X-OQ-MSGID: <20250401092711.1558779-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com>
References: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com>
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

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/nvme/host/core.c  | 16 ++++++++++------
 drivers/nvme/host/nvme.h  |  4 ++++
 drivers/nvme/host/sysfs.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9dea1046b8b4..c999bd905d10 100644
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
@@ -2728,7 +2728,7 @@ int nvme_configure_apst(struct nvme_ctrl *ctrl)
 		 * for higher power states.
 		 */
 		if (apst_primary_timeout_ms && apst_primary_latency_tol_us) {
-			if (!nvme_apst_get_transition_time(total_latency_us,
+			if (!nvme_apst_get_transition_time(ctrl, total_latency_us,
 					&transition_ms, &last_lt_index))
 				continue;
 		} else {
@@ -4856,6 +4856,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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



