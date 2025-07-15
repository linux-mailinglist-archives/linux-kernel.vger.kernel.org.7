Return-Path: <linux-kernel+bounces-731274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED68B0520D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558314E2F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB66272E65;
	Tue, 15 Jul 2025 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jN7IV/Oh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87248272806
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561713; cv=none; b=NrGFDBMVOHMihPTllhsidZW5auTv7bNc9Fk8NkrLncvaa0JqT7IPugfquZvyU4SZ3ki1aUFbvKbYYKb23OYNh0GRBV/byUCg0mm37Ud31KmC1/U0jGbI/lebilDia/nc42Sqmoaz9J7idKrMA0KxElgw+bIFkU7rmcvDoEFXjAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561713; c=relaxed/simple;
	bh=+FnZBthc0QfK6q6BLjuKbUJ1xSApwzKyXwldHpF8ahA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UNa9R94OJAs7o2q/+lTZWTdRfT/SI+kIsWVU4Ol25MS8OpBACEi6PFUdp+wFLkB5XdusOD/3QJUDL0Lsrp9uXfXdMtJ5B+XIdgUvM7wzoZGtpX84Sgky0o/Rs972WMWtNck9tFevLV13n5zAaA7pfwJRobdHnjidOYlpzBoCU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jN7IV/Oh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752561713; x=1784097713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+FnZBthc0QfK6q6BLjuKbUJ1xSApwzKyXwldHpF8ahA=;
  b=jN7IV/OhuV/U7PkSOc5q9j0KDgcP3f0NDECzrW451t9cbWRfenVD8d6q
   IoZJGs0jY41m41o5CXH11fTV3/l6MrvIsD/ZIIt2wnD5jugDebXb7oFMI
   qI2uMQBqpbE3PINT+zZ0O5ymaM0p27kUhyjvKWDbks1cdaAmSFm87jj5A
   dKe1pqtRZdykjkJOY3aXocv6u7dka/nxiTPsT7j9NTSDA53NSC7L3yPA6
   E3xJ9DE8BbP7D8bRQ8S/lCqCZIVvvfJw+SuGJlNCt4Jn7agucWUHlQpwb
   EEJBHVagL7CRPtrbnas992K1eIxLAPEHOdglQESyLMM3NYj38qRj/gds2
   w==;
X-CSE-ConnectionGUID: ydfnjaNIQIurOwsNGo9wRA==
X-CSE-MsgGUID: 1kXYbicNQ2CLHAtXUqdfng==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53880902"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="53880902"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:41:52 -0700
X-CSE-ConnectionGUID: IqY9hFhuSxu04MSLDUl62A==
X-CSE-MsgGUID: gvCMW5LITt2VXXjo8PAwxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157649045"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2025 23:41:48 -0700
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
Subject: [PATCH v5 7/8] iommufd/selftest: Add coverage for vdevice tombstone
Date: Tue, 15 Jul 2025 14:32:44 +0800
Message-Id: <20250715063245.1799534-8-yilun.xu@linux.intel.com>
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

This tests the flow to tombstone vdevice when idevice is to be unbound
before vdevice destruction. The expected results of the tombstone are:

 - The vdevice ID can't be reused anymore (not tested in this patch).
 - Even ioctl(IOMMU_DESTROY) can't free the vdevice ID.
 - iommufd_fops_release() can still free everything.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 16ea10ea1dbf..6084396f7111 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3117,6 +3117,20 @@ TEST_F(iommufd_viommu, hw_queue)
 	test_ioctl_ioas_unmap(iova, PAGE_SIZE);
 }
 
+TEST_F(iommufd_viommu, vdevice_tombstone)
+{
+	uint32_t viommu_id = self->viommu_id;
+	uint32_t dev_id = self->device_id;
+	uint32_t vdev_id = 0;
+
+	if (!dev_id)
+		SKIP(return, "Skipping test for variant no_viommu");
+
+	test_cmd_vdevice_alloc(viommu_id, dev_id, 0x99, &vdev_id);
+	test_ioctl_destroy(self->stdev_id);
+	EXPECT_ERRNO(ENOENT, _test_ioctl_destroy(self->fd, vdev_id));
+}
+
 FIXTURE(iommufd_device_pasid)
 {
 	int fd;
-- 
2.25.1


