Return-Path: <linux-kernel+bounces-780099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C52AB2FD77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E70F27A8F33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CAD2EDD45;
	Thu, 21 Aug 2025 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ake7V/Gk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B5214204
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788088; cv=none; b=RIJ00SG6ao72lvd6VS41MI5E8C5hjUNahNRQZSMVYQxoWPujRd2dH5kJ53PWa9Cej1Objga+C1JPc3R7bJx6VADB1G5aOEzwqemzTnnbA7FjKseldB3oyzvrWbSTceELsaU+F0bjUzfoI3ImbQFWz4oFrV7lcCGoL7WJw9BnY9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788088; c=relaxed/simple;
	bh=h45ucrnhxS5+jV2uUGzcUVj+DBB1Ow09VgonFjZfrcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VH585ga0fjemhb7O9TvYdivgq7rSX088Si7jNGGUkL8od64WFIpt0zgJkkK8oGtyvrVzw6zxNZhFkVMWCxnQgKhSuaDLYtzRHiuHkUNk6ZfC0hDQiHxgyvd5ydoeR1GavBSPph8GhqszR1yRfNOcb/dHp9jJ3iSiK1EQhw0CtFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ake7V/Gk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LEBt6t019360;
	Thu, 21 Aug 2025 14:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ZB4H0
	brEDhy/BTQoDbDq/GzCpRwIb20+sslpqu7YiDg=; b=ake7V/GkRhm4O2LwVbpRM
	lsrT7Ap+zM/ZcGlMciNaJPOfom+bbzsJAs24if26PSo+OIfWK9GNeuoFXu2wpPdq
	uKqpi9sVjecAELqa+zcWq9fl3QN0fZk8J5IcyM4RhuKeadvqEGz8xdOJa4caUlmb
	tOcKtLNFVROnoGO1ZlD2todhQNjn6EkSryObl27Cuhey19w2ZPZJhgD2oNPlhhxL
	AKzTNlVjhUfKFDfr06gdOqn/Aj2JAdx9X9ZuO7L9xK7EHeTmxCOI2qMziwaSqrOH
	Ko87whtYmtK4NG4NMiWIzT9FVQsZ/T7knvLTDpnLHkVTv/s5tKbzUVinB+EsydMP
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tr3nme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 14:54:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LDtTHD020788;
	Thu, 21 Aug 2025 14:54:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48nj6g5s92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 14:54:34 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57LEpOeF011459;
	Thu, 21 Aug 2025 14:54:33 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48nj6g5s7m-5;
	Thu, 21 Aug 2025 14:54:33 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, willy@infradead.org,
        sidhartha.kumar@oracle.com
Subject: [PATCH v2 4/6] drm: Convert magic_map to XArray
Date: Thu, 21 Aug 2025 14:54:27 +0000
Message-ID: <20250821145429.305526-5-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: 8s0toXwNDUjgdIaF8e2CvN7hfbf-lqqa
X-Authority-Analysis: v=2.4 cv=FY1uBJ+6 c=1 sm=1 tr=0 ts=68a7332c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=2OwXVqhp2XgA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=9b9-1ReQUuPN9d1JgaQA:9
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: 8s0toXwNDUjgdIaF8e2CvN7hfbf-lqqa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX4DrbzftxXuKQ
 71VL8IShCarOARFd60PZLKcF6iQvSw0tj3tRZ45jjXSLq+OGzeop2vSlwW7BakoCmPZWHoDWFge
 5YYKgTDGvrlSkmCaxMGaFcFUlBvOrSypRO0b7UBlUkD7zdP4H+kjKdO/zAdcMXIqayFlCHXc7l4
 qRODkLRJokOnewH+TO/zYttViOvbd1XbjqLJcvA8B3o56RVKs7ebHfwlpFufmXA9rTCZbYGaOXA
 IXsn+0xXgYK7yKmgU7MtMEoHhrArP5pwHXq/81Gc11RTN98mq4bkHlGbDqSba8K4SHmB9UBWE/U
 EyA/YE/W1hIZB2nR1+3QVyvRXVVemr5BXJiy5JQ5y/hWIgD5RwCW90lKyQHHnnHU/f+JgANJ4Hf
 N4REk1w0gr04AjyXK+C/nhdwB/h6/FjkOKLSAu1ZjVrrZM3994M=

From: Matthew Wilcox <willy@infradead.org>

Part of the mass conversion of IDR users to the XArray API.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 drivers/gpu/drm/drm_auth.c | 18 ++++++++----------
 include/drm/drm_auth.h     |  5 ++---
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index a2556d16bed6..66a672384367 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -98,16 +98,15 @@ int drm_getmagic(struct drm_device *dev, void *data, struct drm_file *file_priv)
 
 	guard(mutex)(&dev->master_mutex);
 	if (!file_priv->magic) {
-		ret = idr_alloc(&file_priv->master->magic_map, file_priv,
-				1, 0, GFP_KERNEL);
-		if (ret >= 0)
-			file_priv->magic = ret;
+		ret = xa_alloc(&file_priv->master->magic_map,
+				&file_priv->magic, file_priv,
+				xa_limit_31b, GFP_KERNEL);
 	}
 	auth->magic = file_priv->magic;
 
 	drm_dbg_core(dev, "%u\n", auth->magic);
 
-	return ret < 0 ? ret : 0;
+	return ret;
 }
 
 int drm_authmagic(struct drm_device *dev, void *data,
@@ -119,10 +118,10 @@ int drm_authmagic(struct drm_device *dev, void *data,
 	drm_dbg_core(dev, "%u\n", auth->magic);
 
 	guard(mutex)(&dev->master_mutex);
-	file = idr_find(&file_priv->master->magic_map, auth->magic);
+	file = xa_load(&file_priv->master->magic_map, auth->magic);
 	if (file) {
 		file->authenticated = 1;
-		idr_replace(&file_priv->master->magic_map, NULL, auth->magic);
+		xa_store(&file_priv->master->magic_map, auth->magic, NULL, 0);
 	}
 
 	return file ? 0 : -EINVAL;
@@ -137,7 +136,7 @@ struct drm_master *drm_master_create(struct drm_device *dev)
 		return NULL;
 
 	kref_init(&master->refcount);
-	idr_init_base(&master->magic_map, 1);
+	xa_init_flags(&master->magic_map, XA_FLAGS_ALLOC1);
 	master->dev = dev;
 
 	/* initialize the tree of output resource lessees */
@@ -342,7 +341,7 @@ void drm_master_release(struct drm_file *file_priv)
 	guard(mutex)(&dev->master_mutex);
 	master = file_priv->master;
 	if (file_priv->magic)
-		idr_remove(&file_priv->master->magic_map, file_priv->magic);
+		xa_erase(&file_priv->master->magic_map, file_priv->magic);
 
 	if (!drm_is_current_master_locked(file_priv))
 		goto out;
@@ -408,7 +407,6 @@ static void drm_master_destroy(struct kref *kref)
 	if (drm_core_check_feature(dev, DRIVER_MODESET))
 		drm_lease_destroy(master);
 
-	idr_destroy(&master->magic_map);
 	idr_destroy(&master->leases);
 	idr_destroy(&master->lessee_idr);
 
diff --git a/include/drm/drm_auth.h b/include/drm/drm_auth.h
index 50131383ed81..3026aedbc205 100644
--- a/include/drm/drm_auth.h
+++ b/include/drm/drm_auth.h
@@ -58,10 +58,9 @@ struct drm_master {
 	 */
 	int unique_len;
 	/**
-	 * @magic_map: Map of used authentication tokens. Protected by
-	 * &drm_device.master_mutex.
+	 * @magic_map: Map of used authentication tokens.
 	 */
-	struct idr magic_map;
+	struct xarray magic_map;
 	void *driver_priv;
 
 	/**
-- 
2.43.0


