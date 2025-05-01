Return-Path: <linux-kernel+bounces-628036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93679AA5867
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 00:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3161BA01CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 22:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5463123C8D6;
	Wed, 30 Apr 2025 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="C0LJ8Ecc"
Received: from mail-yb1-f226.google.com (mail-yb1-f226.google.com [209.85.219.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0A22A7ED
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053569; cv=none; b=vBk5Yx6LHF6LPDTlt9MIi141knlCbiP7fT+bIr6TzJr/nqwYHhiRZCbmEjW835S2XS9Xzl4YMCgsFuaOiFIDKMoxqYpsWLyDsBOUQ5lMiiK6AA5Gy/q1I0KuzjkYELvvvTY2/cZwvfyoZiXTcJTKp5IRIyJGj1l/6i6h48H560s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053569; c=relaxed/simple;
	bh=ChKMqf1RvETVsEvT5sJjmD/ZOdGzQDcoe+otqADHBU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTncpNMOOTknq/lXzFjeyMt6x4J0qEXvkRfePBCBSs+Cexpl7RL8MxWBhZGMc/6SYpuyc5kv8hnETdciA4oJ0Pqfss9c01cYo9SeTV4sy6DAV3R8PuKagcSfavjiLi/4hysIm7H4w9vOsj0Pv7HXu7SzAPjlyxjWlvD9cpZ2FoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=C0LJ8Ecc; arc=none smtp.client-ip=209.85.219.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yb1-f226.google.com with SMTP id 3f1490d57ef6-e7456415f1bso52067276.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 15:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746053566; x=1746658366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbYmq7hwdo4gr4HQcys5STyhEhXZt+ulzS0YWq0QdIk=;
        b=C0LJ8EccD2Poq25tpXS6PVYqgsVN+DezhiZRWuYoDe5vTFIYPAGNFuf248im1Ymipw
         UqsR//CKpDwAb0S3ZGbJHmBFp/pd/1iNKAY3obKrICwwBqyByDn7m1xcf8gVdUOrg9Mz
         VxfDWm3cuYFT99uV+1XLPpIadKntT6kaRxAhhSBeXSsRUKL76wKZbK9QK3hxNWbBb0iv
         Y+L20vmWQcNVwdZimIWypYwgPRf6X3hGf/h+dx3TU8jfOVNNeYnkODvrBkjgw5YmeuM2
         AxdI4f5Hx4k9Gu3Kkv0C2S6eMrNDkeiYhj9cbPy7F4awI8PDUgGBeLPOX6R0bTkHVh03
         BGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746053566; x=1746658366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbYmq7hwdo4gr4HQcys5STyhEhXZt+ulzS0YWq0QdIk=;
        b=g8tm6KYzHmSHMOqVCooNN1dE/YofBuEjgVkrLnqNswg9115Woby980uY5yha/Y43gA
         fuk7s6fjlzBYWmugjIZmjA95qDjE3kOFDtZ9oYR659x77I/LzAkev4sDp3hcEMHhw8B6
         aqs3BUXWumgEzIbNdSH2enLPDUBTkUF8xZnlIKllzx+iBw5club4VZfNsN94CFIWkn1s
         vCiqG4JFGBWPNSxhnMh6c3xrE7TaL/pvZ6q0eUnu/nmBd756jieNu686mcdQ2Sp4GTpm
         aQeYlsSxRUTmBqnVrUdIwCkewUMiiWvECWARNK2+4SstXbpKBTY1qrIRLRnUuyRK5bgh
         s2pw==
X-Forwarded-Encrypted: i=1; AJvYcCXl9dPPGJaPQ2YKCeR11ncyeqchhs9K/OKGPtkyv8bchqVJGnxmQH0D+NfjJWpPMjfDNn0Ql9eAfT+xNyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+t2zgUml9/VK9IA+G/RRruRxEWMW+b+JCR8vNPn6imZHEM7yi
	l4+KXfxFp4NRMTECBve+Hao8VJW0l1BZdM1sSB/kAGzNZM+xZGQxld8Bs8wjm5duy0nCBkjBIv0
	Upvr8CuPRPurDmnwLs4tYOJsImkWPZajk/1gOs/894BmOLf05
X-Gm-Gg: ASbGncsnxJRAtb+XJd2zPy2UgxuSxlpLDC8w5U0rHu23ahL2avoatPnXNfqlB3d79oT
	ukP6wbS+j4OXaaEOVfju5T5D0fkmf1QzIhz4tFzgo0DN3qXpexZQbRji+mS3R9sLGFDvLyuwDhO
	okGHxCw4YRqiwnLrosE66gmD1evQrlfRnJiB6O8nMqrPvxD5J6oHPvLSCyXOhz9d0o0TY/J96Va
	K+9U+cU+6DapBxK3b9ciIbWyk508Yvnk47LONIUMGoOMAYU4DMZyE2kZcFSF2JgPXjmrJBdk24/
	uMFi3wKEkCqU1eQiyLtvZRfUZ/Wqpg==
X-Google-Smtp-Source: AGHT+IHMBKUP30X+fnZBNuVVqGAC4YwFzK3I2dcrRyVeqHF4tNVp7j3CQOEw8CeZwATubLEilqG1IPN1+Z8g
X-Received: by 2002:a05:690c:8:b0:6f2:9533:8fb6 with SMTP id 00721157ae682-708aee5bbc5mr24377497b3.1.1746053566013;
        Wed, 30 Apr 2025 15:52:46 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-708ae081eb2sm981707b3.42.2025.04.30.15.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 15:52:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7433634022D;
	Wed, 30 Apr 2025 16:52:45 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 727DCE41CC0; Wed, 30 Apr 2025 16:52:45 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 7/9] ublk: don't call ublk_dispatch_req() for NEED_GET_DATA
Date: Wed, 30 Apr 2025 16:52:32 -0600
Message-ID: <20250430225234.2676781-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250430225234.2676781-1-csander@purestorage.com>
References: <20250430225234.2676781-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_dispatch_req() currently handles 3 different cases: incoming ublk
requests that don't need to wait for a data buffer, incoming requests
that do need to wait for a buffer, and resuming those requests once the
buffer is provided. But the call site that provides a data buffer
(UBLK_IO_NEED_GET_DATA) is separate from those for incoming requests.

So simplify the function by splitting the UBLK_IO_NEED_GET_DATA case
into its own function ublk_get_data(). This avoids several redundant
checks in the UBLK_IO_NEED_GET_DATA case, and streamlines the incoming
request cases.

Don't call ublk_fill_io_cmd() for UBLK_IO_NEED_GET_DATA, as it's no
longer necessary to set io->cmd or the UBLK_IO_FLAG_ACTIVE flag for
ublk_dispatch_req().

Since UBLK_IO_NEED_GET_DATA no longer relies on ublk_dispatch_req()
calling io_uring_cmd_done(), return the UBLK_IO_RES_OK status directly
from the ->uring_cmd() handler. If ublk_start_io() fails, don't complete
the UBLK_IO_NEED_GET_DATA command, matching the existing behavior.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 51 +++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b4c64779c4fd..483205a0dfe8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1210,29 +1210,16 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 		/*
 		 * We have not handled UBLK_IO_NEED_GET_DATA command yet,
 		 * so immediately pass UBLK_IO_RES_NEED_GET_DATA to ublksrv
 		 * and notify it.
 		 */
-		if (!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA)) {
-			io->flags |= UBLK_IO_FLAG_NEED_GET_DATA;
-			pr_devel("%s: need get data. qid %d tag %d io_flags %x\n",
-					__func__, ubq->q_id, req->tag, io->flags);
-			ublk_complete_io_cmd(io, UBLK_IO_RES_NEED_GET_DATA,
-					     issue_flags);
-			return;
-		}
-		/*
-		 * We have handled UBLK_IO_NEED_GET_DATA command,
-		 * so clear UBLK_IO_FLAG_NEED_GET_DATA now and just
-		 * do the copy work.
-		 */
-		io->flags &= ~UBLK_IO_FLAG_NEED_GET_DATA;
-		/* update iod->addr because ublksrv may have passed a new io buffer */
-		ublk_get_iod(ubq, req->tag)->addr = io->addr;
-		pr_devel("%s: update iod->addr: qid %d tag %d io_flags %x addr %llx\n",
-				__func__, ubq->q_id, req->tag, io->flags,
-				ublk_get_iod(ubq, req->tag)->addr);
+		io->flags |= UBLK_IO_FLAG_NEED_GET_DATA;
+		pr_devel("%s: need get data. qid %d tag %d io_flags %x\n",
+				__func__, ubq->q_id, req->tag, io->flags);
+		ublk_complete_io_cmd(io, UBLK_IO_RES_NEED_GET_DATA,
+				     issue_flags);
+		return;
 	}
 
 	if (!ublk_start_io(ubq, req, io))
 		return;
 
@@ -2043,10 +2030,28 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 		ublk_put_req_ref(ubq, req);
 
 	return 0;
 }
 
+static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
+			  struct request *req)
+{
+	/*
+	 * We have handled UBLK_IO_NEED_GET_DATA command,
+	 * so clear UBLK_IO_FLAG_NEED_GET_DATA now and just
+	 * do the copy work.
+	 */
+	io->flags &= ~UBLK_IO_FLAG_NEED_GET_DATA;
+	/* update iod->addr because ublksrv may have passed a new io buffer */
+	ublk_get_iod(ubq, req->tag)->addr = io->addr;
+	pr_devel("%s: update iod->addr: qid %d tag %d io_flags %x addr %llx\n",
+			__func__, ubq->q_id, req->tag, io->flags,
+			ublk_get_iod(ubq, req->tag)->addr);
+
+	return ublk_start_io(ubq, req, io);
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
 {
 	struct ublk_device *ub = cmd->file->private_data;
@@ -2108,14 +2113,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			goto out;
 		break;
 	case UBLK_IO_NEED_GET_DATA:
 		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
 			goto out;
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
+		io->addr = ub_cmd->addr;
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
-		ublk_dispatch_req(ubq, req, issue_flags);
-		return -EIOCBQUEUED;
+		if (!ublk_get_data(ubq, io, req))
+			return -EIOCBQUEUED;
+
+		return UBLK_IO_RES_OK;
 	default:
 		goto out;
 	}
 	ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 	return -EIOCBQUEUED;
-- 
2.45.2


