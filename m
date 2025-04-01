Return-Path: <linux-kernel+bounces-583892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF66BA78112
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 19:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE2A3AEA42
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D2E211282;
	Tue,  1 Apr 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9Zz0Wlh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07932EAF7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743527134; cv=none; b=aWTna6/bu+8Zr8l1BIR3TgeYMFz/Bu1Mmhbj2dxaW2jfs3//lEqlplrRvKKF7Y2/AjIvSWpRksjbPQO+L645wWQm4cu6uL1FX1oIfl7eUTQ46Yz3BdncGg2NkHQgbPNT0EMv18fl4lfLW65wxRu9uDJ4No+GkagsQtxvtrsCdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743527134; c=relaxed/simple;
	bh=S8BD5Csp+ce0/c6sIncs+qGZ+yQomoyK1vsncMhB3TY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RtgOG+eQ1CobdFRsyX+gooHkGaek6+bkCW2A5bG1FPp/cg64Y3l01RygpZZluPofyVBUoUzCTntqdaAw55Gg6r7vmADFaT7AWCNWLl3TZOLm8w+iUHzpI0QRSpbq5oYM9FkFvTwVPp4TQXHZyM34wj11Xx44uQ4Fo43CcNBu324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9Zz0Wlh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743527131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OfmSnqQBvK18OQgnBp/1TPGBR3Gzbm66RBLu11vo6tE=;
	b=J9Zz0Wlhv/NLaCkHsU9dbIRqy+ny/EU9XhAEQR9LHszsSw8L4IQUz5StUbVdJLPT3FHgdk
	PfindZjGfbI4564xFuw4b6V5vQ9PXO7KrEgMm0MgtZwHImxgyMBxnJiffI2GflpQuwJPl7
	MT2be+odBi8akZB3eL37Yeezk4Dmtns=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-pZDDnuJPMG6TtXpm_64JzA-1; Tue,
 01 Apr 2025 13:05:29 -0400
X-MC-Unique: pZDDnuJPMG6TtXpm_64JzA-1
X-Mimecast-MFC-AGG-ID: pZDDnuJPMG6TtXpm_64JzA_1743527128
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4A03195608B;
	Tue,  1 Apr 2025 17:05:27 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 587A9180B487;
	Tue,  1 Apr 2025 17:05:25 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 01 Apr 2025 12:03:47 -0400
Subject: [PATCH 04/10] panel/auo-a030jtn01: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-b4-drm-panel-mass-driver-convert-v1-4-cdd7615e1f93@redhat.com>
References: <20250401-b4-drm-panel-mass-driver-convert-v1-0-cdd7615e1f93@redhat.com>
In-Reply-To: <20250401-b4-drm-panel-mass-driver-convert-v1-0-cdd7615e1f93@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linus.walleij@linaro.org>, Joel Selvaraj <jo@jsfamily.in>, 
 Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743523429; l=1358;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=S8BD5Csp+ce0/c6sIncs+qGZ+yQomoyK1vsncMhB3TY=;
 b=o1R4hv6pyf79qn8t2Pap5cFuUC7l166aME69h8BVSQ07swCkJjUi6E10APt25WMe9bEPEy+Ir
 Hsy9u3/yBlcClMLdgfwGqd+cE/XditkdZveBU8uunTtGyew2vPjxJTw
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-auo-a030jtn01.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c b/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
index 77604d6a4e72c915c40575be0e47810c90b4ed71..83529b1c2bac2e29f41efaf4028950214b056a95 100644
--- a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
+++ b/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
@@ -200,9 +200,10 @@ static int a030jtn01_probe(struct spi_device *spi)
 
 	spi->mode |= SPI_MODE_3 | SPI_3WIRE;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	panel = devm_drm_panel_alloc(dev, struct a030jtn01, panel,
+				     &a030jtn01_funcs, DRM_MODE_CONNECTOR_DPI);
+	if (IS_ERR(panel))
+		return PTR_ERR(panel);
 
 	priv->spi = spi;
 	spi_set_drvdata(spi, priv);
@@ -223,9 +224,6 @@ static int a030jtn01_probe(struct spi_device *spi)
 	if (IS_ERR(priv->reset_gpio))
 		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio), "Failed to get reset GPIO");
 
-	drm_panel_init(&priv->panel, dev, &a030jtn01_funcs,
-		       DRM_MODE_CONNECTOR_DPI);
-
 	err = drm_panel_of_backlight(&priv->panel);
 	if (err)
 		return err;

-- 
2.48.1


