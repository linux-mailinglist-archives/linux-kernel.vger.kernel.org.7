Return-Path: <linux-kernel+bounces-746870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A44B12C49
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 22:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E379A7A93F7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 20:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA28D28A1E1;
	Sat, 26 Jul 2025 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWR4ruCi"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B55288C16;
	Sat, 26 Jul 2025 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562451; cv=none; b=F23xzxTkJ/oM8wrG0a0LttNB+73x5YqW2IUlDmY2e2JmMZXFKfUfMCiy4j7sttj61ygU+yE8pbD9I+s2F2PaqhI8UPeGyS+vLhwdkqXWqhD7gdbn3jNXtqH+wvuGZmU7B4f+6q97TcqfKHTGrJCoElRXtFw5wOOHfzQ7PTycHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562451; c=relaxed/simple;
	bh=q8U3HbUWL3lV1u/BA5zoaez+fI3BJu2E54mbekDDKWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCAdjbi31g2ujhuVKvMiJWipbK8vtgZmxqIyGyZ9b9JHs5GgakJHowk2XcMA7sNoymL+GJiYtFjfNrvXaPlg/4v/2L27WWkmygb8Tdj9R9BcjniywTXHI+xVafDdp9V4dT3Z9GYmBIWTj618vp6uA++U98A5FpMNB9a389Kvlnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWR4ruCi; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b34ab678931so2576056a12.0;
        Sat, 26 Jul 2025 13:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753562449; x=1754167249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDyPibcHfFu9Yy643YaFIkeebd0KcluKqtCVtZQhMfU=;
        b=GWR4ruCigpTHy6fp/ynSh4QaWGAcfQXq8sKBypcHiAxXD8jQ/04WzwMRhI+F9UZWkg
         Y65wcdvxjtC68koW4ccy11PMwOsLKY5GUx/i2Td81e2hjVcZjbKN6r5uNZbmimwF+X99
         AJmzfXkjSc3KrPCF7IyUByDXEn70u62ToGdfVeT03EDGCrF9E12gU4HYNa9of+RJs0mD
         d0EUxTng/hMiMGX1R2yd9hXzOoGolKplGJvQGmI4wvnjgEvy84iSx3QijnWXg4SRV8Uj
         8TJx0fMAX3kS9VvWCBFop4vvtOw0/ZesA5NFfPUL5kmW9n1+4tjJodzvxY9I/LOW22qv
         itzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753562449; x=1754167249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDyPibcHfFu9Yy643YaFIkeebd0KcluKqtCVtZQhMfU=;
        b=nMt/OHDFZFtLJHMOwS4jYo4q5Uh45zTeT5NU6PzrWpC4O0z7X3Y+fzIZwzxh4/ZZb0
         ezOb//5ne7lyZzSvpD3k3FYiPq80yW6VreV8PGvfQ2i/MhMjKL18KyN3Jasg03ULOfr/
         BQgpCr7XlsrnkXBnNVT1dG+gHTcd3WdSASgpy16QBcN0b257zzjkoWgqaZVKrR7asDgk
         9wMV3DxNAiO3Ji4LZxQc1CvWDNk7EE6mRJQYV90Ceehd3TzS1Kj7gJvgMoRoVfVPshXf
         0lS33L/+FIiVJz1apItoFtTMxBTx+frISCS5D84L8W8BncL885l224Js2KcREZ9gfRe2
         LSMg==
X-Forwarded-Encrypted: i=1; AJvYcCVE2dofMmJikkz0aH2nxiVPviBRp1HZpJh3q1oHiUzZMJicW5IOzdinzkMAuA2Z2nmZRddldh7BnNU2ue8=@vger.kernel.org, AJvYcCXCVbd68o8nxNyHumdVB6iSq/voDzTH2TO5/wy5RPF5fiRcrluyFwCxw9GiAVFPPrtqNJ8deSt0ufM=@vger.kernel.org, AJvYcCXFkIdajbuK7xS2yiQFcxeygSMlHQ2RN1qOdDOYYhmDBoQ6QfQ3Bsi6EpqL7FDkpQEA7/lKqVUEpGbT34AF@vger.kernel.org, AJvYcCXefWKxpP0lHpkFsfTuwXY5aaJv81OAJBDUqbrse1DqHFYDwe74FjSslNSGeoak3A8vLVaf+HUDOLFyF3liRW/YZXoigg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7kltXKKat16C2ug1xzLxWubYb4gdYGJpL8sYLYzTcRmd0qfy
	CmQ7xPFjDfhZ6wUN8FvoV9NrHfB/9jW7LWYoH6evEhw3Dd8EpHIUgoyw
X-Gm-Gg: ASbGncuMGCidxcCqU2/fh5qAK2kdFTrboE6ZObRN+IUyjEqWlkUTWmBsoJKQs1XtQd1
	yjO9GxpcXPZcqutN1TBZhuC7QF7LhlyFx5jDTwk5TxogpA9TdFkVFc4FgXUvcKh7Xhm48RUX3au
	CrynW0NWczJgI05DYMFoGBOQOflA2nw9TBQnnhuJMrU7pNWGlJC1qupmDUKUjl+uJFzVoF9rALj
	lVxoOIhcSYDURRtSwMA9wf2bquXFOYJnWVwu/PhqfusqxO95FoPeycbeN+3I967khe4G0ONVPl7
	l5nAObwuJyLbpLD+LS1+t/5NFmRfOmOQ+BKreB8M5hzp0WX4MWIMeY59cytWCObRFQqRBu+32aF
	0VOIXQHEg2vHOvPE5AoCbgsrI/QFVYjPVhqP1syWSB4NEr6DNIdtRCwiLUNQ0fak1UPAcaz7IXr
	TJ5g==
X-Google-Smtp-Source: AGHT+IEWydEjwUJsF744vx6ATJdAEZUQUMYwl3JG/2ocZxm7LtUz7J4UCB1DnPHs1dEoF1/u/F1GCA==
X-Received: by 2002:a17:90b:518d:b0:31c:72d7:558b with SMTP id 98e67ed59e1d1-31e77a24bccmr9467658a91.32.1753562448843;
        Sat, 26 Jul 2025 13:40:48 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e8ea37b21sm1905640a91.22.2025.07.26.13.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 13:40:48 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	David Box <david.e.box@linux.intel.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 2/4] platform/x86: (ayn-ec) Add Temperature Sensors
Date: Sat, 26 Jul 2025 13:40:39 -0700
Message-ID: <20250726204041.516440-3-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250726204041.516440-1-derekjohn.clark@gmail.com>
References: <20250726204041.516440-1-derekjohn.clark@gmail.com>
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
 drivers/platform/x86/ayn-ec.c | 88 ++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-ec.c
index 8bd3ed1c69eb..466cc33adcb0 100644
--- a/drivers/platform/x86/ayn-ec.c
+++ b/drivers/platform/x86/ayn-ec.c
@@ -61,6 +61,14 @@
 #define HWMON_PWM_FAN_MODE_AUTO	0x02
 #define HWMON_PWM_FAN_MODE_EC_CURVE	0x03
 
+/* EC Temperature Sensors */
+#define AYN_SENSOR_BAT_TEMP_REG		0x04 /* Battery */
+#define AYN_SENSOR_CHARGE_TEMP_REG	0x07 /* Charger IC */
+#define AYN_SENSOR_MB_TEMP_REG		0x05 /* Motherboard */
+#define AYN_SENSOR_PROC_TEMP_REG	0x09 /* CPU Core */
+#define AYN_SENSOR_VCORE_TEMP_REG	0x08 /* vCore */
+
+
 /* Handle ACPI lock mechanism */
 #define ACPI_LOCK_DELAY_MS 500
 
@@ -81,8 +89,19 @@ struct ayn_device {
 	u32 ayn_lock; /* ACPI EC Lock */
 } drvdata;
 
-/* Handle ACPI lock mechanism */
-#define ACPI_LOCK_DELAY_MS 500
+struct thermal_sensor {
+	char *name;
+	int reg;
+};
+
+static struct thermal_sensor thermal_sensors[] = {
+	{ "Battery",		AYN_SENSOR_BAT_TEMP_REG },
+	{ "Motherboard",	AYN_SENSOR_MB_TEMP_REG },
+	{ "Charger IC",		AYN_SENSOR_CHARGE_TEMP_REG },
+	{ "vCore",		AYN_SENSOR_VCORE_TEMP_REG },
+	{ "CPU Core",		AYN_SENSOR_PROC_TEMP_REG },
+	{}
+};
 
 static bool lock_global_acpi_lock(void)
 {
@@ -428,6 +447,61 @@ static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp, pwm_curve, 7);
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
@@ -439,6 +513,16 @@ static struct attribute *ayn_sensors_attrs[] = {
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


