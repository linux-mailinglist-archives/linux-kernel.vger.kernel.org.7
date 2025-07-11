Return-Path: <linux-kernel+bounces-726876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BBFB0124C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B6677BE88C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDEC1DB546;
	Fri, 11 Jul 2025 04:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAzLnZtc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD801BD9D0
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208388; cv=none; b=o82GimsjDRyRDftuHoyti9MGVek7o7slOpkoDelMK8qfPgNiJ9TbDUKngDUbaY18zA5OYNz9uMqhgfHwxO6IwMfr2d8bUBtrdhNJQ6tP9DyNrX4o/Y+AIisOFGGqcIcCcbkKXbZVD/MB3a4G6hTWueGbgLIPzS+Bk9HZmiaSzgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208388; c=relaxed/simple;
	bh=76yWT/SXjPcOqdfDoug/udmadP1Sboehs0wZbeLGz0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDXP/exSyWA+Zd7udEjgos0M770dMhWybb6LDsnsCEARdRIE9VhbsR/5t87aGK7HqjJHbv0NczifzM2jooXCB+17gfube0JQmjH/X2nkJV/8Y1BWG+3h6qdbhlrXSud6OsvakZLbIPA5oNnn2OT3ylgCi1cigStEgcaz95SPdxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAzLnZtc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ASpOxMdhH1Ni6FA6cOiOM+xnxokYtM9/grNQla7mZ4=;
	b=LAzLnZtcRUgLfB6enTGVDQ+jtP5mTRyJq2tNr2bDGjqKTnOf27P/9zQ+tblVEDwmdNnpHf
	TW4kaXqW47SpdzcbpkkO6RfdVOuc+h1REylpCIr/ixmQtbE5m0d/bByEc1N9k53PhybQmf
	r/Karv64UPL7mvJbqEzGdBCJG6SR3xg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-0afFhi0sNVKFQBd9kZ0sUQ-1; Fri,
 11 Jul 2025 00:33:02 -0400
X-MC-Unique: 0afFhi0sNVKFQBd9kZ0sUQ-1
X-Mimecast-MFC-AGG-ID: 0afFhi0sNVKFQBd9kZ0sUQ_1752208380
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98CF418089B4;
	Fri, 11 Jul 2025 04:33:00 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 818CE180045B;
	Fri, 11 Jul 2025 04:32:57 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 10 Jul 2025 23:31:21 -0500
Subject: [PATCH 10/14] drm/panel/lpm102a188a: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-b4-driver-convert-last-part-july-v1-10-de73ba81b2f5@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752208280; l=1518;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=76yWT/SXjPcOqdfDoug/udmadP1Sboehs0wZbeLGz0I=;
 b=CQH52r9at6hFa1Ymf8GJHoUDHfBxW7YTCZJGYAmSh6pqT6Q+ZQB3zYIxMmVhn63/Z8u5Zik6u
 XP2rofWeeouCEuvIMkofaRsIK4J8YECn/v8jJIHDz+9k8N2ynZA3brP
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
index 5b5082efb282bcf705cf2d38dea24901e9803648..5f897e143758c2be51c39a20eeda2ecd09e1fbee 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
@@ -435,9 +435,6 @@ static int jdi_panel_add(struct jdi_panel *jdi)
 		return dev_err_probe(dev, PTR_ERR(jdi->backlight),
 				     "failed to create backlight\n");
 
-	drm_panel_init(&jdi->base, &jdi->link1->dev, &jdi_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
-
 	drm_panel_add(&jdi->base);
 
 	return 0;
@@ -475,10 +472,13 @@ static int jdi_panel_dsi_probe(struct mipi_dsi_device *dsi)
 
 	/* register a panel for only the DSI-LINK1 interface */
 	if (secondary) {
-		jdi = devm_kzalloc(&dsi->dev, sizeof(*jdi), GFP_KERNEL);
-		if (!jdi) {
+		jdi = devm_drm_panel_alloc(&dsi->dev, __typeof(*jdi),
+					   base, &jdi_panel_funcs,
+					   DRM_MODE_CONNECTOR_DSI);
+
+		if (IS_ERR(jdi)) {
 			put_device(&secondary->dev);
-			return -ENOMEM;
+			return PTR_ERR(jdi);
 		}
 
 		mipi_dsi_set_drvdata(dsi, jdi);

-- 
2.48.1


