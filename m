Return-Path: <linux-kernel+bounces-757733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2D7B1C611
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB4B563B59
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD2828B7F9;
	Wed,  6 Aug 2025 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="avwHcNfJ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B8D28B7D6
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483988; cv=none; b=seHtNTDHkWhW3RB7aNztYyjyNawVL1HfD/smJ2EKHw+r5zFJFzI9XbL/oTSiTfGC908Mmpr/xFOitMih+18SyrJ1m+LW/xixfNCwuezJXHBw5/12d63R9WeqX1JiC8I+nkbc9i3a+sTtwwmfDq3X7r0zZwuTaKs0LOSi9QVtAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483988; c=relaxed/simple;
	bh=swtQ9dzMq+lUac8jbN4//1GKwwI2KLHQMFCBz7s21c8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KrEZQKNhxQmbjOVwZJXdT7RX5euA43dww+qWmQc3LWyQIGmFPrFj8wl0JpcvD6/31hl4Wk69F5+U8hrDCBuVUwlEW0337CTX0fh0jl3e3fgep9U1XcyGJsHRsro+CrVlQFfiZBRlF7UmbDEPh8wst+5IBk4CB7mAF+n0GVggKHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=avwHcNfJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61530559887so9243838a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 05:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1754483982; x=1755088782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wA8sr/HIP4ajt2UgO9mOS4/xSwlrz2Jes7HFAePPJAM=;
        b=avwHcNfJRrJjS+3qJTdD5sDvNbWUmpbDp9KvVSawD9DNePWtEUyIkcC1SDNwGEWKSv
         L3w0zhjsJ882Gb24MLe5pVaaDht0UBzcSf8wePx1e2jO7cjYGWkdWXIKhNYn+TOxtser
         +9cDFLM2edDi22DQEffXSn5uIFvdtiGSJe8eLLwJIBZ2LLwAspzShp6j7gWEbxr3JVOQ
         s4WwxMDg8B4zRMhl27VjntHKN7kYNF6BBYrspeEeP7Im0163kuy2HV5Lay8W/Oo5jt3P
         iOAhLOAW75I+IFDPpgRkjLJgqVnEDwCx7cgRhTVcKw7SIUVhDy/Po61wZAbb5ceKz9rg
         VkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754483982; x=1755088782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wA8sr/HIP4ajt2UgO9mOS4/xSwlrz2Jes7HFAePPJAM=;
        b=nh7xYlER5l/ipcGObZyqAxB122EQA34NwBAKl9wlNRCeMTqhnVnRgwCgmNnANdG+CJ
         /2xr6auXXSv2KeyeYNcSStWUg1ejO2GZuZrGfk//Oh/UG5toMwZM8CQeKJEKI9rse5Uf
         wuOoDDFz+iMmxbCRfMilq4Wh70+crFqj/GzQIs07cVo6BATPcgdWoDdRdQM9/KeRX5G3
         kY8ouYTONn8TpFPdFnMT9986IFjggl0X8R1U11fPjetIdqlRIblEyei+AAgKd83XFn5T
         rdteeIrtSuLJ32uijObcKQhAB8Y1S7lFK8ol1IsG0HOA1hmChbJCJFkwJj0bi2hscJWj
         zEjA==
X-Forwarded-Encrypted: i=1; AJvYcCWRT9OL/Wgm/bUDw41eEDPHPab2njBOLC0lbbBUgfbTC+83bgPFosPRO0Knok8dtUgGbzBEdU8m5wcf7Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNM8gy3WljMyw0GX3nfq++2F42hcBQpT7sSER4x9cqnlPEvD8C
	WFiwEw87TZT6P8M+hkCbPZgdNLMTtpJ/eyomwgYm5wcNY+dgMVRR8fN1JFYCzjmB2gg=
X-Gm-Gg: ASbGncstXJZOqMIvn6snpMGviSchAn/TIOeTk5khgnGWOPaNimRTWas7+meaYKunzWt
	FXHy2bK8VLWA7XVD5XxjZoAGuzw488+/vtApFNqRqxzuz6lxWKRwJwtZTm9Q83WnRC9uFY9V/xd
	Wj3V6qhBm6701GsEmhE7lM7Ma9STnSIrfbnQMicOUs8pIRwuulCXin0u/Zk+gfElh0lT2Uc8OA4
	B4FCyPhd6ybbMAcxsYmOZZguR58N5ofibpiWy6/OXJCQy7N/Fxyb/fcSMeYi3OuXRi0O7uF44z1
	hnlqYeUP5YZlWvzMq8gWxjIIqm49cjlf1aIxc3nZCbJ8zdjMECA9M0REZvOocuZ+87s1LZI1xC7
	bpJWfCUbQD67wHViNx1jqFXN0PTyQHEJLLzCJIvwrHqHkft7lmgo4qJtUPJSf/QlChtDoZ4cj1R
	QBotOSVw==
X-Google-Smtp-Source: AGHT+IFjUN+U/CXzt3F4KjP6+H4Vt97KSUjqpR+4ZRuNCgDn+XmAU+werr9tQrf3XjecDNVThvBJYA==
X-Received: by 2002:a50:9f05:0:b0:615:e3f1:72cd with SMTP id 4fb4d7f45d1cf-617960b2dd3mr1649179a12.4.1754483982478;
        Wed, 06 Aug 2025 05:39:42 -0700 (PDT)
Received: from ryzen9.home (194-166-79-38.hdsl.highway.telekom.at. [194.166.79.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615cc38aee5sm8620934a12.3.2025.08.06.05.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:39:41 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH] rdma_rxe: call comp_handler without holding cq->cq_lock
Date: Wed,  6 Aug 2025 14:39:21 +0200
Message-ID: <20250806123921.633410-1-philipp.reisner@linbit.com>
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
holding cq->cw_lock.

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index fffd144d509e..1195e109f89b 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -88,6 +88,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	int full;
 	void *addr;
 	unsigned long flags;
+	u8 notify;
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 
@@ -110,14 +111,15 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 
 	queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
 
-	if ((cq->notify & IB_CQ_NEXT_COMP) ||
-	    (cq->notify & IB_CQ_SOLICITED && solicited)) {
-		cq->notify = 0;
-		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
-	}
+	notify = cq->notify;
+	cq->notify = 0;
 
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
+	if ((notify & IB_CQ_NEXT_COMP) ||
+	    (notify & IB_CQ_SOLICITED && solicited))
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+
 	return 0;
 }
 
-- 
2.50.1


