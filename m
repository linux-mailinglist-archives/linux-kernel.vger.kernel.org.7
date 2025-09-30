Return-Path: <linux-kernel+bounces-838262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E97BAED49
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDCA1943E71
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484F2D373E;
	Tue, 30 Sep 2025 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BO8zcD6+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B976D2D24B8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276789; cv=none; b=FYAFfVgPgAcSVHbAkaBwIeZH6cd2rwki8rf4g9VWJ0+jdR/pYuyuisUi/k9hv/gooCSngkhuB9PKcu+oOzPpqx3mSxxXn8De5ZLRcuxz7L4g2JevrLt8ozqi+UiJOg5OdVi52au3OuDsvbmntEj3Mm0Yan7A2KdcVGcMMD2iqWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276789; c=relaxed/simple;
	bh=9+ypJPfJFq86tYWdYX0GSRCWy6EW1SG5gKgpNCtWVKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pJzBbCx+HmBr1zPFRXkkrp5K+7Xk2maVknTvPCxXXfDYUl7KviT3fs0sUQmWf5uyTRs54IeId3yNEIRJMObDz6Jcg2W5LA7FfR/GwzCmj5z1g3af7G3SLMXws37OTDP9Tz5oP2yWd+qmVYbyHZ1HS7gZioVTpW3QNnJ+3WRgPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO8zcD6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250F3C4CEF0;
	Tue, 30 Sep 2025 23:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276789;
	bh=9+ypJPfJFq86tYWdYX0GSRCWy6EW1SG5gKgpNCtWVKg=;
	h=From:Date:Subject:To:Cc:From;
	b=BO8zcD6+951UBkvCFIr0AzZHpjHIChoIGsdWt0WEErSoukWLN1gmNDUMFzfQ4lwgL
	 +LJe5IMTNnpQNi43tTHc5/g2oJhiAe5Loc6juwBT+bOOfS/8iQgsEcq2yd2uRdCFup
	 ES2s5xPvd+CBTtU8On9pjGXHobn48v2LCT2001BJk3Idcbf928hWDDuIMpYBoPHncu
	 gIIhVf75ZTQRu68o1TqEh1Pc7KsBjLB7TA1TKaumMTfdoyFJXeNCkYXfupGhfBE8Pc
	 YW4nHVwSb1cMiYtTnx75cH+ulEHKStMiKTYPoI6dJ7+DZ77/b0Tg45KmC98EweBr8w
	 WRjflLMZsnbXQ==
Received: by venus (Postfix, from userid 1000)
	id 23F52180734; Wed, 01 Oct 2025 01:59:45 +0200 (CEST)
From: Sebastian Reichel <sre@kernel.org>
Date: Wed, 01 Oct 2025 01:59:42 +0200
Subject: [PATCH v2] drm/panel: sitronix-st7789v: fix sync flags for
 t28cp45tn89
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-t28cp45tn89-fix-v2-1-67fe8e3046ca@collabora.com>
X-B4-Tracking: v=1; b=H4sIAO1u3GgC/3WNQQ7CIBBFr9LMWgxMIRlceQ/TBeLUklRogDSap
 ncXu3f5XvLf36BwDlzg0m2QeQ0lpNgATx34ycUni/BoDCjRSItaVCS/aFMjWTGGt5C2V0ZKZiI
 HbbVkbvoo3obGUyg15c9xsKqf/d9alVCCmEaD2FtP+urTPLt7yu7s0wuGfd+/mMUvDLIAAAA=
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
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2344;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=nWmSmVpgqf7NoNa9pIPbQK1R30xznDAzAmwY8655seU=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBo3G7wJyaqavCnMROe12KZrIsvsY//6Qi0Tvyzo
 aZPD64uIg6JAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaNxu8AAKCRDY7tfzyDv6
 mqrMD/sFVbzsUjw9hKacyX+Xu6l8webQ1M7j840zDT5eghtCoueScWxNwNgCekU+llKSE9KmjkX
 2wOjdAD1QBqoZN516bxAeXR/kcaAN8ELyFYtd6h8QONSKH1pAImWuN/DLM5hErQaXoNNkbM/OdH
 wcgXBrZKpglQTgNHA8WD1w7QRWHmHtoY7IXxq0TbVdtz0bgRU14fIs2ShEZkPQcilfTt0a3qfzu
 Jg9Kp1HSZtcNHgPzXv19BE+2dZ8AiJ0pdV+11vP3Yya4cg2KJ6XUSUvM2CSf6MFT6v0JHBC1Vqh
 AkCvymYRvE5Zhtt/FGp397U+UHxOeo8a7mzmkIg4iL/fTS5OsCj4TwUoz6RIx3pxB6iqTlfqkRL
 8OaU0/C7AJMqUu8yiTDqkg+VDY8+6SKQsxBPn2UTmntXYXwD+M+3k7B/hSJ4E+p/eL8ZYgMjmqS
 PqndKQY411HIc1ypK/xSKf6hAkjqa2OeoLTiDZgZghtevcLOLcxqj7R9VYHgmGgkehCJTVtJLGT
 jvIuJMNirfwYT09xRCl8q+5abIh4MxGYMed3EOkjEtUL+aaH618iPISTHsP7lSV3ulxx/d3cXuA
 7+ufy6OqkBRZ5grwwonaBzD1IHL0UkZJkfGPkc4UHFPEliJLFxqGu2e+YZUVgottI1KtfHHGm4k
 oBW9oGDLHdFTpcQ==
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
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Changes in v2:
- Link to v1: https://lore.kernel.org/r/20250924-t28cp45tn89-fix-v1-1-8e8f52239c84@collabora.com
- Add comment requested by Marek
- Collect Reviewed-by tags
---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 04d91929eedda092b966b8cffdef5b267748f190..d5f821d6b23cb19dc01312e4eb3ed3fcfb254d42 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -249,6 +249,11 @@ static const struct drm_display_mode default_mode = {
 	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
 };
 
+/*
+ * The mode data for this panel has been reverse engineered without access
+ * to the panel datasheet / manual. Using DRM_MODE_FLAG_PHSYNC like all
+ * other panels results in garbage data on the display.
+ */
 static const struct drm_display_mode t28cp45tn89_mode = {
 	.clock = 6008,
 	.hdisplay = 240,
@@ -261,7 +266,7 @@ static const struct drm_display_mode t28cp45tn89_mode = {
 	.vtotal = 320 + 8 + 4 + 4,
 	.width_mm = 43,
 	.height_mm = 57,
-	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC,
 };
 
 static const struct drm_display_mode et028013dma_mode = {

---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20250924-t28cp45tn89-fix-0931500ee88a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


