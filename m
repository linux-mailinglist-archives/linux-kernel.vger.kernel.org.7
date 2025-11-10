Return-Path: <linux-kernel+bounces-893175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFA4C46B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865853B59A7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B63101B8;
	Mon, 10 Nov 2025 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWwV7/N1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7C30F819
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779154; cv=none; b=hRXCti57AIIaE3vzyFSxRl9h1cW9WDD/RvMUejJDM4/sZu44V3erPJ6elgrcWUN/SYQj928Qg2TN5yV669jH6ZQWAaO4YVm0uOaViWXCUl5t8ISmZNnJXW5ag5TkQy/ePwGTUe4pBhbFhEvyWpoqnkKQxt/fzIEF/BddthXNx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779154; c=relaxed/simple;
	bh=msV+3PGK1IlzoX291OHjE3Fb39LCJTcnII+7EdPQDg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0bsLH1HNkMF8PHRnvMD3W5X+CesD3hB9Ti5QYlRO5P1A3/Mag9+sditM9/PYb1bKQIkokoemclgoVo5QedlgGKEBW1Zz6zeXakYPCWsWjmgLJnPhRgtCDkaYSZ8NNSxlq4VWQchZ1ucd0oQnXLppB21g3wd2CmSBMhJIxqcX8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWwV7/N1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762779151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YhjrYEq8XnNMU4XXDx2ie3d/iAcWWiyDFgL48OSZJOg=;
	b=SWwV7/N1vk8vW6Mgzt5blH15pc7g3pEGq6cZMWQ7t5X9KZRaq6qdda/syNcyi7gvcfGvH6
	+Z1H7ieQrf3DgtIifrYkYMXr6qm+D7JDG4UyIg7RU8bEjzHOZHPD0EiKw7ciEh+RODGZ9B
	U+M/96kkIfF+I46QmYQhFDpZFwPHL5Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-Vn3RM_FrMHGbuiJyBxaxsA-1; Mon,
 10 Nov 2025 07:52:30 -0500
X-MC-Unique: Vn3RM_FrMHGbuiJyBxaxsA-1
X-Mimecast-MFC-AGG-ID: Vn3RM_FrMHGbuiJyBxaxsA_1762779148
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0FE819560A1;
	Mon, 10 Nov 2025 12:52:27 +0000 (UTC)
Received: from slp-asahi.redhat.com (unknown [10.44.32.9])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D6D23000601;
	Mon, 10 Nov 2025 12:52:21 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Sergio Lopez <slp@redhat.com>
Subject: [PATCH 1/3] drm/virtio: support VIRTIO_GPU_F_BLOB_ALIGNMENT
Date: Mon, 10 Nov 2025 13:52:11 +0100
Message-ID: <20251110125213.12633-2-slp@redhat.com>
In-Reply-To: <20251110125213.12633-1-slp@redhat.com>
References: <20251110125213.12633-1-slp@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Support VIRTIO_GPU_F_BLOB_ALIGNMENT, a feature that indicates the device
provides a valid blob_alignment field in its configuration, and that
both RESOURCE_CREATE_BLOB and RESOURCE_MAP_BLOB requests must be aligned
to that value.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h |  2 ++
 drivers/gpu/drm/virtio/virtgpu_kms.c | 14 +++++++++++---
 include/uapi/linux/virtio_gpu.h      |  9 +++++++++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 71c6ccad4b99..ad675ee18b01 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -162,6 +162,7 @@ static unsigned int features[] = {
 	VIRTIO_GPU_F_RESOURCE_UUID,
 	VIRTIO_GPU_F_RESOURCE_BLOB,
 	VIRTIO_GPU_F_CONTEXT_INIT,
+	VIRTIO_GPU_F_BLOB_ALIGNMENT,
 };
 static struct virtio_driver virtio_gpu_driver = {
 	.feature_table = features,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f17660a71a3e..d1fa386a5a99 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -257,6 +257,7 @@ struct virtio_gpu_device {
 	bool has_resource_blob;
 	bool has_host_visible;
 	bool has_context_init;
+	bool has_blob_alignment;
 	struct virtio_shm_region host_visible_region;
 	struct drm_mm host_visible_mm;
 
@@ -270,6 +271,7 @@ struct virtio_gpu_device {
 	uint32_t num_capsets;
 	uint64_t capset_id_mask;
 	struct list_head cap_cache;
+	uint32_t blob_alignment;
 
 	/* protects uuid state when exporting */
 	spinlock_t resource_export_lock;
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 1c15cbf326b7..a20b62041f03 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -123,7 +123,7 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	struct virtio_gpu_device *vgdev;
 	/* this will expand later */
 	struct virtqueue *vqs[2];
-	u32 num_scanouts, num_capsets;
+	u32 num_scanouts, num_capsets, blob_alignment;
 	int ret = 0;
 
 	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
@@ -197,14 +197,22 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_CONTEXT_INIT))
 		vgdev->has_context_init = true;
 
+	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_BLOB_ALIGNMENT)) {
+		vgdev->has_blob_alignment = true;
+		virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
+				blob_alignment, &blob_alignment);
+		vgdev->blob_alignment = blob_alignment;
+	}
+
 	DRM_INFO("features: %cvirgl %cedid %cresource_blob %chost_visible",
 		 vgdev->has_virgl_3d    ? '+' : '-',
 		 vgdev->has_edid        ? '+' : '-',
 		 vgdev->has_resource_blob ? '+' : '-',
 		 vgdev->has_host_visible ? '+' : '-');
 
-	DRM_INFO("features: %ccontext_init\n",
-		 vgdev->has_context_init ? '+' : '-');
+	DRM_INFO("features: %ccontext_init %cblob_alignment\n",
+		 vgdev->has_context_init ? '+' : '-',
+		 vgdev->has_blob_alignment ? '+' : '-');
 
 	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, vqs_info, NULL);
 	if (ret) {
diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index be109777d10d..4f530d90058c 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -64,6 +64,14 @@
  * context_init and multiple timelines
  */
 #define VIRTIO_GPU_F_CONTEXT_INIT        4
+/*
+ * The device provides a valid blob_alignment
+ * field in its configuration and both
+ * VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB and
+ * VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB requests
+ * must be aligned to that value.
+ */
+#define VIRTIO_GPU_F_BLOB_ALIGNMENT      5
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -365,6 +373,7 @@ struct virtio_gpu_config {
 	__le32 events_clear;
 	__le32 num_scanouts;
 	__le32 num_capsets;
+	__le32 blob_alignment;
 };
 
 /* simple formats for fbcon/X use */
-- 
2.51.0


