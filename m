Return-Path: <linux-kernel+bounces-890751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED591C40D87
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE6E94EBF99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3443E265620;
	Fri,  7 Nov 2025 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oEp1lEXX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71905262FC7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532301; cv=none; b=peCwcw5uT51RLZj1I1bWF/XbSxlYp+s0yYzsO6V2ImD4L+kf+4Psb8rLKOBnoHmqx1de4KHKbwuwTWJaV1DP96fH+xiXY/zkmnfweohcT0hvxPW0IrWTjNHx4+73ni7aMHgWik7i2CDcMOcNJbvCt90WqUy9YBb/AvZPI/E437E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532301; c=relaxed/simple;
	bh=v7BLQ9hN6tgnHhY26dNTomwoZYHkCf/qt7OZxeUAchw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iNKq8dxIRJX53fnZ1hbTtNg4VIlR8f2z1EcuJ1rzweNY1s/aDBG3bhgBNtRexVlgGib1KA4Nft68DcP+IrjH1wG8RjmHalZs2/bUz2b88Z+xkmFafn0dPgyJglRKySMhu/0rHKQuURUqqQYDOBql4dhquZ4OpGiHdjVn8v10b6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oEp1lEXX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=//CAQTnED5uckJ05w5QzaZBZaMbRiBHs025dyQwPJD8=; b=oEp1lEXXH0OHgAbWvPTG9vD1AN
	4IqeXHhMLyBEx02RMbzCWnNDfeAWvSaUW8XqfetA2SwTeiYKc4CqhZplfpdHMf1tuHByBE7lo9da+
	XFK+x20ZbjdwPGhD70fxpcNSt3g0Gs96bdctGO5KMLqp5u14pTrBjoeJomVS5IkQtMXQ2o/80NCEV
	b41MRtEwCDRad2TxaS0mnIUHc/MzRqtjs20OHVYRqUBF+V5JBV4nkSKM/YLEvodpq6g2Febq3NA9B
	eEBahorzB2BlUWVXgSOwFhDtQ0mPLC6LvUzyqs6VY3AwecBPRCDXEn054CT1ilXW4+zcpBZyxCHoW
	AISk/t3A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHPA8-0000000DUTI-0K5T;
	Fri, 07 Nov 2025 16:18:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 03C1F3007B5; Fri, 07 Nov 2025 17:18:08 +0100 (CET)
Message-ID: <20251107161739.525916173@infradead.org>
User-Agent: quilt/0.68
Date: Fri, 07 Nov 2025 17:06:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Chris Mason <clm@meta.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>,
 Adam Li <adamli@os.amperecomputing.com>,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
 Josh Don <joshdon@google.com>
Cc: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] sched/fair: Small cleanup to sched_balance_newidle()
References: <20251107160645.929564468@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Pull out the !sd check to simplify code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12811,14 +12811,16 @@ static int sched_balance_newidle(struct
 
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
+	if (!sd) {
+		rcu_read_unlock();
+		goto out;
+	}
 
 	if (!get_rd_overloaded(this_rq->rd) ||
-	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
+	    this_rq->avg_idle < sd->max_newidle_lb_cost) {
 
-		if (sd)
-			update_next_balance(sd, &next_balance);
+		update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
-
 		goto out;
 	}
 	rcu_read_unlock();



