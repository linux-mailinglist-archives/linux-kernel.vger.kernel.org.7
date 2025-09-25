Return-Path: <linux-kernel+bounces-832010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D720B9E231
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56BFD7A489E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA412798ED;
	Thu, 25 Sep 2025 08:53:05 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD025DD0B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790385; cv=none; b=b7AklRtSw1L7D8zeB8AxBQ5vsTuggV7dL+eEAwXG8LwB8kzKmBU9AHITnt+p/+sTLnb5HfLdDa3J+kEoc51lREHkd785VVMAZ7bQECvvBEnvJvVpazj0AnzRZzJqRIgvttmoAIcUpGRu+UQ9MtwLy1kGYMXFKUlGVZmWLxxylC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790385; c=relaxed/simple;
	bh=hYUQm9jphUs9dGCv7A1Zt2WAkULwRarDCblLsjDnM6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MeAV4ZZ+tWxAs9EK881rKniEDnrjcb+d+WVAc3x9FM4ISOJ+VuAe2DQfy5WzvSufxchMY2izM+DUVd36Agnxiz92/JdvPuZfnZDxnHWDooeOXtydO5oS/8mPeH9WD8QE2r5bTJxMxUz+UrfOSVQOyYXIWSP9VdKncn/5Xx/WbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 056c450299ed11f08b9f7d2eb6caa7cf-20250925
X-CID-CACHE: Type:Local,Time:202509251641+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:306fcadc-ced6-41b6-ac94-db94470a8242,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:f388fb7637e4f8dbef5fcb8e91a0dcd6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850,TC:nil,Content:0|50,EDM:5,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 056c450299ed11f08b9f7d2eb6caa7cf-20250925
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1621907147; Thu, 25 Sep 2025 16:52:52 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: syzbot+dd514b5f0cf048aec256@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] KMSAN: uninit-value in n_tty_receive_buf_closing
Date: Thu, 25 Sep 2025 16:52:46 +0800
Message-Id: <905bb5a8bc3e969ef332dd604864ba67b93e1a85.1758789532.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <676ef586.050a0220.2f3838.0488.GAE@google.com>
References: <676ef586.050a0220.2f3838.0488.GAE@google.com>
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


