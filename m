Return-Path: <linux-kernel+bounces-774332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA78B2B12F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB373AD114
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB5C27603A;
	Mon, 18 Aug 2025 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NygvIC3B"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E88B273D9A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543676; cv=none; b=bpGs9TPuiO8N5o8HhCuYSgtP/Ggj04adsNc3121Xp60nEdQPNUWeJTtpWQlAJL80/9pjhmLU40cEELVaUFFbb8laBCMiVu9QFfFvR/bkiD5OUgKNxFVN42QxC7QnjDEYEUGd8EmTauOCOCY4cnaKxrT7aYlHkpOX8fG4+WE3pcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543676; c=relaxed/simple;
	bh=BT+TjyEVHqq1oejrutGpPkWvMjLia7Y9yIZkSZoi/78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRIbcylOxmqW0y7dmXKERZMLe6ZS9ghG/IhC/AopmA8CarSRB1qyce9ojnV46xiRqGJtvygUvyUT5hVm3lg/dQgdwzfY9rg4ioawYx6bMJ2gCqOjW0IjDALqMoNHbA5MaCsnxbUhOXTYIndD29x/N6z0f38laHOpkExIndsCckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NygvIC3B; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IEtqWu025882;
	Mon, 18 Aug 2025 19:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=MSeAY
	l4WIe1MHOBDjnbrRMd2XBvT8Hoto0h0qC2vqwo=; b=NygvIC3Bfwk9vCeOd9XcT
	C8ZSktZuryqNHVfMyh2wRSA1QeLanz1Je9I3S4+0gBofnHJEQHZ3gg+COlvTafwJ
	lPGENfj1A9bTDodV86KJOUb7k28PNFcwVP64n6/bg3MhdOdB0ccQBAKM6AkzORft
	gSLzodDGw/RQFmHmcIT44FSRvbRbgrVoU8KMa0IjMNAqAVavpMXHsca6kllSIDqY
	vtyiiNnagnzCcJ+Wip8Eav3ppf9Em9ol8G0azF/4XM/zmN2YNodzHqo3CFYzqkwP
	vjW2aOxkZt2pZSXMG4F9kBhhg1/4VBNmLdYUI5gtqzPKaJ4J+J4aLA8hvucEoluS
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgdfksyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 19:01:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57IIHmra016771;
	Mon, 18 Aug 2025 19:01:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge9d82g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 19:01:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57IJ0sZb035076;
	Mon, 18 Aug 2025 19:01:01 GMT
Received: from sidhakum-ubuntu.osdevelopmeniad.oraclevcn.com (sidhakum-ubuntu.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.108])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48jge9d7p3-5;
	Mon, 18 Aug 2025 19:01:00 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
        airlied@gmail.com, simona@ffwll.ch, willy@infradead.org,
        sidhartha.kumar@oracle.com
Subject: [PATCH 4/6] drm: Convert magic_map to XArray
Date: Mon, 18 Aug 2025 19:00:44 +0000
Message-ID: <20250818190046.157962-5-sidhartha.kumar@oracle.com>
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
X-Proofpoint-ORIG-GUID: TYB0foLI-pnysjVESdICK1vLO11HlgPe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE3OCBTYWx0ZWRfXwy9smJPRc8vw
 Wpdofehdqebi0jwzRPU6TwVvfe4jJuC0U1asovHF1oMEu7raqcHU1aokXj6ai/WRr1HoXfazdY0
 Z3Tjhwn5h1km2+HtObQNrnQ0FdOg3F2bMK8lcKQ1YaiTSMpVqUn89fs/irPsIYn7dPtuq9Xv8fN
 EG7aJfaFTZ9eqAbuiipfIjvsOFsf3FwhTX93KEXI7kBCu+gPmZAlFdCzURYBtChcaqG1BMfxaTU
 M9tzo+LSTXv2LY8eF5eXw+SpDIBfWqR3hq4KcGZnBMEnNwSf9MPpptb6mzXjCTfRVq6AuBNc3cx
 oLg8ALrly5hCKCJJ2Qhk+ZnnwQrZF7HuywloUCCgk0GlOVApn7W6kpXJdI03dI9pH/pE9Tu5k7z
 E7J2daOoP89aLQss/9GEDJkAb2xHHJB2gu93bF6JadgCZ970giiX/wdEBLIoEejK+7wV0Mj4
X-Proofpoint-GUID: TYB0foLI-pnysjVESdICK1vLO11HlgPe
X-Authority-Analysis: v=2.4 cv=OK4n3TaB c=1 sm=1 tr=0 ts=68a37870 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=2OwXVqhp2XgA:10 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=tR0JZ8r007ulJvwtm9kA:9
 a=1CNFftbPRP8L7MoqJWF3:22

From: Matthew Wilcox <willy@infradead.org>

Part of the mass conversion of IDR users to the XArray API.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 drivers/gpu/drm/drm_auth.c | 18 ++++++++----------
 include/drm/drm_auth.h     |  5 ++---
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index 22aa015df387..41aa20144a9d 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -97,17 +97,16 @@ int drm_getmagic(struct drm_device *dev, void *data, struct drm_file *file_priv)
 
 	mutex_lock(&dev->master_mutex);
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
 	mutex_unlock(&dev->master_mutex);
 
 	drm_dbg_core(dev, "%u\n", auth->magic);
 
-	return ret < 0 ? ret : 0;
+	return ret;
 }
 
 int drm_authmagic(struct drm_device *dev, void *data,
@@ -119,10 +118,10 @@ int drm_authmagic(struct drm_device *dev, void *data,
 	drm_dbg_core(dev, "%u\n", auth->magic);
 
 	mutex_lock(&dev->master_mutex);
-	file = idr_find(&file_priv->master->magic_map, auth->magic);
+	file = xa_load(&file_priv->master->magic_map, auth->magic);
 	if (file) {
 		file->authenticated = 1;
-		idr_replace(&file_priv->master->magic_map, NULL, auth->magic);
+		xa_store(&file_priv->master->magic_map, auth->magic, NULL, 0);
 	}
 	mutex_unlock(&dev->master_mutex);
 
@@ -138,7 +137,7 @@ struct drm_master *drm_master_create(struct drm_device *dev)
 		return NULL;
 
 	kref_init(&master->refcount);
-	idr_init_base(&master->magic_map, 1);
+	xa_init_flags(&master->magic_map, XA_FLAGS_ALLOC1);
 	master->dev = dev;
 
 	/* initialize the tree of output resource lessees */
@@ -358,7 +357,7 @@ void drm_master_release(struct drm_file *file_priv)
 	mutex_lock(&dev->master_mutex);
 	master = file_priv->master;
 	if (file_priv->magic)
-		idr_remove(&file_priv->master->magic_map, file_priv->magic);
+		xa_erase(&file_priv->master->magic_map, file_priv->magic);
 
 	if (!drm_is_current_master_locked(file_priv))
 		goto out;
@@ -425,7 +424,6 @@ static void drm_master_destroy(struct kref *kref)
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


