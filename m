Return-Path: <linux-kernel+bounces-637515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 720A0AADA28
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 10:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E43982E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583C9221D94;
	Wed,  7 May 2025 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiscVOSE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6A221708
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746606513; cv=none; b=Ec0G6rRE82lkxVqyar6zzg+7JKYpE6tK30RH0kFMd/DuHtPxkgkSIFHbk7nyy1yBaKoDoDeJMOoMcEEso5PG+7dTGA2yfUK1xUolCq8v3KK2PsP9gS80K+/2D8hkjas9fINSGcTB4hniLRpNDxjHHL0Vi5kxAOXX5DWThK+U4V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746606513; c=relaxed/simple;
	bh=LQLDtHyEMv6WC5tvlSF6xAtjEa1TBJ6NL16bqwQ1zBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhJZ0KftbJSckFrKUSu0lFT3y24QaJ2s+s/Dn5URCU4F+H2Rz97vtBGSQbvZUhkGZ48truPPQHGSM6eBJwNob+r9KPuXSSfXY7tQq/wAJ5+Hmv3YffV2luLIBlWjk8oEDT5HULIyiYIPYKrHPF6NlVM8qiDm1dDYCe1tVT/dhUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiscVOSE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746606511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VxMpeAEp5/qbopqS26YNMKfIvvwVGQ66Rj7oYRD3BHo=;
	b=UiscVOSEf0aNJIri7oSEsaymd54y+S/GOjOOuY9/5Yz0WhhYp/fAaYeK//gaFdAOEZpw3i
	YbOIIKuJZQcCx7Ksvom4EEJNfDyqqv/YpUlLcUClU6Bficdw+wOH08LpnqmcUOIPHEDhcG
	BWbtAncpcx239TOg/6gktX+f0JhRPqA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-CuZZ52rhOlqxuf7sqjYhSA-1; Wed,
 07 May 2025 04:28:27 -0400
X-MC-Unique: CuZZ52rhOlqxuf7sqjYhSA-1
X-Mimecast-MFC-AGG-ID: CuZZ52rhOlqxuf7sqjYhSA_1746606506
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D61E0180045C;
	Wed,  7 May 2025 08:28:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.80])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7A4D19560AA;
	Wed,  7 May 2025 08:28:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 6EDA318000B2; Wed, 07 May 2025 10:28:21 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	virtualization@lists.linux.dev (open list:VIRTIO GPU DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/virtio: implement virtio_gpu_shutdown
Date: Wed,  7 May 2025 10:28:21 +0200
Message-ID: <20250507082821.2710706-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Calling drm_dev_unplug() is the drm way to say the device
is gone and can not be accessed any more.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index e32e680c7197..71c6ccad4b99 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -130,10 +130,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
 
 static void virtio_gpu_shutdown(struct virtio_device *vdev)
 {
-	/*
-	 * drm does its own synchronization on shutdown.
-	 * Do nothing here, opt out of device reset.
-	 */
+	struct drm_device *dev = vdev->priv;
+
+	/* stop talking to the device */
+	drm_dev_unplug(dev);
 }
 
 static void virtio_gpu_config_changed(struct virtio_device *vdev)
-- 
2.49.0


