Return-Path: <linux-kernel+bounces-895688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD20C4EA94
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE86018C52B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2BA325716;
	Tue, 11 Nov 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="W42LWJsr"
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9932ED31;
	Tue, 11 Nov 2025 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873041; cv=none; b=ZLHvyPUFE3tLDI3ZZKJq9LCU/QTYpVQwYb0bMPqgOltACq5EYxEyxamkvnwHc8XmzAhZbxJZaoNn/RoZO6bW4RKpX0W7jphpX7xNxV35I95CIQLKLlqASbGBMlD3DleazQTSD03eeorOAOrYd1g5bHRlvRuntajyUPrVAzrkPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873041; c=relaxed/simple;
	bh=m9Pt7AYBw/k2ni3ymSY6cQkrAWfSQOt5DNA7GKNDgjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gqDgMYPEp0r/6T3l23KBkjk7/ff5OKWhgdVmfhf7poRkNACFPjWH7XtNbui4UPCQLh+KLpf8lkFk3pJBMY8N8/0G1xo/PJAmCHfZXwfhs91mGrAXvV538F29J99PTbxAaeWB1/WWV+AVy/Q9wpFDOKQRkXqWRrv35iolMUZTv2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=W42LWJsr; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2935abaa0;
	Tue, 11 Nov 2025 22:57:11 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: nas.chung@chipsnmedia.com
Cc: jackson.lee@chipsnmedia.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] media: chips-media: wave5: Fix memory leak on codec_info allocation failure
Date: Tue, 11 Nov 2025 14:57:06 +0000
Message-Id: <20251111145706.570747-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a736bb93b03a1kunm9cd43959b1baf4
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaT04aVh0fGRlMTEwYGUlCSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJQkNDTFVKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=W42LWJsraPpnpvRL/tF96pgKWjdr+eQ6xfAb5rPbroaODuIpzALdwgNNqqOhGf3qRfhXyDunoITOML5uTXoHvL3xQsDfa6tAKBdKugyEiyAZt2fD8HuPrOK+iTe5GtmxKd9qOqHeespBlV88DhscRiYTRPiYJUr6W+4dwtauPV4=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=8SlG+18gyL+Q+Qi6B9kU+mJLxZi9v9c+o8my7YJfdNs=;
	h=date:mime-version:subject:message-id:from;

In wave5_vpu_open_enc() and wave5_vpu_open_dec(), a vpu instance is
allocated via kzalloc(). If the subsequent allocation for inst->codec_info
fails, the functions return -ENOMEM without freeing the previously
allocated instance, causing a memory leak.

Fix this by calling kfree() on the instance in this error path to ensure
it is properly released.

Fixes: 9707a6254a8a6 ("media: chips-media: wave5: Add the v4l2 layer")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 4 +++-
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index e3038c18ca36..a4387ed58cac 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1753,8 +1753,10 @@ static int wave5_vpu_open_dec(struct file *filp)
 	spin_lock_init(&inst->state_spinlock);
 
 	inst->codec_info = kzalloc(sizeof(*inst->codec_info), GFP_KERNEL);
-	if (!inst->codec_info)
+	if (!inst->codec_info) {
+		kfree(inst);
 		return -ENOMEM;
+	}
 
 	v4l2_fh_init(&inst->v4l2_fh, vdev);
 	v4l2_fh_add(&inst->v4l2_fh, filp);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 9bfaa9fb3ceb..94fb5d7c8702 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -1578,8 +1578,10 @@ static int wave5_vpu_open_enc(struct file *filp)
 	inst->ops = &wave5_vpu_enc_inst_ops;
 
 	inst->codec_info = kzalloc(sizeof(*inst->codec_info), GFP_KERNEL);
-	if (!inst->codec_info)
+	if (!inst->codec_info) {
+		kfree(inst);
 		return -ENOMEM;
+	}
 
 	v4l2_fh_init(&inst->v4l2_fh, vdev);
 	v4l2_fh_add(&inst->v4l2_fh, filp);
-- 
2.34.1


