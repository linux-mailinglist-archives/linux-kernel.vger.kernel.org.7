Return-Path: <linux-kernel+bounces-731032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC00B04DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE574A4FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9532D0283;
	Tue, 15 Jul 2025 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UuZ4JdWY"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3CE2C3773
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752545667; cv=none; b=KhMvi+MQmIr9gMx5/+bxOc9BQiJQ8bafB7k2YE0A5q4KBQtQ3CmPIcbQRzjWxRpXNq4icFp+/F9YHMRuOr4Rz1VBxtDe0LVNnUpNPaxguNNiiXPir5r3Hh1imwTyI8sfpTI5xbu2akHi0hnppq6CY2nWteVDwOYF4FZwCXzM0Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752545667; c=relaxed/simple;
	bh=cjBboeGPt8niKXwVxBt7MzsjLbbjYWRpHSA2B0PtJsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uBBkOAoACs3JpokN+OGdjJlwfyBSQsw2n6vE9fYgVcA4WDr05Tzej/W/qB9D7tCznEtLhkLhdbbjhbuw6HeqfoC2GTj+KXdP5yU/avJknpbFYQpWeAd3d4pNTancYM80BTHu5DjkjpuWEvvJUvl5szL7FgqRgBEa5bSFyJUBWso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UuZ4JdWY; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313c3915345so7158864a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752545665; x=1753150465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aeC5ygZA+vPhmblUnoYuBkB9Dhvk54p0L9BPnO9U6iI=;
        b=UuZ4JdWYFSxVK2diWW6tdIgnhBXI8CbhADyRoGGWkfDTMaHmTqeMAlWXpmuO8gG2aP
         cZ3DpQoNhDKlQ6ENI3hTcu/uM28F47s3xQ6F0IBJW47pW/y+frwLj676uY5ER/vnvex/
         6hAQipNF+ciOfQqmuQTkHHMvPpiRY0TgL5u6w7CCGBI/1SYGBp1MR6O0lAwKLs3ok7NN
         Leq39/51tQwBfymg6MqeQWY6vXOlB0XNBfJQhXig764gv8nxUSyzmP6/5MXT1NcpD6HT
         xEuC1IEcY6+u7gBOLMY/F51y5OSjwZB0whSYCwpFWDDYeLG585mfLtAOCMCtgynDGiFB
         NQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752545665; x=1753150465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeC5ygZA+vPhmblUnoYuBkB9Dhvk54p0L9BPnO9U6iI=;
        b=FZt1VG9dxAhiE1SrQi7ybanPbDhuW+i6ujqjj7LzojoHRMCC5U8eI/zVgvx5pM2tbm
         NkCAg3JwdRS1S7lSNgGi2l1+OERAWKg7j8SIlSo8TMfe6brCQ8ag877r/tQSmr2SbMYM
         14NNUjFfir6ZIU8bGmyXku2lH2gzk45BXwJvCjTCzVHAtP7XP/JFEaIxz3VeRcr9tYZm
         KlUJPq5GFfZNk+meodlr6HV7Kznq3SLZpan50GlL4y23q9kA1kQ3ExAP8broQjEiDe/K
         yjEVVFdgBmsjd3WebVmNnWeIUOh5K2x8zA+Ky+LLoLRQ5VErv6EnZhwrRrWKCr+XJ4Yu
         BL8g==
X-Gm-Message-State: AOJu0YxpiN1hVuSVmWljWQ+XInKW4Xl2jzHq3Dk5ru7XblHVv+xZ0IhY
	QGGeG9x+wnmbHez4Df8td+cbnbeACP2Uz703OcwRT4nR0ERUnnhS85QQJGV7Lf+Tb+LOPbnC8dH
	dFPF9qrsKQuOZd9/kW8kkd4ln8iTjyPL6KCs+QvHBc7kAa0T3of/QiJwcoFJ2f2grA6gJSWPOT4
	Yh0KUj+jdS+PmLXC3NyNnQkqn9w3FoeS3IvShqYxzUkVqywmol
X-Google-Smtp-Source: AGHT+IEXgVuzkFStnI1rMNmk3h5eCBTtAHwfv/P7GLtw2gksqxSJdcORSYmCubdm5zp5dgY24cWpnxy8O+wS
X-Received: from pjtu13.prod.google.com ([2002:a17:90a:c88d:b0:312:1e70:e233])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:268e:b0:311:fde5:e224
 with SMTP id 98e67ed59e1d1-31c4ca6759dmr21554283a91.6.1752545665168; Mon, 14
 Jul 2025 19:14:25 -0700 (PDT)
Date: Tue, 15 Jul 2025 02:14:05 +0000
In-Reply-To: <20250715021417.4015799-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715021417.4015799-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715021417.4015799-2-jstultz@google.com>
Subject: [RESEND][PATCH 2/2] test-ww_mutex: Move work to its own UNBOUND workqueue
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
index dcfa5ab15ab49..a05d24deab529 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -71,7 +71,7 @@ static int __test_mutex(unsigned int flags)
 	init_completion(&mtx.done);
 	mtx.flags = flags;
 
-	schedule_work(&mtx.work);
+	queue_work(wq, &mtx.work);
 
 	wait_for_completion(&mtx.ready);
 	ww_mutex_lock(&mtx.mutex, (flags & TEST_MTX_CTX) ? &ctx : NULL);
@@ -231,7 +231,7 @@ static int test_abba(bool trylock, bool resolve)
 	abba.trylock = trylock;
 	abba.resolve = resolve;
 
-	schedule_work(&abba.work);
+	queue_work(wq, &abba.work);
 
 	ww_acquire_init_noinject(&ctx, &ww_class);
 	if (!trylock)
-- 
2.50.0.727.gbf7dc18ff4-goog


