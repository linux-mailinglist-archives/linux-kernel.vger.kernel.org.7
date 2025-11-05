Return-Path: <linux-kernel+bounces-887163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37864C376DD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113453BB315
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E32329369;
	Wed,  5 Nov 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rUZtdjJL"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3057430F550
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369603; cv=none; b=bXI0EOOJcjPyyMwiAX9L2vHQpk+eH+z5Mluaq+Tg1ITPZdeRD+ixW8jsxQBSHcbfCOxa8+8sLNaM4ws/heWR8Ko16q2kiDNdqufPI7J0wa0QS/CUgYDJK4q/Id4vUlZ2E/H1qigJkaToUPZrVFxpn/3IVdf/KjWd+zRBLjomrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369603; c=relaxed/simple;
	bh=ml7U1rpJGnGnBz5uXhKURx2Le0KM4QUiOupT0ekigfs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aDDImOg8+njPCKKblYsDwjycjozShISf5fS7cjFSiOG5uC2PbHNYUt1m2UYX+62as74x3H/kKqcmFRFyAkY8ET2711B4OwwT2CuvHV8aW5Xiu3L3KO+K+FPCgKQhVjgD+UsGJ4W875sDSlcztexGYJ+ti8LFq9NnkwGW52HVgwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rUZtdjJL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 56B5B211D8B1;
	Wed,  5 Nov 2025 11:06:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56B5B211D8B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762369601;
	bh=soKtQEHSTH0EKkfguo3Zbqya4px3IKSED90Pu4k4Nys=;
	h=From:To:Cc:Subject:Date:From;
	b=rUZtdjJLauRH77VLb3VQ8iJu53HrqAd0+lrcMaxXUQoCwvm7DOaLVFY0Xh9YR1jy+
	 Sy3d+aEaO6mMuP9eZJkH3LygkcAeuqjRnR41+vTAuyxl0ZXE4yDkL5dsrv2MGgdjoE
	 emb3mkpyf+RUJMG9sg6+EcyDlIudNkSbRvIxFows=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: [PATCH v3 0/2] SMMU v3 CMDQ fix and improvement
Date: Wed,  5 Nov 2025 11:06:36 -0800
Message-Id: <20251105190638.23172-1-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Will et al,

These two patches address logic issues that occur when SMMU CMDQ spaces
are nearly exhausted at runtime. The problems become more pronounced
when multiple CPUs submit to a single queue, a common scenario under SVA
when shared buffers (used by both CPU and device) are being unmapped.


Thanks,

Jacob 



Alexander Grest (1):
  iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency

Jacob Pan (1):
  iommu/arm-smmu-v3: Fix CMDQ timeout warning

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 74 +++++++++++----------
 1 file changed, 40 insertions(+), 34 deletions(-)

-- 
2.43.0


