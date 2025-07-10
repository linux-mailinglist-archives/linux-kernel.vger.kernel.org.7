Return-Path: <linux-kernel+bounces-724819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA19AFF742
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3485A549C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9546D280CE5;
	Thu, 10 Jul 2025 03:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0jPwCn4"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B0280331;
	Thu, 10 Jul 2025 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116619; cv=none; b=ZRch+lsRCis3igwVg4Ew5XjId7DbxtxzZluy9hvw+alPyIpsvRPPpyGd2EKF4JIhNb1pCAfGRmO90I9Nt6cib6Fc3BRi2WEhB75nrPssN40BPPIvl8c2mAO9E9h/uJlZmK/s5EgSgnUU9FaHh14cZLCYZiYGBey/YN5fiR5TXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116619; c=relaxed/simple;
	bh=/Of205qSTw5BEk3XUtgxYmvs4j2+6Y0doOkNBCXxex0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lD5U/+Lv8d+veUCKynlrQe60Td5+vSs+YIX7ccfI+7yHNNWqlCM2XDT09OPIIuKqYhfJ/2LEcaqP8LJykCuCFcsn4c1O9TdB8NTdaijhK3p1lmKo8yDQ8IE5HFboAnpYcnkQD/akprotyC6S5T09NmuGyHB4nR6rrRyipVDprLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0jPwCn4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23dc5bcf49eso6844535ad.2;
        Wed, 09 Jul 2025 20:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752116617; x=1752721417; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VsDUV4/CFH2slluapL1u11vdrU9pFMok3uSswnLBT6U=;
        b=K0jPwCn4Px7jbkfGjqpMGMa/Lmx7a/rLPzlCNYGwbBSlMPfH8f8qwUmVn3501fMw8w
         RT/+Ku0/D0C/cEtNjGgtkFg7Ss3KUJFIyT836+hLf3s6HxjOhv3tHWZByhPsPHzPqnNv
         iuFA2qkuuSFEiRTkbC4NGTg2+icDPKgDLZnTop1kdsf+75FvhwPRV9/SCIIEB4UhvTlo
         7PDHsje1Ndsi9NdPS+EPbOXjShWF7FR+XOuG2XHxRQJNkbel3VvFbLB2DYC4s84CjChS
         TOUpKI8NpXrkNXXPLmRv93O/bpeiekfB0axtfTDKYWv75Sx3sxs4lbAjvkpm1ihYbD1G
         Cmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752116617; x=1752721417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsDUV4/CFH2slluapL1u11vdrU9pFMok3uSswnLBT6U=;
        b=UuLEG/g/Hn5LZcRXggL4uY8vZAtjr4qh3m/NLNfhPvu510VJtoArd0kF8QV9uBUI3N
         DYRGpHvA6+3cVMndcmLwgANhiiYR7dnDzltDUuX4rPmiDAit5z81FVI4SS5gC8sR8B9L
         UfhDQYzTAH5l/q86uJxK4kyRDfnIYaJOwJvlKsP9ycQbLmF5WUPB7umES8vvfzBvBaRh
         GGNoob6/RoZ1BrzBCBa7/HCxGP6/PTJoTY4yK91QhQTO3k//EKmhI2dofu53COqMsMy7
         ohhSypQfqFDFWrAzHtUqwd9eDc6DUAj/NoL2BGwmW4SiE/qvpCXhaFafz2rrozZ25rMH
         9e5g==
X-Forwarded-Encrypted: i=1; AJvYcCUS7BMb6sMlVWdnvOE0HrfnkSRolH5JRgv9dP/T5lClwXJg5BTIriP8kCj8l0Fo8FubHvM9XnzQKtJ6zjLFCNt3bhpChQ==@vger.kernel.org, AJvYcCXqjqtVk/IlcLJh3j/tsX9az7/wn/tdijwY09BPh/PEsKAj8SgSLPLie3BxxkyKIU8Ntv+M83SJA3iT9VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyflEa4FJ2ljPPZZ9uyzP9WtmpLrV+mdLXI1F3kyLXiWiuMkJ+N
	Bst0pw2kulG/7jcnPDHAlUlxDNXUo5Xy7Nkt3oDNPit5gtxwrAoonL63
X-Gm-Gg: ASbGncsy3dWlmfC3UR6Ry//4GQrRaw6o+IQLNjMArvTJWKgtioFUm1Ial0/6muKW7qD
	Tzvme4jWMqQxpHzbv63rnODGFGh/eeFzyoxwIqfmOzBHziaWNy76j7YHrJd4DFKnzpz+oheS2uN
	IBHCWqRA7F4kjUxTLQxaDFDzCo8AAKTtFJVFA91BaaQmbe2lXr2OT1tSSb22la4DXJ1Ameh/15z
	qhbL39TezMiTrPXC3VlKx1r4lGe0B64BOBsskCMh+C88KIu6PS6XPv2oSVRduyfS5nKYJTGne85
	ge6e3dwJernwXSyDVXGmE7ElioovlM3ghvq3mZDlPuzMqvhQYnU4sNeuH23s2Q==
X-Google-Smtp-Source: AGHT+IGYCAorwTlfZ1paAvwrRBTMiosysemlEeWjyBee3CI+tHla9fu+9A6yxY6ZB1wJBXT4czdSeA==
X-Received: by 2002:a17:902:e807:b0:234:8c3d:2912 with SMTP id d9443c01a7336-23ddb1992famr68865135ad.11.1752116617421;
        Wed, 09 Jul 2025 20:03:37 -0700 (PDT)
Received: from [192.168.1.26] ([181.88.247.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435b7e3sm6210445ad.224.2025.07.09.20.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 20:03:37 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 10 Jul 2025 00:03:16 -0300
Subject: [PATCH v6 1/6] platform/x86: firmware_attributes_class: Add device
 initialization methods
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250710-fw-attrs-api-v6-1-9959ef759771@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6404; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=i+PET9Gw9C+HdAtuKnNY2uOg2H8TvIGmw1iDyA/7OMU=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn5ug0skW9YPq2X1fcTPlzwJ3tiYOfBO3J+rbkaha1xj
 4qY/M53lLIwiHExyIopsrQnLPr2KCrvrd+B0Pswc1iZQIYwcHEKwER8Uhn+Jz37yNzaVLPf38zd
 1fO9LUtszPljk1ljFP7XRf5s013byfA/Nrm8Y2nquTr2CwKuBR7V9744HNB0VlQykZ850V35Szo
 XAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

From: Thomas Weißschuh <linux@weissschuh.net>

Currently each user of firmware_attributes_class has to manually set up
kobjects, devices, etc.

Provide this infrastructure out-of-the-box through the newly introduced
fwat_device_register().

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Co-developed-by: Kurt Borja <kuurtb@gmail.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/firmware_attributes_class.c | 126 +++++++++++++++++++++++
 drivers/platform/x86/firmware_attributes_class.h |  28 +++++
 2 files changed, 154 insertions(+)

diff --git a/drivers/platform/x86/firmware_attributes_class.c b/drivers/platform/x86/firmware_attributes_class.c
index 736e96c186d9dc6d945517f090e9af903e93bbf4..084e66481a4a29bfd801d9e5bbb4067ac25b8437 100644
--- a/drivers/platform/x86/firmware_attributes_class.c
+++ b/drivers/platform/x86/firmware_attributes_class.c
@@ -2,7 +2,14 @@
 
 /* Firmware attributes class helper module */
 
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/device/class.h>
+#include <linux/kdev_t.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/types.h>
 #include "firmware_attributes_class.h"
 
 const struct class firmware_attributes_class = {
@@ -10,6 +17,123 @@ const struct class firmware_attributes_class = {
 };
 EXPORT_SYMBOL_GPL(firmware_attributes_class);
 
+static void fwat_device_release(struct device *dev)
+{
+	struct fwat_device *fadev = to_fwat_device(dev);
+
+	kfree(fadev);
+}
+
+/**
+ * fwat_device_register - Create and register a firmware-attributes class
+ *			  device
+ * @parent: Parent device
+ * @name: Name of the class device
+ * @drvdata: Drvdata of the class device
+ * @groups: Extra groups for the "attributes" directory
+ *
+ * Return: pointer to the new fwat_device on success, ERR_PTR on failure
+ */
+struct fwat_device *
+fwat_device_register(struct device *parent, const char *name, void *drvdata,
+		     const struct attribute_group **groups)
+{
+	struct fwat_device *fadev;
+	int ret;
+
+	if (!parent || !name)
+		return ERR_PTR(-EINVAL);
+
+	fadev = kzalloc(sizeof(*fadev), GFP_KERNEL);
+	if (!fadev)
+		return ERR_PTR(-ENOMEM);
+
+	fadev->groups = groups;
+	fadev->dev.class = &firmware_attributes_class;
+	fadev->dev.parent = parent;
+	fadev->dev.release = fwat_device_release;
+	dev_set_drvdata(&fadev->dev, drvdata);
+	ret = dev_set_name(&fadev->dev, "%s", name);
+	if (ret) {
+		kfree(fadev);
+		return ERR_PTR(ret);
+	}
+	ret = device_register(&fadev->dev);
+	if (ret) {
+		put_device(&fadev->dev);
+		return ERR_PTR(ret);
+	}
+
+	fadev->attrs_kset = kset_create_and_add("attributes", NULL, &fadev->dev.kobj);
+	if (!fadev->attrs_kset) {
+		ret = -ENOMEM;
+		goto out_device_unregister;
+	}
+
+	ret = sysfs_create_groups(&fadev->attrs_kset->kobj, groups);
+	if (ret)
+		goto out_kset_unregister;
+
+	return fadev;
+
+out_kset_unregister:
+	kset_unregister(fadev->attrs_kset);
+
+out_device_unregister:
+	device_unregister(&fadev->dev);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(fwat_device_register);
+
+void fwat_device_unregister(struct fwat_device *fadev)
+{
+	if (!fadev)
+		return;
+
+	kset_unregister(fadev->attrs_kset);
+	device_unregister(&fadev->dev);
+}
+EXPORT_SYMBOL_GPL(fwat_device_unregister);
+
+static void devm_fwat_device_release(void *data)
+{
+	struct fwat_device *fadev = data;
+
+	fwat_device_unregister(fadev);
+}
+
+/**
+ * devm_fwat_device_register - Create and register a firmware-attributes class
+ *			       device
+ * @parent: Parent device
+ * @name: Name of the class device
+ * @data: Drvdata of the class device
+ * @groups: Extra groups for the class device (Optional)
+ *
+ * Device managed version of fwat_device_register().
+ *
+ * Return: pointer to the new fwat_device on success, ERR_PTR on failure
+ */
+struct fwat_device *
+devm_fwat_device_register(struct device *parent, const char *name, void *data,
+			  const struct attribute_group **groups)
+{
+	struct fwat_device *fadev;
+	int ret;
+
+	fadev = fwat_device_register(parent, name, data, groups);
+	if (IS_ERR(fadev))
+		return fadev;
+
+	ret = devm_add_action_or_reset(parent, devm_fwat_device_release, fadev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return fadev;
+}
+EXPORT_SYMBOL_GPL(devm_fwat_device_register);
+
 static __init int fw_attributes_class_init(void)
 {
 	return class_register(&firmware_attributes_class);
@@ -23,5 +147,7 @@ static __exit void fw_attributes_class_exit(void)
 module_exit(fw_attributes_class_exit);
 
 MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
+MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net>");
+MODULE_AUTHOR("Kurt Borja <kuurtb@gmail.com>");
 MODULE_DESCRIPTION("Firmware attributes class helper module");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/firmware_attributes_class.h b/drivers/platform/x86/firmware_attributes_class.h
index d27abe54fcf9812a2f0868eec5426bbc8e7eb21c..048fd0904f767357ef856e687ec4cf3260016ec6 100644
--- a/drivers/platform/x86/firmware_attributes_class.h
+++ b/drivers/platform/x86/firmware_attributes_class.h
@@ -5,8 +5,36 @@
 #ifndef FW_ATTR_CLASS_H
 #define FW_ATTR_CLASS_H
 
+#include <linux/container_of.h>
+#include <linux/device.h>
 #include <linux/device/class.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 
 extern const struct class firmware_attributes_class;
 
+/**
+ * struct fwat_device - The firmware-attributes device
+ * @dev: The class device.
+ * @attrs_kobj: The "attributes" root kobject.
+ * @groups: Sysfs groups attached to the @attrs_kobj.
+ */
+struct fwat_device {
+	struct device dev;
+	struct kset *attrs_kset;
+	const struct attribute_group **groups;
+};
+
+#define to_fwat_device(_d)	container_of_const(_d, struct fwat_device, dev)
+
+struct fwat_device * __must_check
+fwat_device_register(struct device *parent, const char *name, void *drvdata,
+		     const struct attribute_group **groups);
+
+void fwat_device_unregister(struct fwat_device *fwadev);
+
+struct fwat_device * __must_check
+devm_fwat_device_register(struct device *parent, const char *name, void *data,
+			  const struct attribute_group **groups);
+
 #endif /* FW_ATTR_CLASS_H */

-- 
2.50.0


