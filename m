Return-Path: <linux-kernel+bounces-801420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B55B444D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD261CC2938
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F49334712;
	Thu,  4 Sep 2025 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="MaH5iYIg"
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A116322C78
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008248; cv=none; b=PadH6+9WAC3G28NVd8n13DEkKdERB48SbLAsRUMv08lmJlRRYuEtAasoUvrBxgPis2iJ2ZmwIvbg2Yl+VIWvztQLNzq09bBVyfdWd4JWJVYiE/CJgWRpnWpj5QdRpQfAn5FpXv6VH9N2EFiuegpk1Gt+2X8LCxHe/ORALHRFF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008248; c=relaxed/simple;
	bh=/aQomCKAwnh5DSN45093R8fFbfNYv2it5aiWgo616ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9mq90uCLVYwM5mgCDLmZYQB1o2/NDifrCz/qxM3jS2adIsJEpt0n1xPPa7HOhOyOY9y0ezUkk0GNEcalB8Qn1/l5KZ12UHqKrs0tB0oAGB4Z7zmf8NgdMxOtHCewwUG4BTJIQK4oSaOTYTEUXljauFT+uLqfM9z/B0Aj0OKz+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=MaH5iYIg; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id DE8D5BDC0C;
	Thu,  4 Sep 2025 20:50:38 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id E5705BCF4E;
	Thu,  4 Sep 2025 20:50:33 +0300 (EEST)
Received: from antheas-z13 (unknown [37.96.55.21])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 54D611FD140;
	Thu,  4 Sep 2025 20:50:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1757008233;
	bh=xmOu5qfxHSjn2/DMtJndTuGQn3x/Clqe1gi5bi5Z8Y8=; h=From:To:Subject;
	b=MaH5iYIgQi8sktl7HdgY0yFixRIS6OWarjoxb4R0yWlKPat/g9XOPEep7guAPWGQm
	 0HRGd3BfieY529xDfCFeOVCGYRmrjJNj5qwXPLXct/iUmEfjPyxtNfjTFpR7duVfuL
	 ALXYuyrks9gq823Ex5y2+IdYKFeuQUd5RvvxspixUWLLvRbh1wFz85cqF3R2r1I+VT
	 NFhfJnM5CWV6lOLQtJ66W6vEb+ZYSyYlkORP1fcTWY++npfUBT7Q62s0mWsscSnZIw
	 1vSsy7edXavT3JdtbYLKhyKasByckpSiez7xGvp/7VXwWYZdRhv2g8peSe5vRkqYOv
	 ZnmwAld6Syi4A==
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
Subject: [PATCH v1 02/10] drm: panel-orientation-quirks: add additional ID for
 Ayaneo 2021
Date: Thu,  4 Sep 2025 19:50:17 +0200
Message-ID: <20250904175025.3249650-3-lkml@antheas.dev>
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
 <175700823347.2009150.18288815011819177599@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The Ayaneo 2021 has an alternate variant that skips AYA in the
beginning. Add that as well.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index f5c7275cf026..d724253407af 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -215,6 +215,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYA NEO 2021"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO 2021 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "NEO 2021"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* AYA NEO AIR */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
-- 
2.51.0



