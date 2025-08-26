Return-Path: <linux-kernel+bounces-786941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63026B36F11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4CB466F96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15F4371E92;
	Tue, 26 Aug 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kcY2ezjQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3998D36CE11
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223360; cv=none; b=Cpz65yZ87m8wpkqM67HE4Jurl3+UfB//czZpC3o0x3ZbAoP0HOd2fy+O0QOPSIvi0ZDE9/xmF57pOUk4Hli2ut/CnKhUh0w9Lb6BLBbrsrsFlkg1coCNEJD2X7dfpqNu4MYqBrZ6fCf28uludxgKkb56d7hiTUruVnKjvza+WO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223360; c=relaxed/simple;
	bh=RIjUSIwG/uIpA5EV9aElbVGmyMLQsr6kA3pUCRyqlAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnfV4D+zdYRjrfMV3vikGtF2rliCJcrXUkOeBeqqf2w+IMU8Hj24vJwXnDUQEEu6jAI4UlSP2DFhd3OFLWgoNSAMB92foxonMLn8HiMiGGpIIl4Ic34PKfbertVlkkk34d6v0kzePLZ698m2C/peDgtMqyLNZ9GUdbfmTj7QD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kcY2ezjQ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFC6F6012242;
	Tue, 26 Aug 2025 15:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=b+tGX
	nO+yUqjA0bAwDOtEXN0GyA6M2rDHzv64O8PnCE=; b=kcY2ezjQsCRKmhzZkMIvX
	cUPBweqqVdkHac55sieHy3IRF6gA1Wqzy+/YH4Fw97UuTtUQYJDPm05GMZXwyMBm
	3iY8zL+6vzZJxtXqSg6TN+cn4D/+UcWvLdL/DMiKE9m1HVkvVOnYnfgvtDpU5gf0
	331ip1+3SGdZeuwwbD8YYKp+A1Nj2gstEpmIzF+vz/7x7WNyyPQaXRxvnoFqzQFN
	wJw6RqFXF2/Szx0jl9SshQowzY9ZbOd0d0LQJbAgCp+U26133vKqLGisAapDcQUv
	7VHCCODE/WvSsc4uPZa1i4hK09FQ6v7Yj6TBRyQa7KcP6Qou9+ovzZaThRdK/O4s
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48emthd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:49:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFOWje014743;
	Tue, 26 Aug 2025 15:49:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q439pn3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:49:07 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57QFn4ET020762;
	Tue, 26 Aug 2025 15:49:07 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48q439pn0g-7;
	Tue, 26 Aug 2025 15:49:07 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, willy@infradead.org,
        sidhartha.kumar@oracle.com, jani.nikula@linux.intel.com
Subject: [PATCH v3 6/6] drm: Convert tile_idr to XArray
Date: Tue, 26 Aug 2025 15:49:00 +0000
Message-ID: <20250826154900.405480-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826154900.405480-1-sidhartha.kumar@oracle.com>
References: <20250826154900.405480-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260139
X-Proofpoint-GUID: HSCIh1lc47MP5uh4RxT2ii1U6v2eIbxg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfX54PKjP6nIVHv
 XLIM9/t0PK3yibvQqtEUszwqq3ofD3BwltbP1bU2n+LLrYMf5JXYqHJmHm+eygnuKRArTOwKi/D
 uEijlEZU9mWO31YYfBuUxYIVederWE9T3cM7XQve4zaw1ncFbqN/Dbo0Fa/IZ2zamTX0NMywqL7
 hMgaREc5M8Z9emyvC+fRHQIUmmrVVDBqAihzlpLB+OE49gvFQGxzf4fEHvzS5FJR5sTeke2Gdhi
 GC7zwlaKxXQu8uvlUjU4GVveii7fwv7njQnWYu0Zd96qctyXD4huPqCD0q7kJ5BztsQXRzzd4NW
 s0YSTKurXek0qKp2pEs8EyhQk8wmhh4wlKlJpp9ApNcZWGLpo/iN+EVbWOx1F6VOYZwFjSB/MVG
 mtCuvEOBdme3zs0zRyHVhl4adcwCkA==
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68add775 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=2OwXVqhp2XgA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=Kp7_PmMn9Y2_fy4brQkA:9
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: HSCIh1lc47MP5uh4RxT2ii1U6v2eIbxg

From: Matthew Wilcox <willy@infradead.org>

From: Matthew Wilcox <willy@infradead.org>

Convert tile_idr to an Xarray. tg->id and tg are not modified so the
indentifiers are unchanged.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 drivers/gpu/drm/drm_connector.c   | 26 ++++++++++----------------
 drivers/gpu/drm/drm_mode_config.c |  3 +--
 include/drm/drm_mode_config.h     | 12 ++++++------
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 272d6254ea47..6a64e20d730a 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3531,9 +3531,7 @@ static void drm_tile_group_free(struct kref *kref)
 	struct drm_tile_group *tg = container_of(kref, struct drm_tile_group, refcount);
 	struct drm_device *dev = tg->dev;
 
-	mutex_lock(&dev->mode_config.idr_mutex);
-	idr_remove(&dev->mode_config.tile_idr, tg->id);
-	mutex_unlock(&dev->mode_config.idr_mutex);
+	xa_erase(&dev->mode_config.tiles, tg->id);
 	kfree(tg);
 }
 
@@ -3565,19 +3563,18 @@ struct drm_tile_group *drm_mode_get_tile_group(struct drm_device *dev,
 					       const char topology[8])
 {
 	struct drm_tile_group *tg;
-	int id;
+	unsigned long id;
 
-	mutex_lock(&dev->mode_config.idr_mutex);
-	idr_for_each_entry(&dev->mode_config.tile_idr, tg, id) {
+	xa_lock(&dev->mode_config.tiles);
+	xa_for_each(&dev->mode_config.tiles, id, tg) {
 		if (!memcmp(tg->group_data, topology, 8)) {
 			if (!kref_get_unless_zero(&tg->refcount))
 				tg = NULL;
-			mutex_unlock(&dev->mode_config.idr_mutex);
-			return tg;
+			break;
 		}
 	}
-	mutex_unlock(&dev->mode_config.idr_mutex);
-	return NULL;
+	xa_unlock(&dev->mode_config.tiles);
+	return tg;
 }
 EXPORT_SYMBOL(drm_mode_get_tile_group);
 
@@ -3606,16 +3603,13 @@ struct drm_tile_group *drm_mode_create_tile_group(struct drm_device *dev,
 	memcpy(tg->group_data, topology, 8);
 	tg->dev = dev;
 
-	mutex_lock(&dev->mode_config.idr_mutex);
-	ret = idr_alloc(&dev->mode_config.tile_idr, tg, 1, 0, GFP_KERNEL);
-	if (ret >= 0) {
-		tg->id = ret;
-	} else {
+	ret = xa_alloc(&dev->mode_config.tiles, &tg->id, tg, xa_limit_32b,
+			GFP_KERNEL);
+	if (ret < 0) {
 		kfree(tg);
 		tg = NULL;
 	}
 
-	mutex_unlock(&dev->mode_config.idr_mutex);
 	return tg;
 }
 EXPORT_SYMBOL(drm_mode_create_tile_group);
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 25f376869b3a..680b97ab58ec 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -439,7 +439,7 @@ int drmm_mode_config_init(struct drm_device *dev)
 	INIT_LIST_HEAD(&dev->mode_config.plane_list);
 	INIT_LIST_HEAD(&dev->mode_config.privobj_list);
 	idr_init_base(&dev->mode_config.object_idr, 1);
-	idr_init_base(&dev->mode_config.tile_idr, 1);
+	xa_init_flags(&dev->mode_config.tiles, XA_FLAGS_ALLOC1);
 	ida_init(&dev->mode_config.connector_ida);
 	spin_lock_init(&dev->mode_config.connector_list_lock);
 
@@ -578,7 +578,6 @@ void drm_mode_config_cleanup(struct drm_device *dev)
 	}
 
 	ida_destroy(&dev->mode_config.connector_ida);
-	idr_destroy(&dev->mode_config.tile_idr);
 	idr_destroy(&dev->mode_config.object_idr);
 	drm_modeset_lock_fini(&dev->mode_config.connection_mutex);
 }
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 2e848b816218..9e3914119587 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -393,8 +393,8 @@ struct drm_mode_config {
 	/**
 	 * @idr_mutex:
 	 *
-	 * Mutex for KMS ID allocation and management. Protects both @object_idr
-	 * and @tile_idr.
+	 * Mutex for KMS ID allocation and management. Protects the
+	 * objects in @object_idr.
 	 */
 	struct mutex idr_mutex;
 
@@ -407,12 +407,12 @@ struct drm_mode_config {
 	struct idr object_idr;
 
 	/**
-	 * @tile_idr:
+	 * @tiles:
 	 *
-	 * Use this idr for allocating new IDs for tiled sinks like use in some
-	 * high-res DP MST screens.
+	 * Use this for allocating new IDs for tiled sinks like those
+	 * used in some high-res DP MST screens.
 	 */
-	struct idr tile_idr;
+	struct xarray tiles;
 
 	/** @fb_lock: Mutex to protect fb the global @fb_list and @num_fb. */
 	struct mutex fb_lock;
-- 
2.43.0


