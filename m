Return-Path: <linux-kernel+bounces-872242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716DAC0FB08
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85656429509
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1918231A567;
	Mon, 27 Oct 2025 17:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="FIcn9Eca"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611CB3195EB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586467; cv=none; b=pAy/Ry16heVQFcVNNRwGKLCDaivCuYkXDZJeJW+vknzB0e204O01+rZEw430kutTYhONUA0JFuS83YKRYiOOngpoLnShONnXh9TTPr9rQg+uoura9z/XhJ0JTu2OKHDtUqKcxmdAjlhUxygKhJdtL0mXl8L9D3daSbQRbEfqev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586467; c=relaxed/simple;
	bh=G24kXUl2/1TAts5Q0ehohqPvN68Ye7VZyo+zXcJ3lsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RSgktEQaM9Lvat3jBT0FuG4UI1/5SmIgcFpIQ9fjPYqdUjsYY2TaFb2so3APgPV2QueELj/ZLPgGvG13yucwZzP+wLESj2VSjHBDLHyPTMykncv/viUDw6UnzXltohXdkyLiUGyDM+QCrMJsyigIwpZUQD22ozRJDSeXai0k4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=FIcn9Eca; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RFrudL1234687
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:34:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=/MbEWdUFJbcP82cLDLSYjE8slJtu9iBACdeQFA1CSI8=; b=FIcn9EcaygkA
	PhfiNhs33GddbMmYIAvpRSQjxOpmEznTa8EUepxfOlV6HJTUic/11mQBkB2B7a4s
	qiTGaU5SGitHf+YpCAwD8x3wkykDrR+vPl2ZoDLwfAQZthGkjI239xrzWc5Wlfn7
	fNkIsr0A/5CEJHgwx3TU/whPkD7aYvxYq9OC6p9JYYC/o02TQkbkf6UgujVOrjx/
	QRln7xLHEzodT7I/mzG08YvLmRzMatqpmm/CiwgVGhqU5nuYV4/LwW7k6By7y5kt
	uZ8Zu4Vq124/6u8rX058Wl6LwbR1/EI3PWWOduK9XGWlZO/TJ667cp6kNA9gk2vm
	05oMGGSrMw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a2bsd11em-20
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:34:24 -0700 (PDT)
Received: from twshared28390.17.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 27 Oct 2025 17:34:03 +0000
Received: by devgpu012.nha5.facebook.com (Postfix, from userid 28580)
	id 8012F43E09A; Mon, 27 Oct 2025 10:33:57 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
Date: Mon, 27 Oct 2025 10:33:44 -0700
Subject: [PATCH v5 4/5] vfio: selftests: update DMA map/unmap helpers to
 support more test kinds
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251027-fix-unmap-v5-4-4f0fcf8ffb7d@fb.com>
References: <20251027-fix-unmap-v5-0-4f0fcf8ffb7d@fb.com>
In-Reply-To: <20251027-fix-unmap-v5-0-4f0fcf8ffb7d@fb.com>
To: Alex Williamson <alex@shazbot.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>,
        David Matlack <dmatlack@google.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro
	<amastro@fb.com>
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=LrifC3dc c=1 sm=1 tr=0 ts=68ffad20 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=mN9a-mZmZOQI0s6eON8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nVKbAXn-56R-p6M1e4av_sf-gP95IRi6
X-Proofpoint-GUID: nVKbAXn-56R-p6M1e4av_sf-gP95IRi6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE2MyBTYWx0ZWRfX+2NjINe7Gj50
 yKDNN5M/74Iv2FU3Cpm6inSsGacE6tkgVH3cjD+Wtqr9qHTkzVA+h0KUSlkWnWRexlXaonwGkUS
 0jWDIJJ1Svic4pIaXFjDh24UGCGYl+RkOgYtRpM3od/UsDpLL3HOuFRK/dFuOAtq+uVQglejNN4
 vvLuW2rEXkHcVmuCTQbeJnk+PZNRC75vmmQs+Xx7An8i7tRBpnxEeaVp6XQT81Av30yXA/PFzu8
 ROU2SODYICSD93az+0tO0BYyeBsurU1rD5GI4ghEkInYGFLtr/Fx2ngjZYy424Y7jmbHcjf9oho
 xTL71409RvsihDRGkiZ1VdRQmcXVByIyoA9pX0MGvf9gOELhRcn9UWivPN7v6eaFkwXLNuhdhdP
 11w6BgQEhPmynXH69tSOz+5lvU+PeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01

Add __vfio_pci_dma_* helpers which return -errno from the underlying
ioctls.

Add __vfio_pci_dma_unmap_all to test more unmapping code paths. Add an
out unmapped arg to report the unmapped byte size.

The existing vfio_pci_dma_* functions, which are intended for happy-path
usage (assert on failure) are now thin wrappers on top of the
double-underscore helpers.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 .../testing/selftests/vfio/lib/include/vfio_util.h |  27 +++++-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 105 ++++++++++++++++-----
 .../testing/selftests/vfio/vfio_dma_mapping_test.c |   5 +-
 3 files changed, 109 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
index ed31606e01b7..240409bf5f8a 100644
--- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
+++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
@@ -206,10 +206,29 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const char *iommu_
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 void vfio_pci_device_reset(struct vfio_pci_device *device);
 
-void vfio_pci_dma_map(struct vfio_pci_device *device,
-		      struct vfio_dma_region *region);
-void vfio_pci_dma_unmap(struct vfio_pci_device *device,
-			struct vfio_dma_region *region);
+int __vfio_pci_dma_map(struct vfio_pci_device *device,
+		       struct vfio_dma_region *region);
+int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
+			 struct vfio_dma_region *region,
+			 u64 *unmapped);
+int __vfio_pci_dma_unmap_all(struct vfio_pci_device *device, u64 *unmapped);
+
+static inline void vfio_pci_dma_map(struct vfio_pci_device *device,
+				    struct vfio_dma_region *region)
+{
+	VFIO_ASSERT_EQ(__vfio_pci_dma_map(device, region), 0);
+}
+
+static inline void vfio_pci_dma_unmap(struct vfio_pci_device *device,
+				      struct vfio_dma_region *region)
+{
+	VFIO_ASSERT_EQ(__vfio_pci_dma_unmap(device, region, NULL), 0);
+}
+
+static inline void vfio_pci_dma_unmap_all(struct vfio_pci_device *device)
+{
+	VFIO_ASSERT_EQ(__vfio_pci_dma_unmap_all(device, NULL), 0);
+}
 
 void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 			    size_t config, size_t size, void *data);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 0921b2451ba5..af43d8c07199 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -2,6 +2,7 @@
 #include <dirent.h>
 #include <fcntl.h>
 #include <libgen.h>
+#include <stdint.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
@@ -141,7 +142,7 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
 	ioctl_assert(device->fd, VFIO_DEVICE_GET_IRQ_INFO, irq_info);
 }
 
-static void vfio_iommu_dma_map(struct vfio_pci_device *device,
+static int vfio_iommu_dma_map(struct vfio_pci_device *device,
 			       struct vfio_dma_region *region)
 {
 	struct vfio_iommu_type1_dma_map args = {
@@ -152,10 +153,13 @@ static void vfio_iommu_dma_map(struct vfio_pci_device *device,
 		.size = region->size,
 	};
 
-	ioctl_assert(device->container_fd, VFIO_IOMMU_MAP_DMA, &args);
+	if (ioctl(device->container_fd, VFIO_IOMMU_MAP_DMA, &args))
+		return -errno;
+
+	return 0;
 }
 
-static void iommufd_dma_map(struct vfio_pci_device *device,
+static int iommufd_dma_map(struct vfio_pci_device *device,
 			    struct vfio_dma_region *region)
 {
 	struct iommu_ioas_map args = {
@@ -169,54 +173,109 @@ static void iommufd_dma_map(struct vfio_pci_device *device,
 		.ioas_id = device->ioas_id,
 	};
 
-	ioctl_assert(device->iommufd, IOMMU_IOAS_MAP, &args);
+	if (ioctl(device->iommufd, IOMMU_IOAS_MAP, &args))
+		return -errno;
+
+	return 0;
 }
 
-void vfio_pci_dma_map(struct vfio_pci_device *device,
+int __vfio_pci_dma_map(struct vfio_pci_device *device,
 		      struct vfio_dma_region *region)
 {
+	int ret;
+
 	if (device->iommufd)
-		iommufd_dma_map(device, region);
+		ret = iommufd_dma_map(device, region);
 	else
-		vfio_iommu_dma_map(device, region);
+		ret = vfio_iommu_dma_map(device, region);
+
+	if (ret)
+		return ret;
 
 	list_add(&region->link, &device->dma_regions);
+
+	return 0;
 }
 
-static void vfio_iommu_dma_unmap(struct vfio_pci_device *device,
-				 struct vfio_dma_region *region)
+static int vfio_iommu_dma_unmap(int fd, u64 iova, u64 size, u32 flags,
+				u64 *unmapped)
 {
 	struct vfio_iommu_type1_dma_unmap args = {
 		.argsz = sizeof(args),
-		.iova = region->iova,
-		.size = region->size,
+		.iova = iova,
+		.size = size,
+		.flags = flags,
 	};
 
-	ioctl_assert(device->container_fd, VFIO_IOMMU_UNMAP_DMA, &args);
+	if (ioctl(fd, VFIO_IOMMU_UNMAP_DMA, &args))
+		return -errno;
+
+	if (unmapped)
+		*unmapped = args.size;
+
+	return 0;
 }
 
-static void iommufd_dma_unmap(struct vfio_pci_device *device,
-			      struct vfio_dma_region *region)
+static int iommufd_dma_unmap(int fd, u64 iova, u64 length, u32 ioas_id,
+			     u64 *unmapped)
 {
 	struct iommu_ioas_unmap args = {
 		.size = sizeof(args),
-		.iova = region->iova,
-		.length = region->size,
-		.ioas_id = device->ioas_id,
+		.iova = iova,
+		.length = length,
+		.ioas_id = ioas_id,
 	};
 
-	ioctl_assert(device->iommufd, IOMMU_IOAS_UNMAP, &args);
+	if (ioctl(fd, IOMMU_IOAS_UNMAP, &args))
+		return -errno;
+
+	if (unmapped)
+		*unmapped = args.length;
+
+	return 0;
 }
 
-void vfio_pci_dma_unmap(struct vfio_pci_device *device,
-			struct vfio_dma_region *region)
+int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
+			 struct vfio_dma_region *region, u64 *unmapped)
 {
+	int ret;
+
 	if (device->iommufd)
-		iommufd_dma_unmap(device, region);
+		ret = iommufd_dma_unmap(device->iommufd, region->iova,
+					region->size, device->ioas_id,
+					unmapped);
 	else
-		vfio_iommu_dma_unmap(device, region);
+		ret = vfio_iommu_dma_unmap(device->container_fd, region->iova,
+					   region->size, 0, unmapped);
+
+	if (ret)
+		return ret;
+
+	list_del_init(&region->link);
+
+	return 0;
+}
+
+int __vfio_pci_dma_unmap_all(struct vfio_pci_device *device, u64 *unmapped)
+{
+	int ret;
+	struct vfio_dma_region *curr, *next;
+
+	if (device->iommufd)
+		ret = iommufd_dma_unmap(device->iommufd, 0, UINT64_MAX,
+					device->ioas_id, unmapped);
+	else
+		ret = vfio_iommu_dma_unmap(device->container_fd, 0, 0,
+					   VFIO_DMA_UNMAP_FLAG_ALL, unmapped);
+
+	if (ret)
+		return ret;
+
+	list_for_each_entry_safe(curr, next, &device->dma_regions, link) {
+		list_del_init(&curr->link);
+	}
 
-	list_del(&region->link);
+	return 0;
 }
 
 static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index ab19c54a774d..a38966e8e5a6 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -129,6 +129,7 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	struct vfio_dma_region region;
 	struct iommu_mapping mapping;
 	u64 mapping_size = size;
+	u64 unmapped;
 	int rc;
 
 	region.vaddr = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
@@ -184,7 +185,9 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	}
 
 unmap:
-	vfio_pci_dma_unmap(self->device, &region);
+	rc = __vfio_pci_dma_unmap(self->device, &region, &unmapped);
+	ASSERT_EQ(rc, 0);
+	ASSERT_EQ(unmapped, region.size);
 	printf("Unmapped IOVA 0x%lx\n", region.iova);
 	ASSERT_EQ(INVALID_IOVA, __to_iova(self->device, region.vaddr));
 	ASSERT_NE(0, iommu_mapping_get(device_bdf, region.iova, &mapping));

-- 
2.47.3


