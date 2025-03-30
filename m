Return-Path: <linux-kernel+bounces-581182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02677A75B8C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 19:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B923A7E77
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Mar 2025 17:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B2115CD74;
	Sun, 30 Mar 2025 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xywyF7v9"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854FB14B08A
	for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743356990; cv=none; b=nAZ/FHlwVY2gjsCXQifJ216c2ktNHGb3Cx70gnZmZRDQGwmxXHW3JIVCEZWbG3am4fyXl7k9FG6htDYyQZUL4ScC7egbtdeifojLKUBe/yCWmFQqDUUPtcx2WKwyahhRGgekCHdTZkEPJMv0kvOc9BVCBlB99iglCL/SQ6MOiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743356990; c=relaxed/simple;
	bh=k2WStpzaSUTMJxzO4XEqgL2lzxzZWdjGouOPjYJ3wx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AB5ks/CFENVWHxD0aRZuOxTQgQmmfoudE39Xd46viSe5UQZ91BpZxhD2YlvH6hUj3r2lHsYDZMEJ9pfys7O0oExC+zbBQOZ1kUDqhEwxOGK7cPq470jlqbe/Sn1w566tRU9ht53Hx5wsUMMsLzFuIZqFTRqc165QmIuXvVmRESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xywyF7v9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so23259485e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Mar 2025 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743356987; x=1743961787; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i5USGsww5N5Kq0vLfinvKo+QKTveZgSU6cSQ9ak/gNE=;
        b=xywyF7v9w7bUZYoYNTNAbVMiLu0g34Pel5juNaLgqIWcRgpsEq21S0+GI0i+UUkETV
         Tv2bwGmivkq39Ca4VOYvqD9iTHGvm7O2G2f7anJyKxi3IUbdCRPxXoHmmQCfrcLYvqWf
         bNyfbaUG+0l2Lxws7Coc9qtaovzbzOXu0xxTAMVPEM/996H7ZP1DvVHUR8QCQXXbBXcZ
         aIlKkBkzQuVAkEmw3GsxBrK+O7fQoZXPZQgztq1I0DziyE88IE3oe63UfL4LCJrS7Y1g
         jrInWU5rTVyPnfbBUGyizpWGfNaNQnrh8fgZ+lwseodlf7m4fnAu+QHMkjmHaqu4lcPG
         fehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743356987; x=1743961787;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5USGsww5N5Kq0vLfinvKo+QKTveZgSU6cSQ9ak/gNE=;
        b=Hp1ugriwQiocY1pumtpxOu+yVZLr1mNnThfbOuTQbC5hebHyaPQc4AO/7Gk44hQdQb
         ipwNRObCeJ0Hu/P+ydOeIH+5t1NwWh2H17b3XH6PgBjmm30hI7HdfZicOkMV+UlH2NI/
         6WGQOMrzbJWG0NuH9NzWE2ucSzKCTXuj5MZ9xZcCoJeMSzmAnn8dsKkxCDiK6SNJLxMg
         TJgKbkTh457xjQIrgcKzlSxl0TCgmnk7OKmCTMTG9sjXKZp9aV2Dm/zGb6qe3dkmxShM
         SwqWRdgHopjo030+5G35Eq3FLE5gd/bzP7JiZWGc9xBLwG8EM/ZvFmPE2+19qY9vNaZv
         PH4A==
X-Forwarded-Encrypted: i=1; AJvYcCXK/UjoNNM23JAGmry86tRrQuPtea38oaD56xWpEyDk1NRXQmixVjkx3SDW5vS/xULV2R6S4v3Tmjn44+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycOg9fFvlOEoas8bLEpZv5Pvm6PVmmMMNJa59Hio1NZySYwd51
	Pl7llqq78vTCvOEROlVIdMiYt6dqlLPKfJ6khEVy54PqnBGzFcNhoEI8f9jd4vI=
X-Gm-Gg: ASbGnct2Vhv7carr6ifUd4oG6RdpUCXHnnYbrhr1nrFrQVMRhopI6ZSQGaoaal1bE0b
	vzo+KVM2T5+xLSD1iNaJRFYRxmANDGQnC8TzKdNS5k9huCxtx7+8wXzKdrIYf3Qh7NYPes533PJ
	K8D0/WzScVPFByoFUQxLYK56Ebn4c713x02Q2tifPprF2CUWv9zU0MBKE9N4uIpYHNYBfcFZ6t8
	XudCCKevKdYBxYklep4dg66SDgLP/v/UGqhJ1EoupqHa034BSSOeDLxynsFfPjGgpSxz7RgGLVs
	HvjXU7IipwpMqbiOoMsQKZWpRzToUn139Ju+bHRwjtMkaMKadGokfyuN
X-Google-Smtp-Source: AGHT+IEYLK445Y/zgB7+1Y6TO03yznq3naIzTBs/Sb5bDYqFKZU8hEvFN4VaBTPIuiCN/06rWIoCmw==
X-Received: by 2002:a05:600c:5108:b0:43c:fe15:41d4 with SMTP id 5b1f17b1804b1-43db6248b78mr48210495e9.18.1743356986564;
        Sun, 30 Mar 2025 10:49:46 -0700 (PDT)
Received: from localhost ([2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d830f5ea4sm142507725e9.25.2025.03.30.10.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 10:49:46 -0700 (PDT)
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Sun, 30 Mar 2025 18:49:40 +0100
Subject: [PATCH v5] drm/dp: clamp PWM bit count to advertised MIN and MAX
 capabilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v5-1-25083d9732fc@linaro.org>
X-B4-Tracking: v=1; b=H4sIADOE6WcC/6XNsW7DIBSF4VeJmHurCxiMO+U9og5grm0kF1yw3
 FaR3704U6JObcdzhu+/skI5UGEvpyvLtIUSUqxDPZ1YP9k4EgRfNxMoFErRwkdYIDlns+/hvU9
 vsPKmQJrJw2IjzeByGKc1UinQoECjldPKIKvikmkIn7fa5bXuKZQ15a9bfBPH+7fOJoAD176XR
 Iii1ec5RJvTc8ojO0KbvMMl/g6XB660Qe671hr7A2/+gTcVN4oG7Dru/GAe8H3fvwGkYZAdoQE
 AAA==
X-Change-ID: 20250327-wip-obbardc-qcom-t14s-oled-panel-brightness-4020865b6580
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Johan Hovold <johan@kernel.org>, Rui Miguel Silva <rui.silva@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5452;
 i=christopher.obbard@linaro.org; h=from:subject:message-id;
 bh=k2WStpzaSUTMJxzO4XEqgL2lzxzZWdjGouOPjYJ3wx0=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBn6YQ2lqnpa3jCVgm6D846L+t3xu4phENAAvBeK
 UrK/CBz5AaJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCZ+mENgAKCRBjTcTwaHBG
 +FcyEACOiabeX6guwtfWuBjGGoAJln4f2Olg0rP1qh64CCOiH+gVYMMRGXkoBYL5zrKkOww0mHC
 EKGbq6rWH3AzyJRtyhLK1qOYAUJ5lk7xt/FFP7K/evoLQW5LefLTq3CLF+c75ezkrZICNSx1cqm
 rMFrTqPkRWZzSI23CFKuRriOK3+ruYffB5Bom7GdcZ1uRxC1IHQlssl04l4Zn5rVKOI0qVfz1Ca
 YL1Kjj8tW3XnZo1t6IIpKdhkFDKQtF5GpJelVz+gEOtmj5QFZFANgvHNf8RiFDC5XUAVVd3PguA
 LjiIEyZ3O3h3KHekqKRw6FhV+tYOQ2yVgX8Zap7FQ1b+B8EjaSFiYT3j/rBW9mcsvlwXIGYu5L/
 Cl3KTE/JoDZ895mp5JWK7G0juYYtQ16MFlmk7L2Ohbo4eXh1Jao/lKMGVschWQVcchyuPz2h/wY
 9fwiTFBN/jns+QGoWLJkwcHREmUucaZ0mDE78gNwoq6Wx/oDmZ1ZU9IlGgm/8MKkr6W/nsn3R5u
 kVAaC2RDW8UV/fDYm3trsLFaBpQ8Sea0dN3QOlrQgOqzQyE4HyCTcoiI+l894mOLZ8DKGRQuH6k
 i+zBFonwW9hXXcY6yo2NviQqP9CTxd9NUaa3J9g7kbNhF8hDhD5NJWIc1B8Ud8Yrst5s/WC578P
 cXPSqLYOk/JXUWQ==
X-Developer-Key: i=christopher.obbard@linaro.org; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8

According to the eDP specification (VESA Embedded DisplayPort Standard
v1.4b, Section 3.3.10.2), if the value of DP_EDP_PWMGEN_BIT_COUNT is
less than DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, the sink is required to use
the MIN value as the effective PWM bit count.

This commit updates the logic to clamp the reported
DP_EDP_PWMGEN_BIT_COUNT to the range defined by
DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN and _CAP_MAX. As part of this change,
the behavior is modified such that reading _CAP_MIN and _CAP_MAX
registers is now required to succeed. Before reading these registers
was optional.

This ensures correct handling of eDP panels that report a zero PWM
bit count but still provide valid non-zero MIN and MAX capability
values. Without this clamping, brightness values may be interpreted
incorrectly, leading to a dim or non-functional backlight.

For example, the Samsung ATNA40YK20 OLED panel used in the Lenovo
ThinkPad T14s Gen6 (Snapdragon) reports a PWM bit count of 0, but
supports AUX backlight control and declares a valid 11-bit range.
Clamping ensures brightness scaling works as intended on such panels.

Co-developed-by: Rui Miguel Silva <rui.silva@linaro.org>
Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
---
Changes in v5:
- Correctly check return value when reading PWMGEN_BIT_COUNT_CAP_MIN
  and _CAP_MAX.
- Link to v4: https://lore.kernel.org/r/20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v4-1-85ef0991bdf8@linaro.org

Changes in v4:
- Remove unrelated whitespace changes.
- Remove unrelated commit change.
- Add note to commit message about changing read of PWMGEN_BIT_COUNT_CAP_MIN
  and _CAP__MAX from optional to required.
- Link to v3: https://lore.kernel.org/r/20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v3-1-156801d97a8a@linaro.org

Changes in v3:
- Properly rebase patch on top of latest version of drm-misc-next.
- Make patch more generic by clamping PWM bit count to advertised MIN
  and MAX capabilities (suggested by Dmitry).
- Link to v2: https://lore.kernel.org/r/20250327-wip-obbardc-qcom-t14s-oled-panel-brightness-v2-1-16dc3ee00276@linaro.org

Changes in v2:
- Split backlight brightness patch from T14s OLED enablement series.
- Use PWMGEN_CAP_MIN rather than MAX (Dmitry).
- Rework commit message to reference eDP spec.
- Rebase on drm-misc-next.
- Link to v1: https://lore.kernel.org/all/20250325-wip-obbardc-qcom-t14s-oled-panel-v2-4-e9bc7c9d30cc@linaro.org/
---
 drivers/gpu/drm/display/drm_dp_helper.c | 42 +++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e2439c8a7fefe116b04aaa689b557e2387b05540..5550c40310c55ee275b3ebec08a7500cab38ae78 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -28,6 +28,7 @@
 #include <linux/init.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
@@ -4035,6 +4036,32 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
 	}
 
 	pn &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
+
+	ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
+	if (ret < 0) {
+		drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap min: %d\n",
+			    aux->name, ret);
+		return -ENODEV;
+	}
+	pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
+
+	ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
+	if (ret < 0) {
+		drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap max: %d\n",
+			    aux->name, ret);
+		return -ENODEV;
+	}
+	pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
+
+	/*
+	 * Per VESA eDP Spec v1.4b, section 3.3.10.2:
+	 * If DP_EDP_PWMGEN_BIT_COUNT is less than DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN,
+	 * the sink must use the MIN value as the effective PWM bit count.
+	 * Clamp the reported value to the [MIN, MAX] capability range to ensure
+	 * correct brightness scaling on compliant eDP panels.
+	 */
+	pn = clamp(pn, pn_min, pn_max);
+
 	bl->max = (1 << pn) - 1;
 	if (!driver_pwm_freq_hz)
 		return 0;
@@ -4061,21 +4088,6 @@ drm_edp_backlight_probe_max(struct drm_dp_aux *aux, struct drm_edp_backlight_inf
 	 * - FxP is within 25% of desired value.
 	 *   Note: 25% is arbitrary value and may need some tweak.
 	 */
-	ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
-	if (ret < 0) {
-		drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap min: %d\n",
-			    aux->name, ret);
-		return 0;
-	}
-	ret = drm_dp_dpcd_read_byte(aux, DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
-	if (ret < 0) {
-		drm_dbg_kms(aux->drm_dev, "%s: Failed to read pwmgen bit count cap max: %d\n",
-			    aux->name, ret);
-		return 0;
-	}
-	pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
-	pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
-
 	/* Ensure frequency is within 25% of desired value */
 	fxp_min = DIV_ROUND_CLOSEST(fxp * 3, 4);
 	fxp_max = DIV_ROUND_CLOSEST(fxp * 5, 4);

---
base-commit: 4c4d9b7b6c6e676eca22585139aba5f03de74b90
change-id: 20250327-wip-obbardc-qcom-t14s-oled-panel-brightness-4020865b6580

Best regards,
-- 
Christopher Obbard <christopher.obbard@linaro.org>


