Return-Path: <linux-kernel+bounces-606260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E91A8AD30
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 03:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3EF1904022
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 01:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DB31FE47C;
	Wed, 16 Apr 2025 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ptcs/E4H"
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562A11FCFEF
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 01:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744765215; cv=none; b=nKBJP+kJ9+f3S2IeZWCWkwOnlKOoZOUyOseBlcct0oRWd+df6hJmVzoK4mJtT1j0r8N3pvej6tEQ9viU/TlyFxl5TwRUttoG0cyIoP84jBkiwvr6bBsPkAOEu3Y3ClH8W1pW8O1iK9Br6CDLcynL1akjGF5gjktCbySuvNTpXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744765215; c=relaxed/simple;
	bh=ubz58Es7ldmCdO4VoHkD5rzH+upzrmrEWF5yqVCmpiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCWGi6zIgNZ3m6usk6B3dfOqHMM9Pdt3vTzw9QrvYZZ+bYYD1Mv5C/ORMIR1y8MQvRoo2+mJ6Vru0zg/ww1jIfhhiPVvBHW24+Zm0vthFsgSQNVxcrbmfn3Am4CzfBghY/eGoEA1pDN1I5nClHqP9Dn7F7zbQVbDHE/wJr9ob/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ptcs/E4H; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-523f1b31cf8so2161853e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 18:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744765210; x=1745370010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/Rm8eRSTRPM7oJ5S9cVvxEnnOFl+oBtecWyVfRdd50=;
        b=Ptcs/E4HqfXvku3mEh5KCrBwkzxRUp7dFK4/BTYUUDfEEPt63PC9o1XESranlk/jGe
         zNg2PBLZOJ+Tyh9SR5HE8R6dbm1JeilDLlpdC0M44lvWU6E9i7uycE+ncZVT7u0kDl2B
         5XtvXL2a1g0cOrFVAnly+4ZtdmDTvPgH8uv5ahWbPT/ym56B2nz0P7GTLFvMNTY/Eu7U
         22qou+71J/+1+3HeEtgoeCXUJxCagYrr4Sj7ZsKNQPal+NKqb2+rJF9bWV1yclZZ63+a
         U62oOqyHZujll/JA5G5BMCnBDh4b+SNwGbek1dzNC8DXwZTFTlvgslAvcOOwV3Nmv7wt
         588Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744765210; x=1745370010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/Rm8eRSTRPM7oJ5S9cVvxEnnOFl+oBtecWyVfRdd50=;
        b=vR3ZOMVlr0DwtkWcvY4+GRzI91lBGAedJiyutx5ibf6TOj91XfT0YUXwBTmeK4shkS
         S0iNQrWhOjKxaH3HB7GaOA2teUrfnQ2zLNXJs9b5E2eRWtvtjSZNSVpVVlODLUxPQskR
         oqmN2tKIA1GttPMPLA9z6VzZ9sQ2EZ73gShhtfx1/ASyDdg2Db7hN3gkeME31rElOY4q
         akuLS3LEO8D5AzWj+CKJqXrRGJdIl9GCfszlK8XksLXnnZgbo3QGK4jygUzjHLVcpkcU
         KnHatKDiY0j23cTAuqxbpDLQFgPHgWdRIaLWans3kkCsNIV+o4C366QzpBiYMbvqItaP
         Mczg==
X-Forwarded-Encrypted: i=1; AJvYcCXqum/fK/Pfu+2hCJJ+zKQpOtpGJit9gIl4h2dWamk3cOAWrYV7t2YtqBBHs8tvkO21614cztNyVuHmmjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvSCPktXkA9oMLN5wk76dtidKNDbX0vMZXqNsogfaAt5Z+ddsa
	+wk/S4fpCoTkhYLd8f8RdMEJsHnrPUQn9OrZF5NYTrfsPDhCPb2+IaTY6UE1uEf5I6fk7TrQouO
	7JUdeWydDnFjSdBxcEptK8fUu5szD4idp0tLJpoVKGQwovoie
X-Gm-Gg: ASbGncsAQUw1FUEmeggCMRM2y0oe5vEejuh1XAKXDjVKAjFDdp03waB3DWwAXQxLZ0m
	pD2hZ2g99rT55j7Zzo2VZLpQL/KLKcXtZMFzmjS9KA7xP7JwSkbv+17FNUHDfrbCJOFsyisSlZL
	7PoXACm8wl1fqi3uj1B7xhyKyEjr7BO/bJjlMES1HS6mRcubTcO5E3FNMU9RehPPBK2yWth1AVS
	1T7LPRT2YCZB0K4CMUnubjWul2lBHij75RBv7DVdZzCCPZ3cCLttLGR5MCamgeWyKoHDdz9wSwA
	wWQJ44x1xQ+zV+AWW/kp6O6vrpAl6Tg=
X-Google-Smtp-Source: AGHT+IGXQQYfjcDe2oR8+MYAyVs+81XYzD53ihDjxU44Yqa8/Drc11AX14R9kirGSEROTb85jdJuIoExG4uN
X-Received: by 2002:a05:6122:1ac9:b0:526:42c2:8453 with SMTP id 71dfb90a1353d-529092d7ecemr1181678e0c.7.1744765209876;
        Tue, 15 Apr 2025 18:00:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-527abd7afadsm834047e0c.4.2025.04.15.18.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 18:00:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 12685340424;
	Tue, 15 Apr 2025 19:00:08 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 109D6E404FA; Tue, 15 Apr 2025 19:00:08 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 15 Apr 2025 18:59:40 -0600
Subject: [PATCH v4 4/4] ublk: mark ublk_queue as const for
 ublk_handle_need_get_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-ublk_task_per_io-v4-4-54210b91a46f@purestorage.com>
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
marking ublk_queue pointers as const in ublk_handle_need_get_data. Also
move a bit more of the NEED_GET_DATA-specific logic into
ublk_handle_need_get_data, to make the pattern in __ublk_ch_uring_cmd
more uniform.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e2cb54895481aebaa91ab23ba05cf26a950a642f..c8ce9349ca280b8b16040a1242a62b895ee01b5d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1291,7 +1291,7 @@ static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
 	ublk_dispatch_req(ubq, pdu->req, issue_flags);
 }
 
-static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
+static void ublk_queue_cmd(const struct ublk_queue *ubq, struct request *rq)
 {
 	struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
@@ -1813,15 +1813,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	mutex_unlock(&ub->mutex);
 }
 
-static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
-		int tag)
-{
-	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
-	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
-
-	ublk_queue_cmd(ubq, req);
-}
-
 static inline int ublk_check_cmd_op(u32 cmd_op)
 {
 	u32 ioc_type = _IOC_TYPE(cmd_op);
@@ -1933,6 +1924,21 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 	return -EIOCBQUEUED;
 }
 
+static int ublk_handle_need_get_data(const struct ublk_queue *ubq,
+				     struct ublk_io *io,
+				     struct io_uring_cmd *cmd,
+				     const struct ublksrv_io_cmd *ub_cmd,
+				     struct request *req)
+{
+	if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		return -EINVAL;
+
+	ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
+	ublk_queue_cmd(ubq, req);
+
+	return -EIOCBQUEUED;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -2025,10 +2031,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		break;
 	case UBLK_IO_NEED_GET_DATA:
-		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+		ret = ublk_handle_need_get_data(
+			ubq, io, cmd, ub_cmd,
+			blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag));
+		if (ret != -EIOCBQUEUED)
 			goto out;
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag);
 		break;
 	default:
 		goto out;

-- 
2.34.1


