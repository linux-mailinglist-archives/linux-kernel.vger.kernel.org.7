Return-Path: <linux-kernel+bounces-831991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937FCB9E192
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0428E4A50F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C2D274FF5;
	Thu, 25 Sep 2025 08:41:30 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A9721ADA7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789689; cv=none; b=ZT2af3AdA1ilFUuzx/mi7zFUlF6demU2rIUHEUbrMVDkv92G7WtW2L4ec+/H/3dIdVf9zwc0mR8fYaKtO+pVK04/YpeM3kJpm2zJcn+8eJclDfyCh3dsvxZW+aG3zBMsn7rn4fEXIRSICiPNa6JBZ0L6MuxNldX6qIgRsaXyVMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789689; c=relaxed/simple;
	bh=hYUQm9jphUs9dGCv7A1Zt2WAkULwRarDCblLsjDnM6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dcB2zxSa+KjmqKEH1MlXs7SHEWIz7MOE1+sghYStztDWg4/h7zFqE0SfWtUGlUaVxPNM4ojKu6z1stZAT1DZ9LtzA2/ZVdu+lYO9ZTD6u8v4JRIoIn/KQwxqn8qMUW62MDKd/ehEUJKXnOSUEYBtMbwPIkw2fYV+T+PwF4/m5x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 64d9500499eb11f08b9f7d2eb6caa7cf-20250925
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3e91bacf-4d2c-4ab8-8956-ed17e1a27003,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:f388fb7637e4f8dbef5fcb8e91a0dcd6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|50,EDM:5,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 64d9500499eb11f08b9f7d2eb6caa7cf-20250925
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1820374656; Thu, 25 Sep 2025 16:41:13 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: syzbot+62edf7e27b2e8f754525@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] KMSAN: uninit-value in n_tty_receive_buf_closing
Date: Thu, 25 Sep 2025 16:41:09 +0800
Message-Id: <905bb5a8bc3e969ef332dd604864ba67b93e1a85.1758789532.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <68d4e8ea.050a0220.25d7ab.0002.GAE@google.com>
References: <68d4e8ea.050a0220.25d7ab.0002.GAE@google.com>
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


