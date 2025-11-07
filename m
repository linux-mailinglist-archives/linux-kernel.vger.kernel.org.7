Return-Path: <linux-kernel+bounces-890754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084F2C40D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4C11886EA9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EA825C821;
	Fri,  7 Nov 2025 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s4p+MN0t"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71876261B99
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532302; cv=none; b=mKmMFPR9b43B2Jk1s0lPPsYMrovNyuCRk6Z4qir1xQHPr7MxzKxttwz/EMiOGoQ0UyJiHzhepUGtvA9MyZUEIXfgcVN6q8X+9hEKzPNDbyEs15Cx/7t++XvuWDqVWOlo45mWji2w9MRQybEJAvNlP8iyAXuDVQ/zT9xZQX4PXQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532302; c=relaxed/simple;
	bh=xc+Q+HSrfHgz01/jVrxNRJP8NAGZTlIEai3jwOKL6E4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LTw/3zZImGpFSdWdYeF/4hcaMhMnSiWVt1reeLdhcko6ANqldk3rUSJ85lAhHLd/pKwdtC/9HThZ2Azn+ktYVTxNEJlkOWBqyXe8QY43B536u9XOG2khIn9/Yk5FPierPtkPbAD5QcnD4mvgQVNhXNzzMQj20Rf30pMX26AItQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s4p+MN0t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=7yx2y0dJFqYVgOG0SXlROmLKdeQ8zFk8L28f2lgjVAE=; b=s4p+MN0tDKcvsjpzY0JMofx+Dg
	vcpJI8IHbB3DAFMuPA/d1w6fjejFd+819sL0MULcLowPFehdcUBZOLgTpGzBulD09fJOIPWgaETRE
	Pbkf4/sSj3tP85H0WXDanyW9s/Frev9BF2wdar8FpB7HrLfPQTXEzacPc0/I1Rk37v5J0lcTIqYP4
	WHXVq8MnQVVEkkBhVeqVtUXBMqhduh/SraAt/HBVQ9uMMxrcNni6L5KLGWDaQk6QBF8mWQzAb+Ji+
	FWCQ5FdUzJ8cY/4E9SP1qfX/1k26od12R+WtAZFPZUCMmHrOjvERxg12QoGh/eKmc+BC9isFulwNC
	LgMKk8vw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHPA8-0000000DUTJ-0Oqh;
	Fri, 07 Nov 2025 16:18:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 07CF13018AA; Fri, 07 Nov 2025 17:18:08 +0100 (CET)
Message-ID: <20251107161739.655208666@infradead.org>
User-Agent: quilt/0.68
Date: Fri, 07 Nov 2025 17:06:48 +0100
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
Subject: [PATCH 3/4] sched/fair: Small cleanup to update_newidle_cost()
References: <20251107160645.929564468@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Simplify code by adding a few variables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12148,22 +12148,25 @@ void update_max_interval(void)
 
 static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
 {
+	unsigned long next_decay = sd->last_decay_max_lb_cost + HZ;
+	unsigned long now = jiffies;
+
 	if (cost > sd->max_newidle_lb_cost) {
 		/*
 		 * Track max cost of a domain to make sure to not delay the
 		 * next wakeup on the CPU.
 		 */
 		sd->max_newidle_lb_cost = cost;
-		sd->last_decay_max_lb_cost = jiffies;
-	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
+		sd->last_decay_max_lb_cost = now;
+
+	} else if (time_after(now, next_decay)) {
 		/*
 		 * Decay the newidle max times by ~1% per second to ensure that
 		 * it is not outdated and the current max cost is actually
 		 * shorter.
 		 */
 		sd->max_newidle_lb_cost = (sd->max_newidle_lb_cost * 253) / 256;
-		sd->last_decay_max_lb_cost = jiffies;
-
+		sd->last_decay_max_lb_cost = now;
 		return true;
 	}
 



