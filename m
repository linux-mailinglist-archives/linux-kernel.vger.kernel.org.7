Return-Path: <linux-kernel+bounces-786937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0FCB36F01
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905821BC4925
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A7E370592;
	Tue, 26 Aug 2025 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LMXoOvUC"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF136CC96
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223358; cv=none; b=AmpzhP7Zm1bq5mg0qQH/P02ON15rk6wstl0bfzCFPvjSKVqYbiYdYTYUggI9j3Rl5jobuxZn/ycGvDt70M6ZSC/3uk4evmbUbH5aAn4/lfSSXmAtQsiPLjHlNzkzl0Hobv1snxNM3AW66+dav4r3dBEavYZfbEC7dUE3GsDaswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223358; c=relaxed/simple;
	bh=/6egTAUKqDcH+IAHLljH6wDVr3KtJWe+zgsHitcHDkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXvC8IpGpeEf1Zuwe/doDxFORBLoOXCdo7PlIv0JXe9P6mjRLVC/xlXhLtGLtdsX7RiNPdzaM7OuQlLlvvuB3VNRZZ3Ckw+L5FhI9yGGRiB/jlRjkS5V4Q7HROKC4oGQJTO7UP6rw0xuKkxAHsHd1x7CZxHpJhTtdCzwIJBwvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LMXoOvUC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFC8dU012119;
	Tue, 26 Aug 2025 15:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=k16C3
	P8aqJI7IXthNKPo8RJJ52RrODS+VY1r4Vjr708=; b=LMXoOvUCgSP2A/QkyH3qi
	dbi9rZwg/btrf7Hx3gVqRtvn8WHKNCNtPYR7dePLKADAkmiLN5KTMcwfRqV9Ii5M
	p7eM92OQaIp7x2zmp6p4KuIPQII16jnqttYla9NGctg59yZFEvWZ2hg8foYVx7a8
	cWWvv2xOyZ64ogx7hyzF71cK7h0KOQOXobpy4y9A0CQM/I6NDQk3zDWFZuKKg5eO
	a0B8quskOHfRjr4nkqu8jCi+AFtaGeumSoUoVjo7o9WGL+aPghKZ5fDp1Y581xsr
	IR5MrCC83Uwt3bChJYbO0FWEDNjTTzAbCwoGuLAN+7/XeWBuQPdGwRAZs0jN31xR
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jamqqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:49:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QEaOHv014571;
	Tue, 26 Aug 2025 15:49:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q439pn2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 15:49:06 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57QFn4EP020762;
	Tue, 26 Aug 2025 15:49:06 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48q439pn0g-5;
	Tue, 26 Aug 2025 15:49:06 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, willy@infradead.org,
        sidhartha.kumar@oracle.com, jani.nikula@linux.intel.com
Subject: [PATCH v3 4/6] drm: Convert magic_map to XArray
Date: Tue, 26 Aug 2025 15:48:58 +0000
Message-ID: <20250826154900.405480-5-sidhartha.kumar@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX9+o1DegDWi6y
 gm0NPWtxjU1EOv99xOpuE55UlXGCho+w4xeJQZlAtUnlQB/4t+ANT/iFP0XD3fSztlevFJNZKeX
 Gp2xPEDS2MPWDWkk/f5ImW83uspyoAIOLooPhTcHL62xCHlOReK34fUgsmDtGeAq7E6iHucZoHF
 h7sLtHZOGJ5I2kYoPWb/gSONMMq60FdXkv0MgC5mij6odZiC9ILj3PQmXkrwP0OYa1onT5zzgMk
 SZDgO7KfyzAnSmlCgL/vP1jAX5UKFgWvKMpdHZnKV3QqjNgEdb5sqLH5U7tb628aA+SySWlPXU0
 Ma7yNOGNiWqRZn/Ow0ePR6H3BuHZ/o+rVzF7ZTStT+ZG9r0ET3hpOp3nvmLVJJ7cbglsj206uhj
 WHNjC1dIFMEw7cUWh4jOmp+MY19Tag==
X-Proofpoint-GUID: auVsG37P0evKN8Y3psnod54M32W12GDJ
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68add774 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=2OwXVqhp2XgA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=9b9-1ReQUuPN9d1JgaQA:9
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: auVsG37P0evKN8Y3psnod54M32W12GDJ

From: Matthew Wilcox <willy@infradead.org>

From: Matthew Wilcox <willy@infradead.org>

Part of the mass conversion of IDR users to the XArray API.
file_priv->master->magic_map, auth->magic, and file_priv->magic
so the indentifiers are unchanged.


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


