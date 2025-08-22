Return-Path: <linux-kernel+bounces-781362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4560B31196
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302565C5CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7802B2EAD10;
	Fri, 22 Aug 2025 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="w4O+TQhc"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248EF274B3D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850822; cv=none; b=VajZV5k/+aGYcDydJlPu2gFMIQG5FFFl/EfhUpuxtiRlFHmOwfAN4dXEH83a7beVnQ4Nq9pWQtWLD2fRGlojM45WRKWSpML9HRM9hJKzK5Qn4Q/vGPNrz8R9B8BaNnDWwFys9IPxQkN2tLyO8/0Do4L9KlVUi0WtmbEdgY1UeRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850822; c=relaxed/simple;
	bh=SoqeEvRyDj9xNZRwO+49resqGUPxezysRjpX7ed1NkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ui0gnCY2GacL5ecyVEkFnkWmZOfhPflm4KDLP8x7bFoBgbwOm308xs6/5gL0eGnKagfnQmmYI2YPIa/NLP79qQ0VV2arLTcTYVFN9Gx5a/E5rsGky0KRh8sE/+DHrOoprtPel2/20UxxZD+2YFHZJJjASRPyfNigJjResv73szw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=w4O+TQhc; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61a94bd82a5so3394085a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1755850818; x=1756455618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JyWZRAhQvL3ZewOrTkNRPEBR9onjx67kcalcGvlZ+IA=;
        b=w4O+TQhcQMl5lL+KvCdtNXNg7ROAM8lJ0sL0oGNYA3440gZcgxmps+YKW2o4KOZFYP
         xdzZJQdMxnGDQTKI9TOlpJYRve6IQfTHiVVlc/0Q3/wTSI5fyUwyxFFjFdzW8LQcNQR1
         8qP+sa9kXcp/ryvWWXtYmorldqBAK+6TDwkSZCHvrFPPYn05F7wniKTyvbPBkRHAAnjI
         tDhgvnMFECJoiAhSSz1fxmxDFETbm5jXh85gw/OH+mVQ0OLqWgMVNHStWwiGlq+BLr5l
         8MkeJcH16/DrJhYXKO3axP3UwNqedoiBbtUAo6bwUtI1L0e1kcN4sa6zZwxPl/pPPvWH
         HR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850818; x=1756455618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyWZRAhQvL3ZewOrTkNRPEBR9onjx67kcalcGvlZ+IA=;
        b=Ebxpu8+J6X08C7Vu5Kj40LuuRC04L12EdWMtZEtgPAxWcXUVJFIZOMHnf7iONvYNLU
         SEXA8hHRd3fdx/aSt/U9A/jYowYQLQX6WZoUmp0ulo5xCfAQ9vRgFV40w4h9pL1/40jy
         y6wREdmWRDxijnRBLnwf9EpwRw/trm8sRO1XZtlLBd+5IYm2ojCtQ+BmJliGD7kdZ2mA
         pKrA3ywNLSEFHMQ8/GS/IlfxtXPwr5Hx3ZjRQam9TkpIO++Uk1s92f5SmYrD9JZzmmsZ
         ZU/md8G4TvIQi8oSLGNgjGA2fEqEleP7XRCjwXl7sEuUy8pQH4BRlyoNnYDXkIFyqrSN
         uQ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpROcBCTKFY1APHa2af4mls7jQdDahvttNcKzjUJNXTwrE1LBKTbSCx/z5oMdV5bIo7qMq+z9nYzzQeo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGdhTm/BVdT/XqSgvQYYdqXiiencH3nBzYQZw545SE90yosVP
	HUZURW0C4KuW8mUdW2xC/15pSym/arKP01Bu7Mwe+Vf1pL++nWNv0MDiQbQquuZV8QE=
X-Gm-Gg: ASbGncsVhxSWRuATXofjxMqDjrHUA9UKoMBGrelOqDQyGMXU/pjif9K71tu3LCDso81
	RO+/ZMhx1QyUS3khoEysf/v51nJr1MQJ1FsIOtQWguvhgbYpVBJTup73CXye5o7818Dy3P8lkpK
	hkAEBCzAo/QPdI2X97YLUT6dsZt0ESgQ/sIId8NOmiqmnfL0mE1OR8xiCgzVbInMRh9++jwzvXj
	rdpdEEL1WUPLguT4bUL4C8Bwx5GkP1DpxwRhk+RPoGcmWha23QOAMAkqd5S5vVmqXoJjpBPQSb5
	CrzVdYnZlniTY9p99hpk0wqeSuP/TmoUvKwrIrk+eLbLHhM7QJsOs8HyzZ4jV0yoLHVIGXo+P59
	nXE/Iuu+oM17HYWh4NGnTz57p54pLcvrZXlHnOD/irAXbcG7RwyaxY4pn3765lo7ZWU1z6SAjLv
	zGsYWdCw==
X-Google-Smtp-Source: AGHT+IFlbHv8xDZAAC640GMgCDpBsfF6zlAzeggthwP5mZNndc9mGjlmfC4QW/vbdALXrNy2SS/1PA==
X-Received: by 2002:a05:6402:5187:b0:61a:89aa:8d37 with SMTP id 4fb4d7f45d1cf-61c1b7134ccmr1679703a12.21.1755850818338;
        Fri, 22 Aug 2025 01:20:18 -0700 (PDT)
Received: from ryzen9.home (194-166-79-38.hdsl.highway.telekom.at. [194.166.79.38])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a761f2599sm6538432a12.5.2025.08.22.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 01:20:17 -0700 (PDT)
From: Philipp Reisner <philipp.reisner@linbit.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH V2] rdma_rxe: call comp_handler without holding cq->cq_lock
Date: Fri, 22 Aug 2025 10:19:41 +0200
Message-ID: <20250822081941.989520-1-philipp.reisner@linbit.com>
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

Changelog:
v1: https://lore.kernel.org/all/20250806123921.633410-1-philipp.reisner@linbit.com/
v1 -> v2:
- Only reset cq->notify to 0 when invoking the comp_handler
====================

Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
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

