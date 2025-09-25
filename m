Return-Path: <linux-kernel+bounces-833186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F780BA15EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0869176420
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998F531FED1;
	Thu, 25 Sep 2025 20:36:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB331C580;
	Thu, 25 Sep 2025 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832592; cv=none; b=ZdCjHCINUG2AoqKp8ObL3eF1/RUsTE5dTpYPLc/36dVZ90leqzwFiEZxC84/YQV8bj+tC9KZais511VZWfVPtH6vsuEBGDmgTVDkdaLJtC18GFU/y/GgWnfyxtk0k5HnHSkAhqCkhoNIgF80rZvFvNnVqyoSyXt1STHDtJuGIw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832592; c=relaxed/simple;
	bh=OQzMdWF0UYZfLJJtt+kIRQouIWv1ByDrqDFdpmYd8xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gf57ky3MeDonL1kd6diXZkaZR6DZI5BencgMAuycI4KP+UTbEovoRdsvg8n7/3w6umYLFsc8xXcGltgwxS4xOs2HE4VEtandW9hI4S+DqcjHn4QMijDhwio7fBW4a+BtsIcKjMYictq0RfjoRnZGTKUJkoY1Y+1S9GSWdiyMGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 978F81692;
	Thu, 25 Sep 2025 13:36:21 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C9C63F694;
	Thu, 25 Sep 2025 13:36:26 -0700 (PDT)
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
Subject: [PATCH 03/10] firmware: arm_scmi: Allow protocols to register for notifications
Date: Thu, 25 Sep 2025 21:35:47 +0100
Message-ID: <20250925203554.482371-4-cristian.marussi@arm.com>
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

Allow protocols themselves to register for their own notifications and
providing their own notifier callbacks. While at that, allow for a protocol
to register events with compilation-time unknown report/event sizes: such
events will use the maximum transport size.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h    |  4 ++++
 drivers/firmware/arm_scmi/driver.c    | 12 ++++++++++++
 drivers/firmware/arm_scmi/notify.c    | 27 ++++++++++++++++++++-------
 drivers/firmware/arm_scmi/notify.h    |  8 ++++++--
 drivers/firmware/arm_scmi/protocols.h |  8 ++++++++
 5 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 07b9e629276d..2392ca98bc3e 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -17,6 +17,7 @@
 #include <linux/hashtable.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/refcount.h>
 #include <linux/scmi_protocol.h>
 #include <linux/spinlock.h>
@@ -505,5 +506,8 @@ static struct platform_driver __drv = {					       \
 void scmi_notification_instance_data_set(const struct scmi_handle *handle,
 					 void *priv);
 void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
+int scmi_notifier_register(const struct scmi_handle *handle, u8 proto_id,
+			   u8 evt_id, const u32 *src_id,
+			   struct notifier_block *nb);
 int scmi_inflight_count(const struct scmi_handle *handle);
 #endif /* _SCMI_COMMON_H */
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 71ee25b78624..8f969d8b86a6 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1674,6 +1674,17 @@ static void *scmi_get_protocol_priv(const struct scmi_protocol_handle *ph)
 	return pi->priv;
 }
 
+static int
+scmi_register_instance_notifier(const struct scmi_protocol_handle *ph,
+				u8 evt_id, const u32 *src_id,
+				struct notifier_block *nb)
+{
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+
+	return scmi_notifier_register(pi->handle, pi->proto->id,
+				      evt_id, src_id, nb);
+}
+
 static const struct scmi_xfer_ops xfer_ops = {
 	.version_get = version_get,
 	.xfer_get_init = xfer_get_init,
@@ -2174,6 +2185,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	pi->ph.hops = &helpers_ops;
 	pi->ph.set_priv = scmi_set_protocol_priv;
 	pi->ph.get_priv = scmi_get_protocol_priv;
+	pi->ph.notifier_register = scmi_register_instance_notifier;
 	refcount_set(&pi->users, 1);
 	/* proto->init is assured NON NULL by scmi_protocol_register */
 	ret = pi->proto->instance_init(&pi->ph);
diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 78e9e27dc9ec..3e623c14745d 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -593,7 +593,12 @@ int scmi_notify(const struct scmi_handle *handle, u8 proto_id, u8 evt_id,
 	if (!r_evt)
 		return -EINVAL;
 
-	if (len > r_evt->evt->max_payld_sz) {
+	/* Events with a zero max_payld_sz are sized to be of the maximum
+	 * size allowed by the transport: no need to be size-checked here
+	 * since the transport layer would have already dropped such
+	 * over-sized messages.
+	 */
+	if (r_evt->evt->max_payld_sz && len > r_evt->evt->max_payld_sz) {
 		dev_err(handle->dev, "discard badly sized message\n");
 		return -EINVAL;
 	}
@@ -752,7 +757,7 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 				  const struct scmi_protocol_handle *ph,
 				  const struct scmi_protocol_events *ee)
 {
-	int i;
+	int i, max_msg_sz;
 	unsigned int num_sources;
 	size_t payld_sz = 0;
 	struct scmi_registered_events_desc *pd;
@@ -767,6 +772,8 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 	if (!ni)
 		return -ENOMEM;
 
+	max_msg_sz = ph->hops->get_max_msg_size(ph);
+
 	/* num_sources cannot be <= 0 */
 	if (ee->num_sources) {
 		num_sources = ee->num_sources;
@@ -779,8 +786,13 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 	}
 
 	evt = ee->evts;
-	for (i = 0; i < ee->num_events; i++)
+	for (i = 0; i < ee->num_events; i++) {
+		if (evt[i].max_payld_sz == 0) {
+			payld_sz = max_msg_sz;
+			break;
+		}
 		payld_sz = max_t(size_t, payld_sz, evt[i].max_payld_sz);
+	}
 	payld_sz += sizeof(struct scmi_event_header);
 
 	pd = scmi_allocate_registered_events_desc(ni, proto_id, ee->queue_sz,
@@ -809,7 +821,8 @@ int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 		mutex_init(&r_evt->sources_mtx);
 
 		r_evt->report = devm_kzalloc(ni->handle->dev,
-					     evt->max_report_sz, GFP_KERNEL);
+					     evt->max_report_sz ?: max_msg_sz,
+					     GFP_KERNEL);
 		if (!r_evt->report)
 			return -ENOMEM;
 
@@ -1373,9 +1386,9 @@ static int scmi_event_handler_enable_events(struct scmi_event_handler *hndl)
  *
  * Return: 0 on Success
  */
-static int scmi_notifier_register(const struct scmi_handle *handle,
-				  u8 proto_id, u8 evt_id, const u32 *src_id,
-				  struct notifier_block *nb)
+int scmi_notifier_register(const struct scmi_handle *handle,
+			   u8 proto_id, u8 evt_id, const u32 *src_id,
+			   struct notifier_block *nb)
 {
 	int ret = 0;
 	u32 evt_key;
diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
index 76758a736cf4..ecfa4b746487 100644
--- a/drivers/firmware/arm_scmi/notify.h
+++ b/drivers/firmware/arm_scmi/notify.h
@@ -18,8 +18,12 @@
 /**
  * struct scmi_event  - Describes an event to be supported
  * @id: Event ID
- * @max_payld_sz: Max possible size for the payload of a notification message
- * @max_report_sz: Max possible size for the report of a notification message
+ * @max_payld_sz: Max possible size for the payload of a notification message.
+ *		  Set to zero to use the maximum payload size allowed by the
+ *		  transport.
+ * @max_report_sz: Max possible size for the report of a notification message.
+ *		  Set to zero to use the maximum payload size allowed by the
+ *		  transport.
  *
  * Each SCMI protocol, during its initialization phase, can describe the events
  * it wishes to support in a few struct scmi_event and pass them to the core
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index d62c4469d1fd..2e40a7bb5b01 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -161,8 +161,13 @@ struct scmi_proto_helpers_ops;
  * @dev: A reference to the associated SCMI instance device (handle->dev).
  * @xops: A reference to a struct holding refs to the core xfer operations that
  *	  can be used by the protocol implementation to generate SCMI messages.
+ * @hops: A reference to a struct holding refs to the common helper operations
+ *	  that can be used by the protocol implementation.
  * @set_priv: A method to set protocol private data for this instance.
  * @get_priv: A method to get protocol private data previously set.
+ * @notifier_register: A method to register interest for notifications from
+ *		       within a protocol implementation unit: notifiers can
+ *		       be registered only for the same protocol.
  *
  * This structure represents a protocol initialized against specific SCMI
  * instance and it will be used as follows:
@@ -182,6 +187,9 @@ struct scmi_protocol_handle {
 	int (*set_priv)(const struct scmi_protocol_handle *ph, void *priv,
 			u32 version);
 	void *(*get_priv)(const struct scmi_protocol_handle *ph);
+	int (*notifier_register)(const struct scmi_protocol_handle *ph,
+				 u8 evt_id, const u32 *src_id,
+				 struct notifier_block *nb);
 };
 
 /**
-- 
2.51.0


