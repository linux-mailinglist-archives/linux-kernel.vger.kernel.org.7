Return-Path: <linux-kernel+bounces-797380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9911B40FA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8D15E64EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85FF253F11;
	Tue,  2 Sep 2025 21:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CImJ5N2e"
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997621E51D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849909; cv=none; b=SxuOnp9yk3/ORuvRnmzwh3pB0ZqblZvVHXejhM4hgBgMlCmlvTHPn2xhF8xez71lfwLeZxFotMQyZLAHAhqws5eEa9EQg1fl3z5/fZUGObyFYOvF3GYgJoI4XTe1Yc2KGwu0oCl3JkoabWnJJab3mNi93nF4pFpRPqfYu2A4Quo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849909; c=relaxed/simple;
	bh=QZwJ65JxNPKb5u2CytpFi0TWnOlDdgMgBHjgsBIYfC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bqtXhwzeBTzl0qyzzGCa4KI+U7xnbMuXonM0lLGbb3e/RwcxTrc2pgASv7g+Rseu+K0OSZDYZ8YG8niqJBS5ShBo+7juw9Avsuamki0IoBp1VYao7dXIcMcBdQ6mt8mNic3pCMzwD0v/Y72m4FpzOYjDu/FfMzwpmH5211+Hgmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CImJ5N2e; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-71ec78d0c18so2739836d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756849906; x=1757454706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOZlBcAtEanj5yYe7eggShXZAMSmi3kdQq4Ul++tTlc=;
        b=CImJ5N2eRYeGJM74LG5yqK5I+9mReJ163H0GXY4DkOTU3BaF7s6scC6DpVXvbeLjFJ
         PTfGjjM0Nj6r7FS8EMmMbVqDVrncSMristicEv6t9i6Ignk7DqBB9cEYAe7xZ/rQfhJV
         lMm526BSuwOWyDAkWGrvX4J7fQLEu/qQovrTtXFWpf6Oar+zD7lKcC1zWUDJrnO3x6ms
         Co5YjG1lxPNLBC7Az4gPgbRDk5GeV1dxjjtJN4LmCsFey5Gcrq3J1U9afJDispOuOePr
         i/2pqGoOHxqRaRT455wihbin2MxIOQV47L3Xy8NyrkXjsbNPUgLc+g1FvNmNVN8jK4fb
         AvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756849906; x=1757454706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aOZlBcAtEanj5yYe7eggShXZAMSmi3kdQq4Ul++tTlc=;
        b=lnf40TNNUlRUZU8Pk3+QkpC0koQZUdNQp41IfWQR/xL7DKRzNETwnpTUCLe2ljyYX+
         qYUHGzHX5KDGcnYmEucbSfNYjjZh6GORCFn0cPF5JMvwC+jWv4BH4El4XFqlskiJ1Qxb
         HV1UJfWeFqpT5vJMD1t/jwSjjIC/06nobkj2pXmyLcORWiFZVrLHdrkjqqPscZCnmSYW
         rYZBoxxN+o3RUyNxgpiRGNNf/SWU7cbGGlkXc2deSf/7Am9MOOYGTpPLU1QZGmUjaN01
         HqYDNZqv61KqEAsnk7U2ZzhGHnqvafAwc1X1FkKnibj0+BWtDp1TUzfxffB4lgErOtCw
         TaEw==
X-Forwarded-Encrypted: i=1; AJvYcCX9afqRvwInWero1hYjf374Yc4V9UCwuNCvVUVOdMtWmmoQMvA42+rY8DiiPDTSoaDqGE1f+KK75RzVgFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykYH68NePgnsmq1qKEDeeQ/xyG6nAhunZfZkCNDB4kIFBJ+5to
	t7djh99ThOjM7ZA+npJGZ4t/AVaACDQU0bCeZmpsdu9G4x7QPKlLIUzPIkBof4rDMk2BqGWvRDy
	zF9cujHlBMZymX/ha7eqw4pgj5XWleFmywv1Yhy0TFXbHfjKJx02M
X-Gm-Gg: ASbGnct48ATNVEzc4ABNS2IEdGfTl7xwoU9UCnakp4GqajOf8vBo4WC55j9uC+5J6hg
	vP2Nf0ezTk610JHCf/P8qXCr/40Ej/YbIXp+fYQVjfyCed5pFOym0te+tdBm5QSLOzA1JLaS+u/
	yE0yPlKctsk3i58xaI56KlEi+EFj+p6cpQALQCn5CMX7nPCvL3b4QwABs4eX1u6hWhQKDJ1t1S4
	S8d0WQhi6UQfFuGC8INvz7aMaPkvcyjDco0OzplrIN948OMzOqhc+8XtkU9J7dryzM8a/mKr5C2
	CizGx0m2ZFd7SeQzhTg6Yyse5szkfAJeZ63hnAgM2CZef7pRRzt8CsyKuQ==
X-Google-Smtp-Source: AGHT+IHZjwnPrlK2a7cuwK4+laIcrO9YM9p4cXpMMVKzY6nhXG6FkegMJ6dW4dmPQ42j+bOosCwun6Lt3RjN
X-Received: by 2002:ad4:5cc9:0:b0:722:48a9:31a2 with SMTP id 6a1803df08f44-72248a93264mr11614246d6.0.1756849906454;
        Tue, 02 Sep 2025 14:51:46 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-720b4a40d6csm1955946d6.32.2025.09.02.14.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 14:51:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CDF36340328;
	Tue,  2 Sep 2025 15:51:45 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CC23BE4159F; Tue,  2 Sep 2025 15:51:45 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: remove WRITE_ONCE() in io_uring_create()
Date: Tue,  2 Sep 2025 15:51:43 -0600
Message-ID: <20250902215144.1925256-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to use WRITE_ONCE() to set ctx->submitter_task in
io_uring_create() since no other thread can access the io_ring_ctx until
a file descriptor is associated with it. So use a normal assignment
instead of WRITE_ONCE().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 6c07efac977c..545a7d5eefec 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3890,11 +3890,11 @@ static __cold int io_uring_create(unsigned entries, struct io_uring_params *p,
 		goto err;
 	}
 
 	if (ctx->flags & IORING_SETUP_SINGLE_ISSUER
 	    && !(ctx->flags & IORING_SETUP_R_DISABLED))
-		WRITE_ONCE(ctx->submitter_task, get_task_struct(current));
+		ctx->submitter_task = get_task_struct(current);
 
 	file = io_uring_get_file(ctx);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
 		goto err;
-- 
2.45.2


