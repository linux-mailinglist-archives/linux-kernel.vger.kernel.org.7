Return-Path: <linux-kernel+bounces-634332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903EBAAB609
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 07:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0DB50352B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 05:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A842319429;
	Tue,  6 May 2025 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUDJcgpo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6A29AB1D;
	Mon,  5 May 2025 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485056; cv=none; b=fwYaN/kH61e/AWptjhucW3jtCJk8TuJDu0O1QG7Qy2YDqn5TGaeINDdiSEjm1qv4vYLvTSeCU0l91ovM+uejdjVQd6rqkjggJikVvT31n2mx4zUkaegJ+zW/MpQCvawuYYTwhp3v3GBRX186N90QYYPQg2VZhl3KJa9ttvufq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485056; c=relaxed/simple;
	bh=z7v3zH7Bk4Bynx03fs35roYIswkKgBW6qIOK7m742QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fLD6yVBbcN28wEljyMwW7Wdz8tGmLJSwPaoO6YMr4Hq1VgFD0S3gpZsV6udlsZgQzFmnzMgfkF3fvExSDpA8Gs6d/iBzEpIXw3yyplhuiJwn7zxUcOW5gfbwbVGYGhcIRZqtbM1/ft0ue1H5ETVUzPg5LgGGpudemIxBPAn7sw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUDJcgpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A65C4CEEE;
	Mon,  5 May 2025 22:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485055;
	bh=z7v3zH7Bk4Bynx03fs35roYIswkKgBW6qIOK7m742QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUDJcgpo0VApq+07pZx7ep5DLE8nx+yhUQH0ShezcGQRapkBfwmt0Oj+7q3dyYrzn
	 dh/nqabF91+1PTE1LVK23w9S0/zoSe2BwuJ1byckp8bdnBZ/6t0jzmc6vmn2i8nVWu
	 9eyt9FGRG6MxQ6tvIgTfzRvcDfq/sze5z5RBQ5VBqAn4TtsolNx3Cr/amsMJP+AkTb
	 EXJHmQAWdmfy9/VpkrojDrk2X/063jVB4N/X5yy6s8AyZu42bjF+Wg8CIbbEzNH18B
	 ETfX0cP68/OMUl+CvuIzJhW0KNvzUWMCy63MDhy7jhFRL9N2vx2DRHvgYY98ZfTfsN
	 pC9EbJBu/8fcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 145/486] iommu: Keep dev->iommu state consistent
Date: Mon,  5 May 2025 18:33:41 -0400
Message-Id: <20250505223922.2682012-145-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 3832862eb9c4dfa0e80b2522bfaedbc8a43de97d ]

At the moment, if of_iommu_configure() allocates dev->iommu itself via
iommu_fwspec_init(), then suffers a DT parsing failure, it cleans up the
fwspec but leaves the empty dev_iommu hanging around. So far this is
benign (if a tiny bit wasteful), but we'd like to be able to reason
about dev->iommu having a consistent and unambiguous lifecycle. Thus
make sure that the of_iommu cleanup undoes precisely whatever it did.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/d219663a3f23001f23d520a883ac622d70b4e642.1740753261.git.robin.murphy@arm.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu-priv.h | 2 ++
 drivers/iommu/iommu.c      | 2 +-
 drivers/iommu/of_iommu.c   | 6 +++++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index de5b54eaa8bf1..a5913c0b02a0a 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -17,6 +17,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 	return dev->iommu->iommu_dev->ops;
 }
 
+void dev_iommu_free(struct device *dev);
+
 const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
 
 static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cac3dce111689..879009adef407 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -347,7 +347,7 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 	return param;
 }
 
-static void dev_iommu_free(struct device *dev)
+void dev_iommu_free(struct device *dev)
 {
 	struct dev_iommu *param = dev->iommu;
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e7a6a1611d193..e3fcab925a547 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -118,6 +118,7 @@ static void of_pci_check_device_ats(struct device *dev, struct device_node *np)
 int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		       const u32 *id)
 {
+	bool dev_iommu_present;
 	int err;
 
 	if (!master_np)
@@ -129,6 +130,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		mutex_unlock(&iommu_probe_device_lock);
 		return 0;
 	}
+	dev_iommu_present = dev->iommu;
 
 	/*
 	 * We don't currently walk up the tree looking for a parent IOMMU.
@@ -149,8 +151,10 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		err = of_iommu_configure_device(master_np, dev, id);
 	}
 
-	if (err)
+	if (err && dev_iommu_present)
 		iommu_fwspec_free(dev);
+	else if (err && dev->iommu)
+		dev_iommu_free(dev);
 	mutex_unlock(&iommu_probe_device_lock);
 
 	if (!err && dev->bus)
-- 
2.39.5


