Return-Path: <linux-kernel+bounces-726877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A69B0125A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA7E97BEC6F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25041DEFDB;
	Fri, 11 Jul 2025 04:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XrI2sa5o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41D1ADC7E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208396; cv=none; b=H3aasze7CeWaaup3PLIVYAT6pkWZccr16FXs0/WW6iAIKER2JjLLVwWF824i7Vdv31nqzp06XpzZE69Ghz7zhn8/5++aEGoOzcBOsXy3OScCuoTOhPfEGIc+62On7rBxSyp0qT6MGZEnZsU+NdLu3ZOSOEXSLoFVH+FQzjtlgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208396; c=relaxed/simple;
	bh=+qytONX5qdNYsbSY96SUao7oslIs6VJcUi2ae56BVbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XOZo4kbVAhYSktCrcr/DZ0MgpjvTFO0XkwLekHoMjUbS2xbj00xcaQaO6HSs9XUN+hAoaw77PLoSIbljePUr8eHDdpIPUX+7lEi1tEL4XhVV8qn6hAFJk48pxqEpIW6c7tInmWEKOytDLmYbo3WzH2tGAYsWw/jVAL1EKy1HXhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XrI2sa5o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XK5bdt887duIlbvqWjutT9zbGbRguv0UFPjU/94wLiI=;
	b=XrI2sa5oI8XzQNHkMOn6SgxMWjhhpNKXOFfY95hMJsnHjsVX2og4BnL0+5l3l0zyaOBHYz
	pmokEBlBsXNdaqlxqg+diAWWAyG86ONBTapVPsBVfSlY8QJ8u6UXPUwrLJw0pLtsLYEnJM
	aQsyEwEu/HNFz4Kg/ExL0pTWlTTf7oE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-OfZ38x9TNE-qZrPbdjthjA-1; Fri,
 11 Jul 2025 00:33:10 -0400
X-MC-Unique: OfZ38x9TNE-qZrPbdjthjA-1
X-Mimecast-MFC-AGG-ID: OfZ38x9TNE-qZrPbdjthjA_1752208388
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDC6F180028A;
	Fri, 11 Jul 2025 04:33:07 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8DE51803AF2;
	Fri, 11 Jul 2025 04:33:04 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 10 Jul 2025 23:31:23 -0500
Subject: [PATCH 12/14] drm/panel/himax-hx83102: Use refcounted allocation
 in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-b4-driver-convert-last-part-july-v1-12-de73ba81b2f5@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752208280; l=1488;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=+qytONX5qdNYsbSY96SUao7oslIs6VJcUi2ae56BVbA=;
 b=YzQp+0zPuATiOdY8n/ZqoUHfDmb0JE/RqAmDPPQNILpZaEZj/Dv+suOONBpeYpzY2RXLcHdhu
 fdHTZ746oDVAwLcEEBTA0/6hvAaqhL1ess1aqqdsI8ow1gLqPAnnYGA
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-himax-hx83102.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 66abfc44e424829e295f5848153d548176b9dda9..4c432d207634d2d976a9e7cb7744b1fefa10420d 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -989,8 +989,6 @@ static int hx83102_panel_add(struct hx83102 *ctx)
 
 	ctx->base.prepare_prev_first = true;
 
-	drm_panel_init(&ctx->base, dev, &hx83102_drm_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
 	err = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (err < 0)
 		return dev_err_probe(dev, err, "failed to get orientation\n");
@@ -1013,9 +1011,11 @@ static int hx83102_probe(struct mipi_dsi_device *dsi)
 	int ret;
 	const struct hx83102_panel_desc *desc;
 
-	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	ctx = devm_drm_panel_alloc(&dsi->dev, __typeof(*ctx), base,
+				   &hx83102_drm_funcs, DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	desc = of_device_get_match_data(&dsi->dev);
 	dsi->lanes = 4;

-- 
2.48.1


