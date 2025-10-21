Return-Path: <linux-kernel+bounces-862439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D500CBF54C9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726884600A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EBD31E10D;
	Tue, 21 Oct 2025 08:35:28 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516C230217D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035728; cv=none; b=HtxwkMPTBHtqNnD9fQKY8+Zlw4Ga3OBwqkJorbmHoS/y4FMHVT7T2kRLQbMrWlQh6siCurcl0S8ibL/daFUpfs6h3vlv83aWWTsQIK9bmHrz5WP0iC87x8bLHAicBumgNpYI2QZmd6BjFOVPXhyy6QVBMTY6R4zrc5OWTMdhijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035728; c=relaxed/simple;
	bh=HLINWFpfI7LpIEpgOwz4kJy1SwKhM/fLjwdO3SOoBuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zms/6z4iidX2l4Ez7kBJjV/4szf3GV4Z9yjQdupE654iu5ECW8J4zkFhk4cKwt0pgT1coEAmVy4CoPtuRKQqHjc1QLj36n9dSpMZWvK0W/pKAaFYhyPASARxTZ9jhEFSp9S0rvHno3z5ZE8W9KHofZCQnxEaRiSpEg3kUGhw1d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: de4d9faeae5811f0a38c85956e01ac42-20251021
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:55a1b00c-6e44-48ed-a0b3-2b9901d408c0,IP:0,UR
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
X-UUID: de4d9faeae5811f0a38c85956e01ac42-20251021
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1795378596; Tue, 21 Oct 2025 16:35:15 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: syzbot+01fcd39a0d90cdb0e3df@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] syz test
Date: Tue, 21 Oct 2025 16:35:06 +0800
Message-Id: <6c4d42542afeed40435ba0abb94e753e1d259ce1.1761035574.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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


