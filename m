Return-Path: <linux-kernel+bounces-806797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4679B49BFF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A43B4E1F17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221A2DF3D1;
	Mon,  8 Sep 2025 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NtIMkiun";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NtRC7U0R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE872DF145
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367104; cv=none; b=JdFrUHTsU5Cmzh1BuvxWTxHjcn8AnZbA//oSG5+ILMyjMu3XLp3Dz14RHAQIVBKT1mzCOarlRZ+FOToVfvKMZ7d28e65ttCuN8KHAaCR2Hzq3LPZeGkjCRf3CnIUVMze0WKJ/zTV7/dJx1fbGl8Ogo672wgFfiKu/QZ+OtVS+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367104; c=relaxed/simple;
	bh=pVR68kiPsXqv47e/THuSngp8VKiZpQ22MCdrVQMkWqQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=C8pGaNUjM1bRIlC85QlnGEdqpQ22vqTDHhlyal30NwCr8BgqgHxD9S7a+520VW8RI6mTola+kuSWeWVLy5LtlXxN62jKc/xaZRT/up8u9Nd6PlSilgN8HOF7slz8+4f9b8xnHNcGirkUBJTy4JWysM/n0MEiAy26NggjkP9BlcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NtIMkiun; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NtRC7U0R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212925.775679381@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7/41HQj17+XAeIrZidZizZdtvc2MyB7e0HKF5+3Od54=;
	b=NtIMkiunTXLrtCQV0bkjjtNn+uZ18rI2qlko5rCJzVdQC28Yawbh9ukylGVOn9vGLz0zMq
	A6LewFG4GPrm248NxNA8yiEFa67+Ji6NEjAe6PA7R3zxbPHTmGC3DyRoRC0vLVfEwb5hTX
	gNH8Z7G29WlHnggPzWe4exZbpg98WnPsEkHnRucoZtHUYiW7w4tM+LXLbp16v5ff5iGH6s
	hKhy+jCULQtFJzdjODweF0sKxoTHK/+dL90N5gsIx+2w7GPMTjtbRxz7Vw+hJtU2u5+VcQ
	Qtrs8FyxzZnGEVZDywsAZBLi/9oSpQX01KALewAm6Mh9J8XpRpofP3QzE9dV8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7/41HQj17+XAeIrZidZizZdtvc2MyB7e0HKF5+3Od54=;
	b=NtRC7U0RDh9JBHxGW/kPBfax2F+hYEiWk9909mH8hECkDW9jcGKJ9ChemTaTQa/KN/QrKf
	PPZSejreVP6shFAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V4 08/36] rseq: Avoid CPU/MM CID updates when no event pending
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:31:40 +0200 (CEST)

There is no need to update these values unconditionally if there is no
event pending.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/rseq.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -464,11 +464,12 @@ void __rseq_handle_notify_resume(struct
 		t->rseq_event_pending = false;
 	}
 
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
-		ret = rseq_ip_fixup(regs, event);
-		if (unlikely(ret < 0))
-			goto error;
-	}
+	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
+		return;
+
+	ret = rseq_ip_fixup(regs, event);
+	if (unlikely(ret < 0))
+		goto error;
 
 	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;



