Return-Path: <linux-kernel+bounces-795423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BACF6B3F1E0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64AFB3B9553
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 01:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88842DECD3;
	Tue,  2 Sep 2025 01:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ImmrXrA0"
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8BD3594B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756776376; cv=none; b=TvujBxlnOF+x46JPrSpNQsItbJseLUB9Xm8ePQksPTsvWpsU5PDoBYK0xRSSWebGKEyWEwQkZuHZR5TbqnH20le/YvVXoUOmvpY5nu+WxIhzMRDum6+t1ubYwGLYkv1w3RkoH4y5ZqxHh0wad6WFAWRcrCX+Fyz2QAiCqFo2eJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756776376; c=relaxed/simple;
	bh=BtmRQ2JZVKQosuKD9EwRNIFM+4SVu1qxP+Nd0xQRvNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KF0Ur/rnk4igu/rtrnkQ6C/zrMmVTaGo3Ycw7vwQ7WTpQHvz9+qXNBHtB7aU+C2EkHzILhk6esdXszdX7/+UQohlQnEtf7ZD9dNJmDAVXEofHEv3nbHHUOW6Y7fyxwR4blpZL/lgHQ57WHZiwG9F+/MRZzmhDeFArX1uzacHYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ImmrXrA0; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-3158b868804so306463fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 18:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756776373; x=1757381173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FuAqbXrE5OAa9YMUeCtG7mhaJFLjAeGfEFxSVF+yHR8=;
        b=ImmrXrA0xwb86CZgw82vrMZcT/01c2zKaqyV0jgSsGVzOQmcWtPNxfkZr45ybhaltY
         o7JDrno4EEAtSygV3RKNk3xZkXLh3YVkCVdcKNdW2Ihr/U+SvwXK6AapLjlwV6V5adRj
         zus+SFIFKIQIqlm1LrcEzm0Wf5eC1/hk4wfFcY3X58MHAFZpfw5uQA/TU7Am9dwDRSVc
         C8TeLm8OYu9rnduMXNwKkU1Juh7BfKWydvRV0DTEClTU0GtmBk3y3P0tfUCWcd0SegMk
         Q4pdQz942tk64VJZlVUcOqn6TYgj86DkoHSNnodlEQHBteoxePx/73HDU1ipXojBlFCq
         65FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756776373; x=1757381173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FuAqbXrE5OAa9YMUeCtG7mhaJFLjAeGfEFxSVF+yHR8=;
        b=EwwOOHnCJfm2qYcmI6RLH/H6oPokomcZS5xwTHTtQmCgivhV6iWrrXQMmmbntE4/CM
         abILC3vCU8hIpL94j0825rXZPQk0nRplO0eXUcDHjyRP6iCjl+mQrOxnYriEDknjtOJn
         7UvLU4gVqxZ1fOzlU0pFLL2Mm0Q1eqNbPiwZJ4pEdMdc4EJE5czSbsYld/bc+78CIGZm
         pJJmRPKS7dTw4uTcn1oCIlKeZ1x7d3KN3bxUzW85XIyHexIzQyIAAXu9/1qHl6GfrtvH
         SXLkihYAMJ0bLT75vHX2IZ5gMqaiNaSfyTKxgZ7hazVDw/S6YYynaODT3P5N7QUiD02E
         bD7w==
X-Forwarded-Encrypted: i=1; AJvYcCWsqJ4RSRzhkUBsapEGB3FvVhPHyn4UPtUvgx3+/fnpaGKspYbm3jH2FhlRJ8C4AuT5cTVtY9W8cmQsaGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwamTEYDNvmgUq9OKQgEw4XsT+q1/FUYUeL5CZWKJvFj+zyh2KB
	0GsnFRZIaPH0FUorC3kz+jGW2dU7zYjpmNY9X6WlWsFB23LNnkFhI4BELTnQGDWyWjixqfGqenT
	S0bN5idfgzD0TAX05/p7NH3AyajCbAibjqV89
X-Gm-Gg: ASbGncvMEJT1fpyqk8Bfd+UYDBxBhILV1DarPFAjP7FSx5a8hUWu6DYOW0U0Ik+rx8J
	HionIU9i012Iw/umvNbjjCqsf/3Ux7PIVjNQ/08zuvdFS2EzPQGDgUDszkibHr0K73WT2JwssEG
	TWjkGdQZ36N/sSkj6PWR0kKBua2gE4Ot4dL+6BpMUgfoVqmgRbkK3f4SXZgXUYX9vN/XRuBrY+S
	PqyLZ83FFXRquDs0CL2agNO2MzhRZy4xRfGCpGoe+/MJa+ocCGpUDLytArZ5orppEcihpsHow7g
	9qSluDicofmTsIzDl0QfN7qi3QW93edzjHfPx7NmSokRy9AE6Q+H+0s0K2rJJsNANUZ1UpV/
X-Google-Smtp-Source: AGHT+IGoMeqv5Ug0hkm/76GxajhxbOr5rO5Bbw0UFNXDEbLMN86Q44z+6+NI5zvsArM2lPrFPkWW71wCF/3e
X-Received: by 2002:a05:6870:5491:b0:30b:6ffc:4bbc with SMTP id 586e51a60fabf-315bfd6ccffmr2989217fac.11.1756776373440;
        Mon, 01 Sep 2025 18:26:13 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-319b5dad889sm40684fac.18.2025.09.01.18.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 18:26:13 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 625463404C4;
	Mon,  1 Sep 2025 19:26:12 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5E552E41A5E; Mon,  1 Sep 2025 19:26:12 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/uring_cmd: correct io_uring_cmd_done() ret type
Date: Mon,  1 Sep 2025 19:26:07 -0600
Message-ID: <20250902012609.1513123-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring_cmd_done() takes the result code for the CQE as a ssize_t ret
argument. However, the CQE res field is a s32 value, as is the argument
to io_req_set_res(). To clarify that only s32 values can be faithfully
represented without truncation, change io_uring_cmd_done()'s ret
argument type to s32.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring/cmd.h | 4 ++--
 io_uring/uring_cmd.c         | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 4bd3a7339243..64e5dd20ef3f 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -51,11 +51,11 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
  * and the corresponding io_uring request.
  *
  * Note: the caller should never hard code @issue_flags and is only allowed
  * to pass the mask provided by the core io_uring code.
  */
-void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, u64 res2,
+void io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret, u64 res2,
 			unsigned issue_flags);
 
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			    void (*task_work_cb)(struct io_uring_cmd *, unsigned),
 			    unsigned flags);
@@ -99,11 +99,11 @@ static inline int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
 						int ddir, struct iov_iter *iter,
 						unsigned issue_flags)
 {
 	return -EOPNOTSUPP;
 }
-static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
+static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret,
 		u64 ret2, unsigned issue_flags)
 {
 }
 static inline void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			    void (*task_work_cb)(struct io_uring_cmd *, unsigned),
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index f5a2642bb407..2235ba94d3f0 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -149,11 +149,11 @@ static inline void io_req_set_cqe32_extra(struct io_kiocb *req,
 
 /*
  * Called by consumers of io_uring_cmd, if they originally returned
  * -EIOCBQUEUED upon receiving the command.
  */
-void io_uring_cmd_done(struct io_uring_cmd *ioucmd, ssize_t ret, u64 res2,
+void io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret, u64 res2,
 		       unsigned issue_flags)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
 
 	if (WARN_ON_ONCE(req->flags & REQ_F_APOLL_MULTISHOT))
-- 
2.45.2


