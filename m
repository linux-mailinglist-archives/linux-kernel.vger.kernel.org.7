Return-Path: <linux-kernel+bounces-867715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 987CFC03596
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AF21A07D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C86C2D0C62;
	Thu, 23 Oct 2025 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NvSnp2B4"
Received: from mail-wr1-f98.google.com (mail-wr1-f98.google.com [209.85.221.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91154262D14
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250719; cv=none; b=Err+o+ZdxgzKUNFOjTueuW26RG3YMu+FPy9d7ydvDtX/OCyZAnwosrLnTqcLnChRQcHCXBKdCpSTL77yQDxQGWun9smAy2zsYZ9ax6Ac0HXpE/pNdKtEgMbotjQmk8e1Y9vT6P7KdvW/g+M/JkqXGw/F8XMaXAmI2oOPk2FChlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250719; c=relaxed/simple;
	bh=1OFERuWCzicdiztTF/q7QW5F9IVu0Slo/TPxet3gSrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T08uoFbI1hRxdN2MIrIrrwiP+I0jOwXYfBeMMrDBFce9RXC1lX4gCyCW5pBmpyQXo5wusb9/sCy74oN4D6H378hCsUwXWGd/5ao6CxEabL2hNPU0UabHKyo5n2w2cUWDOOddUY9HlwQ3lFiTisHLdaWsRVvb5/FpaXN8YSpr+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NvSnp2B4; arc=none smtp.client-ip=209.85.221.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wr1-f98.google.com with SMTP id ffacd0b85a97d-42708097bbdso79539f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761250716; x=1761855516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=NvSnp2B4XQ3uSah1VnCLVzstzJ+AyVbGSSz6nvwx31bwaNFfuP9e+t5qsdSmj3csdL
         qdL8c96xJa4t6erKX8FpthpOA66kw/QxsbCuY43ttI5bfdIGljix76VEwiY1aUTQ/w93
         BaeBzqfDtJdsBlGt5DYjuADmnTCCoJtKqstfrc22u0lZd+wR2WiKzuD7XHkxSq4Wj0F4
         ab7A+3hLbMtE9zV2Wq0zyuXtdI+X2jzuuO+6179o5unNX7HSV5Ix2HXJrggKjxcB6Pq2
         UJexbANFpr+ycCckeopRFNVtf4Z2idnawISAIo7MZkpnEpfew/yPY4wTcRfTsac+B9PS
         6t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250716; x=1761855516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=R7Llm0cDxsTvQEcJduPMGDEBMvX74MPQRmzAKhGdEqaFeYqSVr5Mst5rBfTxUX7nZz
         zLxZLDusmEtpzAXrKyapqr6QWjnsUOfn/EzJT4cnFP2xK9pvZDlL7ttGw+wBRnxEeYR3
         MgG2oxf82G6T7E7HOWmPfkAwtDEeqI0uYiAPm59a+UsfPzB5PYNNYmR1jjHe9M9OOonL
         wJTlmRGEYFNkhcI5ENbTJA9dFly5Qzpa6zfbc1tS7op4gwe5dtX8SPRMMLvtRfLD/AkZ
         T/Dwl5AnQ3wJel5sqC49A0MTk3J6AY09w5ymhWXff0Wpw/Q5R+3d3W2agPiNuko1gdd4
         7yZA==
X-Forwarded-Encrypted: i=1; AJvYcCW2FL8q5ZUfE6I3GiDEJRbzaLtox9rFbInGwqbMt6rdTLStGXXxZOIMSfJDsME3f4MjgS15FWRkFKTZoSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8VHzTR0ZMJ+K0lq6Iydur0DQbdACXQOnVzw3HGqIGWtDbBjzU
	dXy/9HlIfCqaL/eSjXygixeezI6JBhlwFOUPglwZpOy5l1KfKONPHyDLWFSsXa6GIfP3rb0O2xi
	k5JxbszIaQemT/6a94eRCnhHEAKOmxkws6BAJcAiwVU/qkhvq4JTo
X-Gm-Gg: ASbGnctJoMFntroAX73RMg5HOkk/1Jqw6KAasUbhuyxE4IChLh/xjIpdys6MliUwLKr
	aBAXRNFnqgaqN2XCQGbegUL2p2DA7lzG1Aczqa8wTSl5ZqDKEaVLYwwC5GT5rOH3ZsDiflEDFCW
	HrBQRxQgxbtwN97LwOFQW2B8f9//yXh+CRg5eADiRvOYZtL/TkV3Xy1KyNXL/WI6Lleu/wkxFue
	fE1OQthX2D1WgbyG5ROoqF5HD/JLQpOUxQrkSs9OfeOlobajvQjBsqNcCDtrbLPdH1WmLZl+OI6
	NNZxZtYAsl5mtGyN/Jsi6ZImdcIhadf9PlHd0kditCFeKzxmt0mKL2M1uWEAubLfFbT6KJWNb4Z
	QeUn1yHBk7nV200Zs
X-Google-Smtp-Source: AGHT+IFNnp/5OUSlZLEwl60VMSFyQi/nSnMaue4pn8b3+029XCgF8WPzS6GPvaglBgdRg0DxMPMd5qnGf6Bb
X-Received: by 2002:a5d:4e45:0:b0:427:529:5e48 with SMTP id ffacd0b85a97d-42705295e6dmr7178838f8f.5.1761250715805;
        Thu, 23 Oct 2025 13:18:35 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-429898e96fasm244723f8f.35.2025.10.23.13.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:18:35 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5D2C8340875;
	Thu, 23 Oct 2025 14:18:34 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 59FA6E41B1D; Thu, 23 Oct 2025 14:18:34 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 2/3] io_uring/uring_cmd: call io_should_terminate_tw() when needed
Date: Thu, 23 Oct 2025 14:18:29 -0600
Message-ID: <20251023201830.3109805-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251023201830.3109805-1-csander@purestorage.com>
References: <20251023201830.3109805-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most uring_cmd task work callbacks don't check IO_URING_F_TASK_DEAD. But
it's computed unconditionally in io_uring_cmd_work(). Add a helper
io_uring_cmd_should_terminate_tw() and call it instead of checking
IO_URING_F_TASK_DEAD in the one callback, fuse_uring_send_in_task().
Remove the now unused IO_URING_F_TASK_DEAD.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 fs/fuse/dev_uring.c            | 2 +-
 include/linux/io_uring/cmd.h   | 7 ++++++-
 include/linux/io_uring_types.h | 1 -
 io_uring/uring_cmd.c           | 6 +-----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f6b12aebb8bb..71b0c9662716 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1214,11 +1214,11 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
 {
 	struct fuse_ring_ent *ent = uring_cmd_to_ring_ent(cmd);
 	struct fuse_ring_queue *queue = ent->queue;
 	int err;
 
-	if (!(issue_flags & IO_URING_F_TASK_DEAD)) {
+	if (!io_uring_cmd_should_terminate_tw(cmd)) {
 		err = fuse_uring_prepare_send(ent, ent->fuse_req);
 		if (err) {
 			fuse_uring_next_fuse_req(ent, queue, issue_flags);
 			return;
 		}
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 7509025b4071..b84b97c21b43 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef _LINUX_IO_URING_CMD_H
 #define _LINUX_IO_URING_CMD_H
 
 #include <uapi/linux/io_uring.h>
-#include <linux/io_uring_types.h>
+#include <linux/io_uring.h>
 #include <linux/blk-mq.h>
 
 /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
 #define IORING_URING_CMD_CANCELABLE	(1U << 30)
 /* io_uring_cmd is being issued again */
@@ -143,10 +143,15 @@ static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			io_uring_cmd_tw_t task_work_cb)
 {
 	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
 }
 
+static inline bool io_uring_cmd_should_terminate_tw(struct io_uring_cmd *cmd)
+{
+	return io_should_terminate_tw(cmd_to_io_kiocb(cmd)->ctx);
+}
+
 static inline struct task_struct *io_uring_cmd_get_task(struct io_uring_cmd *cmd)
 {
 	return cmd_to_io_kiocb(cmd)->tctx->task;
 }
 
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index c2ea6280901d..278c4a25c9e8 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -37,11 +37,10 @@ enum io_uring_cmd_flags {
 	IO_URING_F_IOPOLL		= (1 << 10),
 
 	/* set when uring wants to cancel a previously issued command */
 	IO_URING_F_CANCEL		= (1 << 11),
 	IO_URING_F_COMPAT		= (1 << 12),
-	IO_URING_F_TASK_DEAD		= (1 << 13),
 };
 
 struct io_wq_work_node {
 	struct io_wq_work_node *next;
 };
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index d1e3ba62ee8e..35bdac35cf4d 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -114,17 +114,13 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 EXPORT_SYMBOL_GPL(io_uring_cmd_mark_cancelable);
 
 static void io_uring_cmd_work(struct io_kiocb *req, io_tw_token_t tw)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
-	unsigned int flags = IO_URING_F_COMPLETE_DEFER;
-
-	if (io_should_terminate_tw(req->ctx))
-		flags |= IO_URING_F_TASK_DEAD;
 
 	/* task_work executor checks the deffered list completion */
-	ioucmd->task_work_cb(ioucmd, flags);
+	ioucmd->task_work_cb(ioucmd, IO_URING_F_COMPLETE_DEFER);
 }
 
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			io_uring_cmd_tw_t task_work_cb,
 			unsigned flags)
-- 
2.45.2


