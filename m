Return-Path: <linux-kernel+bounces-838369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 006DFBAF092
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6864C02B6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F2927E05E;
	Wed,  1 Oct 2025 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFnUcCkM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6E27B34A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287305; cv=none; b=nzOrXKM2vk1eCZIrvYO+I48aIuiq5mlvKGLEr0auAYD3OgmJCm2xH4czLinRxuzA+gmg9mplGuvc6Jn7sbwoQyJcFSp0AGIHpNjorLCIkfBR75OCfCYJBf1n6gioSsBEcQFAv1Ca6vnOcRzAWdIhCAM7oPqvA9xrQpW3vLnuStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287305; c=relaxed/simple;
	bh=Necu2utP6C1MSshjc1bV8CGQp56cbkE2uL9gSCv/kUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9fqTNjL12hQSjwKmnUBIA8uWvyALaClSipKFF++qGHWHNaBxQBXcb4+g7bhCbfzDO+CmEGbhWQxy/qmWRMi24nhgMEMawDuaVtnl1vrbbQqE1aFEcrGsWgYpOxDupApbfRHOH5qmFEi+cjB8D1gPEhF0B8uGRY+gpBZ8LaccJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oFnUcCkM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287304; x=1790823304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Necu2utP6C1MSshjc1bV8CGQp56cbkE2uL9gSCv/kUQ=;
  b=oFnUcCkMJ9eYIJvXAMObsCr4JlTR2xLsaC2SvuHFzobaQnJg3ksBfRRi
   WgEky7ER//GlOKFQUUjmCTo+EkiiBDIJwxa/x5zelXvOawogEyqUOqY4v
   NCIagFcx70cDMu+ZdIBzhroWla7waoa9csYlC4MIiFDcqQr3lYdsvDf8S
   GiLrBKJyAl2qpzuD8Rg+WhDaISVA1wbW4BmFZGceqoRq1uGQRv7bs9K4J
   rMfXyl5KyZZCRIsQclyDVmBCZkeNaepKyrF+J0Ni60sV/qhsaF9nd0t2c
   WsMp5IQTNCmrXP9TeeGqiVHVUjQciHLJFaN/NwjDdPXdhDBl7hgWBqo7Q
   A==;
X-CSE-ConnectionGUID: AuKOtvolTDCVZgrjvxh08A==
X-CSE-MsgGUID: DWdkEBqkR/eqvsMh7hPm1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662279"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662279"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:04 -0700
X-CSE-ConnectionGUID: Ta4MbWwoQYe26SZPo5U+IA==
X-CSE-MsgGUID: pP/yvJQRQQ6xHe4fFOGFKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629117"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:03 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	reinette.chatre@intel.com,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	dan.j.williams@intel.com,
	yilun.xu@linux.intel.com,
	sagis@google.com,
	vannapurve@google.com,
	paulmck@kernel.org,
	nik.borisov@suse.com
Cc: Chao Gao <chao.gao@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v2 07/21] coco/tdx-host: Expose P-SEAMLDR information via sysfs
Date: Tue, 30 Sep 2025 19:52:51 -0700
Message-ID: <20251001025442.427697-8-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001025442.427697-1-chao.gao@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TDX Module updates require userspace to select the appropriate module
to load. Expose necessary information to facilitate this decision. Two
values are needed:

- P-SEAMLDR version: for compatibility checks between TDX Module and
		     P-SEAMLDR
- num_remaining_updates: indicates how many updates can be performed

Expose them as tdx-host device attributes.

Note that P-SEAMLDR sysfs nodes are hidden when INTEL_TDX_MODULE_UPDATE
isn't enabled or when P-SEAMLDR isn't loaded by BIOS, both of which
cause seamldr_get_info() to return NULL.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
 .../ABI/testing/sysfs-devices-faux-tdx-host   | 25 ++++++++
 drivers/virt/coco/tdx-host/tdx-host.c         | 63 ++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
index 18d4a4a71b80..13c1f4f9909c 100644
--- a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
+++ b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
@@ -4,3 +4,28 @@ Description:	(RO) Report the version of the loaded TDX module. The TDX module
 		version is formatted as x.y.z, where "x" is the major version,
 		"y" is the minor version and "z" is the update version. Versions
 		are used for bug reporting, TD-Preserving updates and etc.
+
+What:		/sys/devices/faux/tdx_host/seamldr/version
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Report the version of the loaded SEAM loader. The SEAM
+		loader version is formatted as x.y.z, where "x" is the major
+		version, "y" is the minor version and "z" is the update version.
+		Versions are used for bug reporting and compatibility check.
+
+What:		/sys/devices/faux/tdx_host/seamldr/num_remaining_updates
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Report the number of remaining updates that can be performed.
+		The CPU keeps track of TCB versions for each TDX Module that
+		has been loaded. Since this tracking database has finite
+		capacity, there's a maximum number of module updates that can
+		be performed.
+
+		After each successful update, the number reduces by one. Once it
+		reaches zero, further updates will fail until next reboot. The
+		number is always zero if P-SEAMLDR doesn't support updates.
+
+		See Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
+		Interface Specification Chapter 3.3 "SEAMLDR_INFO" and Chapter
+		4.2 "SEAMLDR.INSTALL" for more information. The documentation is
+		available at:
+		https://cdrdv2-public.intel.com/739045/intel-tdx-seamldr-interface-specification.pdf
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 968a19f4e01a..42570c5b221b 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -11,6 +11,7 @@
 #include <linux/sysfs.h>
 #include <linux/device/faux.h>
 #include <asm/cpu_device_id.h>
+#include <asm/seamldr.h>
 #include <asm/tdx.h>
 #include <asm/tdx_global_metadata.h>
 
@@ -43,7 +44,67 @@ static struct attribute *tdx_host_attrs[] = {
 	&dev_attr_version.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(tdx_host);
+
+struct attribute_group tdx_host_group = {
+	.attrs = tdx_host_attrs,
+};
+
+static ssize_t seamldr_version_show(struct device *dev, struct device_attribute *attr,
+				    char *buf)
+{
+	const struct seamldr_info *info = seamldr_get_info();
+
+	if (!info)
+		return -ENXIO;
+
+	return sysfs_emit(buf, "%u.%u.%u\n", info->major_version,
+					     info->minor_version,
+					     info->update_version);
+}
+
+static ssize_t num_remaining_updates_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	const struct seamldr_info *info = seamldr_get_info();
+
+	if (!info)
+		return -ENXIO;
+
+	return sysfs_emit(buf, "%u\n", info->num_remaining_updates);
+}
+
+/*
+ * Open-code DEVICE_ATTR_RO to specify a different 'show' function for
+ * P-SEAMLDR version as version_show() is used for the TDX Module version.
+ */
+static struct device_attribute dev_attr_seamldr_version =
+	__ATTR(version, 0444, seamldr_version_show, NULL);
+static DEVICE_ATTR_RO(num_remaining_updates);
+
+static struct attribute *seamldr_attrs[] = {
+	&dev_attr_seamldr_version.attr,
+	&dev_attr_num_remaining_updates.attr,
+	NULL,
+};
+
+static umode_t seamldr_group_is_visible(struct kobject *kobj,
+					struct attribute *attr, int n)
+{
+	return seamldr_get_info() ? attr->mode : 0;
+}
+
+static struct attribute_group seamldr_group = {
+	.name = "seamldr",
+	.attrs = seamldr_attrs,
+	.is_visible = seamldr_group_is_visible,
+};
+
+static const struct attribute_group *tdx_host_groups[] = {
+	&tdx_host_group,
+	&seamldr_group,
+	NULL,
+};
 
 static int __init tdx_host_init(void)
 {
-- 
2.47.3


