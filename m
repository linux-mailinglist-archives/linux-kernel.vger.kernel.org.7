Return-Path: <linux-kernel+bounces-872240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34035C0FAF6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2D119C0387
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7931A051;
	Mon, 27 Oct 2025 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="J3tUBHb4"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBD43176E6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586455; cv=none; b=r650Dxphl3ebnzMNNFbMN2sVymF81jSaN6zTgL4qsCMvFT4JoQXxDeyN9m50Zrkm/cmynKRjoQkQJkc+nnESS8/T8S18vBeblmjLli5CDGtNUWPAnJn4x4hhyxhJKlgMZgSa0Omi9trGeNICHHqlDqFaeUNmUUU0SDZ0raLr0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586455; c=relaxed/simple;
	bh=H9IL4XRZ3ZnMteiXQauLbRFmZlQrFK0JU+yM7o2khx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EfVY3OqdUrdNEm3qtpK6KQVg1D284O5qCTpwk7k9nWzdYoai9y03Cvpemb69ERJq12ChQu7Ap6ayCOodGwKZefJqdQU9kIn+BzKOj84GnkwcJySfXb9S0AGavAMdp3Dy182fEaT9JSlJTGHVyp4OInp0a6hg19//es0KWThzf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=J3tUBHb4; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RHTWP01219781
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:34:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=pc2Zitp21NxmWPvKCj1mQ9fXN3rBoC1SGqxs7K25EH4=; b=J3tUBHb4iZKK
	YrGN91JRM8FRkCopM1CteHkSE0fDty1npA5fKtGLBwGmJyzYeo0XKE6vEfuESr99
	LgpH1pjGBE14/0Hpc4p3lVMQTtiW7KvJp0A1ztGgXCprgsBubXycsAFcR/oyHPHI
	6u0IP9Kms5LZz59tzyhT6yc5LI9lNjAjv0cQK0ro/w3VUNdMurmzNNP0AQ/nCviV
	16zTQm/qEp2arxG2fvlzqxK4+Psr3tGLa4kA7+d1BK+YgIZ0zgscFVd/wg8kdwz9
	P0AyNhmHTPm09g1WPhKCoX5yDatgyKPvTJNewqOoBaFsDz/wyu3tjHiZI4P8UPHS
	W/FojrZuvw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a284etxgs-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:34:12 -0700 (PDT)
Received: from twshared125961.16.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 27 Oct 2025 17:34:11 +0000
Received: by devgpu012.nha5.facebook.com (Postfix, from userid 28580)
	id 8211F43E09C; Mon, 27 Oct 2025 10:33:57 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
Date: Mon, 27 Oct 2025 10:33:45 -0700
Subject: [PATCH v5 5/5] vfio: selftests: add end of address space DMA
 map/unmap tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251027-fix-unmap-v5-5-4f0fcf8ffb7d@fb.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE2MyBTYWx0ZWRfX9gr8tmQWZJPA
 efPHJs7TqzdG/vDGmbZpOaP38tpB4pcrp+lMzuDXaARmz84T+uWDINGf97caubDjH5fFvGPmRpc
 MuMVyAVbgGWmrOpPjPvEi4DEFAF7kkA9DgcBt/SFNsdaAo9pCsJ41r0EZYpmy8dP8Rh2sLcvG1o
 +4bqc91GQ0IeG18gsLzCNQNbFex/7ToDmDME3YnjBeG/CqoVTupSxkhMCPaqpwsGwxA5eIl9lF5
 Rlm/ApYHXLLHFVWD9jk8IAjffkMpDWQBy48egbYz1C0LhCzmw4H7Q1F0I6aOfGBZuPLzwXyB3AJ
 80tHJeQ3V1xmL04hEi5xN3wjAj9AAXliNE0zyx0iyDfiYbZVA6Q9JK4Dfji4kLYbwT53Aj3h8ux
 EmLUTH8nVV8Utardby38i8B1Ob6mOQ==
X-Proofpoint-ORIG-GUID: UWw_IfPADrF_v9Q44csJMw_vBs58e2lB
X-Proofpoint-GUID: UWw_IfPADrF_v9Q44csJMw_vBs58e2lB
X-Authority-Analysis: v=2.4 cv=OaWVzxTY c=1 sm=1 tr=0 ts=68ffad14 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=roStD_RBd83EyHEBywkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01

Add tests which validate dma map/unmap at the end of address space. Add
negative test cases for checking that overflowing ioctl args fail with
the expected errno.

Signed-off-by: Alex Mastro <amastro@fb.com>
---
 .../testing/selftests/vfio/vfio_dma_mapping_test.c | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index a38966e8e5a6..2c38bc17232e 100644
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
@@ -195,6 +197,93 @@ TEST_F(vfio_dma_mapping_test, dma_map_unmap)
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
+	u64 region_size = getpagesize();
+	/*
+	 * Over-allocate mmap by double the size to provide enough backing vaddr
+	 * for overflow tests
+	 */
+	self->mmap_size = 2 * region_size;
+	struct vfio_dma_region *region = &self->region;
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


