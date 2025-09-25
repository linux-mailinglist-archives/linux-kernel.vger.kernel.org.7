Return-Path: <linux-kernel+bounces-833187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4612BA15F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A52D62438F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACDA31FED5;
	Thu, 25 Sep 2025 20:36:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E92331FEDF;
	Thu, 25 Sep 2025 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832595; cv=none; b=ZbUhyn4kwn1U8SFN14p8rIp+6zbSZa+92XOcGoTgGRjcR64NK+Rl5bxSrzxZaJG3kw5o8G4cgm9Ba+Zp4h0NVEM8x9BcF3JDJe/wpoiCtiS0HOaGWb+TWsQ+/QN4RVGjOf0foFImOFAfs41zkESyM23VGlW3AUagdULWF1BXmsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832595; c=relaxed/simple;
	bh=lx3+DDXz17q9zchXS+pHqcpMn5hljDyFdA5F67r54e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpVfotG0UojpmIlhAbTZdxRvPVcMO+hybEeAcdNqLpq91Np6GTd8dDH/bxcuWxrMz3MFcrWpxHSklPopzsLnCt4caXMtIvRJ0Y2ntowj3TctJAU3MdwdLttQ3b9KIMG3wHGbdumAQTsDdUYG62EN5bNkocqVe83Z2IPCN/YITU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2BF91692;
	Thu, 25 Sep 2025 13:36:24 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EAA93F694;
	Thu, 25 Sep 2025 13:36:29 -0700 (PDT)
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
Subject: [PATCH 04/10] uapi: Add ARM SCMI definitions
Date: Thu, 25 Sep 2025 21:35:48 +0100
Message-ID: <20250925203554.482371-5-cristian.marussi@arm.com>
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

Add a number of structures and ioctls definitions used by the ARM
SCMI Telemetry protocol.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 MAINTAINERS               |   1 +
 include/uapi/linux/scmi.h | 286 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 287 insertions(+)
 create mode 100644 include/uapi/linux/scmi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f6206963efbf..5c10e096e638 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24552,6 +24552,7 @@ F:	drivers/regulator/scmi-regulator.c
 F:	drivers/reset/reset-scmi.c
 F:	include/linux/sc[mp]i_protocol.h
 F:	include/trace/events/scmi.h
+F:	include/uapi/linux/scmi.h
 F:	include/uapi/linux/virtio_scmi.h
 
 SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) i.MX Extension Message Protocol drivers
diff --git a/include/uapi/linux/scmi.h b/include/uapi/linux/scmi.h
new file mode 100644
index 000000000000..b1a6d34fee4a
--- /dev/null
+++ b/include/uapi/linux/scmi.h
@@ -0,0 +1,286 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+#ifndef _UAPI_LINUX_SCMI_H
+#define _UAPI_LINUX_SCMI_H
+
+/*
+ * Userspace interface SCMI Telemetry
+ */
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define SCMI_TLM_DE_IMPL_MAX_DWORDS	4
+
+#define SCMI_TLM_GRP_INVALID            0xFFFFFFFF
+
+/**
+ * scmi_tlm_base_info - Basic info about an instance
+ *
+ * @version: SCMI Telemetry protocol version
+ * @de_impl_version: SCMI Telemetry DE implementation revision
+ * @num_de: Number of defined DEs
+ * @num_groups Number of defined DEs groups
+ * @num_intervals: Number of update intervals available (instance-level)
+ * @flags: Instance specific feature-support bitmap
+ *
+ * Used by:
+ *	RO - SCMI_TLM_GET_INFO
+ *
+ * Supported by:
+ *	control/
+ */
+struct scmi_tlm_base_info {
+	__u32 version;
+	__u32 de_impl_version[SCMI_TLM_DE_IMPL_MAX_DWORDS];
+	__u32 num_des;
+	__u32 num_groups;
+	__u32 num_intervals;
+	__u32 flags;
+#define SCMI_TLM_CAN_RESET	(1 << 0)
+///TODO more flags
+};
+
+/**
+ * scmi_tlm_config  - Whole instance or group configuration
+ *
+ * @enable: Enable/Disable Telemetry for the whole instance or the group
+ * @t_enable: Enable/Disable timestamping for all the DEs belonging to a group.
+ * @current_update_interval: Get/Set currently active update interval for the
+ *			     whole instance or a group.
+ *
+ * Used by:
+ *	RO - SCMI_TLM_GET_CFG
+ *	WO - SCMI_TLM_SET_CFG
+ *
+ * Supported by:
+ *	control/
+ *	groups/<N>/control
+ */
+struct scmi_tlm_config {
+	__u8 enable;
+	__u8 t_enable;
+	__u8 reserved[2];
+	__u32 current_update_interval;
+};
+
+/**
+ * scmi_tlm_intervals  - Update intervals descriptor
+ *
+ * @discrete: Flag to indicate the nature of the intervals described in
+ *	      @update_intervals.
+ *	      When 'false' @update_intervals is a triplet: min/max/step
+ * @num: Number of entries of @available
+ * @update_intervals: A variably-sized array containing the update intervals
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_INTRVS
+ *
+ * Supported by:
+ *	control/
+ *	groups/<N>/control
+ */
+struct scmi_tlm_intervals {
+	__u8 discrete;
+	__u8 reserved[3];
+	__u32 num;
+#define SCMI_TLM_UPDATE_INTVL_SEGMENT_LOW	0
+#define SCMI_TLM_UPDATE_INTVL_SEGMENT_HIGH	1
+#define SCMI_TLM_UPDATE_INTVL_SEGMENT_STEP	2
+	__u32 update_intervals[];
+};
+
+/**
+ * scmi_tlm_de_config  - DE configuration
+ *
+ * @id: Identifier of the DE to act upon (ignored by SCMI_TLM_SET_ALL_CFG)
+ * @enable: A boolean to enable/disable the DE
+ * @t_enable: A boolean to enable/disable the timestamp for this DE
+ *	      (if supported)
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_DE_CFG
+ *	RW - SCMI_TLM_SET_DE_CFG
+ *	WO - SCMI_TLM_SET_ALL_CFG
+ *
+ * Supported by:
+ *	control/
+ */
+struct scmi_tlm_de_config {
+	__u32 id;
+	__u32 enable;
+	__u32 t_enable;
+};
+
+/**
+ * scmi_tlm_de_info  - DE Descriptor
+ *
+ * @id: DE identifier
+ * @grp_id: Identifier of the group which this DE belongs to; reported as
+ *	    SCMI_TLM_GRP_INVALID when not part of any group
+ * @data_sz: DE data size in bytes
+ * @type: DE type
+ * @unit: DE unit of measurements
+ * @unit_exp: Power-of-10 multiplier for DE unit
+ * @tstamp_exp: Power-of-10 multiplier for DE timestamp (if supported)
+ * @instance_id: DE instance ID
+ * @compo_instance_id: DE component instance ID
+ * @compo_type: Type of component which is associated to this DE
+ * @peristent: Data value for this DE survives reboot (non-cold ones)
+ * @name: Optional name of this DE
+ *
+ * Used to get the full description of a DE: it reflects DE Descriptors
+ * definitions in 3.12.4.6.
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_DE_INFO
+ *
+ * Supported by:
+ *	control/
+ */
+struct scmi_tlm_de_info {
+	__u32 id;
+	__u32 grp_id;
+	__u32 data_sz;
+	__u32 type;
+	__u32 unit;
+	__s32 unit_exp;
+	__s32 tstamp_exp;
+	__u32 instance_id;
+	__u32 compo_instance_id;
+	__u32 compo_type;
+	__u32 persistent;
+	__u8 name[16];
+};
+
+/**
+ * scmi_tlm_des_list  - List of all defined DEs
+ *
+ * @num_des: Number of entries in @des
+ * @des: An array containing descriptors for all defined DEs
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_DE_LIST
+ *
+ * Supported by:
+ *	control/
+ */
+struct scmi_tlm_des_list {
+	__u32 num_des;
+	struct scmi_tlm_de_info des[];
+};
+
+/**
+ * scmi_tlm_de_sample - A DE reading
+ *
+ * @id: DE identifier
+ * @tstamp: DE reading timestamp (equal 0 is NOT supported)
+ * @val: Reading of the DE data value
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_DE_VALUE
+ *
+ * Supported by:
+ *	control/
+ */
+struct scmi_tlm_de_sample {
+	__u32 id;
+	__u64 tstamp;
+	__u64 val;
+};
+
+/**
+ * scmi_tlm_data_read - Bulk read of multiple DEs
+ *
+ * @num_samples: Number of entries returned in @samples
+ * @samples: An array of samples containing an entry for each DE that was
+ *	     enabled when the single sample read request was issued.
+ *
+ * Used by:
+ *	RW - SCMI_TLM_SINGLE_SAMPLE
+ *	RW - SCMI_TLM_BULK_READ
+ *
+ * Supported by:
+ *	control/
+ *	groups/<N>/control
+ */
+struct scmi_tlm_data_read {
+	__u32 num_samples;
+	struct scmi_tlm_de_sample samples[];
+};
+
+/**
+ * scmi_tlm_grp_info  - DE-group descriptor
+ *
+ * @id: Group ID number
+ * @num_des: Number of DEs part of this group
+ * @num_intervals: Number of update intervals supported. Zero if group does not
+ *		   support per-group update interval configuration.
+ *
+ * Used by:
+ *	RO - SCMI_TLM_GET_GRP_INFO
+ *
+ * Supported by:
+ *	groups/<N>control/
+ */
+struct scmi_tlm_grp_info {
+	__u32 id;
+	__u32 num_des;
+	__u32 num_intervals;
+};
+
+/**
+ * scmi_tlm_grps_list  - DE-groups List
+ *
+ * @num_grps: Number of entries returned in @grps
+ * @grps: An array containing descriptors for all defined DE Groups
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_GRP_LIST
+ *
+ * Supported by:
+ *	control/
+ */
+struct scmi_tlm_grps_list {
+	__u32 num_grps;
+	struct scmi_tlm_grp_info grps[];
+};
+
+/**
+ * scmi_tlm_grp_desc  - Group descriptor
+ *
+ * @num_des: Number of DEs part of this group
+ * @composing_des: An array containing the DE IDs that belongs to this group.
+ *
+ * Used by:
+ *	RW - SCMI_TLM_GET_GRP_DESC
+ *
+ * Supported by:
+ *	groups/<N>control/
+ */
+struct scmi_tlm_grp_desc {
+	__u32 num_des;
+	__u32 composing_des[];
+};
+
+#define SCMI 0xF1
+
+#define SCMI_TLM_GET_INFO	_IOR(SCMI,  0x00, struct scmi_tlm_base_info)
+#define SCMI_TLM_GET_CFG	_IOR(SCMI,  0x01, struct scmi_tlm_config)
+#define SCMI_TLM_SET_CFG	_IOW(SCMI,  0x02, struct scmi_tlm_config)
+#define SCMI_TLM_GET_INTRVS	_IOWR(SCMI, 0x03, struct scmi_tlm_intervals)
+#define SCMI_TLM_GET_DE_CFG	_IOWR(SCMI, 0x04, struct scmi_tlm_de_config)
+#define SCMI_TLM_SET_DE_CFG	_IOWR(SCMI, 0x05, struct scmi_tlm_de_config)
+#define SCMI_TLM_GET_DE_INFO	_IOWR(SCMI, 0x06, struct scmi_tlm_de_info)
+#define SCMI_TLM_GET_DE_LIST	_IOWR(SCMI, 0x07, struct scmi_tlm_des_list)
+#define SCMI_TLM_GET_DE_VALUE	_IOWR(SCMI, 0x08, struct scmi_tlm_de_sample)
+#define SCMI_TLM_SET_ALL_CFG	_IOW(SCMI,  0x09, struct scmi_tlm_de_config)
+#define SCMI_TLM_GET_GRP_LIST	_IOWR(SCMI, 0x0A, struct scmi_tlm_grps_list)
+#define SCMI_TLM_GET_GRP_INFO	_IOR(SCMI,  0x0B, struct scmi_tlm_grp_info)
+#define SCMI_TLM_GET_GRP_DESC	_IOWR(SCMI, 0x0C, struct scmi_tlm_grp_desc)
+#define SCMI_TLM_SINGLE_SAMPLE	_IOWR(SCMI, 0x0D, struct scmi_tlm_data_read)
+#define SCMI_TLM_BULK_READ	_IOWR(SCMI, 0x0E, struct scmi_tlm_data_read)
+
+#endif /* _UAPI_LINUX_SCMI_H */
-- 
2.51.0


