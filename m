Return-Path: <linux-kernel+bounces-774334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF1FB2B130
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238944E04BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A843115A7;
	Mon, 18 Aug 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b48qQMJ5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD602D24A7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543680; cv=none; b=TAZtAhNKrSxVpJW/vv79Yl/zK09jHbcBBEnEWLHoWxC5uLo61k38Q+Q2zGimTo+TpUd0pMzqFC20URNMNn4GRTGL5LLWLNBDFIeqFCBsCIrDjip+2hAlF29GCefKV6Tdz6mUImMR9VdDsRLXPm4nORUR4VoUOqRV8fWLbY1frbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543680; c=relaxed/simple;
	bh=J8FzFJe+D5zlLK80oZ76E2Zxv+yZXN+Ib1vx0wucb98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltsdyNPX7b2v2hNte61mIk/VxmxHsBU9AwBgkcWuWt58rvgTOa5d6ZRaSxTUM8qcatzE+hAWIMPEsMZbs+I4nf46IDjVz17J3NE8WmZc0W41xA7xUHWlTVIbCaovS7fF4BfXLze6m1FEG1XVbg9FWX7T/KGT2SOPY8ou/4t6yM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b48qQMJ5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEuHE2020507;
	Mon, 18 Aug 2025 19:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=VBCCe
	/d9WQBwETiM5fykv7+3abmROBsMk/JwG5aC7Wg=; b=b48qQMJ5ik2AuJZ/lUreZ
	gqFP0Axpm8Yw2eAEVvS6kHfTq83y0/u5wXDUjtLmV4HZDTst9L4j9zfcdJsM7u2l
	i07n4X2wM0adLGhOvh70fYieowUikkOjvDy1fyHFIqog5qkaDz8zh/t0I1Nm/4AV
	aJl3bcUrIW3uaC69ZkpTkxGWoMyEcYMz/7mugYe2kj4VVgKQWxMrdbRDBQOhG2NU
	nq8fdMHZcYcYFCECpmKvboPj8uTGFW+eJK4UTSRscQrz7rbWrtqgaradsge0m5rx
	m6ZaLAdChyOya6TvCmZv0OyEK+XHty6JbqPXIxNg30fp98k+9W4FQzJr0fcwHrz0
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jhkuus3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 19:01:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57IHiIAn016983;
	Mon, 18 Aug 2025 19:01:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge9d7yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 19:01:00 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57IJ0sZZ035076;
	Mon, 18 Aug 2025 19:00:59 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48jge9d7p3-4;
	Mon, 18 Aug 2025 19:00:59 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, willy@infradead.org,
        sidhartha.kumar@oracle.com
Subject: [PATCH 3/6] drm: Convert syncobj_idr to XArray
Date: Mon, 18 Aug 2025 19:00:43 +0000
Message-ID: <20250818190046.157962-4-sidhartha.kumar@oracle.com>
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
X-Proofpoint-GUID: X6yXwbbrKMoEawDTRElUtYA6dzYV9wTg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE3NyBTYWx0ZWRfX8Sir6UUxhEYJ
 AxYonMk6soBfBLH5k+Spj1DA4uIdlt0hBuOm6Ez6oQgv4Wl6gEMvfTfPwxTVkWBaMn6TN28p2d5
 tQV0wFjDfSZ7YGRAePPGls4dIaPLmhYgqL1gwtQqahsOQzvyEgXE6ifYm+kRD//DBp4Fc6HgKBO
 5M+BunyBny+RPTUYHy/T/TcGRvZYRrX5/mcXMORyDR3b3s1WGFiSZcg3KeZVrLh0OdM52uZI0Id
 rFovQhxaRh6VWUtlcqom7MgM34d7C+O6qUkJj68r8OB37XFyfsV9NX2/PqC5Ve3494ffhEj8Si6
 rkBpxP4PBcGOZBSOe446DWYD4pI6Lkmn9fDcziNnYuo8qhN9qSYqZpASv4G3BqDCzRUdPziCsx3
 /dTVhul8097ApnfVDEz+Z0yOSbChqErcPMYGPfjln3t/apEAS7TPzJSQ7zhi0vY3Hx+x9Hlp
X-Proofpoint-ORIG-GUID: X6yXwbbrKMoEawDTRElUtYA6dzYV9wTg
X-Authority-Analysis: v=2.4 cv=HKzDFptv c=1 sm=1 tr=0 ts=68a3786d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=2OwXVqhp2XgA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=2SHY49DYBmSurWS0lVIA:9
 a=1CNFftbPRP8L7MoqJWF3:22

From: Matthew Wilcox <willy@infradead.org>

Remove syncobj_table_lock by converting the syncobj_idr to an XArray.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 drivers/gpu/drm/drm_syncobj.c | 64 +++++++++++------------------------
 include/drm/drm_file.h        |  6 ++--
 2 files changed, 22 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 636cd83ca29e..2177a354c9f7 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -249,14 +249,12 @@ struct drm_syncobj *drm_syncobj_find(struct drm_file *file_private,
 {
 	struct drm_syncobj *syncobj;
 
-	spin_lock(&file_private->syncobj_table_lock);
-
-	/* Check if we currently have a reference on the object */
-	syncobj = idr_find(&file_private->syncobj_idr, handle);
+	/* Get a reference on the object */
+	xa_lock(&file_private->syncobjs);
+	syncobj = xa_load(&file_private->syncobjs, handle);
 	if (syncobj)
 		drm_syncobj_get(syncobj);
-
-	spin_unlock(&file_private->syncobj_table_lock);
+	xa_unlock(&file_private->syncobjs);
 
 	return syncobj;
 }
@@ -597,23 +595,16 @@ int drm_syncobj_get_handle(struct drm_file *file_private,
 {
 	int ret;
 
-	/* take a reference to put in the idr */
+	/* take a reference to put in the XArray */
 	drm_syncobj_get(syncobj);
 
-	idr_preload(GFP_KERNEL);
-	spin_lock(&file_private->syncobj_table_lock);
-	ret = idr_alloc(&file_private->syncobj_idr, syncobj, 1, 0, GFP_NOWAIT);
-	spin_unlock(&file_private->syncobj_table_lock);
+	ret = xa_alloc(&file_private->syncobjs, handle, syncobj, xa_limit_31b,
+			GFP_KERNEL);
 
-	idr_preload_end();
-
-	if (ret < 0) {
+	if (ret < 0)
 		drm_syncobj_put(syncobj);
-		return ret;
-	}
 
-	*handle = ret;
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(drm_syncobj_get_handle);
 
@@ -637,9 +628,7 @@ static int drm_syncobj_destroy(struct drm_file *file_private,
 {
 	struct drm_syncobj *syncobj;
 
-	spin_lock(&file_private->syncobj_table_lock);
-	syncobj = idr_remove(&file_private->syncobj_idr, handle);
-	spin_unlock(&file_private->syncobj_table_lock);
+	syncobj = xa_erase(&file_private->syncobjs, handle);
 
 	if (!syncobj)
 		return -EINVAL;
@@ -725,16 +714,10 @@ static int drm_syncobj_fd_to_handle(struct drm_file *file_private,
 	syncobj = fd_file(f)->private_data;
 	drm_syncobj_get(syncobj);
 
-	idr_preload(GFP_KERNEL);
-	spin_lock(&file_private->syncobj_table_lock);
-	ret = idr_alloc(&file_private->syncobj_idr, syncobj, 1, 0, GFP_NOWAIT);
-	spin_unlock(&file_private->syncobj_table_lock);
-	idr_preload_end();
+	ret = xa_alloc(&file_private->syncobjs, handle, syncobj, xa_limit_31b,
+			GFP_KERNEL);
 
-	if (ret > 0) {
-		*handle = ret;
-		ret = 0;
-	} else
+	if (ret < 0)
 		drm_syncobj_put(syncobj);
 
 	return ret;
@@ -813,17 +796,7 @@ static int drm_syncobj_export_sync_file(struct drm_file *file_private,
 void
 drm_syncobj_open(struct drm_file *file_private)
 {
-	idr_init_base(&file_private->syncobj_idr, 1);
-	spin_lock_init(&file_private->syncobj_table_lock);
-}
-
-static int
-drm_syncobj_release_handle(int id, void *ptr, void *data)
-{
-	struct drm_syncobj *syncobj = ptr;
-
-	drm_syncobj_put(syncobj);
-	return 0;
+	xa_init_flags(&file_private->syncobjs, XA_FLAGS_ALLOC1);
 }
 
 /**
@@ -837,9 +810,12 @@ drm_syncobj_release_handle(int id, void *ptr, void *data)
 void
 drm_syncobj_release(struct drm_file *file_private)
 {
-	idr_for_each(&file_private->syncobj_idr,
-		     &drm_syncobj_release_handle, file_private);
-	idr_destroy(&file_private->syncobj_idr);
+	struct drm_syncobj *syncobj;
+	unsigned long index;
+
+	xa_for_each(&file_private->syncobjs, index, syncobj)
+		drm_syncobj_put(syncobj);
+	xa_destroy(&file_private->syncobjs);
 }
 
 int
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 5c3b2aa3e69d..68928554d426 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -306,10 +306,8 @@ struct drm_file {
 	/** @table_lock: Protects @object_idr. */
 	spinlock_t table_lock;
 
-	/** @syncobj_idr: Mapping of sync object handles to object pointers. */
-	struct idr syncobj_idr;
-	/** @syncobj_table_lock: Protects @syncobj_idr. */
-	spinlock_t syncobj_table_lock;
+	/** @syncobjs: Mapping of sync object handles to object pointers. */
+	struct xarray syncobjs;
 
 	/** @filp: Pointer to the core file structure. */
 	struct file *filp;
-- 
2.43.0


