Return-Path: <linux-kernel+bounces-737648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7C9B0AEE5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8ABD1AA4673
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00A12116E9;
	Sat, 19 Jul 2025 08:47:28 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768F11DA10B
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752914848; cv=none; b=cOt61A+gQsKqJx8XIJ+FXyxRH+BUU88NOblvbhJD0UA9z/7D/cw03Xn91Y0WCxLC+QVzyw7Kf3XRUve9t3rkg9FtKYcGdPmVSuvEc+fwPtkPWY66imk8FzJlRYnEK9rgYU/oH/YjDkU4rOA2bcXmGuKUWh+a8WAZow4Afr9eXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752914848; c=relaxed/simple;
	bh=fSD8UdFbfJi7I3FFS0YTCPp8e3TlJzx2elVhbbMePjg=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=Pa/EsuFErFM51KSiGG6lFw23HEyO7Rx/f8qEMT6i9Mcc2ASgExxAQz/9KNGpA56r9oL9eOp78v6/yT1xdHsDdY7HItoRAAALJibkVC2z0M9Ol1faz/sr+a5RT0qEROUOwmMooomhjn+JxPvV/pffCGxnTp4snHxT/XtUO8+gXpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4bkgJW2pPNz4xPST;
	Sat, 19 Jul 2025 16:47:07 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 56J8l3Vu037829;
	Sat, 19 Jul 2025 16:47:03 +0800 (+08)
	(envelope-from zhang.enpei@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 19 Jul 2025 16:47:05 +0800 (CST)
Date: Sat, 19 Jul 2025 16:47:05 +0800 (CST)
X-Zmail-TransId: 2af9687b5b89ffffffff99b-cee31
X-Mailer: Zmail v1.0
Message-ID: <20250719164705961iryN2w6eDrp8KeLJMkI6-@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <zhang.enpei@zte.com.cn>
To: <andrzej.hajda@intel.com>
Cc: <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vYnJpZGdlOiBwYW5lbDogY29udmVydCB0byB1c2UgRVJSX0NBU1QoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56J8l3Vu037829
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: zhang.enpei@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Sat, 19 Jul 2025 16:47:07 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 687B5B8B.001/4bkgJW2pPNz4xPST

From: Zhang Enpei <zhang.enpei@zte.com.cn>

Use ERR_CAST() since the macro clearly indicates that this is a pointer
to an error value and a type conversion was performed.

Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
---
 drivers/gpu/drm/bridge/panel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 184a8b7049a7..7d2d67e56cee 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -291,7 +291,7 @@ struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
        panel_bridge = devm_drm_bridge_alloc(panel->dev, struct panel_bridge, bridge,
                                             &panel_bridge_bridge_funcs);
        if (IS_ERR(panel_bridge))
-               return (void *)panel_bridge;
+               return ERR_CAST(panel_bridge);

        panel_bridge->connector_type = connector_type;
        panel_bridge->panel = panel;
-- 
2.25.1

