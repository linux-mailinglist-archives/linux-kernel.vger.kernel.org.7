Return-Path: <linux-kernel+bounces-892937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FFEC462AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6409E3A8A61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32321309EE7;
	Mon, 10 Nov 2025 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fwA+Kfoy"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5313C307ACF;
	Mon, 10 Nov 2025 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773194; cv=none; b=Nc0PeL9qWSOyi1SqGh0CWa9P684GJCfffeVtPdGU6d28mdm2mi/NCrm8tBdq79lOmfbP7khl1OUMqn1o20x0kIlaQ0aQqaCGuU1/gxLzFW56A5RJwlQ3ROJ8duXRDtQV1iSa0CS/koefGlphIslsTFDoKmtmrfGl/qv0qyIoOr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773194; c=relaxed/simple;
	bh=9jEjn7UA5EIZ4E/J8lSySh7Fo5dV24tQXSoHKN72VL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lB+qyeepXfL/0EMB2DI82vQQQHnPaDHdEhwiOHg1CcMUIITjQnaqnzo73wkf0nyJDXI0SHaSa/OUa5juS8GxXXctghm6xTNHm0zC3gGz1GBstRM5MR5Nzdv4R/2BUwDHwCa3Sim/xi+55cGte8bASxruk9chuwV6/cbcQFiBkeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fwA+Kfoy; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762773180; x=1763377980; i=w_armin@gmx.de;
	bh=fpbVMSq5Nnkd6s4yCmD/umJ9LqziymVc1BrL7Q7Ths0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fwA+KfoyaG+BMrraZL2l3rnt3aEKzpKAfPRJ4zIcJfajIzJWRD+lTsIFN7i9LiBe
	 KOYMEIwwiCRKRxITBdS07QWL9+XOCIfrNYG5LMpBGKdC9pof9jZR9MIS2Mvi+ma+m
	 VFpKgwjanuGZ3xG4rglxZflfywkMw4VAB+c07XH6kPTidPHilqDsu+sfeNuY3Zk9f
	 t0l1BhPjTd32BCwgW5K1YGgaeF/4fpog9ez5Oli15TgXwE9Is4SRFsB4hmQgJsOIy
	 d1rz90xvd93iCfNU60yntGPk8az3VK54y3TgFJ+CgA8Cag2/HC9BjTTi56cV+J+4q
	 iMzKPXmouZYVNbzyCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.dip.tu-dresden.de ([141.76.8.184]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MNbkv-1vY2643yV1-00ROTR; Mon, 10 Nov 2025 12:13:00 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkml@antheas.dev
Subject: [PATCH 1/2] platform/x86: msi-wmi-platform: Only load on MSI devices
Date: Mon, 10 Nov 2025 12:12:52 +0100
Message-Id: <20251110111253.16204-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251110111253.16204-1-W_Armin@gmx.de>
References: <20251110111253.16204-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fv1BTZLm7i2CDF+elvQfD0VQRgFnV4T5F1rnEUgtssIlYkR9M4S
 q9HaK03m962qV9bDzxnc4YWQPe/8QHag6bTsc7Xq3fuQUAEwwXuz0y1FRMFMKG/0+B/XeIV
 GWe76wwKZzSz2wzIfOLyjJ0EvaBI7LkdxPh4+ydSAiqC0rkvjvhOAFzvOJVX8yA2B+Jo7yS
 bwxjeg636itBWoZ9RORvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RqzM6X4g9Wo=;PUXWqFcZ1cezLKL+upluKD6RSS+
 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

It turns out that the GUID used by the msi-wmi-platform driver
(ABBC0F60-8EA1-11D1-00A0-C90629100000) is not unique, but was instead
copied from the WIndows Driver Samples. This means that this driver
could load on devices from other manufacturers that also copied this
GUID, potentially causing hardware errors.

Prevent this by only loading on devices whitelisted via DMI. The DMI
matches where taken from the msi-ec driver.

Fixes: 9c0beb6b29e7 ("platform/x86: wmi: Add MSI WMI Platform driver")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/Kconfig            |  1 +
 drivers/platform/x86/msi-wmi-platform.c | 41 ++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 46e62feeda3c..d96728a0f18d 100644
=2D-- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -545,6 +545,7 @@ config MSI_WMI
 config MSI_WMI_PLATFORM
 	tristate "MSI WMI Platform features"
 	depends on ACPI_WMI
+	depends on DMI
 	depends on HWMON
 	help
 	  Say Y here if you want to have support for WMI-based platform features
diff --git a/drivers/platform/x86/msi-wmi-platform.c b/drivers/platform/x8=
6/msi-wmi-platform.c
index dc5e9878cb68..bd2687828a2e 100644
=2D-- a/drivers/platform/x86/msi-wmi-platform.c
+++ b/drivers/platform/x86/msi-wmi-platform.c
@@ -14,6 +14,7 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/device/driver.h>
+#include <linux/dmi.h>
 #include <linux/errno.h>
 #include <linux/hwmon.h>
 #include <linux/kernel.h>
@@ -448,7 +449,45 @@ static struct wmi_driver msi_wmi_platform_driver =3D =
{
 	.probe =3D msi_wmi_platform_probe,
 	.no_singleton =3D true,
 };
-module_wmi_driver(msi_wmi_platform_driver);
+
+/*
+ * MSI reused the WMI GUID from the WMI-ACPI sample code provided by Micr=
osoft,
+ * so other manufacturers might use it as well for their WMI-ACPI impleme=
ntations.
+ */
+static const struct dmi_system_id msi_wmi_platform_whitelist[] __initcons=
t =3D {
+	{
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "MICRO-STAR INT"),
+		},
+	},
+	{
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International"),
+		},
+	},
+	{ }
+};
+
+static int __init msi_wmi_platform_module_init(void)
+{
+	if (!dmi_check_system(msi_wmi_platform_whitelist)) {
+		if (!force)
+			return -ENODEV;
+
+		pr_warn("Ignoring DMI whitelist\n");
+	}
+
+	return wmi_driver_register(&msi_wmi_platform_driver);
+}
+
+static void __exit msi_wmi_platform_module_exit(void)
+{
+	wmi_driver_unregister(&msi_wmi_platform_driver);
+}
+
+module_init(msi_wmi_platform_module_init);
+module_exit(msi_wmi_platform_module_exit);
+
=20
 MODULE_AUTHOR("Armin Wolf <W_Armin@gmx.de>");
 MODULE_DESCRIPTION("MSI WMI platform features");
=2D-=20
2.39.5


