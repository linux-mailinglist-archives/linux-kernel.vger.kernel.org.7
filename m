Return-Path: <linux-kernel+bounces-864419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 050CABFAC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90017462C50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9BF2FFFA4;
	Wed, 22 Oct 2025 08:02:25 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AAE2FFF89
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120143; cv=none; b=Y2PI8Ez7Tyw0gI4/r721WpRwldR1D97daGrvuGTzAgg41Fa0ZDoJfqxYh4WOPFlFRdEjJ0TSufsTu9xiMn5wo8itDyDzbuxLSDGwI2nlHWb5MIY17v1VlBtutLmFe1qNHFcGbiUideG5Mu7HMLiBfbbVIDldwxF1x0Ptm6UrfVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120143; c=relaxed/simple;
	bh=oPRtz8peei2pS01Up7aXgOuY/3XlaVLmELAjGXTufVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uRkqeRIGCl9kHnCAe8UMr0rI+fFGsVtbofiPZGfeu19A3e93eeWQZIIuS0w4LIpjGbJZJuph4Q5u/+DFPDstl4ugdybbj+RDHr3GwAoP2D7qhrIPTfQ0xE9d5Trz7egjgzTEV3sxGnZSI3ZsbGozc5IRtEObFjIu25N5usRRdIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6629df54af1d11f0a38c85956e01ac42-20251022
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b97e0a3b-8bae-46db-b23f-3929984af970,IP:0,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:3ad24c58edeb1b9ffe37f19047c79524,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:2,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6629df54af1d11f0a38c85956e01ac42-20251022
X-User: tanze@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1312065914; Wed, 22 Oct 2025 16:02:05 +0800
From: tanze <tanze@kylinos.cn>
To: richard@nod.at,
	hengzhihao1@huawei.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tanze <tanze@kylinos.cn>
Subject: [PATCH] ubifs: using vmalloc_array() to handle the code
Date: Wed, 22 Oct 2025 16:02:00 +0800
Message-Id: <20251022080200.526003-1-tanze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change array_size() to vmalloc_array(), Due to vmalloc_array()
is optimized better,uses fewer instructions, and handles
overflow more concisely

Signed-off-by: tanze <tanze@kylinos.cn>
---
 fs/ubifs/lpt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
index 441d0beca4cf..dde0aa3287f4 100644
--- a/fs/ubifs/lpt.c
+++ b/fs/ubifs/lpt.c
@@ -628,8 +628,8 @@ int ubifs_create_dflt_lpt(struct ubifs_info *c, int *main_lebs, int lpt_first,
 	pnode = kzalloc(sizeof(struct ubifs_pnode), GFP_KERNEL);
 	nnode = kzalloc(sizeof(struct ubifs_nnode), GFP_KERNEL);
 	buf = vmalloc(c->leb_size);
-	ltab = vmalloc(array_size(sizeof(struct ubifs_lpt_lprops),
-				  c->lpt_lebs));
+	ltab = vmalloc_array(c->lpt_lebs,
+			     sizeof(struct ubifs_lpt_lprops));
 	if (!pnode || !nnode || !buf || !ltab || !lsave) {
 		err = -ENOMEM;
 		goto out;
@@ -1777,8 +1777,8 @@ static int lpt_init_rd(struct ubifs_info *c)
 {
 	int err, i;
 
-	c->ltab = vmalloc(array_size(sizeof(struct ubifs_lpt_lprops),
-				     c->lpt_lebs));
+	c->ltab = vmalloc_array(c->lpt_lebs,
+				sizeof(struct ubifs_lpt_lprops));
 	if (!c->ltab)
 		return -ENOMEM;
 
@@ -1846,8 +1846,8 @@ static int lpt_init_wr(struct ubifs_info *c)
 {
 	int err, i;
 
-	c->ltab_cmt = vmalloc(array_size(sizeof(struct ubifs_lpt_lprops),
-					 c->lpt_lebs));
+	c->ltab_cmt = vmalloc_array(c->lpt_lebs,
+				    sizeof(struct ubifs_lpt_lprops));
 	if (!c->ltab_cmt)
 		return -ENOMEM;
 
-- 
2.25.1


