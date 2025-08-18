Return-Path: <linux-kernel+bounces-774329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A3DB2B12B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162553ABD0F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B16E274FCB;
	Mon, 18 Aug 2025 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HJ+GC+xj"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC1272E67
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543674; cv=none; b=e9imrxRvO/WNC/9M3n0v8JKUNR3wHjqextAvAawZBGsxZiiif1BlsZV+aWIJbVR5Kh5UE3x0hy1TYv1PMwEajUhzhtGzaYrOPnW7SHv5gl25N5x9HddMlssOEKhP7FBUkjQpkHa74chs0uD68yW12SeUSGo5UQyW1tvQSrT81m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543674; c=relaxed/simple;
	bh=ggOUmoAWgcJIqOg3JSRN/dabSPg5VetLhtsTjmVSjEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0ZNmHft6LGsZXM6JHIAjeoR1V8HUYt5fQhGfwzXIfENUqxt9trFPEX3+1b2cGfuigrgdWFrEqx8o0N/XmXkkQzze0H/NtWpLKtpymntO2AzxW6est70wV8VWaHypKE4DV5Wg+1PkrBvfQgT2+urnLXioCbx8ATDd8dM3KPT7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HJ+GC+xj; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEuCON030521;
	Mon, 18 Aug 2025 19:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=P8R2w
	JMavJM/HWLVU4xgPHCCkOrfB5Cm79QNOCOwutk=; b=HJ+GC+xjL5KVGenGyv9Cr
	I0ENd4JpDbcDVaE5HOVXI6JLPrNxv9wlG9rR9AIxC2hUSSWHqRfvUSDRvUKtn83K
	FQDlbL9gj4w6wysFALzWXYR6n2e1H57uFGFBdnrBZwPYWJNlc0x2kX1A/LdUrBV1
	bS4TP2hcjsrA4Q/RW5DMlMSSXu/cFoT2zI1GwFXlxw8odFrya57T0W704fjChkoj
	c3OCyh1DQuFgBvg1WbmvPYnVqphu2W5i3PL1HVo0zWL3g3gUVIk03//Lw6/mIIPq
	bGriSGV9ozR097jR2P4nIWV4XhgygDdm7wEf1tMBaI6EZsAOpDgDU2RlLKDNa8wA
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jj1e3tt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 19:00:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57II07VV016778;
	Mon, 18 Aug 2025 19:00:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge9d7tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 19:00:56 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57IJ0sZV035076;
	Mon, 18 Aug 2025 19:00:56 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48jge9d7p3-2;
	Mon, 18 Aug 2025 19:00:55 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, willy@infradead.org,
        sidhartha.kumar@oracle.com
Subject: [PATCH 1/6] drm: Convert aux_idr to XArray
Date: Mon, 18 Aug 2025 19:00:41 +0000
Message-ID: <20250818190046.157962-2-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: kikCSgG1Iz0viikSs0uQBKblV57_AJ0M
X-Authority-Analysis: v=2.4 cv=dN2mmPZb c=1 sm=1 tr=0 ts=68a3786a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=2OwXVqhp2XgA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=bhnSk7d9TMSBOys-tl0A:9
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE3OCBTYWx0ZWRfXyyb9aci2qd20
 JaK82F/XDgzEcGCpN6QeRt6dCL6IxxII4ZMhOSpjxuGrvQLR8u3u0vJ2iqn9BmChpaFefRV4knr
 aVacq1QO6obv2rDv2h4SbBFrQ2hu13y2Lf4RsWkwWfa5YpNpy8bpc7J7M5W76lNtS2NZkv93Wb0
 rqX0G84buQk0uGIMgvNVp9K6YigMYrvN0yTR/J929hKq7hNHWXwk9BVPCAh9W8CBwCSkH/YHqvs
 6vwVfSFc9jnxR6f+DUnzna4OFqYaEoh4CElK9ZCw9UZ1A3qceXr7vrWG3rarCdwflKsuKGmy3ua
 CRWZDF4NY6rR9iw+HuZMCrQvA8MOEkr7djMDlhP1FS+3ysXiP12jBwh3qTIop4vObZSdbmuiX3z
 Q1MpRliDQw+tBcq6vI5HHsAHJnKpsUJ38Tht+9W6gAwZhPLqZhWZHea3r8U7EmrhKJA4UK3H
X-Proofpoint-ORIG-GUID: kikCSgG1Iz0viikSs0uQBKblV57_AJ0M

From: Matthew Wilcox <willy@infradead.org>

Remove aux_idr_mutex by converting aux_idr to an XArray.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 drivers/gpu/drm/display/drm_dp_aux_dev.c | 38 ++++++++++--------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_aux_dev.c b/drivers/gpu/drm/display/drm_dp_aux_dev.c
index 29555b9f03c8..edecfea44da8 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_dev.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_dev.c
@@ -52,8 +52,7 @@ struct drm_dp_aux_dev {
 
 #define DRM_AUX_MINORS	256
 #define AUX_MAX_OFFSET	(1 << 20)
-static DEFINE_IDR(aux_idr);
-static DEFINE_MUTEX(aux_idr_mutex);
+static DEFINE_XARRAY_ALLOC(aux_xa);
 static struct class *drm_dp_aux_dev_class;
 static int drm_dev_major = -1;
 
@@ -61,11 +60,11 @@ static struct drm_dp_aux_dev *drm_dp_aux_dev_get_by_minor(unsigned index)
 {
 	struct drm_dp_aux_dev *aux_dev = NULL;
 
-	mutex_lock(&aux_idr_mutex);
-	aux_dev = idr_find(&aux_idr, index);
+	xa_lock(&aux_xa);
+	aux_dev = xa_load(&aux_xa, index);
 	if (aux_dev && !kref_get_unless_zero(&aux_dev->refcount))
 		aux_dev = NULL;
-	mutex_unlock(&aux_idr_mutex);
+	xa_unlock(&aux_xa);
 
 	return aux_dev;
 }
@@ -73,7 +72,7 @@ static struct drm_dp_aux_dev *drm_dp_aux_dev_get_by_minor(unsigned index)
 static struct drm_dp_aux_dev *alloc_drm_dp_aux_dev(struct drm_dp_aux *aux)
 {
 	struct drm_dp_aux_dev *aux_dev;
-	int index;
+	int err;
 
 	aux_dev = kzalloc(sizeof(*aux_dev), GFP_KERNEL);
 	if (!aux_dev)
@@ -82,14 +81,12 @@ static struct drm_dp_aux_dev *alloc_drm_dp_aux_dev(struct drm_dp_aux *aux)
 	atomic_set(&aux_dev->usecount, 1);
 	kref_init(&aux_dev->refcount);
 
-	mutex_lock(&aux_idr_mutex);
-	index = idr_alloc(&aux_idr, aux_dev, 0, DRM_AUX_MINORS, GFP_KERNEL);
-	mutex_unlock(&aux_idr_mutex);
-	if (index < 0) {
+	err = xa_alloc(&aux_xa, &aux_dev->index,
+				XA_LIMIT(0, DRM_AUX_MINORS - 1), aux_dev, GFP_KERNEL);
+	if (err < 0) {
 		kfree(aux_dev);
-		return ERR_PTR(index);
+		return ERR_PTR(err);
 	}
-	aux_dev->index = index;
 
 	return aux_dev;
 }
@@ -250,22 +247,19 @@ static const struct file_operations auxdev_fops = {
 
 static struct drm_dp_aux_dev *drm_dp_aux_dev_get_by_aux(struct drm_dp_aux *aux)
 {
-	struct drm_dp_aux_dev *iter, *aux_dev = NULL;
-	int id;
+	struct drm_dp_aux_dev *aux_dev;
+	unsigned long id;
 
 	/* don't increase kref count here because this function should only be
 	 * used by drm_dp_aux_unregister_devnode. Thus, it will always have at
 	 * least one reference - the one that drm_dp_aux_register_devnode
 	 * created
 	 */
-	mutex_lock(&aux_idr_mutex);
-	idr_for_each_entry(&aux_idr, iter, id) {
-		if (iter->aux == aux) {
-			aux_dev = iter;
+	xa_for_each(&aux_xa, id, aux_dev) {
+		if (aux_dev->aux == aux)
 			break;
-		}
 	}
-	mutex_unlock(&aux_idr_mutex);
+
 	return aux_dev;
 }
 
@@ -284,9 +278,7 @@ void drm_dp_aux_unregister_devnode(struct drm_dp_aux *aux)
 	 */
 	aux->drm_dev = NULL;
 
-	mutex_lock(&aux_idr_mutex);
-	idr_remove(&aux_idr, aux_dev->index);
-	mutex_unlock(&aux_idr_mutex);
+	xa_erase(&aux_xa, aux_dev->index);
 
 	atomic_dec(&aux_dev->usecount);
 	wait_var_event(&aux_dev->usecount, !atomic_read(&aux_dev->usecount));
-- 
2.43.0


