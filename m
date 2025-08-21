Return-Path: <linux-kernel+bounces-780102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44298B2FD9C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731921BC0FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5772F6190;
	Thu, 21 Aug 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d0VkGgXb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FCD2E2F0E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788089; cv=none; b=MoBkg1syQFhkrkkr+Pugc2YJ9cp/xw2BBmYhJFrMPnoGqYP1SZGJLgGsCwWCJMCxqAFmEhK8xuM7AhyOqhEkpVbNZQ5cRBx1i5mPFWV0UKcv2SJ1Su6iLF/MY/MAVoEC3jt6p7nYLvabB3mPQECIiMfestn98HJDT3VgEVT8nqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788089; c=relaxed/simple;
	bh=V5wwopeV5CYXb1MI1P38eWPYEwxvYCnzcCxsZdKtrHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/fWDKPL4ZYDvhbAfjlpOVlr/eUzYX65Qz9FBJt0TQRLsSPDAL3QUiSpnGUHiVLNSPNsK9/6bmiht04qZ8Arp7Cy/XwdDHzBzC/QI0c5O/O+Q/bg8z5HTg/UgJ+pR1ZUkyCZbBetdwuIh0q6UzDl+FRA6g2tZlHSAnx8ZBtDKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d0VkGgXb; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LEUrXK004090;
	Thu, 21 Aug 2025 14:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=eOyaW
	kVCVs+cuUTdiLvAPrVXJ78haYYosiMCV5aRvhQ=; b=d0VkGgXb+qdqL/kL3l/vF
	agIaG/9iWHVKWzUJq2LDS5vrH8CncqkRFBB9qau2ChbORpuOd4wpeATZrc5te88B
	uW5igdX2XVRog9V5TjLB8hPL4zpaI3k9OFenxaqb1OjH9ehkDJiAMOFN32S6GPwg
	PJ1q3anFdXU+FLUGUv8s4EnA++WflrNP83dFPFOpaQfUROdjEpSX+gIwOk8j1ORl
	TaRMyZnBeLtF2pZw2GCeX8D3j1Db9wGAIEq5v37RXs7eBU4n4q6WW4oMuv7aOo6L
	lma1uPLmdqb38VoNM6jcL60JuSNg1jzmPs1+lQwRCA9WCTwFyQsDNtLBO73oucG+
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqussa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 14:54:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LDjYvd020547;
	Thu, 21 Aug 2025 14:54:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48nj6g5s8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 14:54:33 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57LEpOeB011459;
	Thu, 21 Aug 2025 14:54:33 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48nj6g5s7m-3;
	Thu, 21 Aug 2025 14:54:33 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, willy@infradead.org,
        sidhartha.kumar@oracle.com
Subject: [PATCH v2 2/6] drm: Convert object_name_idr to XArray
Date: Thu, 21 Aug 2025 14:54:25 +0000
Message-ID: <20250821145429.305526-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821145429.305526-1-sidhartha.kumar@oracle.com>
References: <20250821145429.305526-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210121
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX9t14RMCL1NU3
 YjOa8F4FPJhA0tPFEbd5+mdl+G4m/dtqE2quqo/9gKUr2d9LWcpimtUYTN0fcqip37vLEPwPsDU
 vjLMkAp09WGG0ZiyXazwRu8QtME9DWo2nfxZWJPRzPWfMsmWOoG5b4wJU8DLDT4FxWH8JwYrzYk
 YzG73ZXnxoWgNzXRXSkjq9Y413fLR8zUUZetTHgldcurx3r1u1d6T0vGyOmhCr/3wbe7ZhwetiK
 40ZAh2F8bIHvWbh3ZFpPXQkxdHADLVxYD9VZ4MmuHdzjwhcucABS7+GCruN9NCMnJ6z0rLQzbqc
 +XCXqW0X0ZhvVbrOvLUYV+eQMTdVN8S24B1ItEa2Lg917huFjR6MmZW7VsE1z2We4agtfOxXH/5
 DKDBkiABUre2ZaQ6yKfRd3vrwAyXPbMF9gRiM4op4NYhXfFJEu0=
X-Proofpoint-ORIG-GUID: Ybo6BrDYI5387itABCHRy_ALeV3sM6hw
X-Proofpoint-GUID: Ybo6BrDYI5387itABCHRy_ALeV3sM6hw
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a7332a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=DK_Tli1e-HrAiUtdIdsA:9
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12069

From: Matthew Wilcox <willy@infradead.org>

It's not possible to replace object_name_lock as it protects more
code than should be reasonably be run under a spinlock, so the xa_lock
is nested under the object_name_lock.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 drivers/gpu/drm/drm_debugfs.c | 19 ++++++-------------
 drivers/gpu/drm/drm_gem.c     | 11 +++++------
 include/drm/drm_device.h      |  4 ++--
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 365cf337529f..3e57e3da5115 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -122,27 +122,20 @@ static int drm_clients_info(struct seq_file *m, void *data)
 	return 0;
 }
 
-static int drm_gem_one_name_info(int id, void *ptr, void *data)
-{
-	struct drm_gem_object *obj = ptr;
-	struct seq_file *m = data;
-
-	seq_printf(m, "%6d %8zd %7d %8d\n",
-		   obj->name, obj->size,
-		   obj->handle_count,
-		   kref_read(&obj->refcount));
-	return 0;
-}
-
 static int drm_gem_name_info(struct seq_file *m, void *data)
 {
 	struct drm_debugfs_entry *entry = m->private;
 	struct drm_device *dev = entry->dev;
+	struct drm_gem_object *obj;
+	unsigned long index;
 
 	seq_printf(m, "  name     size handles refcount\n");
 
 	mutex_lock(&dev->object_name_lock);
-	idr_for_each(&dev->object_name_idr, drm_gem_one_name_info, m);
+	xa_for_each(&dev->object_names, index, obj) {
+		seq_printf(m, "%6d %8zd %7d %8d\n", obj->name, obj->size,
+				obj->handle_count, kref_read(&obj->refcount));
+	}
 	mutex_unlock(&dev->object_name_lock);
 
 	return 0;
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 6a44351e58b7..cef0c5935798 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -97,7 +97,7 @@ drm_gem_init(struct drm_device *dev)
 	struct drm_vma_offset_manager *vma_offset_manager;
 
 	mutex_init(&dev->object_name_lock);
-	idr_init_base(&dev->object_name_idr, 1);
+	xa_init_flags(&dev->object_names, XA_FLAGS_ALLOC1);
 
 	vma_offset_manager = drmm_kzalloc(dev, sizeof(*vma_offset_manager),
 					  GFP_KERNEL);
@@ -269,7 +269,7 @@ static void drm_gem_object_handle_free(struct drm_gem_object *obj)
 
 	/* Remove any name for this object */
 	if (obj->name) {
-		idr_remove(&dev->object_name_idr, obj->name);
+		xa_erase(&dev->object_names, obj->name);
 		obj->name = 0;
 	}
 }
@@ -927,11 +927,10 @@ drm_gem_flink_ioctl(struct drm_device *dev, void *data,
 	}
 
 	if (!obj->name) {
-		ret = idr_alloc(&dev->object_name_idr, obj, 1, 0, GFP_KERNEL);
+		ret = xa_alloc(&dev->object_names, &obj->name, obj,
+				xa_limit_32b, GFP_KERNEL);
 		if (ret < 0)
 			goto err;
-
-		obj->name = ret;
 	}
 
 	args->name = (uint64_t) obj->name;
@@ -967,7 +966,7 @@ drm_gem_open_ioctl(struct drm_device *dev, void *data,
 		return -EOPNOTSUPP;
 
 	mutex_lock(&dev->object_name_lock);
-	obj = idr_find(&dev->object_name_idr, (int) args->name);
+	obj = xa_load(&dev->object_names, (int) args->name);
 	if (obj) {
 		drm_gem_object_get(obj);
 	} else {
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index a33aedd5e9ec..6a28a9b134dd 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -325,8 +325,8 @@ struct drm_device {
 	/** @object_name_lock: GEM information */
 	struct mutex object_name_lock;
 
-	/** @object_name_idr: GEM information */
-	struct idr object_name_idr;
+	/** @object_names: GEM information */
+	struct xarray object_names;
 
 	/** @vma_offset_manager: GEM information */
 	struct drm_vma_offset_manager *vma_offset_manager;
-- 
2.43.0


