Return-Path: <linux-kernel+bounces-821889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1B3B828E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144E5462685
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148BD20DD52;
	Thu, 18 Sep 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FXk83H/O"
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B122A7E4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160239; cv=none; b=JBmrn4vp0jBMx/hb3975piGzBEw6vRLWsjDjOGo9ZGl4YlDHwHen+bejE0ELSfIr10QJJQ1KdbW+JCsjruUnw2hqBLJfBCQIT12McPczb0oXIdEwBo8vA0pVCVI+kD6nLYJDn/AAlBqjoL6R1iCLhhjwIUnxyDI+YxizKw91I2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160239; c=relaxed/simple;
	bh=aihcCgDUah0uIajlVxvCd9cKsxGun+acjCd2aDD6Qe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQqBZC8VjH2AnuyTQkCenGQFyNUHISPGS4aGNt0cnktkphgF7msUKRxlYuSqBNrpmSx/rRE1hmvZlKzPpdVENPxn0DJDY5YJx5tv/BJue3JC4m3JrT9MbTPdGtxhZEPIoLFmN1oFJOsfgo2VqPqaOpv+2eekaabYlddawZtmoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FXk83H/O; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-3f43a1b1fbaso74995ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160235; x=1758765035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI3aBy5hd/OB/zGPV0D+8NoJtVOoBqGtJe9tiG8XJ4M=;
        b=FXk83H/O/QDpXl+2GrMRJU/q+l7FYugLhpymSVHFdhG82j65AK709UT+WvRZyCvGPh
         TkpEjzFRr3LkDIHpRtA/pzdp4aUBuQYM2n3wlj1J7RxpSE4fWOLdN9Capo9p9m6H1M7r
         +C3X3AswunZr/T3hvvwRLKJoXX2I4vNy+YeagJH6CpQlFTdOqOuLNUMS/Qkzh7vCniTd
         YbpCJ09L2vP3MxHDVmnvmBWVTOm6YqfowuA1VVs2yu6c87nZjpsr3UswCKwDq+KrEehv
         CW/WFwHY59oJ7vLS2o4mLID6w9FVPMgZ/gjsKdpyUlr0O1kGUItrpu/soS+LIRzjmPfM
         P1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160235; x=1758765035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI3aBy5hd/OB/zGPV0D+8NoJtVOoBqGtJe9tiG8XJ4M=;
        b=ofAfwjhHVpsy2PCq6M7cvglGU4OjwfzDfI8J3CbzmYFAyGO93gF/NV0WjBqY5SweFm
         C98+lNBRpgvOAh2HxSbC0Sqdlm/64ZbbE3dmcf1h8L4SNn9skp4DnP0Z1K0O9dcJcrbO
         eJ3OXL84NiI3mzKixn8U4OGD9zoUh25Xue/UTqDWGfcQR7TJXxVC5c/g12dFEagxh+6Y
         ggxHgWN3/ASUHkzM9tGYnmR/iQxJEAPn4143NYW68tm7bIb5JX8ZOmRQ0oWS1U7W3Vxz
         pOOGa5/MWPGuXKR9yg+R7oZ7MUv0IytJOhArMW4q3fA2dED624o1e9QdolXWaX3FLF16
         KS5g==
X-Forwarded-Encrypted: i=1; AJvYcCWX/CdEq2fOGahWcuG60arcCGvhwwHOl8Nz0AxzAXn0Pwd7PmpFggalCz7Ghv1hwGxt3YUYyfZQpQs32ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLn6SYFfuKF+nICGNi/vgOLLZGGNK4gH99x9QAiR3CzG+coJHS
	TIOIWb7GTreSS5JmblVfdT74KtS1WN0SZcoNft4Qxc7ChEFzUCeLVMV+3kpESid3ThLysR5cAXC
	tDQUZcdRrfBmmq9VQNSi3rygGQ2Hbl9aQKTIxJ/3YBwTTFpBpHbc7
X-Gm-Gg: ASbGncsChcpHvmibJJCc4b0GlPWfg/NHw8ZmDWGmyFiq6WFFfte1USiG8lpQsq1I2JF
	iTwVujt1tNFRostKUADkt2LpLeYgiSbEz9z3acf4tioFi31/cD06F3GTMJUAFXxb/+Bhkp0ygM6
	x5graDnBNRBFQWH936D3r429h3oP0M68SMOvSY2p/9aGilL6MQhtbOFGr5hEX506qp7raX7yejW
	P5RwZTYRRscTxG9yvDaOxQzXxUmzPEpeQGIuRNfzsMRoJ4luFrOw6AMmo9aHO4ce7Q4N7PpUUk0
	CsSUB5vJQlJ7yn1se0Zl4FBZIW9d0TeMKpIhP8Q+qDdoMk2lDRETyLPIkg==
X-Google-Smtp-Source: AGHT+IENRKG99R2VW0x9/thmh8Jnepggaoa54jhETJac3wY0mEKuStB4SCrX1/3ae0dO2b3/sMjdieE7qhXq
X-Received: by 2002:a05:6e02:2781:b0:424:1774:6908 with SMTP id e9e14a558f8ab-4241a3e8592mr22236915ab.0.1758160235222;
        Wed, 17 Sep 2025 18:50:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-53d5106212bsm63180173.28.2025.09.17.18.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 96B9F340325;
	Wed, 17 Sep 2025 19:50:34 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 91B4FE41B42; Wed, 17 Sep 2025 19:50:34 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 02/17] ublk: don't pass q_id to ublk_queue_cmd_buf_size()
Date: Wed, 17 Sep 2025 19:49:38 -0600
Message-ID: <20250918014953.297897-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_queue_cmd_buf_size() only needs the queue depth, which is the same
for all queues. Get the queue depth from the ublk_device instead so the
q_id parameter can be dropped.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9f2db91af481..bac16ec3151c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -760,15 +760,13 @@ ublk_queue_cmd_buf(struct ublk_device *ub, int q_id)
 static inline int __ublk_queue_cmd_buf_size(int depth)
 {
 	return round_up(depth * sizeof(struct ublksrv_io_desc), PAGE_SIZE);
 }
 
-static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
+static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub)
 {
-	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
-
-	return __ublk_queue_cmd_buf_size(ubq->q_depth);
+	return __ublk_queue_cmd_buf_size(ub->dev_info.queue_depth);
 }
 
 static int ublk_max_cmd_buf_size(void)
 {
 	return __ublk_queue_cmd_buf_size(UBLK_MAX_QUEUE_DEPTH);
@@ -1701,11 +1699,11 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 	q_id = (phys_off - UBLKSRV_CMD_BUF_OFFSET) / max_sz;
 	pr_devel("%s: qid %d, pid %d, addr %lx pg_off %lx sz %lu\n",
 			__func__, q_id, current->pid, vma->vm_start,
 			phys_off, (unsigned long)sz);
 
-	if (sz != ublk_queue_cmd_buf_size(ub, q_id))
+	if (sz != ublk_queue_cmd_buf_size(ub))
 		return -EINVAL;
 
 	pfn = virt_to_phys(ublk_queue_cmd_buf(ub, q_id)) >> PAGE_SHIFT;
 	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
 }
@@ -2563,11 +2561,11 @@ static const struct file_operations ublk_ch_fops = {
 	.mmap = ublk_ch_mmap,
 };
 
 static void ublk_deinit_queue(struct ublk_device *ub, int q_id)
 {
-	int size = ublk_queue_cmd_buf_size(ub, q_id);
+	int size = ublk_queue_cmd_buf_size(ub);
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
 	int i;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
@@ -2590,11 +2588,11 @@ static int ublk_init_queue(struct ublk_device *ub, int q_id)
 
 	spin_lock_init(&ubq->cancel_lock);
 	ubq->flags = ub->dev_info.flags;
 	ubq->q_id = q_id;
 	ubq->q_depth = ub->dev_info.queue_depth;
-	size = ublk_queue_cmd_buf_size(ub, q_id);
+	size = ublk_queue_cmd_buf_size(ub);
 
 	ptr = (void *) __get_free_pages(gfp_flags, get_order(size));
 	if (!ptr)
 		return -ENOMEM;
 
-- 
2.45.2


