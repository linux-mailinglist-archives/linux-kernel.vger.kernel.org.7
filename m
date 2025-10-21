Return-Path: <linux-kernel+bounces-863697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B93EEBF8DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0243AE4D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA8027A12B;
	Tue, 21 Oct 2025 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="neaVNvmC"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1F31FA178
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080485; cv=none; b=pUFUf0H2VEXuUkqqPwaOu/haK4YBP9pDZMAEZc99kVKfc5Y3b5xYRn/xsyO3oGwpnDWoTmTRjWZ1z0CKckhbPumDHTdXsaVAmjNUDbobPTKhZoZkuOKgy5FIOHezPolCPddDl8i/01uvaHa1dXxZseCEJ/datrox+a6unheNiK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080485; c=relaxed/simple;
	bh=GukjzdhrNSwMkpDtdNr9biLEjMNTzBdyrnCWtzsvraM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbL0tmnecFWBQ5kG23kgk/G/v56cApxqbDw1fQdV1+IA/zV0pWmjd/fGUkk3MVDlxwh78lou49Br4SAI/Iwe2WUdxcg6TyNOD0NbxiUQ317eD2fAaKap+U3UJo5MiOU6Vpzarr6x206P0oYqmK6yJRXEiphlLuEs67ad8NAwle4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=neaVNvmC; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 65C2AC0B8A3;
	Tue, 21 Oct 2025 21:01:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1AAE260680;
	Tue, 21 Oct 2025 21:01:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F249102F2416;
	Tue, 21 Oct 2025 23:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761080479; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=b0w3PlRCn8AXDASJDWQBx6mglmsv4W7JDgIPcOEiCNo=;
	b=neaVNvmCD5ETz7+fvroOyps0QsXqsLCHCndlM86FhF/RRbvG+D53Yt6u3iIq98RJjIhnG0
	/aeTCkZuMq4NvdVQ5IxCFdJ4GLO/VU0JHVFAn+cPEliuAS9T8SJTj25CAtnrgwdt6eqfGg
	u5GUN6saY0UFl0BsU4GIpsmibG3yGn2iVudAYSfuMD0p95UkLmfwfjQdfMH8Ht+uCJddUt
	Jez1MpR3LvO57fW8zT24+R1jXIR7qrdwXApa1CEkQwVXYGmkX/uB53A8m+icBAAe1QEyvv
	uCgAIiCadrKK2JpfpdK2T8Xwzu8rQtJk10gTLsO+o66GglB969aDfYCHAI4+hw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 21 Oct 2025 23:00:44 +0200
Subject: [PATCH v2 1/5] drm/sti: hda: add bridge before attaching
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-drm-bridge-alloc-add-before-attach-v2-1-c17cc1bbff72@bootlin.com>
References: <20251021-b4-drm-bridge-alloc-add-before-attach-v2-0-c17cc1bbff72@bootlin.com>
In-Reply-To: <20251021-b4-drm-bridge-alloc-add-before-attach-v2-0-c17cc1bbff72@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

DRM bridges should be always added to the global bridge list before being
attached.

Link: https://lore.kernel.org/all/20250709-sophisticated-loon-of-rain-6ccdd8@houat/
Acked-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
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


