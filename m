Return-Path: <linux-kernel+bounces-724820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629EDAFF743
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FE1480B19
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCCD280303;
	Thu, 10 Jul 2025 03:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXtcj8pA"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD72F28134F;
	Thu, 10 Jul 2025 03:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116625; cv=none; b=X4hxxPOGPu4BAD0mIYaA43U7QfbsjVU0tZ4ikyGvmezE4MyR0G+QjpBadVmGISeNVRl53FWGrw9T4dxssslvPce5aiS58k0otet1/65xGXi1Tmvpng2zS0akABhxeah4wKRpj3jaMvuEKdLhE/CVuSbj+am/epJxL3O4Orh3yhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116625; c=relaxed/simple;
	bh=AKT2LCDF+mt9HhI7ZHod43bXodzBzmT8WJKy65Gt/cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDBqpvakVvVPw2jkRTo55BHUMpajguyDQeWNYxDTtuoblwHpo5rd13+XIfuMALr6Nu8kC+NI5hqCvnbIclsI1LVbOQttaQ8nXbB2gArDhundWwd4UQqRJoG9bpiCPsHlj5FBW4WUUFO27l3sUTzkF3Re+B9zriJX5PNRkI0wgtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXtcj8pA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23c8f179e1bso6847825ad.1;
        Wed, 09 Jul 2025 20:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752116622; x=1752721422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLNB2VQN0QIwvKWXIQ3RBnjDCQnpPMN2iAM9XzkcvG8=;
        b=RXtcj8pA+v38/cgpkvLhYu3aKqoUaCppHGwB5jwxGtdSaHqHLhVTiyUDrbXoVVlGkp
         8yE91wvttlTHq3wcubh+GojK1OOBNV47N9zS5ZCQEkoJtiGLNGxNljUAivAPQU1juDBw
         zk2Pq1Om6TvFk8CR59BQbV4ZTxdpeuA+l9F7cY8UsXXf7S0M7PutDHcEDB5MG9QPXsDZ
         fpUYNe82wCN03hPLsz7K9dLgpOWhNtPNa2QK21pz2yKx5rjzBnDofC5bdazccSs9Nvda
         kufyf6480I/S/ww7pJ/7OGvtM6LyQOo765l0zSB4nbzUfuvDT3UlAD/nKh81H5ztzePK
         AiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752116622; x=1752721422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLNB2VQN0QIwvKWXIQ3RBnjDCQnpPMN2iAM9XzkcvG8=;
        b=RE2di2LFHnCPkhDp40VTEF19N0QHboPuyHlC4YUbqaF17gnxBhz6pDIvGlK88KZHAC
         4AmdLE3A5h9NdLOzRuUOqFcswzS6L6rZS/nufDnC9y3Qmqi5U4C0NV35+0Vlfw8wlj3x
         bRCOLzp5JFgTC2owgPPfLKT5xWa6sO3JAyyuj9RDJSgAEEZ12uPoe6b1wc3sgNj9EK/2
         0B+STeNLE+7y356bTWRGisIllcJd4P2p3DWRWA8Pgsuqgj1H6ekb9SExI59wvOyOV915
         98igSj4hu17+a5aQptIaq6fFVNeAuAbL6mLegI79EAnrmXqLZsRhO0bBniqegRD8h2YT
         x7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUW3LmUXLB7k82/C4oaXovN1DIRTxNbVgcQyMBnCGZPeRHaSNIvUB8axVHCONW9N1uW3yyHkrsAw11GXos=@vger.kernel.org, AJvYcCUpdIhcvCr1T6kATP8jlNUKV2G0nwPqKcxHxJKpOtLlCSspXj1JRvQSLKMekVTsTPYpmTS8Nb3ZhuLpuJJjRc5QDZ1lAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyekUzGjlSaBZwQxSOyastKIXZFMtfGgcgMFEq4FFL/zzZGkepf
	94rg8xkIxkZz5e2XdFfZ5I4m/K98X9lv1FLco/z1n+aIW+N8UaxFQNmY
X-Gm-Gg: ASbGncs9hKZaHELzp4rboaj27k8Yl5ggcdTqHtv+JCzJgyiw7QlqKBWQQZ/PkF9zvrn
	KUNeLeUdhMKQSO6CnYwIKehoSSKeQk4sPxQCV24KotfjeLzdxcQJfqwRqSJm1G81Ugf0zBjBLON
	vZLiveu0IuRNZFrL8yZMAOGSoTRW2n9pchsfLVxhV1en0eQHg1ZQDCVF35E5QjDx43rWIiRyHGx
	Za3s4awArcJWs43dDumNYW71t9cDuZaeBLIPw/BJ9NOKPleNZQdfsRXeLFXQkbyDCuhXn+QpFNT
	e4swlSBXy8v6Lziin48jlYdxTzDts1H/cRfoq2EeYRznO+5yXnMdUA7eOeXLcg6fx98+y76Z
X-Google-Smtp-Source: AGHT+IE2LRDlUNKGSKsGJapoflmcyF0RL7B1H8D28gh0ZamXjLGu/FgFSGZnI//hIu5uiJKvG5DdDg==
X-Received: by 2002:a17:903:8cd:b0:235:f4f7:a633 with SMTP id d9443c01a7336-23de4866a9fmr15730715ad.28.1752116621718;
        Wed, 09 Jul 2025 20:03:41 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435b7e3sm6210445ad.224.2025.07.09.20.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 20:03:41 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 10 Jul 2025 00:03:17 -0300
Subject: [PATCH v6 2/6] platform/x86: firmware_attributes_class: Add high
 level API for the attributes interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-fw-attrs-api-v6-2-9959ef759771@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=30756; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=AKT2LCDF+mt9HhI7ZHod43bXodzBzmT8WJKy65Gt/cg=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn5ug16S3zYryYv/OZyTWttsdGqLSpu6+WaHTa+vjKPb
 9ZGrovPO0pZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAi9v8Z/nCuYCh9+ubRhuUp
 K2of3FCVY+R7P91z7qlPXzjL36kI3Ktk+GeSHB663ve0SNzdMyrqpb3ybol2QklfH0jMzm9dplS
 whwsA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add high level API to aid in the creation of attribute groups attached
to the `attrs_kobj` (per ABI specification).

This new API lets users configure each group, either statically or
dynamically through a (per type) data struct and then create this group
through the generic fwat_create_group() macro.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/firmware_attributes_class.c | 539 +++++++++++++++++++++++
 drivers/platform/x86/firmware_attributes_class.h | 329 ++++++++++++++
 2 files changed, 868 insertions(+)

diff --git a/drivers/platform/x86/firmware_attributes_class.c b/drivers/platform/x86/firmware_attributes_class.c
index 084e66481a4a29bfd801d9e5bbb4067ac25b8437..40469586cbb4f011e3f03f6ccb8dea643f319ab3 100644
--- a/drivers/platform/x86/firmware_attributes_class.c
+++ b/drivers/platform/x86/firmware_attributes_class.c
@@ -10,13 +10,65 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/string_choices.h>
 #include "firmware_attributes_class.h"
 
+#define to_fwat_bool_data(_c) \
+	container_of_const(_c, struct fwat_bool_data, group)
+#define to_fwat_enum_data(_c) \
+	container_of_const(_c, struct fwat_enum_data, group)
+#define to_fwat_int_data(_c) \
+	container_of_const(_c, struct fwat_int_data, group)
+#define to_fwat_str_data(_c) \
+	container_of_const(_c, struct fwat_str_data, group)
+
+#define __FWAT_ATTR(_name, _mode, _show, _store, _type) {		\
+		.attr = { .name = __stringify(_name), .mode = _mode },	\
+		.show = _show, .store = _store, .type = _type,		\
+	}
+
+#define FWAT_ATTR_RO(_prefix, _name, _show, _type)			\
+	static struct fwat_attribute fwat_##_prefix##_##_name##_attr =	\
+		__FWAT_ATTR(_name, 0444, _show, NULL, _type)
+
+#define FWAT_GROUP_ATTR(_type, _mode, _name)					\
+	static struct fwat_attribute fwat_##_type##_##_name##_attr =		\
+		__FWAT_ATTR(_name, _mode, _type##_group_show,			\
+			    _type##_group_store, fwat_##_type##_##_name)
+
+struct fwat_group {
+	const struct fwat_group_data *data;
+	struct device *dev;
+	struct kobject kobj;
+};
+
+#define kobj_to_fwat_group(_k) \
+	container_of_const(_k, struct fwat_group, kobj)
+
+struct fwat_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct kobject *kobj, const struct fwat_attribute *attr,
+			char *buf);
+	ssize_t (*store)(struct kobject *kobj, const struct fwat_attribute *attr,
+			 const char *buf, size_t count);
+	int type;
+};
+
+#define to_fwat_attribute(_a) \
+	container_of_const(_a, struct fwat_attribute, attr)
+
 const struct class firmware_attributes_class = {
 	.name = "firmware-attributes",
 };
 EXPORT_SYMBOL_GPL(firmware_attributes_class);
 
+static const char * const fwat_type_labels[] = {
+	[fwat_group_type_boolean]			= "boolean",
+	[fwat_group_type_enumeration]			= "enumeration",
+	[fwat_group_type_integer]			= "integer",
+	[fwat_group_type_string]			= "string",
+};
+
 static void fwat_device_release(struct device *dev)
 {
 	struct fwat_device *fadev = to_fwat_device(dev);
@@ -24,6 +76,492 @@ static void fwat_device_release(struct device *dev)
 	kfree(fadev);
 }
 
+static ssize_t
+type_show(struct kobject *kobj, const struct fwat_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", fwat_type_labels[attr->type]);
+}
+
+static ssize_t
+display_name_show(struct kobject *kobj, const struct fwat_attribute *attr,
+		  char *buf)
+{
+	struct fwat_group *group = kobj_to_fwat_group(kobj);
+	const char *disp_name = group->data->display_name;
+
+	if (!disp_name)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%s\n", disp_name);
+}
+
+static ssize_t
+display_name_language_code_show(struct kobject *kobj, const struct fwat_attribute *attr,
+				char *buf)
+{
+	struct fwat_group *group = kobj_to_fwat_group(kobj);
+	const char *lang_code = group->data->language_code;
+
+	if (!lang_code)
+		return -EOPNOTSUPP;
+
+	return sysfs_emit(buf, "%s\n", lang_code);
+}
+
+static ssize_t
+bool_group_show(struct kobject *kobj, const struct fwat_attribute *attr, char *buf)
+{
+	const struct fwat_group *group = kobj_to_fwat_group(kobj);
+	const struct fwat_bool_data *data = to_fwat_bool_data(group->data);
+	bool val;
+	int ret;
+
+	/* show_override does not affect current_value */
+	if (data->group.show_override && attr->type != fwat_bool_current_value)
+		return data->group.show_override(group->dev, attr->type, buf);
+
+	switch (attr->type) {
+	case fwat_bool_current_value:
+		ret = data->read(group->dev, data->group.id, &val);
+		if (ret < 0)
+			return ret;
+		break;
+	case fwat_bool_default_value:
+		val = data->default_val;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return sysfs_emit(buf, "%s\n", str_yes_no(val));
+}
+
+static ssize_t
+bool_group_store(struct kobject *kobj, const struct fwat_attribute *attr,
+		 const char *buf, size_t count)
+{
+	const struct fwat_group *group = kobj_to_fwat_group(kobj);
+	const struct fwat_bool_data *data = to_fwat_bool_data(group->data);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	ret = data->write(group->dev, data->group.id, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t
+enum_group_show(struct kobject *kobj, const struct fwat_attribute *attr, char *buf)
+{
+	const struct fwat_group *group = kobj_to_fwat_group(kobj);
+	const struct fwat_enum_data *data = to_fwat_enum_data(group->data);
+	int val_idx, sz;
+	int ret;
+
+	/* show_override does not affect current_value */
+	if (data->group.show_override && attr->type != fwat_enum_current_value)
+		return data->group.show_override(group->dev, attr->type, buf);
+
+	switch (attr->type) {
+	case fwat_enum_current_value:
+		ret = data->read(group->dev, data->group.id, &val_idx);
+		if (ret < 0)
+			return ret;
+		break;
+	case fwat_enum_default_value:
+		val_idx = data->default_idx;
+		break;
+	case fwat_enum_possible_values:
+		if (!data->possible_vals || !data->possible_vals[0])
+			return -EOPNOTSUPP;
+
+		sz = sysfs_emit_at(buf, 0, "%s", data->possible_vals[0]);
+		for (unsigned int i = 1; data->possible_vals[i]; i++)
+			sz += sysfs_emit_at(buf, sz, ";%s", data->possible_vals[i]);
+		sz += sysfs_emit_at(buf, sz, "\n");
+
+		return sz;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return sysfs_emit(buf, "%s\n", data->possible_vals[val_idx]);
+}
+
+static ssize_t
+enum_group_store(struct kobject *kobj, const struct fwat_attribute *attr,
+		 const char *buf, size_t count)
+{
+	const struct fwat_group *group = kobj_to_fwat_group(kobj);
+	const struct fwat_enum_data *data = to_fwat_enum_data(group->data);
+	int val_idx;
+	int ret;
+
+	val_idx = __sysfs_match_string(data->possible_vals, -1, buf);
+	if (val_idx < 0)
+		return val_idx;
+
+	ret = data->write(group->dev, data->group.id, val_idx);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t
+int_group_show(struct kobject *kobj, const struct fwat_attribute *attr, char *buf)
+{
+	const struct fwat_group *group = kobj_to_fwat_group(kobj);
+	const struct fwat_int_data *data = to_fwat_int_data(group->data);
+	long val;
+	int ret;
+
+	/* show_override does not affect current_value */
+	if (data->group.show_override && attr->type != fwat_int_current_value)
+		return data->group.show_override(group->dev, attr->type, buf);
+
+	switch (attr->type) {
+	case fwat_int_current_value:
+		ret = data->read(group->dev, data->group.id, &val);
+		if (ret < 0)
+			return ret;
+		break;
+	case fwat_int_default_value:
+		val = data->default_val;
+		break;
+	case fwat_int_min_value:
+		val = data->min_val;
+		break;
+	case fwat_int_max_value:
+		val = data->max_val;
+		break;
+	case fwat_int_scalar_increment:
+		val = data->increment;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return sysfs_emit(buf, "%ld\n", val);
+}
+
+static ssize_t
+int_group_store(struct kobject *kobj, const struct fwat_attribute *attr,
+		const char *buf, size_t count)
+{
+	const struct fwat_group *group = kobj_to_fwat_group(kobj);
+	const struct fwat_int_data *data = to_fwat_int_data(group->data);
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = data->write(group->dev, data->group.id, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t
+str_group_show(struct kobject *kobj, const struct fwat_attribute *attr, char *buf)
+{
+	const struct fwat_group *group = kobj_to_fwat_group(kobj);
+	const struct fwat_str_data *data = to_fwat_str_data(group->data);
+	const char *val;
+	long len;
+	int ret;
+
+	/* show_override does not affect current_value */
+	if (data->group.show_override && attr->type != fwat_str_current_value)
+		return data->group.show_override(group->dev, attr->type, buf);
+
+	switch (attr->type) {
+	case fwat_str_current_value:
+		ret = data->read(group->dev, data->group.id, &val);
+		if (ret < 0)
+			return ret;
+		break;
+	case fwat_str_default_value:
+		val = data->default_val;
+		break;
+	case fwat_str_min_length:
+		len = data->min_len;
+		return sysfs_emit(buf, "%ld\n", len);
+	case fwat_str_max_length:
+		len = data->max_len;
+		return sysfs_emit(buf, "%ld\n", len);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return sysfs_emit(buf, "%s\n", val);
+}
+
+static ssize_t
+str_group_store(struct kobject *kobj, const struct fwat_attribute *attr,
+		const char *buf, size_t count)
+{
+	const struct fwat_group *group = kobj_to_fwat_group(kobj);
+	const struct fwat_str_data *data = to_fwat_str_data(group->data);
+	int ret;
+
+	ret = data->write(group->dev, data->group.id, buf);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+#define __FWAT_TYPE_NONE	(-1) /* Dummy value, never evaluated. */
+
+FWAT_ATTR_RO(all, display_name, display_name_show, __FWAT_TYPE_NONE);
+FWAT_ATTR_RO(all, display_name_language_code, display_name_language_code_show,
+	     __FWAT_TYPE_NONE);
+
+FWAT_ATTR_RO(bool, type, type_show, fwat_group_type_boolean);
+FWAT_GROUP_ATTR(bool, 0644, current_value);
+FWAT_GROUP_ATTR(bool, 0444, default_value);
+
+FWAT_ATTR_RO(enum, type, type_show, fwat_group_type_enumeration);
+FWAT_GROUP_ATTR(enum, 0644, current_value);
+FWAT_GROUP_ATTR(enum, 0444, default_value);
+FWAT_GROUP_ATTR(enum, 0444, possible_values);
+
+FWAT_ATTR_RO(int, type, type_show, fwat_group_type_integer);
+FWAT_GROUP_ATTR(int, 0644, current_value);
+FWAT_GROUP_ATTR(int, 0444, default_value);
+FWAT_GROUP_ATTR(int, 0444, min_value);
+FWAT_GROUP_ATTR(int, 0444, max_value);
+FWAT_GROUP_ATTR(int, 0444, scalar_increment);
+
+FWAT_ATTR_RO(str, type, type_show, fwat_group_type_string);
+FWAT_GROUP_ATTR(str, 0644, current_value);
+FWAT_GROUP_ATTR(str, 0444, default_value);
+FWAT_GROUP_ATTR(str, 0444, min_length);
+FWAT_GROUP_ATTR(str, 0444, max_length);
+
+static struct attribute *fwat_bool_attrs[] = {
+	&fwat_bool_type_attr.attr,
+	&fwat_all_display_name_attr.attr,
+	&fwat_all_display_name_language_code_attr.attr,
+	&fwat_bool_current_value_attr.attr,
+	&fwat_bool_default_value_attr.attr,
+	NULL
+};
+
+static struct attribute *fwat_enum_attrs[] = {
+	&fwat_enum_type_attr.attr,
+	&fwat_all_display_name_attr.attr,
+	&fwat_all_display_name_language_code_attr.attr,
+	&fwat_enum_current_value_attr.attr,
+	&fwat_enum_default_value_attr.attr,
+	&fwat_enum_possible_values_attr.attr,
+	NULL
+};
+
+static struct attribute *fwat_int_attrs[] = {
+	&fwat_int_type_attr.attr,
+	&fwat_all_display_name_attr.attr,
+	&fwat_all_display_name_language_code_attr.attr,
+	&fwat_int_current_value_attr.attr,
+	&fwat_int_default_value_attr.attr,
+	&fwat_int_min_value_attr.attr,
+	&fwat_int_max_value_attr.attr,
+	&fwat_int_scalar_increment_attr.attr,
+	NULL
+};
+
+static struct attribute *fwat_str_attrs[] = {
+	&fwat_str_type_attr.attr,
+	&fwat_all_display_name_attr.attr,
+	&fwat_all_display_name_language_code_attr.attr,
+	&fwat_str_current_value_attr.attr,
+	&fwat_str_default_value_attr.attr,
+	&fwat_str_min_length_attr.attr,
+	&fwat_str_max_length_attr.attr,
+	NULL
+};
+
+static_assert(fwat_bool_current_value == 0);
+static_assert(fwat_enum_current_value == 0);
+static_assert(fwat_int_current_value == 0);
+static_assert(fwat_str_current_value == 0);
+
+static umode_t fwat_attr_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	const struct fwat_attribute *fwat_attr = to_fwat_attribute(attr);
+	const struct fwat_group *group = kobj_to_fwat_group(kobj);
+	const struct fwat_group_data *data = group->data;
+
+	/* The `type` attribute is always first */
+	if (n == 0)
+		return attr->mode;
+
+	if (attr == &fwat_all_display_name_attr.attr)
+		return data->display_name ? attr->mode : 0;
+
+	if (attr == &fwat_all_display_name_language_code_attr.attr)
+		return data->language_code ? attr->mode : 0;
+
+	if (!fwat_attr->type)
+		return data->mode;
+
+	return test_bit(fwat_attr->type, &data->fattrs) ? attr->mode : 0;
+}
+
+static const struct attribute_group fwat_bool_group = {
+	.attrs = fwat_bool_attrs,
+	.is_visible = fwat_attr_visible,
+};
+__ATTRIBUTE_GROUPS(fwat_bool);
+
+static const struct attribute_group fwat_enum_group = {
+	.attrs = fwat_enum_attrs,
+	.is_visible = fwat_attr_visible,
+};
+__ATTRIBUTE_GROUPS(fwat_enum);
+
+static const struct attribute_group fwat_int_group = {
+	.attrs = fwat_int_attrs,
+	.is_visible = fwat_attr_visible,
+};
+__ATTRIBUTE_GROUPS(fwat_int);
+
+static const struct attribute_group fwat_str_group = {
+	.attrs = fwat_str_attrs,
+	.is_visible = fwat_attr_visible,
+};
+__ATTRIBUTE_GROUPS(fwat_str);
+
+static ssize_t
+fwat_attr_sysfs_show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	const struct fwat_attribute *fwat_attr = to_fwat_attribute(attr);
+
+	if (!fwat_attr->show)
+		return -EOPNOTSUPP;
+
+	return fwat_attr->show(kobj, fwat_attr, buf);
+}
+
+static ssize_t
+fwat_attr_sysfs_store(struct kobject *kobj, struct attribute *attr, const char *buf,
+		      size_t count)
+{
+	const struct fwat_attribute *fwat_attr = to_fwat_attribute(attr);
+
+	if (!fwat_attr->store)
+		return -EOPNOTSUPP;
+
+	return fwat_attr->store(kobj, fwat_attr, buf, count);
+}
+
+static void fwat_group_release(struct kobject *kobj)
+{
+	struct fwat_group *group = kobj_to_fwat_group(kobj);
+
+	kfree(group);
+}
+
+static const struct sysfs_ops fwat_attr_sysfs_ops = {
+	.show = fwat_attr_sysfs_show,
+	.store = fwat_attr_sysfs_store,
+};
+
+static const struct kobj_type fwat_boolean_ktype = {
+	.sysfs_ops = &fwat_attr_sysfs_ops,
+	.release = fwat_group_release,
+	.default_groups = fwat_bool_groups,
+};
+
+static const struct kobj_type fwat_enumeration_ktype = {
+	.sysfs_ops = &fwat_attr_sysfs_ops,
+	.release = fwat_group_release,
+	.default_groups = fwat_enum_groups,
+};
+
+static const struct kobj_type fwat_integer_ktype = {
+	.sysfs_ops = &fwat_attr_sysfs_ops,
+	.release = fwat_group_release,
+	.default_groups = fwat_int_groups,
+};
+
+static const struct kobj_type fwat_string_ktype = {
+	.sysfs_ops = &fwat_attr_sysfs_ops,
+	.release = fwat_group_release,
+	.default_groups = fwat_str_groups,
+};
+
+static int __fwat_create_group(struct fwat_device *fadev, const struct kobj_type *ktype,
+			       const struct fwat_group_data *data)
+{
+	struct fwat_group *group;
+	int ret;
+
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+	if (!group)
+		return -ENOMEM;
+
+	group->dev = &fadev->dev;
+	group->data = data;
+
+	group->kobj.kset = fadev->attrs_kset;
+	ret = kobject_init_and_add(&group->kobj, ktype, NULL, "%s", data->name);
+	if (ret) {
+		kobject_put(&group->kobj);
+		return ret;
+	}
+
+	kobject_uevent(&group->kobj, KOBJ_ADD);
+
+	return 0;
+}
+
+static void fwat_remove_auto_groups(struct fwat_device *fadev)
+{
+	struct kobject *pos, *n;
+
+	list_for_each_entry_safe(pos, n, &fadev->attrs_kset->list, entry)
+		kobject_put(pos);
+}
+
+int __fwat_create_bool_group(struct fwat_device *fadev,
+			     const struct fwat_bool_data *data)
+{
+	return __fwat_create_group(fadev, &fwat_boolean_ktype, &data->group);
+}
+EXPORT_SYMBOL_GPL(__fwat_create_bool_group);
+
+int __fwat_create_enum_group(struct fwat_device *fadev,
+			     const struct fwat_enum_data *data)
+{
+	return __fwat_create_group(fadev, &fwat_enumeration_ktype, &data->group);
+}
+EXPORT_SYMBOL_GPL(__fwat_create_enum_group);
+
+int __fwat_create_int_group(struct fwat_device *fadev,
+			    const struct fwat_int_data *data)
+{
+	return __fwat_create_group(fadev, &fwat_integer_ktype, &data->group);
+}
+EXPORT_SYMBOL_GPL(__fwat_create_int_group);
+
+int __fwat_create_str_group(struct fwat_device *fadev,
+			    const struct fwat_str_data *data)
+{
+	return __fwat_create_group(fadev, &fwat_string_ktype, &data->group);
+}
+EXPORT_SYMBOL_GPL(__fwat_create_str_group);
+
 /**
  * fwat_device_register - Create and register a firmware-attributes class
  *			  device
@@ -91,6 +629,7 @@ void fwat_device_unregister(struct fwat_device *fadev)
 	if (!fadev)
 		return;
 
+	fwat_remove_auto_groups(fadev);
 	kset_unregister(fadev->attrs_kset);
 	device_unregister(&fadev->dev);
 }
diff --git a/drivers/platform/x86/firmware_attributes_class.h b/drivers/platform/x86/firmware_attributes_class.h
index 048fd0904f767357ef856e687ec4cf3260016ec6..2af79d1d66fc83a9c1b8e564138c8dfff67c9e78 100644
--- a/drivers/platform/x86/firmware_attributes_class.h
+++ b/drivers/platform/x86/firmware_attributes_class.h
@@ -27,6 +27,335 @@ struct fwat_device {
 
 #define to_fwat_device(_d)	container_of_const(_d, struct fwat_device, dev)
 
+enum fwat_group_type {
+	fwat_group_type_boolean,
+	fwat_group_type_enumeration,
+	fwat_group_type_integer,
+	fwat_group_type_string,
+};
+
+enum fwat_bool_attrs {
+	fwat_bool_current_value,
+	fwat_bool_default_value,
+	fwat_bool_attrs_last
+};
+
+#define FWAT_BOOL_CURRENT_VALUE			BIT(fwat_bool_current_value)
+#define FWAT_BOOL_DEFAULT_VALUE			BIT(fwat_bool_default_value)
+#define FWAT_BOOL_ALL_ATTRS			GENMASK(fwat_bool_attrs_last, 0)
+
+enum fwat_enum_attrs {
+	fwat_enum_current_value,
+	fwat_enum_default_value,
+	fwat_enum_possible_values,
+	fwat_enum_attrs_last
+};
+
+#define FWAT_ENUM_CURRENT_VALUE			BIT(fwat_enum_current_value)
+#define FWAT_ENUM_DEFAULT_VALUE			BIT(fwat_enum_default_value)
+#define FWAT_ENUM_POSSIBLE_VALUES		BIT(fwat_enum_possible_values)
+#define FWAT_ENUM_ALL_ATTRS			GENMASK(fwat_enum_attrs_last, 0)
+
+enum fwat_int_attrs {
+	fwat_int_current_value,
+	fwat_int_default_value,
+	fwat_int_min_value,
+	fwat_int_max_value,
+	fwat_int_scalar_increment,
+	fwat_int_attrs_last
+};
+
+#define FWAT_INT_CURRENT_VALUE			BIT(fwat_int_current_value)
+#define FWAT_INT_DEFAULT_VALUE			BIT(fwat_int_default_value)
+#define FWAT_INT_MIN_VALUE			BIT(fwat_int_min_value)
+#define FWAT_INT_MAX_VALUE			BIT(fwat_int_max_value)
+#define FWAT_INT_SCALAR_INCREMENT		BIT(fwat_int_scalar_increment)
+#define FWAT_INT_ALL_ATTRS			GENMASK(fwat_int_attrs_last, 0)
+
+enum fwat_str_attrs {
+	fwat_str_current_value,
+	fwat_str_default_value,
+	fwat_str_min_length,
+	fwat_str_max_length,
+	fwat_str_attrs_last
+};
+
+#define FWAT_STR_CURRENT_VALUE			BIT(fwat_str_current_value)
+#define FWAT_STR_DEFAULT_VALUE			BIT(fwat_str_default_value)
+#define FWAT_STR_MIN_LENGTH			BIT(fwat_str_min_length)
+#define FWAT_STR_MAX_LENGTH			BIT(fwat_str_max_length)
+#define FWAT_STR_ALL_ATTRS			GENMASK(fwat_str_attrs_last, 0)
+
+/**
+ * struct fwat_group_data - Data struct common between group types
+ * @id: Group ID defined by the user.
+ * @name: Name of the group.
+ * @display_name: Name shown in the display_name attribute. (Optional)
+ * @language_code: Language code shown in the display_name_language_code
+ *                 attribute. (Optional)
+ * @mode: Mode for the current_value attribute. All other attributes will have
+ *        0444 permissions.
+ * @fattrs: Bitmap of selected attributes for this group type.
+ * @show_override: Custom show method for attributes in this group, except for
+ *		   the current_value attribute, for which the a `read` callback
+ *		   will still be used. (Optional)
+ *
+ * NOTE: This struct is not meant to be defined directly. It is supposed to be
+ * embedded and defined as part of fwat_[type]_data structs.
+ */
+struct fwat_group_data {
+	long id;
+	umode_t mode;
+	const char *name;
+	const char *display_name;
+	const char *language_code;
+	unsigned long fattrs;
+	ssize_t (*show_override)(struct device *dev, int type, char *buf);
+};
+
+/**
+ * struct fwat_bool_data - Data struct for the boolean group type
+ * @read: Read callback for the current_value attribute.
+ * @write: Write callback for the current_value attribute.
+ * @default_val: Default value.
+ * @group: Group data.
+ */
+struct fwat_bool_data {
+	int (*read)(struct device *dev, long id, bool *val);
+	int (*write)(struct device *dev, long id, bool val);
+	bool default_val;
+	struct fwat_group_data group;
+};
+
+/**
+ * struct fwat_enum_data - Data struct for the enumeration group type
+ * @read: Read callback for the current_value attribute.
+ * @write: Write callback for the current_value attribute.
+ * @default_idx: Index of the default value in the @possible_vals array.
+ * @possible_vals: Array of possible value strings for this group type.
+ * @group: Group data.
+ *
+ * NOTE: The `val_idx` argument in the @write callback is guaranteed to be a
+ *       valid (within bounds) index. However, the user is in charge of writing
+ *       valid indexes to the `*val_idx` argument of the @read callback.
+ *       Failing to do so may result in an OOB access.
+ */
+struct fwat_enum_data {
+	int (*read)(struct device *dev, long id, int *val_idx);
+	int (*write)(struct device *dev, long id, int val_idx);
+	int default_idx;
+	const char * const *possible_vals;
+	struct fwat_group_data group;
+};
+
+/**
+ * struct fwat_int_data - Data struct for the integer group type
+ * @read: Read callback for the current_value attribute.
+ * @write: Write callback for the current_value attribute.
+ * @default_val: Default value.
+ * @min_val: Minimum value.
+ * @max_val: Maximum value.
+ * @increment: Scalar increment for this value.
+ * @group: Group data.
+ *
+ * NOTE: The @min_val, @max_val, @increment constraints are merely informative.
+ *       These values are not enforced in any of the callbacks.
+ */
+struct fwat_int_data {
+	int (*read)(struct device *dev, long id, long *val);
+	int (*write)(struct device *dev, long id, long val);
+	long default_val;
+	long min_val;
+	long max_val;
+	long increment;
+	struct fwat_group_data group;
+};
+
+/**
+ * struct fwat_str_data - Data struct for the string group type
+ * @read: Read callback for the current_value attribute.
+ * @write: Write callback for the current_value attribute.
+ * @default_val: Default value.
+ * @min_len: Minimum string length.
+ * @max_len: Maximum string length.
+ * @group: Group data.
+ *
+ * NOTE: The @min_len, @max_len constraints are merely informative. These
+ *       values are not enforced in any of the callbacks.
+ */
+struct fwat_str_data {
+	int (*read)(struct device *dev, long id, const char **buf);
+	int (*write)(struct device *dev, long id, const char *buf);
+	const char *default_val;
+	long min_len;
+	long max_len;
+	struct fwat_group_data group;
+};
+
+#define __FWAT_GROUP(_name, _disp_name, _mode, _fattrs) \
+	{ .name = __stringify(_name), .display_name = _disp_name, .mode = _mode, .fattrs = _fattrs }
+
+/**
+ * DEFINE_FWAT_BOOL_GROUP - Convenience macro to quickly define a static
+ *                          struct fwat_bool_data instance
+ * @_name: Name of the group.
+ * @_disp_name: Name shown in the display_name attribute. (Optional)
+ * @_def_val: Default value.
+ * @_mode: Mode for the current_value attribute. All other attributes will have
+ *         0444 permissions.
+ * @_fattrs: Bitmap of selected attributes for this group type.
+ *
+ * `read` and `write` callbacks are required to be already defined as
+ * `_name##_read` and `_name##_write` respectively.
+ */
+#define DEFINE_FWAT_BOOL_GROUP(_name, _disp_name, _def_val, _mode, _fattrs) \
+	static const struct fwat_bool_data _name##_group_data = {	\
+		.read = _name##_read,					\
+		.write = _name##_write,					\
+		.default_val = _def_val,				\
+		.group = __FWAT_GROUP(_name, _disp_name, _mode, _fattrs), \
+	}
+
+/**
+ * DEFINE_FWAT_ENUM_GROUP - Convenience macro to quickly define a static
+ *                          struct fwat_enum_data instance
+ * @_name: Name of the group.
+ * @_disp_name: Name shown in the display_name attribute. (Optional)
+ * @_def_idx: Index of the default value in the @_poss_vals array.
+ * @_poss_vals: Array of possible value strings for this group type.
+ * @_mode: Mode for the current_value attribute. All other attributes will have
+ *         0444 permissions.
+ * @_fattrs: Bitmap of selected attributes for this group type.
+ *
+ * `read` and `write` callbacks are required to be already defined as
+ * `_name##_read` and `_name##_write` respectively.
+ *
+ * NOTE: The `val_idx` argument in the `write` callback is guaranteed to be a
+ *       valid (within bounds) index. However, the user is in charge of writing
+ *       valid indexes to the `*val_idx` argument of the `read` callback.
+ *       Failing to do so may result in an OOB access.
+ */
+#define DEFINE_FWAT_ENUM_GROUP(_name, _disp_name, _poss_vals, _def_idx, _mode, _fattrs) \
+	static const struct fwat_enum_data _name##_group_data = {	\
+		.read = _name##_read,					\
+		.write = _name##_write,					\
+		.default_idx = _def_idx,				\
+		.possible_vals = _poss_vals,				\
+		.group = __FWAT_GROUP(_name, _disp_name, _mode, _fattrs), \
+	}
+
+/**
+ * DEFINE_FWAT_INT_GROUP - Convenience macro to quickly define a static
+ *                         struct fwat_int_data instance
+ * @_name: Name of the group.
+ * @_disp_name: Name shown in the display_name attribute. (Optional)
+ * @_def_val: Default value.
+ * @_min: Minimum value.
+ * @_max: Maximum value.
+ * @_inc: Scalar increment for this value.
+ * @_mode: Mode for the current_value attribute. All other attributes will have
+ *         0444 permissions.
+ * @_fattrs: Bitmap of selected attributes for this group type.
+ *
+ * `read` and `write` callbacks are required to be already defined as
+ * `_name##_read` and `_name##_write` respectively.
+ *
+ * NOTE: The @_min, @_max, @_inc constraints are merely informative. These
+ *       values are not enforced in any of the callbacks.
+ */
+#define DEFINE_FWAT_INT_GROUP(_name, _disp_name, _def_val, _min, _max, _inc, _mode, _fattrs) \
+	static const struct fwat_int_data _name##_group_data = {	\
+		.read = _name##_read,					\
+		.write = _name##_write,					\
+		.default_val = _def_val,				\
+		.min_val = _min,					\
+		.max_val = _max,					\
+		.increment = _inc,					\
+		.group = __FWAT_GROUP(_name, _disp_name, _mode, _fattrs), \
+	}
+
+/**
+ * DEFINE_FWAT_STR_GROUP - Convenience macro to quickly define a static
+ *                         struct fwat_str_data instance
+ * @_name: Name of the group.
+ * @_disp_name: Name shown in the display_name attribute. (Optional)
+ * @_def_val: Default value.
+ * @_min: Minimum string length.
+ * @_max: Maximum string length.
+ * @_mode: Mode for the current_value attribute. All other attributes will have
+ *         0444 permissions.
+ * @_fattrs: Bitmap of selected attributes for this group type.
+ *
+ * `read` and `write` callbacks are required to be already defined as
+ * `_name##_read` and `_name##_write` respectively.
+ *
+ * NOTE: The @_min, @_max constraints are merely informative. These values are
+ *       not enforced in any of the callbacks.
+ */
+#define DEFINE_FWAT_STR_GROUP(_name, _disp_name, _def_val, _min, _max, _mode, _fattrs) \
+	static const struct fwat_str_data _name##_group_data = {	\
+		.read = _name##_read,					\
+		.write = _name##_write,					\
+		.default_val = _def_val,				\
+		.min_len = _min,					\
+		.max_len = _max,					\
+		.group = __FWAT_GROUP(_name, _disp_name, _mode, _fattrs), \
+	}
+
+int __fwat_create_bool_group(struct fwat_device *fadev,
+			     const struct fwat_bool_data *data);
+int __fwat_create_enum_group(struct fwat_device *fadev,
+			     const struct fwat_enum_data *data);
+int __fwat_create_int_group(struct fwat_device *fadev,
+			    const struct fwat_int_data *data);
+int __fwat_create_str_group(struct fwat_device *fadev,
+			    const struct fwat_str_data *data);
+
+/**
+ * fwat_create_group - Convenience generic macro to create a group
+ * @_dev: fwat_device
+ * @_data: One of fwat_{bool,enum,int,str}_data instance
+ *
+ * This macro (and associated functions) creates a sysfs group under the
+ * 'attributes' directory, which is located in the class device root directory.
+ *
+ * See Documentation/ABI/testing/sysfs-class-firmware-attributes for details.
+ *
+ * The @_data associated with this group may be created either statically,
+ * through DEFINE_FWAT_*_GROUP macros or dynamically, in which case the user
+ * would have allocate and fill the struct manually. The dynamic approach should
+ * be preferred when group constraints and/or visibility is decided dynamically.
+ *
+ * Example:
+ *
+ * static int stat_read(...){...};
+ * static int stat_write(...){...};
+ *
+ * DEFINE_FWAT_(BOOL|ENUM|INT|STR)_GROUP(stat, ...);
+ *
+ * static int create_groups(struct fwat_device *fadev)
+ * {
+ *	struct fwat_enum_data *dyn_group_data;
+ *
+ *	dyn_group_data = kzalloc(...);
+ *	// Fill the data
+ *	...
+ *	fwat_create_group(fadev, &stat_group_data);
+ *	fwat_create_group(fadev, &dyn_group_data);
+ *	fwat_create_group(...);
+ *	...
+ * }
+ *
+ * Return: 0 on success, -errno on failure
+ */
+#define fwat_create_group(_dev, _data) \
+	_Generic((_data),							\
+		 const struct fwat_bool_data * : __fwat_create_bool_group,	\
+		 const struct fwat_enum_data * : __fwat_create_enum_group,	\
+		 const struct fwat_int_data * : __fwat_create_int_group,	\
+		 const struct fwat_str_data * : __fwat_create_str_group)	\
+		(_dev, _data)
+
 struct fwat_device * __must_check
 fwat_device_register(struct device *parent, const char *name, void *drvdata,
 		     const struct attribute_group **groups);

-- 
2.50.0


