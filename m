Return-Path: <linux-kernel+bounces-861801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8992BF3B06
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C30B34ED706
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB5334C09;
	Mon, 20 Oct 2025 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt1vaaQI"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724E334363
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995087; cv=none; b=MiIUdpjuC9FGejGyQN9IQpmSRhm0/NuL8PG4ybXz6cyIXC9br5V+hWVISAnos36MviGLLXHgJMJKVOqHIGB04Y/44sEF1GO6ABgnRDTg/LnwFSoJrn3wwPVGN3xJjvld9Po4nZ1PqmYmJNc5KL+ox9cARjFCAy+iLhpPkh/U+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995087; c=relaxed/simple;
	bh=dDKQb2Jp752Rl00PjZyJdgg+I14sXcmVVgxBGh7MIOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eb5U12V4aoispS+1OHKcd0MKWMD59h3MFz2xERVOfBrmgDUjMuec61o3VrKgpJJPooFwJGlXC0AEJkL+nsd83h0Ks/dIT+z5mMekLuBHoTcxc/1huIWOjYUx7CAjhedVRxPkAOlkFSvYW2XMDmq5mj2Ix0D+dvV/6iNTI9G18X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bt1vaaQI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so375119f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760995082; x=1761599882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24k/+IQksUqDs45sTJ+Ur00fPTiqMg/ZZl9NEKDMYks=;
        b=bt1vaaQIEfnVdrPDqoyPNiY26r37VBO49kIz+cklmze59FDmjTzy7wLPqs5C3UBGWm
         q47DDdDQ520vZdKz1/H6wCd5OTC9qsw4NY8BcJ2aMHtnaHPM46uWyk8OPz/5Emct1dJ7
         aOkxNtuniEFChhM+O41d7ibpniVL2r0Wt/9SZTiYKZlhKX41xx/WISY7Bu6+ZjmZU4MK
         L0tlh8uFF3/GJhzGotGbzaemDlLb/KJw/LNTUhZ5gb9l3jek2jXMAlNZod6Hcafmm+o+
         Of38DYHRTLmdEqNBKWsIOGkajtzfQa/qFN1PiUC0lTA+QK2YT7qrfDix8IZD1Ch6xNVP
         0PVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760995082; x=1761599882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24k/+IQksUqDs45sTJ+Ur00fPTiqMg/ZZl9NEKDMYks=;
        b=bCGWy9DAOTQ7qE9BdSL+zrPFRO2wh+6UbPVDqyBmt5krxgQsjowu/9Ig7GSLxYzdTt
         H1nL3FN/jxZmkAuLT8+LL5GWldcYS5TmqvDxOOJplhkQqKQxxOQ2xAjvroY5OPWiKr9s
         D1FNlol5EJhgAGoO+vZRfr3745AEdfhzb6UsC+b7Jbb7gGZ00Yz/iPvlqI3UucLE6EEN
         iiZLnBBpWqFMhoGgpPpcP41Rwezhu5EUEAxfm2alxMPhZ7JD2hFN22axJWy8ZjwBegQg
         E3t8fmJOGKpXJZML3oKdOYx+Clf5e3Iw6xRj/7wqwoqmP1CNG0pHqP3p4HUBWgkVpgdp
         sTTA==
X-Gm-Message-State: AOJu0YwFGXPe5HbqZdpDIjDFcp2GGGaAA5SgtpacaJYBUoXvZs+sbweD
	1coB5IEtrC1gWkXs/eLxsapKS/Pj/PuOHkGkhXvWXyG8epxdp1U3nAtVD32ivg==
X-Gm-Gg: ASbGncviIXRo1f/VY/9DndKRY3hPU90GUNrVAR92F20fWYQUhuZ8urF5aFQZC3CQfLl
	uuNxGqjmp0Umx+seGDPiyTdxAGrSCybnciFcyCmtgNzckw2jywomVVYjXQ95hFTon3gqkESmDum
	3lwdQDWys+TG8ad9lTLll48QkRJCyphCCa2HqQU+TSyF+ZyKXaXVaYfEbpJ2f5ZHuDasnLwJXmw
	bFanj+lMt3ntfosvchfTsodo1MmrYsjC2+myj+vTSW7AtqWJyJq4lYme06x77g4IxyHh7l0Ca1B
	RIaFl+gEAj+J2XYn0/AyKZ4P0F6Rsyp6lgexrM5r2JA0S7nnOGbpiIKK3PRa4oo2/rSy72YQ563
	0Z3/kwxMkv2OtI3W2AkCBDRQLLCqXgIVoTkYkry3UCO28Ys3kCb6xTBstgACAgf7DCpYXq8E8RU
	57AD6fvhd28DEI
X-Google-Smtp-Source: AGHT+IFLrKXoNgxDPNQk6LahfMwrO+Tj4kcxzlq3EU2jhpKwtDEEELftfcXKg9PZZJJInoIlYy9/pg==
X-Received: by 2002:a5d:5888:0:b0:426:f38a:a51 with SMTP id ffacd0b85a97d-42704d8d684mr11154732f8f.22.1760995082423;
        Mon, 20 Oct 2025 14:18:02 -0700 (PDT)
Received: from denis-pc ([151.49.75.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a976sm17254971f8f.32.2025.10.20.14.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 14:18:02 -0700 (PDT)
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
Subject: [PATCH v15 4/9] platform/x86: asus-armoury: add apu-mem control support
Date: Mon, 20 Oct 2025 23:17:35 +0200
Message-ID: <20251020211740.719676-5-benato.denis96@gmail.com>
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

Implement the APU memory size control under the asus-armoury module using
the fw_attributes class.

This allows the APU allocated memory size to be adjusted depending on
the users priority. A reboot is required after change.

Co-developed-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-armoury.c        | 105 ++++++++++++++++++++-
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index 20edf4f5370a..fe80d5d04300 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -160,11 +160,12 @@ static int armoury_get_devstate(struct kobj_attribute *attr, u32 *retval, u32 de
  * armoury_set_devstate() - Set the WMI function state.
  * @attr: The kobj_attribute associated to called WMI function.
  * @dev_id: The WMI method ID to call.
- * @retval:
- * * Pointer to where to store the value returned from WMI or NULL.
+ * @retval: Where to store the value returned from WMI or NULL.
  *
  * Intended usage is from sysfs attribute setting associated WMI function.
- * Before calling set the presence of the function should be checked.
+ * Before calling the presence of the function should be checked.
+ *
+ * Every WMI write MUST go through this function to enforce safety checks.
  *
  * Results !1 is usually considered a fail by ASUS, but some WMI methods
  * (like eGPU or CPU cores) do use > 1 to return a status code or similar:
@@ -172,6 +173,7 @@ static int armoury_get_devstate(struct kobj_attribute *attr, u32 *retval, u32 de
  * and should perform relevant checks.
  *
  * Returns:
+ * * %-EINVAL	- attempt to set a dangerous or unsupported value.
  * * %-EIO	- WMI function returned an error.
  * * %0		- successful and retval is filled.
  * * %other	- error from WMI call.
@@ -182,6 +184,26 @@ static int armoury_set_devstate(struct kobj_attribute *attr,
 	u32 result;
 	int err;
 
+	/*
+	 * Prevent developers from bricking devices or issuing dangerous
+	 * commands that can be difficult or impossible to recover from.
+	 */
+	switch (dev_id) {
+	case ASUS_WMI_DEVID_APU_MEM:
+		/*
+		 * A hard reset might suffice to save the device,
+		 * but there is no value in sending these commands.
+		 */
+		if (value == 0x100 || value == 0x101) {
+			pr_err("Refusing to set APU memory to unsafe value: 0x%x\n", value);
+			return -EINVAL;
+		}
+		break;
+	default:
+		/* No known problems are known for this dev_id */
+		break;
+	}
+
 	err = asus_wmi_set_devstate(dev_id, value, retval ? retval : &result);
 	if (err) {
 		if (attr)
@@ -592,6 +614,82 @@ static ssize_t egpu_enable_possible_values_show(struct kobject *kobj, struct kob
 }
 ASUS_ATTR_GROUP_ENUM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
 
+/* Device memory available to APU */
+
+/*
+ * Values map for APU reserved memory (index + 1 number of GB).
+ * Some looks out of order, but are actually correct.
+ */
+static u32 apu_mem_map[] = {
+	[0] = 0x000, /* called "AUTO" on the BIOS, is the minimum available */
+	[1] = 0x102,
+	[2] = 0x103,
+	[3] = 0x104,
+	[4] = 0x105,
+	[5] = 0x107,
+	[6] = 0x108,
+	[7] = 0x109,
+	[8] = 0x106,
+};
+
+static ssize_t apu_mem_current_value_show(struct kobject *kobj, struct kobj_attribute *attr,
+					  char *buf)
+{
+	int err;
+	u32 mem;
+
+	err = armoury_get_devstate(attr, &mem, ASUS_WMI_DEVID_APU_MEM);
+	if (err)
+		return err;
+
+	/* After 0x000 is set, a read will return 0x100 */
+	if (mem == 0x100)
+		return sysfs_emit(buf, "0\n");
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(apu_mem_map); i++) {
+		if (apu_mem_map[i] == mem)
+			return sysfs_emit(buf, "%u\n", i);
+	}
+
+	pr_warn("Unrecognised value for APU mem 0x%08x\n", mem);
+	return -EIO;
+}
+
+static ssize_t apu_mem_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	int result, err;
+	u32 requested, mem;
+
+	result = kstrtou32(buf, 10, &requested);
+	if (result)
+		return result;
+
+	if (requested >= ARRAY_SIZE(apu_mem_map))
+		return -EINVAL;
+	mem = apu_mem_map[requested];
+
+	err = armoury_set_devstate(attr, mem, NULL, ASUS_WMI_DEVID_APU_MEM);
+	if (err) {
+		pr_warn("Failed to set apu_mem 0x%x: %d\n", mem, err);
+		return err;
+	}
+
+	pr_info("APU memory changed to %uGB, reboot required\n", requested + 1);
+	sysfs_notify(kobj, NULL, attr->attr.name);
+
+	asus_set_reboot_and_signal_event();
+
+	return count;
+}
+
+static ssize_t apu_mem_possible_values_show(struct kobject *kobj, struct kobj_attribute *attr,
+					    char *buf)
+{
+	return attr_enum_list(buf, ARRAY_SIZE(apu_mem_map));
+}
+ASUS_ATTR_GROUP_ENUM(apu_mem, "apu_mem", "Set available system RAM (in GB) for the APU to use");
+
 /* Simple attribute creation */
 ASUS_ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
 			    "Show the current mode of charging");
@@ -611,6 +709,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
 	{ &egpu_enable_attr_group, ASUS_WMI_DEVID_EGPU },
 	{ &dgpu_disable_attr_group, ASUS_WMI_DEVID_DGPU },
+	{ &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
 
 	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
 	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 10acd5d52e38..a4f6bab93a6f 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -137,6 +137,8 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+#define ASUS_WMI_DEVID_APU_MEM		0x000600C1
+
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
 #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
 #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026
-- 
2.51.1


