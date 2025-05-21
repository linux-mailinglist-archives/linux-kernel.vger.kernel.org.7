Return-Path: <linux-kernel+bounces-656783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B5FABEACE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 06:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F461BA3A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 04:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CB5231849;
	Wed, 21 May 2025 04:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLVECBKV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED1022F3A8
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 04:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800699; cv=none; b=h3ULnSg7EVtCFBTZ5PkyL0dA6c393AjZKIuDZoQNp4m1lHzq+BF7z5YTc5w92UQBetOk9u+UUiNmoyu8ytYdgT3oHDIXnr0UpdpCr3FiuoWpkk1KSbL4cq0HNEh5RAv4eBiYPNVIz05uLS4iqhs0IQ68qIXeHXrhVtgi+GHTz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800699; c=relaxed/simple;
	bh=tf+dpHrX0zZW8IBXm+99Ul8HeuGpSrsFRL1YM0ceWIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qpQfoa2uUIWLhN6e/bmYtS4t+Vyv4L/ZhJWNXe+qMVxGnMKAbrugawToXzjOKH5MNTt5L/JO2CYtdBMLq7BTmPNy+QsZ+trluxmZ0CpD++AuWjsX4LzedJbBQkKI5mLUZmcLrQvbGBAamAR9KhnKep73MSPkR2WEvpsp/ECXZh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLVECBKV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747800697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31siUvGKFeQUvfWKZYsz5RRkJbynL6zodiKjVJATUHE=;
	b=TLVECBKVlqGTtiTzvlwOamHzRp4yAsZ8yc+92XXvSNkf/glBXGt61On7OrMUdpa8xqaAwg
	08W/at3/DbRSdg3X47ZKr1s+BGIckrIal+cxL15FzYNoh7u71iXgONLK/NOeWRk30pdUPx
	QbFsBRwpxg3zf8gUyimU1KKoxD9CEwc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-F-C2BPSTOqyBCyLC7BQ7xw-1; Wed,
 21 May 2025 00:11:32 -0400
X-MC-Unique: F-C2BPSTOqyBCyLC7BQ7xw-1
X-Mimecast-MFC-AGG-ID: F-C2BPSTOqyBCyLC7BQ7xw_1747800690
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 339EE1800446;
	Wed, 21 May 2025 04:11:30 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.184])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D554B195608F;
	Wed, 21 May 2025 04:11:24 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 20 May 2025 22:03:56 -0500
Subject: [PATCH v3 25/30] panel/novatek-nt35950: Use refcounted allocation
 in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-drivers-mass-convert-part2-v3-25-f7ae7b723c68@redhat.com>
References: <20250520-drivers-mass-convert-part2-v3-0-f7ae7b723c68@redhat.com>
In-Reply-To: <20250520-drivers-mass-convert-part2-v3-0-f7ae7b723c68@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747796667; l=1422;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=tf+dpHrX0zZW8IBXm+99Ul8HeuGpSrsFRL1YM0ceWIw=;
 b=joCFOC1kyHiTqok5E+8fzEBBRQCDYndIC8fOCpLbaJsZHhUn+fgFWpGnclIXrexrCNrk59EPK
 2cWAqYXbz66DuBi6UIxdwSwy0hwxFe3Ny8ers0SJUJNZkHFJx/3wDym
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move to using the new API devm_drm_panel_alloc() to allocate the
panel.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
v3: none.
v2: none.
---
 drivers/gpu/drm/panel/panel-novatek-nt35950.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index 08b22b592ab0452973aa7373dd0692a9bf98e5f2..94aa6489d99fc88f1602c4dbbf4f7f78c04799a9 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -449,9 +449,10 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 	const struct mipi_dsi_device_info *info;
 	int i, num_dsis = 1, ret;
 
-	nt = devm_kzalloc(dev, sizeof(*nt), GFP_KERNEL);
-	if (!nt)
-		return -ENOMEM;
+	nt = devm_drm_panel_alloc(dev, struct nt35950, panel, &nt35950_panel_funcs,
+				  DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(nt))
+		return PTR_ERR(nt);
 
 	ret = nt35950_sharp_init_vregs(nt, dev);
 	if (ret)
@@ -491,9 +492,6 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 	nt->dsi[0] = dsi;
 	mipi_dsi_set_drvdata(dsi, nt);
 
-	drm_panel_init(&nt->panel, dev, &nt35950_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
-
 	ret = drm_panel_of_backlight(&nt->panel);
 	if (ret) {
 		if (num_dsis == 2)

-- 
2.48.1


