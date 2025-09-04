Return-Path: <linux-kernel+bounces-801421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C7B444D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B781A621F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C803376AE;
	Thu,  4 Sep 2025 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="X6nD/cRG"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFAE32A828
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008249; cv=none; b=ZUNBAl/J70R2/+qxo8BEyOgVi6WKs4EdmLr15CGF40lrDscy/u9EBdzD39JiG+osytXzRKKKHpZD7nYEOhXI6lk3c7imgd9Dd58EFmCKfb0LI8OZ+3FM4w9DalgsCTujnd7jGy4nIPH6VqgALhhrlB1NN7tFaykmjG+YSgElzm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008249; c=relaxed/simple;
	bh=w5TsmhWzRX2uWwLvaquxRqJhI+bGAonJUMeDECyfKLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbAwdrRtwZ/4RN68HScf5E951D9LlNMtJVQfRvoiDSRFPNRhMaY/Fxu00Pq+tJTluaKk+GYCo2+tgMdSJTWwq/ncjgxCcCOYoKjkbUhLU0QyKzv1i2+gTsJH0ZWE1n772NNieMbxi4+XsJ1KVdMeHoBdP/JtTFB4xzNZEv/9wuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=X6nD/cRG; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 8ECBB47BB9;
	Thu,  4 Sep 2025 20:50:45 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 8E4B947BC8;
	Thu,  4 Sep 2025 20:50:44 +0300 (EEST)
Received: from antheas-z13 (unknown [37.96.55.21])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 1C9B61FD140;
	Thu,  4 Sep 2025 20:50:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1757008244;
	bh=uQgjSL/MnFEC+mGcji4hkbedZTA4kfonopaBoO9eAgg=; h=From:To:Subject;
	b=X6nD/cRGLLUhFo8fILyCtId608541ennk01KJGPuCJXEYvsltHCD+KQyLiKFh57Uc
	 RnEfWoSn+EdJ40Us0TrPr0zZG6kQ2gTxR9vo4spVV8ul1B+wQOq2n8+RgiznDU5bv2
	 cojyFmzZTC62m5w0Zg2SVkTY6DgQzFY38UMA2gx8cOjyHTAzfwFgNSk8/wM2uq6DVR
	 QGmHQAJcbfCGt6Tl4CXL+Lwg6ermTuyOT43lUoHaRfv6IvNqWCkOkHuAnscFXMwHYR
	 FUU9ZT4h8nGSdkHfyX8oqTgiwvul7Pp95uU5kXTkAzAf17TIvzLVVyB1PkblZEqwpZ
	 PSXf3tv7HinUQ==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 37.96.55.21) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	philm@manjaro.org,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v1 09/10] drm: panel-orientation-quirks: Add GPD Pocket 4
Date: Thu,  4 Sep 2025 19:50:24 +0200
Message-ID: <20250904175025.3249650-10-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904175025.3249650-1-lkml@antheas.dev>
References: <20250904175025.3249650-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <175700824412.2009498.16598954328779473115@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The GPD Pocket 4 is a mini laptop replacement with a portrait
2k panel. Add a quirk for it.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 75a8c4532434..5f896d6e4090 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -388,6 +388,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1617-01")
 		},
 		.driver_data = (void *)&lcd1080x1920_rightside_up,
+	}, {	/* GPD Pocket 4 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1628-04"),
+		},
+		.driver_data = (void *)&lcd1600x2560_rightside_up,
 	}, {	/* I.T.Works TW891 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
-- 
2.51.0



