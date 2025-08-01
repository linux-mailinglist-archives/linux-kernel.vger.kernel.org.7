Return-Path: <linux-kernel+bounces-752815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B0FB17B3C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34FE541138
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1169418C031;
	Fri,  1 Aug 2025 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rVh9Dzjw"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17516156F45
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 02:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754015646; cv=none; b=V/3EYjzzdaHnzl1S8eTOSaWMImChw0S1HO3RtZssxQF2RaFF2OH0BxLj15xI9yhOrz6XE3HXpk4C2OmE5JpsS5WJ/2WL9FgDP9TAHbdlHW4nRUS9xZoTLh8Gze9U/HO2CKNde2gC0DS9hqcnvLPOnTYMrctMwgc9gwy20/npgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754015646; c=relaxed/simple;
	bh=Pb51mfQNmZkb4WPGqUNHd7Z1xTWbviThN5DJVP2wRKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=estOuuPlyA16zD5eqHxe/KGGHjE6Wcr3E6r1KmJsnbtuPEaXLfYlr6U5hHvGHm2X6PLZQCg3KucI9OwpW9JA4Mm38bUMirk04bYUw0Mn6U871bCcW9O8KlCFawrhR6aMri6PvSQnrZ2QcIAA9PpMuBB7x+5BKe+cZ2Y0W6xGUSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rVh9Dzjw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3beafa8d60so1633819a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 19:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754015644; x=1754620444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWk9hic343y4yCEKHWG2bpHk7wRhy/YFcPBXdsL40Y0=;
        b=rVh9DzjwCMjsL4yijmu/f6HPYAogaDbqbqqfEhgeJb6C5drf1uDDakgBUtpyiY0WkE
         Ek6GnIVf/iBKVVgXwIhtjAl6QlNuLCz0w01+u029U5G0YSCWn/TNgIZr22/xeknAyV1E
         D/gPrsKix4VNrNELY3oLGaK2wPnao0wiLAWvaB9AtVTqLKSNeZgMEjxuuDp1zPJFEm+Y
         31tGx65+7jBnV5LsaRuAtxILImpf3Jw+eLeq/3jkAkCg2vT8b4fWZeXE2vxCMujo6esf
         C0mZrej2vT4bHQuX8/F/kLrbjsPQkUfIcauUa9dZqs17zdnZXRp3RJoWookyITmdptfD
         xwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754015644; x=1754620444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWk9hic343y4yCEKHWG2bpHk7wRhy/YFcPBXdsL40Y0=;
        b=OJWxKHhHfXo5gQahca63lBIec1gNO/IX3DrnOGK6n5j4pvLJICLKgxse2fiU+M4gIu
         i4eD764FPAfi7+FXLclGKTq282VNKwbBivUPI93bs7aZJ4zZQcmQGYAFu+X+Y8QIYDVk
         hm7BT+nfrB3BHbHzyXjJQxmM4kplwN0dI2q/2552UVnplCkpgdC7tGyNCs+8rYy88UxA
         ruijjpw1scwEIMojgWsavJK/KVRnKQe9JpqbmyrIyUCMquirEOICJ1IzwczKW9Q7OVU5
         eYLWJyHehQONmfMhC3sq3lQu/aFCyNc6QLge/VHPnzrh/p4Dzdq6hDDpea8dzfVNHMzk
         b9wQ==
X-Gm-Message-State: AOJu0Yz7lL+5UbboPEkXvcCS8x63Icft9cKWJupdfW6olVmrTQNcbSwV
	QCQMw7x4lZXSm+tDcWYHfn+4wMUquiEo2MKp7QqujMbaaZuRvOFgp+61inpLIo0N6pddHLHNiIX
	gfclNj9ZIuCTRy4GdbnRFucJdnvluP0D902GzcAGjA5n5IwOHK0tF+Tdl4T/czc7xL5fG5a8ZUk
	/jx3Ablsawlhx/OkXiMrZwJ+6cATSFexUn07qUlSfgtFgtoK7y
X-Google-Smtp-Source: AGHT+IH9Mn42h2YmbNR36MdNFq3SvYZuogE+4q8+Uhd9SdiVLe/3NeKay1j9N8i5MN697z+stSUhY0teywxo
X-Received: from pjbli11.prod.google.com ([2002:a17:90b:48cb:b0:31e:c61e:663b])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a7:b0:230:f847:6586
 with SMTP id adf61e73a8af0-23de81c3586mr1497725637.29.1754015644291; Thu, 31
 Jul 2025 19:34:04 -0700 (PDT)
Date: Fri,  1 Aug 2025 02:33:48 +0000
In-Reply-To: <20250801023358.562525-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250801023358.562525-1-jstultz@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250801023358.562525-3-jstultz@google.com>
Subject: [PATCH 2/3] test-ww_mutex: Move work to its own UNBOUND workqueue
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
2.50.1.565.gc32cd1483b-goog


