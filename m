Return-Path: <linux-kernel+bounces-828478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB38B94AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828161899926
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B09311C2D;
	Tue, 23 Sep 2025 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA6LJspI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C9630FF2A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611060; cv=none; b=ZlpQP4eZL64Z9WHR5cLokBV8u0g8fJw4gd2W1NCvsti1/crffOa8OXNfvOCwLHQEv5W5mekxIfaBHq54OkuC+58mhUyw8CPpEDueaxioAhmqLCHYT21vklN3K4QRKyRcBQbSnlucEvNreFSR5cv6Ie4vN5UQDWxBBdOtrKs8haA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611060; c=relaxed/simple;
	bh=nQLxvxa8HuWD6dh9QKDs+EMcwoAdv2l2hN58Kmv/I7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYKIq3OvJB2v5/Gpu9ySeOw1CzHuBwqtOeEGMawcZwKpi33F5Sb/H4BzZmTOnIWvHRi7bCh+0ZzaVwD+j8BAfO8l6RSwXX60bkYeSF+ZUpy1eo7ddJIPKfRqAIuFjjX4ZGnJSD7ymxrwFxLv1GD+YaILrPehNNE67C/7l6SCMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA6LJspI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FA2C19424;
	Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758611060;
	bh=nQLxvxa8HuWD6dh9QKDs+EMcwoAdv2l2hN58Kmv/I7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dA6LJspIbwsjBtWTlTh769DMumQNYg3KccnNn5IJ3hNF9uwCIyLDxVLYyiI5flXuc
	 8NrMyikVmA7bPOCZHZxjlpgnSzodA/ZF6R64bBPqQBIIE2XmMG/EMF+rH1hHuO25Ib
	 5DPqo+d5fFiTt1vOE2gBaYacJI7xPayS0bammSGIXO5C0nwmG5a1dOZDbOiPWME1Ev
	 eugTAT8zJrUVarEVQp4TDpuXL0qwhOovfl3y2oOdLolu/iBYgjYiCAuHTW5j7qGMlK
	 jAyHRjCDxHOQgMyda0idGb42Nyyk0P0VFZNIkcmbuiouzeP3KoIW6xlfae8lARtkZJ
	 poZT0kdOdkzQQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0x4U-00000006bKu-1kj3;
	Tue, 23 Sep 2025 09:04:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Ani Sinha <anisinha@redhat.com>,
	Eduardo Habkost <eduardo@habkost.net>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	Yanan Wang <wangyanan55@huawei.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 09/17] acpi/generic_event_device: add logic to detect if HEST addr is available
Date: Tue, 23 Sep 2025 09:04:03 +0200
Message-ID: <c4eb3cf32a3f158ae62dac29e866ac3f373956c3.1758610789.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758610789.git.mchehab+huawei@kernel.org>
References: <cover.1758610789.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Create a new property (x-has-hest-addr) and use it to detect if
the GHES table offsets can be calculated from the HEST address
(qemu 10.0 and upper) or via the legacy way via an offset obtained
from the hardware_errors firmware file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/generic_event_device.c |  2 ++
 hw/arm/virt-acpi-build.c       | 18 ++++++++++++++++--
 hw/core/machine.c              |  5 ++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 55998303c22f..b1ff6ab74d8f 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -349,6 +349,8 @@ static const Property acpi_ged_properties[] = {
                      pcihp_state.use_acpi_hotplug_bridge, 0),
     DEFINE_PROP_LINK("bus", AcpiGedState, pcihp_state.root,
                      TYPE_PCI_BUS, PCIBus *),
+    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState,
+                     ghes_state.use_hest_addr, false),
 };
 
 static const VMStateDescription vmstate_memhp_state = {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index c856d293c6e8..ff3b7a794b84 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1129,6 +1129,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
     { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
 };
 
+static const AcpiNotificationSourceId hest_ghes_notify_10_0[] = {
+    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
+};
+
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
@@ -1186,15 +1190,25 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 
     if (vms->ras) {
         AcpiGedState *acpi_ged_state;
+        static const AcpiNotificationSourceId *notify;
+        unsigned int notify_sz;
         AcpiGhesState *ags;
 
         acpi_ged_state = ACPI_GED(vms->acpi_dev);
         ags = &acpi_ged_state->ghes_state;
         if (ags) {
             acpi_add_table(table_offsets, tables_blob);
+
+            if (!ags->use_hest_addr) {
+                notify = hest_ghes_notify_10_0;
+                notify_sz = ARRAY_SIZE(hest_ghes_notify_10_0);
+            } else {
+                notify = hest_ghes_notify;
+                notify_sz = ARRAY_SIZE(hest_ghes_notify);
+            }
+
             acpi_build_hest(ags, tables_blob, tables->hardware_errors,
-                            tables->linker, hest_ghes_notify,
-                            ARRAY_SIZE(hest_ghes_notify),
+                            tables->linker, notify, notify_sz,
                             vms->oem_id, vms->oem_table_id);
         }
     }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 38c949c4f2ce..7b7a381b0ade 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -35,9 +35,12 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/acpi/generic_event_device.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_10_1[] = {};
+GlobalProperty hw_compat_10_1[] = {
+    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
+};
 const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
 
 GlobalProperty hw_compat_10_0[] = {
-- 
2.51.0


