Return-Path: <linux-kernel+bounces-852459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E259BD90A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811EA3B3248
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC4030FC09;
	Tue, 14 Oct 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qr6AoFSx"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354930CD81
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441485; cv=none; b=e3XGEnD+wClcOaCTdVJwIRjY0+eWTUIM+IDDQ5dlOP0Zmw9x9A1Sf4sHS7Q3kYT0Y2sfvxHJ1dfI9Mfp6f6vX+qH/W9XjpTbpDuhxWzz1S2X+lTqrrZhoGOPwMNfnhUHEQyoms2JT3Z7y7NHkmu3KLfqZK+sHx5dbzQ/RaOwIrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441485; c=relaxed/simple;
	bh=BIO0NcAQsBokphwoEQbRRETLdlgE26EM2f+mvAZarDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uaGF7rQPdpyk/3XsVejJFEFCfBcE2hw5vXE6EG/v4vO3laPZBrbdLgh+Z2Dgr0BBW3lu6yvFJ7FW4tw7tOcu9V7zAeF3wLnQaW1AIXvLO3h4oVKbaOZ5w7T69LdKXQJ2tKyhNOmNmfr+NoeXsjh2GmUOoOagz6wBHbHOP6eWoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qr6AoFSx; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B99A74E4108E;
	Tue, 14 Oct 2025 11:31:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8DD46606EC;
	Tue, 14 Oct 2025 11:31:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9AD5D102F2298;
	Tue, 14 Oct 2025 13:31:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760441480; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=51CzKYDEx2a9yVAc768Na++IHptYoF7LDAE19Kl4+7I=;
	b=Qr6AoFSxr32F6mDxxdYbBXAVT1ujiJP11N7z44icP/Q/PhLiq34zX+VKaBACkajgO2Qh52
	3ZwUKEzfQNxycfhwM+xsCRcoF7nALRDLf91eUj1BWm8asG5Om8Cov7twUwCernFzfA4sBU
	pE8Fk4Poj1I1SlLMbSddA9snbZn0rv0sMg/kWEzmYnoAv4AyfcS1V+N5+mQHI1oUzC/AEO
	IqY3dYgeZZ/rmPLxrRLNr33Y2if9OaHrPfZq+2ThmtGwPpaJ7KANXaSxhVB42XifeODsVr
	eq8gkI7zyqYMn9OeSURX9WmtWIJJjO2qy5QG4psRL5BSYBJLqK1nK09QvWS6iQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 14 Oct 2025 13:30:52 +0200
Subject: [PATCH 2/2] drm/imx: parallel-display: add the bridge before
 attaching it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-drm-bridge-alloc-imx-ipuv3-v1-2-a1bb1dcbff50@bootlin.com>
References: <20251014-drm-bridge-alloc-imx-ipuv3-v1-0-a1bb1dcbff50@bootlin.com>
In-Reply-To: <20251014-drm-bridge-alloc-imx-ipuv3-v1-0-a1bb1dcbff50@bootlin.com>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Invoking drm_bridge_add() is good practice, so add it to this driver.

Link: https://lore.kernel.org/all/DDHZ5GO9MPF0.CGYTVBI74FOZ@bootlin.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Note: there is a proposal to make drm_bridge_add() mandatory before
drm_bridge_attach():
https://lore.kernel.org/lkml/20251003-b4-drm-bridge-alloc-add-before-attach-v1-3-92fb40d27704@bootlin.com/
---
 drivers/gpu/drm/imx/ipuv3/parallel-display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
index 3d0de9c6e925978b7532b6d13caf6909cc343dd7..7fc6af7033078eef6be0672ff0d1c7bddda88ba1 100644
--- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
+++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
@@ -256,6 +256,8 @@ static int imx_pd_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, imxpd);
 
+	devm_drm_bridge_add(dev, &imxpd->bridge);
+
 	return component_add(dev, &imx_pd_ops);
 }
 

-- 
2.51.0


