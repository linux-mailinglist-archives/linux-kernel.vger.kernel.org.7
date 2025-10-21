Return-Path: <linux-kernel+bounces-862456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D05BF558F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E086189F541
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB8C328B5D;
	Tue, 21 Oct 2025 08:46:38 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD39328B51
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036398; cv=none; b=aSnaULYT7VPvcpsYlSPeSKk4ChIXD/rIg0HJGgEPXxKF/wLEXGtBsg7U4ekNVUC32ANC26xqK/BY1NHeRMgIS+N1VtzOI/vGUdvJocWCGN+44PzSuvbQfdLEMrQwo4YfzGGzpTx8ENBm1qin4QiB3LWR9xJeztLIlb6wnKv1DKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036398; c=relaxed/simple;
	bh=HLINWFpfI7LpIEpgOwz4kJy1SwKhM/fLjwdO3SOoBuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dx6BYMsOZCRvQ5N9R/a2/NQHW9AKj2EcCKn3OvG11L07oz7NnyqavW5SOP/HWC9tjrGSE8MfC6medh+fTpAN/sWWF50NAbCyhTlwI0PfyGBZkbV9O6ygvairwitbJzXpopurGKMIdvisraqoL84WCraAWpI0VFjD6ckP9jHou+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6fdeeb3eae5a11f0a38c85956e01ac42-20251021
X-CID-CACHE: Type:Local,Time:202510211635+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:6438a60c-c686-4dd6-9bbf-9b94da5cb44c,IP:0,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:05906bd3a5cf6e35e9b4fb187992aed3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6fdeeb3eae5a11f0a38c85956e01ac42-20251021
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1194117920; Tue, 21 Oct 2025 16:46:29 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: syzbot+01fcd39a0d90cdb0e3df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] syz test
Date: Tue, 21 Oct 2025 16:46:24 +0800
Message-Id: <6c4d42542afeed40435ba0abb94e753e1d259ce1.1761035574.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <68f6a48f.050a0220.91a22.0452.GAE@google.com>
References: <68f6a48f.050a0220.91a22.0452.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test
---
 lib/crypto/poly1305.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/crypto/poly1305.c b/lib/crypto/poly1305.c
index f313ccc4b4dd..25018e3fb487 100644
--- a/lib/crypto/poly1305.c
+++ b/lib/crypto/poly1305.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/unaligned.h>
+#include <linux/kmsan.h>
 
 #ifdef CONFIG_CRYPTO_LIB_POLY1305_ARCH
 #include "poly1305.h" /* $(SRCARCH)/poly1305.h */
@@ -31,6 +32,7 @@ void poly1305_init(struct poly1305_desc_ctx *desc,
 	desc->s[3] = get_unaligned_le32(key + 28);
 	desc->buflen = 0;
 	poly1305_block_init(&desc->state, key);
+	kmsan_unpoison_memory(desc, sizeof(struct poly1305_desc_ctx));
 }
 EXPORT_SYMBOL(poly1305_init);
 
-- 
2.25.1


