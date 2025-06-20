Return-Path: <linux-kernel+bounces-696148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF49EAE22D3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 21:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4666A2B02
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 19:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755642236E5;
	Fri, 20 Jun 2025 19:29:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97A32222BF;
	Fri, 20 Jun 2025 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750447747; cv=none; b=nPGPIIVPu29wzdUgBMwzNWsn94Mvr5dR9D0XSzusc7TVAOrTglMKtFSZrc8T2JK2afId6KC/mCzV1FvqK6+0Vjm5HAUkPtejvVxoUCErQm9lx2MR/XMOj39K+pdrbFB4EPFsUXHKxwWs2niAzgI0rQ7/59yVoe3JJ+fTxKPnO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750447747; c=relaxed/simple;
	bh=iTMfpekzIVBGCyX8l8yyJGOKcthl0keNPwE36XLa33w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paDS1CS4HOntQk9kKggeVwfFtyjtZZIljWc7hlyXtqK3mq31XKcdE7p7qu8UqOrhJYfI3/YzWBkQ6rRjARQlCF2zFvWKiLUy52ejrn0umNpukkw2t0pxYtituY3l300Qu2izXmd0MiCYtdxVANFXbRoz4UR/NXRqU0HcV5dvv2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A526616F2;
	Fri, 20 Jun 2025 12:28:43 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3BE83F673;
	Fri, 20 Jun 2025 12:29:00 -0700 (PDT)
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
Subject: [RFC PATCH 4/7] firmware: arm_scmi: Add System Telemetry driver
Date: Fri, 20 Jun 2025 20:28:10 +0100
Message-ID: <20250620192813.2463367-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250620192813.2463367-1-cristian.marussi@arm.com>
References: <20250620192813.2463367-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an SCMI System Telemetry driver which exposes a sysfs custom API to
configure and consume Telemetry data from userspace.

Still lacking:
 - complete groups handling
 - ungrouped DEs handling

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig             |  10 +
 drivers/firmware/arm_scmi/Makefile            |   1 +
 .../firmware/arm_scmi/scmi_system_telemetry.c | 967 ++++++++++++++++++
 3 files changed, 978 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/scmi_system_telemetry.c

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index e3fb36825978..9e51b3cd0c93 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -99,4 +99,14 @@ config ARM_SCMI_POWER_CONTROL
 	  called scmi_power_control. Note this may needed early in boot to catch
 	  early shutdown/reboot SCMI requests.
 
+config ARM_SCMI_SYSTEM_TELEMETRY
+	tristate "SCMI System Telemetry driver"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	help
+	  This enables SCMI Systemn Telemetry support that allows userspace to
+	  retrieve ARM Telemetry data made available via SCMI.
+
+	  This driver can also be built as a module.  If so, the module will be
+	  called scmi_system_telemetry.
+
 endmenu
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index fe55b7aa0707..20f8d55840a5 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
 
 obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
+obj-$(CONFIG_ARM_SCMI_SYSTEM_TELEMETRY) += scmi_system_telemetry.o
diff --git a/drivers/firmware/arm_scmi/scmi_system_telemetry.c b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
new file mode 100644
index 000000000000..a2f59001747d
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_system_telemetry.c
@@ -0,0 +1,967 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SCMI - System Telemetry Driver
+ *
+ * Copyright (C) 2025 ARM Ltd.
+ */
+
+#include <linux/atomic.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/scmi_protocol.h>
+#include <linux/sysfs.h>
+#include <linux/slab.h>
+
+#define MAX_BULK_LINE_CHAR_LENGTH	64
+
+struct scmi_tlm_setup;
+
+static atomic_t scmi_tlm_instance_count = ATOMIC_INIT(0);
+
+struct scmi_tlm_grp_dev {
+	struct device dev;
+	struct scmi_tlm_setup *tsp;
+	const struct scmi_telemetry_group *grp;
+};
+
+#define to_tlm_grp_dev(d)					\
+	(container_of((d), struct scmi_tlm_grp_dev, dev))
+
+struct scmi_tlm_de_dev {
+	struct device dev;
+	struct scmi_tlm_setup *tsp;
+	const struct scmi_telemetry_de *de;
+};
+
+#define to_tlm_de_dev(d)					\
+	(container_of((d), struct scmi_tlm_de_dev, dev))
+
+struct scmi_tlm_instance {
+	struct device dev;
+	struct device des_dev;
+	struct device groups_dev;
+	struct scmi_tlm_de_dev **des;
+	struct scmi_tlm_setup *tsp;
+	const struct scmi_telemetry_info *info;
+};
+
+#define dev_to_tlm_instance(d)	\
+	(container_of((d), struct scmi_tlm_instance, dev))
+
+#define des_dev_to_tlm_instance(e)	\
+	(container_of((e), struct scmi_tlm_instance, des_dev))
+
+#define groups_dev_to_tlm_instance(e)	\
+	(container_of((e), struct scmi_tlm_instance, groups_dev))
+
+/**
+ * struct scmi_tlm_setup  - Telemetry setup descriptor
+ * @sdev: A reference to the related SCMI device
+ * @ops: A reference to the protocol ops
+ * @ph: A reference to the protocol handle to be used with the ops
+ * @priv: A reference to optional driver-specific data
+ */
+struct scmi_tlm_setup {
+	struct scmi_device *sdev;
+	const struct scmi_telemetry_proto_ops *ops;
+	struct scmi_protocol_handle *ph;
+	const void *priv;
+};
+
+static void scmi_telemetry_release(struct device *dev)
+{
+}
+
+static ssize_t __all_enable_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t len,
+				  bool is_enable_entry)
+{
+	struct scmi_tlm_instance *ti = dev_to_tlm_instance(dev);
+	struct scmi_tlm_setup *tsp = ti->tsp;
+	bool enable;
+	int ret;
+
+	if (kstrtobool(buf, &enable))
+		return -EINVAL;
+
+	if (is_enable_entry && !enable) {
+		ret = tsp->ops->all_disable(tsp->ph, false);
+		if (ret)
+			return ret;
+	} else {
+		for (int i = 0; i < ti->info->num_de; i++) {
+			const struct scmi_telemetry_de *de = ti->info->des[i];
+
+			ret = tsp->ops->state_set(tsp->ph, false, de->id,
+						   is_enable_entry ? &enable : NULL,
+						   !is_enable_entry ? &enable : NULL);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return len;
+}
+
+static ssize_t all_des_enable_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	return __all_enable_store(dev, attr, buf, len, true);
+}
+
+static ssize_t all_des_tstamp_enable_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t len)
+{
+	return __all_enable_store(dev, attr, buf, len, false);
+}
+
+static inline ssize_t __current_update_show(char *buf,
+					    unsigned int active_update_interval)
+{
+	return sysfs_emit(buf, "%u\n",
+			  SCMI_GET_UPDATE_INTERVAL_SECS(active_update_interval));
+}
+
+static inline ssize_t __current_update_store(struct scmi_tlm_setup *tsp,
+					     const char *buf, size_t len,
+					     unsigned int grp_id)
+{
+	bool grp_ignore = grp_id == SCMI_TLM_GRP_INVALID ? true : false;
+	unsigned int update_interval_ms = 0;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &update_interval_ms);
+	if (ret)
+		return ret;
+
+	ret = tsp->ops->collection_configure(tsp->ph, grp_id, grp_ignore, NULL,
+					     &update_interval_ms, NULL);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t current_update_interval_ms_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct scmi_tlm_instance *ti = dev_to_tlm_instance(dev);
+
+	return __current_update_show(buf,
+				     ti->info->intervals.active_update_interval);
+}
+
+static ssize_t current_update_interval_ms_store(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t len)
+{
+	struct scmi_tlm_instance *ti = dev_to_tlm_instance(dev);
+	struct scmi_tlm_setup *tsp = ti->tsp;
+
+	return __current_update_store(tsp, buf, len, SCMI_TLM_GRP_INVALID);
+}
+
+static ssize_t tlm_enable_show(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct scmi_tlm_instance *ti = dev_to_tlm_instance(dev);
+
+	return sysfs_emit(buf, "%c\n", ti->info->enabled ? 'Y' : 'N');
+}
+
+static ssize_t tlm_enable_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t len)
+{
+	struct scmi_tlm_instance *ti = dev_to_tlm_instance(dev);
+	struct scmi_tlm_setup *tsp = ti->tsp;
+	enum scmi_telemetry_collection mode = SCMI_TLM_ONDEMAND;
+	bool enabled;
+	int ret;
+
+	ret = kstrtobool(buf, &enabled);
+	if (ret)
+		return ret;
+
+	ret = tsp->ops->collection_configure(tsp->ph, SCMI_TLM_GRP_INVALID, true,
+					     &enabled, NULL, &mode);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static int scmi_tlm_buffer_fill(struct device *dev, char *buf, size_t size,
+				int *len, int num,
+				struct scmi_telemetry_de_sample *samples)
+{
+	int idx, bytes = 0;
+
+	/* Loop till there space for the next line */
+	for (idx = 0; idx < num && size - bytes >= MAX_BULK_LINE_CHAR_LENGTH; idx++) {
+		bytes += snprintf(buf + bytes, size - bytes,
+				  "0x%04X %llu %016llX\n", samples[idx].id,
+				  samples[idx].tstamp, samples[idx].val);
+	}
+
+	if (idx < num) {
+		dev_err(dev, "Bulk buffer truncated !\n");
+		return -ENOSPC;
+	}
+
+	if (len)
+		*len = bytes;
+
+	return 0;
+}
+
+static inline ssize_t __des_bulk_read_show(struct scmi_tlm_instance *ti,
+					   unsigned int grp_id, char *buf,
+					   int size)
+{
+	struct scmi_telemetry_de_sample *samples;
+	struct scmi_tlm_setup *tsp = ti->tsp;
+	int ret, num;
+
+	num = ti->info->num_de;
+	samples = kcalloc(num, sizeof(*samples), GFP_KERNEL);
+	if (!samples)
+		return -ENOMEM;
+
+	ret = tsp->ops->des_bulk_read(tsp->ph, grp_id, &num, samples);
+	if (ret) {
+		kfree(samples);
+		return ret;
+	}
+
+	ret = scmi_tlm_buffer_fill(&ti->dev, buf, size, NULL, num, samples);
+	kfree(samples);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%s", buf);
+}
+
+static ssize_t des_bulk_read_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct scmi_tlm_instance *ti = dev_to_tlm_instance(dev);
+
+	return __des_bulk_read_show(ti, SCMI_TLM_GRP_INVALID, buf, PAGE_SIZE);
+}
+
+static inline ssize_t __des_single_sample_read_show(struct scmi_tlm_instance *ti,
+						    unsigned int grp_id,
+						    char *buf, int len)
+{
+	struct scmi_telemetry_de_sample *samples;
+	struct scmi_tlm_setup *tsp = ti->tsp;
+	int ret, num, bytes = 0;
+
+	num = ti->info->num_de;
+	samples = kcalloc(num, sizeof(*samples), GFP_KERNEL);
+	if (!samples)
+		return -ENOMEM;
+
+	ret = tsp->ops->des_sample_get(tsp->ph, grp_id, &num, samples);
+	if (ret) {
+		kfree(samples);
+		return ret;
+	}
+
+	for (int i = 0; i < num; i++) {
+		bytes += snprintf(buf + bytes, len - bytes,
+				  "0x%04X %llu %016llX\n", samples[i].id,
+				  samples[i].tstamp, samples[i].val);
+
+		if (bytes >= len) {
+			dev_err(&ti->dev, "==>> BULK BUFFER OVERFLOW !\n");
+			kfree(samples);
+			return -ENOSPC;
+		}
+	}
+
+	kfree(samples);
+
+	return sysfs_emit(buf, "%s", buf);
+}
+
+static ssize_t des_single_sample_read_show(struct device *dev,
+					   struct device_attribute *attr, char *buf)
+{
+	struct scmi_tlm_instance *ti = dev_to_tlm_instance(dev);
+
+	return __des_single_sample_read_show(ti, SCMI_TLM_GRP_INVALID,
+					     buf, PAGE_SIZE);
+}
+
+static ssize_t de_implementation_version_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct scmi_tlm_instance *ti = dev_to_tlm_instance(dev);
+
+	return sysfs_emit(buf, "%pUL\n", ti->info->de_impl_version);
+}
+
+static inline ssize_t __intervals_discrete_show(char *buf, const bool discrete)
+{
+	return sysfs_emit(buf, "%c\n", discrete ? 'Y' : 'N');
+}
+
+static ssize_t intervals_discrete_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct scmi_tlm_instance *ti = dev_to_tlm_instance(dev);
+
+	return __intervals_discrete_show(buf, ti->info->intervals.discrete);
+}
+
+//TODO Review available interval show
+#define BUF_SZ	1024
+static inline ssize_t
+__available_update_show(char *buf,
+			const struct scmi_telemetry_update_interval *intervals)
+{
+	int len = 0, num_intervals = intervals->num;
+	char available[BUF_SZ];
+
+	for (int i = 0; i < num_intervals; i++) {
+		len += scnprintf(available + len, BUF_SZ - len, "%u ",
+				 intervals->update_intervals[i]);
+	}
+
+	available[len - 1] = '\0';
+
+	return sysfs_emit(buf, "%s\n", available);
+}
+
+static ssize_t available_update_intervals_ms_show(struct device *dev,
+						  struct device_attribute *attr,
+						  char *buf)
+{
+	struct scmi_tlm_instance *ti = dev_to_tlm_instance(dev);
+
+	return __available_update_show(buf, &ti->info->intervals);
+}
+
+static ssize_t version_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct scmi_tlm_instance *ti = dev_to_tlm_instance(dev);
+
+	return sysfs_emit(buf, "0x%08x\n", ti->info->version);
+}
+
+static DEVICE_ATTR_WO(all_des_enable);
+static DEVICE_ATTR_WO(all_des_tstamp_enable);
+static DEVICE_ATTR_RW(current_update_interval_ms);
+static DEVICE_ATTR_RW(tlm_enable);
+static DEVICE_ATTR_RO(des_bulk_read);
+static DEVICE_ATTR_RO(des_single_sample_read);
+static DEVICE_ATTR_RO(de_implementation_version);
+static DEVICE_ATTR_RO(intervals_discrete);
+static DEVICE_ATTR_RO(available_update_intervals_ms);
+static DEVICE_ATTR_RO(version);
+
+static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t len)
+{
+	struct scmi_tlm_instance *ti = dev_to_tlm_instance(dev);
+	int ret;
+
+	ret = ti->tsp->ops->reset(ti->tsp->ph);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static struct device_attribute dev_attr_reset = {
+	.attr	= { .name = "reset", .mode = 0200 },
+	.store	= reset_store,
+};
+
+static struct attribute *scmi_telemetry_attrs[] = {
+	&dev_attr_all_des_enable.attr,
+	&dev_attr_all_des_tstamp_enable.attr,
+	&dev_attr_current_update_interval_ms.attr,
+	&dev_attr_tlm_enable.attr,
+	&dev_attr_des_bulk_read.attr,
+	&dev_attr_des_single_sample_read.attr,
+	&dev_attr_de_implementation_version.attr,
+	&dev_attr_intervals_discrete.attr,
+	&dev_attr_available_update_intervals_ms.attr,
+	&dev_attr_version.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(scmi_telemetry);
+
+static struct class scmi_telemetry_class = {
+	.name = "scmi_telemetry",
+	.dev_release = scmi_telemetry_release,
+};
+
+static ssize_t value_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct scmi_tlm_de_dev *tde = to_tlm_de_dev(dev);
+	struct scmi_tlm_setup *tsp = tde->tsp;
+	struct scmi_telemetry_de_sample sample;
+	int ret;
+
+	sample.id = tde->de->id;
+	ret = tsp->ops->de_data_read(tsp->ph, &sample);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu: %016llX\n", sample.tstamp, sample.val);
+}
+static DEVICE_ATTR_RO(value);
+
+#define DEFINE_DE_ATTR_INT_RO(_attr, _fmt)				\
+static ssize_t _attr##_show(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    char *buf)					\
+{									\
+	struct scmi_tlm_de_dev *tde = to_tlm_de_dev(dev);		\
+									\
+	return sysfs_emit(buf, _fmt "\n", tde->de->_attr);		\
+}									\
+static DEVICE_ATTR_RO(_attr)
+
+#define DEFINE_DE_ATTR_BOOL_RO(_attr)					\
+static ssize_t _attr##_show(struct device *dev,				\
+			    struct device_attribute *attr,		\
+			    char *buf)					\
+{									\
+	struct scmi_tlm_de_dev *tde = to_tlm_de_dev(dev);		\
+									\
+	return sysfs_emit(buf, "%c\n", tde->de->_attr ? 'Y' : 'N');	\
+}									\
+static DEVICE_ATTR_RO(_attr)
+
+DEFINE_DE_ATTR_INT_RO(type, "%u");
+DEFINE_DE_ATTR_INT_RO(unit, "%u");
+DEFINE_DE_ATTR_INT_RO(unit_exp, "%d");
+DEFINE_DE_ATTR_INT_RO(instance_id, "%u");
+DEFINE_DE_ATTR_INT_RO(compo_type, "%u");
+DEFINE_DE_ATTR_INT_RO(compo_instance_id, "%u");
+DEFINE_DE_ATTR_BOOL_RO(persistent);
+DEFINE_DE_ATTR_INT_RO(name, "%s");
+DEFINE_DE_ATTR_INT_RO(tstamp_exp, "%d");
+
+#define DEFINE_DE_ATTR_STATE_RW(_name, _is_enable)			\
+static ssize_t _name##_store(struct device *dev,			\
+			     struct device_attribute *attr,		\
+			     const char *buf, size_t len)		\
+{									\
+	struct scmi_tlm_de_dev *tde = to_tlm_de_dev(dev);		\
+	struct scmi_tlm_setup *tsp = tde->tsp;				\
+	typeof(_is_enable) _is_ena = _is_enable;			\
+	bool enabled;							\
+	int ret;							\
+									\
+	ret = kstrtobool(buf, &enabled);				\
+	if (ret)							\
+		return ret;						\
+									\
+	ret = tsp->ops->state_set(tsp->ph, false, tde->de->id,		\
+				  _is_ena ? &enabled : NULL,		\
+				  !_is_ena ? &enabled : NULL);		\
+	if (ret)							\
+		return ret;						\
+									\
+	return len;							\
+}									\
+									\
+static ssize_t _name##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	struct scmi_tlm_de_dev *tde = to_tlm_de_dev(dev);		\
+									\
+	return sysfs_emit(buf, "%c\n", tde->de->_name ## d ? 'Y' : 'N');\
+}									\
+static DEVICE_ATTR_RW(_name)
+
+DEFINE_DE_ATTR_STATE_RW(enable, true);
+DEFINE_DE_ATTR_STATE_RW(tstamp_enable, false);
+
+static struct attribute *scmi_des_attrs[] = {
+	&dev_attr_value.attr,
+	&dev_attr_type.attr,
+	&dev_attr_unit.attr,
+	&dev_attr_unit_exp.attr,
+	&dev_attr_instance_id.attr,
+	&dev_attr_compo_type.attr,
+	&dev_attr_compo_instance_id.attr,
+	&dev_attr_persistent.attr,
+	&dev_attr_enable.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(scmi_des);
+
+static void scmi_tlm_dev_release(struct device *dev)
+{
+}
+
+static int
+scmi_telemetry_dev_register(struct device *dev, struct device *parent,
+			    const char *name)
+{
+	int ret;
+
+	dev->parent = parent;
+	dev->release = scmi_tlm_dev_release;
+	dev_set_name(dev, "%s", name);
+	device_set_pm_not_required(dev);
+	dev_set_uevent_suppress(dev, true);
+	ret = device_register(dev);
+	if (ret)
+		put_device(dev);
+
+	return ret;
+}
+
+static int scmi_des_iter(struct device *dev, void *data)
+{
+	device_unregister(dev);
+
+	return 0;
+}
+
+static void scmi_telemetry_dev_unregister(struct device *parent)
+{
+	device_for_each_child(parent, NULL, scmi_des_iter);
+	device_unregister(parent);
+}
+
+static ssize_t grp_obj_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t len)
+{
+	struct scmi_tlm_grp_dev *gde = to_tlm_grp_dev(dev);
+	struct scmi_tlm_setup *tsp = gde->tsp;
+	bool enabled, is_ena_entry;
+	int ret;
+
+	ret = kstrtobool(buf, &enabled);
+	if (ret)
+		return ret;
+
+	is_ena_entry = !strncmp(attr->attr.name, "enable", 6);
+	ret = tsp->ops->state_set(tsp->ph, true, gde->grp->id,
+				  is_ena_entry ? &enabled : NULL,
+				  !is_ena_entry ? &enabled : NULL);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t grp_obj_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct scmi_tlm_grp_dev *gde = to_tlm_grp_dev(dev);
+	bool enabled, is_ena_entry;
+
+	is_ena_entry = !strncmp(attr->attr.name, "enable", 6);
+	enabled = is_ena_entry ? gde->grp->enabled : gde->grp->tstamp_enabled;
+
+	return sysfs_emit(buf, "%c\n", enabled ? 'Y' : 'N');
+}
+
+static struct device_attribute dev_attr_grp_enable = {
+	.attr	= { .name = "enable", .mode = 0600 },
+	.show	= grp_obj_show,
+	.store	= grp_obj_store,
+};
+
+static struct device_attribute dev_attr_grp_tstamp_enable = {
+	.attr	= { .name = "tstamp_enable", .mode = 0600 },
+	.show	= grp_obj_show,
+	.store	= grp_obj_store,
+};
+
+static ssize_t composing_des_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct scmi_tlm_grp_dev *gde = to_tlm_grp_dev(dev);
+
+	return sysfs_emit(buf, "%s\n", gde->grp->des_str);
+}
+static DEVICE_ATTR_RO(composing_des);
+
+static ssize_t grp_current_update_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct scmi_tlm_grp_dev *gde = to_tlm_grp_dev(dev);
+
+	return __current_update_show(buf,
+				     gde->grp->intervals.active_update_interval);
+}
+
+static ssize_t grp_current_update_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	struct scmi_tlm_grp_dev *gde = to_tlm_grp_dev(dev);
+	struct scmi_tlm_setup *tsp = gde->tsp;
+
+	return __current_update_store(tsp, buf, len, gde->grp->id);
+}
+
+static struct device_attribute dev_attr_grp_current_update = {
+	.attr	= { .name = "current_update_interval_ms", .mode = 0600 },
+	.show	= grp_current_update_show,
+	.store	= grp_current_update_store,
+};
+
+static ssize_t grp_intervals_discrete_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct scmi_tlm_grp_dev *gde = to_tlm_grp_dev(dev);
+
+	return __intervals_discrete_show(buf, gde->grp->intervals.discrete);
+}
+
+static struct device_attribute dev_attr_grp_intervals_discrete = {
+	.attr	= { .name = "intervals_discrete", .mode = 0400 },
+	.show	= grp_intervals_discrete_show,
+};
+
+static ssize_t grp_available_intervals_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct scmi_tlm_grp_dev *gde = to_tlm_grp_dev(dev);
+
+	return __available_update_show(buf, &gde->grp->intervals);
+}
+
+static struct device_attribute dev_attr_grp_available_intervals = {
+	.attr	= { .name = "available_update_intervals_ms", .mode = 0400 },
+	.show	= grp_available_intervals_show,
+};
+
+static ssize_t grp_des_bulk_read_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct scmi_tlm_grp_dev *gde = to_tlm_grp_dev(dev);
+	struct scmi_tlm_instance *ti =
+		groups_dev_to_tlm_instance(gde->dev.parent);
+
+	return __des_bulk_read_show(ti, gde->grp->id, buf, PAGE_SIZE);
+}
+
+static ssize_t grp_des_single_sample_read_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct scmi_tlm_grp_dev *gde = to_tlm_grp_dev(dev);
+	struct scmi_tlm_instance *ti =
+		groups_dev_to_tlm_instance(gde->dev.parent);
+
+	return __des_single_sample_read_show(ti, gde->grp->id, buf, PAGE_SIZE);
+}
+
+static struct device_attribute dev_attr_grp_des_bulk_read = {
+	.attr	= { .name = "des_bulk_read", .mode = 0400 },
+	.show	= grp_des_bulk_read_show,
+};
+
+static struct device_attribute dev_attr_grp_des_single_sample_read = {
+	.attr	= { .name = "des_single_sample_read", .mode = 0400 },
+	.show	= grp_des_single_sample_read_show,
+};
+
+static struct attribute *scmi_grp_attrs[] = {
+	&dev_attr_grp_enable.attr,
+	&dev_attr_grp_tstamp_enable.attr,
+	&dev_attr_grp_des_bulk_read.attr,
+	&dev_attr_grp_des_single_sample_read.attr,
+	&dev_attr_composing_des.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(scmi_grp);
+
+static int scmi_telemetry_groups_initialize(struct device *dev,
+					    struct scmi_tlm_instance *ti)
+{
+	int ret;
+
+	if (ti->info->num_groups == 0)
+		return 0;
+
+	ret = scmi_telemetry_dev_register(&ti->groups_dev, &ti->dev, "groups");
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < ti->info->num_groups; i++) {
+		const struct scmi_telemetry_group *grp = &ti->info->des_groups[i];
+		struct scmi_tlm_grp_dev *gdev;
+		char name[16];
+
+		gdev = devm_kzalloc(dev, sizeof(*gdev), GFP_KERNEL);
+		if (!gdev) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		gdev->tsp = ti->tsp;
+		gdev->grp = grp;
+		gdev->dev.groups = scmi_grp_groups;
+
+		snprintf(name, 8, "%d", grp->id);
+		ret = scmi_telemetry_dev_register(&gdev->dev,
+						  &ti->groups_dev, name);
+		if (ret)
+			goto err;
+
+		if (ti->info->per_group_config_support) {
+			sysfs_add_file_to_group(&gdev->dev.kobj,
+						&dev_attr_grp_current_update.attr,
+						NULL);
+			sysfs_add_file_to_group(&gdev->dev.kobj,
+						&dev_attr_grp_intervals_discrete.attr,
+						NULL);
+			sysfs_add_file_to_group(&gdev->dev.kobj,
+						&dev_attr_grp_available_intervals.attr,
+						NULL);
+		}
+	}
+
+	dev_info(dev, "Found %d Telemetry GROUPS resources.\n",
+		 ti->info->num_groups);
+
+	return 0;
+
+err:
+	scmi_telemetry_dev_unregister(&ti->groups_dev);
+
+	return ret;
+}
+
+static int scmi_telemetry_des_initialize(struct device *dev,
+					 struct scmi_tlm_instance *ti)
+{
+	int ret;
+
+	ret = scmi_telemetry_dev_register(&ti->des_dev, &ti->dev, "des");
+	if (ret)
+		return ret;
+
+	for (int i = 0; i < ti->info->num_de; i++) {
+		const struct scmi_telemetry_de *de = ti->info->des[i];
+		struct scmi_tlm_de_dev *tdev;
+		char name[16];
+
+		tdev = devm_kzalloc(dev, sizeof(*tdev), GFP_KERNEL);
+		if (!tdev) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		tdev->tsp = ti->tsp;
+		tdev->de = de;
+		tdev->dev.groups = scmi_des_groups;
+
+		/*XXX What about of ID/name digits-length used ? */
+		snprintf(name, 8, "0x%04X", de->id);
+		ret = scmi_telemetry_dev_register(&tdev->dev,
+						  &ti->des_dev, name);
+		if (ret)
+			goto err;
+
+		if (de->name)
+			sysfs_add_file_to_group(&tdev->dev.kobj,
+						&dev_attr_name.attr, NULL);
+		if (de->tstamp_support) {
+			sysfs_add_file_to_group(&tdev->dev.kobj,
+						&dev_attr_tstamp_exp.attr,
+						NULL);
+			sysfs_add_file_to_group(&tdev->dev.kobj,
+						&dev_attr_tstamp_enable.attr,
+						NULL);
+		}
+	}
+
+	dev_info(dev, "Found %d Telemetry DE resources.\n",
+		 ti->info->num_de);
+
+	return 0;
+
+err:
+	scmi_telemetry_dev_unregister(&ti->des_dev);
+
+	return ret;
+}
+
+static int
+scmi_tlm_root_instance_initialize(struct device *dev,
+				  struct scmi_tlm_instance *ti, int instance_id)
+{
+	char name[16];
+	int ret;
+
+	ti->dev.class = &scmi_telemetry_class;
+	ti->dev.groups = scmi_telemetry_groups;
+
+	snprintf(name, 16, "scmi_tlm_%d", instance_id);
+	ret = scmi_telemetry_dev_register(&ti->dev, NULL, name);
+	if (ret)
+		return ret;
+
+	if (ti->info->reset_support)
+		ret = sysfs_add_file_to_group(&ti->dev.kobj,
+					      &dev_attr_reset.attr, NULL);
+
+	return ret;
+}
+
+static struct scmi_tlm_instance *scmi_tlm_init(struct scmi_tlm_setup *tsp,
+					       int instance_id)
+{
+	const struct scmi_telemetry_proto_ops *tlm_ops = tsp->ops;
+	struct device *dev = &tsp->sdev->dev;
+	struct scmi_tlm_instance *ti;
+	int ret;
+
+	ti = devm_kzalloc(dev, sizeof(*ti), GFP_KERNEL);
+	if (!ti)
+		return ERR_PTR(-ENOMEM);
+
+	ti->info = tlm_ops->info_get(tsp->ph);
+	if (!ti->info) {
+		dev_err(dev, "invalid Telemetry info !\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	ti->tsp = tsp;
+
+	ret = scmi_tlm_root_instance_initialize(dev, ti, instance_id);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = scmi_telemetry_des_initialize(dev, ti);
+	if (ret) {
+		device_unregister(&ti->dev);
+		return ERR_PTR(ret);
+	}
+
+	ret = scmi_telemetry_groups_initialize(dev, ti);
+	if (ret) {
+		scmi_telemetry_dev_unregister(&ti->des_dev);
+		device_unregister(&ti->dev);
+		return ERR_PTR(ret);
+	}
+
+	return ti;
+}
+
+static int scmi_telemetry_probe(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+	struct scmi_protocol_handle *ph;
+	struct device *dev = &sdev->dev;
+	struct scmi_tlm_instance *ti;
+	struct scmi_tlm_setup *tsp;
+	const void *ops;
+
+	if (!handle)
+		return -ENODEV;
+
+	ops = handle->devm_protocol_get(sdev, sdev->protocol_id, &ph);
+	if (IS_ERR(ops))
+		return dev_err_probe(dev, PTR_ERR(ops),
+				     "Cannot access protocol:0x%X\n",
+				     sdev->protocol_id);
+
+	tsp = devm_kzalloc(&sdev->dev, sizeof(*tsp), GFP_KERNEL);
+	if (!tsp)
+		return -ENOMEM;
+
+	tsp->sdev = sdev;
+	tsp->ops = ops;
+	tsp->ph = ph;
+
+	//TODO Better to get info->id from SCMI/core
+	ti = scmi_tlm_init(tsp, atomic_fetch_inc(&scmi_tlm_instance_count));
+	if (IS_ERR(ti))
+		return PTR_ERR(ti);
+
+	dev_set_drvdata(&sdev->dev, ti);
+
+	return 0;
+}
+
+static void scmi_telemetry_remove(struct scmi_device *sdev)
+{
+	struct device *dev = &sdev->dev;
+	struct scmi_tlm_instance *ti;
+	bool enabled = false;
+	int ret;
+
+	ti = dev_get_drvdata(&sdev->dev);
+
+	ret = ti->tsp->ops->collection_configure(ti->tsp->ph,
+						 SCMI_TLM_GRP_INVALID, true,
+						 &enabled, NULL, NULL);
+	if (ret)
+		dev_warn(dev, "Failed to stop Telemetry collection\n");
+
+	scmi_telemetry_dev_unregister(&ti->groups_dev);
+	scmi_telemetry_dev_unregister(&ti->des_dev);
+	device_unregister(&ti->dev);
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_TELEMETRY, "telemetry" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_telemetry_driver = {
+	.name = "scmi-telemetry-driver",
+	.probe = scmi_telemetry_probe,
+	.remove = scmi_telemetry_remove,
+	.id_table = scmi_id_table,
+};
+
+static int __init scmi_telemetry_init(void)
+{
+	int ret;
+
+	ret = class_register(&scmi_telemetry_class);
+	if (ret)
+		return ret;
+
+	ret = scmi_register(&scmi_telemetry_driver);
+	if (ret)
+		class_unregister(&scmi_telemetry_class);
+
+	return ret;
+}
+module_init(scmi_telemetry_init);
+
+static void __exit scmi_telemetry_exit(void)
+{
+	scmi_unregister(&scmi_telemetry_driver);
+
+	class_unregister(&scmi_telemetry_class);
+}
+module_exit(scmi_telemetry_exit);
+
+MODULE_AUTHOR("Cristian Marussi <cristian.marussi@arm.com>");
+MODULE_DESCRIPTION("ARM SCMI Telemetry Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.47.0


