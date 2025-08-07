Return-Path: <linux-kernel+bounces-759020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2540B1D722
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7754E7AFEB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896AD239E7F;
	Thu,  7 Aug 2025 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBIMWibA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2F23ED6A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567911; cv=none; b=kw+wrwsSKpBfijmdMDl1dQ0HkmjIm05/bd7SrHTOwPzO/MNAV5O0hkNQxU6IxQTMPh8o/a+Fv1exCh5eEgnTEgT/U/6/ufd47oQTnbpHpvIcUgPvFFR9jqBCp3dPoOm0nxPS3zAypA1ltyjQ2Nw6M7NIPqm05dENdvRymmOjy3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567911; c=relaxed/simple;
	bh=bw4QieCdPyUE1mT+QXJIz6RfMf6JFswO943BPFYtrzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KR1apLl/dVlN9kIsmOlOHztdovt2A4cU0jkytWoPUuujEXDpFsif0LZiJvBDOw+yG7cMqiQxuzPxOBHwyWBNeFVe8PNue0JNz3P69Syd/Q9J16swei+7cV3ZAc4/p8i3eXYXEccNoAmjbymHWFqtE/TiWQ2Q6UB6Wkz6k4z21Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HBIMWibA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754567908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAWEzypwFXNY0V+CvTxfSM1d3goRg1trlUIPl5R5TMM=;
	b=HBIMWibAcwXXBGlWVh2LKXJuNIMMyEkkwkjNgrr4KgDUkQ4e6to6QSnhPOanABqNzroFOB
	rUmn6HB5H2DPdb0xUdkt4gqNjme1rnOuo35hTeRqzl00a4On5sxLpLdZAjZKXa0/nwxL27
	+0ra/9HgPWSTSV+Y2xr0QHU6c5UWDGM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-N8vLL0QbNjaVgUTx4rtwyA-1; Thu,
 07 Aug 2025 07:58:27 -0400
X-MC-Unique: N8vLL0QbNjaVgUTx4rtwyA-1
X-Mimecast-MFC-AGG-ID: N8vLL0QbNjaVgUTx4rtwyA_1754567906
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 846E019560AA;
	Thu,  7 Aug 2025 11:58:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B2D713001456;
	Thu,  7 Aug 2025 11:58:22 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Laurent Vivier <lvivier@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	jasowang@redhat.com,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [RFC v2 6/7] vduse: send update_iotlb_v2 message
Date: Thu,  7 Aug 2025 13:57:51 +0200
Message-ID: <20250807115752.1663383-7-eperezma@redhat.com>
In-Reply-To: <20250807115752.1663383-1-eperezma@redhat.com>
References: <20250807115752.1663383-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This message lets the kernel notify userspace VDUSE backends about
updated IOTLB mappings for a specific ASID.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 14 ++++++++++----
 include/uapi/linux/vduse.h         |  7 +++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 145147c49930..ac7897068222 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -326,7 +326,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev, u8 status)
 	return vduse_dev_msg_sync(dev, &msg);
 }
 
-static int vduse_dev_update_iotlb(struct vduse_dev *dev,
+static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
 				  u64 start, u64 last)
 {
 	struct vduse_dev_msg msg = { 0 };
@@ -335,8 +335,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *dev,
 		return -EINVAL;
 
 	msg.req.type = VDUSE_UPDATE_IOTLB;
-	msg.req.iova.start = start;
-	msg.req.iova.last = last;
+	if (dev->api_version < VDUSE_API_VERSION_1) {
+		msg.req.iova.start = start;
+		msg.req.iova.last = last;
+	} else {
+		msg.req.iova_v2.start = start;
+		msg.req.iova_v2.last = last;
+		msg.req.iova_v2.asid = asid;
+	}
 
 	return vduse_dev_msg_sync(dev, &msg);
 }
@@ -882,7 +888,7 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
 	if (ret)
 		return ret;
 
-	ret = vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
+	ret = vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
 	if (ret) {
 		vduse_domain_clear_map(dev->domain[asid], iotlb);
 		return ret;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index d300fd5f867f..a5f7a5edb8e0 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -349,6 +349,12 @@ struct vduse_iova_range {
 	__u64 last;
 };
 
+struct vduse_iova_range_v2 {
+	__u64 start;
+	__u64 last;
+	__u32 asid;
+};
+
 /**
  * struct vduse_dev_request - control request
  * @type: request type
@@ -369,6 +375,7 @@ struct vduse_dev_request {
 		struct vduse_vq_state vq_state;
 		struct vduse_dev_status s;
 		struct vduse_iova_range iova;
+		struct vduse_iova_range_v2 iova_v2;
 		struct vduse_vq_group vq_group; /* Only if vduse api version >= 1 */
 		/* Only if vduse api version >= 1 */
 		struct vduse_vq_group_asid vq_group_asid;
-- 
2.50.1


