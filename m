Return-Path: <linux-kernel+bounces-833123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54358BA1466
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE266C0CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E5231DDAE;
	Thu, 25 Sep 2025 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="LfT0Ka3M"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931731B829
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758830239; cv=none; b=FAnt/l8ducSD3P/D1k4ZmHiMtFE3fv/ers0mIlGV2ykBq4/NLpx9oaGRR2dyMWKQuimbgzRFs3fsznmuY458CCr6pz6MdzeDjijt5L/GhEha81rR9nr4Ad3Mg7LUvhMZYTSoFCLy62rx1w9zYb3zDQg/REy/g/1WTq4JpqAC6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758830239; c=relaxed/simple;
	bh=ceHH3IWiGV3BdvhtaHzZJ3H6fS+G8Ki3Bma+PJK8TBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4l3DbSEDvFOl3N5CsfZ4xzyKt0IhwzaELX5xlB3peWAqN4V2LrrEcNlYkZJilinClc0CTBaNRTyD5NQcC6f99oRPSd09SefXoXX8nmVpB9FmAtnpiEgoQkx6nK0++J1uy2YADmdMJAajp5g0sv8QUm7CukWsJbHApVCg4BfHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=LfT0Ka3M; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e30ef74b0so10002065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1758830233; x=1759435033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8t1cmbuldlzF6KX2Rqj5ZAm/oa7fTEbzdh+kEVZm6Lk=;
        b=LfT0Ka3ML7xs+oahrSNfRh9zr1C8DkrLGj7t6XLQUocaj150xZxBxGTHfr2L4IxPLR
         yuq5KQpztYJnzfIo3Inpunj5Be2aTJQFcPk4Lcye+TX19C135kg8Jp5K1ABhCdPEbpCF
         cGWeJC53cXKoyjeLEBZSdNJ1fFOKeovFIVigOs5D1sJlpTUj43bUczAGp3GFiC3NYBmO
         mbXSqu5F1RsvgeJFkGMCoM5LTutx31i//K1YYs5DhbuyVCj4uywqYHyWYcBFIUq0vd7c
         v5uphJj1zYzsPilmo+WPJhuG4IfeOUptHjobVnUxfXFtrXOwG/GdmlV1tEz9QIWtt+Go
         tW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758830233; x=1759435033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8t1cmbuldlzF6KX2Rqj5ZAm/oa7fTEbzdh+kEVZm6Lk=;
        b=r19i6qakDR2ZslrlQSIflc1SrvuVAuzUqQr80f598e3Ai0EoU4ZM/CG7lqgDqzkc/c
         GiHgx1z0f9nDl5syvSAhaITaB9qWdQrZO1vAsoabS7QOFqhy8dYr9QDg8TvXpvOnkH+y
         TbaykK/qJk/1dmdrOvqIaQFntc2QRnM3h1r+nqvuhZWHTSwaeYBey5zu/2o5DaQ/qz0I
         FOZtSG5/dBC08Q71uhrmKOHErHHpvDTp7OLKKpgZXpva4sL//+oFQ3wvJ8OSWRloXKCO
         bpTMoNiF8hmhK0XTZ8fGZXkkWNu62XyPJlGhq+E3WR+m4dhx4GqA8v1ho13nhMwVQOqx
         lstA==
X-Forwarded-Encrypted: i=1; AJvYcCWhiUDZ+XTk30U47IoSRUfvTQoPvLYukJE3ZS0a0xr1Nhiz18Q4FFkbGVNyGWiUtd2le/grN/ediH4qWsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvOmlAy4c00Gdy6OKChv2n4xZ0t8VyKEANYkqUZ26gDy+p37oI
	yw1XPRSklJ8PwF9kBxWRchnAaZJGJoGLB2sPgEjd4izS4xOahmgum5VoZ2I5irBGdbw=
X-Gm-Gg: ASbGncs+rlCV5m/dzR2luojWY06pWEApz6p6c1wKSKPg4oQhL5TJMoWr9NEGoLeHuQ1
	A7u4yBVwBd0I/CTNpGCfAa54D/h/D09A5+H5BdDNC77nX0qY1/ZchW9hm9TmZzg3vG5Yb6oReWJ
	XSD0Q/ccb7NSlS6jjj1Zw6SnP9eyV9eAsbC6X5SFG4QI5skuA8wobcDlj5pzfEkldtsTPITXZYB
	o12CpuvmVUwnBen9JwGMmjithUx5793eftTkGqSlzvdRFqQoPz5mhBmcCMhEhkyruRXySmYZRxI
	rWXboDwVOythnssewmd0S1PbhkJCmH2xSBdBnj2MFwz/KYW5+EoWuuRpEd8FTiCIrHfNj1tbsS5
	lsQ==
X-Google-Smtp-Source: AGHT+IGG4rQpAEs3KSwr2soh9X6HBNwrl1IFW/ev8oiIGHxU/rW0RIbLhVcfR2nFx4utAhjntsi3YA==
X-Received: by 2002:a05:600c:8a1b:20b0:45b:43cc:e558 with SMTP id 5b1f17b1804b1-46e32a185f0mr38233895e9.35.1758830233153;
        Thu, 25 Sep 2025 12:57:13 -0700 (PDT)
Received: from fw13-phil ([80.149.170.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33baab12sm45507565e9.8.2025.09.25.12.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 12:57:12 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH V3] rdma_rxe: call comp_handler without holding cq->cq_lock
Date: Thu, 25 Sep 2025 21:56:40 +0200
Message-ID: <20250925195640.32594-1-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the comp_handler callback implementation to call ib_poll_cq().
A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.

The Mellanox and Intel drivers allow a comp_handler callback
implementation to call ib_poll_cq().

Avoid the deadlock by calling the comp_handler callback without
holding cq->cq_lock.

Other InfiniBand drivers call the comp_handler callback from a single
thread, in the RXE driver, acquiring the cq->cq_lock has achieved that
up to now. As that gets removed, introduce a new lock dedicated to
making the execution of the comp_handler single-threaded.

Changelog:
 v2 -> v3:
   - make execution of comp_handler single-threaded

 v2: https://lore.kernel.org/lkml/20250822081941.989520-1-philipp.reisner@linbit.com/

 v1 -> v2:
   - Only reset cq->notify to 0 when invoking the comp_handler

 v1: https://lore.kernel.org/all/20250806123921.633410-1-philipp.reisner@linbit.com/
====================

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_cq.c    | 10 +++++++++-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index fffd144d509e..8d94cef7bd50 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -62,6 +62,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 	cq->is_user = uresp;
 
 	spin_lock_init(&cq->cq_lock);
+	spin_lock_init(&cq->comp_handler_lock);
 	cq->ibcq.cqe = cqe;
 	return 0;
 }
@@ -88,6 +89,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	int full;
 	void *addr;
 	unsigned long flags;
+	bool invoke_handler = false;
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 
@@ -113,11 +115,17 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	if ((cq->notify & IB_CQ_NEXT_COMP) ||
 	    (cq->notify & IB_CQ_SOLICITED && solicited)) {
 		cq->notify = 0;
-		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+		invoke_handler = true;
 	}
 
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
+	if (invoke_handler) {
+		spin_lock_irqsave(&cq->comp_handler_lock, flags);
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+		spin_unlock_irqrestore(&cq->comp_handler_lock, flags);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index fd48075810dd..04ec60a786f8 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -62,6 +62,7 @@ struct rxe_cq {
 	struct rxe_pool_elem	elem;
 	struct rxe_queue	*queue;
 	spinlock_t		cq_lock;
+	spinlock_t		comp_handler_lock;
 	u8			notify;
 	bool			is_user;
 	atomic_t		num_wq;
-- 
2.50.1


