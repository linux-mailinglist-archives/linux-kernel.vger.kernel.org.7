Return-Path: <linux-kernel+bounces-741395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A39B0E394
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F00E56394E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0E92820B6;
	Tue, 22 Jul 2025 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="tsBqQO+e"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D523B60F;
	Tue, 22 Jul 2025 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209537; cv=none; b=jkrQYULShKo9u6m3qHat1y1yZqtSwssNw6aCQcHK+YOk3tC/MM8KHT2y6hc6/746NSu90PMq/m88/bsWwEu7daGnjyKoYRY6v/2nEkI17yx2Mi/FbLcRoJIab8cMQP2rBLaDSyu0wg8rtjmnZxzkEpqEdkkKcbeJ/oc5KW04cPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209537; c=relaxed/simple;
	bh=VWLgtMwB/N5XqdJJb0pKehXNZoWX381xk8O3plV62WY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gp6Lw5rq5lZrLy6aLrXc94HigrT6vozAFFE2WUlE40u1Gub+HVTA7wjJMMpuviUXc3XTAR6xPgRBmAbowsvjzq+a36EMkqf9rwnEyBFGcBM32xOXy7DrCdyR7cpsRmTJST94t2ENELRwP9+HEyEskXoZI7yaU0oZYtukFXr09iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=tsBqQO+e; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753209525; x=1753814325; i=w_armin@gmx.de;
	bh=hQ7Ejgi69E9CHPlq3k43hNlSAhN/MDyFhPdHBU8j/sg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tsBqQO+eryE9/nq/xEHP0fMsE8hFpkXkHv4AvPwLwcBmQYvnRIhU8sCvAkPXThpa
	 KnasG2Pkd68rqZZqtjyumgDs8F/mBzBSahfFpfA7vk1Au/LlI2vEKIyFktZvYJQFd
	 Qkj2jvO+Yd3lyEApfzAgIDLETYwhM6I+2HUrU/aGGGYGeMPc5x2osjPFZNzxaFMyO
	 4RY3kHubX5nWnQvAyiRcl7KI0qgvF/96SOeX2YiBxhQFmN6MjHeYZpt91zoxb+2iq
	 4PGaV6Q1BguQnTWVpkCi+K4fEHJ/El8a0thkX8dNHxGF5fT+Jq/FhRGAa2TeMT2vO
	 VWdlYTB1ugcSC96EPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MRCKC-1uH6jA2LP2-00JDZM; Tue, 22 Jul 2025 20:38:44 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: Dell.Client.Kernel@dell.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: dell-smbios-wmi: Stop touching WMI device ID
Date: Tue, 22 Jul 2025 20:38:41 +0200
Message-Id: <20250722183841.9552-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FlYIsSP65aPa9K4D4gCi9AZNT+i+1QykOFlZ8WGP6F8JVHtwvIC
 ANQs9NlaJpKAHPvVb3sqdzUIFjqGW2BDjZII03F3qs8bNd3EGapotK9IBETsZ2JQor5yPGP
 xYE5N2vgEDMuCHUcgDYMWm4Lbms6JukPH5vsCSQgsDT+KngyKbSPd3aooJD3fJkJYmhczWX
 d+fe/8jA4iJxuFOMbmcyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XxdEUfZOZvw=;ZKedF9w/kqElTAL8mzjIN4XoDBQ
 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

The Dell SMBIOS driver uses the "id" field inside struct device for
prioritizing the WMI backend over the SMM backend. Because of this
the WMI backend modifies the "id" field of the underlying WMI device.
However the WMI core itself uses wdev->dev.id internally to track
device IDs, so modifying this value will result in a resource leak.

Fix this by not using the "id" field inside struct device for SMBIOS
prioritization. Instead extend struct smbios_device with a separate
"priority" field.

Tested on a Dell Inspiron 3505.

Fixes: 73f0f2b52c5e ("platform/x86: wmi: Fix WMI device naming issue")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v2:
- improve commit message
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


