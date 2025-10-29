Return-Path: <linux-kernel+bounces-875421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0FDC19118
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BBA3B98D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0963191C6;
	Wed, 29 Oct 2025 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="j809uwdQ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677D31076A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725480; cv=none; b=qFpSM/1opcqhM2uc4iPysaxeuxGkUz6ck3GsTfElJ1gdM8OE1vm3jfhqfGXXWN+n+Q0Ecc/pKr2thG6rVc19AzcpEA7SY7QztP6Wg4yw1tKUzqJKRapCRHQuBP9COE8QAAuD0TXWtdDb16udlQu5xSNANa4MEjJNT+l7uW1QbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725480; c=relaxed/simple;
	bh=giZlxB/y1esW0KSceZAKpr2ebJTr4TN9pxOQBz199Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AE8xZ3DBHzVVHj+oOqbsh88uSHGYeNbhrbK2L6iusnMHgu1qOFFjdaZUGJ4qbH0mHgp8HPhbkgLIP3GBqwQOflXD6GILDj34iIfIqQDmaC7uEDpdIeT8tDApM8KQVUUeCd85aP2SyzRCX6CYI4DpRUSSpjaqWa+ib5ERimIF85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b=j809uwdQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290dc630a07so50080315ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1761725478; x=1762330278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy9XTv2i4jQBLP7k+Sr4EyrGNjL9Wpf6xvz0spYyufM=;
        b=j809uwdQGy1tW+FjAk8rTUo5OEWdkBcxA74XWoMc7p6ewaMVUYf7SmupXpTV3/7111
         zvXU+ZvAkpVHUUmYPvI8krdDYD0FtizABxhLNTJtQxJbaetNBeCquKhYzl4sVLyZti1W
         Loau9uQoCgmacZpo6bzro4AIrvAwGxa0FFxFcEXbtqHq9CDguuQ1aWMamZedxAX0Tl1u
         4z+WQAz0KDrqu+V8BvPklsReKHGoApONjki0RNnViegcN4kAkQ9ONBzh/K8YTX5sIXt4
         ekU03BToCcYQsuEjSZ3to9NSlnwpD9RoH+CYt0rqy6BqvrpBZvygIHiwBDVCLP8OH9T1
         U1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725478; x=1762330278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cy9XTv2i4jQBLP7k+Sr4EyrGNjL9Wpf6xvz0spYyufM=;
        b=b8Xazn33ct5wV7oNj/NLe2OSozYqMIObGLP68REavy61N23N2Jaywr5SiCCCO5vkT5
         OK6ipEZnDi/jLCckGGkp65m4pHFIqHSGSfHhf0R2OE8LDp99V4Pyh/4/gQKFw4ggWm6w
         TOSPE6Z2tV+As6uLGbyatO4F56Tu+GvkN5VxVzdYY6tFMo6R6ISHZUWwhls9Q0y7QTbe
         o38b1AHKRMomnfenIFliV1yP0M1GiaU4YUbKeWaLVYLAvw0HZwLdIIp1x6/OWdlsO4Zx
         aZbVriF7o5077ap15EBWTTHIuvi6SyMYJsB1RhYZf7JmPGEDN8UxigXsaojQTNIKKIAp
         svww==
X-Gm-Message-State: AOJu0YzKOtMrXoXlCI5KvDkRIQMhoK9ALeOFCpL9UxnhNaxovYmgWLkj
	2SErKWWcF2R9IQ4okWnkKSr9IcU+4+I5RCAO3ME1sTtMi5cybCKCuvjyuWBT+LRo+qVzgmXE/We
	DKq5PD5rl6w==
X-Gm-Gg: ASbGncu/VoNRLPxlANrQIXqqDnMFjMU4AinWmR9QmTdw+sNWxYopz8NWsVkkOJnTv7M
	WZit+ZXJPofrjVK26mkHRHRiDItq/DrVB9ooii4g5vz/y4JTi2hBkIiOSKo88iSPCgktSSN/CRQ
	3WcotvHAu/Xj6fxAnmTLK+zFAhrCfxJHpvAVSPrAwiN9rVA2Dd4bEqJqXBDUFVMS/EFsSo2R71M
	GFfA0/csekWCv5y0l2ulka6KXPK49xclQ8vIMJaQnc8W3vjuXpIWpK6kbEVXiuwZ0LNKkjdl/JF
	J0v9BIpmJw6onc7TN18qI7ubupoEfI7/Ru89fqktOnM0YgbNijCvIxrgipLaWbDesERTLpFBaKl
	J2tB+SHH5e61zL61iLtLUhSHjbtN6rd5/sLe7NrywWfJe8uHedm9kS5K+gj2Mz1SAePN518yB/P
	dmSaVt7T75Lv9EIuCC4qQSZEr1hnZa8PyM5Vurw7yHyqUTS2ked5GN6VGUjVUdmnu9Nu3Ec4bW+
	GI/g/QDMOwPGSDNboJmacEq
X-Google-Smtp-Source: AGHT+IE47ekKNBF9kXK/AfwFXT2q/NNP+Zhgqx+yPTGDTly8eePWmvpucVyygnjntJlajk3c9jzzuA==
X-Received: by 2002:a17:902:ea0d:b0:254:70cb:5b36 with SMTP id d9443c01a7336-294dedd0e80mr20877055ad.8.1761725478290;
        Wed, 29 Oct 2025 01:11:18 -0700 (PDT)
Received: from ajye-OMEN-by-HP-Laptop-S.compal.com (61-219-175-100.hinet-ip.hinet.net. [61.219.175.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d23226sm143988155ad.49.2025.10.29.01.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:11:17 -0700 (PDT)
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
	jazhan@google.com
Subject: [PATCH v1 1/2] drm/panel-edp: Add override bpc quirk for generic edp
Date: Wed, 29 Oct 2025 16:10:47 +0800
Message-Id: <20251029081048.162374-2-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251029081048.162374-1-ajye_huang@compal.corp-partner.google.com>
References: <20251029081048.162374-1-ajye_huang@compal.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding override bpc to EDP_PANEL_ENTRY3 quirk.

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 944c7c70de55..da3e8f223ec3 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -218,6 +218,9 @@ struct edp_panel_entry {
 
 	/** @override_edid_mode: Override the mode obtained by edid. */
 	const struct drm_display_mode *override_edid_mode;
+
+	/** @override_bpc: Override the Bits per color obtained by edid. */
+	unsigned int override_bpc;
 };
 
 struct panel_edp {
@@ -586,6 +589,9 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 	bool has_override_edid_mode = p->detected_panel &&
 				      p->detected_panel != ERR_PTR(-EINVAL) &&
 				      p->detected_panel->override_edid_mode;
+	bool has_override_bpc = p->detected_panel &&
+				      p->detected_panel != ERR_PTR(-EINVAL) &&
+				      p->detected_panel->override_bpc;
 
 	/* probe EDID if a DDC bus is available */
 	if (p->ddc) {
@@ -611,6 +617,9 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 			} else {
 				num += drm_edid_connector_add_modes(connector);
 			}
+
+			if (has_override_bpc)
+				connector->display_info.bpc = p->detected_panel->override_bpc;
 		}
 
 		pm_runtime_mark_last_busy(panel->dev);
@@ -1871,6 +1880,17 @@ static const struct panel_delay delay_80_500_e50_d50 = {
 	.override_edid_mode = _mode \
 }
 
+#define EDP_PANEL_ENTRY3(vend_chr_0, vend_chr_1, vend_chr_2, product_id, _delay, _name, _bpc) \
+{ \
+	.ident = { \
+		.name = _name, \
+		.panel_id = drm_edid_encode_panel_id(vend_chr_0, vend_chr_1, vend_chr_2, \
+						     product_id), \
+	}, \
+	.delay = _delay, \
+	.override_bpc = _bpc \
+}
+
 /*
  * This table is used to figure out power sequencing delays for panels that
  * are detected by EDID. Entries here may point to entries in the
-- 
2.25.1


