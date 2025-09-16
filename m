Return-Path: <linux-kernel+bounces-818975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED242B5991E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E291169646
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D455C129E6E;
	Tue, 16 Sep 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MGfv1GQR"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9D21254D;
	Tue, 16 Sep 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031855; cv=none; b=PrLXa3Mg8Bmb47deL/zdexi0KM7vwC6P+4zkoxPtChpZO1G531DCd2ac8WqZJecJvxtBXLKNoppuf6WVs9sj1esPWfHQa8SkDcQxKRid5DaHcleY0RZpJ4eWuZlqJt3m5Sw5SlWC3KWLrv60gJFm0nnXz5UTnF1OCPJrxD4mzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031855; c=relaxed/simple;
	bh=yynrSe/PUu1LCVU8saLqG0qiPvZwvfy8fNiyV/2Kyx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVqjmKY0gYiTPKwijHlZZvgtW7zbJFhOhyn7jp8Kpn0a4He6xXuka0b4d3B6dlCuLJc+cht+6Ka0n4jfgp7Tf9QFir4HDtsDDHHVLocYTHbkxA+Jc2J+L8Au71T8VwFFl0YzmJ26TDruE10Oz+4FzskE7jvxlE/PAiyXitelqm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MGfv1GQR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F7y6X3yo4sAIcRFK2gxVqiEpSXS0WzM0MhLAKz01chI=; b=MGfv1GQRMK9ltlNA1KQ5pYBYBw
	OZG8VKRXcRgrxy8QfzkpeXdtaq6NRLteVHUK/AXmlXuAtRXq5CZp5Aiw14CMvQIOeiuMQi42Vi8aN
	njDezIZkAFOuEb2Yno5tD4cYUq3TO1AgzM3KRI6vMOUhpwsaxQwn7Ki2XmkTj3PnL2rFJSW9co94l
	Ls04JUVfAzOMU3IJYRrx7Y9ZS7mrsCVLqGFLmOlGxxVMITRybCrhwqugk/Mq7c2zxm/yJqjsQLR0I
	DoIsZi01WbBGM33qgbO6M2VJUiySvbB2q2w3TQsg2y4uykD3jrLtf9I+Kgbg/7I0cRkNeZnjsYLsb
	ScOajYIQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyWOB-00000007DL9-0gq4;
	Tue, 16 Sep 2025 14:10:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AC6BF300230; Tue, 16 Sep 2025 16:10:32 +0200 (CEST)
Date: Tue, 16 Sep 2025 16:10:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: pengyu <pengyu@kylinos.cn>
Cc: mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
	longman@redhat.com, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, t.haas@tu-bs.de,
	parri.andrea@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	paulmck@kernel.org, jonas.oberhauser@huaweicloud.com,
	r.maseli@tu-bs.de, lkmm@lists.linux.dev, stern@rowland.harvard.edu
Subject: Re: [PATCH] locking/qspinlock: use xchg with _mb in slowpath for
 arm64
Message-ID: <20250916141032.GJ3245006@noisy.programming.kicks-ass.net>
References: <20250916033903.3374794-1-pengyu@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916033903.3374794-1-pengyu@kylinos.cn>

On Tue, Sep 16, 2025 at 11:39:03AM +0800, pengyu wrote:
> From: Yu Peng <pengyu@kylinos.cn>
> 
> A hardlock detected on arm64: rq->lock was released, but a CPU
> blocked at mcs_node->locked and timed out.
> 
> We found xchg_tail and atomic_try_cmpxchg_relaxed used _relaxed
> versions without memory barriers. Suspected insufficient coherence
> guarantees on some arm64 microarchitectures, potentially leading to
> the following issues occurred:
> 
> CPU0:                                           CPU1:
> // Set tail to CPU0
> old = xchg_tail(lock, tail);
> 
> //CPU0 read tail is itself
> if ((val & _Q_TAIL_MASK) == tail)
>                                                 // CPU1 exchanges the tail
>                                                 old = xchg_tail(lock, tail)
> //assuming CPU0 not see tail change
> atomic_try_cmpxchg_relaxed(
> 	  &lock->val, &val, _Q_LOCKED_VAL)
> //released without notifying CPU1
> goto release;
>                                                 //hardlock detected
>                                                 arch_mcs_spin_lock_contended(
>                                                       &node->locked)
> 
> Therefore, xchg_tail and atomic_try_cmpxchg using _mb to replace _relaxed.

Yeah, no. We do not apply patches based on suspicion. And we most
certainly do not sprinkle #ifdef ARM64 in generic code.

There is this thread:

  https://lkml.kernel.org/r/cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de

Which is also concerned with xchg_tail(). Reading back, I'm not sure
we've ever heard back from ARM on whether that extra ;si was correct or
not, Will?

Anyway, as Waiman already asked, please state your exact ARM64
microarch.

Barring the ;si, the above thread suggests that they can prove the code
correct with the below change, does that resolve your problem?

Other than that, I'm going to have to leave this to Will and co.

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index af8d122bb649..249231460ea0 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -261,14 +261,8 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		goto release;
 
 	/*
-	 * Ensure that the initialisation of @node is complete before we
-	 * publish the updated tail via xchg_tail() and potentially link
-	 * @node into the waitqueue via WRITE_ONCE(prev->next, node) below.
-	 */
-	smp_wmb();
-
-	/*
-	 * Publish the updated tail.
+	 * Publish the updated tail. This is a RELEASE barrier and ensures the
+	 * @node is complete before the link becomes visible.
 	 * We have already touched the queueing cacheline; don't bother with
 	 * pending stuff.
 	 *
diff --git a/kernel/locking/qspinlock.h b/kernel/locking/qspinlock.h
index d69958a844f7..bb9a006e76eb 100644
--- a/kernel/locking/qspinlock.h
+++ b/kernel/locking/qspinlock.h
@@ -117,7 +117,7 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 	 * We can use relaxed semantics since the caller ensures that the
 	 * MCS node is properly initialized before updating the tail.
 	 */
-	return (u32)xchg_relaxed(&lock->tail,
+	return (u32)xchg_release(&lock->tail,
 				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
 }
 
@@ -167,7 +167,7 @@ static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
 		 * the MCS node is properly initialized before updating the
 		 * tail.
 		 */
-	} while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
+	} while (!atomic_try_cmpxchg_release(&lock->val, &old, new));
 
 	return old;
 }

