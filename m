Return-Path: <linux-kernel+bounces-587866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E35A7B142
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 23:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298C416085D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 21:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443231FC0E9;
	Thu,  3 Apr 2025 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8F06P/E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2118DB17
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715484; cv=none; b=XYHpL7w9U4qKCC0ceap3/o/fRXr2kKJoGshzvsIHV5n5TQCyXm4ZXiQRqX49LTAmh+N/pXjgxgfa13BPDsZ4GrRW4PRaGXaaDECsqXsLgJsNzWzEbvPNWjWUxkE6urIQ43jmfZpStfCqdEYFEyw6O1/YasDgi/H6TsszSnF83vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715484; c=relaxed/simple;
	bh=5HF7V2Ynx0YxMQIOx0Nh2UoWUB4ldApTe4qTVFONEqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uEZv6UsfhU5OIg479xIuMeUaoNGH2iUMTQKQsNEbRbqAdDRaLPbu8QoMONqfgz7p0WF90TE5zgJdDnwBc4oYRvvaRbR2Wwy5oN4F2ftIiOnuA8pmUTndbwqxsJz8qOxjZnIUPCiuvvBLaJVL2VgCvb2TNkohJgR/X3up50me2jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8F06P/E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743715482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T78FB7dvnX0BgLK7hP9hSE1L9ZbJkmZnc0hL6QTgquk=;
	b=U8F06P/EgcdQqbWKVpk//j3fY1alrGFmQg5sovuY6tdgKe6q5gluICjdQr8DhjrGucJMJl
	aRPz3uhhXY+e6GJe4xIvqT6P7Cs7/fauyIIEJg1SpwseMI+IHwvD2ROauLr5tGvrAuoHlG
	Luqr9FBRyDAJ7T+VjOFlCk+yMOho5Ts=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-WEqA-JKYO1m7vfHuRGC-uw-1; Thu,
 03 Apr 2025 17:24:40 -0400
X-MC-Unique: WEqA-JKYO1m7vfHuRGC-uw-1
X-Mimecast-MFC-AGG-ID: WEqA-JKYO1m7vfHuRGC-uw_1743715476
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C35A01800267;
	Thu,  3 Apr 2025 21:24:36 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 83925180A803;
	Thu,  3 Apr 2025 21:24:32 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 03 Apr 2025 16:21:00 -0400
Subject: [PATCH 29/46] panel/sony-acx565akm: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-drm_panel_mass_driver_convert_part3-v1-29-965b15ad5b8e@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743711639; l=1262;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=5HF7V2Ynx0YxMQIOx0Nh2UoWUB4ldApTe4qTVFONEqI=;
 b=vHDfnpbZu8QqK29GXM1Zi0/MmqlfcRWLIjVMjEiBl4KCM0o9dHLLKEvc3GgOH+u/lorWIP1VX
 a960bDlmjXnCVbHWVWdCacnlE3G573O22IpRcAboGGxAyAkOQchLU5H
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-sony-acx565akm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sony-acx565akm.c b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
index d437f5c84f5f0915ec9a3b3a899cb8bd41209c77..cf1c4c81fae757dcd4740bacbcd6b8a7eb04d7c2 100644
--- a/drivers/gpu/drm/panel/panel-sony-acx565akm.c
+++ b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
@@ -607,9 +607,10 @@ static int acx565akm_probe(struct spi_device *spi)
 	struct acx565akm_panel *lcd;
 	int ret;
 
-	lcd = devm_kzalloc(&spi->dev, sizeof(*lcd), GFP_KERNEL);
-	if (!lcd)
-		return -ENOMEM;
+	lcd = devm_drm_panel_alloc(&spi->dev, struct acx565akm_panel, panel,
+				   &acx565akm_funcs, DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(lcd))
+		return PTR_ERR(lcd);
 
 	spi_set_drvdata(spi, lcd);
 	spi->mode = SPI_MODE_3;
@@ -635,9 +636,6 @@ static int acx565akm_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	drm_panel_init(&lcd->panel, &lcd->spi->dev, &acx565akm_funcs,
-		       DRM_MODE_CONNECTOR_DPI);
-
 	drm_panel_add(&lcd->panel);
 
 	return 0;

-- 
2.48.1


