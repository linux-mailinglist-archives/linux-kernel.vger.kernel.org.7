Return-Path: <linux-kernel+bounces-865008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB5EBFC03E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3255B18C16B4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4FE347FC3;
	Wed, 22 Oct 2025 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gUb/WTXu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MEZO1ISi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24816348878
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137733; cv=none; b=K5P5EpnWQdSjstXSzKtbh6GZWl640ffIO2TYIq2MJ/GPjejfOToC8SsO+Sfng8J+i16q8SYMpSldH7uPNfVml0C+Q8WKjH4iXBBkhLAS8weX4GTxfvXxk+h/sZUu5Bh9UxYqP6Nse5suAxOj1aRLdztiO5ypbb6co6hOfPB/4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137733; c=relaxed/simple;
	bh=KdFzBGh43sZZFcIMVinJN0yAQryEQC+o+chSK1GsoU8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=QJOWLrRWeXQSgEiquIf3U/8PkAtsjeUbN89FjtK3bMKfU80cAXC0Q90NsyxN7cphiNAydplU/Ek6oRg/aVO1CdoxQ6qzi0SZdj1mbDM1vWJn3zyljYakD2qOHyUKgKD7I3kdq7IXQPe0DGZuiM2f+e0Xu3NX7ggiFaYmQonjZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gUb/WTXu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MEZO1ISi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110555.901055185@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1kz1Oqwbh62r0ZPOr5l6i8T9huUxCdcsMGZc8Ht0brg=;
	b=gUb/WTXugEfI6//9yEjpb9eD1OhKEExCd/e1I2DA5lOdugHc4MLYZGi6D1eVmPYfm9kNOR
	/ndwgY1eXJyk7jvuPkdWOZbgUc1YjseS5wU++Gebxue9KliAh86jIh7PbCHin4WFXptWOW
	fr35lJ3Vh+mjnBPFNFfgLweN1jcQYInch4spQ77P6aL++FpgelnEDJAbgz9d98r0D8W894
	x6q7XewtPZVmGaAN3TghFSVHIDobLaWORWWAUWlw1Js9rJv+nu2D7j3HyUjW0LheGxdG26
	sqKy1hUUxy92fMVWussiaOu5fXkDJeWbsWrO2U1DDGdR7FGqPWdzFJgiPqgqXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1kz1Oqwbh62r0ZPOr5l6i8T9huUxCdcsMGZc8Ht0brg=;
	b=MEZO1ISiaIHRq2DQnKUSKcOqrc4ihjkbspLCEuQCntslGoojNJpVskJXMuFmHoI4c0MVUZ
	lRPyID/tkJcBv9CA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>
Subject: [patch V2 08/20] sched/mmcid: Use cpumask_or_and_calc_weight()
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:29 +0200 (CEST)

Use cpumask_or_and_calc_weight() instead of cpumask_or() and
cpumask_weight() on the result, which walks the same bitmap twice.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10375,6 +10375,7 @@ void call_trace_sched_update_nr_running(
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct cpumask *affmsk)
 {
 	struct cpumask *mm_allowed;
+	unsigned int weight;
 
 	if (!mm)
 		return;
@@ -10385,8 +10386,8 @@ static inline void mm_update_cpus_allowe
 	 */
 	guard(raw_spinlock)(&mm->mm_cid.lock);
 	mm_allowed = mm_cpus_allowed(mm);
-	cpumask_or(mm_allowed, mm_allowed, affmsk);
-	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
+	weight = cpumask_or_and_calc_weight(mm_allowed, mm_allowed, affmsk);
+	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, weight);
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)


