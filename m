Return-Path: <linux-kernel+bounces-861805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DCFBF3B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB7324FDBF9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EAE33508D;
	Mon, 20 Oct 2025 21:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0mfOJNd"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611633346B4
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995090; cv=none; b=e+OcMcjtpbrNMRXWBtepanatavvajThMRFAf7gW+vIBk6z6LFKO95YyJo3PHv42lzsc/Iw9/d2yETAM/IgdjciwuQF5cTdLSHMnpVEXeE7BhFyItrNqEYQF1QmGGSzaDxOXUat+SqlV3poa57DAnqno9nqvDn1GzETJFGKmxHzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995090; c=relaxed/simple;
	bh=EYbxRsklhtHtd95cm4tsuK4kNgK7N+DBs44i6sxjiz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apKHEqoQ/5S8HQfE2ePNqszwHQfr8noLkgscs1/KU1Z8cr89x2ZX9A8iGJw+6kSy9hoN/EIFH9UTfpNjRpcCyUVcxUJG58eskfAxa+69sx1U0bPedfJTf2Vu2fUHLjJ5Q/ir9UjUeKxgOJjv7ZyWKj2GStwW35Yr245Jxu76djE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0mfOJNd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-471076f819bso38315425e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760995086; x=1761599886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8S1ji7PEyADR0wkX50xChdrFSlFaOFL4aD3skFdXec=;
        b=W0mfOJNdSki8Imsupw3EdTKY+qzSPxjMXWwSiK9cj0NIewqXpvjEpATvJ4u2XRH7aL
         fde9urdrkYrBs8u0pbgR899Su+0OiZmzyYiCBPt2ds6Hr0DDYhBKbH5yiYg7PU0FpZSw
         j/fVGM4h//gbCabvYRaABD2zuBLHBb8Wx9Rwsdbfh36vEolETTKkX2hLE0vQOYPg7IYs
         THKzJhcXyulY7pFrmhtNhjTVTSu51FLOtIAgUg60+7iKCo08wieiDMyViJ3rYw/eMPNI
         GzJOE6/QRU6VGKtQ4d+WhzyNdmkUMQ3DqAQ23aYj/6UUoe4Waw9YaRdsgYJo9JJ7NGx6
         jS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995086; x=1761599886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8S1ji7PEyADR0wkX50xChdrFSlFaOFL4aD3skFdXec=;
        b=R0a+DPo1sKoDuvZH4VKWqeAvqFGJfkCTMYfTXRY5L0q4tyrKe8zsYLTVKp3k7K3KN0
         CxLJg+DPfSc5Ghvs44mV680FmqzzIDR5C2aO/Ni00tshfjKTjU1pEOlH4hLBDeIRxGZ+
         Y+b7K6aOmX1tbXMITnrN27R+WvYRGF5H1S58BZwmjRkwfJRBD6WTj/BPGKhLA3iCFPxY
         e1cjiMNJ7QpDIj7YqktRQi5TouACaW91JBpvWMDh1YHbQt7KzZs+ppqirQPOzfFdm5Jo
         +H3oSrJ2nWCPV6mjGHMi1bJ8vSsWgWIE5UdXXqdAO70v10DqHbjGWhG9YfH3zSaat5oe
         QwTQ==
X-Gm-Message-State: AOJu0YwouCMIhSuKD+GOW2NJ1YYFN0ZWPFPsTIdmICdnLIA1vgHJy4J9
	gcW1ViO5CMxrZDw1L5G2m59x2WqlzOVksP/rUraDa2DnrowcbTCMeg9Qc05TkA==
X-Gm-Gg: ASbGncstCCSxNDDXUtFY8d+HE6D6RZFpAbiVSRerH6IWcMYjblEimyY1oblz2gxfOF3
	EmFn3VBEFmwpC5k5/TSmVZ5zsZOL3Wcy1l/ip85h4W0/OZh3sfxn8mfFNz19WC+DLUp+D5/uBZ6
	DlUotySy+fwvyOBwNkxlXO7Fbl0Hgf3uk7hd6RZ08Pl5wfrstJgYX9nENJPw99xE5WCQa2eovsy
	6b40rQsr48J18sKLUSGW6TFcIXZzwMYXyspW23oZTyvJAh/4/UmN86UUcqtdg/lfCKaJSGeFFbC
	Zya5Wfhsw/Ga6reJqhIhwewipEW1WrIDZHHpiooeI9P75rqa8OzDqKbAqAJarNMjevTBAzhwpi5
	OKZOBJ3nMI4GEAslej06QRMRRAmIJivgsNkKkjVmzJlA8dMVD/c1w9l20ucHNUyPdXg/bLW2lvQ
	1Byq8TUYmyeOhC
X-Google-Smtp-Source: AGHT+IEqxXX/KGUgXpJqqHoOUaJnHg0/BSwG8fwQL7ufr9rX7FnJCEa27hDLjpgorSaJEmR1of3atw==
X-Received: by 2002:a05:600c:34c7:b0:46f:b42e:e360 with SMTP id 5b1f17b1804b1-47117931edcmr107036765e9.40.1760995085329;
        Mon, 20 Oct 2025 14:18:05 -0700 (PDT)
Received: from denis-pc ([151.49.75.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a976sm17254971f8f.32.2025.10.20.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:18:05 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Alok Tiwari" <alok.a.tiwari@oracle.com>,
	"Derek John Clark" <derekjohn.clark@gmail.com>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	porfet828@gmail.com,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v15 7/9] platform/x86: asus-wmi: deprecate bios features
Date: Mon, 20 Oct 2025 23:17:38 +0200
Message-ID: <20251020211740.719676-8-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251020211740.719676-1-benato.denis96@gmail.com>
References: <20251020211740.719676-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Luke D. Jones" <luke@ljones.dev>

With the existence of the asus-armoury module the attributes no longer
need to live under the /sys/devices/platform/asus-nb-wmi/ path.

Deprecate all those that were implemented in asus-bioscfg with the goal
of removing them fully in the next LTS cycle.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Denis Benato <benato.denis96@gmail.com>
---
 .../ABI/testing/sysfs-platform-asus-wmi       |  17 +++
 drivers/platform/x86/Kconfig                  |  11 ++
 drivers/platform/x86/asus-wmi.c               | 121 ++++++++++++++----
 3 files changed, 124 insertions(+), 25 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
index 28144371a0f1..89acb6638df8 100644
--- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
+++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
@@ -63,6 +63,7 @@ Date:		Aug 2022
 KernelVersion:	6.1
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Switch the GPU hardware MUX mode. Laptops with this feature can
 		can be toggled to boot with only the dGPU (discrete mode) or in
 		standard Optimus/Hybrid mode. On switch a reboot is required:
@@ -75,6 +76,7 @@ Date:		Aug 2022
 KernelVersion:	5.17
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Disable discrete GPU:
 			* 0 - Enable dGPU,
 			* 1 - Disable dGPU
@@ -84,6 +86,7 @@ Date:		Aug 2022
 KernelVersion:	5.17
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Enable the external GPU paired with ROG X-Flow laptops.
 		Toggling this setting will also trigger ACPI to disable the dGPU:
 
@@ -95,6 +98,7 @@ Date:		Aug 2022
 KernelVersion:	5.17
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Enable an LCD response-time boost to reduce or remove ghosting:
 			* 0 - Disable,
 			* 1 - Enable
@@ -104,6 +108,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Get the current charging mode being used:
 			* 1 - Barrel connected charger,
 			* 2 - USB-C charging
@@ -114,6 +119,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Show if the egpu (XG Mobile) is correctly connected:
 			* 0 - False,
 			* 1 - True
@@ -123,6 +129,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Change the mini-LED mode:
 			* 0 - Single-zone,
 			* 1 - Multi-zone
@@ -133,6 +140,7 @@ Date:		Apr 2024
 KernelVersion:	6.10
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		List the available mini-led modes.
 
 What:		/sys/devices/platform/<platform>/ppt_pl1_spl
@@ -140,6 +148,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Set the Package Power Target total of CPU: PL1 on Intel, SPL on AMD.
 		Shown on Intel+Nvidia or AMD+Nvidia based systems:
 
@@ -150,6 +159,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Set the Slow Package Power Tracking Limit of CPU: PL2 on Intel, SPPT,
 		on AMD. Shown on Intel+Nvidia or AMD+Nvidia based systems:
 
@@ -160,6 +170,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Set the Fast Package Power Tracking Limit of CPU. AMD+Nvidia only:
 			* min=5, max=250
 
@@ -168,6 +179,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Set the APU SPPT limit. Shown on full AMD systems only:
 			* min=5, max=130
 
@@ -176,6 +188,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Set the platform SPPT limit. Shown on full AMD systems only:
 			* min=5, max=130
 
@@ -184,6 +197,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Set the dynamic boost limit of the Nvidia dGPU:
 			* min=5, max=25
 
@@ -192,6 +206,7 @@ Date:		Jun 2023
 KernelVersion:	6.5
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Set the target temperature limit of the Nvidia dGPU:
 			* min=75, max=87
 
@@ -200,6 +215,7 @@ Date:		Apr 2024
 KernelVersion:	6.10
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Set if the BIOS POST sound is played on boot.
 			* 0 - False,
 			* 1 - True
@@ -209,6 +225,7 @@ Date:		Apr 2024
 KernelVersion:	6.10
 Contact:	"Luke Jones" <luke@ljones.dev>
 Description:
+        DEPRECATED, WILL BE REMOVED SOON: please use asus-armoury
 		Set if the MCU can go in to low-power mode on system sleep
 			* 0 - False,
 			* 1 - True
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 8b827680754c..a17288401746 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -296,6 +296,17 @@ config ASUS_WMI
 	  To compile this driver as a module, choose M here: the module will
 	  be called asus-wmi.
 
+config ASUS_WMI_DEPRECATED_ATTRS
+	bool "BIOS option support in WMI platform (DEPRECATED)"
+	depends on ASUS_WMI
+	default y
+	help
+	  Say Y to expose the configurable BIOS options through the asus-wmi
+	  driver.
+
+	  This can be used with or without the asus-armoury driver which
+	  has the same attributes, but more, and better features.
+
 config ASUS_NB_WMI
 	tristate "Asus Notebook WMI Driver"
 	depends on ASUS_WMI
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index ff98267e5981..6de633d4a748 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -338,6 +338,13 @@ struct asus_wmi {
 /* Global to allow setting externally without requiring driver data */
 static enum asus_ally_mcu_hack use_ally_mcu_hack = ASUS_WMI_ALLY_MCU_HACK_INIT;
 
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
+static void asus_wmi_show_deprecated(void)
+{
+	pr_notice_once("Accessing attributes through /sys/bus/platform/asus_wmi is deprecated and will be removed in a future release. Please switch over to /sys/class/firmware_attributes.\n");
+}
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
+
 /* WMI ************************************************************************/
 
 static int asus_wmi_evaluate_method3(u32 method_id,
@@ -730,6 +737,7 @@ static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
 }
 
 /* Charging mode, 1=Barrel, 2=USB ******************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static ssize_t charge_mode_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -740,12 +748,16 @@ static ssize_t charge_mode_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", value & 0xff);
 }
 
 static DEVICE_ATTR_RO(charge_mode);
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 /* dGPU ********************************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static ssize_t dgpu_disable_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -756,6 +768,8 @@ static ssize_t dgpu_disable_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -809,8 +823,10 @@ static ssize_t dgpu_disable_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(dgpu_disable);
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 /* eGPU ********************************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static ssize_t egpu_enable_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -821,6 +837,8 @@ static ssize_t egpu_enable_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -877,8 +895,10 @@ static ssize_t egpu_enable_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(egpu_enable);
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 /* Is eGPU connected? *********************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static ssize_t egpu_connected_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -889,12 +909,16 @@ static ssize_t egpu_connected_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
 static DEVICE_ATTR_RO(egpu_connected);
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 /* gpu mux switch *************************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static ssize_t gpu_mux_mode_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -905,6 +929,8 @@ static ssize_t gpu_mux_mode_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -963,6 +989,7 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(gpu_mux_mode);
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 /* TUF Laptop Keyboard RGB Modes **********************************************/
 static ssize_t kbd_rgb_mode_store(struct device *dev,
@@ -1086,6 +1113,7 @@ static const struct attribute_group *kbd_rgb_mode_groups[] = {
 };
 
 /* Tunable: PPT: Intel=PL1, AMD=SPPT *****************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static ssize_t ppt_pl2_sppt_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
@@ -1124,6 +1152,8 @@ static ssize_t ppt_pl2_sppt_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_pl2_sppt);
 }
 static DEVICE_ATTR_RW(ppt_pl2_sppt);
@@ -1166,6 +1196,8 @@ static ssize_t ppt_pl1_spl_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_pl1_spl);
 }
 static DEVICE_ATTR_RW(ppt_pl1_spl);
@@ -1209,6 +1241,8 @@ static ssize_t ppt_fppt_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_fppt);
 }
 static DEVICE_ATTR_RW(ppt_fppt);
@@ -1252,6 +1286,8 @@ static ssize_t ppt_apu_sppt_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_apu_sppt);
 }
 static DEVICE_ATTR_RW(ppt_apu_sppt);
@@ -1295,6 +1331,8 @@ static ssize_t ppt_platform_sppt_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->ppt_platform_sppt);
 }
 static DEVICE_ATTR_RW(ppt_platform_sppt);
@@ -1338,6 +1376,8 @@ static ssize_t nv_dynamic_boost_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->nv_dynamic_boost);
 }
 static DEVICE_ATTR_RW(nv_dynamic_boost);
@@ -1381,9 +1421,12 @@ static ssize_t nv_temp_target_show(struct device *dev,
 {
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%u\n", asus->nv_temp_target);
 }
 static DEVICE_ATTR_RW(nv_temp_target);
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 /* Ally MCU Powersave ********************************************************/
 
@@ -1424,6 +1467,7 @@ void set_ally_mcu_powersave(bool enabled)
 }
 EXPORT_SYMBOL_NS_GPL(set_ally_mcu_powersave, "ASUS_WMI");
 
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static ssize_t mcu_powersave_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -1434,6 +1478,8 @@ static ssize_t mcu_powersave_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -1469,6 +1515,7 @@ static ssize_t mcu_powersave_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(mcu_powersave);
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 /* Battery ********************************************************************/
 
@@ -2342,6 +2389,7 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
 }
 
 /* Panel Overdrive ************************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static ssize_t panel_od_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -2352,6 +2400,8 @@ static ssize_t panel_od_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -2388,9 +2438,10 @@ static ssize_t panel_od_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(panel_od);
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 /* Bootup sound ***************************************************************/
-
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static ssize_t boot_sound_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -2401,6 +2452,8 @@ static ssize_t boot_sound_show(struct device *dev,
 	if (result < 0)
 		return result;
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", result);
 }
 
@@ -2436,8 +2489,10 @@ static ssize_t boot_sound_store(struct device *dev,
 	return count;
 }
 static DEVICE_ATTR_RW(boot_sound);
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 /* Mini-LED mode **************************************************************/
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static ssize_t mini_led_mode_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -2468,6 +2523,8 @@ static ssize_t mini_led_mode_show(struct device *dev,
 		}
 	}
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "%d\n", value);
 }
 
@@ -2538,10 +2595,13 @@ static ssize_t available_mini_led_mode_show(struct device *dev,
 		return sysfs_emit(buf, "0 1 2\n");
 	}
 
+	asus_wmi_show_deprecated();
+
 	return sysfs_emit(buf, "0\n");
 }
 
 static DEVICE_ATTR_RO(available_mini_led_mode);
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 /* Quirks *********************************************************************/
 
@@ -3829,6 +3889,7 @@ static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
 	return throttle_thermal_policy_write(asus);
 }
 
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 static ssize_t throttle_thermal_policy_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -3872,6 +3933,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
  * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
  */
 static DEVICE_ATTR_RW(throttle_thermal_policy);
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 /* Platform profile ***********************************************************/
 static int asus_wmi_platform_profile_get(struct device *dev,
@@ -4473,27 +4535,29 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
 	&dev_attr_cardr.attr,
 	&dev_attr_touchpad.attr,
-	&dev_attr_charge_mode.attr,
-	&dev_attr_egpu_enable.attr,
-	&dev_attr_egpu_connected.attr,
-	&dev_attr_dgpu_disable.attr,
-	&dev_attr_gpu_mux_mode.attr,
 	&dev_attr_lid_resume.attr,
 	&dev_attr_als_enable.attr,
 	&dev_attr_fan_boost_mode.attr,
-	&dev_attr_throttle_thermal_policy.attr,
-	&dev_attr_ppt_pl2_sppt.attr,
-	&dev_attr_ppt_pl1_spl.attr,
-	&dev_attr_ppt_fppt.attr,
-	&dev_attr_ppt_apu_sppt.attr,
-	&dev_attr_ppt_platform_sppt.attr,
-	&dev_attr_nv_dynamic_boost.attr,
-	&dev_attr_nv_temp_target.attr,
-	&dev_attr_mcu_powersave.attr,
-	&dev_attr_boot_sound.attr,
-	&dev_attr_panel_od.attr,
-	&dev_attr_mini_led_mode.attr,
-	&dev_attr_available_mini_led_mode.attr,
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
+		&dev_attr_charge_mode.attr,
+		&dev_attr_egpu_enable.attr,
+		&dev_attr_egpu_connected.attr,
+		&dev_attr_dgpu_disable.attr,
+		&dev_attr_gpu_mux_mode.attr,
+		&dev_attr_ppt_pl2_sppt.attr,
+		&dev_attr_ppt_pl1_spl.attr,
+		&dev_attr_ppt_fppt.attr,
+		&dev_attr_ppt_apu_sppt.attr,
+		&dev_attr_ppt_platform_sppt.attr,
+		&dev_attr_nv_dynamic_boost.attr,
+		&dev_attr_nv_temp_target.attr,
+		&dev_attr_mcu_powersave.attr,
+		&dev_attr_boot_sound.attr,
+		&dev_attr_panel_od.attr,
+		&dev_attr_mini_led_mode.attr,
+		&dev_attr_available_mini_led_mode.attr,
+		&dev_attr_throttle_thermal_policy.attr,
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 	NULL
 };
 
@@ -4515,7 +4579,11 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_LID_RESUME;
 	else if (attr == &dev_attr_als_enable.attr)
 		devid = ASUS_WMI_DEVID_ALS_ENABLE;
-	else if (attr == &dev_attr_charge_mode.attr)
+	else if (attr == &dev_attr_fan_boost_mode.attr)
+		ok = asus->fan_boost_mode_available;
+
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
+	if (attr == &dev_attr_charge_mode.attr)
 		devid = ASUS_WMI_DEVID_CHARGE_MODE;
 	else if (attr == &dev_attr_egpu_enable.attr)
 		ok = asus->egpu_enable_available;
@@ -4553,6 +4621,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		ok = asus->mini_led_dev_id != 0;
 	else if (attr == &dev_attr_available_mini_led_mode.attr)
 		ok = asus->mini_led_dev_id != 0;
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 	if (devid != -1) {
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
@@ -4808,6 +4877,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 	}
 
 	/* ensure defaults for tunables */
+#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
 	asus->ppt_pl2_sppt = 5;
 	asus->ppt_pl1_spl = 5;
 	asus->ppt_apu_sppt = 5;
@@ -4830,17 +4900,18 @@ static int asus_wmi_add(struct platform_device *pdev)
 		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX;
 	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX_VIVO))
 		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX_VIVO;
-
-	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE))
-		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE;
-	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
-		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
+#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
 
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
 		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY;
 	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO))
 		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE))
+		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE;
+	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
+		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
-- 
2.51.1


