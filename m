Return-Path: <linux-kernel+bounces-820816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4720BB7F52F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3DD97B7D97
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A9C30CB58;
	Wed, 17 Sep 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YYiHeQqX"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC842ECD2D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115840; cv=none; b=XLSifL3F+nF6QEtIudsoEugh+SBEscxPSBqrHK3NL0fW5+sMqv0ZBwTqUoVDEqYcHX+gG5sXPzi7R9V7qpH4R4uZcMpJusl+TeX5sgTSmSm2b5pSKOQOmBLQf9GzfY3dKBQxi5JfR2kkeJu7PxJ2iOkxqD45TUJNLHLJUgM8LZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115840; c=relaxed/simple;
	bh=zf5v0P2isE0qmAmZVojJgSZzamCbh8gBkuc7+76jBBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ruRCHfyUZA0QGQJild5LIw6GXCN27+4IOzV8SmYaavSVr0bBe5yIFDjlhH1N8rRT6vf5FfULpAWo7xM/4EqZbhZJwnAwRQqV0zfKjr9xtDrSZhNN/qhEdpEPm9kdC+OgoImWNz9fchkSvC7o4flJC25Orq5VsETyejMLl+07GzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YYiHeQqX; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250917133037epoutp037998bb2402f909529534c201a3ab77e9~mFQn4kGE32743527435epoutp03g
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:30:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250917133037epoutp037998bb2402f909529534c201a3ab77e9~mFQn4kGE32743527435epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758115837;
	bh=VbBlpRaiPk+6zIQaFNB8aIo/sNFkPAmn9Rc+w20AuEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YYiHeQqXstB1/kiKT39EKoqmxEDgGLRi1swYjqW0cpbrPsCYSOrOLHaL/SKZLhOCT
	 7fbWH5trkNoezAjuLkp9syyZxNDnWkNiIDiwVEtBxpAGhZovnnSp8Du9Xmb+VQeTyT
	 cpqwg5ZF1TXhJQFiUGejEv2CJP2DvBS02QHpV8bU=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250917133036epcas5p364a9f554efae2e2a9a9ed900edd22385~mFQnpa5_S3266232662epcas5p3F;
	Wed, 17 Sep 2025 13:30:36 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cRflv6NS8z6B9m5; Wed, 17 Sep
	2025 13:30:35 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250917133034epcas5p2c9485e40fce4c3a5a826cc94d515b25d~mFQlhDwy90307503075epcas5p2b;
	Wed, 17 Sep 2025 13:30:34 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250917133032epsmtip1fa2d4577804d9b271436265de3f63631~mFQj-zJgV0417404174epsmtip1h;
	Wed, 17 Sep 2025 13:30:32 +0000 (GMT)
From: Neeraj Kumar <s.neeraj@samsung.com>
To: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com
Cc: a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	Neeraj Kumar <s.neeraj@samsung.com>
Subject: [PATCH V3 04/20] nvdimm/label: Update mutex_lock() with
 guard(mutex)()
Date: Wed, 17 Sep 2025 18:59:24 +0530
Message-Id: <20250917132940.1566437-5-s.neeraj@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250917132940.1566437-1-s.neeraj@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250917133034epcas5p2c9485e40fce4c3a5a826cc94d515b25d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917133034epcas5p2c9485e40fce4c3a5a826cc94d515b25d
References: <20250917132940.1566437-1-s.neeraj@samsung.com>
	<CGME20250917133034epcas5p2c9485e40fce4c3a5a826cc94d515b25d@epcas5p2.samsung.com>

Updated mutex_lock() with guard(mutex)()

Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
---
 drivers/nvdimm/label.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 668e1e146229..3235562d0e1c 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -948,7 +948,7 @@ static int __pmem_label_update(struct nd_region *nd_region,
 		return rc;
 
 	/* Garbage collect the previous label */
-	mutex_lock(&nd_mapping->lock);
+	guard(mutex)(&nd_mapping->lock);
 	list_for_each_entry(label_ent, &nd_mapping->labels, list) {
 		if (!label_ent->label)
 			continue;
@@ -960,20 +960,20 @@ static int __pmem_label_update(struct nd_region *nd_region,
 	/* update index */
 	rc = nd_label_write_index(ndd, ndd->ns_next,
 			nd_inc_seq(__le32_to_cpu(nsindex->seq)), 0);
-	if (rc == 0) {
-		list_for_each_entry(label_ent, &nd_mapping->labels, list)
-			if (!label_ent->label) {
-				label_ent->label = nd_label;
-				nd_label = NULL;
-				break;
-			}
-		dev_WARN_ONCE(&nspm->nsio.common.dev, nd_label,
-				"failed to track label: %d\n",
-				to_slot(ndd, nd_label));
-		if (nd_label)
-			rc = -ENXIO;
-	}
-	mutex_unlock(&nd_mapping->lock);
+	if (rc)
+		return rc;
+
+	list_for_each_entry(label_ent, &nd_mapping->labels, list)
+		if (!label_ent->label) {
+			label_ent->label = nd_label;
+			nd_label = NULL;
+			break;
+		}
+	dev_WARN_ONCE(&nspm->nsio.common.dev, nd_label,
+			"failed to track label: %d\n",
+			to_slot(ndd, nd_label));
+	if (nd_label)
+		rc = -ENXIO;
 
 	return rc;
 }
@@ -998,9 +998,8 @@ static int init_labels(struct nd_mapping *nd_mapping, int num_labels)
 		label_ent = kzalloc(sizeof(*label_ent), GFP_KERNEL);
 		if (!label_ent)
 			return -ENOMEM;
-		mutex_lock(&nd_mapping->lock);
+		guard(mutex)(&nd_mapping->lock);
 		list_add_tail(&label_ent->list, &nd_mapping->labels);
-		mutex_unlock(&nd_mapping->lock);
 	}
 
 	if (ndd->ns_current == -1 || ndd->ns_next == -1)
@@ -1039,7 +1038,7 @@ static int del_labels(struct nd_mapping *nd_mapping, uuid_t *uuid)
 	if (!preamble_next(ndd, &nsindex, &free, &nslot))
 		return 0;
 
-	mutex_lock(&nd_mapping->lock);
+	guard(mutex)(&nd_mapping->lock);
 	list_for_each_entry_safe(label_ent, e, &nd_mapping->labels, list) {
 		struct nd_namespace_label *nd_label = label_ent->label;
 
@@ -1061,7 +1060,6 @@ static int del_labels(struct nd_mapping *nd_mapping, uuid_t *uuid)
 		nd_mapping_free_labels(nd_mapping);
 		dev_dbg(ndd->dev, "no more active labels\n");
 	}
-	mutex_unlock(&nd_mapping->lock);
 
 	return nd_label_write_index(ndd, ndd->ns_next,
 			nd_inc_seq(__le32_to_cpu(nsindex->seq)), 0);
-- 
2.34.1


