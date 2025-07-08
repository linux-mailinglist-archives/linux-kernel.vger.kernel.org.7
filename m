Return-Path: <linux-kernel+bounces-722352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEE1AFD881
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628FC7AAE5B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9302459DA;
	Tue,  8 Jul 2025 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrR4hMbQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2734245005
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007001; cv=none; b=r+fB7l9aemplKbMMUpHWm1idt+vmoibH9g0JqN63aTmyU+dHO20u5irfOZQuNaueu2As6tn4eSqH2QBtZxHWYg3rTJFZUkhhOgjJuqP1j7NQvq6hDbwfhAiY9RgXG7V2XetIbbSPEjxIiCDQawy5J9n9r72G7a14kcrgLePOaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007001; c=relaxed/simple;
	bh=r+5IsdI+ou/klTuFsHCu6OuxmANNm4TybvesnM4JDXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/zejy/uLBIRjAy2t+Jx+gd+g6Q+cVH0rGSBeeUUzZV+29MrRd2F514EOe2yOFJGdplA+Rh5RkK9n/4YU+/mUA8ey21Y0ZM7HId0hne7IOBkOVn7hwgYsH83Eo5zOUo4I0Kc/74ADbC5UzphMljDdMs0dRPgKRkkNQ0yFPbEz1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrR4hMbQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752006997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8CFgRsZpDBgxdaDDbGMyD49MIsNUDbVmGlc40tJ3tQ=;
	b=LrR4hMbQ2/HKDOAvM7pV06NhW0fHGhZrg5A57URAdRjZZ8bpu0a0OHJe+mH6l970czVGeH
	gkyUeOkTMhPeG+S7tYjUe+2ScQwBWm9sVLjSlmeMkXv5w5a5COYr3FtxxczTUXYk3O98F9
	EcXC4WsJoS2NETgh7CX9Gw2Wc2KaE3o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-ryCKaWxxOLidmqhsYnD2-w-1; Tue,
 08 Jul 2025 16:36:34 -0400
X-MC-Unique: ryCKaWxxOLidmqhsYnD2-w-1
X-Mimecast-MFC-AGG-ID: ryCKaWxxOLidmqhsYnD2-w_1752006992
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42BD01809CA6;
	Tue,  8 Jul 2025 20:36:32 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.132])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B5EC91956087;
	Tue,  8 Jul 2025 20:36:29 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 08 Jul 2025 15:35:16 -0500
Subject: [PATCH 4/6] drm/panel/kd070fhfid015: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-simple-panel-api-convert-july-v1-4-630902123ea1@redhat.com>
References: <20250708-b4-simple-panel-api-convert-july-v1-0-630902123ea1@redhat.com>
In-Reply-To: <20250708-b4-simple-panel-api-convert-july-v1-0-630902123ea1@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752006919; l=1436;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=r+5IsdI+ou/klTuFsHCu6OuxmANNm4TybvesnM4JDXY=;
 b=qqF4IszpWLZIFDnLCNDDTOs4qvmxX/1iT3LrmFTC4pNcooOCU+C+3gtiyB2zr2ay4SG62nOIJ
 bNcR6zCnTkmD2f118pqBBriPN9bV4tGIKHhWPfH0N3p3aQ1PNGMTUlo
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
index c0c95355b74350843d5703f1779d88b04f4337f5..e3d53939ce76a29966b99f18ca54dc16790200de 100644
--- a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
+++ b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
@@ -286,9 +286,6 @@ static int stk_panel_add(struct stk_panel *stk)
 		return ret;
 	}
 
-	drm_panel_init(&stk->base, &stk->dsi->dev, &stk_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
-
 	drm_panel_add(&stk->base);
 
 	return 0;
@@ -303,9 +300,12 @@ static int stk_panel_probe(struct mipi_dsi_device *dsi)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = (MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM);
 
-	stk = devm_kzalloc(&dsi->dev, sizeof(*stk), GFP_KERNEL);
-	if (!stk)
-		return -ENOMEM;
+	stk = devm_drm_panel_alloc(&dsi->dev, __typeof(*stk), base,
+				   &stk_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(stk))
+		return PTR_ERR(stk);
 
 	mipi_dsi_set_drvdata(dsi, stk);
 

-- 
2.48.1


