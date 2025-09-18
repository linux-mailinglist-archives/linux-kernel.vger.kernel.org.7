Return-Path: <linux-kernel+bounces-822289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE03B8375A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A9D1C82D65
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8D72FABE9;
	Thu, 18 Sep 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kuhSRgWj"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2182F83C5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182828; cv=none; b=TdwHmsfhOLE6upe6XYT8LXc3QQEuPyhW2ta0Zm2V4rxvDC7RKFNQOYC92iuVw1U8m87ZJojLVwGP3sKADKETaOf2XjH4V4/TgMP0qg7GermllLueY8sqrt8GxzzxK8SOprHhyuUQk3iORY4v8TxY+vNQWHvOZEaQyms+6fguOXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182828; c=relaxed/simple;
	bh=IlN4XLKrso/cZZvtFPca5y3RkTjhYGy7kLLh3IzBo+A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Dlrf1SZO5wCuwKB2cw2gffv8EPb94vZSkKegb5FtMFqcJ0nRd2T/JaTyL+EAyqT6yc7tee35Sy2VEpZwvUAQ+PdYuiC/q1tjrutCEFDmuA7oXwxIFYiAEzFUPyV6H48u5yhVvDDghlUqQhSw54Vl4uxzldhjuX30qqEM5mGogxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kuhSRgWj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=T6/Y9m+G84U4TaaIEmT8jGIPgMyNBhKn1kYlP4YLp50=; b=kuhSRgWjax0PJIYuDLIjvMz6Od
	FBVuVS23Rc+N+Huknh/Sqsj24+ks26AN8+HOGvSAvdZE0H4Xe4m6h4AseZs/4kdbuuc3CkYEJWqds
	ttH4OJ1D6Dt+XB9vYOwBaIdjcmxuKiRMG6jv44uvvzDh848e++LHwJ4yu0CIkuaqk8uZ7uckHYJ1e
	67xFoz9hQEM4t7Nj60NnA+QVGEdWlk/6oSj7RsdV8WxLrq1HY2cHtjD2st4drOi/ISLGXK1wdGr93
	gqeFcVjdcjO8o9wqHOBj6Of4+c9OyyUdEfQlJX61NMojNmeh9QE2M3IfpQYTZQM509HJZmLJO41v+
	i8alh7oA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9fD-00000007Z6L-0R7F;
	Thu, 18 Sep 2025 08:06:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 15EFB3003C4; Thu, 18 Sep 2025 10:06:46 +0200 (CEST)
Message-ID: <20250918080205.442967033@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 18 Sep 2025 09:52:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: arnd@arndb.de,
 anna-maria@linutronix.de,
 frederic@kernel.org,
 peterz@infradead.org,
 luto@kernel.org,
 mingo@redhat.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 oliver.sang@intel.com, jstultz@google.com
Subject: [PATCH 1/8] sched: Fix hrtick() vs scheduling context
References: <20250918075219.091828500@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The sched_class::task_tick() method is called on the donor
sched_class, and sched_tick() hands it rq->donor as argument, which is
consistent.

However, while hrtick() uses the donor sched_class, it then passes
rq->curr, which is inconsistent. Fix it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -875,7 +875,7 @@ static enum hrtimer_restart hrtick(struc
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->donor->sched_class->task_tick(rq, rq->curr, 1);
+	rq->donor->sched_class->task_tick(rq, rq->donor, 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;



