Return-Path: <linux-kernel+bounces-833844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF6BBA332C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AC41C01F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A228D8F1;
	Fri, 26 Sep 2025 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XcfYHaNt"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED20F1A9FA4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879622; cv=none; b=IqQfO/ImYp+r3pA9BFawPJfEUtZaOXmR7Wqi+48p+81D0oZOiq0/76VcHXklainYIgsI48BVntdV/APWxVufybUWm9p5+4kUAbYM2eBrhtLefdXp5o9KY0iOS1aEsZrkGK3+0szba7hHumjxGz/GOW7UU6z6Hxwj32VVNwVaflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879622; c=relaxed/simple;
	bh=dQzpoB++ebHK4mATn7wtPFef9km/ae5ml0+k4vbRy3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYpR/0tDcScVMo7B0++M7x9dCGBHDqCb91X8RgxcPRRyyDI1renshyOedfruNqWTWZ/0Se0XI0rlKC5pgevMdyLtoY4WEmU1pKjTj8Lm3zwGKG2K14wGSRlyKWSvv+RNL899vvMYL3EkvXvcsFZb/AimtuUY3JECfmIZmnFQbmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XcfYHaNt; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 739D33FD00
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758879616;
	bh=Z5kDmnvnhlDRdp/yu6a3wA2T9wPYLylMulJWmEaCrD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=XcfYHaNtgQsJqVg0nhOioS5sDCNFWbq0m/kymCYVAIdCzIUoZ+8efwTDQgO7Ud3Nk
	 1Aj1LxdelyVH/jW2LwZwGR5kHQ0XDhsljewgnKr5Tb61HonJR/3jtv1kMM0DaUORDU
	 lBhtmpz3UztDFmOQMws6L/Pnm3+LAk1sm5Q8K7RjVvRZMomj/+3baFIhJ7LHjfQir7
	 PpXQL0xZSGW72p3RxclwYQXM0cLXd5ccOwCvCPp3EhhrMW7RPpQznLPC/kcpVqZLur
	 RHExJMhZ8SYRESE8/LVgnbhV4CHjtKcq072syu0QmxvOiS6YSOTxLVJsln9IWnVzc7
	 1klgQE9P47hww==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4d6fc3d74a2so56169181cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879615; x=1759484415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5kDmnvnhlDRdp/yu6a3wA2T9wPYLylMulJWmEaCrD0=;
        b=jqrnDE/N+JZbDYdTMasxL/JDxo6NmgL5SqgtTI+tCZVWsvThkZ/JsisIkIG0mBbya7
         Q+YlVj26fWHUO7VDuCT4+SpmRvzufSbs/5SJQIsje9dIFcP1mSLfmaubsSPzmxWDSHNg
         LCLPmBTniLxGjdf/4OYNdspPXCe+c633X/2mOARY5Bnwox6QzbjE/d6e06+iiHU4nXNy
         nxsyyMpy2XqM0x0FabnxvJXCLTM0C3yaU3++/VcwhzXsWedFBmqXsOp2S9en72iLc4Oc
         QqcGSHYSdmaWd4A+AOf6G29AZUGMO0PNdfRC2mQnJz9EmJCrHktMmGv0VRD8WxUv60iX
         0+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAhImg570TLeDT9uCMsi1QmlW54kDJRIVtMbQLui9S6Dsx2ZzBzHA+IaKYA0eaWI2EetYa3DjNvWiWJrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhTUV6ppM+KwrmPtB642Ud3BIeWPKpuYwUtNis44hgy6E6VVLk
	kSZr35hwPpKrUQ+XpV7lyLPDfcWJ8slaqS9QGk7K3BS52UDasfrIS9cNce8+gUbcT3npuD09Ljk
	EWGS5pBTfEVa1aDqmhkwGjBy6vOXm/SQN2cos9FFX2OkzgVrgnNkkbcA2LD4xu3ChE0t8s+9Olu
	T832yAFA==
X-Gm-Gg: ASbGncs7rNHqz458mPeTjEa7cSOJC24Eae+tvnbWUJnPTlu0tVzIgroFgcotbusAeDg
	5E0sIa2ogWwCceNHGh3YlwbrTzciJeQajc+2Ggzy2KlEDMCz+B5kHH5vIMfPobZjLxFneTE1gQh
	aAJnQCpBk3Xe1yJhf1rVzP0utu1hDhRGUhOuUjmc42pkSBILa9/fp8V2DZ4s5D3EW5JK+iJxDNS
	jAbUNYuEjthGNQnGLm0JXxrxiAuio6cKolKOYY+vTbzrgZUl55XD2ZfzfYUkcsSkUylaSNa+isg
	K/4uyvF/ibF4K5cbyl/Yfd6oXe+8EqMwbYghH8NKhdlwTbzEjGCfu5Zs
X-Received: by 2002:a05:622a:3d2:b0:4b5:e8b9:30f7 with SMTP id d75a77b69052e-4da4b807e9bmr98240431cf.46.1758879615475;
        Fri, 26 Sep 2025 02:40:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDKtjAu7rS5XGAm/zzFv4YkYyqjAXqHUIUP7F2BwPon3qUmzfWY0fG/FuWugk1l3HM5ToH/Q==
X-Received: by 2002:a05:622a:3d2:b0:4b5:e8b9:30f7 with SMTP id d75a77b69052e-4da4b807e9bmr98240231cf.46.1758879615163;
        Fri, 26 Sep 2025 02:40:15 -0700 (PDT)
Received: from localhost.localdomain ([103.155.100.14])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-80135b563b2sm23419766d6.14.2025.09.26.02.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 02:40:14 -0700 (PDT)
From: Aaron Ma <aaron.ma@canonical.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	suraj.kandpal@intel.com,
	imre.deak@intel.com,
	joonas.lahtinen@linux.intel.com,
	aaron.ma@canonical.com
Subject: [PATCH v2 1/2] drm/dp: Add drm_edp_backlight_get_level
Date: Fri, 26 Sep 2025 17:38:31 +0800
Message-ID: <20250926093832.2811200-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement drm_edp_backlight_get_level() to read the current
backlight brightness level from eDP DPCD registers via AUX channel.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
v1 -> v2: Use drm_err.

 drivers/gpu/drm/display/drm_dp_helper.c | 52 +++++++++++++++++++++++++
 include/drm/display/drm_dp_helper.h     |  1 +
 2 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 1ecc3df7e3167..16da5df805aa5 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -3945,6 +3945,58 @@ int drm_dp_pcon_convert_rgb_to_ycbcr(struct drm_dp_aux *aux, u8 color_spc)
 }
 EXPORT_SYMBOL(drm_dp_pcon_convert_rgb_to_ycbcr);
 
+/**
+ * drm_edp_backlight_get_level - Get the backlight level of eDP DPCD via AUX
+ * @aux: The DP aux device
+ * @bl: Backlight capability info from the panel
+ *
+ * Reads the current backlight brightness level from luminance mode
+ * (24-bit value in nits) or DPCD AUX mode(16-bit and 8-bit modes).
+ *
+ * Returns: Current backlight level.
+ */
+u32 drm_edp_backlight_get_level(struct drm_dp_aux *aux, const struct drm_edp_backlight_info *bl)
+{
+	int ret;
+	u8 buf[3] = { 0 };
+	u32 level = 0;
+
+	if (!(bl->aux_set || bl->luminance_set))
+		return 0;
+
+	if (bl->luminance_set) {
+		ret = drm_dp_dpcd_read(aux, DP_EDP_PANEL_TARGET_LUMINANCE_VALUE, buf, sizeof(buf));
+		if (ret < 0) {
+			drm_err(aux->drm_dev,
+				      "%s: Failed to read luminance value: %d\n",
+				      aux->name, ret);
+			return 0;
+		}
+		level = (buf[2] << 16 | buf[1] << 8 | buf[0]) / 1000;
+	} else if (bl->lsb_reg_used) {
+		ret = drm_dp_dpcd_read(aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, buf, 2);
+		if (ret < 0) {
+			drm_err(aux->drm_dev,
+				      "%s: Failed to read backlight level: %d\n",
+				      aux->name, ret);
+			return 0;
+		}
+		level = buf[0] << 8 | buf[1];
+	} else {
+		ret = drm_dp_dpcd_read(aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, buf, 1);
+		if (ret < 0) {
+			drm_err(aux->drm_dev,
+				      "%s: Failed to read backlight level: %d\n",
+				      aux->name, ret);
+			return 0;
+		}
+		level = buf[0];
+	}
+
+	return level;
+}
+EXPORT_SYMBOL(drm_edp_backlight_get_level);
+
 /**
  * drm_edp_backlight_set_level() - Set the backlight level of an eDP panel via AUX
  * @aux: The DP AUX channel to use
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 87caa4f1fdb86..0b045a47ae573 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -864,6 +864,7 @@ drm_edp_backlight_init(struct drm_dp_aux *aux, struct drm_edp_backlight_info *bl
 		       u32 max_luminance,
 		       u16 driver_pwm_freq_hz, const u8 edp_dpcd[EDP_DISPLAY_CTL_CAP_SIZE],
 		       u32 *current_level, u8 *current_mode, bool need_luminance);
+u32 drm_edp_backlight_get_level(struct drm_dp_aux *aux, const struct drm_edp_backlight_info *bl);
 int drm_edp_backlight_set_level(struct drm_dp_aux *aux, const struct drm_edp_backlight_info *bl,
 				u32 level);
 int drm_edp_backlight_enable(struct drm_dp_aux *aux, const struct drm_edp_backlight_info *bl,
-- 
2.43.0


