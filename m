Return-Path: <linux-kernel+bounces-732522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEE3B06819
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801431888729
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031BC2C1596;
	Tue, 15 Jul 2025 20:49:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B52C08A0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612564; cv=none; b=Z7yyVhIzJ6jbaz5qUj7QN2LHJzrJiratpuf2P5nauq6zoN2okndJVjFJv95stiextq7C7LlHPkwdJJv+e59vFex8/LatS9r0N1vqK8TbxcUuBU6oWlHJkxSt2enP27t246nwD1ZxllLvqVW3wsrmVWRLB6uFjMwsUvGv9C8eTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612564; c=relaxed/simple;
	bh=WssqkErbhL2T08N7gZu0oUt7u3JLlXLIOeaUBCh7otc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEXpSPbWQSfWx0lkdZpjMHra8dbKMhAvgXv64WPs32XJR2jVqgThQJAAbNy4FUSR7h81Tjur6i6Ql8Vop3eGKwIPTjPMUWUXWMIzS19lMfGGRyw5bue7j29SXveaEq5dZwmTAlyec0r0gFV4Vzd5gkDrTLqb6S03zSib51ZsKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1ubmaI-0008KV-HY; Tue, 15 Jul 2025 22:49:06 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Tue, 15 Jul 2025 22:49:01 +0200
Subject: [PATCH 2/4] hwmon: ina238: Add label support for voltage inputs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-ina228-v1-2-3302fae4434b@pengutronix.de>
References: <20250715-ina228-v1-0-3302fae4434b@pengutronix.de>
In-Reply-To: <20250715-ina228-v1-0-3302fae4434b@pengutronix.de>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2255; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=WssqkErbhL2T08N7gZu0oUt7u3JLlXLIOeaUBCh7otc=;
 b=owGbwMvMwCF2ZcYT3onnbjcwnlZLYsgo23dgucWZjQ+ko5P4k31fMHbNMsxZnH6o1fn1GeO1J
 1OV+wuVOkpZGMQ4GGTFFFli1eQUhIz9r5tV2sXCzGFlAhnCwMUpABNRLWZk+HRi4pdelsQ/n1je
 KHyNCnYvmrjnXeKd55ZiwXO2vm0MW8fIsG9KTIDLieNL4rbuOvQgQKhs0fEj2wTEzub5ZTifmrf
 hHBcA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The INA family of power monitors estimate power consumption based on
two voltage measurements: across a shunt resistor and across the bus.

Conveniently label them "Shunt Voltage" and "Bus Voltage".

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 drivers/hwmon/ina238.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
index d603d4990c928984350c1f414431219b1489a546..44f7ce3c1d7b5a91f67d12c1d29e1e560024a04c 100644
--- a/drivers/hwmon/ina238.c
+++ b/drivers/hwmon/ina238.c
@@ -507,6 +507,27 @@ static ssize_t energy1_input_show(struct device *dev,
 	return sysfs_emit(buf, "%llu\n", energy);
 }
 
+static int ina238_read_string(struct device *dev, enum hwmon_sensor_types type,
+			       u32 attr, int channel, const char **str)
+{
+	switch (type) {
+	case hwmon_in:
+		switch (channel) {
+		case 0:
+			*str = "Shunt Voltage";
+			return 0;
+		case 1:
+			*str = "Bus Voltage";
+			return 0;
+		default:
+			break;
+		}
+	default:
+		break;
+	}
+	return -EOPNOTSUPP;
+}
+
 static int ina238_read(struct device *dev, enum hwmon_sensor_types type,
 		       u32 attr, int channel, long *val)
 {
@@ -565,6 +586,7 @@ static umode_t ina238_is_visible(const void *drvdata,
 		case hwmon_in_input:
 		case hwmon_in_max_alarm:
 		case hwmon_in_min_alarm:
+		case hwmon_in_label:
 			return 0444;
 		case hwmon_in_max:
 		case hwmon_in_min:
@@ -615,9 +637,9 @@ static umode_t ina238_is_visible(const void *drvdata,
 static const struct hwmon_channel_info * const ina238_info[] = {
 	HWMON_CHANNEL_INFO(in,
 			   /* 0: shunt voltage */
-			   INA238_HWMON_IN_CONFIG,
+			   INA238_HWMON_IN_CONFIG | HWMON_I_LABEL,
 			   /* 1: bus voltage */
-			   INA238_HWMON_IN_CONFIG),
+			   INA238_HWMON_IN_CONFIG | HWMON_I_LABEL),
 	HWMON_CHANNEL_INFO(curr,
 			   /* 0: current through shunt */
 			   HWMON_C_INPUT),
@@ -633,6 +655,7 @@ static const struct hwmon_channel_info * const ina238_info[] = {
 
 static const struct hwmon_ops ina238_hwmon_ops = {
 	.is_visible = ina238_is_visible,
+	.read_string = ina238_read_string,
 	.read = ina238_read,
 	.write = ina238_write,
 };

-- 
2.39.5


