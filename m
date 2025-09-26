Return-Path: <linux-kernel+bounces-833772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA0ABA3072
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0B577AC1A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EDF29A300;
	Fri, 26 Sep 2025 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="i0m3M4JP"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F422A29A9F9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876942; cv=none; b=Cdj9sgZ3j7z/PhpKNbuUAlLDTCiU98oA5OncvRboSgfNoJM2w5+rgm7CdMs+HbihT3XOu8h4mB4fCqapGTqBaBvKKqtC7rkNdK1KYdfnGnZCXRcLcrPETHgg7jjZLDOm/lSchQpjNjG0hbC8PWXN90X/93UDTbbBSYsviCm09uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876942; c=relaxed/simple;
	bh=1l4wg4jU3kF1elnwZ5gk8Fp7lyY87Xnzwuao54PZVxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZkKP6F6WNWC1d7glzE1j00npXSHbEBCHMbSDv5fw588ESzXZPtD4301mqgpRYzYShDsfmWaVAEREpCcXig2GoyQ3PMVYXefKf6+ig/m5sGkfV/vh+41eNvloIUvR2KPU0YL5TJVyTHtiCy/eOCih8J2vxsuxx4TXZxd0GBe0MgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=i0m3M4JP; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B250A3FBBF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1758876931;
	bh=tYbCmz6DRcivudFtizhBKVDUP6a4VtRsDibIRlblbac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=i0m3M4JPqJ4zZhGAHzrWfTf2qPPzzgz459hTHD2jnkHL6ypKJU7YDCbuBSuerQqYL
	 6cEkC6Gslx43LEQmoBNCSpfoE5U5ACsNZ0grplbpqKWupLr3YJgIDT7eNs/84PIVAO
	 0rXELlovXChVFvH8uu8LnsfY1ldgThtEbt7rjGAchi3kwC98UQU5veUKU+LMpHKOxr
	 MFPdS0VFNJ7oZYQVDodSR6mghQ3tUWs5ko0ZYxcR0UpA3joNx1jQbe0P5dSSRmWBoK
	 nSho6vo359rHvpePP61KwX9/l9eqFqLCXQmptBgVAfDDjnAOgr1uj+Hru8QOuugGHn
	 qxcwk5SnUswsQ==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-632d1317f48so2390079a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758876931; x=1759481731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYbCmz6DRcivudFtizhBKVDUP6a4VtRsDibIRlblbac=;
        b=jA5KIDPrmTXJkEPfpjPEC7THQAXCIkWdh0CEzanD/4ktN2KDnIFiXXvS3cb1tqlKiW
         yPbhtRYuQfR/wNFfZO/hfRo3ZlTr5yAXj1v4w3nv+mpxG6eQMY6A/Z1mCr+5NWuQh9nL
         1UzBd7xQiw3GsJAfUQjZGKR1A4AZEQ9VSR+do/bsOuclbkd8dfQ/kJC33vclewI2tJe5
         tyiEpMEFqzxriSkXhxHO6xGFU6sjuPziguXrqkg3vq6sVkgWsuOBD2mU2nvB2qIlntHe
         PzosC0lBmydwXh5E/zCGOReqO63b8zUnf4VrRPdNEdGz+PidTcvDfk6I0vWHK4QECeQY
         /LXg==
X-Forwarded-Encrypted: i=1; AJvYcCXukmp99RZze0eNuebmKipMD3byWyyQW7Qwz1thwmlZwvn8MwNH23BNqKPurOMw3s+u7zVuB6qfiGyHOB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmdPz4PU2TZC7uAvUxpmywX6w4gwBJDMndo7MHbgAEWy+MBbdn
	CCyNgnIVtadkfrDR8sqXNyiKxR4FXWlH0D8Qu6bNEZN/ZafFcH2Wf4AEgiDImSRFjLsaIHEeDQm
	uiG5x9FzOhgN96xVmSV9wbNAf+Znp2WXQaH4U4x9R1j3FL9LEHu4i3SkRaTytmdR1RzpLJYfU2n
	BPPjXI/A==
X-Gm-Gg: ASbGncukGBYSInY845KGzoJ12h2FTc12m/xebMxChgGWpoXtvTAEmEFEeWlGE2Spey+
	/YQW+kchbVWkojOFwsB74sZnLbIlR5TNZN1GPKuPNQ/p/reufKbxkjlLhpoK5XC5wCLmfsVVusC
	hrTv8qLoGQ29MuNMBcg5j/ht9zZ4wFIaKjl3HDgOhYIOikg65+4kvmJtNg3z75S6yM76/4fOLXf
	EK0lLKVrbmOK/8EOzasNngM2ba9yUeuoigx+SFTCy8VjjUCBkv4zo9Cw9UzwfzqCcBDR8MtokN5
	4nVVPk1tmh49a4QX2UVxYe02oph5hnHKfKioyNRHzdDL9wcwsj90CU58
X-Received: by 2002:a17:906:c145:b0:b34:103b:484c with SMTP id a640c23a62f3a-b34b9d64ae1mr775383066b.16.1758876931118;
        Fri, 26 Sep 2025 01:55:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJnUsWRMqCnVW0L6UsqhW6GfmZPqDaS51X9cSqZ4/iz2tBwZKu7NnpsYjonEaYorYV4TOxHg==
X-Received: by 2002:a17:906:c145:b0:b34:103b:484c with SMTP id a640c23a62f3a-b34b9d64ae1mr775379766b.16.1758876930707;
        Fri, 26 Sep 2025 01:55:30 -0700 (PDT)
Received: from localhost.localdomain ([103.155.100.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f7746sm328087966b.59.2025.09.26.01.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 01:55:30 -0700 (PDT)
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
Subject: [PATCH 1/2] drm/dp: Add drm_edp_backlight_get_level
Date: Fri, 26 Sep 2025 16:54:00 +0800
Message-ID: <20250926085401.2808634-1-aaron.ma@canonical.com>
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
 drivers/gpu/drm/display/drm_dp_helper.c | 52 +++++++++++++++++++++++++
 include/drm/display/drm_dp_helper.h     |  1 +
 2 files changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 1ecc3df7e3167..0cfb357ebd9e2 100644
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
+			DRM_DEV_ERROR(aux->drm_dev->dev,
+				      "%s: Failed to read luminance value: %d\n",
+				      aux->name, ret);
+			return 0;
+		}
+		level = (buf[2] << 16 | buf[1] << 8 | buf[0]) / 1000;
+	} else if (bl->lsb_reg_used) {
+		ret = drm_dp_dpcd_read(aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, buf, 2);
+		if (ret < 0) {
+			DRM_DEV_ERROR(aux->drm_dev->dev,
+				      "%s: Failed to read backlight level: %d\n",
+				      aux->name, ret);
+			return 0;
+		}
+		level = buf[0] << 8 | buf[1];
+	} else {
+		ret = drm_dp_dpcd_read(aux, DP_EDP_BACKLIGHT_BRIGHTNESS_MSB, buf, 1);
+		if (ret < 0) {
+			DRM_DEV_ERROR(aux->drm_dev->dev,
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


