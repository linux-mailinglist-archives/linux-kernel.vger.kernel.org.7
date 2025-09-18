Return-Path: <linux-kernel+bounces-821895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E74B82918
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D587C1BC8B76
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0548824E4C4;
	Thu, 18 Sep 2025 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NA1Q/KHT"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129E23D2B4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160241; cv=none; b=RQ1Jio63FIFpqcBLA1cg0lBkqXQJh08fp8gqq7Y+f1WNEHICrCIo1TgyQS+G1i+pCnwWfKV4ijzim9FRcuY2SUlFVXVcWqm4rRcLX4LiB7zGVf6i/qr2J9cOHYamYtNTGyNQ94xG73o51aZsjlB19sk0U04jMm1CFWtefnV+VwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160241; c=relaxed/simple;
	bh=IzqTeejOplBbi+eM1A6PaFtcunbVQ069l6eaeRHj2kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SD2KIdAxdFum3f1PHOvRrBN4x7JOFrmbfnaLavoslNfqsR0j3lERhlKobawlOuIXeR7lNfWreXVf1bVW4xcfetKj2His+DcxwyRIPZWfTKv2TgXlVQlsj6BX767OxIF6Rk6mjFzhQjO5p4IHzHHorXR0dbGe6RMcN9ixNzZ8TPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NA1Q/KHT; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-267fa729a63so605665ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160238; x=1758765038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wQVhgHo+8vogqC7BSwqDKf5lIXZgh0TKgptIhNyogA=;
        b=NA1Q/KHTLazqS0QJecMFHADF6zhVZszUPpfE4rn7TGKkuOl6kOT4EPG/Oxpven5itK
         65NL0dsPp2WsYKsxlL7lKiE/yW6YG8pMAX2II1XXDamlFP8GK/Ci0LbXLKVjafJROXLa
         AJHmXlJXI24FMwvrquv2gHIBBAbupLBpd6//JAlzPgIwMYxSJxxxRXzjv8zaPeILma7S
         BE8hQjk5J934pVQXfSbBrWxL+y6ikVPaQmlJDu5SV3kyqLHAukeBEo+TnodYk+FiRiGN
         Duxipjk6USymDC4x9g/rYQVdyI6mqMrOJwCqimHMELuPtEH7qbhCgh0YrgpvRYdkvtuJ
         fg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160238; x=1758765038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wQVhgHo+8vogqC7BSwqDKf5lIXZgh0TKgptIhNyogA=;
        b=pxp2TFmkrCVWWGPWdak0rM+i1Nki6CFFD4kUwpM37XRUWr5xWqNYdS5iT5zAtaVSXi
         pwX3YPaC9CCq2r5PFq7ZpGblcw2xXBVoXpgfAMNYCCshV3pquxA+dJkmh/+lv3vBFdvT
         ObpDbACPpizCs5Vh65WTZhvAxzgCeagjaISpWuP8RcLgEIQbeqo9r9DTIgyZuHqnS5DZ
         5uekrJGYWv1MY2GfMnKcNSYhwSDqkdycVb0rtT/E5PMRXeNefHE1vz61logra1L0KfPv
         cS+oB+zUgleMRkp9zJiaLNgRuDAvyZGoSILjx/YIsj5aF02ocCmni6bQtu9L3vLCOWZz
         i0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbdll5DdUtAb0I+ICjNB10avLfDgIL2WOnOhlUqfph9lGkdamIZU9WSiT4PvaOOLO9718t2SOWcrxg+j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyPCV/91EwgR6wdjxJvC6Uu384C1p9wQ7G1gZaqvBW8+vy8inN
	EbtcbehNABDKqIc1qd+rTbcoTx9g0TcpQIM00J8yf2S0y+zFkXFwvPsqK/BXSlvRcu2W7+fW0FV
	RP9yq48E9WFxH0nKnzVX1Gic8iqe/iGFTw/VOWs6aNwr+QPVXB7QH
X-Gm-Gg: ASbGncv5SfNHWRq406vZ0FucMUMezf3FSRoOnK9+4q4+Gp90ejrM/eMpg3qQPdBalm8
	gPtScQdCTQOHk9w2S8Hk69w/QfByw1CrRgXbH0wQ2ZHUgBboCe38XKM2pnH7zbc20SyhVDIguHM
	LqzCos3vqSmfJg8KGjN7GYaEwlvf2rTSpj0Rpzbpl50Myxn7l0pG080MTqz51IBEsTx0EgCxYDi
	Qa/w6Ty8qKskdxutGXbmQft5lVCIcGI2K3ky4143leZexg49F9p85gEGw0z3xY+GN8du+Jya6Dt
	cgQmG3qELr09IZALVQpxMLXfzrCGLEIoUymzx5fyVqjGB7cLt1TCuWY4kw==
X-Google-Smtp-Source: AGHT+IHYgElD2bebvs8pcE3XolyBt06ynW+sJ+AuqDmRJpc7+kRWh6qkKyyz5C58hEj7i9w0FTtgsyRVIiJT
X-Received: by 2002:a17:903:22c1:b0:269:85aa:3776 with SMTP id d9443c01a7336-26985aa513emr6410735ad.11.1758160238394;
        Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-26980271fc7sm993065ad.37.2025.09.17.18.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BE87B34059B;
	Wed, 17 Sep 2025 19:50:37 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B6B8FE41B42; Wed, 17 Sep 2025 19:50:37 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 10/17] ublk: pass q_id and tag to __ublk_check_and_get_req()
Date: Wed, 17 Sep 2025 19:49:46 -0600
Message-ID: <20250918014953.297897-11-csander@purestorage.com>
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

__ublk_check_and_get_req() only uses its ublk_queue argument to get the
q_id and tag. Pass those arguments explicitly to save an access to the
ublk_queue.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 266b46d40886..cb61f6213962 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -248,12 +248,11 @@ struct ublk_params_header {
 
 static void ublk_io_release(void *priv);
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		const struct ublk_queue *ubq, struct ublk_io *io,
-		size_t offset);
+		u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
 static inline unsigned int ublk_req_build_flags(struct request *req);
 
 static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
@@ -2124,21 +2123,21 @@ static void ublk_io_release(void *priv)
 		ublk_put_req_ref(io, rq);
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 				struct ublk_device *ub,
-				const struct ublk_queue *ubq,
+				u16 q_id, u16 tag,
 				struct ublk_io *io,
 				unsigned int index, unsigned int issue_flags)
 {
 	struct request *req;
 	int ret;
 
 	if (!ublk_dev_support_zero_copy(ub))
 		return -EINVAL;
 
-	req = __ublk_check_and_get_req(ub, ubq, io, 0);
+	req = __ublk_check_and_get_req(ub, q_id, tag, io, 0);
 	if (!req)
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
 				      issue_flags);
@@ -2151,11 +2150,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 }
 
 static int
 ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
 			    struct ublk_device *ub,
-			    const struct ublk_queue *ubq, struct ublk_io *io,
+			    u16 q_id, u16 tag, struct ublk_io *io,
 			    unsigned index, unsigned issue_flags)
 {
 	unsigned new_registered_buffers;
 	struct request *req = io->req;
 	int ret;
@@ -2164,11 +2163,11 @@ ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
 	 * Ensure there are still references for ublk_sub_req_ref() to release.
 	 * If not, fall back on the thread-safe buffer registration.
 	 */
 	new_registered_buffers = io->task_registered_buffers + 1;
 	if (unlikely(new_registered_buffers >= UBLK_REFCOUNT_INIT))
-		return ublk_register_io_buf(cmd, ub, ubq, io, index,
+		return ublk_register_io_buf(cmd, ub, q_id, tag, io, index,
 					    issue_flags);
 
 	if (!ublk_dev_support_zero_copy(ub) || !ublk_rq_has_data(req))
 		return -EINVAL;
 
@@ -2356,12 +2355,12 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		/*
 		 * ublk_register_io_buf() accesses only the io's refcount,
 		 * so can be handled on any task
 		 */
 		if (_IOC_NR(cmd_op) == UBLK_IO_REGISTER_IO_BUF)
-			return ublk_register_io_buf(cmd, ub, ubq, io, addr,
-						    issue_flags);
+			return ublk_register_io_buf(cmd, ub, q_id, tag, io,
+						    addr, issue_flags);
 
 		goto out;
 	}
 
 	/* there is pending io cmd, something must be wrong */
@@ -2378,11 +2377,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
-		return ublk_daemon_register_io_buf(cmd, ub, ubq, io, addr,
+		return ublk_daemon_register_io_buf(cmd, ub, q_id, tag, io, addr,
 						   issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		ret = ublk_check_commit_and_fetch(ubq, io, addr);
 		if (ret)
 			goto out;
@@ -2427,20 +2426,19 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 			__func__, cmd_op, tag, ret, io->flags);
 	return ret;
 }
 
 static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
-		const struct ublk_queue *ubq, struct ublk_io *io, size_t offset)
+		u16 q_id, u16 tag, struct ublk_io *io, size_t offset)
 {
-	unsigned tag = io - ubq->ios;
 	struct request *req;
 
 	/*
 	 * can't use io->req in case of concurrent UBLK_IO_COMMIT_AND_FETCH_REQ,
 	 * which would overwrite it with io->cmd
 	 */
-	req = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
+	req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
 	if (!req)
 		return NULL;
 
 	if (!ublk_get_req_ref(io))
 		return NULL;
@@ -2534,11 +2532,11 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 
 	if (tag >= ub->dev_info.queue_depth)
 		return ERR_PTR(-EINVAL);
 
 	*io = &ubq->ios[tag];
-	req = __ublk_check_and_get_req(ub, ubq, *io, buf_off);
+	req = __ublk_check_and_get_req(ub, q_id, tag, *io, buf_off);
 	if (!req)
 		return ERR_PTR(-EINVAL);
 
 	if (!req->mq_hctx || !req->mq_hctx->driver_data)
 		goto fail;
-- 
2.45.2


