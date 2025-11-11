Return-Path: <linux-kernel+bounces-894864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 510A3C4C497
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D70B4F7FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8CC32B98C;
	Tue, 11 Nov 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QK0SShaE"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62783306B15;
	Tue, 11 Nov 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848419; cv=none; b=oKxt2prBnUU3P5joOOKvIMwUFscmDDNb64S/UO6jJfEaEa76DQ0aq8xdJng9Ih7KUCTJ4l+3uBsqclfh+UI9tdmjtvYZGZSZAiUPdyQ0Rb59d4u0+A/tKdPGGGj+u0gV0xM5zHIjMenUiVBHa3gFOV2f3g4xo42JeMS3Db5DUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848419; c=relaxed/simple;
	bh=1frv9Vbxrzynugn/w6Jazgis+04iL8+ywHcI/eXlcrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Qf6VFMU9/O59tXZFXt0PzlvoS2V1XyXcNGbSj3Xd3iGwATkwuwT35k3VHXSBwkaPKIUyKdXUz/I9YWAG61okHRQPk8LNsHaUGT+ezHEy/V7rostXnNKvYJavhnpY/i6VX3OQJU9yoCBTQUNxSh7aPLBMPu8F1581F3srtraQveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QK0SShaE; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=k9WdnwaT6IcbCWY
	uC+hGTHfHC9EqlI1hGdAkWWWRtRc=; b=QK0SShaE/I6tO1hHeU8PKDVbbwiHI1T
	zWMgxNLgTVygpOM+LvwxYPOg3ukMfE48r5Mqq8TYa4FeJnDs7NuUR2MpzLJfdiD1
	uByu7fjBbT+eoNiT1Uyt7OgRR+uvuonY+RqZC2DfnugbMnxcLQF4U3ZsTLjICGZv
	3IGEVbZQUH88=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnq6ln7hJpK0KCDA--.117S10;
	Tue, 11 Nov 2025 16:06:17 +0800 (CST)
From: Wenliang Yan <wenliang202407@163.com>
To: linux@roeck-us.net,
	Jean Delvare <jdelvare@suse.com>
Cc: christophe.jaillet@wanadoo.fr,
	conor+dt@kernel.org,
	corbet@lwn.net,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	wenliang202407@163.com
Subject: [PATCH 8/8] hwmon:(ina3221)Support read/write functions for current_lcrict attribute
Date: Tue, 11 Nov 2025 03:05:46 -0500
Message-Id: <20251111080546.32421-9-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111080546.32421-1-wenliang202407@163.com>
References: <20251111080546.32421-1-wenliang202407@163.com>
X-CM-TRANSID:_____wCnq6ln7hJpK0KCDA--.117S10
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFWDAr1kGr1ftw18XrW8WFg_yoW5AF4rpw
	43Gayrtr4Yq3WIg3ySkF4kXr98Jw4xXF12yr9Fk39Y9a15AryDWFy8G3Wq93yUGFyfXa17
	JayIyr48ua1qvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUFZXrUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/xtbCwBm4jGkS7nkcBAAA3Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Modify the read/write functions for current attributes.
SQ52210 can directly use its internal current registers to compare
with alert values for implementing curr_lcrit functionality.

Signed-off-by: Wenliang Yan <wenliang202407@163.com>
---
 drivers/hwmon/ina3221.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index ea01687ad1fa..50916ce26cb3 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -488,8 +488,11 @@ static const u8 ina3221_curr_reg[][INA3221_NUM_CHANNELS + 1] = {
 	[hwmon_curr_max] = { INA3221_WARN1, INA3221_WARN2, INA3221_WARN3, 0 },
 	[hwmon_curr_crit] = { INA3221_CRIT1, INA3221_CRIT2,
 			      INA3221_CRIT3, INA3221_CRIT_SUM },
+	[hwmon_curr_lcrit] = { SQ52210_ALERT_LIMIT1, SQ52210_ALERT_LIMIT2,
+						SQ52210_ALERT_LIMIT3, 0 },
 	[hwmon_curr_max_alarm] = { F_WF1, F_WF2, F_WF3, 0 },
 	[hwmon_curr_crit_alarm] = { F_CF1, F_CF2, F_CF3, F_SF },
+	[hwmon_curr_lcrit_alarm] = { F_AFF1, F_AFF2, F_AFF3, 0 },
 };
 
 static int ina3221_read_curr(struct device *dev, u32 attr,
@@ -536,8 +539,20 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 		/* Return current in mA */
 		*val = DIV_ROUND_CLOSEST(voltage_nv, resistance_uo);
 		return 0;
+	case hwmon_curr_lcrit:
+		if (!resistance_uo)
+			return -ENODATA;
+
+		ret = ina3221_read_value(ina, reg, &regval);
+		if (ret)
+			return ret;
+
+		/* Return current in mA */
+		*val = DIV_ROUND_CLOSEST(regval * ina->current_lsb_uA, 1000);
+		return 0;
 	case hwmon_curr_crit_alarm:
 	case hwmon_curr_max_alarm:
+	case hwmon_curr_lcrit_alarm:
 		/* No actual register read if channel is disabled */
 		if (!ina3221_is_enabled(ina, channel)) {
 			/* Return 0 for alert flags */
@@ -703,10 +718,9 @@ static int ina3221_write_chip(struct device *dev, u32 attr, long val)
 	}
 }
 
-static int ina3221_write_curr(struct device *dev, u32 attr,
+static int ina3221_write_curr_shunt(struct ina3221_data *ina, u32 attr,
 			      int channel, long val)
 {
-	struct ina3221_data *ina = dev_get_drvdata(dev);
 	struct ina3221_input *input = ina->inputs;
 	u8 reg = ina3221_curr_reg[attr][channel];
 	int resistance_uo, current_ma, voltage_uv;
@@ -749,6 +763,22 @@ static int ina3221_write_curr(struct device *dev, u32 attr,
 	return regmap_write(ina->regmap, reg, regval);
 }
 
+static int ina3221_write_curr(struct device *dev, u32 attr,
+			      int channel, long val)
+{
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_curr_crit:
+	case hwmon_curr_max:
+		return ina3221_write_curr_shunt(ina, attr, channel, val);
+	case hwmon_curr_lcrit:
+		return sq52210_alert_limit_write(ina, attr, channel, val);
+	default:
+		return 0;
+	}
+}
+
 static int ina3221_write_enable(struct device *dev, int channel, bool enable)
 {
 	struct ina3221_data *ina = dev_get_drvdata(dev);
-- 
2.17.1


