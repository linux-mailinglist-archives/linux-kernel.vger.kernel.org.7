Return-Path: <linux-kernel+bounces-746600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCEFB128C6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 05:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1C6AA5A28
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 03:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36E81F8AC8;
	Sat, 26 Jul 2025 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huy1Cihi"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B891EFFB7;
	Sat, 26 Jul 2025 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753501129; cv=none; b=Msci1rA9dp/7T3FeU7MjWH9XlSvynBi3DkeEHvZUh2UfAG+LzTZcjec96G4LnTT5Tfq/Dl8M5NTGlnzylcNLUsdpM8iiQ53wAJvAfgPfA64YWTq/X7x2HGnoa6JFYOrq9a8JzSLUKLYBGZhaXr9ySocKpcsdoKnH3yd34FkShb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753501129; c=relaxed/simple;
	bh=qqR1ftzVitkRvIjjA3vechrl+NjZRajDJ13MWpI4Hqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbfBrck8wDH1jrdQIpGTjzmY3An9vxo30B4zYP/2nndacKHA9X/o9Q4OIiuJ4jxp6Z6TRtPf8SKbuWRItWJcsYPJ1IGA72AFQz6RRcKAx0tne4FjLlA+maZmfKzaw8IZwPFQl9Zw5fR9DGyTaD8SKgHtx4KRdAdIV18hCUbF08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huy1Cihi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso2473060a91.3;
        Fri, 25 Jul 2025 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753501128; x=1754105928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6F0Nx/x4Au56cIxfa0QJMWeiLDdvbcrTmp+T/eyT3+w=;
        b=huy1Cihi9rbKsE6Nc07jeKbD/zVOFiPNCG/6uV8M688eOybIACaYZuD6lqGSJ1XTu8
         sr1EJYXchhHjQ+lgnpzEQ91+ZUziPLlrdz5cE6JYOPp2fmCkW3pIpb17w3+2FGPM/Wsc
         9S5fxJM7Pt6gRwnhVWFCjvNwoBhcIrmLFFnSeoLj5wI9OQjnLxu0BluHmTpGrvKJwEuM
         QrQa36KijVo8smjHXWfDNeTy7U0AHGQ/UQKSCTIWckdgiE8lR9px4cdlo+H78tOvaN6N
         2/HVHUtY9uqikDNDLL231Va/RokA/VD7v/T1XIWIKILwjiiTLhF4S3ixgoNV19t8/d25
         nGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753501128; x=1754105928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6F0Nx/x4Au56cIxfa0QJMWeiLDdvbcrTmp+T/eyT3+w=;
        b=wxZPUGYf5kTgTPNFi9zlVa1Qt8rGM98hfZy4pokAQ0Vu8w4W5KZy1+xeOjRUYj+ebJ
         vWVS0A62oqisni2gA6qOhJmeeXwvNFcjyXlki8Ax6chUmuaX1o8SYgc4Tn9a5i5f8+Zh
         MXLtvlhc1KFoLfttZZM6L36PU1QtRyBIdLI3cHRR/Tu/A6vjlO08fR+iJAioO4pYPSPm
         /ueU6uFhSdr9fEEhfV2RUf0l9nHlThv+yRpxTZTRemkjF9roFS4B6sr00MU9f1TMfKfh
         s3V/nWzdDVH4vNmt1CzUtmm7fSRQJcy1Xo3QqTjZu4+yrYZsqHqwSF08IorMKBhcVHI6
         IOZg==
X-Forwarded-Encrypted: i=1; AJvYcCWCXwj1r50qipxOadEvIRYKdjEKP5/20jByx+Jt57owB6+q3l2FVW4oPU6kunbPc1+e6goK2yufZMC4HY8aThTfJcq2iA==@vger.kernel.org, AJvYcCWJ1yqeRC6/Glwwye5agCARxxEdmHx1cFWMKvFcUSCP/Wy/FKiZPJbmYBzi7ahjKS690DIRR+dHZYL/OTI=@vger.kernel.org, AJvYcCWmdC1/SU9kAdm74bG9gX7ZoMg1adDCrO7QITuOdrAhH5IaWZiKbkV9W0Z4n2FsS0XdkSGXXZvufT0=@vger.kernel.org, AJvYcCXXPV/Dny+z3fczfDWhh5n/EedtRgY/eQKWn8kF3QxV2qyJbyhrSzcxNYBOaTKXSWdRXcQES5lUWjOyYFt3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YtNAv5F50H8naDFhx3rr3exPZZXOsVemeItNkMFTCclRYM1M
	lQNSrVHGsO28Rq+0Ws0H9gZyAOlzgqrvojnH06jYIRalWnoZTkirvX0A
X-Gm-Gg: ASbGncvPSWMx2jr+c0ZrELI32NxdjE2StM1Gz0Lg3Osk6aV4V6dK7Zv6g2DlZ7HEWaY
	/51lDuA9APQ87fbqZ3bA2BFwky2L4haBG+wti21o3hGZyc/NIGh6ELf8/T6LXYM+wJCho4Yv+sD
	gGNeVMGwChUD9zz0v8EvgIs7b8WsxpI0SnJ2+sPVltGaCI/KVIn+WLYkVC+B2hoeZ2nbCDKFbf2
	0Bmn/JOHjLjJPyDPEu8P5kIVz0oz2k9r8J+DKouFbYe3gJh2ZjXHF8tXwW/HEk+11NCKazxeQxy
	FWtglJoFu7co/7pKHdNnEYo6b9mfOcAe3jGBZU0ItdcVXAR4YE4KpkOidaIpbHP7QuUnOtDbbW9
	ePN0yXXWfskbNTvYKB1W54/bfeWoq4Hetajy6HTw5653WIT3aZO+ZnF102Y4c1JM4eY+SjLlElC
	Hb7eqQ/tmJo6iu
X-Google-Smtp-Source: AGHT+IFGJT/KJS3r8dIQVOtFr4U6pTDgI6xExedT2Hw9UAWDmL3kJ2XZNy8CsLT5ROcH2OKRguFOQw==
X-Received: by 2002:a17:90b:3bc4:b0:308:7270:d6ea with SMTP id 98e67ed59e1d1-31e77a2483fmr5757918a91.30.1753501127469;
        Fri, 25 Jul 2025 20:38:47 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832f8942sm779204a91.4.2025.07.25.20.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 20:38:47 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 2/4] platform/x86: (ayn-ec) Add Temperature Sensors
Date: Fri, 25 Jul 2025 20:38:39 -0700
Message-ID: <20250726033841.7474-3-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250726033841.7474-1-derekjohn.clark@gmail.com>
References: <20250726033841.7474-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds temperature sensors to the ayn-ec hwmon interface. These read-only
values include Battery, Motherboard, Charger IC, vCore, and CPU Core, as
well as labels for each entry. The temperature values provided by the EC
are whole numbers in degrees Celsius. As hwmon expects millidegrees, we
scale the raw value up.

`sensors` output after this patch is applied:
aynec-isa-0000
Adapter: ISA adapter
fan1:        1876 RPM
Battery:      +29.0°C
Motherboard:  +30.0°C
Charger IC:   +30.0°C
vCore:        +36.0°C
CPU Core:     +48.0°C

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/ayn-ec.c | 87 +++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-ec.c
index 7e2187eba9a8..3b4daa7603ee 100644
--- a/drivers/platform/x86/ayn-ec.c
+++ b/drivers/platform/x86/ayn-ec.c
@@ -50,8 +50,16 @@
 #define AYN_SENSOR_PWM_FAN_TEMP_4_REG	0x19
 #define AYN_SENSOR_PWM_FAN_TEMP_5_REG	0x1B
 
+/* EC Temperature Sensors */
+#define AYN_SENSOR_BAT_TEMP_REG		0x04 /* Battery */
+#define AYN_SENSOR_CHARGE_TEMP_REG	0x07 /* Charger IC */
+#define AYN_SENSOR_MB_TEMP_REG		0x05 /* Motherboard */
+#define AYN_SENSOR_PROC_TEMP_REG	0x09 /* CPU Core */
+#define AYN_SENSOR_VCORE_TEMP_REG	0x08 /* vCore */
+
 /* Handle ACPI lock mechanism */
 #define ACPI_LOCK_DELAY_MS 500
+
 enum ayn_model {
 	ayn_loki_max = 1,
 	ayn_loki_minipro,
@@ -63,6 +71,20 @@ struct ayn_device {
 	u32 ayn_lock; /* ACPI EC Lock */
 } drvdata;
 
+struct thermal_sensor {
+	char *name;
+	int reg;
+};
+
+static struct thermal_sensor thermal_sensors[] = {
+	{ "Battery", AYN_SENSOR_BAT_TEMP_REG },
+	{ "Motherboard", AYN_SENSOR_MB_TEMP_REG },
+	{ "Charger IC", AYN_SENSOR_CHARGE_TEMP_REG },
+	{ "vCore", AYN_SENSOR_VCORE_TEMP_REG },
+	{ "CPU Core", AYN_SENSOR_PROC_TEMP_REG },
+	{}
+};
+
 /* Handle ACPI lock mechanism */
 #define ACPI_LOCK_DELAY_MS 500
 
@@ -503,6 +525,61 @@ static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp, pwm_curve, 7);
 static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, pwm_curve, 8);
 static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_temp, pwm_curve, 9);
 
+/**
+ * thermal_sensor_show() - Read a thermal sensor attribute value.
+ *
+ * @dev: The attribute's parent device.
+ * @attr: The attribute to read.
+ * @buf: Buffer to write the result into.
+ *
+ * Return: Number of bytes read, or an error.
+ */
+static ssize_t thermal_sensor_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	long ret, val;
+	int i;
+
+	i = to_sensor_dev_attr(attr)->index;
+
+	ret = read_from_ec(thermal_sensors[i].reg, 1, &val);
+	if (ret)
+		return ret;
+
+	val = val * 1000L;
+
+	return sysfs_emit(buf, "%ld\n", val);
+}
+
+/**
+ * thermal_sensor_label_show() - Read a thermal sensor attribute label.
+ *
+ * @dev: The attribute's parent device.
+ * @attr: The attribute to read.
+ * @buf: Buffer to read to.
+ *
+ * Return: Number of bytes read, or an error.
+ */
+static ssize_t thermal_sensor_label_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	int i = to_sensor_dev_attr(attr)->index;
+
+	return sysfs_emit(buf, "%s\n", thermal_sensors[i].name);
+}
+
+static SENSOR_DEVICE_ATTR_RO(temp1_input, thermal_sensor, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, thermal_sensor, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, thermal_sensor, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_input, thermal_sensor, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_input, thermal_sensor, 4);
+static SENSOR_DEVICE_ATTR_RO(temp1_label, thermal_sensor_label, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_label, thermal_sensor_label, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_label, thermal_sensor_label, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_label, thermal_sensor_label, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_label, thermal_sensor_label, 4);
+
 static struct attribute *ayn_sensors_attrs[] = {
 	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
@@ -514,6 +591,16 @@ static struct attribute *ayn_sensors_attrs[] = {
 	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_label.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_label.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_label.dev_attr.attr,
+	&sensor_dev_attr_temp5_input.dev_attr.attr,
+	&sensor_dev_attr_temp5_label.dev_attr.attr,
 	NULL,
 };
 
-- 
2.50.1


