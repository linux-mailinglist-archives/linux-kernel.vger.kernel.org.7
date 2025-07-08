Return-Path: <linux-kernel+bounces-722353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6054AFD882
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52884E0FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C9B246326;
	Tue,  8 Jul 2025 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQTobk9A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E53E241669
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007002; cv=none; b=UhNA/KEEDxg3rGVpK4aVUvDYg/00YZLT51OQfjg5QNs53kondAsYNbn5RQqB34Sk4bWaLhB/CPOqreQr2UoDUA+++CvXaoFYg86GuTrKofozI4/P/N86VsZGkviI1zp+abrfuXou+qFwTF3TJY8hQckGZ7UWJ9v9+ZAdf2unee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007002; c=relaxed/simple;
	bh=xdrj7D4K0zwX0MxASwv1463YcBB8SlyKXurFNGfsjs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=frABuEwW7nK7j2WOFANgvXXGRURLooLddK/24Va6/zEV8OFEFY1u83Q+iczzZ8sq5ghDzkiyioMI/2YfCemkU0684m7dVf42U8mSMSSObYOnnjHftQ4cQI8ftuZekJ6l9DX355RStbhV8ZcWMd6wOU+4LQm+HnomJgedNHL3Adw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQTobk9A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752006999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hsqKeqpYAxulUJGdQCQDGq8VNbR9vrXGCShBK6ozhd4=;
	b=UQTobk9A7Aa+dE4LqomHACw1VNN1ABmNkPnqn1yDYuNx1KFn+QiFSJYF945VmxqOibmyHC
	sKvqakSc0g7ka/OXhmoyyqEs0ZpdZKUmdNdf/k240Cgbt3r4AxHK0rHUtmtqOYwZZOS5bc
	byQChknsSNL2URGul8+lIx6D7AisVUs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-WLycki1_PQWZ2WrqS0k7Nw-1; Tue,
 08 Jul 2025 16:36:38 -0400
X-MC-Unique: WLycki1_PQWZ2WrqS0k7Nw-1
X-Mimecast-MFC-AGG-ID: WLycki1_PQWZ2WrqS0k7Nw_1752006996
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55085190FBC6;
	Tue,  8 Jul 2025 20:36:36 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.132])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 960BC1956087;
	Tue,  8 Jul 2025 20:36:32 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 08 Jul 2025 15:35:17 -0500
Subject: [PATCH 5/6] drm/panel/ls043t1le01: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-b4-simple-panel-api-convert-july-v1-5-630902123ea1@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752006919; l=1523;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=xdrj7D4K0zwX0MxASwv1463YcBB8SlyKXurFNGfsjs0=;
 b=2lJhWZIB0GOmW1MvkuWHqOzTQPsDNQ7t3WddX3KbqRaEyok17CqJzO4xP0yPMDxcGtzb6lA+c
 +jtU/ORZs3dC/WH0MGSAGfhct96yK4FgMsQ1iIRWjk235T5Z4AFnpJ0
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index 36abfa2e65e962af2a08aec3e63ba1077a2c43d4..610f37b844c2d1318ca876385d00f50a3e5410d6 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -199,9 +199,6 @@ static int sharp_nt_panel_add(struct sharp_nt_panel *sharp_nt)
 		gpiod_set_value(sharp_nt->reset_gpio, 0);
 	}
 
-	drm_panel_init(&sharp_nt->base, &sharp_nt->dsi->dev,
-		       &sharp_nt_panel_funcs, DRM_MODE_CONNECTOR_DSI);
-
 	ret = drm_panel_of_backlight(&sharp_nt->base);
 	if (ret)
 		return ret;
@@ -230,9 +227,12 @@ static int sharp_nt_panel_probe(struct mipi_dsi_device *dsi)
 			MIPI_DSI_CLOCK_NON_CONTINUOUS |
 			MIPI_DSI_MODE_NO_EOT_PACKET;
 
-	sharp_nt = devm_kzalloc(&dsi->dev, sizeof(*sharp_nt), GFP_KERNEL);
-	if (!sharp_nt)
-		return -ENOMEM;
+	sharp_nt = devm_drm_panel_alloc(&dsi->dev, __typeof(*sharp_nt), base,
+					&sharp_nt_panel_funcs,
+					DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(sharp_nt))
+		return PTR_ERR(sharp_nt);
 
 	mipi_dsi_set_drvdata(dsi, sharp_nt);
 

-- 
2.48.1


