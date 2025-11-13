Return-Path: <linux-kernel+bounces-899234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204A5C57299
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9443B92EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2EE33B96F;
	Thu, 13 Nov 2025 11:20:18 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E746633ADAF;
	Thu, 13 Nov 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032818; cv=none; b=AjPrIH2Up1ao3pgC255KOvwB2tuUc44cT+yZQPZu9lyTnxj+sYKGvlZW9V2zwsNpa5LXmuaDj34F1xEmfu9WaYzCIRPpXAyfYESNhjrHfRZmxa50/cuARnlruE5WYVkDyQtHyGGsfav+qKMX8Xca17UwrrgG/8UzEksfh332quI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032818; c=relaxed/simple;
	bh=6sh4gEpzZka45KBSDUYPPELbNhlKK57QS4xAYVbgdCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=awkLGvAvPmuNMuO7WwXDwzqJSZN6yQ3McKXHIfTt4E9UMOq1mgp+XhDIdW+E74pLoCLjvd76f3dBrzAa2ckhuk1eO6dAMkvzxkBqBowvdwaCxE8E3BO+xzZj89LImqZdVjgoZjxpoZwpHM8I9OEG4v9kz0ah6HCJzE6lFH+sMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 40BE4201C28;
	Thu, 13 Nov 2025 12:20:15 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C630201477;
	Thu, 13 Nov 2025 12:20:15 +0100 (CET)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CEC91180009C;
	Thu, 13 Nov 2025 19:20:13 +0800 (+08)
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: [PATCH] hwmon: (lm75) Add software-based alarm support for NXP P3T1750/P3T1755
Date: Thu, 13 Nov 2025 16:50:11 +0530
Message-Id: <20251113112011.28909-1-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

NXP P3T1750/P3T1755 does not provide readable alarm/status bits. To support
the standard tempX_alarm attribute, implement the comparator mode threshold
checks in the software using THIGH and TLOW registers.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
---
 drivers/hwmon/lm75.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 3c23b6e8e1bf..b25c19de05d4 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -116,6 +116,7 @@ struct lm75_data {
 	const struct lm75_params	*params;
 	u8				reg_buf[1];
 	u8				val_buf[3];
+	bool				alarm_state;
 };
 
 /*-----------------------------------------------------------------------*/
@@ -229,6 +230,7 @@ static const struct lm75_params device_params[] = {
 		.default_sample_time = 55,
 		.num_sample_times = 4,
 		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
+		.alarm = true,
 	},
 	[p3t1755] = {
 		.clr_mask = 1 << 1 | 1 << 7,	/* disable SMBAlert and one-shot */
@@ -236,6 +238,7 @@ static const struct lm75_params device_params[] = {
 		.default_sample_time = 55,
 		.num_sample_times = 4,
 		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
+		.alarm = true,
 	},
 	[pct2075] = {
 		.default_resolution = 11,
@@ -407,6 +410,49 @@ static int lm75_read(struct device *dev, enum hwmon_sensor_types type,
 			case tmp112:
 				*val = (regval >> 13) & 0x1;
 				break;
+
+			case p3t1750:
+			case p3t1755: {
+				unsigned int temp_raw, thigh_raw, tlow_raw;
+				s16 temp, thigh, tlow;
+
+				err = regmap_read(data->regmap, LM75_REG_TEMP, &temp_raw);
+				if (err)
+					return err;
+
+				err = regmap_read(data->regmap, LM75_REG_MAX, &thigh_raw);
+				if (err)
+					return err;
+
+				err = regmap_read(data->regmap, LM75_REG_HYST, &tlow_raw);
+				if (err)
+					return err;
+
+				temp = (s16)temp_raw;
+				thigh = (s16)thigh_raw;
+				tlow = (s16)tlow_raw;
+
+				/*
+				 * Implement software-based alarm logic for P3T1750/P3T1755.
+				 *
+				 * These devices do not provide readable alarm bits in hardware.
+				 * To comply with hwmon ABI and to support standard 'tempX_alarm'
+				 * attribute, check the current temperature against THIGH and TLOW
+				 * thresholds:
+				 *
+				 * - If temp >= thigh, set alarm = 1 (over-temperature condition).
+				 * - If temp < tlow, clear alarm = 0 (clear alarm).
+				 * - If temp is between tlow and thigh, keep previous alarm state
+				 *   to provide hysteresis behavior similar to hardware.
+				 */
+				if (!data->alarm_state && temp >= thigh)
+					data->alarm_state = true;
+				else if (data->alarm_state && temp < tlow)
+					data->alarm_state = false;
+
+				*val = data->alarm_state;
+				break;
+			}
 			default:
 				return -EINVAL;
 			}
-- 
2.25.1


