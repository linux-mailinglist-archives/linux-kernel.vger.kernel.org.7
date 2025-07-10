Return-Path: <linux-kernel+bounces-725792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68847B003F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4931AA30B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E055426FD84;
	Thu, 10 Jul 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxUEE1AC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2726FA4B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154967; cv=none; b=NBWQ9MUGWzpYu7WaZ8UhZpBhE4DLtfSt/P9FU38zKLOVU3l4EKhQS6M8eYabt8Ud2Gvy6IoCwSpaFio25lHEridGzAl25CJxCaVaCG15ISLitluu0Bcd9hrSJNY0TAfZCItTeMtP3JVJ4JLseaVa7f/KmuqJoEwv3p2EaXYj6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154967; c=relaxed/simple;
	bh=qlDbBioPcf0F/yj17NDrFJ67aogsWu+TJV48R191QIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Is5a9z0gU6BNZcfSr6GbsiKJW5RLUSQ+a+dnXdsEYHtdAQijFSuiHNosAexJ41DyQZWtD6hxhMhud1qn3C9U5x43d0Il+0Zm7lwgQPRF+04ICgjPzNFs/qnfYSchyrqzNxkaVvKjJImUbwi5u7FFxUqj8v59+hp+c0T4EFAklYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxUEE1AC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752154966; x=1783690966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qlDbBioPcf0F/yj17NDrFJ67aogsWu+TJV48R191QIc=;
  b=RxUEE1ACQdNKqvPioNVD8jrZB5rCv31gG1NjcaoQ8o+hpaRtPj+8HH2T
   Uasr58tAwU6qEt9i5Bhily90yBJB8SMKgxuAZf3mPGNHs4ARnYTnl6Usd
   fpIgqHkRBpjlutmnXdZDDWNvN/3VOzsD/qB1OhfKjFGJHQxWq+VeFGadU
   KTm4y21ZtyheJkVc/+HoIoZg01+yEeqFD/1quNONbdfC2fbE9HKyxNPPl
   Gi7bWAeyF2lDkPoHQTGNQjUqr4Ngxey6wWQg/oqlpXdT2Q/MOCQpKcdCy
   hfV7xLLD0Q50SNW5PyvDZLAyPKTlw0DEqFY0uE/WH0TKjjaJHjx6h+dhZ
   w==;
X-CSE-ConnectionGUID: C85mxsszQJST/KFtqZNj+Q==
X-CSE-MsgGUID: yidrgtsmSSOINiEfqP4eNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65787695"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="65787695"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 06:42:46 -0700
X-CSE-ConnectionGUID: AWxHHtRNQT64vH5FrrDDSg==
X-CSE-MsgGUID: oNvLIZCESdSB4d8BqPSC3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156809445"
Received: from gnrd8.igk.intel.com ([10.123.232.137])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2025 06:42:44 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] iommu: Notify requesters of IOMMU fault failures
Date: Thu, 10 Jul 2025 13:42:15 +0000
Message-ID: <20250710134215.97840-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
References: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call the notifier callbacks installed by the device drivers when
failing IOMMU page faults occur during the SVA mode operation.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iommu/iommu-sva.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 1a51cfd82808..18b6d9b02899 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -256,11 +256,19 @@ iommu_sva_handle_mm(struct iommu_fault *fault, struct mm_struct *mm)
 	return status;
 }
 
+static struct iommu_rid_notifier *iommu_get_rid_notifier(struct device *dev, u32 rid)
+{
+	struct dev_iommu *param = dev->iommu;
+
+	return xa_load(&param->rid_notifiers, rid);
+}
+
 static void iommu_sva_handle_iopf(struct work_struct *work)
 {
 	struct iopf_fault *iopf;
 	struct iopf_group *group;
 	enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
+	struct iommu_rid_notifier *rid_notifier;
 
 	group = container_of(work, struct iopf_group, work);
 	list_for_each_entry(iopf, &group->faults, list) {
@@ -268,8 +276,17 @@ static void iommu_sva_handle_iopf(struct work_struct *work)
 		 * For the moment, errors are sticky: don't handle subsequent
 		 * faults in the group if there is an error.
 		 */
-		if (status != IOMMU_PAGE_RESP_SUCCESS)
+		if (status != IOMMU_PAGE_RESP_SUCCESS) {
+			/* Notify the requester of a failure. */
+			rid_notifier = iommu_get_rid_notifier(group->fault_param->dev,
+							      iopf->fault.prm.rid);
+
+			if (rid_notifier && rid_notifier->notifier)
+				rid_notifier->notifier(rid_notifier->dev, &iopf->fault,
+						       status, rid_notifier->data);
+
 			break;
+		}
 
 		status = iommu_sva_handle_mm(&iopf->fault,
 					     group->attach_handle->domain->mm);
-- 
2.43.0


