Return-Path: <linux-kernel+bounces-864579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F4BFB19E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAC51A04897
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96093126DA;
	Wed, 22 Oct 2025 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zeiEdimg"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8C22F90DE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124470; cv=none; b=GYpkN9brv7rwcgsjJlqrTucW2Clxd2VV+/7yYp21dDifnuryKo8AVyHKaGPyaEVvDtwYOky4DIv1w7ITOUAwRJ0zKRwbA4IjQWp/FQdgBRIRHh+hfmDadKXCLsQo95KNaCw8rzuPXBhQUsnc+jhWpfX26aPDE0wafckNjfL8tXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124470; c=relaxed/simple;
	bh=5jHDW6zklN2Co7QB/SGhS3I/3RAAtsMtKENU/P5+vsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKjmUbHqNMHlMEWXN9/WHp1nn3aGfQCfFVxXTm5e1BkRQuG0a5BdfmjtPPP/cgMXY3S20P6uD7/mVkfxMeC4jTpUECqV+U5xXXJ7MY/+nXitfD0JU6eXJEyiZVt6An3nCR6bPkAxumzDWuBr8/xY/wdX/L6iIr4kyQsHD8UVNAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zeiEdimg; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761124468; x=1792660468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5jHDW6zklN2Co7QB/SGhS3I/3RAAtsMtKENU/P5+vsE=;
  b=zeiEdimgGMyx1LMXFEaFNqqoCCTAmzE+ifMPTPdCgqI3L0H8LVsn8agD
   dvpC6eFBB0/Qu0s/tTSyaPhyziuqI4ZYW4HXuwS+DtXAdt9fdsDk/1k00
   /x4N2TbvH8dWae7zfqwlTCKfmjLmL2Xf7MRazIBTlz1MPkSnlNUx4ebkn
   i6IFCvoEvBzo/kXZbBKXDg2WL/i+DfZ9/O57cWVukxED/CWpOyMURl2h9
   cHAGYxL//j4TKzItdU1vc5IfWdn6PKSwv4k/ThtBQFIMU87IcOE5X0iO7
   /D3tAgCNV/OSrLazaHt/JppHTQxUXYlxoZFF9y9nGJnkz+DSXl7tHA6Ih
   Q==;
X-CSE-ConnectionGUID: xz18o7SaSPijanOUbqr0Yg==
X-CSE-MsgGUID: dwjrBljoQ4WO9owt2kacRg==
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="48611258"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 02:14:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Oct 2025 02:13:58 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Oct 2025 02:13:53 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>, <dharma.b@microchip.com>
Subject: [PATCH v2 RESEND 1/3] drm: atmel-hlcdc: add support for LVDS encoder type
Date: Wed, 22 Oct 2025 14:43:49 +0530
Message-ID: <20251022091351.472331-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251022091351.472331-1-manikandan.m@microchip.com>
References: <20251022091351.472331-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Dharma Balasubiramani <dharma.b@microchip.com>

Add support for encoder type "DRM_MODE_ENCODER_LVDS" with the following
bus formats:
	- RGB888_1X7X4_SPWG
	- RGB888_1X7X4_JEIDA
	- RGB666_1X7X3_SPWG
	- RGB666_1X18

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
[manikandan.m@microchip.com: move modifications inside the
atmel_xlcdc_connector_output_lvds fn]
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index e0efc7309b1b..beb825fc4d5d 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -357,6 +357,42 @@ static int atmel_xlcdc_connector_output_dsi(struct drm_encoder *encoder,
 	return supported_fmts;
 }
 
+static int atmel_xlcdc_connector_output_lvds(struct drm_encoder *encoder,
+					     struct drm_display_info *info)
+{
+	int j;
+	unsigned int supported_fmts = 0;
+
+	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
+	case 0:
+		break;
+	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		return ATMEL_HLCDC_RGB666_OUTPUT;
+	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
+	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
+		return ATMEL_HLCDC_RGB888_OUTPUT;
+	default:
+		return -EINVAL;
+	}
+
+	for (j = 0; j < info->num_bus_formats; j++) {
+		switch (info->bus_formats[j]) {
+		case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
+		case MEDIA_BUS_FMT_RGB666_1X18:
+			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
+		case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
+			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
+			break;
+		default:
+			break;
+		}
+	}
+	return supported_fmts;
+}
+
 static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 {
 	struct drm_connector *connector = state->connector;
@@ -375,6 +411,8 @@ static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 	 */
 	if (encoder->encoder_type == DRM_MODE_ENCODER_DSI)
 		return atmel_xlcdc_connector_output_dsi(encoder, info);
+	else if (encoder->encoder_type == DRM_MODE_ENCODER_LVDS)
+		return atmel_xlcdc_connector_output_lvds(encoder, info);
 
 	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
 	case 0:
-- 
2.25.1


