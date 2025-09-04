Return-Path: <linux-kernel+bounces-801744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28085B44975
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D784BA076BA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7292EE60B;
	Thu,  4 Sep 2025 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3b68voJN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HxYPithd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90602ED144
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024453; cv=none; b=Lvmr471r5mBiJscmaYJe4YqrneR0JYQeo3sSupWlySzJFqfwOP04BrWFG7ars4KlaC7X3JRBjMpcFmGUZ1ziMjOC0Hxu+n72hx3OxOhwJ/mQOFa0tEAau81vqnc6HqOfBksBT3ld1f8A93j6Ym9wx3OpFqgBwMWgBDmQNTubXi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024453; c=relaxed/simple;
	bh=pVR68kiPsXqv47e/THuSngp8VKiZpQ22MCdrVQMkWqQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=QjVQVqungX6I2L0g/RrRu1488BnMGu0DCYJ9JtpX569QfZP/oVP+tGAdkY+DNXEt3qZdZ03Nx7LF2P+e3kf1AgRqUh1ieTHAazzmGFXqFjP2PlS047WC9KcN/rYUjTs2B4wZFyIURwaEEMa1W+SWI0ogLWByB8kNJzt2ChOE3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3b68voJN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HxYPithd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185719.647755938@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7/41HQj17+XAeIrZidZizZdtvc2MyB7e0HKF5+3Od54=;
	b=3b68voJN9ISWxQ1Y5z4m8J4POjo+9O7MfPIQ1YSVhEjzRWIy/BZHWXJJDrH65H6ckFNXTR
	VPeKg5K2chgnKlPa0yMqJAjblK3EdnI1HX+kgqsaD516AFchQheGy/7mbnGsGpY3wSiDxl
	dQd6m07dxSm5XzeziqoyJqzVSlh6sDeVVKAYVZN59Mm6Dy0WW/vEnziwf+iJRI5XY3WR9t
	qsZ/w9Fv/HCwv/GHDP7hzPCebqEp3fujbvO9THMZVGZ7Boix+hUVuS2gWIi8nwkTkf5oGo
	yoNzn2uoktYTHTZt72gvKv8FyNeb/TqU053bPtdTvPH9mEhxroS2LyV1N4GroA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7/41HQj17+XAeIrZidZizZdtvc2MyB7e0HKF5+3Od54=;
	b=HxYPithdQI+xk16b0ktkKNUoA1hpnWgg1MMtwhCCXIAKarus1soNS3xN0bHb6YeCb2FF8A
	SQ0dFjrNCVYVwlAw==
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
Subject: [patch V3 08/37] rseq: Avoid CPU/MM CID updates when no event pending
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:20:49 +0200 (CEST)

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



