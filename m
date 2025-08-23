Return-Path: <linux-kernel+bounces-783238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA2FB32AEC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1ABE587D39
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239852EBDD7;
	Sat, 23 Aug 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OoklO4gi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v6784Fn6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1BC2EB87F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967169; cv=none; b=u7dVvMvnWANQcTXmqYsgVhv1BVUeLmYJODqLS0a+xJux5TJLVNlfo6Y4PAYmIQznZZM8U5Dj0NmKwkj+G0VaGi3db9rkZwISYL2RqGX9r6PTMlY6iEOF8KG4vPTHcNM1lV9ldkKZHvgOilNPSqW3s04tlt1jgblOxw0xeaJJy+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967169; c=relaxed/simple;
	bh=eqL9erE46B7rKu7FwxA/5IdztKBktszWQdhwIbuz0zI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=sazhKkwiUtnZFwK6ZU+Of68MKVSactNddATYzH+iq0CW5q5BdreKuIfse0lYzp9fy5I2YujvW052Y+Izzkm50t0u8SIYbLwxYiWNH7dgbQ68PpmErozCRSX4/Q7FgXHpFNv9XtoZySWlugpN8V9RXPWyzKNS69xGNbh0gRMl+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OoklO4gi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v6784Fn6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161653.778777669@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=N+F2iDx5RS83cKT+1sZ4mIe77F1JAxH+QfG7ReD6apc=;
	b=OoklO4giNu/f7NYcYPjXYi+2D8f/3KXfUkUUj7l2LB3rlniuSAog9QSmGqwnTOIFuX6kaz
	QdexqpMUK09RhmhvHJ3ptQr+N6JYygqnVFDVS0iguhZamDLEEuE82r7EZj2Lf2QuW2BpeW
	QKEnzcZfTiAdsKvNuqLuwMkqXxdiOssPNnbPNcQK0PkkzwT4u1/G8rEBPZQQo7pJDcDB4c
	NQAnIrS87zAp9ZYSGU1O1ULlonETfDq4lu0I4jRv+4cp603JWaGRCIDl2MttUhR0aLrAg8
	52ggBGHZhmFRxt4Dtty4hwmoqwtHWPaEByeuwk/6sYNtH1f4qoQILTbxnAZgLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=N+F2iDx5RS83cKT+1sZ4mIe77F1JAxH+QfG7ReD6apc=;
	b=v6784Fn6hopGGkL9uW4wt3pU3tIToAV8Ygv99jM6nOVEIkvE3UrWIi5yibIYQOZUDFpey+
	urrMga+IdYWkdDAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
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
Subject: [patch V2 08/37] rseq: Avoid CPU/MM CID updates when no event pending
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:39:24 +0200 (CEST)

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


