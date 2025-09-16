Return-Path: <linux-kernel+bounces-819421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2CAB5A074
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969461BC4B16
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C890296BC5;
	Tue, 16 Sep 2025 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlSk+9IX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77C2245014
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047101; cv=none; b=AvgJdy4cEH8GMC5NstmfMuuow1sRgBD9oLrj8ZDYtXFI0YpA1LNSpuHCKQzNS5jnubpuo1wLzc8HfcZigUMNOkfArqjfr09v63t8Sxn43c00TARq3NXnEpstUDxqU4YL4TeFF7g1OMMKWxZ+cGI73h9KzTlLnPXXjOLbeuFVh88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047101; c=relaxed/simple;
	bh=MvQcMuTYxHc+p8u5OTj984dWRFYYNw2gvLQD2QLh3po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ysk3FBO8MKfPveYoOAsHtaZEykN7XmB6B0U0GYByk1cwihhjebjIkhE5kg8NcQtZYf/8wqm5x4ao+oYZ1jCZMPaT++c0g2uAHVDq+Weaq30zYQDygh3u47H5MM33q1qyz+UUx8efP2EbnNOkpapsBVXFQYaOi1WZYWu4M8jCj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlSk+9IX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64716C4CEEB;
	Tue, 16 Sep 2025 18:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758047100;
	bh=MvQcMuTYxHc+p8u5OTj984dWRFYYNw2gvLQD2QLh3po=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=SlSk+9IX3gbaVEXU/2mqoXkUo6mf5cTUH4qw3gF/ndBVeBiZvIClsToZgFOGhAe6h
	 DcuWSBs6rooUSYsIvaml2BYkBdvWbxkatVkOjtCyyDkt8OZLV6iTD9lUufb6heAwO+
	 kA7dEeH13L7jDiP4x5bUwoOEfjIbM4Mek34Qn+Gr/YpqUD6y6b7TcPh0Yj3cJTCmGH
	 /2lOpHUDYOOL1n8bqZlZAmgj5ko7rQst5dSAznkwU2oHFKVfqiBQniJnr0z2SL6FbK
	 0WO6JnmEEVa/1o4OG2F5UFdqYU7MZycbXGQMWrzr5aFNVc5WPpOM/3PWJwLG10dTxa
	 vmJUYZzCve0mg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED5CCAC59B;
	Tue, 16 Sep 2025 18:25:00 +0000 (UTC)
From: Brett Mastbergen via B4 Relay <devnull+brett.mastbergen.gmail.com@kernel.org>
Date: Tue, 16 Sep 2025 14:24:54 -0400
Subject: [PATCH] drm: panel-orientation-quirks: Add quirk for Chuwi
 MiniBook X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-chuwi-panel-quirk-v1-1-ec5c6aa5a663@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHWryWgC/2XNQQqDMBCF4avIrDugQUV7FekiiRMzKKlOsBXEu
 xvduvzhfbwdIglThHe2g9CPI39DiuKVgfU6DITcpwaVqypvixqtX/+Msw404bKyjOjKxpWqqVp
 je0jO6EhoRAfrL/kA12YWcrzdv93nOE4znA24hwAAAA==
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Brett Mastbergen <brett.mastbergen@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758047099; l=1282;
 i=brett.mastbergen@gmail.com; s=20250916; h=from:subject:message-id;
 bh=hjeEkEZrq81jIeV1Zh4tI40Z7QvRSV1nwJznGMlUFzg=;
 b=P+80FJjJ5/Fu5amObDeSy9W/HX8DmfuYaF/n3NtyHrXQyU+frsUt2EiXWQD08UUHrE+v8YGlJ
 ynhiqLdQZZzALoZDTeM299z5wQNU6PFofeIB5bMSFLCNpjg/9WdrqzP
X-Developer-Key: i=brett.mastbergen@gmail.com; a=ed25519;
 pk=KMdTG5jy0i293GjuHrtMAg0aedFD0HL3VOJ6hZ3YJAA=
X-Endpoint-Received: by B4 Relay for brett.mastbergen@gmail.com/20250916
 with auth_id=525
X-Original-From: Brett Mastbergen <brett.mastbergen@gmail.com>
Reply-To: brett.mastbergen@gmail.com

From: Brett Mastbergen <brett.mastbergen@gmail.com>

This adds a DMI orientation quirk for the Chuwi MiniBook X which
has a display mounted 90 degrees rotated.

Signed-off-by: Brett Mastbergen <brett.mastbergen@gmail.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3a218fb592ce..70fc2eb292ff 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -283,6 +283,13 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Hi10 pro tablet"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
+	}, {	/* Chuwi MiniBook X */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR,
+				  "CHUWI Innovation And Technology(ShenZhen)co.,Ltd"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "MiniBook X"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Dynabook K50 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dynabook Inc."),

---
base-commit: 46a51f4f5edade43ba66b3c151f0e25ec8b69cb6
change-id: 20250916-chuwi-panel-quirk-f48f42859bcd

Best regards,
-- 
Brett Mastbergen <brett.mastbergen@gmail.com>



