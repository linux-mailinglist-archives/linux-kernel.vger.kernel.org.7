Return-Path: <linux-kernel+bounces-836575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F727BAA0DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD9F3C756A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D570B30DD16;
	Mon, 29 Sep 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNgc/GsS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177430DD0A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759164774; cv=none; b=PfITEwHA8Hwwuc8+CG6Jn5i8xaxPcCxBun32Ej66ZgNlRUpIZJSDKFFZc0cqYV7j14XOiHInlw0cflKoXXMCO+Q63Rf3QhmwXxmMclv+6s1r3Sr5efMvoWtb97C3RgLFGUVkxVPcZsQqJm5tuL0tdAUZsz3rDt7KGXGvkTQ/HS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759164774; c=relaxed/simple;
	bh=K4ASnwZprwTFcGZE3ZLOBGvFlyTGftRQZSnSLFGOWnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oq7fAX3BjvJQ4KwEj9+Xw0Gw8FST3pUH5dRT4we2xB2skhN8WY4Kt4VwMjgb9ehUvV6VwWI3MhmIE4V4phXJ3nzC4Wq6GORi7TD28g8bPxHDGxyeRcxciq9JBblK90UL6leX9gOLPJMRJkZN/jGQmO7eQ+1Y94K6lkRKvR81dw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNgc/GsS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759164771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRHRYri8X5KVjX4QxDJz0RoUB2f1AcZ23dBEU2WTFDo=;
	b=RNgc/GsS7uCWJMViN9gHMjFowPIuVYtWfGLzyOI648v8NF2VWYZXmvw43DCbT95gMQdtb7
	DT24IwWOSbunzIHakgzxMd8VtojogQh1CMIICvZ/dB2bVD69VkNc4z8bAcCrUHLFaAmgV4
	BrLzcWSvVXX58I0Osx3z03P+CZPVW+g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-lpprqX8mPxCEVnflDd_tKQ-1; Mon,
 29 Sep 2025 12:52:44 -0400
X-MC-Unique: lpprqX8mPxCEVnflDd_tKQ-1
X-Mimecast-MFC-AGG-ID: lpprqX8mPxCEVnflDd_tKQ_1759164763
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E8051944F01;
	Mon, 29 Sep 2025 16:52:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.47])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80C8F30003BB;
	Mon, 29 Sep 2025 16:52:36 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	jasowang@redhat.com,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH v6 5/7] vduse: refactor vdpa_dev_add for goto err handling
Date: Mon, 29 Sep 2025 18:52:11 +0200
Message-ID: <20250929165213.2896034-6-eperezma@redhat.com>
In-Reply-To: <20250929165213.2896034-1-eperezma@redhat.com>
References: <20250929165213.2896034-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Next patches introduce more error paths in this function.  Refactor it
so they can be accomodated through gotos.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v6: New in v6.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 923330da9bef..0ce7f40b84fa 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2173,21 +2173,27 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 						  dev->bounce_size);
 	write_unlock(&dev->domain_lock);
 	if (!dev->domain) {
-		put_device(&dev->vdev->vdpa.dev);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto domain_err;
 	}
 
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
 	if (ret) {
-		put_device(&dev->vdev->vdpa.dev);
-		write_lock(&dev->domain_lock);
-		vduse_domain_destroy(dev->domain);
-		dev->domain = NULL;
-		write_unlock(&dev->domain_lock);
-		return ret;
+		goto register_err;
 	}
 
 	return 0;
+
+register_err:
+	write_lock(&dev->domain_lock);
+	vduse_domain_destroy(dev->domain);
+	dev->domain = NULL;
+	write_unlock(&dev->domain_lock);
+
+domain_err:
+	put_device(&dev->vdev->vdpa.dev);
+
+	return ret;
 }
 
 static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
-- 
2.51.0


