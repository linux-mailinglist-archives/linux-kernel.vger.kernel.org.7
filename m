Return-Path: <linux-kernel+bounces-774330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B4AB2B12D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A863ABEAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87F2749F2;
	Mon, 18 Aug 2025 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P04c4/ns"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070D3274B3E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543674; cv=none; b=QOBdPRfXLIdk5y/GFPWrCbdAnPNcH1/VkoVntzIlRLMg1dh9GTZVM/ZIU0zU9F2RMZsUPexaWQT9LmJxjM2XLvlTXWViv2EJx7ZJVDff+Ned5YtM8+fHAHqKDE2yZyN1kekaBBddFup7Q1DNIKhl11UYQlx9RPQN26if28eQyjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543674; c=relaxed/simple;
	bh=XYLPAxHSXVybcDQwFcMG0IPx7i7/Um8JTQBGd+GKCis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tg0h5S5N/EsnaE5Y9epmwqM1Xg4PEnFGEkxeVzP4qD69Ce9oLIKpRSSUbHh3uDJF36tqEF408UsFUrBGvf7rHlXRVyKimJG376C0sxtwFMUNFOHtSWGybfPxfe43F+Yng/kq2ZW2ipiMAjkbSI5SJN5DkFzq3ILgrMZUrufs4cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P04c4/ns; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEtnuN020970;
	Mon, 18 Aug 2025 19:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=kfHAn
	PgnmkpNKS+OEMuVhsU/8JXLMmxSFrlGGE9oFNI=; b=P04c4/nsemFlKYqupYLPw
	OY7F4q0TALpDgFX1tiYMMVvHXtCrPe1XV7JNL+J0y22oEOiS7ZeQp0PSQB8uTIqe
	ri24EdcJBYqctPuR+Xhz8HLD0RkcaVJwoxquJjoXXj13F9vrzVoYkEw/zpZ1+2Bp
	qq4z14rkNJ16nF79obOCsulfRBPI532Y101yuj0UN6NvUeX6EJD0luv1dwn+KVwJ
	N6Tm+frzeEUAveWFZD2EemyMq9U2roIsgEwlJgatICm0G3AZNb3LmKzIErYf0ZO7
	ZoYp8Cn7NmSspcv4ZB8ZV9z53OUG9PJ1nZyeAKMkuiF5tFPOuh7Zzi9FdtCuFwej
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgs5ku33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 19:00:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57IICQcX016749;
	Mon, 18 Aug 2025 19:00:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge9d7wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 19:00:58 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57IJ0sZX035076;
	Mon, 18 Aug 2025 19:00:58 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48jge9d7p3-3;
	Mon, 18 Aug 2025 19:00:57 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, willy@infradead.org,
        sidhartha.kumar@oracle.com
Subject: [PATCH 2/6] drm: Convert object_name_idr to XArray
Date: Mon, 18 Aug 2025 19:00:42 +0000
Message-ID: <20250818190046.157962-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818190046.157962-1-sidhartha.kumar@oracle.com>
References: <20250818190046.157962-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508180177
X-Authority-Analysis: v=2.4 cv=DLiP4zNb c=1 sm=1 tr=0 ts=68a3786b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=2OwXVqhp2XgA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=DK_Tli1e-HrAiUtdIdsA:9
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE3OCBTYWx0ZWRfX6+6gLROxFPsy
 S42h3smYPDcgqQMHXSmFpSDZjCSAYNal4CJsOBvb7p9fKdpve4pPC/DEzaergxXdANqmMvqcFev
 ujPgljE6nxNYR13+GPHMXzhl3pPoI8O4wUohKsgK/1/xITpo0/1BbdYnxYrq2qO2YIo+jCTcj11
 23+EvmfOi/z6OVCeimEmR3T/O4+Bu01e4/E3d4ilk55icYui6j3FZfgO1YinD5cVYFdces3+6bY
 3yxII6m422TEpFlrSg77xZujQe+xy3jG5y/U+CpuByYZ0mjBB9D+T4PaAfNELzNLH77mnST9TmO
 mfp5dubSB8st2qygmL2YmLAKb5ygGpJvo0vY7MBF/cV6TbQHv3zEGjCWB+0WkUR0RipKMeI5deu
 4WTlKqyAOg7u/NpUldT6+/Y/TYB1QIADHCNXhOfzWjkEnNE6LkCXJ/kHhtve5G15IRH4XPfy
X-Proofpoint-ORIG-GUID: hLQLFf36K6JREgNDEIBgb_4nVOueVzLW
X-Proofpoint-GUID: hLQLFf36K6JREgNDEIBgb_4nVOueVzLW

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
index 3dfd8b34dceb..2d37ee7f70fb 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -117,27 +117,20 @@ static int drm_clients_info(struct seq_file *m, void *data)
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
index 4bf0a76bb35e..27a7069d819d 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -96,7 +96,7 @@ drm_gem_init(struct drm_device *dev)
 	struct drm_vma_offset_manager *vma_offset_manager;
 
 	mutex_init(&dev->object_name_lock);
-	idr_init_base(&dev->object_name_idr, 1);
+	xa_init_flags(&dev->object_names, XA_FLAGS_ALLOC1);
 
 	vma_offset_manager = drmm_kzalloc(dev, sizeof(*vma_offset_manager),
 					  GFP_KERNEL);
@@ -257,7 +257,7 @@ static void drm_gem_object_handle_free(struct drm_gem_object *obj)
 
 	/* Remove any name for this object */
 	if (obj->name) {
-		idr_remove(&dev->object_name_idr, obj->name);
+		xa_erase(&dev->object_names, obj->name);
 		obj->name = 0;
 	}
 }
@@ -908,11 +908,10 @@ drm_gem_flink_ioctl(struct drm_device *dev, void *data,
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
@@ -948,7 +947,7 @@ drm_gem_open_ioctl(struct drm_device *dev, void *data,
 		return -EOPNOTSUPP;
 
 	mutex_lock(&dev->object_name_lock);
-	obj = idr_find(&dev->object_name_idr, (int) args->name);
+	obj = xa_load(&dev->object_names, (int) args->name);
 	if (obj) {
 		drm_gem_object_get(obj);
 	} else {
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index e2f894f1b90a..7d8244078d51 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -314,8 +314,8 @@ struct drm_device {
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


