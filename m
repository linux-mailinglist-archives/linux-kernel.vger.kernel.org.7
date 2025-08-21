Return-Path: <linux-kernel+bounces-780097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD08B2FDA9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4722B17B64F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD72EDD41;
	Thu, 21 Aug 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qA9JbZDF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4F2D8398
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788088; cv=none; b=dBN7tegRaS8ccFTPqHtPHknbUjyW1I6v0g/gku/Ubjc4oZ/6vivPWgLUWNGADQCju5x0tyf+dTDFmzGdlmpuXRcIsSHoJNtZNoGXG0NuLOtHuktPloNCvtjcNqnO5QN88BfyMrimrdkit7fIIuOa4R9KUYtO9QLkGksYcz8MFiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788088; c=relaxed/simple;
	bh=LHoOk1R0I/aotAQ/hwjk0mtC527HC+UTcT9bFpcFVCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3ZAILd7UN+DT5ztyqwbuU2Hy7M4WyX14piwEB/zt2eLE6hzKGNn0qhgnsH7GQIlmondsHDrUq0yncKGE/lQEgKZBPZmrL+j+UTUyFv+OjW4/j4BiHyDqgIpHQCjaQw0iADivPpvrbU0TWaynbw/dMxzBYqmQUpiZjEHL/oB8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qA9JbZDF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LEUrVx004114;
	Thu, 21 Aug 2025 14:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=lJQR2
	s5bFPpJRdaGreBdaLP1uehipPklXjIX0NvKcUM=; b=qA9JbZDFaxtUcitSUs4O+
	4QUnvwlloAB3KAVIi1kaS+M8M3EmINl/4XiXzVkMvPgtx0Z0Dj27ADvwT6J2TipV
	EQGa/2YB6XenFDpIn09vheBDcHJMGJw+kYBCw6iz3qPXEy54ICGOHFUUyjKLEtEz
	3Y8UrDrR++HpKQC8CRrLAKZiWs2rTc4qiIUM8p5E85jM9M1VHR6G93BSooFjIzpu
	7mWg4Jpla9JvLOinSX0XM7suRItRWM7VEGut7GewFMqindvPprNUaJ62/Fpm3wUc
	axmWYB25uI5MF1FpzP0L5ZBF/NXhqf7WvgDS3OMWprqNIwn+9PRyy/oXlhfKlv+j
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqussd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 14:54:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LENd3t020541;
	Thu, 21 Aug 2025 14:54:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48nj6g5s9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 14:54:35 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57LEpOeJ011459;
	Thu, 21 Aug 2025 14:54:34 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48nj6g5s7m-7;
	Thu, 21 Aug 2025 14:54:34 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, willy@infradead.org,
        sidhartha.kumar@oracle.com
Subject: [PATCH v2 6/6] drm: Convert tile_idr to XArray
Date: Thu, 21 Aug 2025 14:54:29 +0000
Message-ID: <20250821145429.305526-7-sidhartha.kumar@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXw2za5PaxncGA
 vFmd5jqHnHfqlEL5KiIl71moeADqTdsYcW0Ka8LKaQat22ldMY3Dz+0HFfUN3SYt+nOQ5w7LPvV
 zpTNMG2ZZzB4DK+32WAuYjcQbTMRvnDdzhaLU9idsVWIzshWUs6IkfLzZ3+ZbZfUJnDDciawNNg
 E1REBXoHHWKMJRAz68bwXxyeT9/wfpxdYn1SigTzWiEBQ5f2lxAZMl6upFpiESaSIMkEX0v9JwS
 OM+RDULYOjOKRPNHQRDPJjBa08RleMzWg2dN1QcHNU8PSh+VOomc7diydyUIDVYVwOk/2Lotbum
 OWPgrOsKa5HFLvC7INWRxQ+UtCXw2+mN7RhRs7gPB6nROVf48V4J3yw9BS/4O5bCzslLKP9hCwW
 AZ6aDVmUEbSAc4J/LJNi2gJQq9LsEUK+W/cwEcZsVR12OXVftek=
X-Proofpoint-ORIG-GUID: qKSCdOefhPm1ICh8l5-rj5uZHRoWk9zf
X-Proofpoint-GUID: qKSCdOefhPm1ICh8l5-rj5uZHRoWk9zf
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a7332b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=EcGSMKKx8drgTz_rwpoA:9
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12069

From: Matthew Wilcox <willy@infradead.org>

Convert tile_idr to an Xarray.

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


