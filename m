Return-Path: <linux-kernel+bounces-886021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8649CC34865
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794D5427764
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D077B2D7DFE;
	Wed,  5 Nov 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="moqdvVrF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bwa4XoJ2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3382D6E4F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332166; cv=none; b=mDwOy46fkyPmAsgP9yd/FiXktbc3WRxpyZtGA4St0ctbssciDSHA583jJthOgptCGZpgSOTTrSnSEsj/JjDv/DSvJQYaON02ydtB711hOa/zzqqhEXMvOKRjyj2RWHk1G9wOTnHtPs4TOz+9sRNpCUAj85Puq7ipeMcwMC3jD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332166; c=relaxed/simple;
	bh=dNDKDe1el1Fy5qpKhQukmgyHlhfNQ712+a+Pi2KbykM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ii+aHZKxlw10s63lv/WrSX9+GUNRnoRaPxR5uIyjeLfab7lAgznKCzwcTS6h2VsLTII1jx+eFxXBDpeBpusPL3XrUqMqv51jaIYqhe99yvUXtPl4R1Cz6AQ29QieuZyCO8Hon9n+0KOOw+yxFLMA5fe1Pb2hFq763LszXVmnipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=moqdvVrF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bwa4XoJ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762332162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E2+RHG/sHfe7Kc0FCzIGlIE8f++XmIso7puKodenZBU=;
	b=moqdvVrFM1Efsn/yhr0jYiDif1LZnTr1mK5bDkKfBKk9cugGOqD0lnOCPCDdpH7sXYRJCF
	5Ys9IGDpjS7i1IVpO8OQ/6ypU8GtBFpjiEZzF822fJU/FbREM6Dx5FGz6MBrQSRMohglkD
	22YCTwASFh+kXwKpFuz78ROZ+W4m9rbmsbPyEh5omhIrITeKePnQoMZpwbqYoSS6CY/+Rz
	WvHvUxphaR5TsS4ZRWY8T1GeTCuAMmlPTIL8lzJtrMXegyC92oBCBz9fDGQOR7hQWAN2lH
	QSl9JUGPZEUIGEeCTkuPl1xI/TxcU+JsruFnq6dEzaOWWGu8xNsdGGkiilnfDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762332162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E2+RHG/sHfe7Kc0FCzIGlIE8f++XmIso7puKodenZBU=;
	b=bwa4XoJ2e7NDMZWNNB4iaugk+CkW1tTqTyqCmLE79dSDKJ65BF905PEV0F0vS7uowi0r0v
	4+/VET3EKBQFjtBQ==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Mel Gorman <mgorman@suse.de>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider
 <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp: Suppress false DEBUG_PREEMPT warning in
 smp_call_on_cpu()
In-Reply-To: <20251024140832.46JNLRvL@linutronix.de>
References: <20251024070714.4047816-1-namcao@linutronix.de>
 <20251024140832.46JNLRvL@linutronix.de>
Date: Wed, 05 Nov 2025 09:42:42 +0100
Message-ID: <87ikfolvjx.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> This appears after commit 06ddd17521bf ("sched/smp: Always define
>> is_percpu_thread() and scheduler_ipi()"). Before this commit,
>> is_percpu_thread() always returns true on UP kernel and thus
>> debug_smp_processor_id() always sees a per-cpu thread and never warns. But
>> now is_percpu_thread() returns false for this case.
>> 
>> Suppress this warning with a migrate_disable()+migrate_enable() pair.
>
> Right. This is one of the possibilities. The other one would be to also
> workqueue on UP and preserve the same semantic.
> I don't mind this.

Yeah it's a tradeoff. I'm not sure if someone will be bothered by the
overhead that workqueue introduces, so I use this cheap solution.

>> +
>> +	/* suppress warnings from debug_smp_processor_id() */
>
> If you want to add a comment, what about something like
>
>   /* Preserve not being migratable such as SMP variant does */ 

Wouldn't it be a bit misleading? It's true that technically SMP variant
is not migratable, but that's because it is a per-cpu thread, not
because of migrate_disable(). To me, the comment sounds like that there
is also a migrate_disable() in SMP variant.

Nam

