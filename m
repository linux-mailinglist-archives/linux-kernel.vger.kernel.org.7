Return-Path: <linux-kernel+bounces-857543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F64BE7119
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09213ACA03
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41CD26D4C2;
	Fri, 17 Oct 2025 08:14:06 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E9C334693
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688846; cv=none; b=D1jAV0e8yC9o9K/VbE9blLD1pdHIVIoBFYlHYOnExm2kHE7wpynUjCTVEQe57160Adt5bo6mnwK/AN8uBNqZaKcVhP9TdptJjoZhJbIq15LsJ2BLm9nBQO1GNddIeimWpn9mAqui+boivvUfI1rwbgaapDGlL6GXpjnOtiuwhko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688846; c=relaxed/simple;
	bh=x+KsmDkThTG2V7geklGyoU6ybQOjwVPAriMvuDbcayU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eYJ4QWhvyRCDpX0wFOEgjV2pqLdHWQNpk4JtrzzntguhlFa5a+8bHGArrC59ivO5ZF3SyqnclTtG5sU5vMKI5yE2PRA1MX72NelKxMCpZ1j90M0nXisSntXK1y7Jt8gEmUT7NarV8gabDxeaxpW2JgVWcXIhQNuGVq7pLyRf/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3b76fe44ab3111f0a38c85956e01ac42-20251017
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:af7cda80-b4c6-46ce-bbe4-d4c8ec9ffdd7,IP:0,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:2e1847c0b96745a96810794bc074a1b7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|50,EDM:5,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3b76fe44ab3111f0a38c85956e01ac42-20251017
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1929928010; Fri, 17 Oct 2025 16:13:58 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: syzbot+4b717071f1eecb2972df@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] jfs: test syz test
Date: Fri, 17 Oct 2025 16:13:55 +0800
Message-Id: <d5067a639f2341e6cce0a48f810c22d2e36c33a8.1760688719.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <68f1c794.a00a0220.361615.000f.GAE@google.com>
References: <68f1c794.a00a0220.361615.000f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cdfa699cd7c8..9d26c5dc4efd 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1435,6 +1435,11 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
 			blkno &= ~(MAXL1SIZE - 1);
 		else		/* bmp->db_aglevel == 0 */
 			blkno &= ~(MAXL0SIZE - 1);
+		
+		if (unlikely(budmin < 0)) {
+   			WARN_ON_ONCE(1);
+    			budmin = 0;
+		}		
 
 		blkno +=
 		    ((s64) (ti - le32_to_cpu(dcp->leafidx))) << budmin;
-- 
2.25.1


