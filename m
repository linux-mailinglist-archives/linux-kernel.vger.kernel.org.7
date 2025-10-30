Return-Path: <linux-kernel+bounces-877934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B1EC1F61D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374B53B5CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A53434A78D;
	Thu, 30 Oct 2025 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ir2sQdUt"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBEC34AB12
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817707; cv=none; b=ZSh0QPo8OWol12hKTtf3venJ9HH//pL6xxwmPCmEdNpG/fU2qtoFlqSYLczSw0J4aTwu1AeeAURjQ2Ph7ujNDrDekqycMidXDUmK5wuN6HutzlapUe9QQAFYJuaQHXg0mKrcor3Blf6h8+RB1CWeBPcs5tDX3n958115UgDH/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817707; c=relaxed/simple;
	bh=KP73zFD6pa/mluZfc859H7jK4Ws+qxK7Dj/8pvou9gw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L/Sl9pE7PRWOUPwyxzya2XHazUcYwcHhpMjatryNcKjddeFNBscEl9dcGZe7BJus8+VDIKCMaixIhcr3K99da3Ov5u+A3djnT4r7tMUV03UC/pte3lVIvcqXQNBGtyYjZ60ZYjqItOXtavp1I5IMVDT3CYuKmkxK645B7V2qBHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ir2sQdUt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761817704; x=1793353704;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KP73zFD6pa/mluZfc859H7jK4Ws+qxK7Dj/8pvou9gw=;
  b=Ir2sQdUtBToYxw2iute9ix+PZ7jyS1IWKEWqtYcsw1dyU/ZKH4N2vLVW
   vgeKyD/SZobw5Tq/VX1F4Ehux1v8b0NIaQQ8upqbmKGkHrJWC+JLL6YYM
   Ssn25VrObRV2g5WJ+7rsY1b2S5yYbavAqVlkyy+7A8O/m+yysCxY/lyHQ
   yvFuOFanWO9FMfw6ZZ48rV81LlASa4AO5KZhVwAd6nqKD+Miltwpsu+7p
   yYrL1r+hiCPy7U9ep6h+xNAbFktLzrgfYEm4PqWwTMM5af9ZlhOce2Xcg
   78lgPMjGslZ+dUFSNsEPlDo7qErfGlP7BsK3CboqD0S1Mo0a1hAGuNYGe
   A==;
X-CSE-ConnectionGUID: +oGn3tQCSDqOtrmjZQp9tw==
X-CSE-MsgGUID: NGkMgGyoT6eTZCJEzPprTg==
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="279833920"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2025 02:48:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 30 Oct 2025 02:47:52 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 30 Oct 2025 02:47:47 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <megi@xff.cz>, <javierm@redhat.com>, <neil.armstrong@linaro.org>,
	<jesszhan0024@gmail.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH] drm/panel: himax-hx8394: Populate connector bus formats
Date: Thu, 30 Oct 2025 15:17:42 +0530
Message-ID: <20251030094742.1081960-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a call to drm_display_info_set_bus_formats() in hx8394_get_modes()
to populate the connector's bus_formats field with the panel's bus
format.This ensures display bus format information is available to other
components that may need it later such as to identify and match the input
bus format correctly based on the panel description.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/panel/panel-himax-hx8394.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index c4d3e09a228d..cdd72235fde6 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -725,6 +725,8 @@ static int hx8394_get_modes(struct drm_panel *panel,
 	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
 	connector->display_info.width_mm = mode->width_mm;
 	connector->display_info.height_mm = mode->height_mm;
+	drm_display_info_set_bus_formats(&connector->display_info,
+					 &ctx->desc->format, 1);
 	drm_mode_probed_add(connector, mode);
 
 	return 1;

base-commit: bdaf9fa04946b9d1086d69b7269c113ace8e9f76
-- 
2.25.1


