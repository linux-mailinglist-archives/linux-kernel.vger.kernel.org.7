Return-Path: <linux-kernel+bounces-856255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6252BE3A39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A7F1A64622
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10CD1B5EB5;
	Thu, 16 Oct 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvJPDUpF"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2643D81
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620622; cv=none; b=s6F8Wifv6KdaKAz0nOEA6MfPwVsxbfLyd+P0nbyFnAV62d/SLZ8MSJiesbo7k6AJT+8DtO/307feN3ij/Q9LkXL6pjrDAw3zvIjdtLHVMyeJJM8J5OJHPuFro3iMTQI3tX+Uq+4MR8bp8jxdt4zPPzUqKzURMX28vHmyjx6mAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620622; c=relaxed/simple;
	bh=eA/H0JjZIi16i3hB1JBivKY43jyl+6t7aDUpWUSlrUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4x1C7qzIctOucjgU2VT2slklTu6dX/q/8UOL1Rw1iG/2PZBucKLtKapl5E67LIjiRjL75GmANIoe4G5QSLoJKreQswZ57SLdv26BFd3IxGVRtagM8XDlobfdhUOybylcR5EKKYvSVXPnskuutZsTgTN5IYeY9WFnAwVY8Kq1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvJPDUpF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b62ed9c3e79so472882a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760620620; x=1761225420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W1MfRk6r556ZbNsjPPtcCWZtiAMFkNsr0vVSVYA67QY=;
        b=DvJPDUpFCQ7s2j1/R518nCANsBs+Us/ps7T8m9KAQE2pMIKfbT985+KLRJ42brSm4w
         elbLAva93WA6+/6kjdYiNxhIyG6Fn0ZXdL8atP/C7h2LXFJeMZupjRMI2c56tvi8uo9X
         k4QSPMgHU+m+ooHCaL8c//ipKP6OWQVhE8/IFFCqaZ8aj6GKLcsiSOo0am/QVXOVN+1T
         yW6EY2/MLPEDqyOZ5i8Af6DeP0E1EKaEXbLBnlBzOcN0smidAeBl27YePAnZd3dHtG3D
         WQ6b6DKBTEgizukrRscujrVz83CP1gH36Y8rpFZ2MDVQ/fYmsKZDhvUndyPoOJGo2M1n
         8D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760620620; x=1761225420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1MfRk6r556ZbNsjPPtcCWZtiAMFkNsr0vVSVYA67QY=;
        b=fEa2wjpX0fJ5dyAim4r/8pNYGTwl3PaRuJxWwZDpeNI1k0kDWDosrmOcTUWGLEiGt8
         bjMhD/+GVHPHiFb/7v9B15JB/vI0k7ceg0UqQMfskj+UnVF+D3TGPwUz0gGjtgX9cf5C
         GIc9xsaCI/TCEjBCkL6bxim932+n15aCxavCyQhTeSLi5bQIjwgU82tuqkzASGAOZg3x
         ZipQApjQrAh7b7k7gL0kOI7GPHfK0yGiO0e3U/UN69aWCm33spODQdmQigEEZGFwcPIA
         jTTl+aobmYmEAOjEXWxtdOxYv60ytzOnUVA1+nTiuz9IVPG/xoJrFaYMJkD+5wVIKVSS
         icpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbcFRfLqhyZ1OArQYEWaXMmMzB8VIKsdsJakUeAyB/RgOfID5S/GjROY4V81MqwPfFtYVQ611J6VhHQMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwHimpSsiOYPnXfM8jjUyDH8pA1JRsNGGWdvSfexKKbFGp79n
	JqO9yuTRUufNjh6x0kE1KJGS4vL5WurXtlZJutZo1I6lZONttx/jwOqY
X-Gm-Gg: ASbGncuKXi/dN8marUC7cNHcqYhyAuefyCGtjHziM1aUiwh0CVjckVD4Ot6kTgXmhiS
	12q78KkIGJJocJG4J3yxNn1xin1m908v/CSU4TTG5Tcemi1PMloxvbrmuoz9i3jE5cGWyl6Umi+
	a3gQWflR/q+B7sFAslXImQmnpLjxjOmXuei8ioM9bvL7N8a2tx/zcSulT/EjNpWzj4jju/JDVAp
	mMIwF4FjAwY4UKON5jR+cASQCSXl/Vrh4WgfW2kgaL9SXMgoEckCnwXKRump4EPBVpclZWUt6zF
	gGyB9k7PpyJ92aQLU/rFXHx4ZrFRdW8iNHMYC9u629m1XYDfHbYdCx+tVe7Nmo0Qk+Jhx2xeU1c
	gXRuceaEz05SsiMOYuMjoS47eaoaSlXnJtbXH9LmJWxmomWWh0HQp+9f/+ZBnqc3UMAyQrwYv8i
	IsfvQYNK/YAWmog1615+AbHj+SFA==
X-Google-Smtp-Source: AGHT+IGpJWJBke8Eix07HeJb4e0916GUKsSHOfEgzOggrPloynIzFzloH8zDLF10ETHTTnAow8JnOg==
X-Received: by 2002:a17:902:ce11:b0:27a:6c30:49c with SMTP id d9443c01a7336-2902739a207mr450211305ad.27.1760620619817;
        Thu, 16 Oct 2025 06:16:59 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bb6522fc6sm1942340a91.2.2025.10.16.06.16.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 06:16:59 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk,
	dlemoal@kernel.org,
	yukuai3@huawei.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH] block: Remove redundant hctx pointer dereferencing operation
Date: Thu, 16 Oct 2025 21:16:51 +0800
Message-ID: <20251016131651.83182-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengkaitao <chengkaitao@kylinos.cn>

The {*q = hctx->queue} statement in the dd_insert_requestfunction is
redundant. This patch removes the operation and modifies the function's
formal parameters accordingly. To maintain code formatting consistency,
similar modifications are applied to bfq_insert_request. Changing both
functions' parameters to request_queue also improves logical consistency.

Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
---
 block/bfq-iosched.c | 5 ++---
 block/mq-deadline.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 50e51047e1fe..b0e2fe645c3e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6233,10 +6233,9 @@ static inline void bfq_update_insert_stats(struct request_queue *q,
 
 static struct bfq_queue *bfq_init_rq(struct request *rq);
 
-static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
+static void bfq_insert_request(struct request_queue *q, struct request *rq,
 			       blk_insert_t flags)
 {
-	struct request_queue *q = hctx->queue;
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct bfq_queue *bfqq;
 	bool idle_timer_disabled = false;
@@ -6298,7 +6297,7 @@ static void bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		bfq_insert_request(hctx, rq, flags);
+		bfq_insert_request(hctx->queue, rq, flags);
 	}
 }
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b9b7cdf1d3c9..86b888681552 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -646,10 +646,9 @@ static bool dd_bio_merge(struct request_queue *q, struct bio *bio,
 /*
  * add rq to rbtree and fifo
  */
-static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
+static void dd_insert_request(struct request_queue *q, struct request *rq,
 			      blk_insert_t flags, struct list_head *free)
 {
-	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	const enum dd_data_dir data_dir = rq_data_dir(rq);
 	u16 ioprio = req_get_ioprio(rq);
@@ -707,7 +706,7 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 
 		rq = list_first_entry(list, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		dd_insert_request(hctx, rq, flags, &free);
+		dd_insert_request(q, rq, flags, &free);
 	}
 	spin_unlock(&dd->lock);
 
-- 
2.50.1 (Apple Git-155)


