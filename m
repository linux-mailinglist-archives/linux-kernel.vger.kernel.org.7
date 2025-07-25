Return-Path: <linux-kernel+bounces-745129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E716B11564
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9DD189C6B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C86E17A310;
	Fri, 25 Jul 2025 00:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCPuKsPH"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB000BA3D;
	Fri, 25 Jul 2025 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753404340; cv=none; b=FiUrgzsNaPirWvu/vRJ7PpRr3HPspWR3f6/Catp6udI9HHiTPju6AKo16opgY8CE8UBQg7uSSc75apX4VhmGQGR4Ihrw79/WMOKDnoxMo8fYTcqMAgQ+pIijxbsDcxCGhQ5pOfA9kk7MADgKm1F+KIut1VvhBF2q3Bvg25e2vGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753404340; c=relaxed/simple;
	bh=eEhcAttEyRp/2amfqnSH/3AGm+NdSt0nf7Av5ukEozg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Or1g3wgUZ70buxLIwXiTv9xL4HRFlaIE0bGkcXfvP7irX7B4pR28YyYBlI90PJUNJLgC6DbYSm7WRTV9woYVQkBOAUwG6NmzZNb/zYEvVbauQEdalcwzXHzsb0E5DpPHiNCtHGZKp2hW+p8eZ/tbt2iiXabWsRQQW34gtsZIR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCPuKsPH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234f17910d8so13851435ad.3;
        Thu, 24 Jul 2025 17:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753404338; x=1754009138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XncJ6vSv07Ofuuyn7AN8KqYhBiO6Z4VhwmqC/mWIGys=;
        b=jCPuKsPHN4SzBoo3jPMidGXXBKKgEbN6OKtnWjurXt+SG2W1l7VihYcQypgIm7dPqs
         Dfj+vVjNj8EffLIcsJEPwdCh5AxKnVqvJpWR6XlzZOz9QAFa07RY+6P8QSxixWf1fgCh
         TTUhFGz5zAW3yoVpnCLPta3IMeb0vifTx/5WL25wIOASy7pW2SR3OpP/dbe/LFzWc0Pk
         CIZefurN+C6wxFDT6e6dqNTlUmJs5oihuLa6B2jdqZYlMiO1Lvi/4WwDjs/VB4TdwQYq
         sacwXk9g91Ysc77n9xB66PwqobCVFCt+XbqSDHpoNF7v18XRoG4HY6h4yYJjFl4hK3u0
         7ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753404338; x=1754009138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XncJ6vSv07Ofuuyn7AN8KqYhBiO6Z4VhwmqC/mWIGys=;
        b=dvIGjDCVCscODqX17B8jkuSEImTjbDhawxIOJ505ggO4IwmWHnThaKifexTAFFNtEE
         6HT6WvUszQ/dOyk1lY23snDjyHJqnGyj2yFylMfWE60/0Z1Pr4+c7OqXUnPHQcqc74nQ
         WB0Fl0qT16B2VzvQnWUVZOn9Qg8b6pQf3Qs45xLtoocPta4tLMaslV7Pm/2GACbenffm
         6VzoPBv4EBF16gU+EI4eM+8l1aIgBzdqi3icGKihqYB8CzEDF6IzZDBnNIxXJQU7J18H
         go49B70HqcuPSfzFgtTDZfKr5lw0OFMLFbJoSv1YdExRqlUlt2yE3c0FNRFbBWbT/hzD
         vKRA==
X-Forwarded-Encrypted: i=1; AJvYcCXFRnEkdPdP+fhQ8EONTY6qxQkNyFYdtG/zB9TGkoqNKxOD1PB6ItNv5Pdgz4ycXD+EvEPf6cC4gHR0pA==@vger.kernel.org, AJvYcCXVxPbagHjhF8ThJcFlaxrSunWKPkXuHnxk0Z3OuI5xDQk4bJXasP0CeC8cntD0p2W40Ons7GIpUI6tc83f@vger.kernel.org, AJvYcCXqTZwW1FRjn1fiDwVx9BQkOqPlkb1vy61bspw8GwqCWiD+FYBzOJsCwNAJoMUVazp9tSFR5Ufix3Uncvau75Qj3cJLuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyP/sy2Z7nFE03PFaaIfZE3peG07W//f0Hx30ceeieuzv4SfSy
	ZNMXX1ve3LUvF8Uzf6jyi/DJnif738CabEOIFaPhDyhf+Yh2394gtmI6
X-Gm-Gg: ASbGncvxbmfNJ3tlxpETk5sYpQxFXo4A31iuMO/iBkVg0TCMDr44WlPfgt9zHrnhqrw
	aBjGK5k28yq4Y87mR3Myw+Vxvj6/mJnir8MXUvAvg7VaPJBNKZPQeyT559ActMKsY2NhfMPpcA9
	kHOZvIAP//u0w9Vcb/NJAbvt51Bpk34wNbWzASXmkFuBvj5eUtnHivwZASbDqkc92REhZqUmEiP
	RIzxJR32kZQP0h6lFQsw5y1qb7Wb+VIAq4qR/rNveneKuLYuLcRRljfXVsYYD+2AUuEBMI7tGEJ
	T0QGhDrc8tEowF65p5T+GRp8jE0Nzs66MZb06/bTjpzGCwi6ktWb0vLVqZkxscJT8EvVl6DUq/t
	D1DJtPRLQia6SKGn9YBnZcZ2Eui0efvkwTuXcEch6RBi4IDs1MKnZ0lA4qUvFZhdyvw7cxTRMdg
	GY8A==
X-Google-Smtp-Source: AGHT+IG5vUBNYjPfkpKMNNuBFa+J1F66+slmY1+wIjG4O2kQHJxydFLYmvN/Tin3Hiqzcd34d+XDEw==
X-Received: by 2002:a17:902:d487:b0:235:f3df:bc26 with SMTP id d9443c01a7336-23fb2fe067cmr121035ad.3.1753404337961;
        Thu, 24 Jul 2025 17:45:37 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa4901b99sm24157905ad.188.2025.07.24.17.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 17:45:37 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 2/4] platform/x86: (ayn-ec) Add Temperature Sensors
Date: Thu, 24 Jul 2025 17:45:31 -0700
Message-ID: <20250725004533.63537-2-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725004533.63537-1-derekjohn.clark@gmail.com>
References: <20250725004533.63537-1-derekjohn.clark@gmail.com>
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
 drivers/platform/x86/ayn-ec.c | 89 +++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-ec.c
index 06f232bd10fa..b2054dc2358a 100644
--- a/drivers/platform/x86/ayn-ec.c
+++ b/drivers/platform/x86/ayn-ec.c
@@ -50,8 +50,16 @@
 #define AYN_SENSOR_PWM_FAN_TEMP_4_REG	0x19
 #define AYN_SENSOR_PWM_FAN_TEMP_5_REG	0x1B
 
+/* EC Teperature Sensors */
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
 
@@ -503,6 +525,63 @@ static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp, pwm_curve, 7);
 static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, pwm_curve, 8);
 static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_temp, pwm_curve, 9);
 
+/**
+ * thermal_sensor_show() - Read a thermal sensor attribute value.
+ *
+ * @dev: The attribute's parent device.
+ * @attr: The attribute to read.
+ * @buf: Buffer to read to.
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
+	int i;
+
+	i = to_sensor_dev_attr(attr)->index;
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
@@ -514,6 +593,16 @@ static struct attribute *ayn_sensors_attrs[] = {
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
2.50.0


