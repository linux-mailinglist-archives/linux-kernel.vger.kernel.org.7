Return-Path: <linux-kernel+bounces-791032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B85B2B3B160
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D391C860C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB842367C0;
	Fri, 29 Aug 2025 03:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="EvxHmYeL"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835E2236E5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436726; cv=none; b=Llu0ZbJa60FyChqU3BAY6C1Pr7l6VujSbBby1LxHGnkwfc3LQtVzUBSAE2fVfJOvv0ZpSmkheR609JB8wPmc55FVgsjptaXsjZitceABTjh0J/yv0TRxYEiTlofnPopbVvmIxKYxlSm7vjBlC+yXkqJiCnErXVApV4MjYrhojbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436726; c=relaxed/simple;
	bh=pzz8OKQDkQNq2e8JnSI2y1CTRs67MiIcQoSMs1Cv2EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhLDmyO26J3mZBF0FwalJYX8vJEHBP6BKw2gZZv5sQ9CXZm6Bc/uxT/olJUxCmFffGpfI7ObXPAPZfO4fROT3AUXwrvgaEQ53PemtQ/+LklClV0criUtQg4r9XmOdlC25LxXcKkERDglP7svcII+owtLWyBgvyDnzds9X8kfcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=EvxHmYeL; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 912452C0B41;
	Fri, 29 Aug 2025 15:05:15 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1756436715;
	bh=gPlbYJwwgm63JFIJGzC/gxcEnsL6BDCoyvSEU45EahQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EvxHmYeLWrR0Ohs/sIehnkbt9OvfI6X78mk5yOo2zb8EGvS90f8Z3LMaTCySIJWQO
	 Sk7k4FXMl5Xs9Az4eAJ7I+HrIhAALQ1IyTjgN6BrIoKG21zkb4UZ0YnFQC7smoTSHe
	 N2f65nEv0hNGPTpYLlJza20LlHW0NyAfRU3bsVyy6jYwnOkCWQPL+VBykMbogE7jBt
	 sreHoaCuJpHSVhMt5RIKHWreLaZsVAgJDJfXFWu698tl9MZdAouC5wWZXWVumrPaPz
	 1vOvrL/s15x9+2nZDho712GXxjamr+DHPAzPd5DYsYxfCme4ZOdaqo5N55GDWv9iAD
	 JpynyTW3pKQkg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B68b118eb0003>; Fri, 29 Aug 2025 15:05:15 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 1FB8013EE94;
	Fri, 29 Aug 2025 15:05:15 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 1EA1F280901; Fri, 29 Aug 2025 15:05:15 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	wenliang202407@163.com,
	jre@pengutronix.de
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 3/4] hwmon: (ina238) Add ina238_config fields
Date: Fri, 29 Aug 2025 15:05:11 +1200
Message-ID: <20250829030512.1179998-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829030512.1179998-1-chris.packham@alliedtelesis.co.nz>
References: <20250829030512.1179998-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Yo+sRJYX c=1 sm=1 tr=0 ts=68b118eb a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=2OwXVqhp2XgA:10 a=0ySDgBwBywXvpBaEfx8A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

In preparation for adding INA780 support add some required fields to
ina238_config and set the appropriate values for the existing chips.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - New. Split config struct changes from main patch

 drivers/hwmon/ina238.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
index 4d3dc018ead9..930e12e64079 100644
--- a/drivers/hwmon/ina238.c
+++ b/drivers/hwmon/ina238.c
@@ -120,13 +120,17 @@ enum ina238_ids { ina238, ina237, sq52206, ina228 }=
;
=20
 struct ina238_config {
 	bool has_20bit_voltage_current; /* vshunt, vbus and current are 20-bit =
fields */
+	bool has_shunt;			/* has shunt resistor */
 	bool has_power_highest;		/* chip detection power peak */
 	bool has_energy;		/* chip detection energy */
+	bool has_curr_min_max;		/* supports COL/CUL */
 	u8 temp_shift;			/* fixed parameters for temp calculate */
 	u32 power_calculate_factor;	/* fixed parameters for power calculate */
 	u16 config_default;		/* Power-on default state */
 	int bus_voltage_lsb;		/* use for temperature calculate, uV/lsb */
 	int temp_lsb;			/* use for temperature calculate */
+	int temp_max;			/* maximum configurable temp limit in mC */
+	int fixed_power_lsb;		/* fixed power LSB value */
 };
=20
 struct ina238_data {
@@ -141,43 +145,59 @@ struct ina238_data {
 static const struct ina238_config ina238_config[] =3D {
 	[ina238] =3D {
 		.has_20bit_voltage_current =3D false,
+		.has_shunt =3D true,
 		.has_energy =3D false,
 		.has_power_highest =3D false,
+		.has_curr_min_max =3D false,
 		.temp_shift =3D 4,
 		.power_calculate_factor =3D 20,
 		.config_default =3D INA238_CONFIG_DEFAULT,
 		.bus_voltage_lsb =3D INA238_BUS_VOLTAGE_LSB,
 		.temp_lsb =3D INA238_DIE_TEMP_LSB,
+		.temp_max =3D 125000,
+		.fixed_power_lsb =3D 0,
 	},
 	[ina237] =3D {
 		.has_20bit_voltage_current =3D false,
+		.has_shunt =3D true,
 		.has_energy =3D false,
 		.has_power_highest =3D false,
+		.has_curr_min_max =3D false,
 		.temp_shift =3D 4,
 		.power_calculate_factor =3D 20,
 		.config_default =3D INA238_CONFIG_DEFAULT,
 		.bus_voltage_lsb =3D INA238_BUS_VOLTAGE_LSB,
 		.temp_lsb =3D INA238_DIE_TEMP_LSB,
+		.temp_max =3D 125000,
+		.fixed_power_lsb =3D 0,
 	},
 	[sq52206] =3D {
 		.has_20bit_voltage_current =3D false,
+		.has_shunt =3D true,
 		.has_energy =3D true,
 		.has_power_highest =3D true,
+		.has_curr_min_max =3D false,
 		.temp_shift =3D 0,
 		.power_calculate_factor =3D 24,
 		.config_default =3D SQ52206_CONFIG_DEFAULT,
 		.bus_voltage_lsb =3D SQ52206_BUS_VOLTAGE_LSB,
 		.temp_lsb =3D SQ52206_DIE_TEMP_LSB,
+		.temp_max =3D 125000,
+		.fixed_power_lsb =3D 0,
 	},
 	[ina228] =3D {
 		.has_20bit_voltage_current =3D true,
+		.has_shunt =3D true,
 		.has_energy =3D true,
 		.has_power_highest =3D false,
+		.has_curr_min_max =3D false,
 		.temp_shift =3D 0,
 		.power_calculate_factor =3D 20,
 		.config_default =3D INA238_CONFIG_DEFAULT,
 		.bus_voltage_lsb =3D INA238_BUS_VOLTAGE_LSB,
 		.temp_lsb =3D INA228_DIE_TEMP_LSB,
+		.temp_max =3D 125000,
+		.fixed_power_lsb =3D 0,
 	},
 };
=20
@@ -572,7 +592,7 @@ static int ina238_write_temp(struct device *dev, u32 =
attr, long val)
 		return -EOPNOTSUPP;
=20
 	/* Signed */
-	val =3D clamp_val(val, -40000, 125000);
+	val =3D clamp_val(val, -40000, data->config->temp_max);
 	regval =3D div_s64(val * 10000, data->config->temp_lsb) << data->config=
->temp_shift;
 	regval =3D clamp_val(regval, S16_MIN, S16_MAX) & (0xffff << data->confi=
g->temp_shift);
=20
--=20
2.51.0


