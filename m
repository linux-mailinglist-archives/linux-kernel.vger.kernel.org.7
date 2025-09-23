Return-Path: <linux-kernel+bounces-829163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD24B966E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48217188EA47
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A391264A74;
	Tue, 23 Sep 2025 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FQgSi4IZ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A7263F2D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638793; cv=none; b=FgfAPPXk49sAqwMiG88/yedNymwE/PN762tsjTu/SYEZHRkEaBXJlRzTXxaZEA2aKpNGXetx1stRNU56TkS+hw9Aj20sR3BX3/WOZVi1bDrN55O2bZmfo1Tu+F2fiWlLRBrETuSsWaifdm24QISlwfRSMTggT0+5CJq/SHpo82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638793; c=relaxed/simple;
	bh=NJPU92IJc8p6EBq2/PXa+xW3P9gBDS1maQrlCEec1LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q707Ftxi93f7N+Hw+NcYFHWvJyyQbMUyr/fS+hLxWus13WBpIh4p6Mnz1QXAOgHgE3dnSr6ark3bBiMtRzR06SUvtyUa6zpuyZrH1PcKHPD2gu7JjLZIPs3CNMUXkF6bvz5Euydqd6OvxedY5yL6wTUPkWnMPmMmXM9sYVFKM/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=FQgSi4IZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b256c8ca246so797120466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758638789; x=1759243589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qnpLfXgLidATIzyWgBpv31wOd+0TKVI3i19szauFQ+U=;
        b=FQgSi4IZAtSVkeBU0dytiYzxnqs64RJjSCFot0V+cpFPbmnDlS+Z/PU/CD2FLnM0cR
         qXxSvnmxntA5ighcv6TAT9QesWEL+Qd+gZJuz/9rvfkoZ6OrO/Pt8m7TSEvDCpfMQ5tn
         aQwqPCIUeXkhNnr7mBKqtXxiMWRb+Eb5or2PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638789; x=1759243589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnpLfXgLidATIzyWgBpv31wOd+0TKVI3i19szauFQ+U=;
        b=NzUCK/samNbp8PRx4/H+upbLDGPShTLfztmVt8tCdqYyZxW8DhqdbMtojKIqsvKgKn
         pzqhqf4eHCU7r95sK0v+90XMmvejT89u0iY1H9J2cv/AataeiQcY5sl51qHsyW98WTod
         XyDXVon8LtYIAlAoU1OfTpGM2vkJs81XEDNfwJm/DPZxoNXOdHZG/Fo2XjjxBVOQnGM2
         pNU7gnzeLrzk9Y5/n0+SKE3kQ94qC5LlRJR9CwCuk+5co3fS5C2TVsbJYkmAsuaQXIxX
         HKtZjzsVw7okrmQjNkzwVqU5vyClQtTnNWVuj+cYtHepuHKG8LgjTqaX61S62VyU9/W6
         6tTA==
X-Gm-Message-State: AOJu0Ywni/Jy1kCXgQRuIYpvZdFyoTUjQKhxaOcMwii9tY15kxjG2Zbz
	wvS4R+9lSoTtT1zFIQeAp72NvIjwvgA55EoXRQ9WumbvO3txQPnkQPnLUPI1Iuewya5zZxEFyk4
	vIQ67
X-Gm-Gg: ASbGnctUs6SAKMS9UgbqkiNuVwT8H5iwuYaPqHS+QyHaIccMJLyqqq/lgQVKSoL7rot
	KL0n3WDBezXPuxrteYB+f7NBmBCtjXH7NVBkpqTpTA/ssf0NbOMnlBZp0Dii0kYSSUdliKLkKAb
	Un1Kr2882i22nbBLc7+F21Eqguqa8lxNc94CXAkvkhILML8xuntZspv7e+onmPEV9yV8t4tY00Z
	BXl9FzvABRH79LUBKsiAFfrxDzK+rodiVvl/SFR+mdoTGXhhma5FtQSvQ8FtBC7aF59M8/Uy3m2
	6Woixav/5xAcxBeNDL4mXvISRZrqPffqnq3PY9N5yg6mDWFy1uxIv4eTecfDIVVg9jag6OAuB7w
	joHT4ft8r2w/ysd5SyT/1S7jxkrXCcufrGUA14xyPFWrTecJFLe9iTFxI6sxZmefLv5//KJ7qTb
	NJEt7Wz84oq/eBNtnGj0vYBTOzsvJ2E8S3TnD9kMIk6bkUsC48J0nIVDoEgrDFEjFf
X-Google-Smtp-Source: AGHT+IFhM1A4tavNbq4FsaONus0oinLQYfftXtGEXqvwszvZ2qiBRjL3vMd2w1BuwrdirdDR/FLwVg==
X-Received: by 2002:a17:906:c14c:b0:b04:2212:4211 with SMTP id a640c23a62f3a-b3027a4aa98mr286898366b.16.1758638789462;
        Tue, 23 Sep 2025 07:46:29 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b29f45b5384sm691109666b.27.2025.09.23.07.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:46:29 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jens Reidel <adrian@mainlining.org>,
	Oliver Graute <oliver.graute@kococonnector.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	linux-input@vger.kernel.org
Subject: [PATCH v2] Input: edt-ft5x06 - fix report rate handling by sysfs
Date: Tue, 23 Sep 2025 16:46:11 +0200
Message-ID: <20250923144622.2858165-1-dario.binacchi@amarulasolutions.com>
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

Changes in v2:
- Drop the patch:
  1/2 Input: edt-ft5x06 - rename sysfs attribute report_rate to report_rate_hz
  because not accepted.

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

base-commit: f975f08c2e899ae2484407d7bba6bb7f8b6d9d40
branch: edt-ft5x06-report-rate

