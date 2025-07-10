Return-Path: <linux-kernel+bounces-724822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1A6AFF748
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE2E562D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D535F28312E;
	Thu, 10 Jul 2025 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvfLJv2/"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF52280A35;
	Thu, 10 Jul 2025 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116632; cv=none; b=CEdVtyV9ijMM3j123Vr6yZJEX9H5i3tBoATRpmW0WLP740nNWwO7WFcpou+D6dEejbdikxAwjYActsBPED1u6gnBIYvhXTDVx7fy0VqafslfzUIP1fFdo1OT74oGW1i77JBuDRqv8gzvCLWy1gPN0vNYT4qcfa7k8QqwqXwHg6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116632; c=relaxed/simple;
	bh=+eGlPpSz/22hosbd6I5n15V9p9C3KYO8HuWq0pZwQi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hffdvxgks7FBp03vMDK837VO27cO7fAbhSQ5H2WCuYMEP/RKyLl4pDQ6lHKwuR1yDMgPNpZjmFT/B3M2xl19WohR4AFerRUUnDDt0Z6kkkCtxU4ZnoZJCgjUGaerL5Gg2Iw5SPIttLqsuAy/PUVoJayHmaOmI5ORxw7xBOQ9Q7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvfLJv2/; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso639080a12.3;
        Wed, 09 Jul 2025 20:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752116629; x=1752721429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LT1B3LxqcRdENndxOMBVqMMI2dBsylEgkaBtYHfxrpY=;
        b=YvfLJv2/Ax+vt9Qc2C+lNYE4qDl3JEL73u4iWD6O/PlAIWfSuWW8lqDzrxqAOe8Sje
         NnXCBfVtUoV/J6DwDq2Iyvh8C/ERLXz4x8f+C2K/EVXWgypoH05p4vtQD8Y46wOqnRHl
         3O0/+HFbyJMIALDSfgYuCmkTLESaej3g1yoA9DfJ6vFAoJv3o/L30K0v+bMAJIJAZyI4
         lLn5jFFV/M4LYYX+3lhV4ZoBbNQeQfDHSgXZ+/BAgtisxE+ir5K58wMcDYGmJAN476mh
         Uj5fZC7Q1/gCP8XfNqvkMHkrOLVa9hJSccXNZ2Yu3wx6kvj8VGsKtnNkK3t8JCOPlGP8
         e1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752116629; x=1752721429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LT1B3LxqcRdENndxOMBVqMMI2dBsylEgkaBtYHfxrpY=;
        b=MB7VfGebg05LloVsbSRfjjtEWbnh5Z3UbKugQ9ULqyS85ODqWKv8g7nlXn/TePp/wl
         tDF3+n1f+bT1+1AgqYdcrPzcm4WyjVqUwCbFcTKEWE3+N8tdj+TXbbFWHT+0V4IH2aLC
         1sNScGnLcGKzSXyGZgeJrTHd6NGqA2dBjFwxsbCe6JAnCP2sn1AvUtFSXDwyGDcT2qt6
         FSetyzZ9ep3dQyya9zkdx/hmYd+YRhOhqKXFrKavn5EePMyZjSEH4dE4ctbkop6fZElR
         IxGdE7rHbl/q4KYzxIrBGudW1QHp/oMsXpCT+YqFTe8QvuODvHkQNXaPG9s0C/9fJCj3
         hkaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDtv/W2C3pClz0os45EmNPO4gjbNHqR2dleUThOjIPs19U/MIIviZS1ON2teIlQRW8yOxg3PYQDg98z4IfwjmySwviww==@vger.kernel.org, AJvYcCUS3HxWIotnkOhgl54XfhUskbji2NdQ1MR+uMWomx9d5kCCDh1DFngCDS/mIRdHtNcki6zJG3OeQbsLXfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxMsd3LQ+9pmKRdUeTNMycZJrOUNt1pIOSMtEF8vzBpRI1bxk4
	1Y+4P4AAx1DjHT2ZHCHfirC2INj38hQWkOoo9raYlfaK92wUWEgA5kbX
X-Gm-Gg: ASbGncsZkwF1g7K/sa4avs9hiXt6e36fejfjiUoFdhKo6Z3KKt6lWI6zd+2ChVJsZip
	P0ayI+ZbV/QeAMwNJHq1octtIv8UKN32KhQl4s2T03J4li21GQjXGmljFoqHB82aYz6PIcxfBLk
	bodpeuhKOfau8nYRhpjUlpHAVjON1GURNwAy4i8DV8xVWH59L6muyqp0zL8ypy6codknNI9rWKk
	WprGvvbytsOt+sLCjWWkf2W52gZhVnMcZIxe/U9qxwwcr0pX058l++8Espi7kEKME4GkiepRjZ1
	Fp8Tmee4AvQEv64e4ci+efeiteyBpJtueijbtJWzUPJX2oCdUeuC8pf1cbHxSA==
X-Google-Smtp-Source: AGHT+IELYEOcrgOB0gdyp0bTIBvv0CDzy59bXRt+yEf9zi7iswT+X1QH3lFi9wEqZBGVQJCNLJ4paA==
X-Received: by 2002:a17:902:f70b:b0:23a:cba1:6662 with SMTP id d9443c01a7336-23ddb349bb9mr84020795ad.46.1752116629276;
        Wed, 09 Jul 2025 20:03:49 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435b7e3sm6210445ad.224.2025.07.09.20.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 20:03:48 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 10 Jul 2025 00:03:19 -0300
Subject: [PATCH v6 4/6] platform/x86: samsung-galaxybook: Transition new
 firmware_attributes API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-fw-attrs-api-v6-4-9959ef759771@gmail.com>
References: <20250710-fw-attrs-api-v6-0-9959ef759771@gmail.com>
In-Reply-To: <20250710-fw-attrs-api-v6-0-9959ef759771@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Joshua Grisham <josh@joshuagrisham.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Hans de Goede <hansg@kernel.org>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dell.Client.Kernel@dell.com, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11035; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=+eGlPpSz/22hosbd6I5n15V9p9C3KYO8HuWq0pZwQi4=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn5uo2FqwPzJDwrnPJDgjSjJja42iWd5u4+OrF2m2ju1
 lnVXHM7SlkYxLgYZMUUWdoTFn17FJX31u9A6H2YOaxMIEMYuDgFYCIX5zP8FZK3U5E+n+X4pDXb
 VN9nqkHSq8PtYoe4wjpMz9SIMKiVMfwP75oqfmzOAZVj8X3rZd4o2P7dU3e8YnudUOPTE62v1Tw
 YAQ==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Transition to new firmware_attributes API.

Defining firmware_attributes groups statically through
DEFINE_FWAT_ENUM_GROUP() incurs in a minor ABI change. In particular the
display_name_language_code attribute is no longer created. Fortunately,
this doesn't break user-space compatibility, because this attribute is
not required, neither by the ABI specification nor by user-space tools.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/samsung-galaxybook.c | 238 ++++++++----------------------
 1 file changed, 63 insertions(+), 175 deletions(-)

diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform/x86/samsung-galaxybook.c
index 28046bb941c4b4947e10931690a290d80e909922..0bf736c02a1870342a024507dd6b9f6d8e7d0f82 100644
--- a/drivers/platform/x86/samsung-galaxybook.c
+++ b/drivers/platform/x86/samsung-galaxybook.c
@@ -36,8 +36,6 @@ struct samsung_galaxybook {
 	struct platform_device *platform;
 	struct acpi_device *acpi;
 
-	struct device *fw_attrs_dev;
-	struct kset *fw_attrs_kset;
 	/* block in case firmware attributes are updated in multiple threads */
 	struct mutex fw_attr_lock;
 
@@ -60,36 +58,6 @@ struct samsung_galaxybook {
 	u8 profile_performance_modes[PLATFORM_PROFILE_LAST];
 };
 
-enum galaxybook_fw_attr_id {
-	GB_ATTR_POWER_ON_LID_OPEN,
-	GB_ATTR_USB_CHARGING,
-	GB_ATTR_BLOCK_RECORDING,
-};
-
-static const char * const galaxybook_fw_attr_name[] = {
-	[GB_ATTR_POWER_ON_LID_OPEN] = "power_on_lid_open",
-	[GB_ATTR_USB_CHARGING]      = "usb_charging",
-	[GB_ATTR_BLOCK_RECORDING]   = "block_recording",
-};
-
-static const char * const galaxybook_fw_attr_desc[] = {
-	[GB_ATTR_POWER_ON_LID_OPEN] = "Power On Lid Open",
-	[GB_ATTR_USB_CHARGING]      = "USB Charging",
-	[GB_ATTR_BLOCK_RECORDING]   = "Block Recording",
-};
-
-#define GB_ATTR_LANGUAGE_CODE "en_US.UTF-8"
-
-struct galaxybook_fw_attr {
-	struct samsung_galaxybook *galaxybook;
-	enum galaxybook_fw_attr_id fw_attr_id;
-	struct attribute_group attr_group;
-	struct kobj_attribute display_name;
-	struct kobj_attribute current_value;
-	int (*get_value)(struct samsung_galaxybook *galaxybook, bool *value);
-	int (*set_value)(struct samsung_galaxybook *galaxybook, const bool value);
-};
-
 struct sawb {
 	u16 safn;
 	u16 sasb;
@@ -908,150 +876,95 @@ static int galaxybook_block_recording_init(struct samsung_galaxybook *galaxybook
 
 /* Firmware Attributes setup */
 
-static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+static const char * const galaxybook_possible_vals[] = {
+	[false] = "0", [true] = "1", NULL
+};
+
+static int power_on_lid_open_read(struct device *dev, long id, int *val_idx)
 {
-	return sysfs_emit(buf, "enumeration\n");
-}
-
-static struct kobj_attribute fw_attr_type = __ATTR_RO(type);
-
-static ssize_t default_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "0\n");
-}
-
-static struct kobj_attribute fw_attr_default_value = __ATTR_RO(default_value);
-
-static ssize_t possible_values_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "0;1\n");
-}
-
-static struct kobj_attribute fw_attr_possible_values = __ATTR_RO(possible_values);
-
-static ssize_t display_name_language_code_show(struct kobject *kobj, struct kobj_attribute *attr,
-					       char *buf)
-{
-	return sysfs_emit(buf, "%s\n", GB_ATTR_LANGUAGE_CODE);
-}
-
-static struct kobj_attribute fw_attr_display_name_language_code =
-	__ATTR_RO(display_name_language_code);
-
-static ssize_t display_name_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
-{
-	struct galaxybook_fw_attr *fw_attr =
-		container_of(attr, struct galaxybook_fw_attr, display_name);
-
-	return sysfs_emit(buf, "%s\n", galaxybook_fw_attr_desc[fw_attr->fw_attr_id]);
-}
-
-static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
-{
-	struct galaxybook_fw_attr *fw_attr =
-		container_of(attr, struct galaxybook_fw_attr, current_value);
-	bool value;
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(dev);
+	bool val;
 	int err;
 
-	err = fw_attr->get_value(fw_attr->galaxybook, &value);
+	err = power_on_lid_open_acpi_get(galaxybook, &val);
 	if (err)
 		return err;
 
-	return sysfs_emit(buf, "%u\n", value);
+	*val_idx = val;
+
+	return 0;
 }
 
-static ssize_t current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
-				   const char *buf, size_t count)
+static int power_on_lid_open_write(struct device *dev, long id, int val_idx)
 {
-	struct galaxybook_fw_attr *fw_attr =
-		container_of(attr, struct galaxybook_fw_attr, current_value);
-	struct samsung_galaxybook *galaxybook = fw_attr->galaxybook;
-	bool value;
-	int err;
-
-	if (!count)
-		return -EINVAL;
-
-	err = kstrtobool(buf, &value);
-	if (err)
-		return err;
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(dev);
 
 	guard(mutex)(&galaxybook->fw_attr_lock);
 
-	err = fw_attr->set_value(galaxybook, value);
+	return power_on_lid_open_acpi_set(galaxybook, val_idx ? true : false);
+}
+
+DEFINE_FWAT_ENUM_GROUP(power_on_lid_open, "Power On Lid Open", galaxybook_possible_vals,
+		       false, 0644, FWAT_ENUM_ALL_ATTRS);
+
+static int usb_charging_read(struct device *dev, long id, int *val_idx)
+{
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(dev);
+	bool val;
+	int err;
+
+	err = usb_charging_acpi_get(galaxybook, &val);
 	if (err)
 		return err;
 
-	return count;
+	*val_idx = val;
+
+	return 0;
 }
 
-#define NUM_FW_ATTR_ENUM_ATTRS  6
-
-static int galaxybook_fw_attr_init(struct samsung_galaxybook *galaxybook,
-				   const enum galaxybook_fw_attr_id fw_attr_id,
-				   int (*get_value)(struct samsung_galaxybook *galaxybook,
-						    bool *value),
-				   int (*set_value)(struct samsung_galaxybook *galaxybook,
-						    const bool value))
+static int usb_charging_write(struct device *dev, long id, int val_idx)
 {
-	struct galaxybook_fw_attr *fw_attr;
-	struct attribute **attrs;
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(dev);
 
-	fw_attr = devm_kzalloc(&galaxybook->platform->dev, sizeof(*fw_attr), GFP_KERNEL);
-	if (!fw_attr)
-		return -ENOMEM;
+	guard(mutex)(&galaxybook->fw_attr_lock);
 
-	attrs = devm_kcalloc(&galaxybook->platform->dev, NUM_FW_ATTR_ENUM_ATTRS + 1,
-			     sizeof(*attrs), GFP_KERNEL);
-	if (!attrs)
-		return -ENOMEM;
-
-	attrs[0] = &fw_attr_type.attr;
-	attrs[1] = &fw_attr_default_value.attr;
-	attrs[2] = &fw_attr_possible_values.attr;
-	attrs[3] = &fw_attr_display_name_language_code.attr;
-
-	sysfs_attr_init(&fw_attr->display_name.attr);
-	fw_attr->display_name.attr.name = "display_name";
-	fw_attr->display_name.attr.mode = 0444;
-	fw_attr->display_name.show = display_name_show;
-	attrs[4] = &fw_attr->display_name.attr;
-
-	sysfs_attr_init(&fw_attr->current_value.attr);
-	fw_attr->current_value.attr.name = "current_value";
-	fw_attr->current_value.attr.mode = 0644;
-	fw_attr->current_value.show = current_value_show;
-	fw_attr->current_value.store = current_value_store;
-	attrs[5] = &fw_attr->current_value.attr;
-
-	attrs[6] = NULL;
-
-	fw_attr->galaxybook = galaxybook;
-	fw_attr->fw_attr_id = fw_attr_id;
-	fw_attr->attr_group.name = galaxybook_fw_attr_name[fw_attr_id];
-	fw_attr->attr_group.attrs = attrs;
-	fw_attr->get_value = get_value;
-	fw_attr->set_value = set_value;
-
-	return sysfs_create_group(&galaxybook->fw_attrs_kset->kobj, &fw_attr->attr_group);
+	return usb_charging_acpi_set(galaxybook, val_idx ? true : false);
 }
 
-static void galaxybook_kset_unregister(void *data)
+DEFINE_FWAT_ENUM_GROUP(usb_charging, "USB Charging", galaxybook_possible_vals,
+		       false, 0644, FWAT_ENUM_ALL_ATTRS);
+
+static int block_recording_read(struct device *dev, long id, int *val_idx)
 {
-	struct kset *kset = data;
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(dev);
+	bool val;
+	int err;
 
-	kset_unregister(kset);
+	err = block_recording_acpi_get(galaxybook, &val);
+	if (err)
+		return err;
+
+	*val_idx = val;
+
+	return 0;
 }
 
-static void galaxybook_fw_attrs_dev_unregister(void *data)
+static int block_recording_write(struct device *dev, long id, int val_idx)
 {
-	struct device *fw_attrs_dev = data;
 
-	device_unregister(fw_attrs_dev);
+	struct samsung_galaxybook *galaxybook = dev_get_drvdata(dev);
+
+	guard(mutex)(&galaxybook->fw_attr_lock);
+
+	return block_recording_acpi_set(galaxybook, val_idx ? true : false);
 }
 
+DEFINE_FWAT_ENUM_GROUP(block_recording, "Block Recording", galaxybook_possible_vals,
+		       false, 0644, FWAT_ENUM_ALL_ATTRS);
+
 static int galaxybook_fw_attrs_init(struct samsung_galaxybook *galaxybook)
 {
+	struct fwat_device *fdev;
 	bool value;
 	int err;
 
@@ -1059,42 +972,20 @@ static int galaxybook_fw_attrs_init(struct samsung_galaxybook *galaxybook)
 	if (err)
 		return err;
 
-	galaxybook->fw_attrs_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
-						 NULL, "%s", DRIVER_NAME);
-	if (IS_ERR(galaxybook->fw_attrs_dev))
-		return PTR_ERR(galaxybook->fw_attrs_dev);
-
-	err = devm_add_action_or_reset(&galaxybook->platform->dev,
-				       galaxybook_fw_attrs_dev_unregister,
-				       galaxybook->fw_attrs_dev);
-	if (err)
-		return err;
-
-	galaxybook->fw_attrs_kset = kset_create_and_add("attributes", NULL,
-							&galaxybook->fw_attrs_dev->kobj);
-	if (!galaxybook->fw_attrs_kset)
-		return -ENOMEM;
-	err = devm_add_action_or_reset(&galaxybook->platform->dev,
-				       galaxybook_kset_unregister, galaxybook->fw_attrs_kset);
-	if (err)
-		return err;
+	fdev = devm_fwat_device_register(&galaxybook->platform->dev, DRIVER_NAME, galaxybook, NULL);
+	if (IS_ERR(fdev))
+		return PTR_ERR(fdev);
 
 	err = power_on_lid_open_acpi_get(galaxybook, &value);
 	if (!err) {
-		err = galaxybook_fw_attr_init(galaxybook,
-					      GB_ATTR_POWER_ON_LID_OPEN,
-					      &power_on_lid_open_acpi_get,
-					      &power_on_lid_open_acpi_set);
+		err = fwat_create_group(fdev, &power_on_lid_open_group_data);
 		if (err)
 			return err;
 	}
 
 	err = usb_charging_acpi_get(galaxybook, &value);
 	if (!err) {
-		err = galaxybook_fw_attr_init(galaxybook,
-					      GB_ATTR_USB_CHARGING,
-					      &usb_charging_acpi_get,
-					      &usb_charging_acpi_set);
+		err = fwat_create_group(fdev, &usb_charging_group_data);
 		if (err)
 			return err;
 	}
@@ -1107,10 +998,7 @@ static int galaxybook_fw_attrs_init(struct samsung_galaxybook *galaxybook)
 
 	galaxybook->has_block_recording = true;
 
-	return galaxybook_fw_attr_init(galaxybook,
-				       GB_ATTR_BLOCK_RECORDING,
-				       &block_recording_acpi_get,
-				       &block_recording_acpi_set);
+	return fwat_create_group(fdev, &block_recording_group_data);
 }
 
 /*

-- 
2.50.0


