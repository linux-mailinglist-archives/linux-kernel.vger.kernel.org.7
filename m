Return-Path: <linux-kernel+bounces-759017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ED9B1D71C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE2677B374F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8FE246BA5;
	Thu,  7 Aug 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkJEtITE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FAC246335
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567902; cv=none; b=KUIWpbAfzyawg5bOxacmik2nhORK2Nn+seunT9D0gXiFbxAxtsyt5xrJQQGLho8sj7xrvX1d3XnMjq/P9twBEn54ssWZUBXBKjBj6k+OqWkRQbX8Po8jCUkM9q/pjneg6D55Np/GOzO8qWVJ75c11/Ng3Q5NsKt1Bq8DcOoK0n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567902; c=relaxed/simple;
	bh=OlgcjKZEoocgp8URLTA8IUW5kt7t2SqKtJHyK26iYcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Klc5UJIiss6u2Ovo59nsbjIW1DMEO49LeODLGxf3EhGbsQ7JzYGqQER8FfQqZXowqqigTV8Qf2J8HtzDiccCAui8DKAqhAez/ysKNoGeXANKKfoMgZ6u0EqkvfELvRJWlJuzx9Tnzx7IOoIw1gMAE8/Z215CJYUFv65kbWRFN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkJEtITE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754567899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fha0KzHMPOcDj2AbK1PHLwLWx6br+bmZq+WqPZof6SM=;
	b=WkJEtITEuik/ZCGJUgj8/awKiW9ZfA4A+IW0k+vaKK3md0rDWkkVa2Nc3fjFvxjpqGppha
	AziRXgjHu/LwILI1Lt81TTb6DPmTNswBjfESN1PBsHriMWFmoZlWqx+AVdRUHHdho3Qsdl
	N22xlhiSpWDeXLGoVSQJVH2kMC1AesM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-3-SduvGxPYS4va4z7JCCQA-1; Thu,
 07 Aug 2025 07:58:18 -0400
X-MC-Unique: 3-SduvGxPYS4va4z7JCCQA-1
X-Mimecast-MFC-AGG-ID: 3-SduvGxPYS4va4z7JCCQA_1754567897
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71A53180034D;
	Thu,  7 Aug 2025 11:58:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86A1530001A5;
	Thu,  7 Aug 2025 11:58:13 +0000 (UTC)
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
Subject: [RFC v2 4/7] vduse: return internal vq group struct as map token
Date: Thu,  7 Aug 2025 13:57:49 +0200
Message-ID: <20250807115752.1663383-5-eperezma@redhat.com>
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

Return the internal struct that represents the vq group as virtqueue map
token, instead of the device.  This allows the DMA functions to access
the information per group.

At this moment all the virtqueues share the same vq group, that only
can point to ASID 0.  This change prepares the infrastructure for actual
per-group address space handling

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 44 ++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index d1f6d00a9c71..a7a2749f5818 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -90,6 +90,10 @@ struct vduse_umem {
 	struct mm_struct *mm;
 };
 
+struct vduse_vq_group_int {
+	struct vduse_dev *dev;
+};
+
 struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
@@ -123,6 +127,7 @@ struct vduse_dev {
 	u32 vq_align;
 	u32 ngroups;
 	struct vduse_umem *umem;
+	struct vduse_vq_group_int groups[VDUSE_MAX_VQ_GROUPS];
 	struct mutex mem_lock;
 	unsigned int bounce_size;
 	struct mutex domain_lock;
@@ -614,6 +619,14 @@ static u32 vduse_get_vq_desc_group(struct vdpa_device *vdpa, u16 idx)
 	return dev->vqs[idx]->vq_desc_group;
 }
 
+static void *vduse_get_vq_map_token(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	u32 vq_group = dev->vqs[idx]->vq_group;
+
+	return &dev->groups[vq_group];
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -870,6 +883,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
+	.get_vq_map_token	= vduse_get_vq_map_token,
 	.free			= vduse_vdpa_free,
 };
 
@@ -877,8 +891,8 @@ static void vduse_dev_sync_single_for_device(void *token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct device *dev = token;
-	struct vduse_dev *vdev = dev_to_vduse(dev);
+	struct vduse_vq_group_int *group = token;
+	struct vduse_dev *vdev = group->dev;
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
@@ -888,8 +902,8 @@ static void vduse_dev_sync_single_for_cpu(void *token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct device *dev = token;
-	struct vduse_dev *vdev = dev_to_vduse(dev);
+	struct vduse_vq_group_int *group = token;
+	struct vduse_dev *vdev = group->dev;
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
@@ -900,8 +914,8 @@ static dma_addr_t vduse_dev_map_page(void *token, struct page *page,
 				     enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	struct device *dev = token;
-	struct vduse_dev *vdev = dev_to_vduse(dev);
+	struct vduse_vq_group_int *group = token;
+	struct vduse_dev *vdev = group->dev;
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
@@ -911,8 +925,8 @@ static void vduse_dev_unmap_page(void *token, dma_addr_t dma_addr,
 				size_t size, enum dma_data_direction dir,
 				unsigned long attrs)
 {
-	struct device *dev = token;
-	struct vduse_dev *vdev = dev_to_vduse(dev);
+	struct vduse_vq_group_int *group = token;
+	struct vduse_dev *vdev = group->dev;
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
@@ -921,8 +935,8 @@ static void vduse_dev_unmap_page(void *token, dma_addr_t dma_addr,
 static void *vduse_dev_alloc_coherent(void *token, size_t size,
 				      dma_addr_t *dma_addr, gfp_t flag)
 {
-	struct device *dev = token;
-	struct vduse_dev *vdev = dev_to_vduse(dev);
+	struct vduse_vq_group_int *group = token;
+	struct vduse_dev *vdev = group->dev;
 	struct vduse_iova_domain *domain = vdev->domain;
 	unsigned long iova;
 	void *addr;
@@ -942,8 +956,8 @@ static void vduse_dev_free_coherent(void *token, size_t size,
 					void *vaddr, dma_addr_t dma_addr,
 					unsigned long attrs)
 {
-	struct device *dev = token;
-	struct vduse_dev *vdev = dev_to_vduse(dev);
+	struct vduse_vq_group_int *group = token;
+	struct vduse_dev *vdev = group->dev;
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
@@ -951,8 +965,8 @@ static void vduse_dev_free_coherent(void *token, size_t size,
 
 static size_t vduse_dev_max_mapping_size(void *token)
 {
-	struct device *dev = token;
-	struct vduse_dev *vdev = dev_to_vduse(dev);
+	struct vduse_vq_group_int *group = token;
+	struct vduse_dev *vdev = group->dev;
 	struct vduse_iova_domain *domain = vdev->domain;
 
 	return domain->bounce_size;
@@ -1925,6 +1939,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	} else {
 		dev->ngroups = 1;
 	}
+	for (u32 i = 0; i < dev->ngroups; ++i)
+		dev->groups[i].dev = dev;
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
 		goto err_str;
-- 
2.50.1


