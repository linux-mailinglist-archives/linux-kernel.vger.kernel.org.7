Return-Path: <linux-kernel+bounces-726878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FFEB01259
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB487BECA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E551C3BFC;
	Fri, 11 Jul 2025 04:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbFgfUPz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4751B0F19
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208396; cv=none; b=m0qIvGUJnBWGu1s7aiW7r1+YlhnegfgD+ih6ABWXps1/DKrjtWsK9WDG9ON9HIVqh/TkP3xMwup/xOenu9lu1BHNvOKTIUlKxJjsYCRXrzrAciIrKur4LaiUcEYev0izkoVfhQVfzT5eXpEXthL0mL6Ja1L4JJP2FkYOBwCHrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208396; c=relaxed/simple;
	bh=ER59UgY9l+Va6Huh6S5CvMkkT0Jw8llNaQIZnUo8YOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hmLqMu6Ukfq2mnLfpbSV0atpmIEUVH0txnzrKSl55GlhuAyQPuaHE47B/QiHuSXG17Zi3hLZ4RebSyvwQTnN60hyi4kE0CtggjPgeSBiyEUx07IqKUlyLKvgJ7yoa9g5nYIhNJ+6wsEm+ctkJ1lJTIABST5BNC1PtMSjm1usHUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbFgfUPz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0Er8YEXgRdZGHwdl+getdRWRYoVoI6fUW/7CIKivU4=;
	b=PbFgfUPzwWiufISKsYMWrphknGnpq3US2fUZaihtNsjhgLbMIfcz+7z5Lx7XL99/JIEzuf
	EuhGJhma85iazP83SMh2JSSG1TWt9Q+Rtacw4acCJnmxnZ8ev3S65oefO64E4mUpGwfbkO
	LVGl4jLoraQcj95qb9V6N1EkpltDxM4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-TLdhagfXPXSozx3EaBeDTw-1; Fri,
 11 Jul 2025 00:33:07 -0400
X-MC-Unique: TLdhagfXPXSozx3EaBeDTw-1
X-Mimecast-MFC-AGG-ID: TLdhagfXPXSozx3EaBeDTw_1752208385
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AA05195608F;
	Fri, 11 Jul 2025 04:33:04 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.240])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2424180045B;
	Fri, 11 Jul 2025 04:33:00 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 10 Jul 2025 23:31:22 -0500
Subject: [PATCH 11/14] drm/panel/ilitek-ili9882t: Use refcounted allocation
 in place of devm_kzalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-b4-driver-convert-last-part-july-v1-11-de73ba81b2f5@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752208280; l=1502;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=ER59UgY9l+Va6Huh6S5CvMkkT0Jw8llNaQIZnUo8YOI=;
 b=Cvmd7LAzRjijgyydkXPVnN1V2KnrGh6nDgari7Hd+b92Ziq83sjvKn1LqkIk0HOYwW4KQlVGL
 b3Wzlw4dpJ5Br2q1XF5rekSpMnGNHHMsQ5P9sepjuPv/WjMeoCqbT5Q
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move to using the new API devm_drm_panel_alloc() to allocate the
panel. In the call to the new API, avoid using explicit type and use
__typeof() for more type safety.

Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 3c24a63b6be8c710a1b7f3524b537d3cb6fc63d3..85c7059be214e722e795e3a55420a32fcfee2e4f 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -614,8 +614,6 @@ static int ili9882t_add(struct ili9882t *ili)
 
 	gpiod_set_value(ili->enable_gpio, 0);
 
-	drm_panel_init(&ili->base, dev, &ili9882t_funcs,
-		       DRM_MODE_CONNECTOR_DSI);
 	err = of_drm_get_panel_orientation(dev->of_node, &ili->orientation);
 	if (err < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
@@ -640,9 +638,11 @@ static int ili9882t_probe(struct mipi_dsi_device *dsi)
 	int ret;
 	const struct panel_desc *desc;
 
-	ili = devm_kzalloc(&dsi->dev, sizeof(*ili), GFP_KERNEL);
-	if (!ili)
-		return -ENOMEM;
+	ili = devm_drm_panel_alloc(&dsi->dev, __typeof(*ili), base,
+				   &ili9882t_funcs, DRM_MODE_CONNECTOR_DSI);
+
+	if (IS_ERR(ili))
+		return PTR_ERR(ili);
 
 	desc = of_device_get_match_data(&dsi->dev);
 	dsi->lanes = desc->lanes;

-- 
2.48.1


