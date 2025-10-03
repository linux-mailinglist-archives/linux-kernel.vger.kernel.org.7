Return-Path: <linux-kernel+bounces-841105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B59BB6469
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E353B0854
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64880280CFA;
	Fri,  3 Oct 2025 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ApqGFf2Q"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C47826F2AD
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482048; cv=none; b=olaJ+jChiirnhH0voMi64iFtoboGVLtKnb4USyJj+i3euaZw3Fj6bERbpl50/xGoAC7JY8McSnSP6CQwnMEE3ZwuAd6seo2GJ2iRVB+41lYGhJB78QHRjKdc7+LNrAjjmPBXWxiyQuJ6v16Y38mhD/1HGsbLfQCNkd+9WOddyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482048; c=relaxed/simple;
	bh=kLoCyULXnAwRMYE7yzuvW8s2/zTfNQjHIgvV1n0Bc38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4CpkTMtF+knFpStQ8tgs7z8FaXhmns/7KZpkZMODQuMhdwRl3YnLkZ98eUhNrb+J+0MpTqUBfe40G98KEyrQrxcMBVqxKDbRfY2hXcai5WIPyU5z9HRtFLPNIEivEKGI6AGwer+eSxbPQ9/gjCm+ct3uL+xTZ4uN1ABlbv0GIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ApqGFf2Q; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E89DFC00D98;
	Fri,  3 Oct 2025 09:00:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7A2E60683;
	Fri,  3 Oct 2025 09:00:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A47D102F1C24;
	Fri,  3 Oct 2025 11:00:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759482043; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=w/wMDW+ORc4IMlsm9YNmK+hs7D2/6cQwBTxkTz703Fk=;
	b=ApqGFf2QVFtIC4jXGJmWPKeuVCliDaErNZgd8yq3fINh2qnqkx+xp8BAksynsjcC3gA78I
	cXZ9b7nadeQQsdKelBS/XHwPsGH3lSdIP4fCLbqDmmBgcNjtpyW85ZMpOdMUplbsaDeUIn
	3H2frNCuAIy3goJy0A9Hu0RQ0cPXVni21TdpkYuoV4EO/8Kc8LIw+T/KZv7PVAuke9x+3Y
	VRu8XKpet9roen1fR5n6MfKwnl0gysfU0I7+k0lXCrr3TtH3o6piOky8CcUl/FXBAlXYPg
	4oqdFegOZabnbiPm8/CbSkifDUXvIguPgX3ol8MJ+Fq3FJflHpqv/udHX/fKgA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 03 Oct 2025 10:59:55 +0200
Subject: [PATCH 1/4] drm/sti: hda: add bridge before attaching
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-1-92fb40d27704@bootlin.com>
References: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-0-92fb40d27704@bootlin.com>
In-Reply-To: <20251003-b4-drm-bridge-alloc-add-before-attach-v1-0-92fb40d27704@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

DRM bridges should be always added to the global bridge list before being
attached.

Link: https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
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


