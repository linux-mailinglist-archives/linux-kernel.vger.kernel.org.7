Return-Path: <linux-kernel+bounces-578675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1885A73519
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 15:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645081896027
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA7218AC4;
	Thu, 27 Mar 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gP6garJY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39802192F1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087362; cv=none; b=nUwiSIZs0ZA2mBm8lT8mXWaQIReDeL3ZgWDCYbLu5EBjfWgdr3ATPDS9yFZ4Vu2jrBySpGAaXL4CqDREKkmzt2QuY84LbE1Q+aQkWYPhkeLE09m+AmIML2+5VRQsb0ZKl+qIBH7xlfaru0AsVWKqXf+MHtopJcpuLUXMdjunNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087362; c=relaxed/simple;
	bh=DTLMFbg++BMWEnIPepyoWDQ8F0fwoBTbjBSbA4s7hXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFxnvSETI+d6d8/OKZbgazhQk3Joxqr8teSXIyfuO4SDZGwfQOnoEIrc6zpEYFbdIeScpvns8VvpOUj9hemqsAdvKZh4dTa2zauQfwI1eIIKUnvq3HXRlo102PHcgDrH9UlCIupdaVdWLj9BxxuYu/+LY20G7254r19Z8GU493Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gP6garJY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743087359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJDVt8F5H/p9yTGiLHlDGk02rYV7TueWY9zNYRaidl8=;
	b=gP6garJYas0xEQBbH7inq+jqGlRFM8XpAmxuVpxuJKVvNfQ17ymzPwf4SkRAqSiuoiTzWi
	6jvF8iGQLzdhQMttvNccyX7EfWHUuGdQ8d02aCwb0T5TZR+2+la/rMTQCQdZMjeky4694Q
	GLMwr2kKRASLRHwilAAJdzrruiUw6z0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-0rZXLvuBO024IfHsALPs4g-1; Thu,
 27 Mar 2025 10:55:56 -0400
X-MC-Unique: 0rZXLvuBO024IfHsALPs4g-1
X-Mimecast-MFC-AGG-ID: 0rZXLvuBO024IfHsALPs4g_1743087354
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E50C1933B50;
	Thu, 27 Mar 2025 14:55:54 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4384F180A803;
	Thu, 27 Mar 2025 14:55:52 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 27 Mar 2025 10:55:41 -0400
Subject: [PATCH v2 3/4] drm/panel: deprecate old-style panel allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-panel-refcounting-v2-3-b5f5ca551f95@redhat.com>
References: <20250327-b4-panel-refcounting-v2-0-b5f5ca551f95@redhat.com>
In-Reply-To: <20250327-b4-panel-refcounting-v2-0-b5f5ca551f95@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743087343; l=1111;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=DTLMFbg++BMWEnIPepyoWDQ8F0fwoBTbjBSbA4s7hXM=;
 b=dr9PeVObTbBys6usrLAjoFfmTQRBf0OvAyNX57GehYEYIugAXZ/L+K2NUNQFRkcVepeBGWyF5
 3lAUvTy6LMXAP4sqdBuyUxJ9sUxOPSZ65/Srlf8JGpy2w84idk6EIgC
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Start moving to the new refcounted allocations using
the new API devm_drm_panel_alloc(). Deprecate any other
allocation.

v2: make the documentation changes in v1 more precise (Maxime)

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 drivers/gpu/drm/drm_panel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 7b17531d85a4dc3031709919564d2e4d8332f748..870bf8d471ee9c5fe65d88acc13661cacd883b9b 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -74,8 +74,9 @@ EXPORT_SYMBOL(drm_panel_init);
  * drm_panel_add - add a panel to the global registry
  * @panel: panel to add
  *
- * Add a panel to the global registry so that it can be looked up by display
- * drivers.
+ * Add a panel to the global registry so that it can be looked
+ * up by display drivers. The panel to be added must have been
+ * allocated by devm_drm_panel_alloc().
  */
 void drm_panel_add(struct drm_panel *panel)
 {

-- 
2.48.1


