Return-Path: <linux-kernel+bounces-885711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DC2C33BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8C294E2E80
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5CE20A5C4;
	Wed,  5 Nov 2025 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="DHFCDRTM"
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550181F5E6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 02:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309037; cv=none; b=BQdmmAKBf2XjdQ9SWdPamOl19RH63zMhAPp4qwtB1YmdI1VkE4H0/C8vmshijdDoEcsfX9btuiiohCjVpbWq3DIqBWxJGePFRnBENVhifhF6aH4oLdZzjlDC/wnuCMOYe1Kae5DULjyHAzTsLt+VgzTFWNL73ofMhO4GPqMUnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309037; c=relaxed/simple;
	bh=kCseptUFxbSlZvZ2Phsw4zdoMYwzMWDL7ZgnSRxT9qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=thGsjzr6qbUwJPHNsrQ20ubCgVf6cuIjNzlmjxnUWjAT/0j3weX0IuwvgNGACjEtgIPfWz3CyAsleJ8v702NjP+PXTH5a3aoDEIizxF1ZYn9GtAhWiBRt3+6LZiMaSKolt49sw1n35pUm3sPp48O9YoQB8Z4JpltgF5GSq6bJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=DHFCDRTM; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2869c94a4;
	Wed, 5 Nov 2025 10:17:01 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: dhowells@redhat.com
Cc: marc.dionne@auristor.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] afs: use kvfree() to free memory allocated by kvcalloc()
Date: Wed,  5 Nov 2025 02:16:58 +0000
Message-Id: <20251105021658.1803652-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a51cd9f7c03a1kunm21076fca6d09ce
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQkMaVk1LSx4fHUJNSx1NSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=DHFCDRTMwfwpUPoN5N4Ri0cN4YlNHNgHdm0YCrQHS4M6ZTFeXz9T2wz5SCQSlvXjXoUhNNHWyk6aAExUiKt89O6mXIVO+6Qi/C8zVgMaU9L35IEUpvNUrRmgUrOjJD1NvYlYpwshTdjtDM0AhafcjdVUZHD2nJl+hMpegLhtZJc=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=SJJUc1UhBKizBdL83Bkhd6oYJLODgtHHo+SozLlqtcc=;
	h=date:mime-version:subject:message-id:from;

op->more_files is allocated with kvcalloc() but released via
afs_put_operation(), which uses kfree() internally. This mismach prevents
the resource from being released properly and may lead to undefined
behavior.

Fix this by using kvfree() to free op->more_files to match its allocation
method.

Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/afs/fs_operation.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index 8418813ee043..ae0c9750c6b6 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -348,7 +348,7 @@ int afs_put_operation(struct afs_operation *op)
 		for (i = 0; i < op->nr_files - 2; i++)
 			if (op->more_files[i].put_vnode)
 				iput(&op->more_files[i].vnode->netfs.inode);
-		kfree(op->more_files);
+		kvfree(op->more_files);
 	}
 
 	if (op->estate) {
-- 
2.34.1


