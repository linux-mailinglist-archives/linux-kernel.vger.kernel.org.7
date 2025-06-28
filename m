Return-Path: <linux-kernel+bounces-707653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B62CAEC67E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 12:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D174A281F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 10:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB23C24339D;
	Sat, 28 Jun 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D51JAG4a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894E1E8332
	for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751105177; cv=none; b=XN/An/2bsowEWxSk9rH6JX2Qoijy3GvAYrMsX45VX3fJxLcPbBKC4O5xYSHrg4oGz8yMG9+BUlR2hN9PFkIkbLpX41GVYIKsRARku0atjqC2v6JVKqK8f9ltsktJoXxc9gD7cV5riTyU0rCgtOcMy3wQ9HSgsGRnlitGSJ8Upbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751105177; c=relaxed/simple;
	bh=6nfu5IZBhKE95REwLtCcNXDFz3K7fenEADHBLf0I/18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hwo11RJmctyx7gas8FN3RfcVZFb/f9jmDSxg0Ltbjs92zLhIFQHFA5g6T5hQw2MIt5GRg9jufRVgslmuaHMWRLVc+aBZ3nR0IQLV8ieUkT1hkuEVZh6aWNYzPMs9V0ikVQdZ2J/T9Er4SsKmBwUYOeT0eBj5tRbNs2XMDpGBZbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D51JAG4a; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751105175; x=1782641175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6nfu5IZBhKE95REwLtCcNXDFz3K7fenEADHBLf0I/18=;
  b=D51JAG4awZ2bi819q5Ipw7dECkOyQy27sItuVbB0SI7VBRdXbnrEGvH8
   PGCmXm3ZDGuy0gT2RV7wxirzFxo4CaTs+SWuF33l/rcDmV0RBASKfG5Va
   oe1JbXOGDjWYHeiLG6YFYw6SKe0bPoapdsBtxXZ389jENYoDv9RjtbrG8
   PBdq7VASACHyHXTL+4eO/HIYuV+IazLayrcxUVNZ5yfweTNz0GUKGn65B
   CZKvSsQUcAUqT5DPGO0wfzFYUvjlzj9XmCVPoK7Y94Clz02GOzv+sY/6A
   0qNPFeaZrtScu/Bca64mCvhKk6g1WFSdL4trLbs2HDjNzKKJsCMAwS1M4
   w==;
X-CSE-ConnectionGUID: Llk3BAg7SwyF4gLIbUlvzQ==
X-CSE-MsgGUID: +e/UjBRzQi2IZP5R97zIWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="64002255"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="64002255"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 03:06:14 -0700
X-CSE-ConnectionGUID: rj2RCJnTT3iu62YBDLznQA==
X-CSE-MsgGUID: VRzeq9MzRtqCrVJelv3VtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="157551286"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa004.jf.intel.com with ESMTP; 28 Jun 2025 03:06:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.16-rc
Date: Sat, 28 Jun 2025 18:03:50 +0800
Message-ID: <20250628100351.3198955-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fix has been queued for v6.16-rc4:

- Assign devtlb cache tag on ATS enablement

It fixes a critical cache invalidation issue for ATS-capable devices. It
has been reviewed and is ready for merge. Can you please consider it?

Best regards,
baolu


Lu Baolu (1):
  iommu/vt-d: Assign devtlb cache tag on ATS enablement

 drivers/iommu/intel/cache.c |  5 ++---
 drivers/iommu/intel/iommu.c | 11 ++++++++++-
 drivers/iommu/intel/iommu.h |  2 ++
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.43.0


