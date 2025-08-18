Return-Path: <linux-kernel+bounces-773229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D9EB29CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2534E64A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954EC30BF69;
	Mon, 18 Aug 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTtISHbG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC0330BF65
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507463; cv=none; b=gmQ39eC94wzM4+Borme1YSL7AW+/WOEEhsP9N7iA/j0gOyV61cB/QlFEeXUD8GYtF++mPZgfAkQjCJ+82AxUKxB9pb9NKNd5DwgyCxiooJBQ8ty7XSYTMlCjyLdeCxZPAjb+nne6rdOtjFnZ8KC3f2iiNZwkyLbsfWnYlxjbxcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507463; c=relaxed/simple;
	bh=KukE7lIDYgBkgVivBel/763Uqu2vc2JHySiAPWZJYj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bj6ZsXQLBbs77cNc+rcWOFdTTDp56FsaHBJbVERtWH5g9vRcCUAQHy/nVtkb/pBk9jhFYIW9YnYkIA/uWhb05m07j7zlmkbT5UNCLjNqXNAb9lUiGyBVe5PWykaSbeQDnpUbvdlBkK4BPFX6Cc6iAImC9G78772zG203G1Gphas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTtISHbG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755507460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vv2fIHHkGpDijoACTLcDqW3ci7RJYD8mt/1gDnxJgTA=;
	b=dTtISHbGAkcZgfOY55LXgxmnBBHyfRDnznTgxaIHI2dLAusNEgHdPkIN6G7gltJpX/0RcS
	quG/ndD2HCjd3WvzCjgOHkqNafgYPxOWLFgqildaEEOZxEqR504lZUxMWKv4jSgd1fNjx+
	pp0z4ZIheJTYORpOBY2F1ltrfS5GsRM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-s1bxgSckNY6Xv3T4BMjAGw-1; Mon,
 18 Aug 2025 04:57:37 -0400
X-MC-Unique: s1bxgSckNY6Xv3T4BMjAGw-1
X-Mimecast-MFC-AGG-ID: s1bxgSckNY6Xv3T4BMjAGw_1755507456
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A07331956086;
	Mon, 18 Aug 2025 08:57:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.213])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BCB3180028B;
	Mon, 18 Aug 2025 08:57:31 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	jasowang@redhat.com,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC v3 4/7] vduse: return internal vq group struct as map token
Date: Mon, 18 Aug 2025 10:57:08 +0200
Message-ID: <20250818085711.3461758-5-eperezma@redhat.com>
In-Reply-To: <20250818085711.3461758-1-eperezma@redhat.com>
References: <20250818085711.3461758-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Return the internal struct that represents the vq group as virtqueue map
token, instead of the device.  This allows the map functions to access
the information per group.

At this moment all the virtqueues share the same vq group, that only
can point to ASID 0.  This change prepares the infrastructure for actual
per-group address space handling

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v3:
* Make the vq groups a dynamic array to support an arbitrary number of
  them.
---
 drivers/vdpa/vdpa_user/iova_domain.h |  1 -
 drivers/vdpa/vdpa_user/vduse_dev.c   | 65 +++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index c0f97dfaf94f..1f3c30be272a 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -26,7 +26,6 @@ struct vduse_bounce_map {
 };
 
 struct vduse_iova_domain {
-	struct vring_mapping_opaque token;
 	struct iova_domain stream_iovad;
 	struct iova_domain consistent_iovad;
 	struct vduse_bounce_map *bounce_maps;
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index e3c8fc1aa446..45b188dc2659 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -84,6 +84,11 @@ struct vduse_umem {
 	struct mm_struct *mm;
 };
 
+struct vduse_vq_group_int {
+	struct vring_mapping_opaque token;
+	struct vduse_dev *dev;
+};
+
 struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
@@ -118,6 +123,7 @@ struct vduse_dev {
 	u32 vq_align;
 	u32 ngroups;
 	struct vduse_umem *umem;
+	struct vduse_vq_group_int *groups;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
 	struct mutex domain_lock;
@@ -164,9 +170,9 @@ static inline struct vduse_dev *dev_to_vduse(struct device *dev)
 	return vdpa_to_vduse(vdpa);
 }
 
-static struct vduse_iova_domain *vduse_token_to_domain(struct vring_mapping_opaque *token)
+static struct vduse_vq_group_int *vduse_token_to_vq_group(struct vring_mapping_opaque *token)
 {
-	return container_of(token, struct vduse_iova_domain, token);
+	return container_of(token, struct vduse_vq_group_int, token);
 }
 
 static struct vduse_dev_msg *vduse_find_msg(struct list_head *head,
@@ -607,6 +613,16 @@ static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
 	return dev->vqs[idx]->vq_group;
 }
 
+static union vring_mapping_token vduse_get_vq_mapping_token(struct vdpa_device *vdpa,
+							    u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	u32 vq_group = dev->vqs[idx]->vq_group;
+	union vring_mapping_token ret = { .token = &dev->groups[vq_group].token };
+
+	return ret;
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -856,6 +872,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
+	.get_vq_mapping_token	= vduse_get_vq_mapping_token,
 	.free			= vduse_vdpa_free,
 };
 
@@ -863,7 +880,9 @@ static void vduse_dev_sync_single_for_device(struct vring_mapping_opaque *token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
+	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
+	struct vduse_dev *vdev = group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
 }
@@ -872,7 +891,9 @@ static void vduse_dev_sync_single_for_cpu(struct vring_mapping_opaque *token,
 					  dma_addr_t dma_addr, size_t size,
 					  enum dma_data_direction dir)
 {
-	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
+	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
+	struct vduse_dev *vdev = group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
 }
@@ -883,7 +904,9 @@ static dma_addr_t vduse_dev_map_page(struct vring_mapping_opaque *token,
 				     enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
+	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
+	struct vduse_dev *vdev = group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
 }
@@ -893,7 +916,9 @@ static void vduse_dev_unmap_page(struct vring_mapping_opaque *token,
 				 enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
+	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
+	struct vduse_dev *vdev = group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }
@@ -902,7 +927,9 @@ static void *vduse_dev_alloc_coherent(struct vring_mapping_opaque *token,
 				      size_t size, dma_addr_t *dma_addr,
 				      gfp_t flag)
 {
-	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
+	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
+	struct vduse_dev *vdev = group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 	unsigned long iova;
 	void *addr;
 
@@ -921,7 +948,9 @@ static void vduse_dev_free_coherent(struct vring_mapping_opaque *token,
 				    size_t size, void *vaddr,
 				    dma_addr_t dma_addr, unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
+	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
+	struct vduse_dev *vdev = group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
 }
@@ -929,7 +958,9 @@ static void vduse_dev_free_coherent(struct vring_mapping_opaque *token,
 static bool vduse_dev_need_sync(struct vring_mapping_opaque *token,
 				dma_addr_t dma_addr)
 {
-	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
+	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
+	struct vduse_dev *vdev = group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	return dma_addr < domain->bounce_size;
 }
@@ -944,7 +975,9 @@ static int vduse_dev_mapping_error(struct vring_mapping_opaque *token,
 
 static size_t vduse_dev_max_mapping_size(struct vring_mapping_opaque *token)
 {
-	struct vduse_iova_domain *domain = vduse_token_to_domain(token);
+	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
+	struct vduse_dev *vdev = group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	return domain->bounce_size;
 }
@@ -1750,6 +1783,7 @@ static int vduse_destroy_dev(char *name)
 	if (dev->domain)
 		vduse_domain_destroy(dev->domain);
 	kfree(dev->name);
+	kfree(dev->groups);
 	vduse_dev_destroy(dev);
 	module_put(THIS_MODULE);
 
@@ -1915,7 +1949,15 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+
 	dev->ngroups = (dev->api_version < 1) ? 1 : (config->ngroups ?: 1);
+	dev->groups = kcalloc(dev->ngroups, sizeof(dev->groups[0]),
+			      GFP_KERNEL);
+	if (!dev->groups)
+		goto err_vq_groups;
+	for (u32 i = 0; i < dev->ngroups; ++i)
+		dev->groups[i].dev = dev;
+
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
 		goto err_str;
@@ -1952,6 +1994,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 err_idr:
 	kfree(dev->name);
 err_str:
+	kfree(dev->groups);
+err_vq_groups:
 	vduse_dev_destroy(dev);
 err:
 	return ret;
@@ -2113,7 +2157,6 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return -ENOMEM;
 	}
 
-	dev->vdev->vdpa.mapping_token.token = &dev->domain->token;
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
-- 
2.50.1


