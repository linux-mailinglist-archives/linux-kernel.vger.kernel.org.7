Return-Path: <linux-kernel+bounces-726869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09245B01241
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710FB170911
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF001C2437;
	Fri, 11 Jul 2025 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kq0pYU3n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC312EAE5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208367; cv=none; b=ul9q9S4cHQO4dlQJcyYb654Gd3ZzFOFaCfxkREeH106BmDk2a6HODfVmX5pr8z8/UpIkSHLPh7g5/LBPXoPqnSVg2Wn1AHR8372hVsEnulF7NTi5j/iZSwSTHXsNQU5PF/kfvYBLq6pqbPZGsIOtL1taOMYHhfEWR3S6KfMIJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208367; c=relaxed/simple;
	bh=SUV4f8dNf/xYjMAHj2f0Rzw90WK1gwUaB8kV6C9fYoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XAXgd0N4LgsB6dKtajSMUsyMNCfw5xQteUyEnHB5wEDoDarrMTeyhsRpqJ/FVV/GodZGNJbvY6xSbkPNPeVvSDfLwgM95/t5CkxIZtmO4lCsKALv2w6oR4IAuEgQ+NA9crIRsB9s8R3n39vbGG0G+8Z8IulSlunBNWO8dKQPbew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kq0pYU3n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybj92p3FeYPb6PC8GulJyPRWsViFfANiGwTVSp0VdX4=;
	b=Kq0pYU3neiZJq8jiTbnf89kK6v3gE8nQTLoAFLz3+hydkV44sqom6fy1IkJp8OYSWATm7M
	KnnAE6eArMVaLsS5hDr3ehtLXzRTtr2RUhQLvHryPov0Om4Se23QoKWFnX9FtxamjHMbAD
	CmA6dvNvICt1h+k5YO6ER/LJpYmsI44=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-ePPTMWUmNaefCetTzTFRZg-1; Fri,
 11 Jul 2025 00:32:39 -0400
X-MC-Unique: ePPTMWUmNaefCetTzTFRZg-1
X-Mimecast-MFC-AGG-ID: ePPTMWUmNaefCetTzTFRZg_1752208357
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86CE9180028C;
	Fri, 11 Jul 2025 04:32:36 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A77C180045B;
	Fri, 11 Jul 2025 04:32:32 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 10 Jul 2025 23:31:14 -0500
Subject: [PATCH 03/14] drm/panel/vvx10f034n00: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-b4-driver-convert-last-part-july-v1-3-de73ba81b2f5@redhat.com>
References: <20250710-b4-driver-convert-last-part-july-v1-0-de73ba81b2f5@redhat.com>
In-Reply-To: <20250710-b4-driver-convert-last-part-july-v1-0-de73ba81b2f5@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752208280; l=1558;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=SUV4f8dNf/xYjMAHj2f0Rzw90WK1gwUaB8kV6C9fYoo=;
 b=cveZnxEVTl9fD4dgn3VYxY0c24BJ4C5Zv1DaSA2DSWTnJdyulmh5nQQcL4X2ztZfU4Dbkh4VU
 hYmQq7h238LDZP7OaMgBa5Y8pj38WtFJIDLZuFcdnnAgGDCX01p0ST2
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
index d1c5c9bc3c56a6fe12096ca7b08e34e490699207..3c3308fc55df08a24d62fadbef00080667ea3902 100644
--- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
+++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
@@ -166,9 +166,6 @@ static int wuxga_nt_panel_add(struct wuxga_nt_panel *wuxga_nt)
 	if (IS_ERR(wuxga_nt->supply))
 		return PTR_ERR(wuxga_nt->supply);
 
-	drm_panel_init(&wuxga_nt->base, &wuxga_nt->dsi->dev,
-		       &wuxga_nt_panel_funcs, DRM_MODE_CONNECTOR_DSI);
-
 	ret = drm_panel_of_backlight(&wuxga_nt->base);
 	if (ret)
 		return ret;
@@ -196,9 +193,12 @@ static int wuxga_nt_panel_probe(struct mipi_dsi_device *dsi)
 			MIPI_DSI_CLOCK_NON_CONTINUOUS |
 			MIPI_DSI_MODE_LPM;
 
-	wuxga_nt = devm_kzalloc(&dsi->dev, sizeof(*wuxga_nt), GFP_KERNEL);
-	if (!wuxga_nt)
-		return -ENOMEM;
+	wuxga_nt = devm_drm_panel_alloc(&dsi->dev, __typeof(*wuxga_nt), base,
+					&wuxga_nt_panel_funcs,
+					DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(wuxga_nt))
+		return PTR_ERR(wuxga_nt);
 
 	mipi_dsi_set_drvdata(dsi, wuxga_nt);
 

-- 
2.48.1


