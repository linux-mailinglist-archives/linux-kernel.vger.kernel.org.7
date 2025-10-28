Return-Path: <linux-kernel+bounces-873485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB2C1409C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2509A19800E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC8E2E6CD2;
	Tue, 28 Oct 2025 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qlkb9E7A"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DD5303CAE
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646598; cv=none; b=hTY4+F2gC8HOTB47+FTWxH0QtXbixbD8e7agCaH3hL4yoL6hj+9J3DH10RGPxPBorKMCgnvM0ESM5/EPPsupiTDHQwNduFRTPBdzm/9tmMmM1gqEB+AiA0pevD9qf+2BRLeGdokFfiI0M+B7Ab2z+3WlkMvZvAIatASa0KMrgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646598; c=relaxed/simple;
	bh=ifpbaagJL38iTiuI3uDxN7hJcYYCS9921ruXzBZxg3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CrmBh41ew2kqqEeAvmP8dmRGhnZI8wc6pstGbxeeb6ipAIpZz6NY2aJH8oph3P/1sjQ72d8vtbUP//XtFJhBatzE7sL2wHZzIfbBVUtahCHpcVI8XP459WzpchT6sTrY+n9BdBKaXvW/Fw5noCnLZtQkApdJ8FWGus5CajKwXaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qlkb9E7A; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 312E64E41393;
	Tue, 28 Oct 2025 10:16:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 035AF606AB;
	Tue, 28 Oct 2025 10:16:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45C501179B13D;
	Tue, 28 Oct 2025 11:16:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761646593; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZOj8mdyqTqYuMWt3nIGEDkwJWbIYd1bOEoaEedTj9EI=;
	b=qlkb9E7A1FupSg1i57BwyhsJlnIdnBXZnKxfuA8I7Vn78dvhaZl39Sri5UKfuOSZVEMGlU
	jbmedUXrZcBNlGaprupYW0M2EzjMrxXHRk8c4Pxg4G17+rGhjtI183kT6GY6JCYDhvj7t1
	/IdYgmIX/otRpUKkGEneM6bhu9MBh+cHWVteYvopKf4nnXG7cbZaqrcLECmGevWQ4vHB9r
	HNBhRPq0Q1v+0e8st87tlFECFP/YxHfi/awbQPbTwFimsuCSqxkZzKpnDu0CfLqfTzGsfY
	5dmJL04tuMXRcCziK02ndhE3vlwXHDm1NaE1XhBZUkmMzzASOL2vrgkmovGxqQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 28 Oct 2025 11:15:42 +0100
Subject: [PATCH v3 1/6] drm/sti: hda: add bridge before attaching
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-1-bb8611acbbfb@bootlin.com>
References: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-0-bb8611acbbfb@bootlin.com>
In-Reply-To: <20251028-b4-drm-bridge-alloc-add-before-attach-v3-0-bb8611acbbfb@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

DRM bridges should be always added to the global bridge list before being
attached.

Acked-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Acked-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- removed misplaced 'Link:' tag
---
 drivers/gpu/drm/sti/sti_hda.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 2c015f563de96ae58959801493ead870c49f70e5..b7397827889c94d6f8e8c2a48b09f06e29ceeaf7 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -779,6 +779,8 @@ static int sti_hda_probe(struct platform_device *pdev)
 		return PTR_ERR(hda->clk_hddac);
 	}
 
+	drm_bridge_add(&hda->bridge);
+
 	platform_set_drvdata(pdev, hda);
 
 	return component_add(&pdev->dev, &sti_hda_ops);
@@ -786,7 +788,10 @@ static int sti_hda_probe(struct platform_device *pdev)
 
 static void sti_hda_remove(struct platform_device *pdev)
 {
+	struct sti_hda *hda = platform_get_drvdata(pdev);
+
 	component_del(&pdev->dev, &sti_hda_ops);
+	drm_bridge_remove(&hda->bridge);
 }
 
 static const struct of_device_id hda_of_match[] = {

-- 
2.51.0


