Return-Path: <linux-kernel+bounces-874209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CE1C15C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399213A2438
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2988288C0A;
	Tue, 28 Oct 2025 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="HOKKYZtr"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3928467D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668121; cv=none; b=H1D9J8bYbGNm7IobXIqTENGbE0DPAljByh1+Rn/wR0WjAjmpLNsZ4zc6/V5ydIoM56RDPYiKqVNuOnWggMUfeTWzYjAeVh5XifpC9CcvMmPOeh5z7et5qNq16GDrg3He2es7JIUff0Qb6S3sddq3w1jBaJmwJYkpx/kUsIleorg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668121; c=relaxed/simple;
	bh=tzggaxR9FZMIzBPQS8Uhk5DQQIJ5mAFzxbGJIArHuc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=C364zHDKjCR+J5UHPpiTXlps/L4StnHI2XSDmvuKOCgYZJx7vPdr8PdLM7c9AUHvifph33/eQ7ff9R+tQVNuVb7W/TvbNmNN8G8FY5jBGZ3N7cpBDDkUkAjrYLk4aRDFT91R2uNhS+j13ayckJWFZRaIMDj9mf8w1m1BN8mWMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=HOKKYZtr; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SFNmrj3079406
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:15:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=jL27jaMKNMd3868BGcN8P3oHAzLxge4Xak38+P/R528=; b=HOKKYZtrgrl4
	TqOmQtT1fJ7qYwIMUqejfa+hMZWFT2/r+0YdM5IzfY2RBNSJ9DlQVqI4XQgRMc36
	S2c1E3KCdvyar50lqlSKk7oWPFMyoJKUxfF0RS2/hB0SHnxiq8OmGiDy6Z4l8+yV
	xheMDaYD3YUP3P5Cl8Nf/K63Z79ixNnyR6jEAAm0/GBSP43FrYBXPrd+lZYBZl/T
	mTir10MOmaKkycV87BEdwfouqVFxmCpzURfTawcEhNXIciJEPmamly1Jo3O3NEIw
	IxtCIw1+dWgvcDke4ADhvVICa8Uhn5J6Ojjmo79dP3//FBIdkcg5m5EFnwPZNR/r
	YkgZs5YC+A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a30egggem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:15:19 -0700 (PDT)
Received: from twshared15465.32.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 28 Oct 2025 16:15:12 +0000
Received: by devgpu012.nha5.facebook.com (Postfix, from userid 28580)
	id 0778E51293D; Tue, 28 Oct 2025 09:15:05 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
Date: Tue, 28 Oct 2025 09:15:04 -0700
Subject: [PATCH v6 5/5] vfio: selftests: add end of address space DMA
 map/unmap tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251028-fix-unmap-v6-5-2542b96bcc8e@fb.com>
References: <20251028-fix-unmap-v6-0-2542b96bcc8e@fb.com>
In-Reply-To: <20251028-fix-unmap-v6-0-2542b96bcc8e@fb.com>
To: Alex Williamson <alex@shazbot.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>,
        David Matlack <dmatlack@google.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Alex Mastro
	<amastro@fb.com>
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDEzNyBTYWx0ZWRfXwd8NAJOk14nK
 z2ldXud0GkOPtu8yuhuKy9j3La8U8BL9arW9mTUloALm0FqcEqDP1CVgPw0jDCnsFHnkY6ga1rN
 Dn5/KcVW0LRFithZE20fjtls29dUAMp64kzGdoW69wiKOpOBYbk9eRY0gtmF/PNPkWTHugdvl1e
 bwahXpbPCFeImEFqn4BtpBf8a7d06FV4iH5ad0qPDTYoAAwEpzftxFFq3f6IgZvM7L9btLusB31
 25Imfhw5X7RK7aktkcCfXt6RmX1TWryCQeMPwXo4G7AI3Ds0ZkOOPzT6Ww9rDuRHn46lceC5ZMN
 R7VoLzTsBoufoNuUFOdtIh3G3J8JlGEi8ApI0ABzjcZkTFtoF7P/6IGj/JmRglnt1vWJXUVXJt4
 NG12t7Txo3pRO3d07dVet/iSiQpf5Q==
X-Proofpoint-GUID: 421no4rqLIP4UGgGIipuBk3VCLAKaQ7Y
X-Authority-Analysis: v=2.4 cv=PNkCOPqC c=1 sm=1 tr=0 ts=6900ec17 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=FOH2dFAWAAAA:8 a=wf1ge7rc0ZxdfOmzxhAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 421no4rqLIP4UGgGIipuBk3VCLAKaQ7Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01

Add tests which validate dma map/unmap at the end of address space. Add
negative test cases for checking that overflowing ioctl args fail with
the expected errno.

Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Alex Mastro <amastro@fb.com>
---
 .../testing/selftests/vfio/vfio_dma_mapping_test.c | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index a38966e8e5a6..4f1ea79a200c 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -112,6 +112,8 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous, 0, 0);
 FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_2mb, SZ_2M, MAP_HUGETLB | MAP_HUGE_2MB);
 FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB | MAP_HUGE_1GB);
 
+#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
+
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
 	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
@@ -195,6 +197,94 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
 	ASSERT_TRUE(!munmap(region.vaddr, size));
 }
 
+FIXTURE(vfio_dma_map_limit_test) {
+	struct vfio_pci_device *device;
+	struct vfio_dma_region region;
+	size_t mmap_size;
+};
+
+FIXTURE_VARIANT(vfio_dma_map_limit_test) {
+	const char *iommu_mode;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode)			       \
+FIXTURE_VARIANT_ADD(vfio_dma_map_limit_test, _iommu_mode) {		       \
+	.iommu_mode = #_iommu_mode,					       \
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
+
+#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
+
+FIXTURE_SETUP(vfio_dma_map_limit_test)
+{
+	struct vfio_dma_region *region = &self->region;
+	u64 region_size = getpagesize();
+
+	/*
+	 * Over-allocate mmap by double the size to provide enough backing vaddr
+	 * for overflow tests
+	 */
+	self->mmap_size = 2 * region_size;
+
+	self->device = vfio_pci_device_init(device_bdf, variant->iommu_mode);
+	region->vaddr = mmap(NULL, self->mmap_size, PROT_READ | PROT_WRITE,
+			     MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(region->vaddr, MAP_FAILED);
+
+	/* One page prior to the end of address space */
+	region->iova = ~(iova_t)0 & ~(region_size - 1);
+	region->size = region_size;
+}
+
+FIXTURE_TEARDOWN(vfio_dma_map_limit_test)
+{
+	vfio_pci_device_cleanup(self->device);
+	ASSERT_EQ(munmap(self->region.vaddr, self->mmap_size), 0);
+}
+
+TEST_F(vfio_dma_map_limit_test, unmap_range)
+{
+	struct vfio_dma_region *region = &self->region;
+	u64 unmapped;
+	int rc;
+
+	vfio_pci_dma_map(self->device, region);
+	ASSERT_EQ(region->iova, to_iova(self->device, region->vaddr));
+
+	rc = __vfio_pci_dma_unmap(self->device, region, &unmapped);
+	ASSERT_EQ(rc, 0);
+	ASSERT_EQ(unmapped, region->size);
+}
+
+TEST_F(vfio_dma_map_limit_test, unmap_all)
+{
+	struct vfio_dma_region *region = &self->region;
+	u64 unmapped;
+	int rc;
+
+	vfio_pci_dma_map(self->device, region);
+	ASSERT_EQ(region->iova, to_iova(self->device, region->vaddr));
+
+	rc = __vfio_pci_dma_unmap_all(self->device, &unmapped);
+	ASSERT_EQ(rc, 0);
+	ASSERT_EQ(unmapped, region->size);
+}
+
+TEST_F(vfio_dma_map_limit_test, overflow)
+{
+	struct vfio_dma_region *region = &self->region;
+	int rc;
+
+	region->size = self->mmap_size;
+
+	rc = __vfio_pci_dma_map(self->device, region);
+	ASSERT_EQ(rc, -EOVERFLOW);
+
+	rc = __vfio_pci_dma_unmap(self->device, region, NULL);
+	ASSERT_EQ(rc, -EOVERFLOW);
+}
+
 int main(int argc, char *argv[])
 {
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);

-- 
2.47.3


