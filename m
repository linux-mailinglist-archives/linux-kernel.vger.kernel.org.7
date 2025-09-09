Return-Path: <linux-kernel+bounces-807677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6940B4A7AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C797B3EBB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6879430F958;
	Tue,  9 Sep 2025 09:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/pHKjSy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F830CDA5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409369; cv=none; b=oXINxBpb1rpKyjd9OqR+H2BMjiNmHkFhGmfQRfZaRHEkDYKGjAyhBPZIbFODj6MVC0uczisHfIH5ktCfhxRsVJga1kyLUG1VX6pkgrtJ6LVqUR6rmGUlDHZOFEUgbl5kkQxV6v3r+HjHt24nuSzpwDOjWIvDAjQrSyeDayhdZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409369; c=relaxed/simple;
	bh=oVv24RZQlKH22Ja6cyHWdi7oBOb6EOI1GUtwdyNI2ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s1pyXe3OAwrbzqb5SBWUzBft8UzISR6CGTfdrACSIn+BrblfdzR0RRuy2k+3v4ks35rGXlpfOJzcFLZiX5fwzL3lDAQqLKt1PODYKCaDjbqHsPi2faNbz/+F2h8MdaFkADqSnrF5bmxYVaeLjxzrxHQYfIq+0nuFT2k9N2o8fnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/pHKjSy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757409365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wjGJD3gvFoEiZrkJU/Pic1oDbV4RUgzaWVlQA83tMU=;
	b=g/pHKjSyjRWBL9tdFbWqQodAfJLg9HV1VM6+ZCc7ePeW0TKKLY8qgzO8UURDQAb/85i7+L
	KhRgm+Y3XMRrXciwGtvvqwg1yRAdfy/vXspLvX7rZdQn3br3GDSqb9yXtZ0USyBt4xa9YM
	447ZgcHKKehHlj9ygE2ftEifyUWSzVM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-2hrXO8lRM1e7LR9xd7vyCw-1; Tue,
 09 Sep 2025 05:16:01 -0400
X-MC-Unique: 2hrXO8lRM1e7LR9xd7vyCw-1
X-Mimecast-MFC-AGG-ID: 2hrXO8lRM1e7LR9xd7vyCw_1757409360
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83B2A19560B7;
	Tue,  9 Sep 2025 09:15:59 +0000 (UTC)
Received: from p16v.. (unknown [10.43.2.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB92819560B4;
	Tue,  9 Sep 2025 09:15:55 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v6 5/5] dpll: zl3073x: Implement devlink flash callback
Date: Tue,  9 Sep 2025 11:15:32 +0200
Message-ID: <20250909091532.11790-6-ivecera@redhat.com>
In-Reply-To: <20250909091532.11790-1-ivecera@redhat.com>
References: <20250909091532.11790-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Use the introduced functionality to read firmware files and flash their
contents into the device's internal flash memory to implement the devlink
flash update callback.

Sample output on EDS2 development board:
 # devlink -j dev info i2c/1-0070 | jq '.[][]["versions"]["running"]'
 {
   "fw": "6026"
 }
 # devlink dev flash i2c/1-0070 file firmware_fw2.hex
 [utility] Prepare flash mode
 [utility] Downloading image 100%
 [utility] Flash mode enabled
 [firmware1-part1] Downloading image 100%
 [firmware1-part1] Flashing image
 [firmware1-part2] Downloading image 100%
 [firmware1-part2] Flashing image
 [firmware1] Flashing done
 [firmware2] Downloading image 100%
 [firmware2] Flashing image 100%
 [firmware2] Flashing done
 [utility] Leaving flash mode
 Flashing done
 # devlink -j dev info i2c/1-0070 | jq '.[][]["versions"]["running"]'
 {
   "fw": "7006"
 }

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v4:
* Removed excessive comments
* Refactored flash callback by adding helper for preparation and finish
  phase
v3:
* Fixed return value documentation for zl3073x_flash_update()
---
 Documentation/networking/devlink/zl3073x.rst |  14 ++
 drivers/dpll/zl3073x/devlink.c               | 129 +++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/Documentation/networking/devlink/zl3073x.rst b/Documentation/networking/devlink/zl3073x.rst
index 4b6cfaf386433..fc5a8dc272a77 100644
--- a/Documentation/networking/devlink/zl3073x.rst
+++ b/Documentation/networking/devlink/zl3073x.rst
@@ -49,3 +49,17 @@ The ``zl3073x`` driver reports the following versions
       - running
       - 1.3.0.1
       - Device configuration version customized by OEM
+
+Flash Update
+============
+
+The ``zl3073x`` driver implements support for flash update using the
+``devlink-flash`` interface. It supports updating the device flash using a
+combined flash image ("bundle") that contains multiple components (firmware
+parts and configurations).
+
+During the flash procedure, the standard firmware interface is not available,
+so the driver unregisters all DPLLs and associated pins, and re-registers them
+once the flash procedure is complete.
+
+The driver does not support any overwrite mask flags.
diff --git a/drivers/dpll/zl3073x/devlink.c b/drivers/dpll/zl3073x/devlink.c
index d0f6d9cd4a68e..f55d5309d4f9c 100644
--- a/drivers/dpll/zl3073x/devlink.c
+++ b/drivers/dpll/zl3073x/devlink.c
@@ -9,6 +9,8 @@
 #include "core.h"
 #include "devlink.h"
 #include "dpll.h"
+#include "flash.h"
+#include "fw.h"
 #include "regs.h"
 
 /**
@@ -141,11 +143,138 @@ void zl3073x_devlink_flash_notify(struct zl3073x_dev *zldev, const char *msg,
 					   total);
 }
 
+/**
+ * zl3073x_devlink_flash_prepare - Prepare and enter flash mode
+ * @zldev: zl3073x device pointer
+ * @zlfw: pointer to loaded firmware
+ * @extack: netlink extack pointer to report errors
+ *
+ * The function stops normal operation and switches the device to flash mode.
+ * If an error occurs the normal operation is resumed.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_devlink_flash_prepare(struct zl3073x_dev *zldev,
+			      struct zl3073x_fw *zlfw,
+			      struct netlink_ext_ack *extack)
+{
+	struct zl3073x_fw_component *util;
+	int rc;
+
+	util = zlfw->component[ZL_FW_COMPONENT_UTIL];
+	if (!util) {
+		zl3073x_devlink_flash_notify(zldev,
+					     "Utility is missing in firmware",
+					     NULL, 0, 0);
+		zl3073x_fw_free(zlfw);
+		return -ENOEXEC;
+	}
+
+	/* Stop normal operation prior entering flash mode */
+	zl3073x_dev_stop(zldev);
+
+	rc = zl3073x_flash_mode_enter(zldev, util->data, util->size, extack);
+	if (rc) {
+		zl3073x_devlink_flash_notify(zldev,
+					     "Failed to enter flash mode",
+					     NULL, 0, 0);
+
+		/* Resume normal operation */
+		zl3073x_dev_start(zldev, true);
+
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * zl3073x_devlink_flash_finish - Leave flash mode and resume normal operation
+ * @zldev: zl3073x device pointer
+ * @extack: netlink extack pointer to report errors
+ *
+ * The function switches the device back to standard mode and resumes normal
+ * operation.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_devlink_flash_finish(struct zl3073x_dev *zldev,
+			     struct netlink_ext_ack *extack)
+{
+	int rc;
+
+	/* Reset device CPU to normal mode */
+	zl3073x_flash_mode_leave(zldev, extack);
+
+	/* Resume normal operation */
+	rc = zl3073x_dev_start(zldev, true);
+	if (rc)
+		zl3073x_devlink_flash_notify(zldev,
+					     "Failed to start normal operation",
+					     NULL, 0, 0);
+
+	return rc;
+}
+
+/**
+ * zl3073x_devlink_flash_update - Devlink flash update callback
+ * @devlink: devlink structure pointer
+ * @params: flashing parameters pointer
+ * @extack: netlink extack pointer to report errors
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_devlink_flash_update(struct devlink *devlink,
+			     struct devlink_flash_update_params *params,
+			     struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dev *zldev = devlink_priv(devlink);
+	struct zl3073x_fw *zlfw;
+	int rc = 0;
+
+	zlfw = zl3073x_fw_load(zldev, params->fw->data, params->fw->size,
+			       extack);
+	if (IS_ERR(zlfw)) {
+		zl3073x_devlink_flash_notify(zldev, "Failed to load firmware",
+					     NULL, 0, 0);
+		rc = PTR_ERR(zlfw);
+		goto finish;
+	}
+
+	/* Stop normal operation and enter flash mode */
+	rc = zl3073x_devlink_flash_prepare(zldev, zlfw, extack);
+	if (rc)
+		goto finish;
+
+	rc = zl3073x_fw_flash(zldev, zlfw, extack);
+	if (rc) {
+		zl3073x_devlink_flash_finish(zldev, extack);
+		goto finish;
+	}
+
+	/* Resume normal mode */
+	rc = zl3073x_devlink_flash_finish(zldev, extack);
+
+finish:
+	if (!IS_ERR(zlfw))
+		zl3073x_fw_free(zlfw);
+
+	zl3073x_devlink_flash_notify(zldev,
+				     rc ? "Flashing failed" : "Flashing done",
+				     NULL, 0, 0);
+
+	return rc;
+}
+
 static const struct devlink_ops zl3073x_devlink_ops = {
 	.info_get = zl3073x_devlink_info_get,
 	.reload_actions = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT),
 	.reload_down = zl3073x_devlink_reload_down,
 	.reload_up = zl3073x_devlink_reload_up,
+	.flash_update = zl3073x_devlink_flash_update,
 };
 
 static void
-- 
2.49.1


