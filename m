Return-Path: <linux-kernel+bounces-801416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD41EB444CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5AAA40887
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4483C3218C9;
	Thu,  4 Sep 2025 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Wn2ogZd5"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3131AF36
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008243; cv=none; b=nfQapjQ0vbtJqDfApB9uaJM/PYSNoVGwuDarEx07ufMFRDzgSDVkpJpCO6MTH0qSjE1QCETXYqAHT7OtADdaKFRtLEMpt4j3S+4UUFsfhyaLdQ835SbN9wLfLSofb15dNx1RJ2ZEFV29qSZPy34LGx39wohPPxJYXA9kYf/FExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008243; c=relaxed/simple;
	bh=EAIT06RX4dHEcRLhstnh3tKNg76fpFzrkajLxLNs9bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYXuthOBhYPpRByjN4aCoR2GZCPYcuqomQay11PNLBWmJIz9TXPhaB3mzNkH2muqmLfZCvIwHm4NPzrty03Mh9gVKvLTWOk7ZJO5Bns9ciWBRoTlRdRGmFglvdgTw2Fkx/LhdWczjXp7y/8Elrnwwmi3LRcFlY7IEKIbsWYja1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Wn2ogZd5; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 2DF9EC83BC;
	Thu,  4 Sep 2025 20:50:40 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id BAE71C83C3;
	Thu,  4 Sep 2025 20:50:39 +0300 (EEST)
Received: from antheas-z13 (unknown [37.96.55.21])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 6F9A91FD13B;
	Thu,  4 Sep 2025 20:50:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1757008239;
	bh=BAvDGtLi6Zo9CZ1tJtojxW1gBOs8Zcop6Ypl8Lyl3Nw=; h=From:To:Subject;
	b=Wn2ogZd5pY83lrLjAXK2CoCDEZulDmzlGK3mz0l0k2NOUivSEnVWJmUJFYoDsqJA0
	 yvWmo0lRP3cHcA5nVxA1ymjQIhrWuSrqN85Bn2BzHWkGQ4hF64g2C+YCvKtz7VCKmJ
	 5NxGlSaXuuI6EpFHd1SHNnJahZ0HjbEnpIryScLpHuCtXP+EdAFhsN1cqBz0t5bVeZ
	 IMBUaEIU/ebtk6lq3FCXYTAaFAFvmvftsuIPvvOHRXCc8gbnSy1mYpwHhaVWqbpJTo
	 XG7gYcpX5cxR+BPWbT759aiaSjajB6DzOm2JAB7+Wu04oyUjHt9PMYQh7PflI7MEnN
	 lCfugq+mQ0PNg==
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
Subject: [PATCH v1 06/10] drm: panel-orientation-quirks: Add OneXPlayer F1
 variants
Date: Thu,  4 Sep 2025 19:50:21 +0200
Message-ID: <20250904175025.3249650-7-lkml@antheas.dev>
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
 <175700823943.2009361.5295348970573880397@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The OneXPlayer F1Pro has a 144hz 1920x1080 portrait OLED panel.
Add a quirk to correct the panel portrait orientation. In addition,
it comes with a red limited edition variant in the Chinese market,
so add that as well. Then, add the 8840U non-pro variant as well.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 0c0fe66e94ad..6f5ce26a84b7 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -540,6 +540,24 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1Pro EVA-02"),
 		},
 		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OneXPlayer OneXFly F1 Pro (OLED) LE Red variant */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER F1 EVA-02"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {	/* OneXPlayer OneXFly F1 Pro (OLED) Hawk Point */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER F1 OLED"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {	/* OneXPlayer OneXFly F1 Pro (OLED) Strix Point */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER F1Pro"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* OrangePi Neo */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
-- 
2.51.0



