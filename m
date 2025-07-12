Return-Path: <linux-kernel+bounces-728634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A0EB02B2D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 16:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0087B563C4D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BB027A90E;
	Sat, 12 Jul 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KMBltCIf"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE01F5823;
	Sat, 12 Jul 2025 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752328960; cv=none; b=XVEOreMH9Wwg6fYmw+jOOUeL+kP6l0Nc+RW+2slyxWMjF5tBajXGh+hePoTqENCiw7uGi3V2BkP9DvblsPsTjTkaiec2l9V9dqm3CnDpaGa6oN/LF1QMGQp2PVRAN4upwc0KVXuGPRFLT4a+nHpga9E9uOKt06X6PZ9bJ1449mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752328960; c=relaxed/simple;
	bh=3wtYLKyS14ch+ZF6MjwOmyiGKgz25sSUqwIQqg39jSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ix+lJsa3xt6vsaj1nnuimLZ/fdgQTG++6xZb1I/AVbq7kQdu3vLlX5hdX4pvmXR8A1CM5QnoA31FYXu68rHNDZEhG76Nr89jy7bdH4q1w9nG3uY9h1R2faOOIGmA+yyp0xxoHzttniLYnR2/HAOmkHaKe0JOn/3YKPERVg6EKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KMBltCIf; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752328946; x=1752933746; i=w_armin@gmx.de;
	bh=wWjkNGfz2QrTJCO3ffRPYeeMPs4MaL5FylSe88/LmdA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KMBltCIf2G3UDgYnPVNPt2bqfGz1qQ5L/4vfOwo7ST0/KmgErJp9QGPOQT5kpsiq
	 D9zaijaTXCLJ21arRjmK2CTqrycgejpRJUmUzu7Qac8CBo9c7xOk9yfqid459SYsx
	 0VJGqjNiBcb8DaDwKcXPGbb/929DY6WQkVrizLM8Iv9Vlrux2R79KToRY4FKcEGKq
	 S2RnUduE8peL/PyARWyXi3T+1sYY3jVOMelPHPIamLAMO2VDXLvkeNuNInG98MnJ2
	 VWYZ+rKXbrXy4OVqr8nBUKviLGXsZupO9ucCCYFjLh7fmiNHqLPRq4CMHSgt0l/mP
	 FfTPYI9aAZMXMDamPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MVN6j-1uAv2b0TGJ-00TzYL; Sat, 12 Jul 2025 16:02:26 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: Dell.Client.Kernel@dell.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-smbios-wmi: Stop touching WMI device ID
Date: Sat, 12 Jul 2025 16:02:22 +0200
Message-Id: <20250712140222.347638-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PLJfVQNQKuJZfR8n18OEctN8QvyvV8QgfMrse0Z/elglOys/vZ9
 Mr8N46boN/LU+gxsZ5F6djslb3V7Il77yrShL/Ig6S5ty6oD1CxCmqpXFZGR11IcYJIPFov
 k6QWunONz2a7/wAl1/o4h6BaCktkWDgAoB7lfLNODmspREC4X+UU3SH3BY5UQz7GTQwVj/K
 uXAK0l1lyQhCP/0CF9OLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DAPsPdVYskY=;kPP8c4N16c5EEk9XUOD6k8Ju21b
 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
 gT+Yy2HSqu0ANQ=

The WMI core itself uses wdev->dev.id internally to track device IDs,
so modifying this value will result in a resource leak.

Fix this by not using the device ID for SMBIOS prioritization.

Tested on a Dell Inspiron 3505.

Fixes: 73f0f2b52c5e ("platform/x86: wmi: Fix WMI device naming issue")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-smbios-base.c | 19 +++++++++----------
 drivers/platform/x86/dell/dell-smbios-smm.c  |  3 +--
 drivers/platform/x86/dell/dell-smbios-wmi.c  |  4 +---
 drivers/platform/x86/dell/dell-smbios.h      |  2 +-
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platfo=
rm/x86/dell/dell-smbios-base.c
index 01c72b91a50d..444786102f02 100644
=2D-- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -39,6 +39,7 @@ struct token_sysfs_data {
 struct smbios_device {
 	struct list_head list;
 	struct device *device;
+	int priority;
 	int (*call_fn)(struct calling_interface_buffer *arg);
 };
=20
@@ -145,7 +146,7 @@ int dell_smbios_error(int value)
 }
 EXPORT_SYMBOL_GPL(dell_smbios_error);
=20
-int dell_smbios_register_device(struct device *d, void *call_fn)
+int dell_smbios_register_device(struct device *d, int priority, void *cal=
l_fn)
 {
 	struct smbios_device *priv;
=20
@@ -154,6 +155,7 @@ int dell_smbios_register_device(struct device *d, void=
 *call_fn)
 		return -ENOMEM;
 	get_device(d);
 	priv->device =3D d;
+	priv->priority =3D priority;
 	priv->call_fn =3D call_fn;
 	mutex_lock(&smbios_mutex);
 	list_add_tail(&priv->list, &smbios_device_list);
@@ -292,28 +294,25 @@ EXPORT_SYMBOL_GPL(dell_smbios_call_filter);
=20
 int dell_smbios_call(struct calling_interface_buffer *buffer)
 {
-	int (*call_fn)(struct calling_interface_buffer *) =3D NULL;
-	struct device *selected_dev =3D NULL;
+	struct smbios_device *selected =3D NULL;
 	struct smbios_device *priv;
 	int ret;
=20
 	mutex_lock(&smbios_mutex);
 	list_for_each_entry(priv, &smbios_device_list, list) {
-		if (!selected_dev || priv->device->id >=3D selected_dev->id) {
-			dev_dbg(priv->device, "Trying device ID: %d\n",
-				priv->device->id);
-			call_fn =3D priv->call_fn;
-			selected_dev =3D priv->device;
+		if (!selected || priv->priority >=3D selected->priority) {
+			dev_dbg(priv->device, "Trying device ID: %d\n", priv->priority);
+			selected =3D priv;
 		}
 	}
=20
-	if (!selected_dev) {
+	if (!selected) {
 		ret =3D -ENODEV;
 		pr_err("No dell-smbios drivers are loaded\n");
 		goto out_smbios_call;
 	}
=20
-	ret =3D call_fn(buffer);
+	ret =3D selected->call_fn(buffer);
=20
 out_smbios_call:
 	mutex_unlock(&smbios_mutex);
diff --git a/drivers/platform/x86/dell/dell-smbios-smm.c b/drivers/platfor=
m/x86/dell/dell-smbios-smm.c
index 4d375985c85f..7055e2c40f34 100644
=2D-- a/drivers/platform/x86/dell/dell-smbios-smm.c
+++ b/drivers/platform/x86/dell/dell-smbios-smm.c
@@ -125,8 +125,7 @@ int init_dell_smbios_smm(void)
 	if (ret)
 		goto fail_platform_device_add;
=20
-	ret =3D dell_smbios_register_device(&platform_device->dev,
-					  &dell_smbios_smm_call);
+	ret =3D dell_smbios_register_device(&platform_device->dev, 0, &dell_smbi=
os_smm_call);
 	if (ret)
 		goto fail_register;
=20
diff --git a/drivers/platform/x86/dell/dell-smbios-wmi.c b/drivers/platfor=
m/x86/dell/dell-smbios-wmi.c
index ae9012549560..a7dca8c59d60 100644
=2D-- a/drivers/platform/x86/dell/dell-smbios-wmi.c
+++ b/drivers/platform/x86/dell/dell-smbios-wmi.c
@@ -264,9 +264,7 @@ static int dell_smbios_wmi_probe(struct wmi_device *wd=
ev, const void *context)
 	if (ret)
 		return ret;
=20
-	/* ID is used by dell-smbios to set priority of drivers */
-	wdev->dev.id =3D 1;
-	ret =3D dell_smbios_register_device(&wdev->dev, &dell_smbios_wmi_call);
+	ret =3D dell_smbios_register_device(&wdev->dev, 1, &dell_smbios_wmi_call=
);
 	if (ret)
 		return ret;
=20
diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x8=
6/dell/dell-smbios.h
index 77baa15eb523..f421b8533a9e 100644
=2D-- a/drivers/platform/x86/dell/dell-smbios.h
+++ b/drivers/platform/x86/dell/dell-smbios.h
@@ -64,7 +64,7 @@ struct calling_interface_structure {
 	struct calling_interface_token tokens[];
 } __packed;
=20
-int dell_smbios_register_device(struct device *d, void *call_fn);
+int dell_smbios_register_device(struct device *d, int priority, void *cal=
l_fn);
 void dell_smbios_unregister_device(struct device *d);
=20
 int dell_smbios_error(int value);
=2D-=20
2.39.5


