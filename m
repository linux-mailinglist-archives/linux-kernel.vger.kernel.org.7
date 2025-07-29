Return-Path: <linux-kernel+bounces-749039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBCAB14933
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3962B16F003
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEDD262815;
	Tue, 29 Jul 2025 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFhnJYpi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31409235041
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774416; cv=none; b=hwieIs6uZnbWupyiS14ErVDb9BwQrA0dgjsvWGMObsYY4jRUstMLYucSBCkQ6Y/djAHYJKDS8FflA+LapG/1KxRC3AAV/Hum5SR+QRkEF+utqAahJvc92ez1dPrqQQ5RO4HGo8jlS5XFmlDfzm+jWoaLbDc7sBk3TfNCYPp+xmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774416; c=relaxed/simple;
	bh=ewe/XbMDF853Rg/Iz2rVFV9Lh//MHFTpn3uY/o1JUSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw3K1A/oMOS0Y63obFkPxCYEU+T0p9eZtjTBgsglNcwBnuKy9CzY3qSjuY23hHHqbqKSL34Sl0morv8r/vALzs70ovz73KG5YjTA3XTKDa6S9oz0fFHrryMY1YR5HIoJsanEmUUfq0mcn4PX8lPxY8x7xcHQE3TzTHgBsPXhCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFhnJYpi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753774413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d/f22wV5Wc7j7i+hlhhZU4idac7ggCEqjSbOcPAu6AA=;
	b=HFhnJYpizIfcfaOI3Adwc9PnYN/vaH/ieoSF3uEF2cT5ZDe2FWGrwbW4jiJOiwGhSJGd+W
	+OPUpKZBgiNRXThYHXXma1Z+9kRx7UEKkwVWQOfREJLBYV+F0sOeGEa33jJZeL2pC6euba
	INrQx5bXHKI7yQtbZc8ejwZgrQUYuOg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-AfER4kIdPW-eFIHe3osDAQ-1; Tue,
 29 Jul 2025 03:33:27 -0400
X-MC-Unique: AfER4kIdPW-eFIHe3osDAQ-1
X-Mimecast-MFC-AGG-ID: AfER4kIdPW-eFIHe3osDAQ_1753774405
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55544195608D;
	Tue, 29 Jul 2025 07:33:25 +0000 (UTC)
Received: from localhost (unknown [10.22.88.125])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D53D818003FC;
	Tue, 29 Jul 2025 07:33:22 +0000 (UTC)
Date: Tue, 29 Jul 2025 04:33:21 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH v6] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <aIh5QajyaVT7MtVp@uudg.org>
References: <aGvTz5VaPFyj0pBV@uudg.org>
 <20250728201441.GA4690@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728201441.GA4690@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Jul 28, 2025 at 10:14:41PM +0200, Oleg Nesterov wrote:
> On 07/07, Luis Claudio R. Goncalves wrote:
> >
> > Instead of adding more complex conditions to decide when to directly
> > call __put_task_struct() and when to defer the call, unconditionally
> > resort to the deferred call on PREEMPT_RT to simplify the code.
>                               ^^^^^^^^^^^^^
> Confused... with this patch put_task_struct() always uses the deferred
> call, regardless of PREEMPT_RT?
>
> Oleg.

You are correct.

I mistakenly sent the patch from v3, with the updated description. I had
been working on that patch in parallel for a future RFC and mixed them up
when updating the description for v6. The changes from v4 onward were
updates to the patch description only.

The fact that I had discussed this patch (the one submitted) with some
people and was asking for tests to assess robustness and dependability
may have further composed the confusion.

I posted v6 (with the wrong patch) a couple of hours before leaving for
a 2-week vacation. This is also why I didn't notice the wrong submission
before. That was an unfortunate mistake on my part, no bad intent.

Not sure how to proceed here, if I should resend the correct patch or a
follow-up fix like this:

======

From: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Subject: sched: restore the behavior of put_task_struct() for non-rt

Commit 8671bad873eb ("sched: Do not call __put_task_struct() on rt
if pi_blocked_on is set") changed the behavior of put_task_struct()
unconditionally, even when PREEMPT_RT was not enabled, in clear mismatch
with the commit description.

Restore the previous behavior of put_task_struct() for the PREEMPT_RT
disabled case.

Fixes: 8671bad873eb ("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ea41795a352b..51678a541477 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -130,6 +133,16 @@ static inline void put_task_struct(struct task_struct *t)
 	if (!refcount_dec_and_test(&t->usage))
 		return;
 
+	/* In !RT, it is always safe to call __put_task_struct(). */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
+
+		lock_map_acquire_try(&put_task_map);
+		__put_task_struct(t);
+		lock_map_release(&put_task_map);
+		return;
+	}
+
 	/*
 	 * Under PREEMPT_RT, we can't call __put_task_struct
 	 * in atomic context because it will indirectly
@@ -137,10 +150,6 @@ static inline void put_task_struct(struct task_struct *t)
 	 * current process has a mutex enqueued (blocked on
 	 * a PI chain).
 	 *
-	 * In !RT, it is always safe to call __put_task_struct().
-	 * Though, in order to simplify the code, resort to the
-	 * deferred call too.
-	 *
 	 * call_rcu() will schedule __put_task_struct_rcu_cb()
 	 * to be called in process context.
 	 *
 


