Return-Path: <linux-kernel+bounces-760710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04A9B1EF23
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1ACA6032C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DCE227BB5;
	Fri,  8 Aug 2025 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3LEQzrZ"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69468155A4D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683412; cv=none; b=uuBZ6rV5MH9HcVIu03F3ByK/vfATbTZ8xugBvFqpKIyeLBvQOhzbSbnGC24wmcehBjLHmmeVnZRyWuTft4cyRegyo+W2SyFYs00UY2NgWtNdqEd0XdY1uPr/gp7sKJWFAPFHmufz/2AaJvKsqC/ON5YSyrHrEfs/l1c+/Xj/ldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683412; c=relaxed/simple;
	bh=GVJc/wZRynwuQ6rRZT+sEMoN0AfLOSNGlxqByyDWvgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=stSgsccQKBb7K2vMyxRuIamkfXlceeXi07VlEC0iP4J8RGgeqDMcPVqqVvhH1v7cJKgSd0/y6OZCdqSV2sO/1aTJZhK5O9dBe+MPPKvkT57PLPT6mJ8B/gAKZHzBP1Gf+eBYSfvkXKFnf2ktIwyBsaLePYCbw8PUbh3es6NtSzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3LEQzrZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-459e30e4477so18734365e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754683409; x=1755288209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X8wF8pEsyzI1TAHFsJQiDAZL8Oz2FlZ7WlVS+gzTnJM=;
        b=L3LEQzrZqWU+B6+xkn+AasIvnUfKM9zkyou5p35ZyNzpQPpa9cWEwKtS5UQWuVmofE
         dwrN0XHQuiCq+UG8Jkp0Da4/RBWeM0BNLRAwcUF3hb0BO97ismnjLwKhqlkY6cmN/jTO
         vMwmaHzA5Vwr2B36xRYpxT7BV8qH9Fzuhn1qhv4pxCHCJRjNsuYpBY6BjHE5+frof8bH
         E0FtdmesmyRhAbNMU9g40y4Vw2GSfCGkBy2CdEN+9XVehMPscWl6HQAV29cJjLgTZNSe
         eCtu8lrjT3NX4VKE9PhF7LkvG1irnyahuiXK4iK2CKXN+4LL3UxKd1MpNUs2NRqdljm7
         4nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754683409; x=1755288209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X8wF8pEsyzI1TAHFsJQiDAZL8Oz2FlZ7WlVS+gzTnJM=;
        b=Hf9QJpXZn9k0EKJGSnt2htOw5KqMzHS40o5RaY0y1wwslKl+IAH8Za9KU9oyGI/3PN
         iJOn6AX2St3vZGljJmIUO/BDRo6cOdNMxNarn6JVohvsRLcPrX3PrAr7PpTfXR3PQ5Hq
         I6gCTrKwzFw57LxOrtTB39bvWo1OXbW5P7iRWFFNCcY0OkPolQsa+3zY1qIl+n2TQuTU
         BgBj9efnGbt17Jd/qZ8bIxMjfOIwi9kc5p4MSUl2lZ0mSb4esEtX1cSwqoHBIAUVcWiI
         I9XoM0VgmfhRRhgqEAXcZkFc2iMPn2mvuUNUsK3TbGLlDyxjoybX1tfl7zTlnE+lQ2Sn
         g+JQ==
X-Gm-Message-State: AOJu0Yy7F5X7vz8ZT3elmHie7RLoKaBSOVBCdqGc/LaMW5bCyNfjr9X1
	6PxBePLSikMUNvJw6GFZd1+Mr8176A+el/HLWO2pSr2DhkdhdAy3h/ZgglKILip6bZ9zueIjjNe
	Cy9Bx5k5QSxDNMw==
X-Google-Smtp-Source: AGHT+IHFiFTYIQ+EVtzyPZqEFPvTOHnwmw/5R4XWNyE+q8wVxy7SuEA1K3BWF/A/oROA0xcl2eiuy7E2ax8skA==
X-Received: from wmbhj11.prod.google.com ([2002:a05:600c:528b:b0:458:b662:fbc4])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:290c:b0:3b7:899c:e887 with SMTP id ffacd0b85a97d-3b900b4f687mr4034787f8f.24.1754683408678;
 Fri, 08 Aug 2025 13:03:28 -0700 (PDT)
Date: Fri,  8 Aug 2025 20:02:49 +0000
In-Reply-To: <20250808200250.2016584-1-jpiecuch@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250808200250.2016584-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250808200250.2016584-3-jpiecuch@google.com>
Subject: [RFC PATCH 2/3] sched/fair: don't schedule() in yield if nr_running
 == 1
From: Kuba Piecuch <jpiecuch@google.com>
To: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, joshdon@google.com
Cc: linux-kernel@vger.kernel.org, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

There's no need to schedule() if we know that there are no other tasks
to pick.

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c06a2f8290822..3f9bfc64e0bc5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9020,7 +9020,7 @@ static bool yield_task_fair(struct rq *rq)
 	 * Are we the only task in the tree?
 	 */
 	if (unlikely(rq->nr_running == 1))
-		return true;
+		return false;
 
 	clear_buddies(cfs_rq, se);
 
-- 
2.51.0.rc0.155.g4a0f42376b-goog


