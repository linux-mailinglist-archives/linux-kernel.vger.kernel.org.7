Return-Path: <linux-kernel+bounces-859261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91483BED28A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 817F04E8411
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A852236F0;
	Sat, 18 Oct 2025 15:23:30 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184FE221DB1
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760801009; cv=none; b=eLWy7mtatq5GZdT/d06MMVLss9pccxpCbGtf6z4SfHEnlsPteKjRsasjOjT0lk9bRlvX7QWxsWmnwDtEWzMSwK7QFjsF90H4DTjpioPR822WjxtjgTJlmzzFSdSckFK0QsxT/BwBX8X0tkQ4CyQlILaZlQZeMTUN/c04L5ue8eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760801009; c=relaxed/simple;
	bh=qmzfsmqRRfV1AgSEIfIAc2Amfkf1IbHGW6j/smMTuqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3jgX/F9Og4980VZ092n/geHkmXJc+WSbx/X0aLWuD/e6L3ZwDMFXgLf9y0m6axG3piTEvkOLo+JPuXKLgHt4NMXqlVSsBGqJZJzremj3cgYCT9KC/D6ZIH1x/AQAGc0ItLC6NIxiRXxysBU6p4v7C3R9PuqRiDLNmePIr3vuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5af3a1b8ac3611f0a38c85956e01ac42-20251018
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_LOWREP, SRC_LOWREP, DN_TRUSTED
	SRC_TRUSTED, SA_UNTRUSTED, SA_LOWREP, SA_EXISTED, SN_UNTRUSTED
	SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:9657a6c6-2841-4262-824e-3fefe3e87ff4,IP:10,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:40
X-CID-INFO: VERSION:1.3.6,REQID:9657a6c6-2841-4262-824e-3fefe3e87ff4,IP:10,URL
	:0,TC:0,Content:0,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:40
X-CID-META: VersionHash:a9d874c,CLOUDID:cb43a231f1e62819d6fbbce3c9e6b51f,BulkI
	D:2510182147173C9T6SOE,BulkQuantity:3,Recheck:0,SF:19|25|45|66|72|78|102|8
	50,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5af3a1b8ac3611f0a38c85956e01ac42-20251018
X-User: hehuiwen@kylinos.cn
Received: from localhost.localdomain [(220.202.195.150)] by mailgw.kylinos.cn
	(envelope-from <hehuiwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 555464057; Sat, 18 Oct 2025 23:23:10 +0800
From: Huiwen He <hehuiwen@kylinos.cn>
To: Liam.Howlett@oracle.com
Cc: aliceryhl@google.com,
	andrewjballance@gmail.com,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huiwen He <hehuiwen@kylinos.cn>
Subject: [PATCH] maple_tree: Fix potential NULL pointer dereference if mas_pop_node() fails
Date: Sat, 18 Oct 2025 23:23:05 +0800
Message-ID: <20251018152305.1612722-1-hehuiwen@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mas_pop_node() may return NULL when memory allocation fails or when
mas->sheaf is invalid. Several callers of mas_pop_node() did not check
the return value and directly dereferenced the pointer, which could
lead to a NULL pointer dereference and kernel crash.

Fixes: 54a611b60590 ("maple_tree: add mas_pop_node() helper")
Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
---
 lib/maple_tree.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 39bb779cb311..524e1cfb4439 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3085,6 +3085,9 @@ static inline void mas_root_expand(struct ma_state *mas, void *entry)
 	int slot = 0;
 
 	node = mas_pop_node(mas);
+	if (unlikely(!node))
+		return;
+
 	pivots = ma_pivots(node, type);
 	slots = ma_slots(node, type);
 	node->parent = ma_parent_ptr(mas_tree_parent(mas));
@@ -3367,6 +3370,9 @@ static inline void mas_new_root(struct ma_state *mas, void *entry)
 	}
 
 	node = mas_pop_node(mas);
+	if (unlikely(!node))
+		return;
+
 	pivots = ma_pivots(node, type);
 	slots = ma_slots(node, type);
 	node->parent = ma_parent_ptr(mas_tree_parent(mas));
@@ -3506,6 +3512,9 @@ static inline void mas_wr_node_store(struct ma_wr_state *wr_mas,
 		newnode = &reuse;
 	}
 
+	if (unlikely(!newnode))
+		return;
+
 	newnode->parent = mas_mn(mas)->parent;
 	dst_pivots = ma_pivots(newnode, wr_mas->type);
 	dst_slots = ma_slots(newnode, wr_mas->type);
-- 
2.43.0


