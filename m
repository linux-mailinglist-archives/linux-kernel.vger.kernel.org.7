Return-Path: <linux-kernel+bounces-737163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A84B0A8A4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1F3A83D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491D52E6D10;
	Fri, 18 Jul 2025 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="AHu9xzH+"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E91EB5B;
	Fri, 18 Jul 2025 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856799; cv=none; b=EkhyxhwJ4ntST0z9+YnufiOhCY+m66j68WFTmYOMWChhP/rKGxpZjE9NZ3nNhVD6eWYu1m05jnEFQYzNFWA23PbVLiMhR2JSYBMno7Wg6DrAAeHPmNKpqv/vs+d73vnJWkpbFS/VAAdiamE2vympJNUY9E6UrDIzabUWAniSNt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856799; c=relaxed/simple;
	bh=jSJrORt+zktIU+MdXKWB9zDlk8JLptby9hINOQ0Zh48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cxfx9vOg6MgZ9dwG9ZW82ZprgKYD9zBQv2cog/MoymgerisgWsdlWLkCP2UYvwqZqIyxj0sv/lWmf7rf2gDmyr8mxSbJ1dSSOWbI55WenQSs04U3o8zZGYK5iBHhL10CpJ5PxyPiZeY4ZPcgF+IAdo2nyyxKFsK/SsShpld8nlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=AHu9xzH+; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 40AF8C6DAA;
	Fri, 18 Jul 2025 19:33:11 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 84B95C6DB1;
	Fri, 18 Jul 2025 19:33:10 +0300 (EEST)
Received: from antheas-z13 (x5996a89a.customers.hiper-net.dk [89.150.168.154])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id C39731FDA75;
	Fri, 18 Jul 2025 19:33:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1752856390;
	bh=0qBqnmMckTPpBCNrzJ/uZEyOLxnLE4NWtj3PbNYSdIQ=; h=From:To:Subject;
	b=AHu9xzH+N5GFhJnAi+g+iAX6lXD2l0HQf6TLFM9aC3ohh0lZOBv7nQhjMiEfXod9h
	 C9rLmkqLDHmH8sjK9IqW3RxAkH+tX7M4WvC61G7QZvudWUpqTyjAfJBiT1o9iPNoBn
	 m+202XggloTllzxBgNJkghVyhTGlPqU1vhn82wWG554pcChu1z2yT/GPWbEalwJN6b
	 HA74//+5cGOUXY6KlUmheaLrPCnFebuN3fFnRW2lj1b/O5YHJ+9K8vH0XKORVGkYf3
	 RI+TuH12MDGP8N/xrIKrUhFIK00R2cTPo4U6CY8XDdf9POkByGBLZAeUiey1m4+seM
	 CyfHjRnQjpIcw==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 89.150.168.154) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Eileen <eileen@one-netbook.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 1/2] platform/x86: oxpec: Fix turbo register for G1 AMD
Date: Fri, 18 Jul 2025 18:33:04 +0200
Message-ID: <20250718163305.159232-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175285639024.3276261.10156386364968385795@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.0.9 at linux3247.grserver.gr
X-Virus-Status: Clean

Turns out that the AMD variant of the G1 uses different turbo registers
than the Intel variant. Differentiate them and apply the correct ones
to the AMD variant.

Fixes: b369395c895b ("platform/x86: oxpec: Add support for the OneXPlayer G1")
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/oxpec.c | 37 +++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 06759036945d..9839e8cb82ce 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -58,7 +58,8 @@ enum oxp_board {
 	oxp_mini_amd_a07,
 	oxp_mini_amd_pro,
 	oxp_x1,
-	oxp_g1,
+	oxp_g1_i,
+	oxp_g1_a,
 };
 
 static enum oxp_board board;
@@ -247,14 +248,14 @@ static const struct dmi_system_id dmi_table[] = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER G1 A"),
 		},
-		.driver_data = (void *)oxp_g1,
+		.driver_data = (void *)oxp_g1_a,
 	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER G1 i"),
 		},
-		.driver_data = (void *)oxp_g1,
+		.driver_data = (void *)oxp_g1_i,
 	},
 	{
 		.matches = {
@@ -352,7 +353,8 @@ static umode_t tt_toggle_is_visible(struct kobject *kobj,
 	case oxp_mini_amd_a07:
 	case oxp_mini_amd_pro:
 	case oxp_x1:
-	case oxp_g1:
+	case oxp_g1_i:
+	case oxp_g1_a:
 		return attr->mode;
 	default:
 		break;
@@ -381,12 +383,13 @@ static ssize_t tt_toggle_store(struct device *dev,
 	case aok_zoe_a1:
 	case oxp_fly:
 	case oxp_mini_amd_pro:
+	case oxp_g1_a:
 		reg = OXP_TURBO_SWITCH_REG;
 		mask = OXP_TURBO_TAKE_VAL;
 		break;
 	case oxp_2:
 	case oxp_x1:
-	case oxp_g1:
+	case oxp_g1_i:
 		reg = OXP_2_TURBO_SWITCH_REG;
 		mask = OXP_TURBO_TAKE_VAL;
 		break;
@@ -426,12 +429,13 @@ static ssize_t tt_toggle_show(struct device *dev,
 	case aok_zoe_a1:
 	case oxp_fly:
 	case oxp_mini_amd_pro:
+	case oxp_g1_a:
 		reg = OXP_TURBO_SWITCH_REG;
 		mask = OXP_TURBO_TAKE_VAL;
 		break;
 	case oxp_2:
 	case oxp_x1:
-	case oxp_g1:
+	case oxp_g1_i:
 		reg = OXP_2_TURBO_SWITCH_REG;
 		mask = OXP_TURBO_TAKE_VAL;
 		break;
@@ -520,7 +524,8 @@ static bool oxp_psy_ext_supported(void)
 {
 	switch (board) {
 	case oxp_x1:
-	case oxp_g1:
+	case oxp_g1_i:
+	case oxp_g1_a:
 	case oxp_fly:
 		return true;
 	default:
@@ -659,7 +664,8 @@ static int oxp_pwm_enable(void)
 	case oxp_mini_amd_a07:
 	case oxp_mini_amd_pro:
 	case oxp_x1:
-	case oxp_g1:
+	case oxp_g1_i:
+	case oxp_g1_a:
 		return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, PWM_MODE_MANUAL);
 	default:
 		return -EINVAL;
@@ -686,7 +692,8 @@ static int oxp_pwm_disable(void)
 	case oxp_mini_amd_a07:
 	case oxp_mini_amd_pro:
 	case oxp_x1:
-	case oxp_g1:
+	case oxp_g1_i:
+	case oxp_g1_a:
 		return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, PWM_MODE_AUTO);
 	default:
 		return -EINVAL;
@@ -713,7 +720,8 @@ static int oxp_pwm_read(long *val)
 	case oxp_mini_amd_a07:
 	case oxp_mini_amd_pro:
 	case oxp_x1:
-	case oxp_g1:
+	case oxp_g1_i:
+	case oxp_g1_a:
 		return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
 	default:
 		return -EOPNOTSUPP;
@@ -742,7 +750,7 @@ static int oxp_pwm_fan_speed(long *val)
 		return read_from_ec(ORANGEPI_SENSOR_FAN_REG, 2, val);
 	case oxp_2:
 	case oxp_x1:
-	case oxp_g1:
+	case oxp_g1_i:
 		return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
 	case aok_zoe_a1:
 	case aya_neo_2:
@@ -757,6 +765,7 @@ static int oxp_pwm_fan_speed(long *val)
 	case oxp_mini_amd:
 	case oxp_mini_amd_a07:
 	case oxp_mini_amd_pro:
+	case oxp_g1_a:
 		return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);
 	default:
 		return -EOPNOTSUPP;
@@ -776,7 +785,7 @@ static int oxp_pwm_input_write(long val)
 		return write_to_ec(ORANGEPI_SENSOR_PWM_REG, val);
 	case oxp_2:
 	case oxp_x1:
-	case oxp_g1:
+	case oxp_g1_i:
 		/* scale to range [0-184] */
 		val = (val * 184) / 255;
 		return write_to_ec(OXP_SENSOR_PWM_REG, val);
@@ -796,6 +805,7 @@ static int oxp_pwm_input_write(long val)
 	case aok_zoe_a1:
 	case oxp_fly:
 	case oxp_mini_amd_pro:
+	case oxp_g1_a:
 		return write_to_ec(OXP_SENSOR_PWM_REG, val);
 	default:
 		return -EOPNOTSUPP;
@@ -816,7 +826,7 @@ static int oxp_pwm_input_read(long *val)
 		break;
 	case oxp_2:
 	case oxp_x1:
-	case oxp_g1:
+	case oxp_g1_i:
 		ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
 		if (ret)
 			return ret;
@@ -842,6 +852,7 @@ static int oxp_pwm_input_read(long *val)
 	case aok_zoe_a1:
 	case oxp_fly:
 	case oxp_mini_amd_pro:
+	case oxp_g1_a:
 	default:
 		ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
 		if (ret)
-- 
2.50.1



