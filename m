Return-Path: <linux-kernel+bounces-821466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26BFB81504
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA131683C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DB7301710;
	Wed, 17 Sep 2025 18:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="edqcO8SY"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54982FFDC9;
	Wed, 17 Sep 2025 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132670; cv=none; b=rlSvL8Zo3N3n+feJMQ6uJyG30pgQfV54Zq1KPTjS5nPTL05WfwafUpFsZ2TmMk3xyBI7VnRaOPF8Bzgi7QlnjGLypstmqOAlgortzZ35nULIrZVqLx9D4bCX9pP2xTbofPhynuL7b6wUfbdvJB1dQJnC6uk4QXd4NiOfiHKsFX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132670; c=relaxed/simple;
	bh=tzcGfSS7gnYEBx8TXY3VDLR8HICoV3aUSuiFO5lghvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SQ4aLST5HAic/kleAXmoasc6UWW/WzYyJZQdekkSHo220qFRum6xLz4/QP/HQTjPR08He0B1JdRWvsnDh9/69LIKaEGyfVSPO411Qn2xeP929WKkLcUkVjoL03X2BMhiIB+O9/AXgIL2nlkDNKY9PSfC0IRuHyi6xUAhPqYzJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=edqcO8SY; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758132650; x=1758737450; i=w_armin@gmx.de;
	bh=9D/Y1uLEmnPzDJTHwZFhPNecM+RYeSIhgRtjdsjeCWI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=edqcO8SYb+rz+06PNUO+9WtM02tRSZgpS4W52TZXLtyrjkhcT8Rn1B4oPR1JwEUf
	 ZXXQNz+BE8MisnickJdy3B8ZujmtJRoAGwH6OEPgwYm4gFPqJEurMwWvUwrxvFxsb
	 pZh52HcX+4gx7zz1dZL7Z3HroIoCCupC1TiUExI/CvST0f9rcxfWZI+rLlt8H3wC1
	 V6Zt/OVnjam2Vxkt1XIlJWJocjYj3wG+EHLxraZwdpLONcmFGAkTGMUJGzLudBI7J
	 4kTpnONfB+B74ILTBMchtgMUp31QwV95jMhNh7IN9SSdX2hSgAnAfb716ZT/Sj37P
	 imusfROSxYtM0ffrgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MAwbz-1v5m643SJt-00Fdid; Wed, 17 Sep 2025 20:10:49 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] hwmon: (dell-smm) Remove Dell Precision 490 custom config data
Date: Wed, 17 Sep 2025 20:10:33 +0200
Message-Id: <20250917181036.10972-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250917181036.10972-1-W_Armin@gmx.de>
References: <20250917181036.10972-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nxPb/sBBYWtXlZdNNzMUyxUI/Trh3Q/aZvm8d0YkHwIeZCskSky
 Ht7LPTALowNlPqqTjWQuqafIBICrHgcBJM51jdn0ZGqp5H8uJSw1vErrQ88QDKx57frXtuA
 Asif0KY3Ir6WIeodepKd6TD3vqF7BaLIMFqfpLwkuu/aWrddT/WwLdy3mDbTyQULRBvLhmo
 7McI0rHjcd260lmjYCAYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6QYnEAwwBvU=;GL7PjgrGI3/DpVq7oO5kFRn43wH
 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
 LuSDzxwv0YlgiJCFvAqkDHEMoCMmflRQ==

It turns out the second fan on the Dell Precision 490 does not
really support I8K_FAN_TURBO. Setting the fan state to 3 enables
automatic fan control, just like on the other two fans.
The reason why this was misinterpreted as turbo mode was that
the second fan normally spins faster in automatic mode than
in the previous fan states. Yet when in state 3, the fan speed
reacts to heat exposure, exposing the automatic mode setting.

Link: https://github.com/lm-sensors/lm-sensors/pull/383
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 1e2c8e284001..3f61b2d7935e 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1331,7 +1331,6 @@ struct i8k_config_data {
=20
 enum i8k_configs {
 	DELL_LATITUDE_D520,
-	DELL_PRECISION_490,
 	DELL_STUDIO,
 	DELL_XPS,
 };
@@ -1341,10 +1340,6 @@ static const struct i8k_config_data i8k_config_data=
[] __initconst =3D {
 		.fan_mult =3D 1,
 		.fan_max =3D I8K_FAN_TURBO,
 	},
-	[DELL_PRECISION_490] =3D {
-		.fan_mult =3D 1,
-		.fan_max =3D I8K_FAN_TURBO,
-	},
 	[DELL_STUDIO] =3D {
 		.fan_mult =3D 1,
 		.fan_max =3D I8K_FAN_HIGH,
@@ -1364,15 +1359,6 @@ static const struct dmi_system_id i8k_config_dmi_ta=
ble[] __initconst =3D {
 		},
 		.driver_data =3D (void *)&i8k_config_data[DELL_LATITUDE_D520],
 	},
-	{
-		.ident =3D "Dell Precision 490",
-		.matches =3D {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME,
-				  "Precision WorkStation 490"),
-		},
-		.driver_data =3D (void *)&i8k_config_data[DELL_PRECISION_490],
-	},
 	{
 		.ident =3D "Dell Studio",
 		.matches =3D {
=2D-=20
2.39.5


