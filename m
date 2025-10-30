Return-Path: <linux-kernel+bounces-877956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842CEC1F6C8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8A6188624E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6277B35471A;
	Thu, 30 Oct 2025 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acvD+kYi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2169635471E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818457; cv=none; b=Dobtz3WtgulonZMGskX3aR21cYbyrlbb1eYCvz2O6RIhxDPfeRxAmGZoGOHHxqDvVvg04tKA7boWq6XxIvXiUfY7iBrttLNmP0N6prkYJiiHAQo6xWYqxrgYdedbD1ozbygrs/H5T8gW/I9jw9HV9skLqgt0hRzx9ncDG+XOsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818457; c=relaxed/simple;
	bh=xQ1lYSHf+GNmGHyMRgKB4DBH9TrAv2qVEC7ZcroqfzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bT7pPcRzSowdcWn8o3qk2Uwz0gLOBffj2oWEHwxdHBP8wMYlwmayXRzUeVs1t6tUaGzfDdBRWWW0acRyFt2MFAch7yKFqvhJ3sgopIWDEndh2IESWsGsUOuyDf1GV3vIIz1u76ajIvOVlMM66z2VjysEZSvG9yhfrXi96+V3OI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=acvD+kYi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761818455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skp2OXbmR+VaOe/XG8U+Ipz6owhljMasvW5yY7eZShE=;
	b=acvD+kYi+YB2KAhS1WlXA2tIVVcCdFjIuoFqe1Bl9luWjcqXAov6430W5D8Qm7UBJ9aurB
	toxYQ7WSplOfYC2VAc6GH6aUKY4OT2HU+ckQDZnO6EjuJrwvlkb/nLTuWunWgJzUeMhpOm
	h4ZKAjkpgF5Qq0Ew7ORxD9F3vzPMVgs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-yjzekU1gNnOEgUxqdWnyxw-1; Thu,
 30 Oct 2025 06:00:51 -0400
X-MC-Unique: yjzekU1gNnOEgUxqdWnyxw-1
X-Mimecast-MFC-AGG-ID: yjzekU1gNnOEgUxqdWnyxw_1761818451
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D22E6180AD46;
	Thu, 30 Oct 2025 10:00:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D3E219560A2;
	Thu, 30 Oct 2025 10:00:46 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	jasowang@redhat.com,
	Cindy Lu <lulu@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/6] vduse: refactor vdpa_dev_add for goto err handling
Date: Thu, 30 Oct 2025 11:00:23 +0100
Message-ID: <20251030100025.95113-5-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-1-eperezma@redhat.com>
References: <20251030100025.95113-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Next patches introduce more error paths in this function.  Refactor it
so they can be accomodated through gotos.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v6: New in v6.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index b01f55a1c22d..97be04f73fbf 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2172,21 +2172,27 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 						  dev->bounce_size);
 	mutex_unlock(&dev->domain_lock);
 	if (!dev->domain) {
-		put_device(&dev->vdev->vdpa.dev);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto domain_err;
 	}
 
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
 	if (ret) {
-		put_device(&dev->vdev->vdpa.dev);
-		mutex_lock(&dev->domain_lock);
-		vduse_domain_destroy(dev->domain);
-		dev->domain = NULL;
-		mutex_unlock(&dev->domain_lock);
-		return ret;
+		goto register_err;
 	}
 
 	return 0;
+
+register_err:
+	mutex_lock(&dev->domain_lock);
+	vduse_domain_destroy(dev->domain);
+	dev->domain = NULL;
+	mutex_unlock(&dev->domain_lock);
+
+domain_err:
+	put_device(&dev->vdev->vdpa.dev);
+
+	return ret;
 }
 
 static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
-- 
2.51.0


