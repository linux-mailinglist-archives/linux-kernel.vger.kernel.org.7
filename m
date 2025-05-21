Return-Path: <linux-kernel+bounces-656762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479C2ABEAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 06:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831D57A6D43
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 04:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C18322DA00;
	Wed, 21 May 2025 04:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyEqXvih"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DF922E3E3
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747800587; cv=none; b=nV65Jc2yFdHQryXgDImgtYHypklbuWJ2yLeAYOzdZigq57qaxfEK/oTH2JlPT1GbD7hMnE1HtdbVW4pr44PpfVLDNWWkIaM+4ZtVJ62j/9iWMDAARN1vCT5ps+Db9gFS2dAJ6BFkv105zgr8hFWhRDHh78ce20vDAs9Ycww8RLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747800587; c=relaxed/simple;
	bh=K3YwSoj4MiCufAEc5brlXoQ1JORQzXdmEv93P+TcP0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nQITA2NBh2bO9Z0VrLOa2xcbdRx5hiAUE9oeHYMDMuHHhosDTbD/bFIQEUJjy0aXI27wwz9kQYXfn0PSGhs4Lh/BlUIwenOy3UpiHMS9tK09q4a+Zd1p7k7Ri1TRhhYs3LKH3N28po/2fuTmwGLUUBvHAO/tHKVCqcTIVz2d32I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FyEqXvih; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747800584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+1bRLuRukIFK2Iowe7ZseK+1jyezOHBOmX9x0wIu0Q=;
	b=FyEqXvihVTwp5zOt5+nryls47hUIwa4WMskUJcBK9YjnjS9pE1qI3rTQFdPifkKFKcLaDC
	NKEc9EzNvY23+k/1GXB+2LXw3Y/8LvXyU6k4+5JfDVCo4AUT8aMrKJZ2xjVYNjOSkKIYZ0
	lVF+WaOawFC2bFmrgmrXV3ZXUgkhwhI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-oMJ5iwy4M0Gb-b9rzpmItw-1; Wed,
 21 May 2025 00:09:37 -0400
X-MC-Unique: oMJ5iwy4M0Gb-b9rzpmItw-1
X-Mimecast-MFC-AGG-ID: oMJ5iwy4M0Gb-b9rzpmItw_1747800575
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A401D1800361;
	Wed, 21 May 2025 04:09:34 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.184])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CE8C1956095;
	Wed, 21 May 2025 04:09:28 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 20 May 2025 22:03:37 -0500
Subject: [PATCH v3 06/30] panel/ilitek-ili9322: Use refcounted allocation
 in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-drivers-mass-convert-part2-v3-6-f7ae7b723c68@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747796667; l=1297;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=K3YwSoj4MiCufAEc5brlXoQ1JORQzXdmEv93P+TcP0M=;
 b=alchfbXnujXrrjcyzc8ZqWooNe3p6Sdn7JLUxxFRCpF0EmzA0RwZlRZEP317gxM/1URzr+exk
 9UYRjXOTbjhBKRk2MSgU25+trzvdqLj4E+iZi3YyCPKA66+sTvNfJIE
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
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
index 94b7dfef3b5e280f02f3127e965e418b6d497c7f..6ed544a83bdd5cf1547847eba39e88cdc5b1e914 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
@@ -722,9 +722,10 @@ static int ili9322_probe(struct spi_device *spi)
 	int ret;
 	int i;
 
-	ili = devm_kzalloc(dev, sizeof(struct ili9322), GFP_KERNEL);
-	if (!ili)
-		return -ENOMEM;
+	ili = devm_drm_panel_alloc(dev, struct ili9322, panel,
+				   &ili9322_drm_funcs, DRM_MODE_CONNECTOR_DPI);
+	if (IS_ERR(ili))
+		return PTR_ERR(ili);
 
 	spi_set_drvdata(spi, ili);
 
@@ -883,9 +884,6 @@ static int ili9322_probe(struct spi_device *spi)
 		ili->input = ili->conf->input;
 	}
 
-	drm_panel_init(&ili->panel, dev, &ili9322_drm_funcs,
-		       DRM_MODE_CONNECTOR_DPI);
-
 	drm_panel_add(&ili->panel);
 
 	return 0;

-- 
2.48.1


