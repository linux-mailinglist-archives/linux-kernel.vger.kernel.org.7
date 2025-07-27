Return-Path: <linux-kernel+bounces-747315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7220B1324E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 00:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6E43B693E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2403124EAB1;
	Sun, 27 Jul 2025 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="Xv4FM1BZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="nO6JGkLI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="REhx32xj"
Received: from sender6.mail.selcloud.ru (sender6.mail.selcloud.ru [5.8.75.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F77C156CA;
	Sun, 27 Jul 2025 22:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753656043; cv=none; b=BLYoBZwpVe5q0eJG7slEUpJZtZ5Iogt9OLcFmblhxRa8kYjFGby4YmrvSxWTYBbmzvvSuZfkyksBfQ9Tyz4leefQacj3RJXSPfN27pMnuDrGwgkH5zWc5uxblPqlxNTVlblMAi1/Eaz5F/NcBF8lGuG4pxNwzs5O0uEW9XF6JMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753656043; c=relaxed/simple;
	bh=YLsWk7Tq07UJu+/IXpBffsp/Lvcv2PO6cl7SRr9d6io=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jd5Seo7Cgy4q3OGe+GnGyQd1UjSTve5oQniJVp0po1+eBp+Fz+mucgA9c/yebYHCStNnoHqg3eHqd4M1pLBTsWQqBROFJhEk9xG8LihKZInK4wKh0vb8p9gNTGxrNvidQ1pjq3gBVftZhkO/fOowdpawSLpNlog9b2w/1QtiyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=Xv4FM1BZ; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=nO6JGkLI; dkim=fail (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=REhx32xj reason="signature verification failed"; arc=none smtp.client-ip=5.8.75.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=clR8uHubenofJjQ8ktas4B5nhVgljK6hHXAT9d2hRgg=; t=1753656039; x=1753828839;
	 b=Xv4FM1BZRl3HUWi+XCP4kWpXCVszQKNEzJshRt/IGsCh9iqZH230NKCOhce9vYxG600JQxVYY/
	5pSTkRZH+v0YklZnOzjxiICH//nuTDef9cdCQorkr3QzEslVmGW+XAmS5ugAGdhE88t6x+klM5z72
	CK9EaHRXNM08spk9pqnU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Help:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=clR8uHubenofJjQ8ktas4B5nhVgljK6hHXAT9d2hRgg=;
	t=1753656039; x=1753828839; b=nO6JGkLIOd1VHmgY1W2mQtdV1xZj+gLhBxh1qyI5FgD8lw6
	CSFTiKBAZLKNz5AQrcgz63lN2GeGEi1daQk0FNjfkylipLoSmS0pEM8S0PXV1NdCw8fNeJyVmxwnS
	J1yrxtwoV7d8Vfm7IKxe/h4kcMo30AcCnaGyxrDvKrTAq7g=;
Precedence: bulk
X-Issuen: 1116632
X-User: 320191285
X-Postmaster-Msgtype: 3849
Feedback-ID: 1116632:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20250725.002728
X-SMTPUID: mlgnr60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxido.dev; s=dkim;
	t=1753655770; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=QWlecfNQDYmgXCcKf2vj3aRFQnvYOO2lUvp35mddSHE=;
	b=REhx32xjJEHUfiGH9EGtstAh/p3gxuFVSbc3svbxOXH/0jl1mMmm1BtkksVuHkI1DS5IoD
	nTeDJFO6Hkz9kDYQtBfUQhdZIG2Z2P9ssItiJlPXF0DjzxcuFYxdLBzfz7XpOXzUZ/egnY
	/4wKplFkeIsodiNyBJmps7UTA7+eQWEwhXg519GnERaOd0kO9ACViDETZm0bO9hts+nuea
	jFIDaEKXZ5MOa1CJerlNqpP8l6l37nW2Tk14WlUnZ09zBanMKLBhdu0zVii6Q8nEKczUAH
	vAHzUquQX9WsdUYVZEHDvb7irBPFsAdAEx8fzErsiZjWubj1fBuRgRLITKpcug==
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: w_armin@gmx.de,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/1] Add WMI driver for Redmibook keyboard.
Date: Mon, 28 Jul 2025 01:34:59 +0300
Message-ID: <20250727223516.29244-1-foxido@foxido.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable

This driver implements support for various Fn keys (like Cut) and Xiaomi
specific AI button.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 MAINTAINERS                      |   6 ++
 drivers/platform/x86/Kconfig     |  10 ++
 drivers/platform/x86/Makefile    |   1 +
 drivers/platform/x86/redmi-wmi.c | 164 +++++++++++++++++++++++++++++++
 4 files changed, 181 insertions(+)
 create mode 100644 drivers/platform/x86/redmi-wmi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 10850512c118..b3956f3d2eb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20965,6 +20965,12 @@ S:	Maintained
 T:	git https://github.com/pkshih/rtw.git
 F:	drivers/net/wireless/realtek/rtw89/
=20
+REDMIBOOK WMI DRIVERS
+M:	Gladyshev Ilya <foxido@foxido.dev>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/redmi-wmi.c
+
 REDPINE WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index e5cbd58a99f3..b8d426e6b5a3 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -109,6 +109,16 @@ config XIAOMI_WMI
 	  To compile this driver as a module, choose M here: the module will
 	  be called xiaomi-wmi.
=20
+config REDMI_WMI
+	tristate "Redmibook WMI key driver"
+	depends on ACPI_WMI
+	depends on INPUT
+	help
+	  Say Y here if you want to support WMI-based keys on Redmibooks.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called redmi-wmi.
+
 config GIGABYTE_WMI
 	tristate "Gigabyte WMI temperature driver"
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
index abbc2644ff6d..56903d7408cd 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_HUAWEI_WMI)		+=3D huawei-wmi.o
 obj-$(CONFIG_MXM_WMI)			+=3D mxm-wmi.o
 obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)	+=3D nvidia-wmi-ec-backlight.o
 obj-$(CONFIG_XIAOMI_WMI)		+=3D xiaomi-wmi.o
+obj-$(CONFIG_REDMI_WMI)			+=3D redmi-wmi.o
 obj-$(CONFIG_GIGABYTE_WMI)		+=3D gigabyte-wmi.o
=20
 # Acer
diff --git a/drivers/platform/x86/redmi-wmi.c b/drivers/platform/x86/redm=
i-wmi.c
new file mode 100644
index 000000000000..0bb6ea7b1081
--- /dev/null
+++ b/drivers/platform/x86/redmi-wmi.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/* WMI driver for Xiaomi Redmibooks */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/wmi.h>
+
+#include <uapi/linux/input-event-codes.h>
+
+#define WMI_REDMIBOOK_KEYBOARD_EVENT_GUID "46c93e13-ee9b-4262-8488-563bc=
a757fef"
+
+/* Supported WMI keys ... */
+#define ACPI_CUT_PAYLOAD		0x00000201
+#define ACPI_ALL_APPS_PAYLOAD		0x00000301
+#define ACPI_SETUP_PAYLOAD		0x00001b01
+#define ACPI_CST_KEY_PRESS_PAYLOAD	0x00011801
+#define ACPI_CST_KEY_RELEASE_PAYLOAD	0x00011901
+
+/* ... and their mappings */
+#define WMI_CUT_KEY		KEY_PROG1
+#define WMI_ALL_APPS_KEY	KEY_ALL_APPLICATIONS
+#define WMI_SETUP_KEY		KEY_SETUP
+#define WMI_CST_KEY		KEY_ASSISTANT
+
+/* Keyboard backlight key (not supported yet) */
+#define BACKLIGHT_LEVEL_0_PAYLOAD	0x00000501
+#define BACKLIGHT_LEVEL_1_PAYLOAD	0x00800501
+#define BACKLIGHT_LEVEL_2_PAYLOAD	0x00050501
+#define BACKLIGHT_LEVEL_3_PAYLOAD	0x000a0501
+
+struct redmi_wmi {
+	struct input_dev *input_dev;
+	/* Protects the key event sequence */
+	struct mutex key_lock;
+};
+
+static void redmi_mutex_destroy(void *data)
+{
+	struct mutex *lock =3D data;
+
+	mutex_destroy(lock);
+}
+
+static int redmi_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	struct redmi_wmi *data;
+	int ret;
+
+	/* Init dev */
+	data =3D devm_kzalloc(&wdev->dev, sizeof(struct redmi_wmi), GFP_KERNEL)=
;
+	if (!data)
+		return -ENOMEM;
+
+	dev_set_drvdata(&wdev->dev, data);
+
+	/* Init mutex & setup destroy at exit */
+	mutex_init(&data->key_lock);
+	ret =3D devm_add_action_or_reset(&wdev->dev, redmi_mutex_destroy, &data=
->key_lock);
+	if (ret < 0)
+		return ret;
+
+	/* Setup input device */
+	data->input_dev =3D devm_input_allocate_device(&wdev->dev);
+	if (!data->input_dev)
+		return -ENOMEM;
+	data->input_dev->name =3D "Redmibook WMI keys";
+	data->input_dev->phys =3D "wmi/input0";
+
+	set_bit(EV_KEY, data->input_dev->evbit);
+
+	/* "Cut" key*/
+	set_bit(WMI_CUT_KEY, data->input_dev->keybit);
+	/* "All apps" key*/
+	set_bit(WMI_ALL_APPS_KEY, data->input_dev->keybit);
+	/* "Settings" key */
+	set_bit(WMI_SETUP_KEY, data->input_dev->keybit);
+	/* Custom (AI?) key */
+	set_bit(WMI_CST_KEY, data->input_dev->keybit);
+
+	return input_register_device(data->input_dev);
+}
+
+static void press_and_release_key(struct input_dev *dev, unsigned int co=
de)
+{
+	input_report_key(dev, code, 1);
+	input_sync(dev);
+	input_report_key(dev, code, 0);
+	input_sync(dev);
+}
+
+static void redmi_wmi_notify(struct wmi_device *wdev, union acpi_object =
*obj)
+{
+	struct redmi_wmi *data =3D dev_get_drvdata(&wdev->dev);
+
+	if (obj->type !=3D ACPI_TYPE_BUFFER) {
+		dev_err(&wdev->dev, "Bad response type %u\n", obj->type);
+		return;
+	}
+
+	if (obj->buffer.length < 4) {
+		dev_err(&wdev->dev, "Invalid buffer length %u\n", obj->buffer.length);
+		return;
+	}
+
+	/* For linearizability */
+	guard(mutex)(&data->key_lock);
+
+	u32 payload =3D ((u32 *)obj->buffer.pointer)[0];
+
+	switch (payload) {
+	case ACPI_CUT_PAYLOAD:
+		press_and_release_key(data->input_dev, WMI_CUT_KEY);
+		break;
+	case ACPI_ALL_APPS_PAYLOAD:
+		press_and_release_key(data->input_dev, WMI_ALL_APPS_KEY);
+		break;
+	case ACPI_SETUP_PAYLOAD:
+		press_and_release_key(data->input_dev, WMI_SETUP_KEY);
+		break;
+	case ACPI_CST_KEY_PRESS_PAYLOAD:
+		input_report_key(data->input_dev, WMI_CST_KEY, 1);
+		input_sync(data->input_dev);
+		break;
+	case ACPI_CST_KEY_RELEASE_PAYLOAD:
+		input_report_key(data->input_dev, WMI_CST_KEY, 0);
+		input_sync(data->input_dev);
+		break;
+	case BACKLIGHT_LEVEL_0_PAYLOAD:
+	case BACKLIGHT_LEVEL_1_PAYLOAD:
+	case BACKLIGHT_LEVEL_2_PAYLOAD:
+	case BACKLIGHT_LEVEL_3_PAYLOAD:
+		pr_debug("keyboard backlight WMI event, no action");
+		break;
+	default:
+		pr_debug("unsupported Redmibook WMI event with 4byte payload %u", payl=
oad);
+		break;
+	}
+}
+
+static const struct wmi_device_id redmi_wmi_id_table[] =3D {
+	{ .guid_string =3D WMI_REDMIBOOK_KEYBOARD_EVENT_GUID },
+	/* Terminating entry */
+	{ }
+};
+
+static struct wmi_driver redmi_wmi_driver =3D {
+	.driver =3D {
+		.name =3D "redmi-wmi",
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS
+	},
+	.id_table =3D redmi_wmi_id_table,
+	.probe =3D redmi_wmi_probe,
+	.notify =3D redmi_wmi_notify,
+	.no_singleton =3D true,
+};
+module_wmi_driver(redmi_wmi_driver);
+
+MODULE_DEVICE_TABLE(wmi, redmi_wmi_id_table);
+MODULE_AUTHOR("Gladyshev Ilya <foxido@foxido.dev>");
+MODULE_DESCRIPTION("Redmibook WMI driver");
+MODULE_LICENSE("GPL");
--=20
2.50.0


