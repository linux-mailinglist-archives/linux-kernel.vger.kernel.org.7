Return-Path: <linux-kernel+bounces-618963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73964A9B58D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 19:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6939C1B8239B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2509E28B50F;
	Thu, 24 Apr 2025 17:41:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D081AC43A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516497; cv=none; b=c7qjK0f+nrIcXh3JeuGIJnKcmWaoiD3nnwnLZ8j9S//yq/UA+oZtyDpCT1dbhMrmfGpKv+Vx8iuXYmETef+oJCOHv8jbKxdeGSQOo250sVwqOlb71jxoO4jVXxFZ9x/y4IPYBqxl4AD0vtcOuRQdRD3HPzoefyNby3cwl+XXYbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516497; c=relaxed/simple;
	bh=fXCjcwkEtcDQ7QCB1IGaY0tTIBvn8gLp0aN7PhKhDnc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YB0/LtgkZLAN10IL6R2fSYQX9HMow0tHPseKnjTMk/Ng0ky25aQm6lkIf4F+4VWyg4C6cUZGBGVOwNEmoG8YyoPLUNmneZ6GjThLTn5AiAA9AFB8cl76MuGi9DOmzPx7JzyCJJmfUaMDzNX29zYKmzo+M8Xcq0qGLeJ5gmEj8SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22FE61063;
	Thu, 24 Apr 2025 10:41:30 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C4253F5A1;
	Thu, 24 Apr 2025 10:41:34 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] iommu: Handle yet another race around registration
Date: Thu, 24 Apr 2025 18:41:28 +0100
Message-Id: <88d54c1b48fed8279aa47d30f3d75173685bb26a.1745516488.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Next up on our list of race windows to close is another one during
iommu_device_register() - it's now OK again for multiple instances to
run their bus_iommu_probe() in parallel, but an iommu_probe_device() can
still also race against a running bus_iommu_probe(). As Johan has
managed to prove, this has now become a lot more visible on DT platforms
wth driver_async_probe where a client driver is attempting to probe in
parallel with its IOMMU driver - although commit b46064a18810 ("iommu:
Handle race with default domain setup") resolves this from the client
driver's point of view, this isn't before of_iommu_configure() has had
the chance to attempt to "replay" a probe that the bus walk hasn't even
tried yet, and so still cause the out-of-order group allocation
behaviour that we're trying to clean up (and now warning about).

The most reliable thing to do here is to explicitly keep track of the
"iommu_device_register() is still running" state, so we can then
special-case the ops lookup for the replay path (based on dev->iommu
again) to let that think it's still waiting for the IOMMU driver to
appear at all. This still leaves the longstanding theoretical case of
iommu_bus_notifier() being triggered during bus_iommu_probe(), but it's
not so simple to defer a notifier, and nobody's ever reported that being
a visible issue, so let's quietly kick that can down the road for now...

Reported-by: Johan Hovold <johan@kernel.org>
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 26 ++++++++++++++++++--------
 include/linux/iommu.h |  2 ++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 264383b507bc..2605dab818a0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -277,6 +277,8 @@ int iommu_device_register(struct iommu_device *iommu,
 		err = bus_iommu_probe(iommu_buses[i]);
 	if (err)
 		iommu_device_unregister(iommu);
+	else
+		WRITE_ONCE(iommu->ready, true);
 	return err;
 }
 EXPORT_SYMBOL_GPL(iommu_device_register);
@@ -2832,31 +2834,39 @@ bool iommu_default_passthrough(void)
 }
 EXPORT_SYMBOL_GPL(iommu_default_passthrough);
 
-const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode)
+static const struct iommu_device *iommu_from_fwnode(const struct fwnode_handle *fwnode)
 {
-	const struct iommu_ops *ops = NULL;
-	struct iommu_device *iommu;
+	const struct iommu_device *iommu, *ret = NULL;
 
 	spin_lock(&iommu_device_lock);
 	list_for_each_entry(iommu, &iommu_device_list, list)
 		if (iommu->fwnode == fwnode) {
-			ops = iommu->ops;
+			ret = iommu;
 			break;
 		}
 	spin_unlock(&iommu_device_lock);
-	return ops;
+	return ret;
+}
+
+const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode)
+{
+	const struct iommu_device *iommu = iommu_from_fwnode(fwnode);
+
+	return iommu ? iommu->ops : NULL;
 }
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 {
-	const struct iommu_ops *ops = iommu_ops_from_fwnode(iommu_fwnode);
+	const struct iommu_device *iommu = iommu_from_fwnode(iommu_fwnode);
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!ops)
+	if (!iommu)
 		return driver_deferred_probe_check_state(dev);
+	if (!dev->iommu && !READ_ONCE(iommu->ready))
+		return -EPROBE_DEFER;
 
 	if (fwspec)
-		return ops == iommu_fwspec_ops(fwspec) ? 0 : -EINVAL;
+		return iommu->ops == iommu_fwspec_ops(fwspec) ? 0 : -EINVAL;
 
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ccce8a751e2a..cbb1520005c3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -750,6 +750,7 @@ struct iommu_domain_ops {
  * @dev: struct device for sysfs handling
  * @singleton_group: Used internally for drivers that have only one group
  * @max_pasids: number of supported PASIDs
+ * @ready: set once iommu_device_register() has completed successfully
  */
 struct iommu_device {
 	struct list_head list;
@@ -758,6 +759,7 @@ struct iommu_device {
 	struct device *dev;
 	struct iommu_group *singleton_group;
 	u32 max_pasids;
+	bool ready;
 };
 
 /**
-- 
2.39.2.101.g768bb238c484.dirty


