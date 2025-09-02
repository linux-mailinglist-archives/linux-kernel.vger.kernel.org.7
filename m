Return-Path: <linux-kernel+bounces-795427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DBFB3F1EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D078482762
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 01:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2584D2DF3EA;
	Tue,  2 Sep 2025 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VvrkGPvZ"
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1235C19E97B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756776813; cv=none; b=n1iokcUQJ9D6qZiaJpIdBj2dgW1Ef2z3zBSS+BONx8aNMtIHT5YO4WpA9boLzdM4qaXubxVfBYuGeXJ3SZrIk78spUnC3NJ7Z5SYBWbwsMc+R70VaMIkcazi8pWs/V9CGwolbJGnfKlWg5mTqZuLjiXOfhz6SVkVvM1iDeqtOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756776813; c=relaxed/simple;
	bh=2YsAuU9Q6pFZYBD4YIVLPsPJ6+ZyQoKmksaP5ZOibHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mp+hdDcSHqmMF+5fVmoyKRNmFzazVXs2uXhugTKCc5MbBX5gIUzM82tShLjKCK2cAvtpqfGy8e3YomibKLnnICWQTVb3I541bo0UQB4Si2Ud1BPOZCdOHgqwDN96SG8UlZ6yJgKVQYfl6s1pJR0Rgw9qqAzdVlt4T++K2InuLs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VvrkGPvZ; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-771e6d0c140so90837b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 18:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756776811; x=1757381611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tApxxDHtl1zCXhBCC76r6xxWiaU0tPGEcHjM+O4IQNw=;
        b=VvrkGPvZNziWc27vjL0LKr+QFMmWC0Mic0iY7oKKgUNfFvWps8Hgk3QLb29iQGmToq
         CBKIGUZ9R71MQEsheTOF9j1S4GkjYS8HB7UlxY56G7u3tq6ew9f8g2N/IGrUbTJ3HQ34
         Rc8AFUfMtbK3HXh8Sn3YQ6RohG/rGPd/QCZfUqxWCvF0REUf3MxekwboJrT+ARpUnjsE
         QXF1x+aAUfRYqYFWCm2K8rigeqGULioDaj9PbXdawrhpBN6VJ38Nq22BzpAD94sg4gsW
         mmijf84AAnXoVUKqAhhFC30uPcOWF1Hg2DAw3cWeondMrc6wD1vlT4RBuSC+vGdEm3OZ
         4P2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756776811; x=1757381611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tApxxDHtl1zCXhBCC76r6xxWiaU0tPGEcHjM+O4IQNw=;
        b=uveCMYa70yx4/KhVzIndJK7tLFbz4MolNO12IrqoocAVB8ywvCqZTQnZiCqssrufKW
         bYB4t87ZmFCT76u19iPxBA81nhY2Zqo/8+Ng5DMKEoBciQqXfdsHuLlWdsBmUX9ifP41
         rn7J6ZI2qziiDx+2KiMCg5fx6d9SxJaRzOw+nbpNYilTcORuCd8Ts7dJ2g+J1ScXFvOz
         qP9/K0UT1h+Zm3F45LAdiZy/jpkJvVYjp5PTFILRHMFMRPJGcWTqlJZLEflsd0GwmuoP
         UV8Rzm/QPpJl6UCGoYKO1UBKAeIo6BRpS65m9xwMcy6YkFtPmknVa19oktLYUYqHKq4M
         oV1A==
X-Forwarded-Encrypted: i=1; AJvYcCWAGsUto5gu3zsSdQfT1xVTcu9+c1eitl9rF/hxhdUUFdY/fMlwosf1TjLVjDQICSEIHDeTpqpfLjE8Qlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydO/QQ2aPa9uu67GGN0IQxCFJ9O88IGpE58yVSF9KHJT3C3QA3
	u6b9pCdZHGZFw+aPfScbSEYxdb5hh3EYWQpTpyZ+AmwFd+0Dk6yripSA0jJkZTdk4Dl2yWTJ0QP
	M3Va8yrSv3Rlz5N55BxY6jWRZ66pYVrisb62w
X-Gm-Gg: ASbGncu4WXRvP6yNuLDY2hgtGlMTc1ceHK7+kpFlJ2Qf45mjymOL53s3fn0fvl4qf7U
	1R6dz1IM58s3SyWwC/v+JVS31qTR4/TRR9N0PuPg4kt5v0uYrzyBX29A3eOPJpBhfF7K+ECGDKa
	P4fDu1r36J+y1JdEUQP9JmFZp1hDlvO+T4arj2ujTasyB2WJQVRXNQ27it1fy8Ysf5BjRy7JK7F
	cearoC1ZolzNus2VcBYuHEEBBcpyJdfC5ADeb7RNxrK9Xm3r7Ee6Tg/HueSpirJUkEFGavCO7r/
	CKhVN/+g7D4crEkZ6YiyN1BVF2+I4e8JAOf24207/OPKt/cbsMWby9bKn6godjxzDIwvMfx4
X-Google-Smtp-Source: AGHT+IHU1FqiL7D/IMH3xDzyGN84Oykg//qTxXsV/RSMqcFDXgJplTBnuFFO+SZlIBfrd/4KNCwO0v3MoUcT
X-Received: by 2002:a05:6a00:2193:b0:772:5fb8:e398 with SMTP id d2e1a72fcca58-7725fb8edbcmr2836966b3a.6.1756776811206;
        Mon, 01 Sep 2025 18:33:31 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7722a4c8d8asm666100b3a.14.2025.09.01.18.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 18:33:31 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8A0EA3404C4;
	Mon,  1 Sep 2025 19:33:30 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 87DA2E41A5E; Mon,  1 Sep 2025 19:33:30 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/cmd: remove unused io_uring_cmd_iopoll_done()
Date: Mon,  1 Sep 2025 19:33:27 -0600
Message-ID: <20250902013328.1517686-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring_cmd_iopoll_done()'s only caller was removed in commit
9ce6c9875f3e ("nvme: always punt polled uring_cmd end_io work to
task_work"). So remove the unused function too.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring/cmd.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 4bd3a7339243..7e38d4512b6a 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -128,21 +128,10 @@ static inline bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd *ioucmd,
 {
 	return true;
 }
 #endif
 
-/*
- * Polled completions must ensure they are coming from a poll queue, and
- * hence are completed inside the usual poll handling loops.
- */
-static inline void io_uring_cmd_iopoll_done(struct io_uring_cmd *ioucmd,
-					    ssize_t ret, ssize_t res2)
-{
-	lockdep_assert(in_task());
-	io_uring_cmd_done(ioucmd, ret, res2, 0);
-}
-
 /* users must follow the IOU_F_TWQ_LAZY_WAKE semantics */
 static inline void io_uring_cmd_do_in_task_lazy(struct io_uring_cmd *ioucmd,
 			void (*task_work_cb)(struct io_uring_cmd *, unsigned))
 {
 	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, IOU_F_TWQ_LAZY_WAKE);
-- 
2.45.2


