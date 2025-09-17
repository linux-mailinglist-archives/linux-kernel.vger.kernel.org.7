Return-Path: <linux-kernel+bounces-820885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0167FB7F96E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27E32A25D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3BB372896;
	Wed, 17 Sep 2025 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tMdEPQ74"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09643705AC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116538; cv=none; b=Oet5RD4QtfnBzrGaneDf1YOQ8U/11zuPfCkSEULBnnvi0Iq1V0AnSk7eVRBV1BQtB3VjCJa/mlYqNdM2+qvJTc3+RQQ46+60Is46NTtf3JUoapfhJvLvuOlBOwRJCeS1A3Br4dpHobhRhS3b+4EHve2/iWxbzpSftiG3RD6w3fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116538; c=relaxed/simple;
	bh=9bTEk28p+1EQHHun823XzXhDf9Y8hPVkAkMuj47iOl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=qhFrT+WYyTRwuyXCUuAWYqAGb+NR4OvwO1unPABMUpOJ3uBOWegvsEKCIZ85tN7P2GBibTyY+PVYd/wwgpF7qbQ4AKUBsAojxpdMsU6SpSHjlBxiCua232SHCfQVEHLPm8Vj4KPJe4Kk4ZYhuKgAbPN2ZrN4mHsyqo4Xmx+1MLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tMdEPQ74; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250917134214epoutp03abe120475dfe7eda96b1b22fb59f1984~mFaxJnZj_0947909479epoutp03P
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:42:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250917134214epoutp03abe120475dfe7eda96b1b22fb59f1984~mFaxJnZj_0947909479epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758116534;
	bh=Gis+7Gmlr9qMCEkpYG8GWuuPF2egOaPPu7OYRJgJuIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMdEPQ74dYBYVHjKFckasnAK4cm+DFBtCEx0+YR9YqIlGe3QNkeue8fvq+z7a5hIO
	 V0ZrvokjTMllWYdac4JwNa79eHHD8I8zq3lYb8CcBIgLd7AB7J3+SEVGxMeLc/3di7
	 A+W9bjAlrr80rlC7gbcQhSqVY8MloAZ71Sngg91Q=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250917134213epcas5p3b005d2627fd878856aa9bbbf118b8c66~mFawOasd72659126591epcas5p31;
	Wed, 17 Sep 2025 13:42:13 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.92]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cRg1J1whNz6B9m6; Wed, 17 Sep
	2025 13:42:12 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250917134211epcas5p17cf5e4052df126a67b27be971be82fe1~mFauehKXU2209822098epcas5p1u;
	Wed, 17 Sep 2025 13:42:11 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250917134209epsmtip2f7c92cf264b8112a07dae1cd96a09253~mFaszAMbH0970709707epsmtip2E;
	Wed, 17 Sep 2025 13:42:09 +0000 (GMT)
From: Neeraj Kumar <s.neeraj@samsung.com>
To: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com
Cc: a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com, Neeraj Kumar <s.neeraj@samsung.com>
Subject: [PATCH V3 19/20] cxl/pmem_region: Add sysfs attribute cxl region
 label updation/deletion
Date: Wed, 17 Sep 2025 19:11:15 +0530
Message-Id: <20250917134116.1623730-20-s.neeraj@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917134116.1623730-1-s.neeraj@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250917134211epcas5p17cf5e4052df126a67b27be971be82fe1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917134211epcas5p17cf5e4052df126a67b27be971be82fe1
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
	<CGME20250917134211epcas5p17cf5e4052df126a67b27be971be82fe1@epcas5p1.samsung.com>

Using these attributes region label is added/deleted into LSA. These
attributes are called from userspace (ndctl) after region creation.

Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 22 ++++++
 drivers/cxl/core/pmem_region.c          | 91 ++++++++++++++++++++++++-
 drivers/cxl/cxl.h                       |  1 +
 3 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 6b4e8c7a963d..d6080fcf843a 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -615,3 +615,25 @@ Description:
 		The count is persistent across power loss and wraps back to 0
 		upon overflow. If this file is not present, the device does not
 		have the necessary support for dirty tracking.
+
+
+What:		/sys/bus/cxl/devices/regionZ/pmem_regionZ/region_label_update
+Date:		Sept, 2025
+KernelVersion:	v6.17
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Write a boolean 'true' string value to this attribute to
+		update cxl region information into LSA as region label. It
+		uses nvdimm nd_region_label_update() to update cxl region
+		information saved during cxl region creation into LSA. This
+		attribute must be called at last during cxl region creation.
+
+
+What:		/sys/bus/cxl/devices/regionZ/pmem_regionZ/region_label_delete
+Date:		Sept, 2025
+KernelVersion:	v6.17
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) When a boolean 'true' is written to this attribute then
+		pmem_region driver deletes cxl region label from LSA using
+		nvdimm nd_region_label_delete()
diff --git a/drivers/cxl/core/pmem_region.c b/drivers/cxl/core/pmem_region.c
index 55b80d587403..665b603c907b 100644
--- a/drivers/cxl/core/pmem_region.c
+++ b/drivers/cxl/core/pmem_region.c
@@ -45,9 +45,98 @@ static void cxl_pmem_region_release(struct device *dev)
 	kfree(cxlr_pmem);
 }
 
+static ssize_t region_label_update_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
+	struct cxl_region *cxlr = cxlr_pmem->cxlr;
+	ssize_t rc;
+	bool update;
+
+	rc = kstrtobool(buf, &update);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem);
+	if (rc)
+		return rc;
+
+	/* Region not yet committed */
+	if (update && cxlr && cxlr->params.state != CXL_CONFIG_COMMIT) {
+		dev_dbg(dev, "region not committed, can't update into LSA\n");
+		return -ENXIO;
+	}
+
+	if (cxlr && cxlr->cxlr_pmem && cxlr->cxlr_pmem->nd_region) {
+		rc = nd_region_label_update(cxlr->cxlr_pmem->nd_region);
+		if (!rc)
+			cxlr->params.region_label_state = 1;
+	}
+
+	if (rc)
+		return rc;
+
+	return len;
+}
+
+static ssize_t region_label_update_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
+	struct cxl_region *cxlr = cxlr_pmem->cxlr;
+	struct cxl_region_params *p = &cxlr->params;
+	ssize_t rc;
+
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem);
+	if (rc)
+		return rc;
+
+	return sysfs_emit(buf, "%d\n", p->region_label_state);
+}
+static DEVICE_ATTR_RW(region_label_update);
+
+static ssize_t region_label_delete_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
+	struct cxl_region *cxlr = cxlr_pmem->cxlr;
+	ssize_t rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem);
+	if (rc)
+		return rc;
+
+	if (cxlr && cxlr->cxlr_pmem && cxlr->cxlr_pmem->nd_region) {
+		rc = nd_region_label_delete(cxlr->cxlr_pmem->nd_region);
+		if (rc)
+			return rc;
+		cxlr->params.region_label_state = 0;
+	}
+
+	return len;
+}
+static DEVICE_ATTR_WO(region_label_delete);
+
+static struct attribute *cxl_pmem_region_attrs[] = {
+	&dev_attr_region_label_update.attr,
+	&dev_attr_region_label_delete.attr,
+	NULL
+};
+
+static struct attribute_group cxl_pmem_region_group = {
+	.attrs = cxl_pmem_region_attrs,
+};
+
 static const struct attribute_group *cxl_pmem_region_attribute_groups[] = {
 	&cxl_base_attribute_group,
-	NULL,
+	&cxl_pmem_region_group,
+	NULL
 };
 
 const struct device_type cxl_pmem_region_type = {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0d576b359de6..f01f8c942fdf 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -484,6 +484,7 @@ enum cxl_config_state {
  */
 struct cxl_region_params {
 	enum cxl_config_state state;
+	int region_label_state;
 	uuid_t uuid;
 	int interleave_ways;
 	int interleave_granularity;
-- 
2.34.1


