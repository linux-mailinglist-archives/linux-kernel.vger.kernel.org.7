Return-Path: <linux-kernel+bounces-731273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8177B0520C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A992B4E29CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA0A26F462;
	Tue, 15 Jul 2025 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzkcZiXw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD2271478
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561710; cv=none; b=JQ5OiF4V66vQdo9dlhbKlwnPYwe0hdeJgmkH09YVk9foMDHBFcbgnh8PLGi22zkdzxDtny9hyBEK41+QdJqqzoagotb6Qnt+ijaVo5jL9nHqJUPVMvuaQpLGErDdz27afZ142kU/KwFclAIT/MxsGKgXhw65NWZ0rfx708rerKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561710; c=relaxed/simple;
	bh=XQxU2MzFiVEMn0002F0j2LQdy7BvNN5+2QDQyQV5dAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d/k7W73PDbIC9WYYkTUhrR3CGR5vg/1Z0Nq/xuPFZelNBUO0ZwRUKgXPkk8B2YEzmqhJC2j3/XKDDpO01jlEkYeDGrKDjC7A90bTaPl5kW/kLooBo2rrXFQv+jVymf5aB8zZAZZRq7D//FPdt9sGKpRETK/PuwV0HI9v96Ch9gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzkcZiXw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752561709; x=1784097709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XQxU2MzFiVEMn0002F0j2LQdy7BvNN5+2QDQyQV5dAQ=;
  b=VzkcZiXwOlrehMHaYfwbuHmN6xYeMeDDaqJRzzTxR43Bfe02uPwfIk6T
   ltqUY7lZy4MlyuQe7BTbmNkixLL2v1Ea2NKiLoIQzKPQYKREozHr18GY5
   GWXoFzx89aLKvoRrQU8kgQ7eQlowWHTFPBYsP3FDhXYc+DkHiwCHaaUMw
   DOjyVa7o3sOjIs22YsUGM8RZa5yCq8nbcft7wUutUlTbQVtI5K6RovDGD
   qDndeNIzi4WVhfbSc1W7GL2E+9LYse/t9BTtXjgWAmqENUWAZqsFurzAO
   0fx+in8L6D9pT5YBBWo93q0bWj6PDL5qFgydwqHXHKU7s+LgW6s2leGiw
   g==;
X-CSE-ConnectionGUID: EMbHsp9hQ+e6qySD2Nxgxg==
X-CSE-MsgGUID: 6gBAb++SQKi8hjrZkXNyQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53880893"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="53880893"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:41:49 -0700
X-CSE-ConnectionGUID: nIpZZPhDQdm4kBqk5/utDA==
X-CSE-MsgGUID: tdsCWviJQzKHVoi93y4CSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157649039"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2025 23:41:44 -0700
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
Subject: [PATCH v5 6/8] iommufd/selftest: Explicitly skip tests for inapplicable variant
Date: Tue, 15 Jul 2025 14:32:43 +0800
Message-Id: <20250715063245.1799534-7-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

no_viommu is not applicable for some viommu/vdevice tests. Explicitly
report the skipping, don't do it silently.

Opportunistically adjust the line wrappings after the indentation
changes using git clang-format.

Only add the prints. No functional change intended.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 365 ++++++++++++------------
 1 file changed, 178 insertions(+), 187 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index d59d48022a24..16ea10ea1dbf 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2779,35 +2779,34 @@ TEST_F(iommufd_viommu, viommu_alloc_nested_iopf)
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
+	test_err_hwpt_alloc_iopf(ENOENT, dev_id, viommu_id, UINT32_MAX,
+				 IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
+				 IOMMU_HWPT_DATA_SELFTEST, &data,
+				 sizeof(data));
+	test_err_hwpt_alloc_iopf(EOPNOTSUPP, dev_id, viommu_id, fault_id,
+				 IOMMU_HWPT_FAULT_ID_VALID | (1 << 31),
+				 &iopf_hwpt_id, IOMMU_HWPT_DATA_SELFTEST, &data,
+				 sizeof(data));
+	test_cmd_hwpt_alloc_iopf(dev_id, viommu_id, fault_id,
+				 IOMMU_HWPT_FAULT_ID_VALID, &iopf_hwpt_id,
+				 IOMMU_HWPT_DATA_SELFTEST, &data,
+				 sizeof(data));
 
-		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
-		test_ioctl_destroy(iopf_hwpt_id);
-		close(fault_fd);
-		test_ioctl_destroy(fault_id);
-	}
+	/* Must allocate vdevice before attaching to a nested hwpt */
+	test_err_mock_domain_replace(ENOENT, self->stdev_id, iopf_hwpt_id);
+	test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+	test_cmd_mock_domain_replace(self->stdev_id, iopf_hwpt_id);
+	EXPECT_ERRNO(EBUSY, _test_ioctl_destroy(self->fd, iopf_hwpt_id));
+	test_cmd_trigger_iopf(dev_id, fault_fd);
+
+	test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
+	test_ioctl_destroy(iopf_hwpt_id);
+	close(fault_fd);
+	test_ioctl_destroy(fault_id);
 }
 
 TEST_F(iommufd_viommu, viommu_alloc_with_data)
@@ -2902,169 +2901,161 @@ TEST_F(iommufd_viommu, vdevice_cache)
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
+	if (!dev_id)
+		SKIP(return, "Skipping test for variant no_viommu");
 
-		/* Negative test: invalid vdev_id */
-		num_inv = 1;
-		inv_reqs[0].flags = 0;
-		inv_reqs[0].vdev_id = 0x9;
-		inv_reqs[0].cache_id = 0;
-		test_err_viommu_invalidate(EINVAL, viommu_id, inv_reqs,
-					   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST,
-					   sizeof(*inv_reqs), &num_inv);
-		assert(!num_inv);
+	test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+
+	test_cmd_dev_check_cache_all(dev_id, IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+	/* Check data_type by passing zero-length array */
+	num_inv = 0;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs, sizeof(*inv_reqs),
+				   &num_inv);
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
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST, 1,
+				   &num_inv);
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
+				   IOMMU_VIOMMU_INVALIDATE_DATA_SELFTEST, 0,
+				   &num_inv);
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
-
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
+	test_cmd_dev_check_cache(dev_id, 1, IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 2, IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 3, IOMMU_TEST_DEV_CACHE_DEFAULT);
 
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
+	test_cmd_dev_check_cache(dev_id, 1, IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 2, IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 3, IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+	/* Invalidate the 2nd cache entry and verify */
+	num_inv = 1;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = 1;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs, sizeof(*inv_reqs),
+				   &num_inv);
+	assert(num_inv == 1);
+	test_cmd_dev_check_cache(dev_id, 0, 0);
+	test_cmd_dev_check_cache(dev_id, 1, 0);
+	test_cmd_dev_check_cache(dev_id, 2, IOMMU_TEST_DEV_CACHE_DEFAULT);
+	test_cmd_dev_check_cache(dev_id, 3, IOMMU_TEST_DEV_CACHE_DEFAULT);
+
+	/* Invalidate the 3rd and 4th cache entries and verify */
+	num_inv = 2;
+	inv_reqs[0].flags = 0;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].cache_id = 2;
+	inv_reqs[1].flags = 0;
+	inv_reqs[1].vdev_id = 0x99;
+	inv_reqs[1].cache_id = 3;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs, sizeof(*inv_reqs),
+				   &num_inv);
+	assert(num_inv == 2);
+	test_cmd_dev_check_cache_all(dev_id, 0);
+
+	/* Invalidate all cache entries for nested_dev_id[1] and verify */
+	num_inv = 1;
+	inv_reqs[0].vdev_id = 0x99;
+	inv_reqs[0].flags = IOMMU_TEST_INVALIDATE_FLAG_ALL;
+	test_cmd_viommu_invalidate(viommu_id, inv_reqs, sizeof(*inv_reqs),
+				   &num_inv);
+	assert(num_inv == 1);
+	test_cmd_dev_check_cache_all(dev_id, 0);
+	test_ioctl_destroy(vdev_id);
 }
 
 TEST_F(iommufd_viommu, hw_queue)
-- 
2.25.1


