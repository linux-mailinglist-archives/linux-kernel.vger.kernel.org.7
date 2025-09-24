Return-Path: <linux-kernel+bounces-831295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D94BB9C4C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7BE1BC17FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65043263C8A;
	Wed, 24 Sep 2025 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLXR2/5t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B604C85
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758750407; cv=none; b=tDgyRD5Iu4D4XgZ/Z1RMPWI3QWtWDwOp9s52BTekG9hqkgVEeaROrtpfLZPEXg8R9H+kHJyms1C/Ltdqcd9c9C8QgzVRJypzKGxKQRbKwKdEaEK/LmQ9xHz1JnxkldVqXUUW7tfwi5fNYnhbmrUnn5r2MWVxmht05v1ASjpkBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758750407; c=relaxed/simple;
	bh=ckaSwtRPrj356IriTKLthYSjTY99oe1PgyqUXN6/eDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FwYnElGtRAWHJmIDx8kVXqWAkEIEuKtyXg5FhwubzlUYEXveeY74jrGWKTGndkQIzqOUqAjZpBto6Ji0/IlMPXPMVO8X2iiQb3mocaBHuYf0nsFmRFQOZBTKP0H5OGd03DBL8pENkCG0yNLYSOSx3uwC3STgrhQ5Z5IixU8REuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLXR2/5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC06C4CEE7;
	Wed, 24 Sep 2025 21:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758750407;
	bh=ckaSwtRPrj356IriTKLthYSjTY99oe1PgyqUXN6/eDg=;
	h=From:Date:Subject:To:Cc:From;
	b=sLXR2/5tlBDoAo+MWC8BCrzcXg4Lodf+O2znxlGGPUCxbmfnu+caHSthpgXZ/h8JS
	 fenKE2u2/2HaxNpsrsVmR5RPPsL0KWt1shLEG+W00qUxCvHb8qqwF9XUVxRvzH2EI6
	 2mSXHfh30GudnUyf0hnxzuzPG/nwyAmGOLNXjxButbaHkCdgyC71LLeqDYz33Fcfjm
	 NRXmxTpurJR7xHuIaDNQ9nYoCTiU6u9qnD1jLgLynfXcQSxwhmDqBJFwKH42kZttAf
	 6s6LXllje2kiOdEMNwanpnfLpPR3MjwD+8x7uZ0Boma9iOL7garIIOg8oMpfIo9Juu
	 VBYaXc/qoIuuw==
Received: by venus (Postfix, from userid 1000)
	id CB1CF1805CC; Wed, 24 Sep 2025 23:46:43 +0200 (CEST)
From: Sebastian Reichel <sre@kernel.org>
Date: Wed, 24 Sep 2025 23:46:30 +0200
Subject: [PATCH] drm/panel: sitronix-st7789v: fix sync flags for
 t28cp45tn89
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-t28cp45tn89-fix-v1-1-8e8f52239c84@collabora.com>
X-B4-Tracking: v=1; b=H4sIALVm1GgC/x2MQQqAIBAAvyJ7TthMQftKdJDaai8mKhGIf086z
 sBMhUyJKcMsKiR6OPMdOoyDgO3y4STJe2dQqAw6pWVRdovalGCdPPiV6KbRIBJZ66FXMVHX/3F
 ZW/sAG5u1iGEAAAA=
X-Change-ID: 20250924-t28cp45tn89-fix-0931500ee88a
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michael Riesch <michael.riesch@collabora.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=yo39CeDpYS10BZLVJfancD+PhiXUMdjyCeXd2WEPXNk=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBo1GbDqfNn0D/c1bP94UcM7RFr8hOS6xS7sItSO
 EM3oYksaPuJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaNRmwwAKCRDY7tfzyDv6
 mgSVD/9qInDMt1F7V7n52ZgLdiBx1TxisznnPNS/i7G5Qg4z1XLr2ecdzH+KWfuEK7GjO624Xes
 l5hHtt2upTpCIZ2qnWmLYeO6rbepRsyywAgUpqGlJfhcsMD161sNQwKY4r3/V7usUNSLpX94Xng
 i8fk8k2mFYD7hOti8YyFu4RfjlfzQuIFt3fH7r9gt6ykNtRsjMNzfHFu4oFq3irIyZv3ZtBHOcU
 2nafyWbfo4NDBtDBvUltguT/Kt7ROPxeMt40BFRD73NVx4GsAo5SqSRGTwcbHYXEbpL87CuCV18
 MxhWmSjwkp/x0vfQup/HgP4L4QMaRHEF2hGb+X+XqLF1laSvCw45Pm7YUIAQ/0ksxZ2uwLEWkgr
 FkGe2VGe/23zSeDDhaJScs/B2W4J2/A0Zm/bR73+1M0VdIWd7h0flEtsK++xZiX1MhVSRk2oZto
 UthmhA1VcT5LtHz9eoVSZbchh6hN5JhKIIg1iPzUSoIDp3iYW7jhYM/mQRmLYxCyxMwmJYyCUil
 3lIcJlzHO9h8VRyHfBGY0Qr2eU7OhPb+otCx7EE7x+ZFz47RrzkzO9aBg9mBn4pZF3LX9r9rksJ
 pzuiUmaGQwBw6uEvRXqo1e2UBbBZ7e4DJG45pI48SbweJ/g/2YPQyyWwjkJxNlW8woesnGzMut/
 +omS/45E8XIevLA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Sebastian Reichel <sebastian.reichel@collabora.com>

I planned to set the polarity of horizontal and vertical sync, but
accidentally described vertical sync twice with different polarity
instead.

Note, that there is no functional change, because the driver only
makes use of DRM_MODE_FLAG_P[HV]SYNC to divert from the default
active-low polarity.

Reported-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Closes: https://lore.kernel.org/all/20250923132616.GH20765@pendragon.ideasonboard.com/
Fixes: a411558cc143 ("drm/panel: sitronix-st7789v: add Inanbo T28CP45TN89 support")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 04d91929eedda092b966b8cffdef5b267748f190..dedf0a390a88dd45a8179e2d22e872128c87cfda 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -261,7 +261,7 @@ static const struct drm_display_mode t28cp45tn89_mode = {
 	.vtotal = 320 + 8 + 4 + 4,
 	.width_mm = 43,
 	.height_mm = 57,
-	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC,
 };
 
 static const struct drm_display_mode et028013dma_mode = {

---
base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
change-id: 20250924-t28cp45tn89-fix-0931500ee88a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


