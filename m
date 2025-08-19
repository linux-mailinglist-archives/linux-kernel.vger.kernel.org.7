Return-Path: <linux-kernel+bounces-776245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB3FB2CA86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51501899363
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9BD304BC7;
	Tue, 19 Aug 2025 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="1GrBkpa+"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000F304972
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624355; cv=none; b=JmK/pjYGaJDhHkwlM3YBhF8ssF6NYwnRIUfDzSlaGiCd5/joAGwVu3rJimb43LgOxOQp2GeBtTeHo1v9ueeGI/9Bem23GAYDW8H9bmk/hu+4v1putEFwrRcU/04YSVVc5O/RJOvDT9IjWzNK0bWoPZvTikUFf3G8uLqGDPvFTdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624355; c=relaxed/simple;
	bh=GBV13FKyir8kfypxR26CrxL7efucypvzQsqK+fC/kYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfJ6L2b9B7lOUkUsCibWiTf8GcNLzSE0m/g+N4d1Uef5F3qQ5+rMsyV+Zes49RpenBPxJLr6xFOMJSo/ukI6U+bEovl2zlQ28RR0WZenS4L5LQSccVjORG1ryZ2wgNW/bnnMFzWavwfhK1HjElJbkAEa9zA2qkos/dQmEP8fgf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=1GrBkpa+; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb78d5dcbso787684166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1755624351; x=1756229151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KjoQco34wnq0FWx62tALK2m6MwiEYH9uCLBDH7Ywwg=;
        b=1GrBkpa+Ew5GESYlvubKkHRqYeJca7zR0fAcRDq1OujD8g/04u8mcrJJpQAxGCRi3n
         11rfGL9ETIW8vgRE3qqx/U1mIwxAbdlk3R4JnrH7SW46d2ttcjwoAc2SfqM4Aeah1CZ6
         Po6i9ok0VPN0aptRfVpNuP6IkD10sBY4ueKZKafiEVr0dqtxkFy13/j/qdCIhdf8R5j7
         TDKEXdUMpckOqRZOIUZBLF4C50d08fRPeY9zDRnMqUnSq8+T9Ft7NQfX2304Z2GV0pZt
         2xTycYEB1M/envRt/+Tai6kfZxBrL/k32t0T+MG1x6Ial2hjHdLGm3uNskfJlmD4Dai2
         2kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755624351; x=1756229151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KjoQco34wnq0FWx62tALK2m6MwiEYH9uCLBDH7Ywwg=;
        b=k5tPZ/BWrJMUx80XKpLXXEOA9wYCTE7J/wvASjXCwNumLe7YLwUhBEjUneab0g0QNY
         aVDdMcGNkugEda8Cdgqf8y1zw+BmPl/bIihd/SzkQ8nHLO3tqsrTBTVPdZQL32m6dpuA
         l7tiEwWeZjzhizDH/Anx5qHcBt09FwXkqM0T04LIEpyVX6NRP2y9oEdCyo54WY/qkvrz
         ruSFWyYK8clSQ+IY0+cOLgB5IqouWx1Q7f/gwKXMZpHSMTa/Lz14UeAvp8B3nQPa3Xlr
         7oIUOQ8utrDuL7o3GVkcVAYKj05gh3skdjCMWdiop7uy9ivU2F/sUQRTGyFW9/IP3xVw
         8YSA==
X-Forwarded-Encrypted: i=1; AJvYcCVpqwqENvlCUMwypC/7YBF2pNVfBKwHFKbWyFyrDtrN3HE7SJD2U21evMVZFV0NObstq2E79Da7RNMYiXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkzkJkY/qrrJq2wCIVw3pJHxY3oCSdgFzyMCK52J//6oKKiYdf
	qV/juirKyIGTC8ttHn3p2TkcVKuhgq7k4b/SdPxWGUtf0SPVuvMpNFMWwflTqfoNlV4=
X-Gm-Gg: ASbGncsR2Y4iLXnyekbtSUU+/POkMiRmf49PAZas6T0x13lBJpV5GlnmKmhsDVX5KS8
	MTT5oNDKC4BVWcKyZZgSlKMXjOh/+eGZpARkSLaNcXNll1GDtIXkJkVJ3q8lJtgieiUZcvbAz6P
	X5h8V/Rj7krcRUXy6yk4ES5VR36Gxb4ADBg2xTudE/RzWcgc1ok/3ZPTJIyXq7xyq7uF9BBuSZc
	+RZYTvWLiUEgw0naAbQJbyfrwFL6wrVr+JfYYWMQON1niUMesYTngtyXfXQOkIxfp5hse3+SxlW
	OX3I/1uUA4I9M5KLFYucJCo52GxSXI55wPGuA/7b+vydymQ3fD9pTRlTCrgL0mQwh7DN9AbgcJL
	KlCisPstfTkfhrDa2xLpKDZ6S2HejcxrZtThPf/VqLPvyos3IPSZHH58zj/WLWVX1ivfqd4E=
X-Google-Smtp-Source: AGHT+IE5AjGUKwAZkNWCiL2ZU44AUNHMlXyejjcisiBbclf5xRlDqp3F/kYCU1CMxsOc/0mV5vXxNA==
X-Received: by 2002:a17:907:2dac:b0:afd:c0fe:b6a3 with SMTP id a640c23a62f3a-afddccdcc90mr302942666b.29.1755624351040;
        Tue, 19 Aug 2025 10:25:51 -0700 (PDT)
Received: from ryzen9.home (194-166-79-38.hdsl.highway.telekom.at. [194.166.79.38])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2badd9sm18648266b.20.2025.08.19.10.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 10:25:50 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: yanjun.zhu@linux.dev
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	philipp.reisner@linbit.com,
	zyjzyj2000@gmail.com
Subject: [PATCH] rdma_rxe: call comp_handler without holding cq->cq_lock
Date: Tue, 19 Aug 2025 19:24:27 +0200
Message-ID: <20250819172427.645153-1-philipp.reisner@linbit.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <e0f88ef5-b046-4128-8c81-ce3c7e20274c@linux.dev>
References: <e0f88ef5-b046-4128-8c81-ce3c7e20274c@linux.dev>
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

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
---
 drivers/infiniband/sw/rxe/rxe_cq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index fffd144d509e..95652001665d 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -88,6 +88,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	int full;
 	void *addr;
 	unsigned long flags;
+	bool invoke_handler = false;
 
 	spin_lock_irqsave(&cq->cq_lock, flags);
 
@@ -113,11 +114,14 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 	if ((cq->notify & IB_CQ_NEXT_COMP) ||
 	    (cq->notify & IB_CQ_SOLICITED && solicited)) {
 		cq->notify = 0;
-		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+		invoke_handler = true;
 	}
 
 	spin_unlock_irqrestore(&cq->cq_lock, flags);
 
+	if (invoke_handler)
+		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
+
 	return 0;
 }
 
-- 
2.50.1


