Return-Path: <linux-kernel+bounces-817743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0774B585E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2EB20285C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1981828DB46;
	Mon, 15 Sep 2025 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ki1YE0Qf"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CEC2820CE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967487; cv=none; b=fShhGZfuEbIxAAK73vCfVqiUG2tDZfMGSJ9CUdbm83ncKQpK6iROHTmkSpjrQwcV331hNF3dqnjPCROBzPN2sXARs5bmRoO6BqvFHodEpcfwSw1lF9MWfIRHzgME1c8dRGp26OPGQkL6AcAJJbCWdHmUmV/j+4/CTB7r/2FKHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967487; c=relaxed/simple;
	bh=2MgQN39RZNmvFtL6QEsLDuDn4gBHd05USt/arPyBRAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hymegN9JOMW4Zcqu4zvgf6h0mEaYOkRHfvZFPBDmRiFTfXxKARBKgw+0xoL+dGFQe0c6/xqpjllzTm8Rfam6aTJx4WqZ5rYGuRhUocMPi/CpDZn+bRn/ZAJxQRo9CiMR4WF8LP5hILWi5zahgzY+dsmqa8DArIt+nt0pkh2Erk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Ki1YE0Qf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3df726ecff3so2541631f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757967483; x=1758572283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sJJhpppygvVmFx5yZMKGD+Tn+q1juVpsqVaPDYy/WKI=;
        b=Ki1YE0QfOKsCMU3FJmKVoejdRhkz7cD5/teJibjgpbP+pmAKR1w+ZCi27vXBa8AV86
         Vpg9JA70b9KC/YEW28FVXKQmtrlCL9zADMhEwGOMEeQ+FZ6Fpdn4KeiWlOggQi2fbqvK
         XhBubpXk5p8PZNioTXhdOsAtd+0SdrMgSbT7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967483; x=1758572283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJJhpppygvVmFx5yZMKGD+Tn+q1juVpsqVaPDYy/WKI=;
        b=nejV73fm8OCiLrxMq8u0NjwqUg90KHE/k68s5B6VyV6HOzrYYdp/o++KtrF/TknLIT
         GGYiKDQdFWqyNRDUCH1Ex3EENzV3uF8v94wgIXovSms3lV8f8aeCkGqPIevSFljS6SJW
         0qT9mYrBpDjuQosiDxMYg/1Rp8BNyQeTE0zap64FL/nWhmAmDUWznrtUI7KPyumCmV8l
         f6/XEu/JgowOF5dVm5h4+BTKPGgvYsW7ByLu7Kg0mx9W9RPnjJpgvi7aLfW4DQeukaiF
         cCHDeFMckqFN9+rVBGdmfHHsJbNesR9Boti3fN06pLrgijonPqtef5JOju7AI/WVklOF
         z/kg==
X-Gm-Message-State: AOJu0YyjEf1Y+ex/ZTC/TRO0RjiQxny5rZVycEqBPrToQTuiRXIlehlI
	Zhhv7vm4BmA762ZhVTndr2n7XuFrw4442Gmd6b0fifXTAPBqe7TOfwV2eFH+YdgPfU6coZJ6EPO
	jg1zL
X-Gm-Gg: ASbGncuVS1dMBDxgL7o09dzYP5rO0XAcop1OwNswwgX9KQjLZ5EPCVdf2oUPGbeSVJo
	sq/SxR2C3pRPX9bjEMIAz4eIkUsoXWQV+i56KqZsPNHEv7RjDHq9a7DXNspZVbUl4cqQox2fEuT
	IoXJjmKUnCmmh/C+79qFV7Sv3oYFEhNm9AeyWu13eTpW1yztU5UFbJVouluYCLK+dVpbrFSlYDQ
	2vSHCH4q1obxxwuOB2YJK8Hub8xW7tQyQQnxr4uHIFWZIAyYO8JUTWvQm02ZP3ry7fjS2Zj1uun
	1UlmckHlwSwPwzuSvU7sDPpjlBtIS3+m+j+gzSc6wvV5O0EDMqPrNteF/5uLnKFy/1VZzCINqgp
	MNrT4c8gsa3Ht5jHhnCUr/o/JsNO0zV+SwfNzUUYx+nMsOOGEdr/r5hjeQ/4FKHI=
X-Google-Smtp-Source: AGHT+IFJ+/QD5nMmjdc2FRI9EvoQtf3vRrLAQzEz0v92T7rDYMmiD5ZEG6MjexO8fnAd7KKKm9hfpQ==
X-Received: by 2002:a05:6000:438a:b0:3eb:5ff:cb2e with SMTP id ffacd0b85a97d-3eb05ffcfdbmr2622016f8f.29.1757967483330;
        Mon, 15 Sep 2025 13:18:03 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7d369ea3bsm13724160f8f.0.2025.09.15.13.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:18:02 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Oliver Graute <oliver.graute@kococonnector.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	linux-input@vger.kernel.org
Subject: [PATCH 1/2] Input: edt-ft5x06 - fix report rate handling by sysfs
Date: Mon, 15 Sep 2025 22:16:31 +0200
Message-ID: <20250915201748.1712822-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the driver probe, the report-rate-hz value from device tree is written
directly to the M12 controller register, while for the M06 it is divided
by 10 since the controller expects the value in units of 10 Hz. That logic
was missing in the sysfs handling, leading to inconsistent behavior
depending on whether the value came from device tree or sysfs.

This patch makes the report-rate handling consistent by applying the same
logic in both cases. Two dedicated functions, report_rate_hz_{show,store},
were added for the following reasons:

- Avoid modifying the more generic edt_ft5x06_setting_{show,store} and
  thus prevent regressions.
- Properly enforce lower and upper limits for the M06 case. The previous
  version accepted invalid values for M06, since it relied on the M12
  limits.
- Return an error when the property is not supported (e.g. M09), to avoid
  misleading users into thinking the property is handled by the
  controller.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/input/touchscreen/edt-ft5x06.c | 158 +++++++++++++++++++++----
 1 file changed, 135 insertions(+), 23 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index bf498bd4dea9..d7a269a0528f 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -516,9 +516,136 @@ static EDT_ATTR(offset_y, S_IWUSR | S_IRUGO, NO_REGISTER, NO_REGISTER,
 /* m06: range 20 to 80, m09: range 0 to 30, m12: range 1 to 255... */
 static EDT_ATTR(threshold, S_IWUSR | S_IRUGO, WORK_REGISTER_THRESHOLD,
 		M09_REGISTER_THRESHOLD, EV_REGISTER_THRESHOLD, 0, 255);
-/* m06: range 3 to 14, m12: range 1 to 255 */
-static EDT_ATTR(report_rate, S_IWUSR | S_IRUGO, WORK_REGISTER_REPORT_RATE,
-		M12_REGISTER_REPORT_RATE, NO_REGISTER, 0, 255);
+
+static int edt_ft5x06_report_rate_get(struct edt_ft5x06_ts_data *tsdata)
+{
+	unsigned int val;
+	int error;
+
+	if (tsdata->reg_addr.reg_report_rate == NO_REGISTER)
+		return -EOPNOTSUPP;
+
+	error = regmap_read(tsdata->regmap, tsdata->reg_addr.reg_report_rate,
+			    &val);
+	if (error)
+		return error;
+
+	if (tsdata->version == EDT_M06)
+		val *= 10;
+
+	if (val != tsdata->report_rate) {
+		dev_warn(&tsdata->client->dev,
+			 "report-rate: read (%d) and stored value (%d) differ\n",
+			 val, tsdata->report_rate);
+		tsdata->report_rate = val;
+	}
+
+	return 0;
+}
+
+static ssize_t report_rate_show(struct device *dev,
+				struct device_attribute *dattr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	size_t count;
+	int error;
+
+	mutex_lock(&tsdata->mutex);
+
+	if (tsdata->factory_mode) {
+		error = -EIO;
+		goto out;
+	}
+
+	error = edt_ft5x06_report_rate_get(tsdata);
+	if (error) {
+		dev_err(&tsdata->client->dev,
+			"Failed to fetch attribute %s, error %d\n",
+			dattr->attr.name, error);
+		goto out;
+	}
+
+	count = sysfs_emit(buf, "%d\n", tsdata->report_rate);
+out:
+	mutex_unlock(&tsdata->mutex);
+	return error ?: count;
+}
+
+static int edt_ft5x06_report_rate_set(struct edt_ft5x06_ts_data *tsdata,
+				      unsigned int val)
+{
+	if (tsdata->reg_addr.reg_report_rate == NO_REGISTER)
+		return -EOPNOTSUPP;
+
+	if (tsdata->version == EDT_M06)
+		tsdata->report_rate = clamp_val(val, 30, 140);
+	else
+		tsdata->report_rate = clamp_val(val, 1, 255);
+
+	if (val != tsdata->report_rate) {
+		dev_warn(&tsdata->client->dev,
+			 "report-rate %dHz is unsupported, use %dHz\n",
+			 val, tsdata->report_rate);
+		val = tsdata->report_rate;
+	}
+
+	if (tsdata->version == EDT_M06)
+		val /= 10;
+
+	return regmap_write(tsdata->regmap, tsdata->reg_addr.reg_report_rate,
+			    val);
+}
+
+static ssize_t report_rate_store(struct device *dev,
+				 struct device_attribute *dattr,
+				 const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
+	unsigned int val;
+	u8 limit_low;
+	u8 limit_high;
+	int error;
+
+	mutex_lock(&tsdata->mutex);
+
+	if (tsdata->factory_mode) {
+		error = -EIO;
+		goto out;
+	}
+
+	error = kstrtouint(buf, 0, &val);
+	if (error)
+		goto out;
+
+	if (tsdata->version == EDT_M06) {
+		limit_low = 30;
+		limit_high = 140;
+	} else {
+		limit_low = 1;
+		limit_high = 255;
+	}
+
+	if (val < limit_low || val > limit_high) {
+		error = -ERANGE;
+		goto out;
+	}
+
+	error = edt_ft5x06_report_rate_set(tsdata, val);
+	if (error) {
+		dev_err(&tsdata->client->dev,
+			"Failed to update attribute %s, error: %d\n",
+			dattr->attr.name, error);
+		goto out;
+	}
+
+out:
+	mutex_unlock(&tsdata->mutex);
+	return error ?: count;
+}
+
+static DEVICE_ATTR_RW(report_rate);
 
 static ssize_t model_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
@@ -572,7 +699,7 @@ static struct attribute *edt_ft5x06_attrs[] = {
 	&edt_ft5x06_attr_offset_x.dattr.attr,
 	&edt_ft5x06_attr_offset_y.dattr.attr,
 	&edt_ft5x06_attr_threshold.dattr.attr,
-	&edt_ft5x06_attr_report_rate.dattr.attr,
+	&dev_attr_report_rate.attr,
 	&dev_attr_model.attr,
 	&dev_attr_fw_version.attr,
 	&dev_attr_header_errors.attr,
@@ -595,8 +722,7 @@ static void edt_ft5x06_restore_reg_parameters(struct edt_ft5x06_ts_data *tsdata)
 	if (reg_addr->reg_offset_y != NO_REGISTER)
 		regmap_write(regmap, reg_addr->reg_offset_y, tsdata->offset_y);
 	if (reg_addr->reg_report_rate != NO_REGISTER)
-		regmap_write(regmap, reg_addr->reg_report_rate,
-			     tsdata->report_rate);
+		edt_ft5x06_report_rate_set(tsdata, tsdata->report_rate);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -1029,8 +1155,8 @@ static void edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
 	if (reg_addr->reg_offset_y != NO_REGISTER)
 		regmap_read(regmap, reg_addr->reg_offset_y, &tsdata->offset_y);
 	if (reg_addr->reg_report_rate != NO_REGISTER)
-		regmap_read(regmap, reg_addr->reg_report_rate,
-			    &tsdata->report_rate);
+		edt_ft5x06_report_rate_get(tsdata);
+
 	tsdata->num_x = EDT_DEFAULT_NUM_X;
 	if (reg_addr->reg_num_x != NO_REGISTER) {
 		if (!regmap_read(regmap, reg_addr->reg_num_x, &val))
@@ -1289,21 +1415,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client)
 	if (tsdata->reg_addr.reg_report_rate != NO_REGISTER &&
 	    !device_property_read_u32(&client->dev,
 				      "report-rate-hz", &report_rate)) {
-		if (tsdata->version == EDT_M06)
-			tsdata->report_rate = clamp_val(report_rate, 30, 140);
-		else
-			tsdata->report_rate = clamp_val(report_rate, 1, 255);
-
-		if (report_rate != tsdata->report_rate)
-			dev_warn(&client->dev,
-				 "report-rate %dHz is unsupported, use %dHz\n",
-				 report_rate, tsdata->report_rate);
-
-		if (tsdata->version == EDT_M06)
-			tsdata->report_rate /= 10;
-
-		regmap_write(tsdata->regmap, tsdata->reg_addr.reg_report_rate,
-			     tsdata->report_rate);
+		edt_ft5x06_report_rate_set(tsdata, report_rate);
 	}
 
 	dev_dbg(&client->dev,
-- 
2.43.0

base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
branch: edt-ft5x06-report-rate

