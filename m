Return-Path: <linux-kernel+bounces-821893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1AFB82906
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2417234B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986622459FF;
	Thu, 18 Sep 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="IkrNHWib"
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3623C4F3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160240; cv=none; b=HeoJ+d9tuRZtgfZ9YtCJCBasl0YGgULsuv+qaqD0Z4WNU8DvXDWq6ZfQR5ooXrK9u/cLY/CK3bb5iQ8JEaHeZGM7zjY0LwG6AT/oH94VDsVfZQD+hy2aWsHxhp9X/wLu5GGjRh9FHLtfHHTVWi12Qp5g7WoELVyt+dnche2Kb+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160240; c=relaxed/simple;
	bh=SADlHgrOrTEn79WvE5EtQJLfGlA1k13iJsqgAnWiaNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjTplKvjjyriy0ymUaWqY3lqo3iUn2GPNm6+8yaCahoczJ2BzmgWrqDNraDdBVgoPHCpbeXSCrYcoY/34YqjAnAxHFjLG5hTqteBx+NWvEpek1JTCiSLk5RhVPSsOPQdqXxw99ugkKjRzKncCHPnIeAP+9qmCDk1p4XcdcRXSNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=IkrNHWib; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-4b604c17182so225371cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160237; x=1758765037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QKZxZyP+vsEEnhv8Ftm0VexvVlHS9TFLKY4pSs7XGM=;
        b=IkrNHWib0W+mKEJucZ+ukTsLPO44B0hauglDgo200XYzN81SwdL6LZacBor6catxTS
         GjIKrebSBY+YyIfouLYc8W7H9Xr0gqKBUDf522DYix7Mt0osi76aVCpNq3R7LDVMBf0C
         x+5nlHbTuJksu796y3x/6fGVG/gtnT1w//ZFmeUledf32i3/iqoeeM35ZR6dO3WXgvxK
         pzjm7Qdt2bkk8I1j2RjVr+Q1fWjurx/8tg/Hi3zi/7Cd7JulsuE1KmWRoPO/zc3dgnLG
         s98r90BwRdUlUe3KOLBOOM5ObrD4JwL/Xp7ccGbeucmQIcfsCSbs4ZDUnjipjaFoypeR
         vAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160237; x=1758765037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QKZxZyP+vsEEnhv8Ftm0VexvVlHS9TFLKY4pSs7XGM=;
        b=QlGgV6IksBe7lLzgc6zIaPDKwivEsyGs1bEqhduZlC0SmRbQjq9KpPZZaFLF/5Blb2
         pAbRtWkzSeKFZ82xSjbIsIjTN5iJnEakrk3KqzANdtK8B75W5xRtAEWXbn0BCtMDdj6L
         noe07l/kDJ/IiGqdBDs0pB5hDSkbODwJzyZ5CEZBjSBdTQqZRk6wSpyC0WnlNg1f/XGv
         9zm25+BRFQzdRycSVFJOZz52LGQ/v4P6yMqhI5L5k7qqKY9Jjg1oJ5p36BA1AzxsIQGt
         fZKf6PqTUuTmbvWKeSWDtN0+m0j4koZ273CYjx0wgh/kF9/ZJdwobFKOkmmAGI+FkH1q
         CTHw==
X-Forwarded-Encrypted: i=1; AJvYcCV/8BCZ7I+0bc5rGHAAkieq7Q2eXcIrWXnLCl1DyJ8u2FyWE/uvWmtWtCJ0jwvDlpjT97LYQt9VazOY2p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyX2ReJvaWL4aJQWeQRLOUmmy+pNUMZklv+KPkN7Wad9ioZu3d
	0oewrxoD5VYy6TY5TYdKduwSnzsfz2CSV8w096rOHGFhbwKbiqrTi4qsWheomdVk74CAmXCzjoJ
	vZ9JEwBJ0HvOOZBDMwtW4cbYYtdAirvE8oBLgs4cjxHNCzf7ZhrGT
X-Gm-Gg: ASbGncvWm75hQGwnDZqGJT3wwRnIpoTp8Cw1v+yTKtIovtIQdcl0TCw1VUNbdun1Dcf
	ypIoIjVypJqoYrjpOfsizAJTiHrRJpika6sgnyhpdBQHXTK9IEvGjI9I5pgYhwB7HTJZF7c09A7
	iqAzdzs+xP829aYkKgoYv/BRSDHocJB7x4aZNQMynuIV1rxIbJGoP/XzBOYqJzHIKICCJYHolFM
	Fjs/6aCUKqcK4Z5hGj5REzDXRNbuNf6Zs1jtdmvkH6GUJNnxA3PJr1jHsA4fMaN8vmdWoxWaPpO
	ZXHE/+McfiQxpBFDBfKqrwyaq71qJ6hdcAYcv/eIgLaDehoM0JLNzjzL4Q==
X-Google-Smtp-Source: AGHT+IEsgIGsNSRRNT38WH7yzSqLp/Ktc3WgoI/FXMkTetjwhZhrLfnLD0dIVWr34qvWWxXEJ54m1NyDRmNv
X-Received: by 2002:ac8:5dc7:0:b0:4b7:aa56:c0f8 with SMTP id d75a77b69052e-4ba66a30247mr35635721cf.4.1758160237404;
        Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-79350a538c8sm710306d6.33.2025.09.17.18.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C303334059B;
	Wed, 17 Sep 2025 19:50:36 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BDB7BE41B42; Wed, 17 Sep 2025 19:50:36 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 07/17] ublk: pass ublk_device to ublk_register_io_buf()
Date: Wed, 17 Sep 2025 19:49:43 -0600
Message-ID: <20250918014953.297897-8-csander@purestorage.com>
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

Avoid repeating the 2 dereferences to get the ublk_device from the
io_uring_cmd by passing it from ublk_ch_uring_cmd_local() to
ublk_register_io_buf().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d6d8dcb72e4b..cb51f3f3cd33 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2123,15 +2123,15 @@ static void ublk_io_release(void *priv)
 	else
 		ublk_put_req_ref(io, rq);
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
+				struct ublk_device *ub,
 				const struct ublk_queue *ubq,
 				struct ublk_io *io,
 				unsigned int index, unsigned int issue_flags)
 {
-	struct ublk_device *ub = cmd->file->private_data;
 	struct request *req;
 	int ret;
 
 	if (!ublk_support_zero_copy(ubq))
 		return -EINVAL;
@@ -2150,10 +2150,11 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	return 0;
 }
 
 static int
 ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
+			    struct ublk_device *ub,
 			    const struct ublk_queue *ubq, struct ublk_io *io,
 			    unsigned index, unsigned issue_flags)
 {
 	unsigned new_registered_buffers;
 	struct request *req = io->req;
@@ -2163,11 +2164,12 @@ ublk_daemon_register_io_buf(struct io_uring_cmd *cmd,
 	 * Ensure there are still references for ublk_sub_req_ref() to release.
 	 * If not, fall back on the thread-safe buffer registration.
 	 */
 	new_registered_buffers = io->task_registered_buffers + 1;
 	if (unlikely(new_registered_buffers >= UBLK_REFCOUNT_INIT))
-		return ublk_register_io_buf(cmd, ubq, io, index, issue_flags);
+		return ublk_register_io_buf(cmd, ub, ubq, io, index,
+					    issue_flags);
 
 	if (!ublk_support_zero_copy(ubq) || !ublk_rq_has_data(req))
 		return -EINVAL;
 
 	ret = io_buffer_register_bvec(cmd, req, ublk_io_release, index,
@@ -2354,11 +2356,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		/*
 		 * ublk_register_io_buf() accesses only the io's refcount,
 		 * so can be handled on any task
 		 */
 		if (_IOC_NR(cmd_op) == UBLK_IO_REGISTER_IO_BUF)
-			return ublk_register_io_buf(cmd, ubq, io, addr,
+			return ublk_register_io_buf(cmd, ub, ubq, io, addr,
 						    issue_flags);
 
 		goto out;
 	}
 
@@ -2376,11 +2378,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
-		return ublk_daemon_register_io_buf(cmd, ubq, io, addr,
+		return ublk_daemon_register_io_buf(cmd, ub, ubq, io, addr,
 						   issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		ret = ublk_check_commit_and_fetch(ubq, io, addr);
 		if (ret)
 			goto out;
-- 
2.45.2


