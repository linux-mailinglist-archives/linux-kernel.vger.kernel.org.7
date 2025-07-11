Return-Path: <linux-kernel+bounces-726872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 334F0B01249
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0385A814A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFC01A5BA4;
	Fri, 11 Jul 2025 04:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMaov1Fn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296419995E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208374; cv=none; b=oSthziO20T2TmGEQvesdvviefP+LehlcaH3Yujb9GrDgPj4PBbvm8et2G1zFKwYTxznv3baXHQCqpaBKnfXCiTpHBxUKS2Dq8W/Iqe11NANvAzrkkyKFP/Zdt6iDR//SdQlEVh32sqCy+Zjuzf8ItsfYLVCli7Mdy5Ho/bKiulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208374; c=relaxed/simple;
	bh=3QDCqPHPMjOKG75wERMG3gnVgeLbhqq0KjlFSt72mzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TewU7uv4f5SfEFfnGqgauvoTguCieSE7ynibsVY9A9oPgXPTmBm6s7AzNVfp/1pSioY2j8I80Or0DEAawqWiUH/hgFpAKt++FhvlPer4fbTvwVpCgTUERzUAVFU1J9J026S8FPUHdzYRnNfTfyGg7geh5rd4u29jzk3QZR86ACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMaov1Fn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HraXtN+VDBmg8Jr7Ws1Qqx3eC0zBZOgQnBqDsPJqBQo=;
	b=IMaov1FntiIVzus7p3PWkE3APardNarS0FbRFFJ2Ca6Qei/8xOMkpxK83HpqMGqaltJ6Ct
	eCylCCPn1T6pgTSBVBsj2ayXgGLnp4E5XOmB6PDgVST9wRrJ5BmXYqKKE+9jYKkWxELsbA
	W/dpKbxMqjT0mIq8ciVfxLDt8p5Qyvg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-TGjdrrW_N6yKyRUk1hCqQw-1; Fri,
 11 Jul 2025 00:32:48 -0400
X-MC-Unique: TGjdrrW_N6yKyRUk1hCqQw-1
X-Mimecast-MFC-AGG-ID: TGjdrrW_N6yKyRUk1hCqQw_1752208366
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0EDE1956089;
	Fri, 11 Jul 2025 04:32:46 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A3327180045B;
	Fri, 11 Jul 2025 04:32:43 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 10 Jul 2025 23:31:17 -0500
Subject: [PATCH 06/14] drm/panel/lg-sw43408: Use refcounted allocation in
 place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-b4-driver-convert-last-part-july-v1-6-de73ba81b2f5@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752208280; l=1349;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=3QDCqPHPMjOKG75wERMG3gnVgeLbhqq0KjlFSt72mzk=;
 b=G5IhmBlpsZ1SLS/7fDAzeQOm+Jx4AdzwZi0ZTYHQdgUquUhJubClUq4p0zjV/z6ciA/jgpV4O
 TzTQb4PYQ+lDdB4YFAV33wYBG1MFDFsJCCaXOwdKVyT8glRC2Bfp7hA
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index f3dcc39670eae866030e705a30c6cfb2594a70bb..46a56ea92ad9ff3a7e60e0ad0810f4082dbed620 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -246,8 +246,6 @@ static int sw43408_add(struct sw43408_panel *ctx)
 
 	ctx->base.prepare_prev_first = true;
 
-	drm_panel_init(&ctx->base, dev, &sw43408_funcs, DRM_MODE_CONNECTOR_DSI);
-
 	drm_panel_add(&ctx->base);
 	return ret;
 }
@@ -257,9 +255,11 @@ static int sw43408_probe(struct mipi_dsi_device *dsi)
 	struct sw43408_panel *ctx;
 	int ret;
 
-	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	ctx = devm_drm_panel_alloc(&dsi->dev, __typeof(*ctx), base,
+				   &sw43408_funcs, DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
 
 	dsi->mode_flags = MIPI_DSI_MODE_LPM;
 	dsi->format = MIPI_DSI_FMT_RGB888;

-- 
2.48.1


