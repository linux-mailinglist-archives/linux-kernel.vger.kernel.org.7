Return-Path: <linux-kernel+bounces-831995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481E4B9E1D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071F717889D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE142777F9;
	Thu, 25 Sep 2025 08:47:32 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BAD271A9D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790052; cv=none; b=sPoRw+KqaGzon1YcKHAqkBB1sQRGg1LqSVrrJXaxeZj1Dyh56dRMKED5+MtDbKeF8KqSFqHKdwpQ1/ybPJCmQ7sTg4BJZ2OdoOmEYs9qnEmtzb+0JV3XGB5wG8loHWmjiMD5ryC7+DeTnbbHKTuVz3bRc57b9FpJzqoVcdnZpFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790052; c=relaxed/simple;
	bh=hYUQm9jphUs9dGCv7A1Zt2WAkULwRarDCblLsjDnM6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sletGf9a7xfMhcB13uwPVpqONWk9EtbaZvF7ANPFYEl4XRdBVH5PLzhQrMHnziIBZh18p5ZqxoPZKz3SILf98ZhpNxGJBeRkw1lnxcRXGqzDw6OwfFoVJfnOufC/F7P57XoZC4N2VXkrluO5P8zkHs++isIxet0yZOsV9/dErg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 402aff1899ec11f08b9f7d2eb6caa7cf-20250925
X-CID-CACHE: Type:Local,Time:202509251641+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ce525a75-5f98-4c7c-a297-6c6838192066,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:f388fb7637e4f8dbef5fcb8e91a0dcd6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|50,EDM:5,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 402aff1899ec11f08b9f7d2eb6caa7cf-20250925
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1352101100; Thu, 25 Sep 2025 16:47:21 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: syzbot+dd514b5f0cf048aec256@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] KMSAN: uninit-value in n_tty_receive_buf_closing
Date: Thu, 25 Sep 2025 16:47:18 +0800
Message-Id: <905bb5a8bc3e969ef332dd604864ba67b93e1a85.1758789532.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0000000000000a1b9a0620097bad@google.com>
References: <0000000000000a1b9a0620097bad@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test
---
 drivers/tty/tty_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 67271fc0b223..62d32556a24b 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -108,6 +108,7 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
 	p->lookahead = 0;
 	p->read = 0;
 	p->flags = true;
+	memset(p->data, 0, size);
 }
 
 /**
@@ -177,7 +178,7 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 	 */
 	if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
 		return NULL;
-	p = kmalloc(struct_size(p, data, 2 * size), GFP_ATOMIC | __GFP_NOWARN);
+	p = kzalloc(struct_size(p, data, 2 * size), GFP_ATOMIC | __GFP_NOWARN);
 	if (p == NULL)
 		return NULL;
 
-- 
2.25.1


