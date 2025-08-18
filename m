Return-Path: <linux-kernel+bounces-774558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4936B2B423
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD1219633AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F124927A468;
	Mon, 18 Aug 2025 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zn5oJtqI"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2325F79A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755556488; cv=none; b=LHurF2y8iQabZ+Z7g0UGCEtD90wnpwKIypVXaMS3JxTMZwJKp3tVvaHymQWDdAy+0KE4KO6FSfAPBqj9Y/gRFUP2FZiNV1FEq5aISP7WUpEDSeslRh4/UB6YyOXoeYYFkw0VL9eXKQDPHJVYpC4XXH8W6flbNUragyYX4C9L9kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755556488; c=relaxed/simple;
	bh=8QYezj8e4Y9KcmW5om348zn69zikG7Pe9BiOcbCs5sU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pX2BmcNapjRB/gf6B7HwpZgVgSjCOUFaFZAOrXmLhqU+IFHpv6FMOIscXwvqbJyuVvudZg/WUf5VLnVutTARCHmVpJTR8RoOSflx0KNiIWUJyEMkWseaMMySUrEGGx/mGgYd9dxXubOTUyv4dYbV7E71LxiP2eL+TGwN8mRdvFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zn5oJtqI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so4502070b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755556485; x=1756161285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6jWHRSJ+IeEEVdjy+rEw1iCTjwEyi1x5Goc9mHMKTA=;
        b=zn5oJtqI77P/R/iXX1EJP+cvo+OUlTgLrZfHWTOCQgCJq2jRmWGg7mzbf4Y1tcVBr6
         wTNbZZMycFxkcUTFaRFCj1K4JcEReaF52nGPVm8vqg2ooHxh/VmHo152E2qtUZFVpMjH
         QUrhDs6cGzkHCal0+w0Xfm9FOAFveTWeN/347ytWlCLSCK8LOOmzfBNETTg1da580IRi
         bEPLQiI6CdzKIoZ+GEGxbzeqEVneYwd0t7kMRmc1EFuoEUOrXbTx/u5IBOoIOi53SD7x
         w/jJMiignkD2MlJZj4WejowrxftKUX4vRwD62M/rm8fLFYqK1JYIcURywNBf8ZXTKTmL
         nxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755556485; x=1756161285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6jWHRSJ+IeEEVdjy+rEw1iCTjwEyi1x5Goc9mHMKTA=;
        b=rnHOCPaB3wrLtVkzaBykl50lbSzRzsqOKrMdAxh4UCRc9Ke+TGBXL6QBNpecYQ0Vt6
         Z88j29QAhK8knCFIXeSxY5y6zyLDOHTikD8mFP9VrNNMNCtGXv8Wf+TbgpRzR3QATHtp
         /4ndD7Bj8hgjMQBKzpX8ZFgiXfGCAdVm0FX5f1g/i8VheBAm4pYrZvfS86LgeOp/UhEM
         N822OHxz7whhrbcpEPJu8WZ63HMTGnF+uwwU7xwvtpwmX9cY68xePgf6CfQH1RV1leD7
         WqNSJPWesRweh644mg+0QSYlJh5IVLQiEXr2yvZqrtseviR8BI3pELt6tJnvth76KbPS
         zlqw==
X-Gm-Message-State: AOJu0YzM0VnenK9mbiCL964KnVvEUWXxWpq1Gzd5uvt4p2TV8m/+L3I0
	WSG7UMmUYou+K7oB4N+X+k7mtLQJix+fZrlN5TXZ6/V+a1aqZDY8FdTQ1nxIzPd1P5n0ly3J7KJ
	vyp5LUzU+r5B7zNmkvh8KxJUx5xP01cJLiiGcgLnpoiOzs5wxp1gIdJUetuZ+Iy1XtoUz63j/Ny
	4e+FLAQMD3lB011g1kT43OxXf0vYzh/dwC1sHJCZUNiGfMIycy
X-Google-Smtp-Source: AGHT+IGgKug3JGAR/BzXjH+I8A1kW9ssyAK0V6H7KOxz0NziozRzQSpp+XxOmKuizyrFRkiFF62zMVF27+6t
X-Received: from pjbsb5.prod.google.com ([2002:a17:90b:50c5:b0:312:ea08:fa64])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7293:b0:21a:e751:e048
 with SMTP id adf61e73a8af0-2430d420579mr297742637.35.1755556485116; Mon, 18
 Aug 2025 15:34:45 -0700 (PDT)
Date: Mon, 18 Aug 2025 22:34:23 +0000
In-Reply-To: <20250818223439.2989969-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818223439.2989969-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818223439.2989969-2-jstultz@google.com>
Subject: [RESEND][PATCH 2/3] test-ww_mutex: Move work to its own UNBOUND workqueue
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
index 788b6eda11322..89ded3a3c6d20 100644
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
2.51.0.rc1.167.g924127e9c0-goog


