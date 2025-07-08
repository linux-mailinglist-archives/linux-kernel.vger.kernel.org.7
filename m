Return-Path: <linux-kernel+bounces-722337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF61BAFD850
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D04E565787
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A0324676F;
	Tue,  8 Jul 2025 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LHIXJY3u"
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB3A241CA2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 20:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006146; cv=none; b=qzeUI1xZatxG/ACbc2vh3DCthYi6XtjaM+4gCpwhiup63JJU1RBjbl+n/jlvz2oxStCC0IO5GWaXIDNFGC/gLrfcoOgsvMxTjERVYC9hwito7uNd2gJIGP/yEE9HZiJMU00qFzbMGmsEs4Seu+XkL/48yK0aVchLuTovBKufZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006146; c=relaxed/simple;
	bh=ZVBrrHmhgsG6N59v7mULAw5I6M2l2CKSVzxTpP6rvro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBpSqjglimr3Gs9GguAF1m74xVw5boljhR9AsI++YoXxrf70a5uzXOk2qMNOH7CtugIm+7a2fL6sFtVzGV3CUKemWvwLQUIvA/IJuweCIYClcEI8P9QOZ5UsKZMSIATPHxCOfi43CATni5pHVjWVAmtvYDLaP20klkAZigTxubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LHIXJY3u; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-53470a345e8so104096e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752006144; x=1752610944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ6ufLrTJ+dfNDDuxAhQi2WJ2AhmuL1ORSeAN7H3r9I=;
        b=LHIXJY3uEF3Q/tcu/TiuuXHgWXapogpJCAE3yUDxjUQz0MoQR+jKCeOpTMw4dDBKTz
         IesygsEWLFd2hy0sIyk8q13Ao2/jZLwB5THXzu9mFHoOdv/lKzmD2JTcjGcDriuCNPX2
         ICMYEFzovVJiCEflk7vQetioE+MP6YZz9lMj4qsQPr4kYuNr5PxwS7kdywDGgRzi0LnM
         RI48oE+5TA+dzwbfYS6nRvfnPTvw5QnqnpkDoDKVs7VebA0ogKG9vir+AqjStxgp3Cb0
         1iKsbDEoDKNkcAcQwkGX4ZdZUdn547e0fnM/pU3uMeyGaZaHen1ke1E6p+jaCdesjhZn
         hl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752006144; x=1752610944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJ6ufLrTJ+dfNDDuxAhQi2WJ2AhmuL1ORSeAN7H3r9I=;
        b=mdCbbsfks4yz9P5aefk2ouIxa1RbsGlP6LFZ39Sb6AXgIZU+O3i8W3HKt2eqWEHZxk
         CGXD7LV5bRjJzH7JfZImuimR69UwjIdhz+uTd4/PEnpRi/H9ZAtXeVQ3eyQFRgqgMtTw
         hpQK5GMyT41zEIluWxPLBU3kzMxJY5LR7NkM2mwbyiJs82/T6k2fPk2OQ8w8r6ZW38KG
         UgXQsN9iZxk6ci+T5tQKyu627Wmd4GwxRlqsy1mTm3/efS4+xgzSGG0mgdBsriOJTfTl
         K+P/m6I0xHkCeXzWy2xSg0YGjt+53622ZAfhN8FQXbX3ri6xBaHl8gd7JaH3ZoeN6l/v
         e9Qw==
X-Forwarded-Encrypted: i=1; AJvYcCU+lqEf36A7uLpfHOxyhujekmeq9nIr88fJ/125FOwRPhYAoVXum3rzMPU0zzYpyW/5OCOo+XJ+9XjrnPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbSkWOXas7QEQw2Ug+HP/WlkChCebWIe93lGVrS2M4GdAyd7p3
	jMLpRv+ofN2NXHo2fMQVbqPOLz2LPwzEEOFtJEWGXJ4nZRfG0B3gxSIvwx5qPJ/tNLWfSLfiLRQ
	ZF8/EhJ3G3/C2zZAa2Uj9neo2rqUlXnFDLIEe
X-Gm-Gg: ASbGncvBXctXWAUl+yYwTC1loP6iXPZ/iFJcDprx6PK93LxPmAjYK2+pWSqDBSoD98o
	kx+ZCNznGUHC1NvNx8sJ3x1YrP77vaYE+8Z+5nW2Jz910E6xXYn/PiNQ4S8AA71SqSXluwaIayx
	8b7uaOhyeYJhliOU6D4D7bVeVTyWYTuRgzvfvx/m5DmXd0BnQUulRTpYCzskCL+I44e9I5BLDTK
	tvtlReeVGcOoxYjGdSBu8VI6oYfx1kxswK++MiYLG4C5xCkoTSwylSIUEA5wPrrUtrBW8V30Dfn
	uE00Lbfq9uNloaq1zUNu8wLM6/vpI1QnZmuJQn7BjOAEviQDgDliYXY=
X-Google-Smtp-Source: AGHT+IFJUSFN4ZOpjMCeamxy/173A4wpLk3i5AJortHDDnjHVKBklDx3ykVDiJk3P1pvSv9lOH+Dxcj5TVey
X-Received: by 2002:a05:6122:8606:b0:531:c315:f787 with SMTP id 71dfb90a1353d-5347c274f0amr4289125e0c.2.1752006143793;
        Tue, 08 Jul 2025 13:22:23 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5347906c808sm536733e0c.7.2025.07.08.13.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:22:23 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C1D3934069F;
	Tue,  8 Jul 2025 14:22:22 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BF952E41CDE; Tue,  8 Jul 2025 14:22:22 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Mark Harmstone <maharmstone@fb.com>,
	linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 4/4] io_uring/cmd: remove struct io_uring_cmd_data
Date: Tue,  8 Jul 2025 14:22:12 -0600
Message-ID: <20250708202212.2851548-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250708202212.2851548-1-csander@purestorage.com>
References: <20250708202212.2851548-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no more users of struct io_uring_cmd_data and its op_data
field. Remove it to shave 8 bytes from struct io_async_cmd and eliminate
a store and load for every uring_cmd.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring/cmd.h |  9 ---------
 io_uring/uring_cmd.c         | 12 +-----------
 io_uring/uring_cmd.h         |  1 -
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 29892f54e0ac..cfa6d0c0c322 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -19,14 +19,10 @@ struct io_uring_cmd {
 	u32		cmd_op;
 	u32		flags;
 	u8		pdu[32]; /* available inline for free use */
 };
 
-struct io_uring_cmd_data {
-	void			*op_data;
-};
-
 static inline const void *io_uring_sqe_cmd(const struct io_uring_sqe *sqe)
 {
 	return sqe->cmd;
 }
 
@@ -135,15 +131,10 @@ static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 static inline struct task_struct *io_uring_cmd_get_task(struct io_uring_cmd *cmd)
 {
 	return cmd_to_io_kiocb(cmd)->tctx->task;
 }
 
-static inline struct io_uring_cmd_data *io_uring_cmd_get_async_data(struct io_uring_cmd *cmd)
-{
-	return cmd_to_io_kiocb(cmd)->async_data;
-}
-
 /*
  * Return uring_cmd's context reference as its context handle for driver to
  * track per-context resource, such as registered kernel IO buffer
  */
 static inline void *io_uring_cmd_ctx_handle(struct io_uring_cmd *cmd)
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 58964a2f8582..053bac89b6c0 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -24,25 +24,19 @@ void io_cmd_cache_free(const void *entry)
 
 static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	struct io_async_cmd *ac = req->async_data;
-	struct io_uring_cmd_data *cache = &ac->data;
-
-	if (cache->op_data) {
-		kfree(cache->op_data);
-		cache->op_data = NULL;
-	}
 
 	if (issue_flags & IO_URING_F_UNLOCKED)
 		return;
 
 	io_alloc_cache_vec_kasan(&ac->vec);
 	if (ac->vec.nr > IO_VEC_CACHE_SOFT_CAP)
 		io_vec_free(&ac->vec);
 
-	if (io_alloc_cache_put(&req->ctx->cmd_cache, cache)) {
+	if (io_alloc_cache_put(&req->ctx->cmd_cache, ac)) {
 		ioucmd->sqe = NULL;
 		req->async_data = NULL;
 		req->flags &= ~(REQ_F_ASYNC_DATA|REQ_F_NEED_CLEANUP);
 	}
 }
@@ -191,13 +185,10 @@ EXPORT_SYMBOL_GPL(io_uring_cmd_done);
 int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	struct io_async_cmd *ac;
 
-	/* see io_uring_cmd_get_async_data() */
-	BUILD_BUG_ON(offsetof(struct io_async_cmd, data) != 0);
-
 	if (sqe->__pad1)
 		return -EINVAL;
 
 	ioucmd->flags = READ_ONCE(sqe->uring_cmd_flags);
 	if (ioucmd->flags & ~IORING_URING_CMD_MASK)
@@ -209,11 +200,10 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	ioucmd->cmd_op = READ_ONCE(sqe->cmd_op);
 
 	ac = io_uring_alloc_async_data(&req->ctx->cmd_cache, req);
 	if (!ac)
 		return -ENOMEM;
-	ac->data.op_data = NULL;
 	ioucmd->sqe = sqe;
 	return 0;
 }
 
 void io_uring_cmd_sqe_copy(struct io_kiocb *req)
diff --git a/io_uring/uring_cmd.h b/io_uring/uring_cmd.h
index 9e11da10ecab..041aef8a8aa3 100644
--- a/io_uring/uring_cmd.h
+++ b/io_uring/uring_cmd.h
@@ -2,11 +2,10 @@
 
 #include <linux/io_uring/cmd.h>
 #include <linux/io_uring_types.h>
 
 struct io_async_cmd {
-	struct io_uring_cmd_data	data;
 	struct iou_vec			vec;
 	struct io_uring_sqe		sqes[2];
 };
 
 int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags);
-- 
2.45.2


