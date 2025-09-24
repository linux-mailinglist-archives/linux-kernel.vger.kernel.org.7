Return-Path: <linux-kernel+bounces-831006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D807CB9B241
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CD03B0164
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E363A315D51;
	Wed, 24 Sep 2025 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ymry3qXT"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567CD314B9E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736488; cv=none; b=Pt72nf7RSUl1fakPcbq/CTJM9CXLBYidtoy1IHiZB1BrQCGfgDOHpe0OJJ9b7f/y0W+7do+5iDixqzAEJop1RYSMzZYhjX8MbwmYNn/8mF2yWAPRNc8KX1J7JOMi0WlBHBrZcH06ydhJMIjYknGoIlA0MaMF4gFumku7OnmdCcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736488; c=relaxed/simple;
	bh=ag1vNuT/kxZxXkXGRRGmxBDw80fmvceu868lguHhC50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e7jX6rb9X8BsGNfRwjHoc3CKka0G4fo7SZCrALYbQodnNCwDMRlg7tWy85fwV62pNCB4Bqu269pO7ykiMtMf81GsaUB6Wnxoby/LfluKDn0qYDL/J0d+FeJPrBgjbGNIlwDK7N9dYKjP03NK2eO1JjF7qhiXuNxptTKOMAg+aLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ymry3qXT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 45FF9201C951;
	Wed, 24 Sep 2025 10:54:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45FF9201C951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758736480;
	bh=qYnEFJ4ml8ZsATSMrFpZfLXw2dI2teC8KK1sm5L+cAw=;
	h=From:To:Cc:Subject:Date:From;
	b=Ymry3qXT9rbGaEiWas6zChS/mD8YHLBOE2rOO+BpOlb4Y17Tyidz/rNSEKow5hFef
	 h14DrJJvTZOVuw05+8ZV1jtjnlD3Zldg3APglsal5A7e2PuqSibch23MODLi0WASgs
	 hePL4PnZiZpxN77xVp0v4+8PZf61LSuF9GlMrz38=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: [PATCH 0/2] SMMU v3 CMDQ fix and improvement
Date: Wed, 24 Sep 2025 10:54:36 -0700
Message-Id: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Will et al,

These two patches are derived from testing SMMU driver with smaller CMDQ
sizes where we see soft lockups.

This happens on HyperV emulated SMMU v3 as well as baremetal ARM servers
with artificially reduced queue size and microbenchmark to stress test
concurrency.

Thanks,

Jacob 


Alexander Grest (1):
  iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency

Jacob Pan (1):
  iommu/arm-smmu-v3: Fix CMDQ timeout warning

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 85 +++++++++------------
 1 file changed, 35 insertions(+), 50 deletions(-)

-- 
2.43.0


