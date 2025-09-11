Return-Path: <linux-kernel+bounces-811454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB2B52951
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1E45606F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E83267386;
	Thu, 11 Sep 2025 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm+Gy9Xb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59E239E81;
	Thu, 11 Sep 2025 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573799; cv=none; b=PvJabQObepIhsizoZLx2p8UqXjyEHonbhkF/xUCHyg5wEdaPQl3aiHMahAUfgEXTJb4vjBKHAzTb7l/mqVvdfi2gf/jYg+8HeQmD8F/hFUDzcsazzrTOxE0SwrK+Eg+WUqnnTlXEdV1TyY2945CkXM6pWMUP6u+Owote68tEV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573799; c=relaxed/simple;
	bh=HmpFicPrhQ4GrI+SJBypevcnMkaWy5cA7tgcSdGvEHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZHpqMybXu2iyNWq+knKQL56HacRSokCpX1OnQC+4LdazpDL7zteH8MB32tBL8PE7QJE5suYnGZQmpaSvYvOe1WgxKx7BxYercWBhU8XcUBdIL5hBSD9iZSmN90KFLf2zbk95Xnn5FeSpnpCCdp9gAlpNCDiRfdwuwskXn7y7D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm+Gy9Xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E098C4CEF5;
	Thu, 11 Sep 2025 06:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757573798;
	bh=HmpFicPrhQ4GrI+SJBypevcnMkaWy5cA7tgcSdGvEHc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bm+Gy9Xbw5M0DINGKV0pR9MEMbuq08NSKDrVsrEx9EGpy4h4r3XRjopPDIPkaP3mx
	 Q+ecqEWwGUtJhouce5oXA6erSfKZ+TaKVeWE9QTt4ULiD1ysU/UacGH/8+HwC2IpzM
	 MAiqHGnSYXJA5hp7XJW5XXanTw5M+3SGcmNiM/YVqImD4fJpHR1EQpT8UjnN02MdWJ
	 o6HPISVlHRCQ+iXFWq8BKLSaSbUzHkhzjs3hO4/mpxBtOtEJ5jLgt6+MnEobxd3/2u
	 677vJIz5j1I9hBRLrY8pBbyOx9PeOQGKVLDYXEVnKp8b36dOQQlrq1XHFm8jQ1XFLn
	 ppxRwFihRSfAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907F3CAC58D;
	Thu, 11 Sep 2025 06:56:38 +0000 (UTC)
From: Sung-Chi Li via B4 Relay <devnull+lschyi.google.com@kernel.org>
Date: Thu, 11 Sep 2025 06:56:34 +0000
Subject: [PATCH v6 1/3] platform/chrome: update pwm fan control host
 commands
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250911-cros_ec_fan-v6-1-a1446cc098af@google.com>
References: <20250911-cros_ec_fan-v6-0-a1446cc098af@google.com>
In-Reply-To: <20250911-cros_ec_fan-v6-0-a1446cc098af@google.com>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 Sung-Chi Li <lschyi@google.com>, Sung-Chi Li <lschyi@chromium.org>, 
 Tzung-Bi Shih <tzungbi@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757573797; l=2291;
 i=lschyi@google.com; s=20250911; h=from:subject:message-id;
 bh=XKg9pL8fIe9un0KsLGA/Xf6YwtKbC9ILlKEDmhqAsDU=;
 b=FvHu5OpVFEL0f244w4/fsq2OrKNUPTtwqaJQemt9+rCvk0KUy8TERMzTpaDrq3YVMtgCMH4u/
 4w7AAZyyKaPB1vKic0iSO2MgIfgyTPja9mAcahOuZXUVfRsg0zDmtsR
X-Developer-Key: i=lschyi@google.com; a=ed25519;
 pk=fBhhFxZrEyInLLODzeoq06UxQhKVqNjmZ2680pwMBCM=
X-Endpoint-Received: by B4 Relay for lschyi@google.com/20250911 with
 auth_id=518
X-Original-From: Sung-Chi Li <lschyi@google.com>
Reply-To: lschyi@google.com

From: Sung-Chi Li <lschyi@chromium.org>

Update cros_ec_commands.h to include definitions for getting PWM fan
duty, getting and setting the fan control mode.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/platform_data/cros_ec_commands.h | 29 +++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index c19b404e3d8d9ec895a17838aa6e271e235f0823..69294f79cc88aaa6289af3f104743ff0d93ab753 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -1825,6 +1825,16 @@ struct ec_response_pwm_get_duty {
 	uint16_t duty;     /* Duty cycle, EC_PWM_MAX_DUTY = 100% */
 } __ec_align2;
 
+#define EC_CMD_PWM_GET_FAN_DUTY 0x0027
+
+struct ec_params_pwm_get_fan_duty {
+	uint8_t fan_idx;
+} __ec_align1;
+
+struct ec_response_pwm_get_fan_duty {
+	uint32_t percent; /* Percentage of duty cycle, ranging from 0 ~ 100 */
+} __ec_align4;
+
 /*****************************************************************************/
 /*
  * Lightbar commands. This looks worse than it is. Since we only use one HOST
@@ -3127,14 +3137,31 @@ struct ec_params_thermal_set_threshold_v1 {
 
 /****************************************************************************/
 
-/* Toggle automatic fan control */
+/* Set or get fan control mode */
 #define EC_CMD_THERMAL_AUTO_FAN_CTRL 0x0052
 
+enum ec_auto_fan_ctrl_cmd {
+	EC_AUTO_FAN_CONTROL_CMD_SET = 0,
+	EC_AUTO_FAN_CONTROL_CMD_GET,
+};
+
 /* Version 1 of input params */
 struct ec_params_auto_fan_ctrl_v1 {
 	uint8_t fan_idx;
 } __ec_align1;
 
+/* Version 2 of input params */
+struct ec_params_auto_fan_ctrl_v2 {
+	uint8_t fan_idx;
+	uint8_t cmd; /* enum ec_auto_fan_ctrl_cmd */
+	uint8_t set_auto; /* only used with EC_AUTO_FAN_CONTROL_CMD_SET - bool
+			   */
+} __ec_align4;
+
+struct ec_response_auto_fan_control {
+	uint8_t is_auto; /* bool */
+} __ec_align1;
+
 /* Get/Set TMP006 calibration data */
 #define EC_CMD_TMP006_GET_CALIBRATION 0x0053
 #define EC_CMD_TMP006_SET_CALIBRATION 0x0054

-- 
2.51.0.384.g4c02a37b29-goog



