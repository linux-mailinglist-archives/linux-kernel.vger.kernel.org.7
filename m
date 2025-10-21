Return-Path: <linux-kernel+bounces-863467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A18BBF7E70
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C4BC4E1BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF652E8B8A;
	Tue, 21 Oct 2025 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7TsF/iV"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A9355817
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067779; cv=none; b=Vle3KqDNLp/H0m7RlDUyhxghQiBwTONnKXMjtP1DSQLW5kKRRbmyxOA2oQG7UyJaxjcZpoOEdrSQleIDYY+oIwLhQbFyG5H9VvG13Abg7GbZMIFd8vBaSop6xJiksGyrC59KIlI8fnQy/NobWkeLQuuZ9FELO6/N1djShw9dayw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067779; c=relaxed/simple;
	bh=2wVoZ6J5fH+QEIqkn/CT/xdIWuyj0ZyFQwJmlOtInbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IsL3lxO1+axQNv7wtRB48LBdCueLXHQ/skz0/+Kp6PczFJ/HC9+TPsv5NaYAlrIbCdYCG6CkLF29pQTPQ1xX+D0pH6FBBIYkUkd2r3VR3GCJh7UDtEqVKRtTobcm/jWvilHtQUY8eHXf6KT/iDfHzkFuEi3pQFYV/UBACQjzxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7TsF/iV; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-783ad9c784cso436795b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761067777; x=1761672577; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ledmYIP+nkgPWwnc+uPn/2RVeKo8OpO0ythHoInBHKI=;
        b=G7TsF/iVCr3mnZc09Ic/W4NhWimyh3KhJKZIxB73Knx6TAXa+BlkwDm391Vjlc7DcI
         zWm9FbGh+cI7dJQlDwpq4LjSCs+RR5d8mzdEm1tXP9rEKuZB/7wiyYWwOU4o5P6VHyDW
         pk8ZabYJy9sCM1Okb15pllrno0b/9nWnVZSUXqRZc6XFp1pUJMlL8QSX0Al3gJC6gt6j
         dq00VF28YBjSlmmc/O1SX2Kb2jG269nvfnO5jyD1DUZB5gock9qk9slGrsS9kjEI/xJX
         Jq6rAAYRzI1UEjGXQOHLkOCiOom8aBd2LbVUenr098tny1CS3fZ/dn2F4/y4fHlCPWIN
         hLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067777; x=1761672577;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ledmYIP+nkgPWwnc+uPn/2RVeKo8OpO0ythHoInBHKI=;
        b=FjFcGhX3POKrbGzYm92apEcf8ZnsYpa533S8A+2mHh6G1v1SGqXghOdUfMwPUsm8qp
         COOLhKqcJMVbfXKGv11YodlGUd2UrweQuT+fwxCYmXAWSRws+GYiBoWfPrGxD/VrhGvD
         RD071eliVWhG8F0p9FGvXg9Kcpb7W2zFqilxVdnskZBbLGNiJ9RnpDlLZof7OsLo6fjJ
         XZNjpmD7IFsGbvnFRtnqiddqlGaR9moONJYrUNj/HH8nuGeAU8IfnkEKNEymih2I2ciW
         AQeE3dJZEe0izn5e7bVtWNTattacMWkmW/ULg/miQuS4uVK5mXsrnB6xb9X9bc4K7Qnc
         lYYA==
X-Forwarded-Encrypted: i=1; AJvYcCULQvWj4+3xvLHWkksaNlJublKP58p+iqva2NTnvMjYQvEtDlYZXCU7W6/VV0HShCO4W3wDXvFSiCDepNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRB8z77MfqMN8UjAgHPqdUugGv/VunB610fKE14W0RUBQz6zS+
	C9vztfoPYghhg/UYj7gtya16Km3uk3QYh28EV/leinzqpGj9xUxwLtYv
X-Gm-Gg: ASbGncsvVRqHgapaHXuGyxLrr4Gfbw53c9sSyR0xd0Y5hiK6IsoDtZn+n9xhe9FIB5e
	MzSFcrVgutGD2VnHeirZeOU0s67u1a6x14saym9EsX6buEN+8zW71DtnZ3H+ZlPxsQTUB3SAuP6
	M+iyAfhJ1BV22/kZJOsSHGAAgX9uKTeB1iAF96zkP6K/UKdItOXQdrr3AZ54COADK8eBFkl1NdI
	Z2CMauGKGtULd+PXbrVc+O+urU0KaU0gSashCLRc7jOQEmelzLZAujIYJwL6ijnrzzDkyleBwoi
	vUjJ+eUl04BahaoukvA/aq8r0EMhFii1TDZ1qe+waJR7BzpAG+TtVBX4r5y0SOsD1L9qvHn5eYF
	Rfx/UxpCG+VkXgG3c9v9MAO10p4m2D5pBwoo2ML80i0HLy40fqjXqb9TxgevFPzl/XAZT2fo1OV
	cc5M8PY5eODqEIbCDjJwO0SpErpEKwt5icSqn7ZUmKhyX71FSiJasY
X-Google-Smtp-Source: AGHT+IFieAhnyzYe7C9i/6QLJHNCpOIimwcmOCoBd9pXtYP+sFSff2MZW43lZN1M6LJpjGGJOhvAqQ==
X-Received: by 2002:a17:903:120b:b0:28d:1904:6e77 with SMTP id d9443c01a7336-290c9d26917mr108005465ad.3.1761067776768;
        Tue, 21 Oct 2025 10:29:36 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:c8fb:fb07:e608:6e67:4b89:c950])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5794sm113695615ad.53.2025.10.21.10.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:29:36 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Tue, 21 Oct 2025 22:59:30 +0530
Subject: [PATCH] io_uring: Fix code indentation error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-fix_indentation-v1-1-efe8157bd862@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPrC92gC/x2MQQqAIBAAvyJ7TlDDqL4SEZZr7cVCIwLx7y0dB
 2amQMZEmGEUBRI+lOmMDLoRsB0u7ijJM4NRxmpltAz0LhQ9xtvd7MoObWhNvw7KauDqSsjKf5z
 mWj9RO2YQYQAAAA==
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761067774; l=2084;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=2wVoZ6J5fH+QEIqkn/CT/xdIWuyj0ZyFQwJmlOtInbM=;
 b=HefC25msrxAxBwPPYJyL9S8c9tZbseSOly0CeGYXVusAuIzknsQnZeBHU714jZNgfUl+NrG5Z
 Z3d508W9k8gDQSgYkRaYxXU/QVM+P/YIJsIQdfJ4bdFJDdlvR27Ad/T
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

Fix the indentation to ensure consistent code style and improve
readability and to fix the errors:
ERROR: code indent should use tabs where possible
+               return io_net_import_vec(req, kmsg, sr->buf, sr->len, ITER_SOURCE);$

ERROR: code indent should use tabs where possible
+^I^I^I           struct io_big_cqe *big_cqe)$

Tested by running the /scripts/checkpatch.pl

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
Fix the indentation errors in the code according to the coding
style and verified by ./scripts/checkpatch,pl
ERROR: code indent should use tabs where possible

+               return io_net_import_vec(req, kmsg, sr->buf, sr->len, ITER_SOURCE);$

ERROR: code indent should use tabs where possible

+^I^I^I           struct io_big_cqe *big_cqe)$
---
 io_uring/io_uring.c | 2 +-
 io_uring/net.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 820ef0527666..296667ba712c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -879,7 +879,7 @@ static inline struct io_cqe io_init_cqe(u64 user_data, s32 res, u32 cflags)
 }
 
 static __cold void io_cqe_overflow(struct io_ring_ctx *ctx, struct io_cqe *cqe,
-			           struct io_big_cqe *big_cqe)
+				   struct io_big_cqe *big_cqe)
 {
 	struct io_overflow_cqe *ocqe;
 
diff --git a/io_uring/net.c b/io_uring/net.c
index f99b90c762fc..a95cc9ca2a4d 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -383,7 +383,7 @@ static int io_send_setup(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return 0;
 
 	if (sr->flags & IORING_SEND_VECTORIZED)
-               return io_net_import_vec(req, kmsg, sr->buf, sr->len, ITER_SOURCE);
+		return io_net_import_vec(req, kmsg, sr->buf, sr->len, ITER_SOURCE);
 
 	return import_ubuf(ITER_SOURCE, sr->buf, sr->len, &kmsg->msg.msg_iter);
 }

---
base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
change-id: 20251021-fix_indentation-6e5f328b9051

Best regards,
-- 
Ranganath V N <vnranganath.20@gmail.com>


