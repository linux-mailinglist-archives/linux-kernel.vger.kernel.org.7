Return-Path: <linux-kernel+bounces-726867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58C4B01232
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D40173A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B827B19995E;
	Fri, 11 Jul 2025 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEahZeNT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CADA17741
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208361; cv=none; b=uo9oteQQvozXiiRyvMEqZk6ahe3jpbxieeLpNYO3uZs0/uo5TVW93DPbD0b9wBzxoU0HEOavJAVzeXzSHDvAgMJHWJ/cXJbaBVzs+vnedLv+bver+Da+fswK7RgmGmYn/YUKs6QTav8U9ZQqdTwDDi4qJvct2Zf/RDdZDD0JR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208361; c=relaxed/simple;
	bh=XwHrhha4r8E5H3/YHzr2brJv4FW0X5k7UgxfvfR1BOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JWaHLPpiuxd7PdwnsGJxSuZ84G5uFmQZReScwZyUyaTn6Iirh0//ylmyfx9lofksqSlfWHsiUM63mADZ8bRAP1JERTomTMXmeMGKxZD5Afdphov6vEWSUcDMDhOeIQBHhmrp6OGaONGEpkT9japrR5NbDA371Pl4V/ZibpiiHUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEahZeNT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/GVtp9qqFjx2/BwC2OA4RCl93BnNwMZ4NEmrKbv4PXE=;
	b=EEahZeNTEVMsVQjyiGL937XRKwcrBWlLJ5ofLLWUXZkOIs9jhWT2m7qfMAEs/RoW7M4TLd
	rjlz7pl7MDuMH1ytkHgHBJJNf2srzqig/Ubg8hwri5AltQVQ1jyORKr2+MTdvu4mW/6D8K
	jhAQVLCS4zMjAszPQzgwjW30PaLX0dc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-IBibMAwsNkqOSTUKh4InfQ-1; Fri,
 11 Jul 2025 00:32:31 -0400
X-MC-Unique: IBibMAwsNkqOSTUKh4InfQ-1
X-Mimecast-MFC-AGG-ID: IBibMAwsNkqOSTUKh4InfQ_1752208349
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2B1619560B2;
	Fri, 11 Jul 2025 04:32:28 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8332D1803AF2;
	Fri, 11 Jul 2025 04:32:24 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 10 Jul 2025 23:31:12 -0500
Subject: [PATCH 01/14] drm/panel/lq101r1sx01: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-b4-driver-convert-last-part-july-v1-1-de73ba81b2f5@redhat.com>
References: <20250710-b4-driver-convert-last-part-july-v1-0-de73ba81b2f5@redhat.com>
In-Reply-To: <20250710-b4-driver-convert-last-part-july-v1-0-de73ba81b2f5@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752208280; l=1551;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=XwHrhha4r8E5H3/YHzr2brJv4FW0X5k7UgxfvfR1BOo=;
 b=a/pFvCxmyNn0BtJAg1K8boxZ9yka4eSHSaPt+BW6l+vMcCWSa0dJP0ICVeIKhXlGl/uNbqufJ
 3kx4yUQ9QaIA4gkN3iTK8IW6CvU9NMuvkZ+l9RijD8/0lJ56QMbtayf
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
index a0d76d588da1a276c5875ad291195d01a0c0495c..d159b0e4fdb6bfb00beb60de660db59ed2c9c566 100644
--- a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
@@ -279,9 +279,6 @@ static int sharp_panel_add(struct sharp_panel *sharp)
 	if (IS_ERR(sharp->supply))
 		return PTR_ERR(sharp->supply);
 
-	drm_panel_init(&sharp->base, &sharp->link1->dev, &sharp_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
-
 	ret = drm_panel_of_backlight(&sharp->base);
 	if (ret)
 		return ret;
@@ -323,10 +320,12 @@ static int sharp_panel_probe(struct mipi_dsi_device *dsi)
 
 	/* register a panel for only the DSI-LINK1 interface */
 	if (secondary) {
-		sharp = devm_kzalloc(&dsi->dev, sizeof(*sharp), GFP_KERNEL);
-		if (!sharp) {
+		sharp = devm_drm_panel_alloc(&dsi->dev, __typeof(*sharp), base,
+					     &sharp_panel_funcs,
+					     DRM_MODE_CONNECTOR_DSI);
+		if (IS_ERR(sharp)) {
 			put_device(&secondary->dev);
-			return -ENOMEM;
+			return PTR_ERR(sharp);
 		}
 
 		mipi_dsi_set_drvdata(dsi, sharp);

-- 
2.48.1


