Return-Path: <linux-kernel+bounces-765970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C87CB240B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839AF1893198
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA72D2380;
	Wed, 13 Aug 2025 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjX4Qb+P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD862D1F4A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064166; cv=none; b=asJuFmZeIjuusEffZT+1MPTqogZ5L+L90yQiLb+Ftn6GwQ1abnZi44iFkIrlgz7LEVci7STNlf6kwVbbIg0BEuHKDwQyWctaWOo4aYiCmzpCl2Nn19bRs5PDb8MeNNla7GtEQaja9hLCWdgDkp2CbF5WwOJv7Ix/ZTG97KrMSGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064166; c=relaxed/simple;
	bh=cE7ivMj9V02Cj5Qk81EJzx4q+SUy6j0AAF71NUCzb9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnUuZxYj+fbd1O3pw3MHWQeoBdiddEpXx1a34NdH1+bE8/41fABdhAmYJIbum5QnM/BVwnycbCax2z6xfkXk7LQlAzxGaKBCQ7jNrKanBnofkodEkQd/lsWOEnQKJrwTJ8gLvwHrnNcis7mALRW0u7KPBhUEo3rYR+fH05PjsRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjX4Qb+P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755064163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KrCph31Dj9FYN9+2Tn4R+nxwXGM+l19IOSezhR32ZbQ=;
	b=WjX4Qb+PeGAmlrCcP6Llf91arPo1vVcaHPbmRfY0Mp5yuPxj17lSvYXCqnExn4dBTobWLe
	jozbjWg9aCRl9GPo3b1beiS1lsw73FylGyNjs77gnHGA7L0Uj/HxG6OeDV6CY25xv8eb6S
	S3ViJysTKdWZKOSXlgpEPUmVfb4ULRg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-n86RWQo2Nx6Ahgv-37sqgw-1; Wed,
 13 Aug 2025 01:49:20 -0400
X-MC-Unique: n86RWQo2Nx6Ahgv-37sqgw-1
X-Mimecast-MFC-AGG-ID: n86RWQo2Nx6Ahgv-37sqgw_1755064159
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C56318002C3;
	Wed, 13 Aug 2025 05:49:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.168])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25C061800446;
	Wed, 13 Aug 2025 05:49:14 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V5 8/9] vdpa: introduce map ops
Date: Wed, 13 Aug 2025 13:48:30 +0800
Message-ID: <20250813054831.25865-9-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-1-jasowang@redhat.com>
References: <20250813054831.25865-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Virtio core allows the transport to provide device or transport
specific mapping functions. This patch adds this support to vDPA. We
can simply do this by allowing the vDPA parent to register a
virtio_map_ops.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/alibaba/eni_vdpa.c          |  3 ++-
 drivers/vdpa/ifcvf/ifcvf_main.c          |  3 ++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c        |  2 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++--
 drivers/vdpa/pds/vdpa_dev.c              |  3 ++-
 drivers/vdpa/solidrun/snet_main.c        |  4 ++--
 drivers/vdpa/vdpa.c                      |  3 +++
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  3 ++-
 drivers/vdpa/virtio_pci/vp_vdpa.c        |  3 ++-
 drivers/vhost/vdpa.c                     | 10 ++++++++++
 drivers/virtio/virtio_vdpa.c             |  4 +++-
 include/linux/vdpa.h                     | 10 +++++++---
 13 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index cbec3fcffaef..a0420da37863 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -478,7 +478,8 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 
 	eni_vdpa = vdpa_alloc_device(struct eni_vdpa, vdpa,
-				     dev, &eni_vdpa_ops, 1, 1, NULL, false);
+				     dev, &eni_vdpa_ops, NULL,
+				     1, 1, NULL, false);
 	if (IS_ERR(eni_vdpa)) {
 		ENI_ERR(pdev, "failed to allocate vDPA structure\n");
 		return PTR_ERR(eni_vdpa);
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 520a7d4db435..2fd8a9b20ac3 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -705,7 +705,8 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	vf = &ifcvf_mgmt_dev->vf;
 	pdev = vf->pdev;
 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
-				    &pdev->dev, &ifc_vdpa_ops, 1, 1, NULL, false);
+				    &pdev->dev, &ifc_vdpa_ops,
+				    NULL, 1, 1, NULL, false);
 	if (IS_ERR(adapter)) {
 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
 		return PTR_ERR(adapter);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 4a1a8b0a0123..8a8cf6942998 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3882,7 +3882,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	}
 
 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mgtdev->vdpa_ops,
-				 MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
+				 NULL, MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index e229b421d194..3ef9c2fd8f57 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -508,8 +508,8 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	u64 device_features;
 	int ret;
 
-	oct_vdpa = vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev->dev, &octep_vdpa_ops, 1, 1,
-				     NULL, false);
+	oct_vdpa = vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev->dev, &octep_vdpa_ops,
+				     NULL, 1, 1, NULL, false);
 	if (IS_ERR(oct_vdpa)) {
 		dev_err(&pdev->dev, "Failed to allocate vDPA structure for octep vdpa device");
 		return PTR_ERR(oct_vdpa);
diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index c9da0e519d5c..ed3e015c4668 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -632,7 +632,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	}
 
 	pdsv = vdpa_alloc_device(struct pds_vdpa_device, vdpa_dev,
-				 dev, &pds_vdpa_ops, 1, 1, name, false);
+				 dev, &pds_vdpa_ops, NULL,
+				 1, 1, name, false);
 	if (IS_ERR(pdsv)) {
 		dev_err(dev, "Failed to allocate vDPA structure: %pe\n", pdsv);
 		return PTR_ERR(pdsv);
diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index d7b4eff77c95..849d325cab31 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -1008,8 +1008,8 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
 	}
 
 	/* Allocate vdpa device */
-	snet = vdpa_alloc_device(struct snet, vdpa, &pdev->dev, &snet_config_ops, 1, 1, NULL,
-				 false);
+	snet = vdpa_alloc_device(struct snet, vdpa, &pdev->dev, &snet_config_ops,
+				 NULL, 1, 1, NULL, false);
 	if (!snet) {
 		SNET_ERR(pdev, "Failed to allocate a vdpa device\n");
 		ret = -ENOMEM;
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 0115ce04979c..8421c882f4d6 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -142,6 +142,7 @@ static void vdpa_release_dev(struct device *d)
  * initialized but before registered.
  * @parent: the parent device
  * @config: the bus operations that is supported by this device
+ * @map: the map opeartions that is supported by this device
  * @ngroups: number of groups supported by this device
  * @nas: number of address spaces supported by this device
  * @size: size of the parent structure that contains private data
@@ -156,6 +157,7 @@ static void vdpa_release_dev(struct device *d)
  */
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
+					const struct virtio_map_ops *map,
 					unsigned int ngroups, unsigned int nas,
 					size_t size, const char *name,
 					bool use_va)
@@ -187,6 +189,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	vdev->dev.release = vdpa_release_dev;
 	vdev->index = err;
 	vdev->config = config;
+	vdev->map = map;
 	vdev->features_valid = false;
 	vdev->use_va = use_va;
 	vdev->ngroups = ngroups;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 9a07063aaff7..fa288960d53f 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -215,7 +215,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	else
 		ops = &vdpasim_config_ops;
 
-	vdpa = __vdpa_alloc_device(NULL, ops,
+	vdpa = __vdpa_alloc_device(NULL, ops, NULL,
 				   dev_attr->ngroups, dev_attr->nas,
 				   dev_attr->alloc_size,
 				   dev_attr->name, use_va);
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 8e32b3db8608..f161059d543e 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2009,7 +2009,8 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 		return -EEXIST;
 
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
-				 &vduse_vdpa_config_ops, 1, 1, name, true);
+				 &vduse_vdpa_config_ops, NULL,
+				 1, 1, name, true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
 
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 2cb0dbf1740e..e908b2a37c92 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -511,7 +511,8 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	int ret, i;
 
 	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
-				    dev, &vp_vdpa_ops, 1, 1, name, false);
+				    dev, &vp_vdpa_ops, NULL,
+				    1, 1, name, false);
 
 	if (IS_ERR(vp_vdpa)) {
 		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 3d4c44b3f2b7..147fdef02f06 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1322,13 +1322,23 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
 	const struct vdpa_config_ops *ops = vdpa->config;
 	union vring_mapping_token *mapping_token =
 	      vdpa_get_mapping_token(vdpa);
+	const struct virtio_map_ops *map = vdpa->map;
 	struct device *dma_dev = mapping_token->dma_dev;
 	int ret;
 
+	/* IOMMU domain only works for DMA device */
+	if (vdpa->map)
+		return -EINVAL;
+
 	/* Device want to do DMA by itself */
 	if (ops->set_map || ops->dma_map)
 		return 0;
 
+	if (map) {
+		dev_warn(&v->dev, "Can't allocate a domian, device use vendor specific mappings\n");
+		return -EINVAL;
+	}
+
 	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY)) {
 		dev_warn_once(&v->dev,
 			      "Failed to allocate domain, device is not IOMMU cache coherent capable\n");
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 1a10024a8e4f..fddfcfabf28e 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -462,9 +462,11 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
 	if (!vd_dev)
 		return -ENOMEM;
 
-	vd_dev->vdev.dev.parent = vdpa_get_mapping_token(vdpa)->dma_dev;
+	vd_dev->vdev.dev.parent = vdpa->map ? &vdpa->dev :
+		       vdpa_get_mapping_token(vdpa)->dma_dev;
 	vd_dev->vdev.dev.release = virtio_vdpa_release_dev;
 	vd_dev->vdev.config = &virtio_vdpa_config_ops;
+	vd_dev->vdev.map = vdpa->map;
 	vd_dev->vdpa = vdpa;
 
 	vd_dev->vdev.id.device = ops->get_device_id(vdpa);
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index f806f13ca260..d328ec1ab5ea 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -76,6 +76,7 @@ struct vdpa_mgmt_dev;
  *                   because core frees it; use driver_set_override() to
  *                   set or clear it.
  * @config: the configuration ops for this device.
+ * @map: the map ops for this device
  * @cf_lock: Protects get and set access to configuration layout.
  * @index: device index
  * @features_valid: were features initialized? for legacy guests
@@ -91,6 +92,7 @@ struct vdpa_device {
 	union vring_mapping_token mapping_token;
 	const char *driver_override;
 	const struct vdpa_config_ops *config;
+	const struct virtio_map_ops *map;
 	struct rw_semaphore cf_lock; /* Protects get/set config */
 	unsigned int index;
 	bool features_valid;
@@ -447,6 +449,7 @@ struct vdpa_config_ops {
 
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
+					const struct virtio_map_ops *map,
 					unsigned int ngroups, unsigned int nas,
 					size_t size, const char *name,
 					bool use_va);
@@ -458,6 +461,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
  * @member: the name of struct vdpa_device within the @dev_struct
  * @parent: the parent device
  * @config: the bus operations that is supported by this device
+ * @map: the map operations that is supported by this device
  * @ngroups: the number of virtqueue groups supported by this device
  * @nas: the number of address spaces
  * @name: name of the vdpa device
@@ -465,10 +469,10 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
  *
  * Return allocated data structure or ERR_PTR upon error
  */
-#define vdpa_alloc_device(dev_struct, member, parent, config, ngroups, nas, \
-			  name, use_va) \
+#define vdpa_alloc_device(dev_struct, member, parent, config, map, \
+			  ngroups, nas, name, use_va)		   \
 			  container_of((__vdpa_alloc_device( \
-				       parent, config, ngroups, nas, \
+				       parent, config, map, ngroups, nas, \
 				       (sizeof(dev_struct) + \
 				       BUILD_BUG_ON_ZERO(offsetof( \
 				       dev_struct, member))), name, use_va)), \
-- 
2.31.1


