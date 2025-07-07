Return-Path: <linux-kernel+bounces-720420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DF1AFBB87
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B1A7A9B6F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF77267AF1;
	Mon,  7 Jul 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cc2g+Zzk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9082673BD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915304; cv=none; b=RAr9eog8u/QzUSwnFRE9ParU3G2UYbMw0P8Zn2DUj3DZ0M0oQxtV6t3ZK5bQp0tTAARASlaIcFTod/KwPXq56nM3U0/15IUtsn6B68n3T1usvi6fDzX1No1x0cphuhhyoL3FfxwEnaqfEQ8CHjR5/AbSDa3mCOrWnGXQJzvwOP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915304; c=relaxed/simple;
	bh=zfEMSZNS7WZOf4XboYjNsTZzoVX9JqsD4ZPLNOqTQTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLmrbIEggPuy7qogj7GNQ0MPEBEiamfBb9sTUQM21QmaxraDr76emvwWXb2ivbH1FDnwnz8xrnEIebL0eSFaNcwWpMJvsgzzqOAylhMlDceo43FyOLabeKLTGacHk1gsq21KhE3AtxSfG//CTZULyqCrikbbzH88NBo7qhV6c8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cc2g+Zzk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751915303; x=1783451303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zfEMSZNS7WZOf4XboYjNsTZzoVX9JqsD4ZPLNOqTQTk=;
  b=cc2g+ZzkeuUw3q472QdgBLnGhpZPVPO4vxiSYzaH6nCyt2408uDB8ow2
   Iq2j+EpQeIwERaHrCB21cKTEZyLwpOwWANhz1d+ayzcPmk+IWNeViKaWt
   EiTbg/dDUmfVPHjftRbnG1bIKxjvTQoql3GI8ECn6ylu/5uZlp7qgQcAL
   s5cH33iUuxUkzdBSk4amwnXpQUeUMX1hrkC+42wSNSqauS/PJAh48ymkJ
   wEUm0qyHkgwrLz4WoaOg3aAyVIVk3pKvT69UakRj+vfVwAJvD0w2HmF1M
   G4Q10QUGHst5CNhRg7gKF1uUqrgsHSgjoaAp+nJbNkrLT9Vjzj3qA1kCD
   g==;
X-CSE-ConnectionGUID: DoO0idINTByy1PiWDfloJQ==
X-CSE-MsgGUID: LT+Wx4xaST+QfKfCm3wPog==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57945665"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="57945665"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:08:22 -0700
X-CSE-ConnectionGUID: DM4zPoNGR8q6qF37C3XOXw==
X-CSE-MsgGUID: jv/Dok5CS5++C+vPr8AX/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="154707437"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:08:19 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	alexander.usyskin@intel.com,
	gregkh@linuxfoundation.org,
	daniele.ceraolospurio@intel.com
Subject: [PATCH v7 2/9] mei: late_bind: add late binding component driver
Date: Tue,  8 Jul 2025 00:42:30 +0530
Message-Id: <20250707191237.1782824-3-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707191237.1782824-1-badal.nilawar@intel.com>
References: <20250707191237.1782824-1-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

Add late binding component driver.
It allows pushing the late binding configuration from, for example,
the Xe graphics driver to the Intel discrete graphics card's CSE device.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Reviewed-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/misc/mei/Kconfig                    |  11 +
 drivers/misc/mei/Makefile                   |   1 +
 drivers/misc/mei/mei_late_bind.c            | 271 ++++++++++++++++++++
 include/drm/intel/i915_component.h          |   1 +
 include/drm/intel/late_bind_mei_interface.h |  62 +++++
 5 files changed, 346 insertions(+)
 create mode 100644 drivers/misc/mei/mei_late_bind.c
 create mode 100644 include/drm/intel/late_bind_mei_interface.h

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 7575fee96cc6..36569604038c 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -81,6 +81,17 @@ config INTEL_MEI_VSC
 	  This driver can also be built as a module. If so, the module
 	  will be called mei-vsc.
 
+config INTEL_MEI_LATE_BIND
+	tristate "Intel late binding support on ME Interface"
+	depends on INTEL_MEI_ME
+	depends on DRM_XE
+	help
+	  MEI Support for Late Binding for Intel graphics card.
+
+	  Enables the ME FW interfaces for Late Binding feature,
+	  allowing loading of firmware for the devices like Fan
+	  Controller by Intel Xe driver.
+
 source "drivers/misc/mei/hdcp/Kconfig"
 source "drivers/misc/mei/pxp/Kconfig"
 source "drivers/misc/mei/gsc_proxy/Kconfig"
diff --git a/drivers/misc/mei/Makefile b/drivers/misc/mei/Makefile
index 6f9fdbf1a495..b639a897b472 100644
--- a/drivers/misc/mei/Makefile
+++ b/drivers/misc/mei/Makefile
@@ -31,6 +31,7 @@ CFLAGS_mei-trace.o = -I$(src)
 obj-$(CONFIG_INTEL_MEI_HDCP) += hdcp/
 obj-$(CONFIG_INTEL_MEI_PXP) += pxp/
 obj-$(CONFIG_INTEL_MEI_GSC_PROXY) += gsc_proxy/
+obj-$(CONFIG_INTEL_MEI_LATE_BIND) += mei_late_bind.o
 
 obj-$(CONFIG_INTEL_MEI_VSC_HW) += mei-vsc-hw.o
 mei-vsc-hw-y := vsc-tp.o
diff --git a/drivers/misc/mei/mei_late_bind.c b/drivers/misc/mei/mei_late_bind.c
new file mode 100644
index 000000000000..48f70c05dd53
--- /dev/null
+++ b/drivers/misc/mei/mei_late_bind.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+#include <drm/intel/i915_component.h>
+#include <drm/intel/late_bind_mei_interface.h>
+#include <linux/component.h>
+#include <linux/pci.h>
+#include <linux/mei_cl_bus.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/slab.h>
+#include <linux/uuid.h>
+
+#include "mkhi.h"
+
+#define GFX_SRV_MKHI_LATE_BINDING_CMD 0x12
+#define GFX_SRV_MKHI_LATE_BINDING_RSP (GFX_SRV_MKHI_LATE_BINDING_CMD | 0x80)
+
+#define LATE_BIND_SEND_TIMEOUT_MSEC 3000
+#define LATE_BIND_RECV_TIMEOUT_MSEC 3000
+
+/**
+ * struct csc_heci_late_bind_req - late binding request
+ * @header: @ref mkhi_msg_hdr
+ * @type: type of the late binding payload
+ * @flags: flags to be passed to the firmware
+ * @reserved: reserved for future use by firmware, must be set to 0
+ * @payload_size: size of the payload data in bytes
+ * @payload: data to be sent to the firmware
+ */
+struct csc_heci_late_bind_req {
+	struct mkhi_msg_hdr header;
+	__le32 type;
+	__le32 flags;
+	__le32 reserved[2];
+	__le32 payload_size;
+	u8  payload[] __counted_by(payload_size);
+} __packed;
+
+/**
+ * struct csc_heci_late_bind_rsp - late binding response
+ * @header: @ref mkhi_msg_hdr
+ * @type: type of the late binding payload
+ * @reserved: reserved for future use by firmware, must be set to 0
+ * @status: status of the late binding command execution by firmware
+ */
+struct csc_heci_late_bind_rsp {
+	struct mkhi_msg_hdr header;
+	__le32 type;
+	__le32 reserved[2];
+	__le32 status;
+} __packed;
+
+static int mei_late_bind_check_response(const struct device *dev, const struct mkhi_msg_hdr *hdr)
+{
+	if (hdr->group_id != MKHI_GROUP_ID_GFX) {
+		dev_err(dev, "Mismatch group id: 0x%x instead of 0x%x\n",
+			hdr->group_id, MKHI_GROUP_ID_GFX);
+		return -EINVAL;
+	}
+
+	if (hdr->command != GFX_SRV_MKHI_LATE_BINDING_RSP) {
+		dev_err(dev, "Mismatch command: 0x%x instead of 0x%x\n",
+			hdr->command, GFX_SRV_MKHI_LATE_BINDING_RSP);
+		return -EINVAL;
+	}
+
+	if (hdr->result) {
+		dev_err(dev, "Error in result: 0x%x\n", hdr->result);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mei_late_bind_push_config(struct device *dev, enum late_bind_type type, u32 flags,
+				     const void *payload, size_t payload_size)
+{
+	struct mei_cl_device *cldev;
+	struct csc_heci_late_bind_req *req = NULL;
+	struct csc_heci_late_bind_rsp rsp;
+	size_t req_size;
+	ssize_t bytes;
+	int ret;
+
+	cldev = to_mei_cl_device(dev);
+
+	ret = mei_cldev_enable(cldev);
+	if (ret) {
+		dev_dbg(dev, "mei_cldev_enable failed. %d\n", ret);
+		return ret;
+	}
+
+	req_size = struct_size(req, payload, payload_size);
+	if (req_size > mei_cldev_mtu(cldev)) {
+		dev_err(dev, "Payload is too big %zu\n", payload_size);
+		ret = -EMSGSIZE;
+		goto end;
+	}
+
+	req = kmalloc(req_size, GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	req->header.group_id = MKHI_GROUP_ID_GFX;
+	req->header.command = GFX_SRV_MKHI_LATE_BINDING_CMD;
+	req->type = cpu_to_le32(type);
+	req->flags = cpu_to_le32(flags);
+	req->reserved[0] = 0;
+	req->reserved[1] = 0;
+	req->payload_size = cpu_to_le32(payload_size);
+	memcpy(req->payload, payload, payload_size);
+
+	bytes = mei_cldev_send_timeout(cldev,
+				       (void *)req, req_size, LATE_BIND_SEND_TIMEOUT_MSEC);
+	if (bytes < 0) {
+		dev_err(dev, "mei_cldev_send failed. %zd\n", bytes);
+		ret = bytes;
+		goto end;
+	}
+
+	bytes = mei_cldev_recv_timeout(cldev,
+				       (void *)&rsp, sizeof(rsp), LATE_BIND_RECV_TIMEOUT_MSEC);
+	if (bytes < 0) {
+		dev_err(dev, "mei_cldev_recv failed. %zd\n", bytes);
+		ret = bytes;
+		goto end;
+	}
+	if (bytes < sizeof(rsp.header)) {
+		dev_err(dev, "bad response header from the firmware: size %zd < %zu\n",
+			bytes, sizeof(rsp.header));
+		ret = -EPROTO;
+		goto end;
+	}
+	if (mei_late_bind_check_response(dev, &rsp.header)) {
+		dev_err(dev, "bad result response from the firmware: 0x%x\n",
+			*(uint32_t *)&rsp.header);
+		ret = -EPROTO;
+		goto end;
+	}
+	if (bytes < sizeof(rsp)) {
+		dev_err(dev, "bad response from the firmware: size %zd < %zu\n",
+			bytes, sizeof(rsp));
+		ret = -EPROTO;
+		goto end;
+	}
+
+	dev_dbg(dev, "status = %u\n", le32_to_cpu(rsp.status));
+	ret = (int)le32_to_cpu(rsp.status);
+end:
+	mei_cldev_disable(cldev);
+	kfree(req);
+	return ret;
+}
+
+static const struct late_bind_component_ops mei_late_bind_ops = {
+	.push_config = mei_late_bind_push_config,
+};
+
+static int mei_component_master_bind(struct device *dev)
+{
+	return component_bind_all(dev, (void *)&mei_late_bind_ops);
+}
+
+static void mei_component_master_unbind(struct device *dev)
+{
+	component_unbind_all(dev, (void *)&mei_late_bind_ops);
+}
+
+static const struct component_master_ops mei_component_master_ops = {
+	.bind = mei_component_master_bind,
+	.unbind = mei_component_master_unbind,
+};
+
+/**
+ * mei_late_bind_component_match - compare function for matching mei late bind.
+ *
+ *    This function checks if requester is Intel PCI_CLASS_DISPLAY_VGA or
+ *    PCI_CLASS_DISPLAY_OTHER device, and checks if the requester is the
+ *    grand parent of mei_if i.e. late_bind mei device
+ *
+ * @dev: master device
+ * @subcomponent: subcomponent to match (INTEL_COMPONENT_LATE_BIND)
+ * @data: compare data (late_bind mei device on mei bus)
+ *
+ * Return:
+ * * 1 - if components match
+ * * 0 - otherwise
+ */
+static int mei_late_bind_component_match(struct device *dev, int subcomponent,
+					 void *data)
+{
+	struct device *base = data;
+	struct pci_dev *pdev;
+
+	if (!dev)
+		return 0;
+
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+
+	if (pdev->vendor != PCI_VENDOR_ID_INTEL)
+		return 0;
+
+	if (pdev->class != (PCI_CLASS_DISPLAY_VGA << 8) &&
+	    pdev->class != (PCI_CLASS_DISPLAY_OTHER << 8))
+		return 0;
+
+	if (subcomponent != INTEL_COMPONENT_LATE_BIND)
+		return 0;
+
+	base = base->parent;
+	if (!base) /* mei device */
+		return 0;
+
+	base = base->parent; /* pci device */
+
+	return !!base && dev == base;
+}
+
+static int mei_late_bind_probe(struct mei_cl_device *cldev,
+			       const struct mei_cl_device_id *id)
+{
+	struct component_match *master_match = NULL;
+	int ret;
+
+	component_match_add_typed(&cldev->dev, &master_match,
+				  mei_late_bind_component_match, &cldev->dev);
+	if (IS_ERR_OR_NULL(master_match))
+		return -ENOMEM;
+
+	ret = component_master_add_with_match(&cldev->dev,
+					      &mei_component_master_ops,
+					      master_match);
+	if (ret < 0)
+		dev_err(&cldev->dev, "Master comp add failed %d\n", ret);
+
+	return ret;
+}
+
+static void mei_late_bind_remove(struct mei_cl_device *cldev)
+{
+	component_master_del(&cldev->dev, &mei_component_master_ops);
+}
+
+#define MEI_GUID_MKHI UUID_LE(0xe2c2afa2, 0x3817, 0x4d19, \
+			      0x9d, 0x95, 0x6, 0xb1, 0x6b, 0x58, 0x8a, 0x5d)
+
+static struct mei_cl_device_id mei_late_bind_tbl[] = {
+	{ .uuid = MEI_GUID_MKHI, .version = MEI_CL_VERSION_ANY },
+	{ }
+};
+MODULE_DEVICE_TABLE(mei, mei_late_bind_tbl);
+
+static struct mei_cl_driver mei_late_bind_driver = {
+	.id_table = mei_late_bind_tbl,
+	.name = KBUILD_MODNAME,
+	.probe = mei_late_bind_probe,
+	.remove	= mei_late_bind_remove,
+};
+
+module_mei_cl_driver(mei_late_bind_driver);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MEI Late Binding");
diff --git a/include/drm/intel/i915_component.h b/include/drm/intel/i915_component.h
index 4ea3b17aa143..456849a97d75 100644
--- a/include/drm/intel/i915_component.h
+++ b/include/drm/intel/i915_component.h
@@ -31,6 +31,7 @@ enum i915_component_type {
 	I915_COMPONENT_HDCP,
 	I915_COMPONENT_PXP,
 	I915_COMPONENT_GSC_PROXY,
+	INTEL_COMPONENT_LATE_BIND,
 };
 
 /* MAX_PORT is the number of port
diff --git a/include/drm/intel/late_bind_mei_interface.h b/include/drm/intel/late_bind_mei_interface.h
new file mode 100644
index 000000000000..ad5f21330087
--- /dev/null
+++ b/include/drm/intel/late_bind_mei_interface.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (c) 2025 Intel Corporation
+ */
+
+#ifndef _LATE_BIND_MEI_INTERFACE_H_
+#define _LATE_BIND_MEI_INTERFACE_H_
+
+#include <linux/types.h>
+
+struct device;
+struct module;
+
+/**
+ * Late Binding flags
+ * Persistent across warm reset
+ */
+#define CSC_LATE_BINDING_FLAGS_IS_PERSISTENT	BIT(0)
+
+/**
+ * xe_late_bind_fw_type - enum to determine late binding fw type
+ */
+enum late_bind_type {
+	CSC_LATE_BINDING_TYPE_FAN_CONTROL = 1,
+};
+
+/**
+ * Late Binding payload status
+ */
+enum csc_late_binding_status {
+	CSC_LATE_BINDING_STATUS_SUCCESS           = 0,
+	CSC_LATE_BINDING_STATUS_4ID_MISMATCH      = 1,
+	CSC_LATE_BINDING_STATUS_ARB_FAILURE       = 2,
+	CSC_LATE_BINDING_STATUS_GENERAL_ERROR     = 3,
+	CSC_LATE_BINDING_STATUS_INVALID_PARAMS    = 4,
+	CSC_LATE_BINDING_STATUS_INVALID_SIGNATURE = 5,
+	CSC_LATE_BINDING_STATUS_INVALID_PAYLOAD   = 6,
+	CSC_LATE_BINDING_STATUS_TIMEOUT           = 7,
+};
+
+/**
+ * struct late_bind_component_ops - ops for Late Binding services.
+ * @owner: Module providing the ops
+ * @push_config: Sends a config to FW.
+ */
+struct late_bind_component_ops {
+	/**
+	 * @push_config: Sends a config to FW.
+	 * @dev: device struct corresponding to the mei device
+	 * @type: payload type
+	 * @flags: payload flags
+	 * @payload: payload buffer
+	 * @payload_size: payload buffer size
+	 *
+	 * Return: 0 success, negative errno value on transport failure,
+	 *         positive status returned by FW
+	 */
+	int (*push_config)(struct device *dev, u32 type, u32 flags,
+			   const void *payload, size_t payload_size);
+};
+
+#endif /* _LATE_BIND_MEI_INTERFACE_H_ */
-- 
2.34.1


