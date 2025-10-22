Return-Path: <linux-kernel+bounces-864973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B7BBFBF93
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA9D63416B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A73F34B1B0;
	Wed, 22 Oct 2025 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eXJo9avc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U2j5xuFb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8F348893
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137537; cv=none; b=m4fRfwv49+VKPMRUlgiNF/R5sMW7SaCiXsLJlVnn+BhSbe6zuV2kFUwNakPoBdjCiU+vzYVyobRxV/NQo6lsjFbqlpbXAcBt5YLJmjadAQD5R/zyg5saqLow210blnIppQHIYzknr8tg0yxbnF0gqLDJxSgc+UoIN/ry9zVzpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137537; c=relaxed/simple;
	bh=nnhB+f0G36x3W0MIZh4aEhevuMAkfzzvEKPQH+SzSl0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=fSmVBTxEoeOR/1Jr3VzRR9e4KXZPPdDbrWotksU19QHi77LtQfUL+vm0JpYWMaN4MaEvk+OBhn+Fnf8cMWUFOqRzOeZnn8lKhrhdKZh1QSr1zWZTFSnkAzFzhbQVYQ4efIHDbUNc3CPjh6ufOaI/dhJFpnqVyvpi7iW/KWqyeAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eXJo9avc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U2j5xuFb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121941.885550851@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=g71gtEzQsU5afaEplI48n3ovcqOlik+gKaQw3jv1WLk=;
	b=eXJo9avcofbsvjHXQl/5lWUnGqcM3UNJlTY/S42rjPTFzmxZVwEbSHm9wb+W1SK3bzdzDi
	/aBSDGZHUT/7Gfkn0nU9YmneCQ10KOcNuvg27KbYHxlYoRf3lJ7mFHvlrSDpucf3A3gNAo
	C5VczvL2D9kbD8fkP4BrtMHbBEITAP95u/DlceMGzs3SDsoQY6U/UH2sZaeUTjq5VNQpMk
	zQQbIBNBLanRXXkUYezlHznPbe/mufkkI/+7GdmbZfmnNrpfTo4+7OhMoqT23E5iRo92tI
	qlzewDPHLO7qv0MDGw9NtirpQZXD1F8AKrwWm96taSkf0nfEX4S8P7ql8C16lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=g71gtEzQsU5afaEplI48n3ovcqOlik+gKaQw3jv1WLk=;
	b=U2j5xuFbL/fp9t1Uj/jtzaDXKl8frPylghlXcvbfhf5C4ay4nquMbkG7tSMJZI3E9Jcf+s
	hVS8HkVaqGmFjZBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V5 08/31] rseq: Avoid CPU/MM CID updates when no event pending
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:10 +0200 (CEST)

There is no need to update these values unconditionally if there is no
event pending.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

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





