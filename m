Return-Path: <linux-kernel+bounces-823761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E54AB8763D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 912847AEA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A446A279346;
	Thu, 18 Sep 2025 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7XaJpNx"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9427A5CDF1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758238431; cv=none; b=g+1bBUceGzHTC8uLLOoTb5VfcGuG7xh1Y46qr8bAUBvP4deeKu8kPmi0NoYzfqkkl4gd+95JCvPTwIGo/bAs8Aarhzfrw7QMuhRNcCvXNPin+CCICxTJhwprvwVZVaDHZvjhKs1QlMGB3PBMAAiCPttT11lG7F9+oKbtN8yxQpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758238431; c=relaxed/simple;
	bh=VLDfSj203Qkc2zXRjD5MnjJ6Qg3EHkSG8UXZoW/q+t4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IkOMgWsM6ZWPWZ0KJgCoWgV7xH8JCu11XKUFO/pFEbB4xIndCB44xSe65a2dMXRo01+MK0zUeq62G0qQYfDY5BVB7wVrru3A4NVKgGFJpURchYPwn21XLO52+u03AZezM8usob1qqtJR7Dj3Sk/612l1hPFef7cce1XVePwWTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7XaJpNx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b54d0ffd16eso1113046a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758238429; x=1758843229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0Mri374mR1+nIWvUiH4WKvHXnpol3IHoEuLX9naRqk=;
        b=t7XaJpNx/M7M24UpQzoO+huAPr2mp1M6l+SPTwsQMZsF9+1m+29TRZ4jw5GAdgbL8R
         k+6gHFOZGDhHzK25amJtABtLDXOpRAjD88egKKtGU+a2ZbufsdckADP5mljEmNW/nNOy
         LEOCNAqc4lX2EiGGcdTCWj4nElCzdHMeuY9ASWcXysNSwO//yCBMPinvT75C/sZI9xHz
         MHZ8xN8s+IJGTIbqthroiSXXNwYiOtvjVDldFpCkZ+FtZrpF+3VrR879qzE2fjkZ5/8V
         4dvrV2vTpIp9LUAJSMmeT9s+XSRcelNRvs9KuxLR4BGYtL0MkE2AbMC8mHS3kmiPc3KL
         lQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758238429; x=1758843229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0Mri374mR1+nIWvUiH4WKvHXnpol3IHoEuLX9naRqk=;
        b=C8V+SsFbk6WkiZxE63EpAHy5xeaF34aykdJJ8KBSgJbC5qmlpQszkLwxXO6dGtqFv+
         +hBhg+IOH/91XsahBq4K36Qhmqy5+GKog2pr0iwNzz9I6z77pUcAmUacClPIDVBMqUNF
         V7Vv+evw85uSSQAi+BQUTEcVwBdvLVI91Ifp4oHoPkr6HSL3E3u8PxPTjLc8MOa0njxZ
         JZLSFVXf88vBrbfPgmjgJ4uidUiXwX4Jg5OVNByIiSXt1PDDxXwRsX/N1K1SLf7IMBB8
         OmDWBNJebFuuyycl5IlqMKjs2vD/g9yc5Bfrp+g0Z/Zbwg+qe8LxtUz13I7kyK0/NJrK
         V4wA==
X-Gm-Message-State: AOJu0YwdzPmzUXNfi1K16n3y3hvtOi+PCIsNizcxauILGEoN7bqcd/6u
	Z1CvXVnTsqIz+k9Upnp13+flpNvUq1HEk9CFj9Da6HPUNQqm2t3Nl3gPOVdodxfkofophLwDkJJ
	0aAEwgvGKCDfjOw6Oye1aJR9k3LXCD6uJLZ2jfbBZDJFMfWUS919ep4KZhZfJQ63+zu1g9fLEa5
	iw0vChioxXyjNae1gIRjqDeuOoB972QPtTh0OZljGjI87gY1Lx
X-Google-Smtp-Source: AGHT+IExPfrp7dOWhuAkGXn2PbYR+sD3P4RwRXdH8VqwfNkvrlxq6+1b5dfmHv6SyuPdfa9yH7OR5itui0xo
X-Received: from pfbei7.prod.google.com ([2002:a05:6a00:80c7:b0:77d:19cc:c40f])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9994:b0:262:514f:16d6
 with SMTP id adf61e73a8af0-2925a78e604mr2045146637.12.1758238428611; Thu, 18
 Sep 2025 16:33:48 -0700 (PDT)
Date: Thu, 18 Sep 2025 23:33:33 +0000
In-Reply-To: <20250918233344.4166141-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918233344.4166141-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250918233344.4166141-2-jstultz@google.com>
Subject: [RESEND x3][PATCH 2/3] test-ww_mutex: Move work to its own UNBOUND workqueue
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
index d27aaaa860a36..30512b3e95c99 100644
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
2.51.0.534.gc79095c0ca-goog


