Return-Path: <linux-kernel+bounces-757825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE9EB1C71D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CC994E2A26
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920DB28DF33;
	Wed,  6 Aug 2025 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY6ya0Et"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368CE28C87D;
	Wed,  6 Aug 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488439; cv=none; b=jWGtQR8bHQdk/qJ15OoaGGwGptcAmGBvq48/AUL+N2RszSJNyL9C6rq3/zm9kprSMHQyBEKB1Fn/RvvUKzHGitJUE9vLkRM7Ek9VMEMVBXGHBThd4lTWqa3KcFEKrYY+I2FN8owAlRx7VtOLLIC8f97CK00eqqBGP7VPfiZCQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488439; c=relaxed/simple;
	bh=NyieNGe+oF+v3JEmHPg/hCdfI+0EoAYznbT6C2k8OVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+pH5dcsg+PjDOwp141W8fuEL3zNfXC6XFH7qAZiv3GzEYAwzSLoccz0t0FcXaT3cQIXf5QdtQjeIm8QhTHgWmfDPpWYCd6dJZVw7OCz5u/FyaG7wBmTW6VUYMrq9jnXG08fiGWQ6wJRLTISjUvEgClMZqqU+CYDQt2QJSYp7jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY6ya0Et; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so3726462f8f.3;
        Wed, 06 Aug 2025 06:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754488435; x=1755093235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDR2vFZKCmVOxJ0q5lD+gqAbFKbxZlWWeU0ccf6/sqQ=;
        b=HY6ya0Etgf/DoXfBiZDQYOjBiTQWR5DE5J+Z87Tonaf1RLR+8l2X4FJhIWCpzWHxaQ
         R7RDZBsHUWgUfFkXvxCndsU8WfmOfqhM+QLB02AGATLoSvwBQ4nrCTKhI8TRsiZZtyml
         tWQ27Y7dfFty9ZD0y06ALmw6kQ0aZDdeNNeAoogevBDPacN20L00x5c4XMRlmf4MqU9v
         s4Ew6plW0oyIH+ZWuDxi9oHwU1EhsRi4jJaXVODU4v44iCVFkGVi/v6zfkXE5wZH0VdN
         zWSuKkHo9KEw/XFFQhIptPz2GxUqwedDsUUaVgQ8oJEacNABetH3dauN9YIPavFrRzFl
         Fgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754488435; x=1755093235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDR2vFZKCmVOxJ0q5lD+gqAbFKbxZlWWeU0ccf6/sqQ=;
        b=c3kcVw1AbRl8XZKEtmUH4BVShHKC5xQMVx2V/UW6zuGhcZS/iFiEULNJ2ZdTxwW8hX
         v18ZzY1r/GhxSr4Y3VjwEhFbaVrZStyPqrD0p9b1Qa0jv8sb0BTvTLWMvn579ziVKfoG
         j5YJBdcwEq2rnnjIzxrGQF/En5fm3kcFccXKv1+LDHmLl905RjyJ1raJNQFVMUIASjyL
         12FgCYJszn9ArBb7kFYOC7ZS8wJDUsL1CZKb47KwMopQUYwYULgUFGRPCccYHAzAj4z2
         AOsjrvu5NDb00bTV1TRVOya+6lmmDq+a1j0Zr7822mpl3Q4YRaXZsWxxIHeHGwuGUVHG
         Q3SQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0EvKDP2Gp2enbthsEWxr92QtxYq8ge/RVZ+4zScTztuJdltAHZOGf/AplUXu+Pqy++GE0ozmISDsZ3FswZjIdS1D6@vger.kernel.org
X-Gm-Message-State: AOJu0YzNR5oRkXjxvxddZ91OFPZdYAMrx/kVGgvsiAA9TGtM3BG+P/TF
	rKLrcPzPVqRc7qffrUafySLOj8jAN532EgB2c7TdJgJUnVuBXYUuXto3Pe3FzQ==
X-Gm-Gg: ASbGncsjo3YBbalAMamy36upfbcgUHTQdSBOQIMyeBbtZ4flgkKfv+1otdaJSHBM3Nu
	8QNcyBjYWo8hpnjHEcmCA8BOrSHDeXDLN8c9QyyUpSrnVGngVzt8Fcizv0QCQqNGKCZyDZKzQZv
	a+owOuXNRvmDEIjUj6v1keSkx5hyeLZnhicIW6bXVT4xE82WCIxue4orycztBJ0biWH7lRcSA1F
	c+hTQh3CQC2jL9QCSDm8IBY7X/2K7d8hHxCqwSndHFy8WTggDEFcdYtNPGAoSn925PjrAzxsu7p
	2Cq/uErvuGr3cIJUvXpOk/uxxJvLFsHwmET6RGGTLAF0BD5E3yGO2tsSt1BbT0cGfPicOY8jXeU
	XLHLRTnybAGcjm3hJuWn1j3h1
X-Google-Smtp-Source: AGHT+IHvrU4MHTfDrDKQ9bhNDfzUJKrdgeb4MpRKlaRoK1aYF6lroNVc6vaigTedFS1UcDU274agGg==
X-Received: by 2002:a05:6000:2486:b0:3b7:9a31:2a10 with SMTP id ffacd0b85a97d-3b8f4923f05mr2033711f8f.41.1754488435181;
        Wed, 06 Aug 2025 06:53:55 -0700 (PDT)
Received: from denis-pc ([151.49.205.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bc12csm23646087f8f.28.2025.08.06.06.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:53:54 -0700 (PDT)
From: Denis Benato <benato.denis96@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	mario.limonciello@amd.com,
	"Luke D . Jones" <luke@ljones.dev>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v10 5/8] platform/x86: asus-armoury: add core count control
Date: Wed,  6 Aug 2025 15:53:16 +0200
Message-ID: <20250806135319.1205762-6-benato.denis96@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806135319.1205762-1-benato.denis96@gmail.com>
References: <20250806135319.1205762-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Luke D. Jones" <luke@ljones.dev>

Implement Intel core enablement under the asus-armoury module using the
fw_attributes class.

This allows users to enable or disable preformance or efficiency cores
depending on their requirements. After change a reboot is required.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-armoury.c        | 258 ++++++++++++++++++++-
 drivers/platform/x86/asus-armoury.h        |  28 +++
 include/linux/platform_data/x86/asus-wmi.h |   5 +
 3 files changed, 290 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index e458d23d020d..4629389c4c25 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -45,13 +45,49 @@
 #define ASUS_MINI_LED_2024_STRONG 0x01
 #define ASUS_MINI_LED_2024_OFF    0x02
 
+#define ASUS_POWER_CORE_MASK	GENMASK(15, 8)
+#define ASUS_PERF_CORE_MASK		GENMASK(7, 0)
+
+enum cpu_core_type {
+	CPU_CORE_PERF = 0,
+	CPU_CORE_POWER,
+};
+
+enum cpu_core_value {
+	CPU_CORE_DEFAULT = 0,
+	CPU_CORE_MIN,
+	CPU_CORE_MAX,
+	CPU_CORE_CURRENT,
+};
+
+#define CPU_PERF_CORE_COUNT_MIN 4
+#define CPU_POWR_CORE_COUNT_MIN 0
+
+/* Tunables provided by ASUS for gaming laptops */
+struct cpu_cores {
+	u32 cur_perf_cores;
+	u32 min_perf_cores;
+	u32 max_perf_cores;
+	u32 cur_power_cores;
+	u32 min_power_cores;
+	u32 max_power_cores;
+};
+
 static struct asus_armoury_priv {
 	struct device *fw_attr_dev;
 	struct kset *fw_attr_kset;
 
+	struct cpu_cores *cpu_cores;
 	u32 mini_led_dev_id;
 	u32 gpu_mux_dev_id;
-} asus_armoury;
+	/*
+	 * Mutex to prevent big/little core count changes writing to same
+	 * endpoint at the same time. Must lock during attr store.
+	 */
+	struct mutex cpu_core_mutex;
+} asus_armoury = {
+	.cpu_core_mutex = __MUTEX_INITIALIZER(asus_armoury.cpu_core_mutex)
+};
 
 struct fw_attrs_group {
 	bool pending_reboot;
@@ -93,6 +129,8 @@ static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
 static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
 {
 	return !strcmp(attr->attr.name, "gpu_mux_mode") ||
+	       !strcmp(attr->attr.name, "cores_performance") ||
+	       !strcmp(attr->attr.name, "cores_efficiency") ||
 	       !strcmp(attr->attr.name, "panel_hd_mode");
 }
 
@@ -171,6 +209,12 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
 	return sysfs_emit(buf, "enumeration\n");
 }
 
+static ssize_t int_type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			     char *buf)
+{
+	return sysfs_emit(buf, "integer\n");
+}
+
 /* Mini-LED mode **************************************************************/
 static ssize_t mini_led_mode_current_value_show(struct kobject *kobj,
 						struct kobj_attribute *attr, char *buf)
@@ -474,6 +518,207 @@ static ssize_t apu_mem_possible_values_show(struct kobject *kobj, struct kobj_at
 }
 ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set available system RAM (in GB) for the APU to use");
 
+static int init_max_cpu_cores(void)
+{
+	u32 cores;
+	int err;
+
+	asus_armoury.cpu_cores = kzalloc(sizeof(struct cpu_cores), GFP_KERNEL);
+	if (!asus_armoury.cpu_cores)
+		return -ENOMEM;
+
+	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES_MAX, &cores);
+	if (err)
+		return err;
+
+	if ((cores & ASUS_WMI_DSTS_PRESENCE_BIT) == 0) {
+		pr_err("ACPI does not support CPU core count control\n");
+		err = -ENODEV;
+		goto init_max_cpu_cores_err;
+	}
+
+	asus_armoury.cpu_cores->max_power_cores = FIELD_GET(ASUS_POWER_CORE_MASK, cores);
+	asus_armoury.cpu_cores->max_perf_cores = FIELD_GET(ASUS_PERF_CORE_MASK, cores);
+
+	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_CORES, &cores);
+	if (err) {
+		pr_err("Could not get CPU core count: error %d\n", err);
+		goto init_max_cpu_cores_err;
+	}
+
+	asus_armoury.cpu_cores->cur_perf_cores = FIELD_GET(ASUS_PERF_CORE_MASK, cores);
+	asus_armoury.cpu_cores->cur_power_cores = FIELD_GET(ASUS_POWER_CORE_MASK, cores);
+
+	asus_armoury.cpu_cores->min_perf_cores = CPU_PERF_CORE_COUNT_MIN;
+	asus_armoury.cpu_cores->min_power_cores = CPU_POWR_CORE_COUNT_MIN;
+
+	return 0;
+
+init_max_cpu_cores_err:
+	kfree(asus_armoury.cpu_cores);
+	return err;
+}
+
+static ssize_t cores_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf,
+				enum cpu_core_type core_type, enum cpu_core_value core_value)
+{
+	u32 cores;
+
+	switch (core_value) {
+	case CPU_CORE_DEFAULT:
+	case CPU_CORE_MAX:
+		if (core_type == CPU_CORE_PERF)
+			return sysfs_emit(buf, "%u\n",
+					  asus_armoury.cpu_cores->max_perf_cores);
+		else
+			return sysfs_emit(buf, "%u\n",
+					  asus_armoury.cpu_cores->max_power_cores);
+	case CPU_CORE_MIN:
+		if (core_type == CPU_CORE_PERF)
+			return sysfs_emit(buf, "%u\n",
+					  asus_armoury.cpu_cores->min_perf_cores);
+		else
+			return sysfs_emit(buf, "%u\n",
+					  asus_armoury.cpu_cores->min_power_cores);
+	default:
+		break;
+	}
+
+	if (core_type == CPU_CORE_PERF)
+		cores = asus_armoury.cpu_cores->cur_perf_cores;
+	else
+		cores = asus_armoury.cpu_cores->cur_power_cores;
+
+	return sysfs_emit(buf, "%u\n", cores);
+}
+
+static ssize_t cores_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
+					 const char *buf, enum cpu_core_type core_type)
+{
+	u32 new_cores, perf_cores, power_cores, out_val, min, max;
+	int result, err;
+
+	result = kstrtou32(buf, 10, &new_cores);
+	if (result)
+		return result;
+
+	scoped_guard(mutex, &asus_armoury.cpu_core_mutex) {
+		if (core_type == CPU_CORE_PERF) {
+			perf_cores = new_cores;
+			power_cores = asus_armoury.cpu_cores->cur_power_cores;
+			min = asus_armoury.cpu_cores->min_perf_cores;
+			max = asus_armoury.cpu_cores->max_perf_cores;
+		} else {
+			perf_cores = asus_armoury.cpu_cores->cur_perf_cores;
+			power_cores = new_cores;
+			min = asus_armoury.cpu_cores->min_power_cores;
+			max = asus_armoury.cpu_cores->max_power_cores;
+		}
+
+		if (new_cores < min || new_cores > max)
+			return -EINVAL;
+
+		out_val = FIELD_PREP(ASUS_PERF_CORE_MASK, perf_cores) |
+			FIELD_PREP(ASUS_POWER_CORE_MASK, power_cores);
+
+		err = asus_wmi_set_devstate(ASUS_WMI_DEVID_CORES, out_val, &result);
+		if (err) {
+			pr_warn("Failed to set CPU core count: %d\n", err);
+			return err;
+		}
+
+		if (result > 1) {
+			pr_warn("Failed to set CPU core count (result): 0x%x\n", result);
+			return -EIO;
+		}
+	}
+
+	pr_info("CPU core count changed, reboot required\n");
+
+	sysfs_notify(kobj, NULL, attr->attr.name);
+	asus_set_reboot_and_signal_event();
+
+	return 0;
+}
+
+static ssize_t cores_performance_min_value_show(struct kobject *kobj,
+						struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_MIN);
+}
+
+static ssize_t cores_performance_max_value_show(struct kobject *kobj,
+						struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_MAX);
+}
+
+static ssize_t cores_performance_default_value_show(struct kobject *kobj,
+						    struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_DEFAULT);
+}
+
+static ssize_t cores_performance_current_value_show(struct kobject *kobj,
+						    struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_PERF, CPU_CORE_CURRENT);
+}
+
+static ssize_t cores_performance_current_value_store(struct kobject *kobj,
+						     struct kobj_attribute *attr,
+						     const char *buf, size_t count)
+{
+	int err;
+
+	err = cores_current_value_store(kobj, attr, buf, CPU_CORE_PERF);
+	if (err)
+		return err;
+
+	return count;
+}
+ATTR_GROUP_CORES_RW(cores_performance, "cores_performance",
+		    "Set the max available performance cores");
+
+static ssize_t cores_efficiency_min_value_show(struct kobject *kobj, struct kobj_attribute *attr,
+					       char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_MIN);
+}
+
+static ssize_t cores_efficiency_max_value_show(struct kobject *kobj, struct kobj_attribute *attr,
+					       char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_MAX);
+}
+
+static ssize_t cores_efficiency_default_value_show(struct kobject *kobj,
+						   struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_DEFAULT);
+}
+
+static ssize_t cores_efficiency_current_value_show(struct kobject *kobj,
+						   struct kobj_attribute *attr, char *buf)
+{
+	return cores_value_show(kobj, attr, buf, CPU_CORE_POWER, CPU_CORE_CURRENT);
+}
+
+static ssize_t cores_efficiency_current_value_store(struct kobject *kobj,
+						    struct kobj_attribute *attr, const char *buf,
+						    size_t count)
+{
+	int err;
+
+	err = cores_current_value_store(kobj, attr, buf, CPU_CORE_POWER);
+	if (err)
+		return err;
+
+	return count;
+}
+ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency",
+		    "Set the max available efficiency cores");
+
 /* Simple attribute creation */
 ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
 		       "Show the current mode of charging");
@@ -495,6 +740,8 @@ static const struct asus_attr_group armoury_attr_groups[] = {
 	{ &egpu_enable_attr_group, ASUS_WMI_DEVID_EGPU },
 	{ &dgpu_disable_attr_group, ASUS_WMI_DEVID_DGPU },
 	{ &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
+	{ &cores_efficiency_attr_group, ASUS_WMI_DEVID_CORES_MAX },
+	{ &cores_performance_attr_group, ASUS_WMI_DEVID_CORES_MAX },
 
 	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
 	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
@@ -598,6 +845,7 @@ static int asus_fw_attr_add(void)
 static int __init asus_fw_init(void)
 {
 	char *wmi_uid;
+	int err;
 
 	wmi_uid = wmi_get_acpi_device_uid(ASUS_WMI_MGMT_GUID);
 	if (!wmi_uid)
@@ -610,6 +858,14 @@ static int __init asus_fw_init(void)
 	if (!strcmp(wmi_uid, ASUS_ACPI_UID_ASUSWMI))
 		return -ENODEV;
 
+	if (asus_wmi_is_present(ASUS_WMI_DEVID_CORES_MAX)) {
+		err = init_max_cpu_cores();
+		if (err) {
+			pr_err("Could not initialise CPU core control %d\n", err);
+			return err;
+		}
+	}
+
 	return asus_fw_attr_add();
 }
 
diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
index 61675e7b5a60..a6c4caefdef9 100644
--- a/drivers/platform/x86/asus-armoury.h
+++ b/drivers/platform/x86/asus-armoury.h
@@ -161,4 +161,32 @@
 		.name = _fsname, .attrs = _attrname##_attrs			\
 	}
 
+/* CPU core attributes need a little different in setup */
+#define ATTR_GROUP_CORES_RW(_attrname, _fsname, _dispname)		\
+	__ATTR_SHOW_FMT(scalar_increment, _attrname, "%d\n", 1);	\
+	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
+	static struct kobj_attribute attr_##_attrname##_current_value =	\
+		__ASUS_ATTR_RW(_attrname, current_value);		\
+	static struct kobj_attribute attr_##_attrname##_default_value = \
+		__ASUS_ATTR_RO(_attrname, default_value);		\
+	static struct kobj_attribute attr_##_attrname##_min_value =	\
+		__ASUS_ATTR_RO(_attrname, min_value);			\
+	static struct kobj_attribute attr_##_attrname##_max_value =	\
+		__ASUS_ATTR_RO(_attrname, max_value);			\
+	static struct kobj_attribute attr_##_attrname##_type =		\
+		__ASUS_ATTR_RO_AS(type, int_type_show);			\
+	static struct attribute *_attrname##_attrs[] = {		\
+		&attr_##_attrname##_current_value.attr,			\
+		&attr_##_attrname##_default_value.attr,			\
+		&attr_##_attrname##_min_value.attr,			\
+		&attr_##_attrname##_max_value.attr,			\
+		&attr_##_attrname##_scalar_increment.attr,		\
+		&attr_##_attrname##_display_name.attr,			\
+		&attr_##_attrname##_type.attr,				\
+		NULL							\
+	};								\
+	static const struct attribute_group _attrname##_attr_group = {	\
+		.name = _fsname, .attrs = _attrname##_attrs		\
+	}
+
 #endif /* _ASUS_ARMOURY_H_ */
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index d5f4b1de6d54..3e7491f8e01a 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -137,6 +137,11 @@
 /* dgpu on/off */
 #define ASUS_WMI_DEVID_DGPU		0x00090020
 
+/* Intel E-core and P-core configuration in a format 0x0[E]0[P] */
+#define ASUS_WMI_DEVID_CORES		0x001200D2
+ /* Maximum Intel E-core and P-core availability */
+#define ASUS_WMI_DEVID_CORES_MAX	0x001200D3
+
 #define ASUS_WMI_DEVID_APU_MEM		0x000600C1
 
 /* gpu mux switch, 0 = dGPU, 1 = Optimus */
-- 
2.50.1


