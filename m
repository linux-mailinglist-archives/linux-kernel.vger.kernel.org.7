Return-Path: <linux-kernel+bounces-587861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86354A7B13B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 23:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EB418875D5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 21:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D45D1E7C01;
	Thu,  3 Apr 2025 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKgvk1tO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7385931
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715471; cv=none; b=Imj7FSThpbYQd9sF8jeX8ETofs3punNPJNfVi3/4erwjfLYMDMFTBU+ueWDZZcacQNbc/HSb1axRBni7dFylDYEHVxGlB5XRFF0iHUFTSVrq9HgCL7KzQLcxx3xAhFOU3WhxiTJb+jj6UAXmpwQf1lBeRc/86+uCVxAKD8kw+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715471; c=relaxed/simple;
	bh=V2E/oy4I9619a0A4Y/q88mbe4D7FPStb5RlER26uOJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9uV0LSKyIwR1jF74dTI6abm0r3f9gDx1S+sPS/XoViR9QvuM15miwjTdcpA7BxrK0YyF6xSDameEtRy+6GXtI4K2M2RiDTJJnJNwE57NkuzrPTyTg0kY8RdGESiK3BDERsdzsQYn+Gs/2KBU3E6oQ+yWXlij+Tj4vEiagv1QUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKgvk1tO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743715468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=prhxRbMWcQEe4Um2m8Gu+S5B2Vc6o+DVlLumeainEJ4=;
	b=dKgvk1tOrczwBUkjd5qzz5aGAejzTkXEjimBItu6L+bawQHJOngcnm9ifnW4R/Ho2yEJZk
	jX6AtGui6wyoam6ifsV3Tv62WNN1yYrugQtpvr6X4uosPpjpz0I63s0BVLIMQIjbvu588Z
	9kd1mcDWnDd7Fc6uE3Ppvj9hKV7uhe0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-iVU9k4L4PaiS2M1unpBIRw-1; Thu,
 03 Apr 2025 17:24:24 -0400
X-MC-Unique: iVU9k4L4PaiS2M1unpBIRw-1
X-Mimecast-MFC-AGG-ID: iVU9k4L4PaiS2M1unpBIRw_1743715462
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAFD01860970;
	Thu,  3 Apr 2025 21:24:13 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B29A1828B97;
	Thu,  3 Apr 2025 21:24:08 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 03 Apr 2025 16:20:55 -0400
Subject: [PATCH 24/46] panel/sharp-ls037v7dw01: Use refcounted allocation
 in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-drm_panel_mass_driver_convert_part3-v1-24-965b15ad5b8e@redhat.com>
References: <20250403-b4-drm_panel_mass_driver_convert_part3-v1-0-965b15ad5b8e@redhat.com>
In-Reply-To: <20250403-b4-drm_panel_mass_driver_convert_part3-v1-0-965b15ad5b8e@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Chiras <robert.chiras@nxp.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Markuss Broks <markuss.broks@gmail.com>, 
 Artur Weber <aweber.kernel@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Janne Grunau <j@jannau.net>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743711639; l=1308;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=V2E/oy4I9619a0A4Y/q88mbe4D7FPStb5RlER26uOJ0=;
 b=4L4ieRiNfcBlseZ7/pwYabfhU090CEA3dg8EW30F/74RHB2J0dNPISk+70WhSCMM0lmBd5xrn
 +Vfy3svr8b3BBUuWZ8ExkpJ+40miPrCyctJ3PtkjPTEmjQ0FL2nQnEK
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
index a9673a52b861553792c9814da54a08043eb773e8..938beac4655d0bad6deaf93c7c1957403a446f20 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
@@ -138,9 +138,10 @@ static int ls037v7dw01_probe(struct platform_device *pdev)
 {
 	struct ls037v7dw01_panel *lcd;
 
-	lcd = devm_kzalloc(&pdev->dev, sizeof(*lcd), GFP_KERNEL);
-	if (!lcd)
-		return -ENOMEM;
+	lcd = devm_drm_panel_alloc(&pdev->dev, struct ls037v7dw01_panel, panel,
+				   &ls037v7dw01_funcs, DRM_MODE_CONNECTOR_DPI);
+	if (IS_ERR(lcd))
+		return PTR_ERR(lcd);
 
 	platform_set_drvdata(pdev, lcd);
 	lcd->pdev = pdev;
@@ -181,9 +182,6 @@ static int ls037v7dw01_probe(struct platform_device *pdev)
 		return PTR_ERR(lcd->ud_gpio);
 	}
 
-	drm_panel_init(&lcd->panel, &pdev->dev, &ls037v7dw01_funcs,
-		       DRM_MODE_CONNECTOR_DPI);
-
 	drm_panel_add(&lcd->panel);
 
 	return 0;

-- 
2.48.1


