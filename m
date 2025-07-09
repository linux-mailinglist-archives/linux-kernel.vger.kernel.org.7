Return-Path: <linux-kernel+bounces-722780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83E7AFDEB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E847AF9CE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B76262FF5;
	Wed,  9 Jul 2025 04:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8DF9Tg+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5FB26980E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 04:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752034279; cv=none; b=eQvHMo9JlSpXMVpSXrzC+5gnUpEja4VRLDO0ZeoSNMltoXbDGtMU34FXvvmLvoltBBjxwOjOKQKRi1s5wQW6cnNCcu4znF3EjaNlp+oFrraaItmgZToRfqs8UywExCGJ+19T/xdNNbbmum01c79XILZqgYz552XVfDawbHLXu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752034279; c=relaxed/simple;
	bh=5K3hjXlq1bJbDVwkTQ7HOvyFRpMm3vCq2rxlBOIv/Vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kBmvre5NGYC4isQXdGWEfl9S6kb+U0KTwpaox2TM5hDALXT4FChNxQUc7NAywY923nVkNuWFnFIzwlA8ZP3/ih7KrYsjfcuAQ0E+zppKb1e9jDWBvvHySdNv282od7ZEwCIBCzHmFwDFXcEuDIiu5GItIgSa1tQY998b424zkjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8DF9Tg+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752034278; x=1783570278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5K3hjXlq1bJbDVwkTQ7HOvyFRpMm3vCq2rxlBOIv/Vg=;
  b=W8DF9Tg+xc/tOmKFb5d1m2n8LffTJrHqe6iEf2y0qn+nFPTuFTwphMOR
   7PKtmW/zbV+nwMo5fBrsA/iKN5S+Yl+Wn45IzmVdzxouTKVNhk255j4fS
   9zR80Pae1k4lC4Zw2nEXkPYuAXhCiI8F2DptA5qX39p2aAeqqe54PwV7k
   fwZykBenFQR0jVRPNGXxkNx24HDwUO0LP4BjY/SwMRmrWCFAx6eIxhVXu
   LGkdfh10HWYJJXGhBmWbHhM1R9ZE/qnQ2yKId5aN8i10VLOtkRG0lA0Yt
   0xXH0x/obuzIRusf0+ptXcs9EvzOy5aUjxHlmppqoT1NxEC3uxR7No9+n
   g==;
X-CSE-ConnectionGUID: s8H0lRsbQ1a9yGfM1Dddmg==
X-CSE-MsgGUID: xNBP6U4aRcitL/gGirjpXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76831830"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="76831830"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 21:11:17 -0700
X-CSE-ConnectionGUID: dK7KQQtQS7+r7JfzlQKGJQ==
X-CSE-MsgGUID: 7Ck2RSqvRVyKGCv0Ud9xlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192851666"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 08 Jul 2025 21:11:14 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	shuah@kernel.org,
	nicolinc@nvidia.com,
	aik@amd.com,
	dan.j.williams@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v4 6/7] iommufd/selftest: Explicitly skip tests for inapplicable variant
Date: Wed,  9 Jul 2025 12:02:33 +0800
Message-Id: <20250709040234.1773573-7-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

no_viommu is not applicable for some viommu/vdevice tests. Explicitly
report the skipping, don't do it silently.

Only add the prints. No functional change intended.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 378 ++++++++++++------------
 1 file changed, 190 insertions(+), 188 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 1a8e85afe9aa..4a9b6e3b37fa 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2760,35 +2760,36 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
 	uint32_t fault_fd;
 	uint32_t vdev_id;
 
-	if (self->device_id) {
-		test_ioctl_fault_alloc(&fault_id, &fault_fd);
-		test_err_hwpt_alloc_iopf(
-			ENOENT, dev_id, viommu_id, UINT32_MAX,
-			IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
-			IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
-		test_err_hwpt_alloc_iopf(
-			EOPNOTSUPP, dev_id, viommu_id, fault_id,
-			IOMMU_HWPT_FAULT_ID_VALID | (1 << 31), &iopf_hwpt_id,
-			IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
-		test_cmd_hwpt_alloc_iopf(
-			dev_id, viommu_id, fault_id, IOMMU_HWPT_FAULT_ID_VALID,
-			&iopf_hwpt_id, IOMMU_HWPT_DATA_SELFTEST, &data,
-			sizeof(data));
+	if (!dev_id)
+		SKIP(return, "Skipping test for variant no_viommu");
 
-		/* Must allocate vdevice before attaching to a nested hwpt */
-		test_err_mock_domain_replace(ENOENT, self->stdev_id,
-					     iopf_hwpt_id);
-		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
-		test_cmd_mock_domain_replace(self->stdev_id, iopf_hwpt_id);
-		EXPECT_ERRNO(EBUSY,
-			     _test_ioctl_destroy(self->fd, iopf_hwpt_id));
-		test_cmd_trigger_iopf(dev_id, fault_fd);
+	test_ioctl_fault_alloc(&fault_id, &fault_fd);
+	test_err_hwpt_alloc_iopf(
+		ENOENT, dev_id, viommu_id, UINT32_MAX,
+		IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
+		IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
+	test_err_hwpt_alloc_iopf(
+		EOPNOTSUPP, dev_id, viommu_id, fault_id,
+		IOMMU_HWPT_FAULT_ID_VALID | (1 << 31), &iopf_hwpt_id,
+		IOMMU_HWPT_DATA_SELFTEST, &data, sizeof(data));
+	test_cmd_hwpt_alloc_iopf(
+		dev_id, viommu_id, fault_id, IOMMU_HWPT_FAULT_ID_VALID,
+		&iopf_hwpt_id, IOMMU_HWPT_DATA_SELFTEST, &data,
+		sizeof(data));
+
+	/* Must allocate vdevice before attaching to a nested hwpt */
+	test_err_mock_domain_replace(ENOENT, self->stdev_id,
+				     iopf_hwpt_id);
+	test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+	test_cmd_mock_domain_replace(self->stdev_id, iopf_hwpt_id);
+	EXPECT_ERRNO(EBUSY,
+		     _test_ioctl_destroy(self->fd, iopf_hwpt_id));
+	test_cmd_trigger_iopf(dev_id, fault_fd);
 
-		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
-		test_ioctl_destroy(iopf_hwpt_id);
-		close(fault_fd);
-		test_ioctl_destroy(fault_id);
-	}
+	test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+	test_ioctl_destroy(iopf_hwpt_id);
+	close(fault_fd);
+	test_ioctl_destroy(fault_id);
 }
 
 TEST_F(iommufd_viommu, vdevice_alloc)
@@ -2849,169 +2850,170 @@ TEST_F(iommufd_viommu, vdevice_cache)
 	uint32_t vdev_id = 0;
 	uint32_t num_inv;
 
-	if (dev_id) {
-		test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
-
-		test_cmd_dev_check_cache_all(dev_id,
-					     IOMMU_TEST_DEV_CACHE_DEFAULT);
-
-		/* Check data_type by passing zero-length array */
-		num_inv = 0;
-		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
-
-		/* Negative test: Invalid data_type */
-		num_inv = 1;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
-
-		/* Negative test: structure size sanity */
-		num_inv = 1;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs) + 1, &num_inv);
-		assert(!num_inv);
-
-		num_inv = 1;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   1, &num_inv);
-		assert(!num_inv);
-
-		/* Negative test: invalid flag is passed */
-		num_inv = 1;
-		inv_reqs[0].flags = 0xffffffff;
-		inv_reqs[0].vdev_id = 0x99;
-		test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
-
-		/* Negative test: invalid data_uptr when array is not empty */
-		num_inv = 1;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		test_err_viommu_invalidate(EINVAL, viommu_id, NULL,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
-
-		/* Negative test: invalid entry_len when array is not empty */
-		num_inv = 1;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   0, &num_inv);
-		assert(!num_inv);
-
-		/* Negative test: invalid cache_id */
-		num_inv = 1;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		inv_reqs[0].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
-
-		/* Negative test: invalid vdev_id */
-		num_inv = 1;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x9;
-		inv_reqs[0].cache_id = 0;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
-
-		/*
-		 * Invalidate the 1st cache entry but fail the 2nd request
-		 * due to invalid flags configuration in the 2nd request.
-		 */
-		num_inv = 2;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		inv_reqs[0].cache_id = 0;
-		inv_reqs[1].flags = 0xffffffff;
-		inv_reqs[1].vdev_id = 0x99;
-		inv_reqs[1].cache_id = 1;
-		test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 1);
-		test_cmd_dev_check_cache(dev_id, 0, 0);
-		test_cmd_dev_check_cache(dev_id, 1,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-		test_cmd_dev_check_cache(dev_id, 2,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-		test_cmd_dev_check_cache(dev_id, 3,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
+	if (!dev_id)
+		SKIP(return, "Skipping test for variant no_viommu");
+
+	test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+
+	test_cmd_dev_check_cache_all(dev_id,
+				     IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+	/* Check data_type by passing zero-length array */
+	num_inv = 0;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: Invalid data_type */
+	num_inv = 1;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST_INVALID,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: structure size sanity */
+	num_inv = 1;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs) + 1, &num_inv);
+	assert(!num_inv);
+
+	num_inv = 1;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   1, &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: invalid flag is passed */
+	num_inv = 1;
+	inv_reqs[0].flags = 0xffffffff;
+	inv_reqs[0].vdev_id = 0x99;
+	test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: invalid data_uptr when array is not empty */
+	num_inv = 1;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	test_err_viommu_invalidate(EINVAL, viommu_id, NULL,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: invalid entry_len when array is not empty */
+	num_inv = 1;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   0, &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: invalid cache_id */
+	num_inv = 1;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(!num_inv);
+
+	/* Negative test: invalid vdev_id */
+	num_inv = 1;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x9;
+	inv_reqs[0].cache_id = 0;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(!num_inv);
 
-		/*
-		 * Invalidate the 1st cache entry but fail the 2nd request
-		 * due to invalid cache_id configuration in the 2nd request.
-		 */
-		num_inv = 2;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		inv_reqs[0].cache_id = 0;
-		inv_reqs[1].flags = 0;
-		inv_reqs[1].vdev_id = 0x99;
-		inv_reqs[1].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 1);
-		test_cmd_dev_check_cache(dev_id, 0, 0);
-		test_cmd_dev_check_cache(dev_id, 1,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-		test_cmd_dev_check_cache(dev_id, 2,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-		test_cmd_dev_check_cache(dev_id, 3,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-
-		/* Invalidate the 2nd cache entry and verify */
-		num_inv = 1;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		inv_reqs[0].cache_id = 1;
-		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 1);
-		test_cmd_dev_check_cache(dev_id, 0, 0);
-		test_cmd_dev_check_cache(dev_id, 1, 0);
-		test_cmd_dev_check_cache(dev_id, 2,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-		test_cmd_dev_check_cache(dev_id, 3,
-					 IOMMU_TEST_DEV_CACHE_DEFAULT);
-
-		/* Invalidate the 3rd and 4th cache entries and verify */
-		num_inv = 2;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x99;
-		inv_reqs[0].cache_id = 2;
-		inv_reqs[1].flags = 0;
-		inv_reqs[1].vdev_id = 0x99;
-		inv_reqs[1].cache_id = 3;
-		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 2);
-		test_cmd_dev_check_cache_all(dev_id, 0);
+	/*
+	 * Invalidate the 1st cache entry but fail the 2nd request
+	 * due to invalid flags configuration in the 2nd request.
+	 */
+	num_inv = 2;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = 0;
+	inv_reqs[1].flags = 0xffffffff;
+	inv_reqs[1].vdev_id = 0x99;
+	inv_reqs[1].cache_id = 1;
+	test_err_viommu_invalidate(EOPNOTSUPP, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(num_inv == 1);
+	test_cmd_dev_check_cache(dev_id, 0, 0);
+	test_cmd_dev_check_cache(dev_id, 1,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 2,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 3,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
 
-		/* Invalidate all cache entries for nested_dev_id[1] and verify */
-		num_inv = 1;
-		inv_reqs[0].vdev_id = 0x99;
-		inv_reqs[0].flags = IOMMU_TEST_INVALIDATE_FLAG_ALL;
-		test_cmd_viommu_invalidate(viommu_id, inv_reqs,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(num_inv == 1);
-		test_cmd_dev_check_cache_all(dev_id, 0);
-		test_ioctl_destroy(vdev_id);
-	}
+	/*
+	 * Invalidate the 1st cache entry but fail the 2nd request
+	 * due to invalid cache_id configuration in the 2nd request.
+	 */
+	num_inv = 2;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = 0;
+	inv_reqs[1].flags = 0;
+	inv_reqs[1].vdev_id = 0x99;
+	inv_reqs[1].cache_id = MOCK_DEV_CACHE_ID_MAX + 1;
+	test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(num_inv == 1);
+	test_cmd_dev_check_cache(dev_id, 0, 0);
+	test_cmd_dev_check_cache(dev_id, 1,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 2,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 3,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+	/* Invalidate the 2nd cache entry and verify */
+	num_inv = 1;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = 1;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(num_inv == 1);
+	test_cmd_dev_check_cache(dev_id, 0, 0);
+	test_cmd_dev_check_cache(dev_id, 1, 0);
+	test_cmd_dev_check_cache(dev_id, 2,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 3,
+				 IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+	/* Invalidate the 3rd and 4th cache entries and verify */
+	num_inv = 2;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = 2;
+	inv_reqs[1].flags = 0;
+	inv_reqs[1].vdev_id = 0x99;
+	inv_reqs[1].cache_id = 3;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(num_inv == 2);
+	test_cmd_dev_check_cache_all(dev_id, 0);
+
+	/* Invalidate all cache entries for nested_dev_id[1] and verify */
+	num_inv = 1;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].flags = IOMMU_TEST_INVALIDATE_FLAG_ALL;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs,
+				   sizeof(*inv_reqs), &num_inv);
+	assert(num_inv == 1);
+	test_cmd_dev_check_cache_all(dev_id, 0);
+	test_ioctl_destroy(vdev_id);
 }
 
 FIXTURE(iommufd_device_pasid)
-- 
2.25.1


