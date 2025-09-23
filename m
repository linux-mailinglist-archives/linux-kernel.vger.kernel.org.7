Return-Path: <linux-kernel+bounces-828486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF62B94B19
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02ACB17620E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C0314B64;
	Tue, 23 Sep 2025 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+LJsx6e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F2D3101B4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611060; cv=none; b=RMWsQBO31UjkJYBz8YEgQbucZz7qQfU7hr6WZcj7syjvzE1uMaon/Xs5fVS0t2T6UaPxPZAcvjC3atRTK8c3Glox+vuowmkUXoHQkLe2yfQDiWhjHTdx2slyZtKsY+9TdPX/97Zyj7KZcuwNhX1RBhYl+wEhlOFgbvz1wXbBQJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611060; c=relaxed/simple;
	bh=FIqokdY5i2iLDrvLG74soWuf+7qZtG1fVedjS8WqfxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkQp2H7qCMvvjCzLN6x+KAc4zi6NW9v6axyx4kk7g65SWZ/Qa4snkLc20IrgVyk9wKbrrcdTTmZcYZ6K9iF8yD/8wsuNI5e8WkPIoYhsBUVlf6TYLtlQlqdJzI9KJogiH0ZRBx0HOy8eDVBHH+b4uK0+4FcioarPU452C3nSufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+LJsx6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC75C2BCB8;
	Tue, 23 Sep 2025 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758611060;
	bh=FIqokdY5i2iLDrvLG74soWuf+7qZtG1fVedjS8WqfxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+LJsx6eSkC2Qz/OWJn1h40fRRM2YRKukjdYYf0qPiLI1XdbIcBlsvVAsU+5NwPhA
	 xY2VZgWCcX5G3Yhj4NtllnzXnQNOarV+ewzRfZSBNiLd/0b4SOCw/J8+js7bI2wOvx
	 yCxhUeKvFrQBm4ZSAWr/0xICxGSIz62bOIlvreNjkUxerFeSBhnVqRb2CnElfarLZg
	 lxgX8b6szBdNN1MNGhpzqsqclvagWZGhE0NXI3e2zUmUjDNvxJ5XR++MbiN2EW9b1O
	 FQ2eNV+jiFKpyw6L3V+5l3mZSlA1JhM9JuNre/vDYWJw4+3SR5lr3LBRFEyC97G/eh
	 gziAVjvRndHrQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0x4U-00000006bLA-2EHU;
	Tue, 23 Sep 2025 09:04:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 13/17] qapi/acpi-hest: add an interface to do generic CPER error injection
Date: Tue, 23 Sep 2025 09:04:07 +0200
Message-ID: <81e2118b3c8b7e5da341817f277d61251655e0db.1758610789.git.mchehab+huawei@kernel.org>
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

Create a QMP command to be used for generic ACPI APEI hardware error
injection (HEST) via GHESv2, and add support for it for ARM guests.

Error injection uses ACPI_HEST_SRC_ID_QMP source ID to be platform
independent. This is mapped at arch virt bindings, depending on the
types supported by QEMU and by the BIOS. So, on ARM, this is supported
via ACPI_GHES_NOTIFY_GPIO notification type.

This patch was co-authored:
    - original ghes logic to inject a simple ARM record by Shiju Jose;
    - generic logic to handle block addresses by Jonathan Cameron;
    - generic GHESv2 error inject by Mauro Carvalho Chehab;

Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS              |  7 +++++++
 hw/acpi/Kconfig          |  5 +++++
 hw/acpi/ghes.c           |  2 +-
 hw/acpi/ghes_cper.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/acpi/ghes_cper_stub.c | 20 ++++++++++++++++++++
 hw/acpi/meson.build      |  2 ++
 hw/arm/virt-acpi-build.c |  1 +
 hw/arm/virt.c            |  7 +++++++
 include/hw/acpi/ghes.h   |  1 +
 include/hw/arm/virt.h    |  1 +
 qapi/acpi-hest.json      | 36 ++++++++++++++++++++++++++++++++++++
 qapi/meson.build         |  1 +
 qapi/qapi-schema.json    |  1 +
 13 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 hw/acpi/ghes_cper.c
 create mode 100644 hw/acpi/ghes_cper_stub.c
 create mode 100644 qapi/acpi-hest.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 70eb0241d36c..36c13f25e516 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2166,6 +2166,13 @@ F: hw/acpi/ghes.c
 F: include/hw/acpi/ghes.h
 F: docs/specs/acpi_hest_ghes.rst
 
+ACPI/HEST/GHES/ARM processor CPER
+R: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+S: Maintained
+F: hw/arm/ghes_cper.c
+F: hw/acpi/ghes_cper_stub.c
+F: qapi/acpi-hest.json
+
 ppc4xx
 L: qemu-ppc@nongnu.org
 S: Orphan
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 1d4e9f0845c0..daabbe6cd11e 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -51,6 +51,11 @@ config ACPI_APEI
     bool
     depends on ACPI
 
+config GHES_CPER
+    bool
+    depends on ACPI_APEI
+    default y
+
 config ACPI_PCI
     bool
     depends on ACPI && PCI
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index d666f1b10b5f..06555905cebb 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -553,7 +553,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
     /* Write the generic error data entry into guest memory */
     cpu_physical_memory_write(cper_addr, cper, len);
 
-    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
+    notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
 }
 
 int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
new file mode 100644
index 000000000000..31cb2ffabeb4
--- /dev/null
+++ b/hw/acpi/ghes_cper.c
@@ -0,0 +1,40 @@
+/*
+ * CPER payload parser for error injection
+ *
+ * Copyright(C) 2024-2025 Huawei LTD.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/base64.h"
+#include "qemu/error-report.h"
+#include "qemu/uuid.h"
+#include "qapi/qapi-commands-acpi-hest.h"
+#include "hw/acpi/ghes.h"
+
+void qmp_inject_ghes_v2_error(const char *qmp_cper, Error **errp)
+{
+    AcpiGhesState *ags;
+    uint8_t *cper;
+    size_t  len;
+
+    ags = acpi_ghes_get_state();
+    if (!ags) {
+        return;
+    }
+
+    cper = qbase64_decode(qmp_cper, -1, &len, errp);
+    if (!cper) {
+        error_setg(errp, "missing GHES CPER payload");
+        return;
+    }
+
+    ghes_record_cper_errors(ags, cper, len, ACPI_HEST_SRC_ID_QMP, errp);
+
+    g_free(cper);
+}
diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c
new file mode 100644
index 000000000000..b16be73502db
--- /dev/null
+++ b/hw/acpi/ghes_cper_stub.c
@@ -0,0 +1,20 @@
+/*
+ * Stub interface for CPER payload parser for error injection
+ *
+ * Copyright(C) 2024-2025 Huawei LTD.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-acpi-hest.h"
+#include "hw/acpi/ghes.h"
+
+void qmp_inject_ghes_v2_error(const char *cper, Error **errp)
+{
+    error_setg(errp, "GHES QMP error inject is not compiled in");
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 73f02b96912b..56b5d1ec9691 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -34,4 +34,6 @@ endif
 system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
 system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
+system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
+system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
 system_ss.add(files('acpi-qmp-cmds.c'))
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 2b63008df01d..8bb6b6051548 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1128,6 +1128,7 @@ static void acpi_align_size(GArray *blob, unsigned align)
 
 static const AcpiNotificationSourceId hest_ghes_notify[] = {
     { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
+    { ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_GPIO },
 };
 
 static const AcpiNotificationSourceId hest_ghes_notify_10_0[] = {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6960f6113fef..aad557be1ae3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1052,6 +1052,13 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
 
 static void virt_generic_error_req(Notifier *n, void *opaque)
 {
+    uint16_t *source_id = opaque;
+
+    /* Currently, only QMP source ID is async */
+    if (*source_id != ACPI_HEST_SRC_ID_QMP) {
+        return;
+    }
+
     VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);
 
     acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 390943e46d99..df2ecbf6e4a9 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -65,6 +65,7 @@ enum AcpiGhesNotifyType {
  */
 enum AcpiGhesSourceID {
     ACPI_HEST_SRC_ID_SYNC,
+    ACPI_HEST_SRC_ID_QMP,       /* Use it only for QMP injected errors */
 };
 
 typedef struct AcpiNotificationSourceId {
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index e14ea0f9d42a..04a09af35406 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -33,6 +33,7 @@
 #include "exec/hwaddr.h"
 #include "qemu/notify.h"
 #include "hw/boards.h"
+#include "hw/acpi/ghes.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
 #include "hw/block/flash.h"
diff --git a/qapi/acpi-hest.json b/qapi/acpi-hest.json
new file mode 100644
index 000000000000..28af1266a777
--- /dev/null
+++ b/qapi/acpi-hest.json
@@ -0,0 +1,36 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+##
+# == GHESv2 CPER Error Injection
+#
+# Defined since ACPI Specification 6.1,
+# section 18.3.2.8 Generic Hardware Error Source version 2. See:
+#
+# https://uefi.org/sites/default/files/resources/ACPI_6_1.pdf
+##
+
+
+##
+# @inject-ghes-v2-error:
+#
+# Inject an error with additional ACPI 6.1 GHESv2 error information
+#
+# @cper: contains a base64 encoded string with raw data for a single
+#     CPER record with Generic Error Status Block, Generic Error Data
+#     Entry and generic error data payload, as described at
+#     https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#format
+#
+# Features:
+#
+# @unstable: This command is experimental.
+#
+# Since: 10.2
+##
+{ 'command': 'inject-ghes-v2-error',
+  'data': {
+    'cper': 'str'
+  },
+  'features': [ 'unstable' ]
+}
diff --git a/qapi/meson.build b/qapi/meson.build
index ca6b61a608d0..a46269b5a0c9 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -59,6 +59,7 @@ if have_system
   qapi_all_modules += [
     'accelerator',
     'acpi',
+    'acpi-hest',
     'audio',
     'cryptodev',
     'qdev',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 82f111ba063c..b93dd68d94c6 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -68,6 +68,7 @@
 { 'include': 'misc-i386.json' }
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
+{ 'include': 'acpi-hest.json' }
 { 'include': 'pci.json' }
 { 'include': 'stats.json' }
 { 'include': 'virtio.json' }
-- 
2.51.0


