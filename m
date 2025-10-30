Return-Path: <linux-kernel+bounces-878270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E53C20282
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7A63BD86F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3245C355800;
	Thu, 30 Oct 2025 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JKXjsbOH"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149B354AC6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829418; cv=none; b=kcVw7fwd3OrMh1mEiSQJ0GYMWXqzpcnrJ+W9XfOwpRiTcnyTeh8/YThAJapOKpctJXO9y5ctdhZsokVNXg5fpwdTe/TwGv4VXa9Dhu17zRquXarTZgXw/BRMIg//SlPuvkCN0CXuEoCcvTZkNxTDohLY2RCTePoqZW+SUwBT/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829418; c=relaxed/simple;
	bh=WgCelcYiXNUkQIS66dk9ZX6Q4bZe6mmNi0nZxS/obPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhhXqFaSZpCsDx0EH7c0YwdexMLmPdOBHxlBLg2u+TtyXAVLoZrbc+TgfxgJGhnxMFaRia9MVdqtYukSes/GSfizRqoZB3XaOdUaWN6DvrRtccDIkfGGjvVmtshbl5ujzf7ahOFvlSSX/SotieYO352uhNFXpAIX2Z+j0MH00hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JKXjsbOH; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761829414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIyiX33X4rYFdfJHlDRY9IXFhUqnPUR/4zmQddzO7Fo=;
	b=JKXjsbOHQDxcAgyU/AYKbgUW6aV2Fzw8VMnxR/q8POQ+prHhF2D1IYZ8ttvWUGSi8LMcbF
	UUb460+I3KvCCU0pdSOHgeUpHi2NDTNrvBJDNolGmleAzPC4AKVNo8TyGircF9Ok8HeZTy
	2Eto4Y1bh/fToTiMNptHExW9D0XkrkQ=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Alok Tiwari" <alok.a.tiwari@oracle.com>,
	"Derek John Clark" <derekjohn.clark@gmail.com>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	porfet828@gmail.com,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v16 4/9] platform/x86: asus-armoury: add apu-mem control support
Date: Thu, 30 Oct 2025 14:03:15 +0100
Message-ID: <20251030130320.1287122-5-denis.benato@linux.dev>
In-Reply-To: <20251030130320.1287122-1-denis.benato@linux.dev>
References: <20251030130320.1287122-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: "Luke D. Jones" <luke@ljones.dev>

Implement the APU memory size control under the asus-armoury module using
the fw_attributes class.

This allows the APU allocated memory size to be adjusted depending on
the users priority. A reboot is required after change.

Co-developed-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
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
2.51.2


