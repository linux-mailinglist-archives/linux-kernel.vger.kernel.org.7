Return-Path: <linux-kernel+bounces-667609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22091AC872E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 06:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510CDA2525F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 04:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D91211A05;
	Fri, 30 May 2025 04:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DgqXRFzU"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4A31DE88C
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748577815; cv=none; b=WW9l0WicIe3BPPBMiPQWTtSHGRELVHJmDvyQhXhaJnebnwBmaLZrv39r11JMeHR0QH04GPOyVS95X8mT79qVMgdk5eehDaLGdA8dW9q7O4dYj4OUP/1ms5JMADtgK1BVPeyrwPcwegoMYSg/FOSICZ0dNqVXw0KRdXJxl3gnw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748577815; c=relaxed/simple;
	bh=eAu0U5Klqvc7tRBdl2Mdni3Wjy3EAmOY+KbuV5j0eTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QkBe5+Rlot4PT//rGlHXMSkSU/dSD5IKWsA44el2buFpBK/zmWHLf0xf0QGIcxMM+bnS9+PfA/QvyAhDw31UTDg9nk/l2/MG67Hh2aCwDmc2OelMekDH7AT54NJt5AU54QTMbRcFi3ON2pr2MkcceBWnzAfVqug1TlUR57Z+bVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DgqXRFzU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1748577803;
	bh=eAu0U5Klqvc7tRBdl2Mdni3Wjy3EAmOY+KbuV5j0eTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DgqXRFzU3Snz88+EIqONLXP7DfUUflI2dk14rpsOCKNSH4rcK19buEMOGje5uoTxL
	 GhRRRCnSyM5STE4UBuSONLnTj2NxSbkruXzJKp/4rJgG8lbxdEK1wLZYNoDdeEQj70
	 uHv5OA8KvqlwsYJnGZxtUSl+MOfv8Q1NHI/tt938=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 30 May 2025 05:54:38 +0200
Subject: [PATCH v3 4/6] sysfs: treewide: switch back to
 attribute_group::bin_attrs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250530-sysfs-const-bin_attr-final-v3-4-724bfcf05b99@weissschuh.net>
References: <20250530-sysfs-const-bin_attr-final-v3-0-724bfcf05b99@weissschuh.net>
In-Reply-To: <20250530-sysfs-const-bin_attr-final-v3-0-724bfcf05b99@weissschuh.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748577802; l=49366;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=eAu0U5Klqvc7tRBdl2Mdni3Wjy3EAmOY+KbuV5j0eTc=;
 b=L18fdiXXTJpgW24doxp5FG79uRNWhIMjJKqMJs5EiC4Wfc3Z/zlW25cIBwpLcN7qZAq9QJKBu
 tRFMKhNkkA+B1dWp4awPL1iFsNk5SGuPfZtkwADkiCwAAMSKOzTwOIx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The normal bin_attrs field can now handle const pointers.
This makes the _new variant unnecessary.
Switch all users back.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/powerpc/kernel/secvar-sysfs.c             |  2 +-
 arch/powerpc/perf/hv-24x7.c                    |  2 +-
 arch/powerpc/platforms/powernv/opal-core.c     |  2 +-
 arch/s390/kernel/cpacf.c                       |  2 +-
 arch/s390/kernel/ipl.c                         | 18 +++++++++---------
 arch/s390/pci/pci_sysfs.c                      |  2 +-
 arch/x86/kernel/ksysfs.c                       |  4 ++--
 drivers/accel/habanalabs/common/sysfs.c        |  2 +-
 drivers/acpi/bgrt.c                            |  2 +-
 drivers/base/devcoredump.c                     |  2 +-
 drivers/base/firmware_loader/sysfs.c           |  2 +-
 drivers/base/node.c                            |  2 +-
 drivers/base/topology.c                        |  2 +-
 drivers/cxl/port.c                             |  2 +-
 drivers/firmware/google/cbmem.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        |  2 +-
 drivers/gpu/drm/drm_sysfs.c                    |  2 +-
 drivers/hid/hid-core.c                         |  2 +-
 drivers/hid/hid-roccat-arvo.c                  |  2 +-
 drivers/hid/hid-roccat-isku.c                  |  2 +-
 drivers/hid/hid-roccat-kone.c                  |  2 +-
 drivers/hid/hid-roccat-koneplus.c              |  2 +-
 drivers/hid/hid-roccat-konepure.c              |  2 +-
 drivers/hid/hid-roccat-kovaplus.c              |  2 +-
 drivers/hid/hid-roccat-pyra.c                  |  2 +-
 drivers/hid/hid-roccat-ryos.c                  |  2 +-
 drivers/hid/hid-roccat-savu.c                  |  2 +-
 drivers/iio/imu/bno055/bno055.c                |  2 +-
 drivers/infiniband/hw/hfi1/sysfs.c             |  2 +-
 drivers/infiniband/hw/qib/qib_sysfs.c          |  2 +-
 drivers/input/touchscreen/goodix_berlin_core.c |  2 +-
 drivers/leds/led-class.c                       |  2 +-
 drivers/misc/c2port/core.c                     |  2 +-
 drivers/mtd/spi-nor/sysfs.c                    |  2 +-
 drivers/nvmem/core.c                           |  4 ++--
 drivers/pci/p2pdma.c                           |  2 +-
 drivers/pci/pci-sysfs.c                        |  4 ++--
 drivers/pci/vpd.c                              |  2 +-
 drivers/platform/chrome/cros_ec_vbc.c          |  2 +-
 drivers/platform/x86/amd/hsmp/acpi.c           |  2 +-
 drivers/platform/x86/amd/hsmp/plat.c           |  2 +-
 drivers/platform/x86/dell/dcdbas.c             |  2 +-
 drivers/platform/x86/dell/dell_rbu.c           |  2 +-
 drivers/platform/x86/intel/sdsi.c              |  2 +-
 drivers/platform/x86/wmi-bmof.c                |  2 +-
 drivers/power/supply/ds2760_battery.c          |  2 +-
 drivers/power/supply/ds2780_battery.c          |  2 +-
 drivers/power/supply/ds2781_battery.c          |  2 +-
 drivers/power/supply/olpc_battery.c            |  2 +-
 drivers/ptp/ptp_ocp.c                          |  2 +-
 drivers/rapidio/rio-sysfs.c                    |  2 +-
 drivers/s390/cio/chp.c                         |  2 +-
 drivers/s390/crypto/pkey_sysfs.c               |  8 ++++----
 drivers/scsi/scsi_sysfs.c                      |  2 +-
 drivers/usb/core/sysfs.c                       |  2 +-
 drivers/usb/usbip/vudc_sysfs.c                 |  2 +-
 drivers/virt/coco/guest/tsm-mr.c               |  4 ++--
 drivers/w1/slaves/w1_ds2408.c                  |  2 +-
 drivers/w1/slaves/w1_ds2413.c                  |  2 +-
 drivers/w1/slaves/w1_ds2430.c                  |  2 +-
 drivers/w1/slaves/w1_ds2431.c                  |  2 +-
 drivers/w1/slaves/w1_ds2433.c                  |  4 ++--
 drivers/w1/slaves/w1_ds2438.c                  |  2 +-
 drivers/w1/slaves/w1_ds2780.c                  |  2 +-
 drivers/w1/slaves/w1_ds2781.c                  |  2 +-
 drivers/w1/slaves/w1_ds28e04.c                 |  2 +-
 drivers/w1/w1.c                                |  2 +-
 drivers/zorro/zorro-sysfs.c                    |  2 +-
 kernel/module/sysfs.c                          | 10 +++++-----
 mm/page_idle.c                                 |  2 +-
 71 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
index afb690a172b4e281830d0dd18785f70e0a967d13..ec900bce0257feedf721a954e9043e65fddc48ff 100644
--- a/arch/powerpc/kernel/secvar-sysfs.c
+++ b/arch/powerpc/kernel/secvar-sysfs.c
@@ -121,7 +121,7 @@ static struct attribute *secvar_attrs[] = {
 
 static const struct attribute_group secvar_attr_group = {
 	.attrs = secvar_attrs,
-	.bin_attrs_new = secvar_bin_attrs,
+	.bin_attrs = secvar_bin_attrs,
 };
 __ATTRIBUTE_GROUPS(secvar_attr);
 
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index b0768f3d289300826dcd454a8e397a943572fd45..681cf85af2b327785acfa64bfce13c37cabacba3 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1141,7 +1141,7 @@ static struct attribute *if_attrs[] = {
 
 static const struct attribute_group if_group = {
 	.name = "interface",
-	.bin_attrs_new = if_bin_attrs,
+	.bin_attrs = if_bin_attrs,
 	.attrs = if_attrs,
 };
 
diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
index 6fe121aae4053d3f28fe07e12a3219e2e79758ad..784602a48afba5c4e5447bcda00f05f991769cbb 100644
--- a/arch/powerpc/platforms/powernv/opal-core.c
+++ b/arch/powerpc/platforms/powernv/opal-core.c
@@ -607,7 +607,7 @@ static const struct bin_attribute *const mpipl_bin_attr[] = {
 
 static const struct attribute_group mpipl_group = {
 	.attrs = mpipl_attr,
-	.bin_attrs_new =  mpipl_bin_attr,
+	.bin_attrs =  mpipl_bin_attr,
 };
 
 static int __init opalcore_init(void)
diff --git a/arch/s390/kernel/cpacf.c b/arch/s390/kernel/cpacf.c
index 4b9b34f95d729806d416279b93ccb5a20e4406a7..3bebc47beeab680c53a713fee1435e22125eab3c 100644
--- a/arch/s390/kernel/cpacf.c
+++ b/arch/s390/kernel/cpacf.c
@@ -101,7 +101,7 @@ static const struct bin_attribute *const cpacf_attrs[] = {
 
 static const struct attribute_group cpacf_attr_grp = {
 	.name = "cpacf",
-	.bin_attrs_new = cpacf_attrs,
+	.bin_attrs = cpacf_attrs,
 };
 
 static int __init cpacf_init(void)
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index ff15f91affdea4bf3d80f76b1c188ea491804e46..961a3d60a4dddabddabf196b30890681f3604504 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -596,7 +596,7 @@ static struct attribute *ipl_fcp_attrs[] = {
 
 static const struct attribute_group ipl_fcp_attr_group = {
 	.attrs = ipl_fcp_attrs,
-	.bin_attrs_new = ipl_fcp_bin_attrs,
+	.bin_attrs = ipl_fcp_bin_attrs,
 };
 
 static struct attribute *ipl_nvme_attrs[] = {
@@ -610,7 +610,7 @@ static struct attribute *ipl_nvme_attrs[] = {
 
 static const struct attribute_group ipl_nvme_attr_group = {
 	.attrs = ipl_nvme_attrs,
-	.bin_attrs_new = ipl_nvme_bin_attrs,
+	.bin_attrs = ipl_nvme_bin_attrs,
 };
 
 static struct attribute *ipl_eckd_attrs[] = {
@@ -623,7 +623,7 @@ static struct attribute *ipl_eckd_attrs[] = {
 
 static const struct attribute_group ipl_eckd_attr_group = {
 	.attrs = ipl_eckd_attrs,
-	.bin_attrs_new = ipl_eckd_bin_attrs,
+	.bin_attrs = ipl_eckd_bin_attrs,
 };
 
 /* CCW ipl device attributes */
@@ -920,7 +920,7 @@ static struct attribute *reipl_fcp_attrs[] = {
 
 static const struct attribute_group reipl_fcp_attr_group = {
 	.attrs = reipl_fcp_attrs,
-	.bin_attrs_new = reipl_fcp_bin_attrs,
+	.bin_attrs = reipl_fcp_bin_attrs,
 };
 
 static struct kobj_attribute sys_reipl_fcp_clear_attr =
@@ -958,7 +958,7 @@ static struct attribute *reipl_nvme_attrs[] = {
 
 static const struct attribute_group reipl_nvme_attr_group = {
 	.attrs = reipl_nvme_attrs,
-	.bin_attrs_new = reipl_nvme_bin_attrs
+	.bin_attrs = reipl_nvme_bin_attrs
 };
 
 static ssize_t reipl_nvme_clear_show(struct kobject *kobj,
@@ -1051,7 +1051,7 @@ static struct attribute *reipl_eckd_attrs[] = {
 
 static const struct attribute_group reipl_eckd_attr_group = {
 	.attrs = reipl_eckd_attrs,
-	.bin_attrs_new = reipl_eckd_bin_attrs
+	.bin_attrs = reipl_eckd_bin_attrs
 };
 
 static ssize_t reipl_eckd_clear_show(struct kobject *kobj,
@@ -1596,7 +1596,7 @@ static const struct bin_attribute *const dump_fcp_bin_attrs[] = {
 static const struct attribute_group dump_fcp_attr_group = {
 	.name  = IPL_FCP_STR,
 	.attrs = dump_fcp_attrs,
-	.bin_attrs_new = dump_fcp_bin_attrs,
+	.bin_attrs = dump_fcp_bin_attrs,
 };
 
 /* NVME dump device attributes */
@@ -1630,7 +1630,7 @@ static const struct bin_attribute *const dump_nvme_bin_attrs[] = {
 static const struct attribute_group dump_nvme_attr_group = {
 	.name  = IPL_NVME_STR,
 	.attrs = dump_nvme_attrs,
-	.bin_attrs_new = dump_nvme_bin_attrs,
+	.bin_attrs = dump_nvme_bin_attrs,
 };
 
 /* ECKD dump device attributes */
@@ -1664,7 +1664,7 @@ static const struct bin_attribute *const dump_eckd_bin_attrs[] = {
 static const struct attribute_group dump_eckd_attr_group = {
 	.name  = IPL_ECKD_STR,
 	.attrs = dump_eckd_attrs,
-	.bin_attrs_new = dump_eckd_bin_attrs,
+	.bin_attrs = dump_eckd_bin_attrs,
 };
 
 /* CCW dump device attributes */
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index 0ecad08e1b1eeb444b712cc69cbf18ed328060b9..0ee0924cfab7e5d22468fb197ee78cac679d8c13 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -218,7 +218,7 @@ static struct attribute *zpci_dev_attrs[] = {
 
 const struct attribute_group zpci_attr_group = {
 	.attrs = zpci_dev_attrs,
-	.bin_attrs_new = zpci_bin_attrs,
+	.bin_attrs = zpci_bin_attrs,
 };
 
 static struct attribute *pfip_attrs[] = {
diff --git a/arch/x86/kernel/ksysfs.c b/arch/x86/kernel/ksysfs.c
index 4ee7fd9dd69c46cf9a0e9205585d3f898122db96..d547de9b3ed80c85536cbd11a52327be383d545e 100644
--- a/arch/x86/kernel/ksysfs.c
+++ b/arch/x86/kernel/ksysfs.c
@@ -56,7 +56,7 @@ static const struct bin_attribute *const boot_params_data_attrs[] = {
 
 static const struct attribute_group boot_params_attr_group = {
 	.attrs = boot_params_version_attrs,
-	.bin_attrs_new = boot_params_data_attrs,
+	.bin_attrs = boot_params_data_attrs,
 };
 
 static int kobj_to_setup_data_nr(struct kobject *kobj, int *nr)
@@ -265,7 +265,7 @@ static const struct bin_attribute *const setup_data_data_attrs[] = {
 
 static const struct attribute_group setup_data_attr_group = {
 	.attrs = setup_data_type_attrs,
-	.bin_attrs_new = setup_data_data_attrs,
+	.bin_attrs = setup_data_data_attrs,
 };
 
 static int __init create_setup_data_node(struct kobject *parent,
diff --git a/drivers/accel/habanalabs/common/sysfs.c b/drivers/accel/habanalabs/common/sysfs.c
index 678585cfef848b4222aac82c80a7d39a4148efb2..82f66520ec18b9f07c029c3d62d202057cad706a 100644
--- a/drivers/accel/habanalabs/common/sysfs.c
+++ b/drivers/accel/habanalabs/common/sysfs.c
@@ -479,7 +479,7 @@ static const struct bin_attribute *const hl_dev_bin_attrs[] = {
 
 static struct attribute_group hl_dev_attr_group = {
 	.attrs = hl_dev_attrs,
-	.bin_attrs_new = hl_dev_bin_attrs,
+	.bin_attrs = hl_dev_bin_attrs,
 };
 
 static struct attribute_group hl_dev_clks_attr_group;
diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
index 35ece8e9f15d1d15c224fb6879d48730898fa3df..0fdd581ef96fb6aedf2a881527a01142de3dfccf 100644
--- a/drivers/acpi/bgrt.c
+++ b/drivers/acpi/bgrt.c
@@ -47,7 +47,7 @@ static const struct bin_attribute *const bgrt_bin_attributes[] = {
 
 static const struct attribute_group bgrt_attribute_group = {
 	.attrs = bgrt_attributes,
-	.bin_attrs_new = bgrt_bin_attributes,
+	.bin_attrs = bgrt_bin_attributes,
 };
 
 int __init acpi_parse_bgrt(struct acpi_table_header *table)
diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 03a39c417dc41730e040e3d36ba8ee379f6086f7..37faf6156d7c88d8d9b11b0b81747a220fc53e07 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -140,7 +140,7 @@ static const struct bin_attribute *const devcd_dev_bin_attrs[] = {
 };
 
 static const struct attribute_group devcd_dev_group = {
-	.bin_attrs_new = devcd_dev_bin_attrs,
+	.bin_attrs = devcd_dev_bin_attrs,
 };
 
 static const struct attribute_group *devcd_dev_groups[] = {
diff --git a/drivers/base/firmware_loader/sysfs.c b/drivers/base/firmware_loader/sysfs.c
index c9b1564616f451d3913f2a3d07a2b20ffe2e39f3..add0b9b75eddc99132c9650cd7e3b132e40504bd 100644
--- a/drivers/base/firmware_loader/sysfs.c
+++ b/drivers/base/firmware_loader/sysfs.c
@@ -381,7 +381,7 @@ static const struct bin_attribute *const fw_dev_bin_attrs[] = {
 
 static const struct attribute_group fw_dev_attr_group = {
 	.attrs = fw_dev_attrs,
-	.bin_attrs_new = fw_dev_bin_attrs,
+	.bin_attrs = fw_dev_bin_attrs,
 #ifdef CONFIG_FW_UPLOAD
 	.is_visible = fw_upload_is_visible,
 #endif
diff --git a/drivers/base/node.c b/drivers/base/node.c
index c19094481630d8e87e39b6bef8685bca6f760c51..9328b81c2f471bbc647970cdee7a30e087714483 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -597,7 +597,7 @@ static const struct bin_attribute *node_dev_bin_attrs[] = {
 
 static const struct attribute_group node_dev_group = {
 	.attrs = node_dev_attrs,
-	.bin_attrs_new = node_dev_bin_attrs,
+	.bin_attrs = node_dev_bin_attrs,
 };
 
 static const struct attribute_group *node_dev_groups[] = {
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 8b42df05feffada71febacf6693efc043fb356c0..c890e2a5b42801ed018f2a93eba13febb233cbce 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -179,7 +179,7 @@ static umode_t topology_is_visible(struct kobject *kobj,
 
 static const struct attribute_group topology_attr_group = {
 	.attrs = default_attrs,
-	.bin_attrs_new = bin_attrs,
+	.bin_attrs = bin_attrs,
 	.is_visible = topology_is_visible,
 	.name = "topology"
 };
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index fe4b593331da050bab9503063a334c12149ac25f..cf32dc50b7a61c3a9dd3f6a8f1bff80d26454f0d 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -181,7 +181,7 @@ static const struct bin_attribute *const cxl_cdat_bin_attributes[] = {
 };
 
 static const struct attribute_group cxl_cdat_attribute_group = {
-	.bin_attrs_new = cxl_cdat_bin_attributes,
+	.bin_attrs = cxl_cdat_bin_attributes,
 	.is_bin_visible = cxl_port_bin_attr_is_visible,
 };
 
diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/google/cbmem.c
index 773d05078e0ae0763591a6d9cfa0d55ea5fff611..54c3b8b05e5d633b1185b22cf3a0a693eaa6f7c2 100644
--- a/drivers/firmware/google/cbmem.c
+++ b/drivers/firmware/google/cbmem.c
@@ -86,7 +86,7 @@ static const struct bin_attribute *const bin_attrs[] = {
 
 static const struct attribute_group cbmem_entry_group = {
 	.attrs = attrs,
-	.bin_attrs_new = bin_attrs,
+	.bin_attrs = bin_attrs,
 };
 
 static const struct attribute_group *dev_groups[] = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index be9f03bbcb36c5a6c7a355c677c3b6f4c255f96f..41c150ae4143857ef66a2a2ec41cdda4edbb43d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4181,7 +4181,7 @@ static umode_t amdgpu_bin_flash_attr_is_visible(struct kobject *kobj,
 
 const struct attribute_group amdgpu_flash_attr_group = {
 	.attrs = flash_attrs,
-	.bin_attrs_new = bin_flash_attrs,
+	.bin_attrs = bin_flash_attrs,
 	.is_bin_visible = amdgpu_bin_flash_attr_is_visible,
 	.is_visible = amdgpu_flash_attr_is_visible,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index de0944947eaf1e52c9f544fc3096fd9cc383d7d1..9c8829bd5a58ca504a27dc32f56b926b5f26611c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2124,7 +2124,7 @@ static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 		con->badpages_attr = bin_attr_gpu_vram_bad_pages;
 		sysfs_bin_attr_init(&con->badpages_attr);
 		bin_attrs[0] = &con->badpages_attr;
-		group.bin_attrs_new = bin_attrs;
+		group.bin_attrs = bin_attrs;
 	}
 
 	r = sysfs_create_group(&adev->dev->kobj, &group);
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 8d27ba7f0d83bcb5d32789cf46b4beec5a5715f6..a455c56dbbeb7774a6eb6b779de5f43cb261a12c 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -329,7 +329,7 @@ static const struct bin_attribute *const connector_bin_attrs[] = {
 
 static const struct attribute_group connector_dev_group = {
 	.attrs = connector_dev_attrs,
-	.bin_attrs_new = connector_bin_attrs,
+	.bin_attrs = connector_bin_attrs,
 };
 
 static const struct attribute_group *connector_dev_groups[] = {
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b348d0464314ca331da073128f0ec4e0a6a91ed1..b10a28a7554665028f9693cf7c1e07661e52d836 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2812,7 +2812,7 @@ static const struct bin_attribute *hid_dev_bin_attrs[] = {
 };
 static const struct attribute_group hid_dev_group = {
 	.attrs = hid_dev_attrs,
-	.bin_attrs_new = hid_dev_bin_attrs,
+	.bin_attrs = hid_dev_bin_attrs,
 };
 __ATTRIBUTE_GROUPS(hid_dev);
 
diff --git a/drivers/hid/hid-roccat-arvo.c b/drivers/hid/hid-roccat-arvo.c
index 3048297569c529d4ac8be5a26e75e0640e7cd53a..7b09adfa44a1ded5bc6940a853f0087345b24656 100644
--- a/drivers/hid/hid-roccat-arvo.c
+++ b/drivers/hid/hid-roccat-arvo.c
@@ -258,7 +258,7 @@ static const struct bin_attribute *const arvo_bin_attributes[] = {
 
 static const struct attribute_group arvo_group = {
 	.attrs = arvo_attrs,
-	.bin_attrs_new = arvo_bin_attributes,
+	.bin_attrs = arvo_bin_attributes,
 };
 
 static const struct attribute_group *arvo_groups[] = {
diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index 9fddc42f241b21328b58efa43ac6d1213b494ab1..339378771ed506a87ea4328e299774dc93363854 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -238,7 +238,7 @@ static const struct bin_attribute *const isku_bin_attributes[] = {
 
 static const struct attribute_group isku_group = {
 	.attrs = isku_attrs,
-	.bin_attrs_new = isku_bin_attributes,
+	.bin_attrs = isku_bin_attributes,
 };
 
 static const struct attribute_group *isku_groups[] = {
diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index af8ef42aca02809a934c3efe1b3c7eb8fbc4da54..fabc08efcfd8cbeac97a95ff937836b1da662719 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -646,7 +646,7 @@ static const struct bin_attribute *const kone_bin_attributes[] = {
 
 static const struct attribute_group kone_group = {
 	.attrs = kone_attrs,
-	.bin_attrs_new = kone_bin_attributes,
+	.bin_attrs = kone_bin_attributes,
 };
 
 static const struct attribute_group *kone_groups[] = {
diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
index c3f01f7b7e488d2aa21bf82a37601035fe3970a9..77d45d36421a6e108a355f0d9e9364f1ab7152a7 100644
--- a/drivers/hid/hid-roccat-koneplus.c
+++ b/drivers/hid/hid-roccat-koneplus.c
@@ -346,7 +346,7 @@ static const struct bin_attribute *const koneplus_bin_attributes[] = {
 
 static const struct attribute_group koneplus_group = {
 	.attrs = koneplus_attrs,
-	.bin_attrs_new = koneplus_bin_attributes,
+	.bin_attrs = koneplus_bin_attributes,
 };
 
 static const struct attribute_group *koneplus_groups[] = {
diff --git a/drivers/hid/hid-roccat-konepure.c b/drivers/hid/hid-roccat-konepure.c
index 7fb705789d4eca6c9eeab9b2fc2a1f615bad747e..027bfc55ef9ceacf3d476c8a3ac3472591fcb7e1 100644
--- a/drivers/hid/hid-roccat-konepure.c
+++ b/drivers/hid/hid-roccat-konepure.c
@@ -62,7 +62,7 @@ static const struct bin_attribute *const konepure_bin_attrs[] = {
 };
 
 static const struct attribute_group konepure_group = {
-	.bin_attrs_new = konepure_bin_attrs,
+	.bin_attrs = konepure_bin_attrs,
 };
 
 static const struct attribute_group *konepure_groups[] = {
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 7d625ed53c9f4b82490bc5b76a8e8263e4c8cadc..a66f1b4730f30ab269c1df572d4ae630076fc5f5 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -399,7 +399,7 @@ static const struct bin_attribute *const kovaplus_bin_attributes[] = {
 
 static const struct attribute_group kovaplus_group = {
 	.attrs = kovaplus_attrs,
-	.bin_attrs_new = kovaplus_bin_attributes,
+	.bin_attrs = kovaplus_bin_attributes,
 };
 
 static const struct attribute_group *kovaplus_groups[] = {
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index dbb9055853696bafad6266872f18819b5560a6c3..de2da6086e0b93080c4ba21b7b0437992adcc478 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -355,7 +355,7 @@ static const struct bin_attribute *const pyra_bin_attributes[] = {
 
 static const struct attribute_group pyra_group = {
 	.attrs = pyra_attrs,
-	.bin_attrs_new = pyra_bin_attributes,
+	.bin_attrs = pyra_bin_attributes,
 };
 
 static const struct attribute_group *pyra_groups[] = {
diff --git a/drivers/hid/hid-roccat-ryos.c b/drivers/hid/hid-roccat-ryos.c
index 902dac1e714e16936d8ab7881b183b732cb1c110..36911c9da4fe30a1f6026577f9f16c78732f48f9 100644
--- a/drivers/hid/hid-roccat-ryos.c
+++ b/drivers/hid/hid-roccat-ryos.c
@@ -70,7 +70,7 @@ static const struct bin_attribute *const ryos_bin_attrs[] = {
 };
 
 static const struct attribute_group ryos_group = {
-	.bin_attrs_new = ryos_bin_attrs,
+	.bin_attrs = ryos_bin_attrs,
 };
 
 static const struct attribute_group *ryos_groups[] = {
diff --git a/drivers/hid/hid-roccat-savu.c b/drivers/hid/hid-roccat-savu.c
index 7399b8ffb5c7cae8110c8fb1a93f8b645f54f2eb..fb2e464c3ada8dea8b0f6b881679720f0dd37751 100644
--- a/drivers/hid/hid-roccat-savu.c
+++ b/drivers/hid/hid-roccat-savu.c
@@ -42,7 +42,7 @@ static const struct bin_attribute *const savu_bin_attrs[] = {
 };
 
 static const struct attribute_group savu_group = {
-	.bin_attrs_new = savu_bin_attrs,
+	.bin_attrs = savu_bin_attrs,
 };
 
 static const struct attribute_group *savu_groups[] = {
diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index 597c402b98dedf0c43248642e34748e9274b2e9d..574657db13f6fa2c3b7cc0cc626f7cc700d12932 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -1357,7 +1357,7 @@ static const struct bin_attribute *const bno055_bin_attrs[] = {
 
 static const struct attribute_group bno055_attrs_group = {
 	.attrs = bno055_attrs,
-	.bin_attrs_new = bno055_bin_attrs,
+	.bin_attrs = bno055_bin_attrs,
 };
 
 static const struct iio_info bno055_info = {
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index d94216c7d576f6418140e0d096314633aa42ab3b..372cfd13dc6160dd8905b8aa80e5ae953e576958 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -134,7 +134,7 @@ static struct attribute *port_cc_attributes[] = {
 static const struct attribute_group port_cc_group = {
 	.name = "CCMgtA",
 	.attrs = port_cc_attributes,
-	.bin_attrs_new = port_cc_bin_attributes,
+	.bin_attrs = port_cc_bin_attributes,
 };
 
 /* Start sc2vl */
diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 805e37dc7621179c94320759f8259144950c2e68..a6571bc38366e6884622c50c9d07c418b6ed9bb8 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -295,7 +295,7 @@ static umode_t qib_ccmgta_is_bin_visible(struct kobject *kobj,
 static const struct attribute_group port_ccmgta_attribute_group = {
 	.name = "CCMgtA",
 	.is_bin_visible = qib_ccmgta_is_bin_visible,
-	.bin_attrs_new = port_ccmgta_attributes,
+	.bin_attrs = port_ccmgta_attributes,
 };
 
 /* Start sl2vl */
diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
index 02a1d9a465f25b151ff4f38fed39931431363f07..c78d512d97cdb1612f484e445700090dd321a4c1 100644
--- a/drivers/input/touchscreen/goodix_berlin_core.c
+++ b/drivers/input/touchscreen/goodix_berlin_core.c
@@ -707,7 +707,7 @@ static const struct bin_attribute *const goodix_berlin_bin_attrs[] = {
 };
 
 static const struct attribute_group goodix_berlin_attr_group = {
-	.bin_attrs_new = goodix_berlin_bin_attrs,
+	.bin_attrs = goodix_berlin_bin_attrs,
 };
 
 const struct attribute_group *goodix_berlin_groups[] = {
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index c20ac8ccf52b7d79762a3aeea446389bad8443ea..58592593b8e953f17b0d2227b2d24f1a0383c2cc 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -91,7 +91,7 @@ static const struct bin_attribute *const led_trigger_bin_attrs[] = {
 	NULL,
 };
 static const struct attribute_group led_trigger_group = {
-	.bin_attrs_new = led_trigger_bin_attrs,
+	.bin_attrs = led_trigger_bin_attrs,
 };
 #endif
 
diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
index fc64474b8241b73df4937bd4bac5593fbb96016c..babdb60cc46c00cc9930a2dbe9c2f14a683fcb5b 100644
--- a/drivers/misc/c2port/core.c
+++ b/drivers/misc/c2port/core.c
@@ -888,7 +888,7 @@ static size_t c2port_bin_attr_size(struct kobject *kobj,
 
 static const struct attribute_group c2port_group = {
 	.attrs = c2port_attrs,
-	.bin_attrs_new = c2port_bin_attrs,
+	.bin_attrs = c2port_bin_attrs,
 	.bin_size = c2port_bin_attr_size,
 };
 
diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
index 4f12ff755df06cee04125efd5036245c51b49af4..643513ee891b7e5e1213a9be137024558a036117 100644
--- a/drivers/mtd/spi-nor/sysfs.c
+++ b/drivers/mtd/spi-nor/sysfs.c
@@ -104,7 +104,7 @@ static const struct attribute_group spi_nor_sysfs_group = {
 	.is_visible	= spi_nor_sysfs_is_visible,
 	.is_bin_visible	= spi_nor_sysfs_is_bin_visible,
 	.attrs		= spi_nor_sysfs_entries,
-	.bin_attrs_new	= spi_nor_sysfs_bin_entries,
+	.bin_attrs	= spi_nor_sysfs_bin_entries,
 };
 
 const struct attribute_group *spi_nor_sysfs_groups[] = {
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f0a664bcb01a0b43fb6ea9cd62cb01211277b931..1cd962312fa8ed1dd2ccba79d852f19db9196643 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -386,7 +386,7 @@ static const struct bin_attribute *const nvmem_bin_attributes[] = {
 };
 
 static const struct attribute_group nvmem_bin_group = {
-	.bin_attrs_new	= nvmem_bin_attributes,
+	.bin_attrs	= nvmem_bin_attributes,
 	.attrs		= nvmem_attrs,
 	.is_bin_visible = nvmem_bin_attr_is_visible,
 	.bin_size	= nvmem_bin_attr_size,
@@ -503,7 +503,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 		i++;
 	}
 
-	group.bin_attrs_new = pattrs;
+	group.bin_attrs = pattrs;
 
 	ret = device_add_group(&nvmem->dev, &group);
 	if (ret)
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 8d955c25aed36142258f82e0a6f8e803946392f4..da5657a020074e4ad59d3763ef6298f251d545a4 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -196,7 +196,7 @@ static const struct bin_attribute *const p2pmem_bin_attrs[] = {
 
 static const struct attribute_group p2pmem_group = {
 	.attrs = p2pmem_attrs,
-	.bin_attrs_new = p2pmem_bin_attrs,
+	.bin_attrs = p2pmem_bin_attrs,
 	.name = "p2pmem",
 };
 
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f2739eafef9bf1578a08beb67387865537ab6a3e..5eea14c1f7f5f704d43eed7e3a6d6136a4920679 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -857,7 +857,7 @@ static size_t pci_dev_config_attr_bin_size(struct kobject *kobj,
 }
 
 static const struct attribute_group pci_dev_config_attr_group = {
-	.bin_attrs_new = pci_dev_config_attrs,
+	.bin_attrs = pci_dev_config_attrs,
 	.bin_size = pci_dev_config_attr_bin_size,
 };
 
@@ -1377,7 +1377,7 @@ static size_t pci_dev_rom_attr_bin_size(struct kobject *kobj,
 }
 
 static const struct attribute_group pci_dev_rom_attr_group = {
-	.bin_attrs_new = pci_dev_rom_attrs,
+	.bin_attrs = pci_dev_rom_attrs,
 	.is_bin_visible = pci_dev_rom_attr_is_visible,
 	.bin_size = pci_dev_rom_attr_bin_size,
 };
diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 3d29b2602d0fb760b81c374036a506a4ddb4b281..153394a652d33a80db150c826bed348fb4fc542e 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -336,7 +336,7 @@ static umode_t vpd_attr_is_visible(struct kobject *kobj,
 }
 
 const struct attribute_group pci_dev_vpd_attr_group = {
-	.bin_attrs_new = vpd_attrs,
+	.bin_attrs = vpd_attrs,
 	.is_bin_visible = vpd_attr_is_visible,
 };
 
diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index 963c4db23055d8fd807ec72072b1ae0a95c1bbb0..5ee8adaa6564ea56ba2d5efea5c8b4eac1db8f5a 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -108,7 +108,7 @@ static const struct bin_attribute *const cros_ec_vbc_bin_attrs[] = {
 
 static const struct attribute_group cros_ec_vbc_attr_group = {
 	.name = "vbc",
-	.bin_attrs_new = cros_ec_vbc_bin_attrs,
+	.bin_attrs = cros_ec_vbc_bin_attrs,
 };
 
 static int cros_ec_vbc_probe(struct platform_device *pd)
diff --git a/drivers/platform/x86/amd/hsmp/acpi.c b/drivers/platform/x86/amd/hsmp/acpi.c
index 63af9dae02542cc4736c01559e18cebbf42a7e71..9155ce35a743767fadde66f7bd1bc92224143615 100644
--- a/drivers/platform/x86/amd/hsmp/acpi.c
+++ b/drivers/platform/x86/amd/hsmp/acpi.c
@@ -560,7 +560,7 @@ static struct attribute *hsmp_dev_attr_list[] = {
 };
 
 static const struct attribute_group hsmp_attr_grp = {
-	.bin_attrs_new = hsmp_attr_list,
+	.bin_attrs = hsmp_attr_list,
 	.attrs = hsmp_dev_attr_list,
 	.is_bin_visible = hsmp_is_sock_attr_visible,
 	.is_visible = hsmp_is_sock_dev_attr_visible,
diff --git a/drivers/platform/x86/amd/hsmp/plat.c b/drivers/platform/x86/amd/hsmp/plat.c
index b6dceca28bdb99dd5f83a7354cd22d8c7faaa684..e257fb0f41433fa9466e2ec57dbbe3bce810c394 100644
--- a/drivers/platform/x86/amd/hsmp/plat.c
+++ b/drivers/platform/x86/amd/hsmp/plat.c
@@ -110,7 +110,7 @@ HSMP_BIN_ATTR(7, *sock7_attr_list);
 
 #define HSMP_BIN_ATTR_GRP(index, _list, _name)			\
 static const struct attribute_group sock##index##_attr_grp = {	\
-	.bin_attrs_new = _list,					\
+	.bin_attrs = _list,					\
 	.is_bin_visible = hsmp_is_sock_attr_visible,		\
 	.name = #_name,						\
 }
diff --git a/drivers/platform/x86/dell/dcdbas.c b/drivers/platform/x86/dell/dcdbas.c
index 8149be25fa267ca027d809c45fe1c3f47fcfd453..678f44252a4537ec0ad9388ff3aeeeaf1075c870 100644
--- a/drivers/platform/x86/dell/dcdbas.c
+++ b/drivers/platform/x86/dell/dcdbas.c
@@ -662,7 +662,7 @@ static struct attribute *dcdbas_dev_attrs[] = {
 
 static const struct attribute_group dcdbas_attr_group = {
 	.attrs = dcdbas_dev_attrs,
-	.bin_attrs_new = dcdbas_bin_attrs,
+	.bin_attrs = dcdbas_bin_attrs,
 };
 
 static int dcdbas_probe(struct platform_device *dev)
diff --git a/drivers/platform/x86/dell/dell_rbu.c b/drivers/platform/x86/dell/dell_rbu.c
index e30ca325938cb604560a810e7d63f65b4b70964b..d74f2d47917cdf0846a6d27c24caae5ff27066d3 100644
--- a/drivers/platform/x86/dell/dell_rbu.c
+++ b/drivers/platform/x86/dell/dell_rbu.c
@@ -636,7 +636,7 @@ static const struct bin_attribute *const rbu_bin_attrs[] = {
 };
 
 static const struct attribute_group rbu_group = {
-	.bin_attrs_new = rbu_bin_attrs,
+	.bin_attrs = rbu_bin_attrs,
 };
 
 static int __init dcdrbu_init(void)
diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 30d1c2caf9842dbc355e7dea19f6446c56421228..da75f53d0bcc02dadbaf7740ac3b6ce4d4d4fe73 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -576,7 +576,7 @@ static struct attribute *sdsi_attrs[] = {
 
 static const struct attribute_group sdsi_group = {
 	.attrs = sdsi_attrs,
-	.bin_attrs_new = sdsi_bin_attrs,
+	.bin_attrs = sdsi_bin_attrs,
 	.is_bin_visible = sdsi_battr_is_visible,
 };
 __ATTRIBUTE_GROUPS(sdsi);
diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bmof.c
index 3e33da36da8ada3648b58b2579181fd2cd4bfff3..5b00370a9a22c3255329305f9e0439838d3b9a4d 100644
--- a/drivers/platform/x86/wmi-bmof.c
+++ b/drivers/platform/x86/wmi-bmof.c
@@ -46,7 +46,7 @@ static size_t bmof_bin_size(struct kobject *kobj, const struct bin_attribute *at
 
 static const struct attribute_group bmof_group = {
 	.bin_size = bmof_bin_size,
-	.bin_attrs_new = bmof_attrs,
+	.bin_attrs = bmof_attrs,
 };
 
 static const struct attribute_group *bmof_groups[] = {
diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index 5badf58c6edbce46208da1084607613df1d59e83..142c7492c3c22e09dec2fda33a3671cd20c6071c 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -209,7 +209,7 @@ static const struct bin_attribute *const w1_ds2760_bin_attrs[] = {
 };
 
 static const struct attribute_group w1_ds2760_group = {
-	.bin_attrs_new = w1_ds2760_bin_attrs,
+	.bin_attrs = w1_ds2760_bin_attrs,
 };
 
 static const struct attribute_group *w1_ds2760_groups[] = {
diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index 8352c6401cbfab1ea03a3f946d13e05cbb190b37..5b57bbba79d449f4620a5188af1480b9a58c7837 100644
--- a/drivers/power/supply/ds2780_battery.c
+++ b/drivers/power/supply/ds2780_battery.c
@@ -734,7 +734,7 @@ static const struct bin_attribute *const ds2780_sysfs_bin_attrs[] = {
 
 static const struct attribute_group ds2780_sysfs_group = {
 	.attrs = ds2780_sysfs_attrs,
-	.bin_attrs_new = ds2780_sysfs_bin_attrs,
+	.bin_attrs = ds2780_sysfs_bin_attrs,
 };
 
 static const struct attribute_group *ds2780_sysfs_groups[] = {
diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
index 43a6b022901e39fd1aedfc744dc84b64451de2cb..1319e02f3f95e9641c7aa4f6f5de43b586dcd351 100644
--- a/drivers/power/supply/ds2781_battery.c
+++ b/drivers/power/supply/ds2781_battery.c
@@ -737,7 +737,7 @@ static const struct bin_attribute *const ds2781_sysfs_bin_attrs[] = {
 
 static const struct attribute_group ds2781_sysfs_group = {
 	.attrs = ds2781_sysfs_attrs,
-	.bin_attrs_new = ds2781_sysfs_bin_attrs,
+	.bin_attrs = ds2781_sysfs_bin_attrs,
 
 };
 
diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/olpc_battery.c
index a9760dbb16163ffebab218d951662ab5e3331d11..202c4fa9b90392f65745ff35d116ace5f38f21d0 100644
--- a/drivers/power/supply/olpc_battery.c
+++ b/drivers/power/supply/olpc_battery.c
@@ -591,7 +591,7 @@ static const struct bin_attribute *const olpc_bat_sysfs_bin_attrs[] = {
 
 static const struct attribute_group olpc_bat_sysfs_group = {
 	.attrs = olpc_bat_sysfs_attrs,
-	.bin_attrs_new = olpc_bat_sysfs_bin_attrs,
+	.bin_attrs = olpc_bat_sysfs_bin_attrs,
 };
 
 static const struct attribute_group *olpc_bat_sysfs_groups[] = {
diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index ce804438c32d18572de220340aac4d5e2e495788..d3b341c339c82616d9d3e987063ec25cc02c5a9a 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3938,7 +3938,7 @@ static const struct bin_attribute *const bin_art_timecard_attrs[] = {
 
 static const struct attribute_group art_timecard_group = {
 	.attrs = art_timecard_attrs,
-	.bin_attrs_new = bin_art_timecard_attrs,
+	.bin_attrs = bin_art_timecard_attrs,
 };
 
 static const struct ocp_attr_group art_timecard_groups[] = {
diff --git a/drivers/rapidio/rio-sysfs.c b/drivers/rapidio/rio-sysfs.c
index 5e8c22677e460c4a774f36e90c50930b2a0e8987..0949c869b2f11de99ad80b9371127791a8ce297f 100644
--- a/drivers/rapidio/rio-sysfs.c
+++ b/drivers/rapidio/rio-sysfs.c
@@ -278,7 +278,7 @@ static umode_t rio_dev_is_attr_visible(struct kobject *kobj,
 static const struct attribute_group rio_dev_group = {
 	.attrs		= rio_dev_attrs,
 	.is_visible	= rio_dev_is_attr_visible,
-	.bin_attrs_new	= rio_dev_bin_attrs,
+	.bin_attrs	= rio_dev_bin_attrs,
 };
 
 const struct attribute_group *rio_dev_groups[] = {
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 4f01b1929240eb1f31f3b51875b18c8343548df8..caa300160b1756c5d22f53cf07f04cd5d4646c13 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -470,7 +470,7 @@ static struct attribute *chp_attrs[] = {
 };
 static const struct attribute_group chp_attr_group = {
 	.attrs = chp_attrs,
-	.bin_attrs_new = chp_bin_attrs,
+	.bin_attrs = chp_bin_attrs,
 };
 static const struct attribute_group *chp_attr_groups[] = {
 	&chp_attr_group,
diff --git a/drivers/s390/crypto/pkey_sysfs.c b/drivers/s390/crypto/pkey_sysfs.c
index cea77297364911097b1fd6a3bc64188a368529cd..792c0fce88fa04baba4d075d145835a626d00fb8 100644
--- a/drivers/s390/crypto/pkey_sysfs.c
+++ b/drivers/s390/crypto/pkey_sysfs.c
@@ -297,7 +297,7 @@ static const struct bin_attribute *const protkey_attrs[] = {
 
 static const struct attribute_group protkey_attr_group = {
 	.name	       = "protkey",
-	.bin_attrs_new = protkey_attrs,
+	.bin_attrs = protkey_attrs,
 };
 
 /*
@@ -406,7 +406,7 @@ static const struct bin_attribute *const ccadata_attrs[] = {
 
 static const struct attribute_group ccadata_attr_group = {
 	.name	       = "ccadata",
-	.bin_attrs_new = ccadata_attrs,
+	.bin_attrs = ccadata_attrs,
 };
 
 #define CCACIPHERTOKENSIZE	(sizeof(struct cipherkeytoken) + 80)
@@ -520,7 +520,7 @@ static const struct bin_attribute *const ccacipher_attrs[] = {
 
 static const struct attribute_group ccacipher_attr_group = {
 	.name	       = "ccacipher",
-	.bin_attrs_new = ccacipher_attrs,
+	.bin_attrs = ccacipher_attrs,
 };
 
 /*
@@ -635,7 +635,7 @@ static const struct bin_attribute *const ep11_attrs[] = {
 
 static const struct attribute_group ep11_attr_group = {
 	.name	   = "ep11",
-	.bin_attrs_new = ep11_attrs,
+	.bin_attrs = ep11_attrs,
 };
 
 const struct attribute_group *pkey_attr_groups[] = {
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index deba96107d20b987c0f75b0ec9b69fef27bb15eb..169af7d47ce76ba5e33fd5db2e94a35c53a42a8a 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1362,7 +1362,7 @@ static const struct bin_attribute *const scsi_sdev_bin_attrs[] = {
 };
 static struct attribute_group scsi_sdev_attr_group = {
 	.attrs =	scsi_sdev_attrs,
-	.bin_attrs_new = scsi_sdev_bin_attrs,
+	.bin_attrs = scsi_sdev_bin_attrs,
 	.is_visible =	scsi_sdev_attr_is_visible,
 	.is_bin_visible = scsi_sdev_bin_attr_is_visible,
 };
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 23f3cb1989f408ecb6b679e6cbe4857384188ae4..a07866f1060cf4f2ba336d80218f8102cdcdef2d 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -944,7 +944,7 @@ static umode_t dev_bin_attrs_are_visible(struct kobject *kobj,
 }
 
 static const struct attribute_group dev_bin_attr_grp = {
-	.bin_attrs_new =	dev_bin_attrs,
+	.bin_attrs =	dev_bin_attrs,
 	.is_bin_visible =	dev_bin_attrs_are_visible,
 };
 
diff --git a/drivers/usb/usbip/vudc_sysfs.c b/drivers/usb/usbip/vudc_sysfs.c
index 2aae3edfc81369e3f84aadec7050356a4347c104..47f3a7d51736cb09f835473dfe683b45e7114c5f 100644
--- a/drivers/usb/usbip/vudc_sysfs.c
+++ b/drivers/usb/usbip/vudc_sysfs.c
@@ -259,7 +259,7 @@ static const struct bin_attribute *const dev_bin_attrs[] = {
 
 static const struct attribute_group vudc_attr_group = {
 	.attrs = dev_attrs,
-	.bin_attrs_new = dev_bin_attrs,
+	.bin_attrs = dev_bin_attrs,
 };
 
 const struct attribute_group *vudc_groups[] = {
diff --git a/drivers/virt/coco/guest/tsm-mr.c b/drivers/virt/coco/guest/tsm-mr.c
index 74465e79be60d6838e628c3ea202d8bdc9831487..bc509df04db1d0351b0fb78ceeba28feeeb7201c 100644
--- a/drivers/virt/coco/guest/tsm-mr.c
+++ b/drivers/virt/coco/guest/tsm-mr.c
@@ -228,7 +228,7 @@ tsm_mr_create_attribute_group(const struct tsm_measurements *tm)
 
 	init_rwsem(&ctx->rwsem);
 	ctx->agrp.name = "measurements";
-	ctx->agrp.bin_attrs_new = no_free_ptr(attrs);
+	ctx->agrp.bin_attrs = no_free_ptr(attrs);
 	ctx->tm = tm;
 	return &no_free_ptr(ctx)->agrp;
 }
@@ -244,7 +244,7 @@ EXPORT_SYMBOL_GPL(tsm_mr_create_attribute_group);
 void tsm_mr_free_attribute_group(const struct attribute_group *attr_grp)
 {
 	if (!IS_ERR_OR_NULL(attr_grp)) {
-		kfree(attr_grp->bin_attrs_new);
+		kfree(attr_grp->bin_attrs);
 		kfree(container_of(attr_grp, struct tm_context, agrp));
 	}
 }
diff --git a/drivers/w1/slaves/w1_ds2408.c b/drivers/w1/slaves/w1_ds2408.c
index beccd2912d2aeb9a5f83cabba19c32946778a790..30d1d574d2e5de749e71fbb9203537c589657ec7 100644
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -328,7 +328,7 @@ static const struct bin_attribute *const w1_f29_bin_attrs[] = {
 };
 
 static const struct attribute_group w1_f29_group = {
-	.bin_attrs_new = w1_f29_bin_attrs,
+	.bin_attrs = w1_f29_bin_attrs,
 };
 
 static const struct attribute_group *w1_f29_groups[] = {
diff --git a/drivers/w1/slaves/w1_ds2413.c b/drivers/w1/slaves/w1_ds2413.c
index 5fa46017ca7cd8ae8ff657adaa9ed0e83f5d0e8b..94d3cd2a0ec9723c8dc1510039ab55075cd7efe8 100644
--- a/drivers/w1/slaves/w1_ds2413.c
+++ b/drivers/w1/slaves/w1_ds2413.c
@@ -137,7 +137,7 @@ static const struct bin_attribute *const w1_f3a_bin_attrs[] = {
 };
 
 static const struct attribute_group w1_f3a_group = {
-	.bin_attrs_new = w1_f3a_bin_attrs,
+	.bin_attrs = w1_f3a_bin_attrs,
 };
 
 static const struct attribute_group *w1_f3a_groups[] = {
diff --git a/drivers/w1/slaves/w1_ds2430.c b/drivers/w1/slaves/w1_ds2430.c
index ff56e2e68e583b3bb4df82c119e9325271342595..3d8c2b238aed3c9c1bbe683a96b36303d408a881 100644
--- a/drivers/w1/slaves/w1_ds2430.c
+++ b/drivers/w1/slaves/w1_ds2430.c
@@ -271,7 +271,7 @@ static const struct bin_attribute *const w1_f14_bin_attrs[] = {
 };
 
 static const struct attribute_group w1_f14_group = {
-	.bin_attrs_new = w1_f14_bin_attrs,
+	.bin_attrs = w1_f14_bin_attrs,
 };
 
 static const struct attribute_group *w1_f14_groups[] = {
diff --git a/drivers/w1/slaves/w1_ds2431.c b/drivers/w1/slaves/w1_ds2431.c
index 27b390fb59da11b610e1d126347ddba46a2f4f29..5749880b67c534ef085ae41bf9398272ad9de4bd 100644
--- a/drivers/w1/slaves/w1_ds2431.c
+++ b/drivers/w1/slaves/w1_ds2431.c
@@ -270,7 +270,7 @@ static const struct bin_attribute *const w1_f2d_bin_attrs[] = {
 };
 
 static const struct attribute_group w1_f2d_group = {
-	.bin_attrs_new = w1_f2d_bin_attrs,
+	.bin_attrs = w1_f2d_bin_attrs,
 };
 
 static const struct attribute_group *w1_f2d_groups[] = {
diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index a53eb34fea79fc7d815a6451b4ae4320eed2ea56..3371d804dc6cadb2426856c7a8a56a97883d0dc4 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -294,7 +294,7 @@ static const struct bin_attribute *const w1_f23_bin_attributes[] = {
 };
 
 static const struct attribute_group w1_f23_group = {
-	.bin_attrs_new = w1_f23_bin_attributes,
+	.bin_attrs = w1_f23_bin_attributes,
 };
 
 static const struct attribute_group *w1_f23_groups[] = {
@@ -308,7 +308,7 @@ static const struct bin_attribute *const w1_f43_bin_attributes[] = {
 };
 
 static const struct attribute_group w1_f43_group = {
-	.bin_attrs_new = w1_f43_bin_attributes,
+	.bin_attrs = w1_f43_bin_attributes,
 };
 
 static const struct attribute_group *w1_f43_groups[] = {
diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 630a6db5045e8c2985cae6fef684bb6f2081f95d..86860f727e9621a418f55123aadfabfe0cc15247 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -492,7 +492,7 @@ static const struct bin_attribute *const w1_ds2438_bin_attrs[] = {
 };
 
 static const struct attribute_group w1_ds2438_group = {
-	.bin_attrs_new = w1_ds2438_bin_attrs,
+	.bin_attrs = w1_ds2438_bin_attrs,
 };
 
 static const struct attribute_group *w1_ds2438_groups[] = {
diff --git a/drivers/w1/slaves/w1_ds2780.c b/drivers/w1/slaves/w1_ds2780.c
index ba7beb7b01f98d631d61c44847540068ece4bdd6..889a6099c314e09464ee943abb3600e4c4bc50f9 100644
--- a/drivers/w1/slaves/w1_ds2780.c
+++ b/drivers/w1/slaves/w1_ds2780.c
@@ -103,7 +103,7 @@ static const struct bin_attribute *const w1_ds2780_bin_attrs[] = {
 };
 
 static const struct attribute_group w1_ds2780_group = {
-	.bin_attrs_new = w1_ds2780_bin_attrs,
+	.bin_attrs = w1_ds2780_bin_attrs,
 };
 
 static const struct attribute_group *w1_ds2780_groups[] = {
diff --git a/drivers/w1/slaves/w1_ds2781.c b/drivers/w1/slaves/w1_ds2781.c
index acd04ee96e81bd028e026711749649c59e35a141..88f3abd5cd4be4d6a9dd44509d8d79f4ca553353 100644
--- a/drivers/w1/slaves/w1_ds2781.c
+++ b/drivers/w1/slaves/w1_ds2781.c
@@ -100,7 +100,7 @@ static const struct bin_attribute *const w1_ds2781_bin_attrs[] = {
 };
 
 static const struct attribute_group w1_ds2781_group = {
-	.bin_attrs_new = w1_ds2781_bin_attrs,
+	.bin_attrs = w1_ds2781_bin_attrs,
 };
 
 static const struct attribute_group *w1_ds2781_groups[] = {
diff --git a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
index d99ffadbe29bb48a5c60239b4d6f4cb0d7a5cb5d..c577b5973032e12cf6108d71899595f35656fd0e 100644
--- a/drivers/w1/slaves/w1_ds28e04.c
+++ b/drivers/w1/slaves/w1_ds28e04.c
@@ -371,7 +371,7 @@ static const struct bin_attribute *const w1_f1C_bin_attrs[] = {
 
 static const struct attribute_group w1_f1C_group = {
 	.attrs		= w1_f1C_attrs,
-	.bin_attrs_new	= w1_f1C_bin_attrs,
+	.bin_attrs	= w1_f1C_bin_attrs,
 };
 
 static const struct attribute_group *w1_f1C_groups[] = {
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 29f200bbab41f41948388635e0f1790ec39ca417..d0474a0532ec1f24f14e5bb75733a9c2fe176c72 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -149,7 +149,7 @@ static const struct bin_attribute *const w1_slave_bin_attrs[] = {
 };
 
 static const struct attribute_group w1_slave_default_group = {
-	.bin_attrs_new = w1_slave_bin_attrs,
+	.bin_attrs = w1_slave_bin_attrs,
 };
 
 static const struct attribute_group *w1_slave_default_groups[] = {
diff --git a/drivers/zorro/zorro-sysfs.c b/drivers/zorro/zorro-sysfs.c
index 294d3642a2795eaa26e5e4b8fdf841aef18fb8b2..4e967754d8ad40ca88c2e0729a1a397254918436 100644
--- a/drivers/zorro/zorro-sysfs.c
+++ b/drivers/zorro/zorro-sysfs.c
@@ -114,7 +114,7 @@ static const struct bin_attribute *const zorro_device_bin_attrs[] = {
 
 static const struct attribute_group zorro_device_attr_group = {
 	.attrs		= zorro_device_attrs,
-	.bin_attrs_new	= zorro_device_bin_attrs,
+	.bin_attrs	= zorro_device_bin_attrs,
 };
 
 const struct attribute_group *zorro_device_attribute_groups[] = {
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
index 5183ae86e05ee7f1833568e7b419c91e2e9b91fc..c7622ff5226a2b6c48ebdfc4c9f6aeff7a7437e7 100644
--- a/kernel/module/sysfs.c
+++ b/kernel/module/sysfs.c
@@ -56,9 +56,9 @@ static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
 {
 	const struct bin_attribute *const *bin_attr;
 
-	for (bin_attr = sect_attrs->grp.bin_attrs_new; *bin_attr; bin_attr++)
+	for (bin_attr = sect_attrs->grp.bin_attrs; *bin_attr; bin_attr++)
 		kfree((*bin_attr)->attr.name);
-	kfree(sect_attrs->grp.bin_attrs_new);
+	kfree(sect_attrs->grp.bin_attrs);
 	kfree(sect_attrs);
 }
 
@@ -86,7 +86,7 @@ static int add_sect_attrs(struct module *mod, const struct load_info *info)
 
 	/* Setup section attributes. */
 	sect_attrs->grp.name = "sections";
-	sect_attrs->grp.bin_attrs_new = gattr;
+	sect_attrs->grp.bin_attrs = gattr;
 
 	sattr = &sect_attrs->attrs[0];
 	for (i = 0; i < info->hdr->e_shnum; i++) {
@@ -144,7 +144,7 @@ struct module_notes_attrs {
 
 static void free_notes_attrs(struct module_notes_attrs *notes_attrs)
 {
-	kfree(notes_attrs->grp.bin_attrs_new);
+	kfree(notes_attrs->grp.bin_attrs);
 	kfree(notes_attrs);
 }
 
@@ -178,7 +178,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
 	}
 
 	notes_attrs->grp.name = "notes";
-	notes_attrs->grp.bin_attrs_new = gattr;
+	notes_attrs->grp.bin_attrs = gattr;
 
 	nattr = &notes_attrs->attrs[0];
 	for (loaded = i = 0; i < info->hdr->e_shnum; ++i) {
diff --git a/mm/page_idle.c b/mm/page_idle.c
index 408aaf29a3ea62aa85cc5f93a8a9687c1eb8eedb..a82b340dc20447e760889b588cf71288525a7275 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -208,7 +208,7 @@ static const struct bin_attribute *const page_idle_bin_attrs[] = {
 };
 
 static const struct attribute_group page_idle_attr_group = {
-	.bin_attrs_new = page_idle_bin_attrs,
+	.bin_attrs = page_idle_bin_attrs,
 	.name = "page_idle",
 };
 

-- 
2.49.0


