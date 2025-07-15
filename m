Return-Path: <linux-kernel+bounces-731270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C54B05206
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925B83B1E47
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5A826D4E9;
	Tue, 15 Jul 2025 06:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P58ZLj/Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9626D4DA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561698; cv=none; b=jYA0Po8L1xW08cCSyn+4CWbbKqEO0u/4ON08rEJW55Cvsf5Y0UNG924I5Ata/0E+aLfiwZuE5Mv4KA0a1Mv1cdrid8GWINV4MHjBdmYvp94hdc2QiJsKINYXpc1kVOphgR4lD/6+eUIke/FYhEm8AJNlRqb0A0w1FTPjsU2hF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561698; c=relaxed/simple;
	bh=ldERnd6WuJBj0vJBisCoWvYmOAetmnwBakfZRokt2A0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hz+e+rc895DqDsRPp1RwKr2Fxl7A8j/p3DnhQrAFPWuYVtz66XskIZQhDdsLTieBeRqCIc2z/h6X2vjM2SuXPiBnJq5vY0Ylo36YQkvMnZwfblme25EmY3CIrA9Mu4ie4FzC61Wm/ixiLf7ufDQRFMbciwuOz5GrzTj+4DaRea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P58ZLj/Z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752561696; x=1784097696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ldERnd6WuJBj0vJBisCoWvYmOAetmnwBakfZRokt2A0=;
  b=P58ZLj/Z+lhnCE29ny5SCiFao+EJ+/U/Ijq1kymol56CZPiZPHNPqUlY
   tXFpUxLuHi6gqyT34kv5bb4CTC0eR0KN9Oia9dticQp5yRChnYNncmFQo
   Jiq2Djz9WOkFs7a71qaVTi9GtO6rrNa0JwC2zxmn+NW+3A+1lVqKlpQOX
   GgREgqPS2Z05A2LDsjIGt31JInS/uMfNDMpSONGnU63aGxTn8uK8JsUWe
   ac597/qTWrNWb1faKA3wzqqpEOiuqODamGOTHqYMpKuSPTd4VwwpfJfCY
   V0pXItL2F786/FEqtr/pvqKeKqjkHfBINL2oXQsjtiY15Yz85EBJ4wAQZ
   g==;
X-CSE-ConnectionGUID: sn8VpsxfSLaU6CX1A/+3zw==
X-CSE-MsgGUID: dQxN9k37RM+I48P1cRzzXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53880860"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="53880860"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:41:36 -0700
X-CSE-ConnectionGUID: 0yLybFLMS+2FOL7azW89Pw==
X-CSE-MsgGUID: wFNM6iKGSAeqfeftkA4bPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157648991"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2025 23:41:32 -0700
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
Subject: [PATCH v5 3/8] iommufd: Add a pre_destroy() op for objects
Date: Tue, 15 Jul 2025 14:32:40 +0800
Message-Id: <20250715063245.1799534-4-yilun.xu@linux.intel.com>
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

Add a pre_destroy() op which gives objects a chance to clear their
short term users references before destruction. This op is intended for
external driver created objects (e.g. idev) which does deterministic
destruction.

In order to manage the lifecycle of interrelated objects as well as the
deterministic destruction (e.g. vdev can't outlive idev, and idev
destruction can't fail), short term users references are allowed to
live out of an ioctl execution. An immediate use case is, vdev holds
idev's short term user reference until vdev destruction completes, idev
leverages existing wait_shortterm mechanism to ensure it is destroyed
after vdev.

This extended usage makes the referenced object unable to just wait for
its reference gone. It needs to actively trigger the reference removal,
as well as prevent new references before wait. Should implement these
work in pre_destroy().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 71135f0ec72d..53085d24ce4a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -23,6 +23,7 @@
 #include "iommufd_test.h"
 
 struct iommufd_object_ops {
+	void (*pre_destroy)(struct iommufd_object *obj);
 	void (*destroy)(struct iommufd_object *obj);
 	void (*abort)(struct iommufd_object *obj);
 };
@@ -160,6 +161,9 @@ static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
 	if (refcount_dec_and_test(&to_destroy->shortterm_users))
 		return 0;
 
+	if (iommufd_object_ops[to_destroy->type].pre_destroy)
+		iommufd_object_ops[to_destroy->type].pre_destroy(to_destroy);
+
 	if (wait_event_timeout(ictx->destroy_wait,
 			       refcount_read(&to_destroy->shortterm_users) == 0,
 			       msecs_to_jiffies(60000)))
-- 
2.25.1


