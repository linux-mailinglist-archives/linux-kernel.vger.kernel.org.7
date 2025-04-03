Return-Path: <linux-kernel+bounces-586994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9F3A7A643
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 17:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FA618975A5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 15:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2F62517AC;
	Thu,  3 Apr 2025 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/0VtUg9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5822512DE
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693526; cv=none; b=rUOVREW7Z+/BtkDzL3uosYUZ/7wuc+woBDNAjjGm7bvPuSZt/JyEN4jMim4MNSwF7wWXoBPYUGHhF3uHwU6Ox42JSQyLS94QiGnpDVN0YQQmcH0/IRk2F6M5HM1G/nCpVCLxMb3wUtmwA2hVjVEk+XEenD6VHHacv/+6FiBxdJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693526; c=relaxed/simple;
	bh=OvfPV/9ehfjRBN3Px7KFfwcuBcVdr+EQDv2IXnbdDts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WaAFql50gOXpacgnYLXrH7tzHzYzaBmzp4cXtE5Q110yrYo2Ido7PMSBGm3+g4D3FtIYO4RsFpViwf6CAQDfMrky+Nki5F65GX4vsDd6u1I9izWKPZ95twhub9msMO/unK2SNYJIkTMT787F1W0fx6rHm6yr0mUN3d01/26MXOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/0VtUg9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743693523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGhs5rdjJtxCIQ4in6lIxVrXrWp4AmuNLID9t6HVESU=;
	b=e/0VtUg9OOGnER+spm4IguVa+FRCgyGVDdi9RjwrzSLoRHYPrrreDq/S5ndWQk7RoGveJ3
	tq/oIwv4N4yIxEAimsvf+XKlaW7PTLI6IgVgNhy4NKsAcFl7rslMydjTl+BAdbjUaovIlX
	FfVkhx2zvCLlCFmTZRfCMghNOm01esQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-_dk0sk89OAyqSNeQ8UwJQg-1; Thu,
 03 Apr 2025 11:18:39 -0400
X-MC-Unique: _dk0sk89OAyqSNeQ8UwJQg-1
X-Mimecast-MFC-AGG-ID: _dk0sk89OAyqSNeQ8UwJQg_1743693516
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C26CA180AF56;
	Thu,  3 Apr 2025 15:18:36 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9DB21801752;
	Thu,  3 Apr 2025 15:18:31 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 03 Apr 2025 10:16:18 -0400
Subject: [PATCH v2 11/30] panel/innolux-ej030na: Use refcounted allocation
 in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-drm_panel_mass_convert_part2-v2-11-260c8a44c56b@redhat.com>
References: <20250403-b4-drm_panel_mass_convert_part2-v2-0-260c8a44c56b@redhat.com>
In-Reply-To: <20250403-b4-drm_panel_mass_convert_part2-v2-0-260c8a44c56b@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Icenowy Zheng <icenowy@aosc.io>, Jagan Teki <jagan@amarulasolutions.com>, 
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Walle <mwalle@kernel.org>, Jagan Teki <jagan@edgeble.ai>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Jianhua Lu <lujianhua000@gmail.com>, Stefan Mavrodiev <stefan@olimex.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743689775; l=1355;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=OvfPV/9ehfjRBN3Px7KFfwcuBcVdr+EQDv2IXnbdDts=;
 b=wSu6peuveq4hXJkV3uLgLamsYaZxTwXCcnebADu2RHcok9B5MPar0lTecoVNh6gxrwmjzToB1
 +JgpZrGDegNDYMmHyUAMrRQZbbPEoDf1Zosxuh5HIn3jN3ES6kpZJ9O
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
v2: none.
---
 drivers/gpu/drm/panel/panel-innolux-ej030na.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-ej030na.c b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
index f85b7a4cbb4206bea7b5a019ba1de1dd05b13fe2..b2309900873b28f98707f79f4332763369a27d72 100644
--- a/drivers/gpu/drm/panel/panel-innolux-ej030na.c
+++ b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
@@ -204,9 +204,11 @@ static int ej030na_probe(struct spi_device *spi)
 	struct ej030na *priv;
 	int err;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	priv = devm_drm_panel_alloc(dev, struct ej030na, panel,
+				    &ej030na_funcs,
+				    DRM_MODE_CONNECTOR_DPI);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
 
 	priv->spi = spi;
 	spi_set_drvdata(spi, priv);
@@ -231,9 +233,6 @@ static int ej030na_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
 				     "Failed to get reset GPIO\n");
 
-	drm_panel_init(&priv->panel, dev, &ej030na_funcs,
-		       DRM_MODE_CONNECTOR_DPI);
-
 	err = drm_panel_of_backlight(&priv->panel);
 	if (err)
 		return err;

-- 
2.48.1


