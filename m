Return-Path: <linux-kernel+bounces-863524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45156BF80CA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFEF424D13
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C44F3446D5;
	Tue, 21 Oct 2025 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mXsxciB2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jVwnlMIJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC434A3CA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071240; cv=none; b=SRgtXAqdbq6I5lYhJKVJGCplh1UC+XWf5+6Wz3mPrLTI1BZCjuTD03yIvggMAj8QxSziwXHGBDEF6SkeJoktiAZ1AjpCrhuOVQiSWTc8wWFeZHfy7brubOQx9BhMdTJQsYql7/dyFe0To++8U2eZpnNydhq4fG4cj1PJi2ed74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071240; c=relaxed/simple;
	bh=TO41T8cTnlLILRfMsNU71tgfeU1wi6t17Qr5OlxhmpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z4eHUWKqTJfGuuTxGQ8ZGnSOnJnipBv5vGPUBTljzuElWzCm+do+A4e5V3d+RAnZCCrBDorfPxY7cYk6ZTxCy5lbVh7JZwLMnBcR9vvWDTq4xQnWzFQNZdFxyBfAN667Bp7nI1kdOnuP9tNDLPonj4SudCXqHiJUV7ikVrgG0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mXsxciB2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jVwnlMIJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761071237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XKky2jLmJxwLchmHSd83F4t3GvFIaVrTmhBKTa4PtbU=;
	b=mXsxciB2RqQ4cbniSiALfaxgSJfpcpXpNjQcv6MoMWmMgAow8LFzd0sd7hP1zFM+SvM9cC
	cmchIipxZhsgGRKgC+eWFpYkdtbPxtYqvl5xJwKYiPfoQtNNvn3Om5tRsxHuOB2Y038dFr
	KRFLaIgR6Cir+Aqv5geweL4yrw1C1VhH9Y5kDi0dpOQdtD699alPq5y0rL2z0B+wKP8SgL
	tUAos0sD6hhkX5beelXh30kJITL91SsLdYlqZsHmEOdIemDs4DtgyoaG+OcLKG+5QVgi1g
	BzUomcX2YdrKsVoGajKF8K8ZOkGV91P2EkWd3wnpd4b02inlZcyRigZxGozXIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761071237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XKky2jLmJxwLchmHSd83F4t3GvFIaVrTmhBKTa4PtbU=;
	b=jVwnlMIJq3ADFPm2jSuqHEJUXOL8C7WpKzbGw235/Ua+sXbx3mM1Zwl+ekMTmpvcU7DH2l
	WKmVRyrbm6SJ7TBQ==
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, TCMalloc Team <tcmalloc-eng@google.com>
Subject: Re: [patch 16/19] sched/mmcid: Provide CID ownership mode fixup
 functions
In-Reply-To: <20251020092727.GI3245006@noisy.programming.kicks-ass.net>
References: <20251015164952.694882104@linutronix.de>
 <20251015172835.313805515@linutronix.de>
 <20251020092727.GI3245006@noisy.programming.kicks-ass.net>
Date: Tue, 21 Oct 2025 20:27:16 +0200
Message-ID: <87sefcxg8r.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20 2025 at 11:27, Peter Zijlstra wrote:
> On Wed, Oct 15, 2025 at 07:29:54PM +0200, Thomas Gleixner wrote:
>
>> +static bool mm_cid_fixup_task_to_cpu(struct task_struct *t, struct mm_struct *mm)
>> +{
>> +	/* Remote access to mm::mm_cid::pcpu requires rq_lock */
>> +	guard(task_rq_lock)(t);
>> +	if (t->mm != mm)
>> +		return false;
>
> I'm slightly confused about this one; I'm assuming it is a double check
> of mm for the VM_CLONE case below, once before lock once after. Except,
> none of the scheduler locks actually serialize t->mm ...
>
> IIRC the only way to actually change ->mm is exec(), and that is under
> task_lock().

Right. That's also where the task removed itself from CID
management. Let me look at that again.

