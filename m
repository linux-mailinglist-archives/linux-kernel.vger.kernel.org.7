Return-Path: <linux-kernel+bounces-764269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501DBB220BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6779425F68
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B92E1C6F;
	Tue, 12 Aug 2025 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AyTLzdSo"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DC62E1C4C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986991; cv=none; b=GL50+Y2DdXjZGBaUZJLOzjvNMzYZF8SvgcmUAZszsgxsBmFqTaYL2RSGsCqxCvP0PDl9HU9v7Mig/aZOgj+HyShqIyi7jvOJgEo8ZVMHQLgPoiDBV4gZTPk21S44fH1Tpe/y8w7jYr+9g5eEXNyGHKovHjgGP+KrSEWQBSnTEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986991; c=relaxed/simple;
	bh=R0H6qbgi75sw1XiCR3olrxWKeQfidkeqX7+9hw2r1YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iaks1lzqDxdGAU9wQlUOC03P5tOHjC+U+9ulQWiCJTU6uAwX/J7HMrYKVZMylMQ1V/GyB41UqZyNIzBFpLJU9MmxSQ3o8JBN4qyUtP/XswPlON3ckSYpKNjsR3jDUdfUcBpAYE6ceb+YUIzkSQtwVc7BDlT0hzyUfsldKb3fwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AyTLzdSo; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bc55f6612so4687135b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754986989; x=1755591789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+ApBBIww/CD03e0b3YPmz5HPcIxQrsuvUlv8WI11Ow=;
        b=AyTLzdSoHmqBaDN+7Zfkzz7PZqxwS/fKRTWI48YG2UPyN7IbphEdaXngVvjS4r4NB6
         TJMH9qX8zrm17g23FCEZ5r25+WEHbPra64GIYAwhlyJ6rgHFPxvGbWTCYQSzs/yUvHpb
         S1Z+UJr+4ZidVVZoybVKC+rJbJoDwScgeOh7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754986989; x=1755591789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+ApBBIww/CD03e0b3YPmz5HPcIxQrsuvUlv8WI11Ow=;
        b=QRCeScjbL35bct7cEWKn14MBOFgOfXcrJuztaXf6XY+tquvBRpBwAht2SbHse4A4oQ
         JOR3BEEHytv7lu7wLvs/XxVu0BE8NfQ/eGmUkMUwG6vcgsRF4oyoBoX4saC/VcLD3Fuz
         +MPKemxQSnTMS9EaCxG1c7y4rBLdWRWCMWSbkPt7XPb0wW3G48Tnk4khS92nxmlF1WO2
         u5CauDIsE7nr2v89Ri6fv4NH41M4qHGjWm6noyG2mv8V0oiLeIM5VDs6qa8ApIHLl9CY
         BP6vo1N2cK/oer9vWelyhu4tip1FVaKliAMCFcnsKhAgcEsd/UG6mowDqP+NcvmsqMWl
         BUZw==
X-Forwarded-Encrypted: i=1; AJvYcCURStk8Zu+QHBCTSnKZNhhk6dObyGMPEzLVFJNl+NaUTOI/DdfHPfCcL4l5r5YKp018WH+LJSyrzB0eUNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3rNIh7bsevNIG5hOALic/eNbciA8wIimJ80SQHW1uQXKfWH0p
	oSy3oMrZ45Nz0555Bgzo5NmmOJRtmYUE9ekDKF6NqhcHJM+mPRTddj7dYy5CQBtWSg==
X-Gm-Gg: ASbGncvKc3D1wMs2wBtfADTdsxclXvDuKTYgqODvO4uRAQZcKHylpV/bQTPHbrFZdVW
	6W5OpPSjt3B1hVn2ygiVhjRB6qlZw2kR2Dxxaq+Y6s8FUl4tiWVnUdukkpBT4B/70IODstlN0Jh
	CtUDMLjucDsVru3QB2exrrv3R0dKT17RU0L78Z2TAjRAmM5mtApSoxjcFq0zoESRnpyA6GyB7CQ
	7zWVUSfNF8MrnRLI9zsR429fcz9ITx2lOuQwI/8j+7QIUT4b49DzjjKnQ4Vr+hF4QtvaW5NIzQ+
	gw/jnVzgXiurTLbVg7iubDasf0U2wzVbKHj8k+afY01GlWcvHAGo1RsQW4BkVal4fh/JbaKpqec
	gJ6f+tQ/01uKDGCbpkL7TyFBtpfy2TArZOC+9IEBU
X-Google-Smtp-Source: AGHT+IFBxmWzFIiHhb5XfrGSojOd5d60/WZ6emuFjM8ECLdSIxa2VC0bJOfLpoOVpWHpRQX+LCpt0A==
X-Received: by 2002:aa7:9888:0:b0:76b:fdac:d884 with SMTP id d2e1a72fcca58-76e0de69077mr2857234b3a.3.1754986988784;
        Tue, 12 Aug 2025 01:23:08 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:8e8:f5ef:865c:a4fa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf77210aesm22722064b3a.113.2025.08.12.01.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:23:08 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Hubert Mazur <hmazur@google.com>,
	Sean Paul <seanpaul@chromium.org>,
	Fei Shao <fshao@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/2] drm_bridge: register content protect property
Date: Tue, 12 Aug 2025 16:17:58 +0800
Message-ID: <20250812082135.3351172-2-fshao@chromium.org>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
In-Reply-To: <20250812082135.3351172-1-fshao@chromium.org>
References: <20250812082135.3351172-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hsin-Yi Wang <hsinyi@chromium.org>

Some bridges can update HDCP status based on userspace requests if they
support HDCP.

The HDCP property is created after connector initialization and before
registration, just like other connector properties.

Add the content protection property to the connector if a bridge
supports HDCP.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
---

Changes in v8:
- rebase on top of next-20250731

 drivers/gpu/drm/display/drm_bridge_connector.c | 9 +++++++++
 include/drm/drm_bridge.h                       | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 5eb7e9bfe361..20376d9616ec 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -20,6 +20,7 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/display/drm_hdcp_helper.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
 #include <drm/display/drm_hdmi_cec_helper.h>
 #include <drm/display/drm_hdmi_helper.h>
@@ -641,6 +642,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	struct drm_bridge *bridge, *panel_bridge = NULL;
 	unsigned int supported_formats = BIT(HDMI_COLORSPACE_RGB);
 	unsigned int max_bpc = 8;
+	bool support_hdcp = false;
 	int connector_type;
 	int ret;
 
@@ -763,6 +765,9 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 
 		if (drm_bridge_is_panel(bridge))
 			panel_bridge = bridge;
+
+		if (bridge->support_hdcp)
+			support_hdcp = true;
 	}
 
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
@@ -845,6 +850,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (panel_bridge)
 		drm_panel_bridge_set_orientation(connector, panel_bridge);
 
+	if (support_hdcp && IS_REACHABLE(CONFIG_DRM_DISPLAY_HELPER) &&
+	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
+		drm_connector_attach_content_protection_property(connector, true);
+
 	return connector;
 }
 EXPORT_SYMBOL_GPL(drm_bridge_connector_init);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 8ed80cad77ec..c0c02d65a3fb 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1122,6 +1122,10 @@ struct drm_bridge {
 	 * before the peripheral.
 	 */
 	bool pre_enable_prev_first;
+	/**
+	 * @support_hdcp: Indicate that the bridge supports HDCP.
+	 */
+	bool support_hdcp;
 	/**
 	 * @ddc: Associated I2C adapter for DDC access, if any.
 	 */
-- 
2.51.0.rc0.205.g4a044479a3-goog


