Return-Path: <linux-kernel+bounces-871095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C43C0C736
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02D3401EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EA030F92C;
	Mon, 27 Oct 2025 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hiWaYCHu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KdpVRHpQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F830F803
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554675; cv=none; b=nC2hfhx64REYR8VPaW3hYR/v/4NjAiNiHI8o5NodbF6n3G4m2Q0kMrgcTUuoJ4CK2x8jv0urlhWQEtrCTky21qX2ZDJROc6KeRdbpdVYh/CHctoAw6UbMuTOf7FutC+EfgqQHGNwWHS+XjrFnFQ2Snb8MNZCIC1PNTJ3NLpesu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554675; c=relaxed/simple;
	bh=nnhB+f0G36x3W0MIZh4aEhevuMAkfzzvEKPQH+SzSl0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VccIy6h+2lA9b9msUyiGnB2pJo8bxdNHQq32naZcdmTp2VAzv5gEBObcb0GDh9jVN1kSe+ybjhEI2YtcbcFJtPju0kUCGAywoXMbjkAASHAGSaIYR+le5UEb3gVlgAStJsjzEFfviTWZfmGpiYENyp4VKp68j3GlbBfMEaFHtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hiWaYCHu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KdpVRHpQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084306.462964916@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=g71gtEzQsU5afaEplI48n3ovcqOlik+gKaQw3jv1WLk=;
	b=hiWaYCHuYQpz6cGGDNzoZJrOLzn1YySnN4lurVt2TaIma97ngfS1VxLTAoHdEOoaJMI88c
	6peEoBNlp0K0FYaVFMhpb8d9yaBgFjkcamhXEkPjGFxdgxShm6CyH3v4QRtJhUrYRgpq4I
	mNGh0iLUnV8UYdMnWJ9v5dpG2NRUBba1OpPQhXsTyszYSHqnKVVgHV4+WUWrUvneeASZsW
	e/YqX1WJ11SmBHkQMHwfy6lDRaI4uBBpluA0MwOv71yU+ZO9aQQr5FQxD5AnIdnvXXevpl
	7nJwdyfHDZlFQY6D8EiELzqiEesMKUqR/uR7RlP3V1AgTi8Op12TOUN2pcRlkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=g71gtEzQsU5afaEplI48n3ovcqOlik+gKaQw3jv1WLk=;
	b=KdpVRHpQbAyfan8puYa/8LKfBJPWXM4LkjKo6BKlMcZAxoihUkiYEZZge5KHmN4N/Wq9RE
	AkaZiLdwF1w2DCCg==
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
Subject: [patch V6 08/31] rseq: Avoid CPU/MM CID updates when no event pending
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:31 +0100 (CET)

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





