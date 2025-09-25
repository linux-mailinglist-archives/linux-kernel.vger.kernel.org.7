Return-Path: <linux-kernel+bounces-832062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4498BB9E412
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C95384641
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A72F2EB5B5;
	Thu, 25 Sep 2025 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlGrJ+p1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C02EB5B2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791653; cv=none; b=cLDJfFhFvhBSyU2n1SCulOf3UFjEptQkpvqYiF1JwUnGwC8b+CRDSun4y/ZGN7QLhHzynGbGv1J6Vd/IJvhsKWfIYXP5t2IYBdZDPdKp9t9Jartl9XXgwGLnNimwPnIeeHvz7eSDDb9EFcfASarGHEAH5nWpAik8MSjR7mDajgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791653; c=relaxed/simple;
	bh=dhAvVfijdadFzcvvMQkMrLMToA6mRc1iW9Alz5EVGW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7dpqSGckKkndeXm4HtBsqtvATSe+pDHKytt5EfS6XYHGBRuLdTKXWk97FlvlCiJHlNLhAxx+TCMr1HLgDMndW1RP3WiI9dZMSkriwg0RMrEfb2QPPW95qbG52u/JBqzbpVy3BJV8XJyVTogThI8RLSRO92LqM4PXlMX2oeGKLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LlGrJ+p1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758791651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cf9XEk98f14e3UW071J22fCW3YBlBlMBvlocBw8g7Y8=;
	b=LlGrJ+p1Ek2QpZfDyz8TnOWXYKq2l43lYu/Z4AVezlnbzkp/cUaFXstEM3UOv4UYcZnn8W
	tZURIVmNyvC7OCcvj+OutvDW/da/2secq3GYNkjFTxRafBA4a6lWYFZk4zWjM08f0z6cc4
	55x1eSAq7eGNaxFtV+Xby33Ed1FI7LI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-Xnjbk29pOK-ZYQCjyGME7g-1; Thu,
 25 Sep 2025 05:14:09 -0400
X-MC-Unique: Xnjbk29pOK-ZYQCjyGME7g-1
X-Mimecast-MFC-AGG-ID: Xnjbk29pOK-ZYQCjyGME7g_1758791648
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7455E18002C0;
	Thu, 25 Sep 2025 09:14:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.91])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A48C01956095;
	Thu, 25 Sep 2025 09:14:04 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 6/6] vduse: bump version number
Date: Thu, 25 Sep 2025 11:13:35 +0200
Message-ID: <20250925091335.1964283-7-eperezma@redhat.com>
In-Reply-To: <20250925091335.1964283-1-eperezma@redhat.com>
References: <20250925091335.1964283-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Finalize the series by advertising VDUSE API v1 support to userspace.

Now that all required infrastructure for v1 (ASIDs, VQ groups,
update_iotlb_v2) is in place, VDUSE devices can opt in to the new
features.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 8fd34fc67574..63fcde57e2f4 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2165,7 +2165,7 @@ static long vduse_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
-		if (api_version > VDUSE_API_VERSION)
+		if (api_version > VDUSE_API_VERSION_1)
 			break;
 
 		ret = 0;
@@ -2232,7 +2232,7 @@ static int vduse_open(struct inode *inode, struct file *file)
 	if (!control)
 		return -ENOMEM;
 
-	control->api_version = VDUSE_API_VERSION;
+	control->api_version = VDUSE_API_VERSION_1;
 	file->private_data = control;
 
 	return 0;
-- 
2.51.0


