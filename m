Return-Path: <linux-kernel+bounces-726880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964F8B01250
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED17516DBB6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C861C1E3DED;
	Fri, 11 Jul 2025 04:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xq/Eb8V6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41ED1B0F19
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208401; cv=none; b=qo7YVQ//MzUBSgepHCuucpczQHsz87N3KGK+zmVic1npdwjED/5Eyu6/DrzP2QBWVbvzfYh/b6f+RD/vWoJ5xnzw9i+Pfy1eEXrb5wlDh0q1ZPRphCBiWD55c/FLlzZS5y1u1LOH2nU5GglLIGav9rJDYrx5h6A3TddbBEjGnmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208401; c=relaxed/simple;
	bh=a6ZNYWyy1tj4pWbYzR6Lh3OvSPa78NsH3QPr0ODN52k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AnGo7knpHyLwtqgJPB1jK2UcGimBNmCpJsRBEPrQFI2VQWH6TGavmocuxJ9L3qXCCiZXci+1IOU6rFKt6dSgpxdiSC++rP1XACbAzLv1UrIdNiPvWDhJv0Sk4LWEwQlBi8ziMVLuRNeR5F+SmN1FCk4lwCrLaHveRXUKUDBQv6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xq/Eb8V6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWTeR8/c8og1zZivLTfFMs4guLGelLhrLnAKtFs0Ahg=;
	b=Xq/Eb8V6MscOoMEVVgM21NcXuJrRKGAtnhFiJdVC1GpwCslV0HDj9tuU1Nnin3Yr9r39fj
	3TSBFT/MpzE0YyJSyhZZ1TG1B4iYJoN03A7NhikVaLhQQCbOW904GAwx3+MYkVAWQ6llHu
	n19axk7WszwIVCGsV99LbQgN71ikq4o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-Zgph_v_qP0OODgSQpsK7Tg-1; Fri,
 11 Jul 2025 00:33:13 -0400
X-MC-Unique: Zgph_v_qP0OODgSQpsK7Tg-1
X-Mimecast-MFC-AGG-ID: Zgph_v_qP0OODgSQpsK7Tg_1752208391
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6067718002ED;
	Fri, 11 Jul 2025 04:33:11 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37E5A18002B5;
	Fri, 11 Jul 2025 04:33:08 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 10 Jul 2025 23:31:24 -0500
Subject: [PATCH 13/14] drm/panel/boe-tv101wum-nl6: Use refcounted
 allocation in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-b4-driver-convert-last-part-july-v1-13-de73ba81b2f5@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752208280; l=1515;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=a6ZNYWyy1tj4pWbYzR6Lh3OvSPa78NsH3QPr0ODN52k=;
 b=aaLAXmAYTYPXIf6rYqGtaHTBQU8AWJBRxjzPVIQsvNsueaKycU2N4n5l1Cs7Y0P0ac3dxJC98
 f6YN3atFk7aAuH3Dgxrwe3L15e1LmPkaaiFkiqOqchKro9jSrraiN9c
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 3e5b0d8636d087596aeb3ef0a9feef14157942ca..d5fe105bdbdde5147c5392945928148ebfdf53b5 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1720,8 +1720,6 @@ static int boe_panel_add(struct boe_panel *boe)
 
 	boe->base.prepare_prev_first = true;
 
-	drm_panel_init(&boe->base, dev, &boe_panel_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
 	err = of_drm_get_panel_orientation(dev->of_node, &boe->orientation);
 	if (err < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
@@ -1746,9 +1744,11 @@ static int boe_panel_probe(struct mipi_dsi_device *dsi)
 	int ret;
 	const struct panel_desc *desc;
 
-	boe = devm_kzalloc(&dsi->dev, sizeof(*boe), GFP_KERNEL);
-	if (!boe)
-		return -ENOMEM;
+	boe = devm_drm_panel_alloc(&dsi->dev, __typeof(*boe), base,
+				   &boe_panel_funcs, DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(boe))
+		return PTR_ERR(boe);
 
 	desc = of_device_get_match_data(&dsi->dev);
 	dsi->lanes = desc->lanes;

-- 
2.48.1


