Return-Path: <linux-kernel+bounces-837409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B88BBAC42A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FE93A6FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D74268688;
	Tue, 30 Sep 2025 09:22:21 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BFD23B62C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759224141; cv=none; b=njEOR/cXUJAA4ONDQ/BP5WCq6paiH8jZW895Mkf9rmj562J9qNPYxZqRsSN3cCqKpbIVlEKLm2lT1W+bzfAIUaHkaNW78/6+Ll3INCsr2cMjJZ0pkreNftWb7SzN4jYGzp+15yiz61rKy6xHH8qLR/1l4XBM7MKDKwVBlpNV0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759224141; c=relaxed/simple;
	bh=6tp7kDX3oRdYgfHPGk5m5fUfVumzL0bcB7ccNNK1IfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jYMB1CM3hWCd2zUlSyi/VZI5wQ/yhuPuJiRhPBZd9GmFPHOCDst+sVMwU8IVBSQLUK0zyPU0bsd0VYr098/vubQY1D5Scz1z/ZZ5D1EyKiQFgs1xbPuPuYYa3sxybKboQv3A1avKdlV5OnUTCDXo/YACukZJiuq3Iy8ASAtpS9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: eafba74e9dde11f08b9f7d2eb6caa7cf-20250930
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:64f52787-5ac7-4f5a-9186-d8c0339fe843,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.1.45,REQID:64f52787-5ac7-4f5a-9186-d8c0339fe843,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:6493067,CLOUDID:cde200468e5833ba8e998c12b7f72ec2,BulkI
	D:2509301722017RW1K8LW,BulkQuantity:0,Recheck:0,SF:19|24|38|44|66|72|78|10
	2|850,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: eafba74e9dde11f08b9f7d2eb6caa7cf-20250930
X-User: husong@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 167271401; Tue, 30 Sep 2025 17:21:59 +0800
From: Hu Song <husong@kylinos.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Song Hu <husong@kylinos.cn>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mm/page_owner: Rename proc-prefixed variables for clarity
Date: Tue, 30 Sep 2025 17:21:51 +0800
Message-Id: <20250930092153.843109-1-husong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Hu <husong@kylinos.cn>

The `proc_page_owner_operations` and related variables were renamed to
`page_owner_fops` to better reflect their association with `debugfs` rather
than `/proc`. This improves code clarity and aligns with kernel naming
conventions.

Signed-off-by: Song Hu <husong@kylinos.cn>
---
 mm/page_owner.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index c3ca21132c2c..bb88b72b6062 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -848,7 +848,7 @@ static void init_early_allocated_pages(void)
 		init_zones_in_node(pgdat);
 }
 
-static const struct file_operations proc_page_owner_operations = {
+static const struct file_operations page_owner_fops = {
 	.read		= read_page_owner,
 	.llseek		= lseek_page_owner,
 };
@@ -929,7 +929,7 @@ static int page_owner_stack_open(struct inode *inode, struct file *file)
 	return seq_open_private(file, &page_owner_stack_op, 0);
 }
 
-static const struct file_operations page_owner_stack_operations = {
+static const struct file_operations page_owner_stack_fops = {
 	.open		= page_owner_stack_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
@@ -948,7 +948,7 @@ static int page_owner_threshold_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(proc_page_owner_threshold, &page_owner_threshold_get,
+DEFINE_SIMPLE_ATTRIBUTE(page_owner_threshold_fops, &page_owner_threshold_get,
 			&page_owner_threshold_set, "%llu");
 
 
@@ -961,13 +961,12 @@ static int __init pageowner_init(void)
 		return 0;
 	}
 
-	debugfs_create_file("page_owner", 0400, NULL, NULL,
-			    &proc_page_owner_operations);
+	debugfs_create_file("page_owner", 0400, NULL, NULL, &page_owner_fops);
 	dir = debugfs_create_dir("page_owner_stacks", NULL);
 	debugfs_create_file("show_stacks", 0400, dir, NULL,
-			    &page_owner_stack_operations);
+			     &page_owner_stack_fops);
 	debugfs_create_file("count_threshold", 0600, dir, NULL,
-			    &proc_page_owner_threshold);
+			    &page_owner_threshold_fops);
 
 	return 0;
 }
-- 
2.25.1


