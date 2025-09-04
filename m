Return-Path: <linux-kernel+bounces-799620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE4B42E2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DA7A01639
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B777156236;
	Thu,  4 Sep 2025 00:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CTstNnlE"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F927470
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945624; cv=none; b=ks3auBokIRv4Mez5IB43KzMqwiDr2e4Q3EaUy1jzUQcgHTPOWDYGxriyx659wiy+E0vPMDL4Td5xzwXgKqSH9LgxJzD2E1pL1LLJrSd3GWo2zwXUIyb1wE7fX/3DvjtAw1toz0BsMvJQ/ozqSo/xn0v3LlgGL8jS2cRQlpiCCpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945624; c=relaxed/simple;
	bh=ABdEvvpvuwgvuJ08muiM4e5QDsv2jPFiMgTWPrKy5Vg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a+sBzZXvl8s5i3rGpur6feEsPSnqQZpg4pEfSIeVoeM61SlwBtklbz6dZt4Lfo3rz2e0bC0H5mCA+Woy/moBAWqrUCTjlrll9kjHMh+hWFZA5ps2OXTQ4W0ypq+FuZIzCcNdvI2UaTlZgk8sQp/pgdUSzXdofnEZhjOHYrYVqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CTstNnlE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329ee69e7deso377443a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756945622; x=1757550422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzeQS1i5mV6wZS/DacR1YcN49FEGOVtlP/vZpIDl+xk=;
        b=CTstNnlEJ1rwd9kkrZqIjonSewLBGJax2Eq8D9E7TlM74Je65FbvZJorO2L0i5GOS0
         LKClgQjnjxA0WrolOuhGxyZYjqwKqB5qDdeu/SzM1prosYxc9mRWwvm32SYAf6eRz4NC
         XeK5umaVzKGyR4VoP4XBak1aIbkB6IGbI52DkqF0IF56V1UHso25w8aEIu4ppqwP2gmM
         GVT7+YN2pwiVvA90jpvbpb6KmBQretoOirxIty6dkpobBPC5dPkZhWt5wMbeJJllAYIU
         CK2Rp5fc4JMzQgBkwbRCyTtctfB6735VgZrXxrIfuwHgbTsF+eUuraFlQPedzQYkscVY
         mGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945622; x=1757550422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzeQS1i5mV6wZS/DacR1YcN49FEGOVtlP/vZpIDl+xk=;
        b=OMJFpPqs8aqR32/jq0DbljMw4dchuk0DZBwPpIKTF2rXLtynQe6LRY17aa2YUAVGtz
         n2YmG3Fhff3wKX0i96OogEYZnVN7sZ/XqqR/MkeRV/GfLtVyl0cLCHKs7fKNunLrF5IQ
         IRoKHv8yFBGKI+lpgk8axjsXYDr5guGn9X31oosm7DGxFKfX1K+qHsetscdirD8hnpto
         TOCbTYiHP6e+w1Fap1sPUBwVo39AdH3MO6SYmJo0N3tIe4GH4VVK0DJyaVjQivQsi8jG
         E/Ez8ZhMyKJr1ie+KjJ9aMhzZ/3BHmFHkxgEL8hASJTFKjiDd3jG9AV6l1fJ7WcsfLCL
         IQtQ==
X-Gm-Message-State: AOJu0YwTSWfhwWwqUws2+hqPWIKhqeKPTV4DHTrQACbZrHiATRbbRrD9
	WvB12ggrHAzMo5BcTMHgXsUhu58lwh2hFeTT9ryceDS6N12tKAId9m5yp/1P2zCpG/9ss3cqjbt
	HRj7gVKHBqRR2yRiqg/ozCrWS6/XkJ1z54so8JQK2FryJysHQSIuZm5Y6MxLZLzMSoLTaqkkoec
	JCYzriXM7SF/TA7I4B/QaY5YoOS+FCn7WEEaokP/oXKNIrqTur
X-Google-Smtp-Source: AGHT+IHE5bbNfRre12BPjZXi/Emp5+hIpJxDYyuMinAQauhizKsBYnAeXMWpkRbvBm58b8qOzhn8eHMO2d+0
X-Received: from pjbeu6.prod.google.com ([2002:a17:90a:f946:b0:31c:32f8:3f88])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2884:b0:329:e2b1:def3
 with SMTP id 98e67ed59e1d1-329e2b1dfa7mr11420155a91.10.1756945622082; Wed, 03
 Sep 2025 17:27:02 -0700 (PDT)
Date: Thu,  4 Sep 2025 00:26:45 +0000
In-Reply-To: <20250904002658.974593-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904002658.974593-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904002658.974593-2-jstultz@google.com>
Subject: [RESEND x2][PATCH 2/3] test-ww_mutex: Move work to its own UNBOUND workqueue
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

The test-ww_mutex test already allocates its own workqueue
so be sure to use it for the mtx.work and abba.work rather
then the default system workqueue.

This resolves numerous messages of the sort:
"workqueue: test_abba_work hogged CPU... consider switching to WQ_UNBOUND"
"workqueue: test_mutex_work hogged CPU... consider switching to WQ_UNBOUND"

Signed-off-by: John Stultz <jstultz@google.com>
---
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kernel-team@android.com
---
 kernel/locking/test-ww_mutex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 20f509ca17e16..11bc467c286aa 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -72,7 +72,7 @@ static int __test_mutex(struct ww_class *class, unsigned int flags)
 	init_completion(&mtx.done);
 	mtx.flags = flags;
 
-	schedule_work(&mtx.work);
+	queue_work(wq, &mtx.work);
 
 	wait_for_completion(&mtx.ready);
 	ww_mutex_lock(&mtx.mutex, (flags & TEST_MTX_CTX) ? &ctx : NULL);
@@ -234,7 +234,7 @@ static int test_abba(struct ww_class *class, bool trylock, bool resolve)
 	abba.trylock = trylock;
 	abba.resolve = resolve;
 
-	schedule_work(&abba.work);
+	queue_work(wq, &abba.work);
 
 	ww_acquire_init_noinject(&ctx, class);
 	if (!trylock)
-- 
2.51.0.338.gd7d06c2dae-goog


