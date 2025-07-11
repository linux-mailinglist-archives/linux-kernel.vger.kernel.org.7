Return-Path: <linux-kernel+bounces-726870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B253B01242
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC2D1728C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A815A1C3C14;
	Fri, 11 Jul 2025 04:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bU33rt6H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3741AC43A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208368; cv=none; b=ankHZF/DuUyK1pex3SZbfNKPVjbo605n4HtteyFqzgt2uyON6+xL60i70+ORiHUuSnL6X7/4bgvQe/ECW8CmN2rZ3Ogigk3QA6HZBgEPMWjW+L1YUqeMlH+uFX7dNsaPflNy9XkzWfy9Ldhiek3v338scsT9P2/5eigSdxadkUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208368; c=relaxed/simple;
	bh=7kUwIkJl86pFYYQVdqTbPPyQkYWl3J1ABcWmZEpiDVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PpbqNIiVvwOEytlT+AsqzpCTQCRzed1Ww9bYGdCRlO0fw+QEQ6SmuosxxVVCeb+Nbu5MIn7dR4m8A3pS001ilPq42zh0TYm+hRMTC7aICZCav9mK47k6R4BkQ5y29w2dkpS5D9cbuLe7EjqDqL7gnIyZQJPmIicFZl90nQfNus0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bU33rt6H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXNaF4+BMp3g0HFKFrTE4oB1c46APaPxKbvDXy92b/k=;
	b=bU33rt6HZD73zgftc6SOkVbCEyT1OrGX07dOSv5S7qN/7SXd0TA8q7DkzhRxFVS2Wa6ffe
	RuqayIomOWsV4x6NVYZB9FBmHGN+Vy6LSA/1C+QCQVB59+bXHIUggfotucRpuMfoZ5P73e
	ku0yOf8dsLlG7SLINDQZUGGrPmdKx28=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-jNmcXOdCNni-UY5LOX2_xA-1; Fri,
 11 Jul 2025 00:32:42 -0400
X-MC-Unique: jNmcXOdCNni-UY5LOX2_xA-1
X-Mimecast-MFC-AGG-ID: jNmcXOdCNni-UY5LOX2_xA_1752208360
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C298519560B4;
	Fri, 11 Jul 2025 04:32:39 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C92118002B5;
	Fri, 11 Jul 2025 04:32:36 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 10 Jul 2025 23:31:15 -0500
Subject: [PATCH 04/14] drm/panel/osd101t2587-53ts: Use refcounted
 allocation in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-b4-driver-convert-last-part-july-v1-4-de73ba81b2f5@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752208280; l=1626;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=7kUwIkJl86pFYYQVdqTbPPyQkYWl3J1ABcWmZEpiDVc=;
 b=cXGLwVnCtsgtvTXjCBJ0QkJD60xl6QTAK8U0DdwiD/7ZMWenI70x57yDpOiB/eBQwYTVBuvZx
 8d5wOFYb+HxAHA1Rpm+xa+HKgasQ81yjR0aNvODXkmsKHyIuVFi2A0j
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
index dbea84f515142dbf77236552643bb0e4546d0ca8..2334b77f348ce61e98b74f7b26d4021be412c376 100644
--- a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
+++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
@@ -132,9 +132,6 @@ static int osd101t2587_panel_add(struct osd101t2587_panel *osd101t2587)
 	if (IS_ERR(osd101t2587->supply))
 		return PTR_ERR(osd101t2587->supply);
 
-	drm_panel_init(&osd101t2587->base, &osd101t2587->dsi->dev,
-		       &osd101t2587_panel_funcs, DRM_MODE_CONNECTOR_DSI);
-
 	ret = drm_panel_of_backlight(&osd101t2587->base);
 	if (ret)
 		return ret;
@@ -161,9 +158,12 @@ static int osd101t2587_panel_probe(struct mipi_dsi_device *dsi)
 			  MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 			  MIPI_DSI_MODE_NO_EOT_PACKET;
 
-	osd101t2587 = devm_kzalloc(&dsi->dev, sizeof(*osd101t2587), GFP_KERNEL);
-	if (!osd101t2587)
-		return -ENOMEM;
+	osd101t2587 = devm_drm_panel_alloc(&dsi->dev, __typeof(*osd101t2587), base,
+					   &osd101t2587_panel_funcs,
+					   DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(osd101t2587))
+		return PTR_ERR(osd101t2587);
 
 	mipi_dsi_set_drvdata(dsi, osd101t2587);
 

-- 
2.48.1


