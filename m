Return-Path: <linux-kernel+bounces-606259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A06FA8AD2E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 03:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF2444288D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 01:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6982063E2;
	Wed, 16 Apr 2025 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fNBTnJnW"
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009F204C1A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765214; cv=none; b=pZjhhokLlmDNgk0xzxSMGD5sbLoOUAcjVK5zfH/GTK5LiEwagZzbS9cxA/pEcyvBSEa+O0vvOl68IEJNQ6FvLmFfGZ61aswa1kMp/hWRdNGGbJa6876p8B12J82zeWs+KhCxEeKvR4eSMRhIRrW4e0vRYFfZ7U4PMUqBmoAUze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765214; c=relaxed/simple;
	bh=ht1z5tMmO+4FBWu5eprttGdN/Q0lnY9pm88IS3LYzgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QwKUPdPripwIlHm5qPSntGoHivjbegeQAJGXbHH33Zdc+aMuPuxjaNnu5vXdUBy1CMGUSIpnZX7rp3Bngpcb3Yb4ILwvsgXhflFDlqXOUuflSJOWifp6X3lA+MNXD5E72KHJAxruxY5bbpNNBdrD7Es3wme4xFHmMUsubz/5eGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fNBTnJnW; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-2d09d495c6cso1756081fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744765209; x=1745370009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BeIb+nOqtxi+iaoqYFgPTqpRXHwAg24kReKqzI+s5Wc=;
        b=fNBTnJnWnvdsmDR0kdN7rjmZJ/KJcM3LeTEezJ+Z7tj8oFLWxhRiWuf5eSOQt9QcU2
         rH6BCrg75G+UAhajiZpGJMyPuGPVx0AKocIbrl42KzHBXdJYozhFHrotnhLUZvwC5oa9
         dM7o6KOGSwqbRN/kFa4h6u83DJqHR3Fu0oW9rzqO13AErLeLDh/l+N8Z9n9DRMlA1oKU
         NvmCWClEEj6QfkLE95Muhluu9Z6spTnyfHIQ93eHH2PBWBbgoGdYUEnpBT5l1cLYgblf
         l13qgwFskljAMYaHFzdVbJriCrEQ5Yw8Hf1z/HpiT7Zfkog1EZpFNp4WCGzsgGctYmQL
         qTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744765209; x=1745370009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeIb+nOqtxi+iaoqYFgPTqpRXHwAg24kReKqzI+s5Wc=;
        b=DK+Qrr2Cav/Eb/fKFvxAKwHoi1nI7E/qPR/TgLqXfscSbWORT9cPGoGcxeNvKYT9MG
         Ap53ai4nu2e4KR7JcFvBQF4Q4KQ+j1OZeTDn5AechNl7tBU4FEjzwc1J0ds3E7MjUY33
         YdEeLqTNBdSEV6zMFnxXqFIpyIKComq3I02DYDWP7tIvh9mJ/KGRS6lZtSyYX1l5Fe7O
         yVnU9nMqts1ZxEgm8hOMStTGNlsSmLzrGRoIBZRLddSUwAUdSZJpS35t+fxAe1SpFdjD
         Ps95ojP6zq6cvOA9EVvXRAq+8IWOH4NaY9A6m1+B3qjSj7wvKP9zvmTWJazdJLUy9qUe
         dWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr4S7hVz/GgTXLx6N3rt6mXgouGcr9QcYg4gplSs8MxIvBvdosfcwYtSV2SNJ92f5QfNBiorkursXmPC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybWcwObsbgUJjGAsSzS3l+VeqFwFREROtRTCHre3WfxAvr2seJ
	SplOy8CUo24ILPYv/FWCXRQfonRB6tYe42RR3Xnb4o7A1Umg7o9QFmqg2UsQ3o8k9oJxXl+hvDM
	y6BhlpgFRsnLYFPHgHrOuDW0kmQqag8l36ruVdyDVqQDVOo27
X-Gm-Gg: ASbGncvYFcJuye90MROnWnm1RRVuRnMPvf6mEcgaQ+uFZYjswLmyvC/ihxAz49pO2In
	wuPeP7FWdNAj6zSc0OXIf4zjjo7h7Oe18GE3XS+4XFoFm18iuCXydpbYyTmrJGrLk1beu0wggRJ
	JtDx+XgKYNzMpCq2Ob59juHVZQJ4vxuZyb0FBvm/gBGnzgac1xmPwjAYmnqA1CTBogokDPESwkB
	WxcgPuaT5Jy9HoSKeY1Hmhzp6Ltnwu00jmvpSrXC2LmcMf9CYSRoVi2l74MLV28L41+kATEk+KV
	CWwAS4KR15dLk7sQll4S9NBMacW6/sY=
X-Google-Smtp-Source: AGHT+IF1lVFyFNvpYCSWetCStup9q/NCRo+l8krjI7JKuqiVsfplbUneTzIj60Z0qcSmQQT/A8J2k4XxTof6
X-Received: by 2002:a05:6870:f10f:b0:2b8:2f9c:d513 with SMTP id 586e51a60fabf-2d4c3afcb4bmr842541fac.19.1744765209591;
        Tue, 15 Apr 2025 18:00:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2d096d49cddsm732785fac.38.2025.04.15.18.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 18:00:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 099AF3402DD;
	Tue, 15 Apr 2025 19:00:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 026B0E40ECA; Tue, 15 Apr 2025 19:00:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 15 Apr 2025 18:59:38 -0600
Subject: [PATCH v4 2/4] ublk: mark ublk_queue as const for
 ublk_commit_and_fetch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-ublk_task_per_io-v4-2-54210b91a46f@purestorage.com>
References: <20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com>
In-Reply-To: <20250415-ublk_task_per_io-v4-0-54210b91a46f@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

We now allow multiple tasks to operate on I/Os belonging to the same
queue concurrently. This means that any writes to ublk_queue in the I/O
path are potential sources of data races. Try to prevent these by
marking ublk_queue pointers as const when handling COMMIT_AND_FETCH.
Move the logic for this command into its own function
ublk_commit_and_fetch. Also open code ublk_commit_completion in
ublk_commit_and_fetch to reduce the number of parameters/avoid a
redundant lookup.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 91 +++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 48 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9a0d2547512fc8119460739230599d48d2c2a306..153f67d92248ad45bddd2437b1306bb23df7d1ae 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1518,30 +1518,6 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
 	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
 }
 
-static void ublk_commit_completion(struct ublk_device *ub,
-		const struct ublksrv_io_cmd *ub_cmd)
-{
-	u32 qid = ub_cmd->q_id, tag = ub_cmd->tag;
-	struct ublk_queue *ubq = ublk_get_queue(ub, qid);
-	struct ublk_io *io = &ubq->ios[tag];
-	struct request *req;
-
-	/* now this cmd slot is owned by nbd driver */
-	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
-	io->res = ub_cmd->result;
-
-	/* find the io request and complete */
-	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
-	if (WARN_ON_ONCE(unlikely(!req)))
-		return;
-
-	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = ub_cmd->zone_append_lba;
-
-	if (likely(!blk_should_fake_timeout(req->q)))
-		ublk_put_req_ref(ubq, req);
-}
-
 /*
  * Called from io task context via cancel fn, meantime quiesce ublk
  * blk-mq queue, so we are called exclusively with blk-mq and io task
@@ -1918,6 +1894,45 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
+static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
+				 struct ublk_io *io, struct io_uring_cmd *cmd,
+				 const struct ublksrv_io_cmd *ub_cmd,
+				 struct request *req)
+{
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		return -EINVAL;
+
+	if (ublk_need_map_io(ubq)) {
+		/*
+		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
+		 * NEED GET DATA is not enabled or it is Read IO.
+		 */
+		if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
+					req_op(req) == REQ_OP_READ))
+			return -EINVAL;
+	} else if (req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
+		/*
+		 * User copy requires addr to be unset when command is
+		 * not zone append
+		 */
+		return -EINVAL;
+	}
+
+	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
+
+	/* now this cmd slot is owned by ublk driver */
+	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
+	io->res = ub_cmd->result;
+
+	if (req_op(req) == REQ_OP_ZONE_APPEND)
+		req->__sector = ub_cmd->zone_append_lba;
+
+	if (likely(!blk_should_fake_timeout(req->q)))
+		ublk_put_req_ref(ubq, req);
+
+	return -EIOCBQUEUED;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -1928,7 +1943,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	u32 cmd_op = cmd->cmd_op;
 	unsigned tag = ub_cmd->tag;
 	int ret = -EINVAL;
-	struct request *req;
 
 	pr_devel("%s: received: cmd op %d queue %d tag %d result %d\n",
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
@@ -2004,30 +2018,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		io->task = get_task_struct(current);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
-		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
-
-		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		ret = ublk_commit_and_fetch(
+			ubq, io, cmd, ub_cmd,
+			blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag));
+		if (ret != -EIOCBQUEUED)
 			goto out;
-
-		if (ublk_need_map_io(ubq)) {
-			/*
-			 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
-			 * NEED GET DATA is not enabled or it is Read IO.
-			 */
-			if (!ub_cmd->addr && (!ublk_need_get_data(ubq) ||
-						req_op(req) == REQ_OP_READ))
-				goto out;
-		} else if (req_op(req) != REQ_OP_ZONE_APPEND && ub_cmd->addr) {
-			/*
-			 * User copy requires addr to be unset when command is
-			 * not zone append
-			 */
-			ret = -EINVAL;
-			goto out;
-		}
-
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_commit_completion(ub, ub_cmd);
 		break;
 	case UBLK_IO_NEED_GET_DATA:
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))

-- 
2.34.1


