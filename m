Return-Path: <linux-kernel+bounces-880652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8EDC2640B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 385654F0C22
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8331E301002;
	Fri, 31 Oct 2025 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Occ4LbmB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pZCRgTPL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE92F28F6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929827; cv=none; b=JwuV/VS27zvO85Rvs0t5vu0b6NXDg9GQFt6jojtN62iIi5osKdS1nuvQwcZNp6L+8jdpoesDOB+YgefLtoL155z0F1sxqxg8FnWKoAUpFNSudkVUbLAytUAwjqZ1YBs4eBktqAhcZNhfnVyPANuAnUh0XMp24mt85i0v4lsRYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929827; c=relaxed/simple;
	bh=ktJzeZKT4S9R0kurL7nULojRclTlHA+ttvd/q+SSIzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m+ohz9r88CNTbdaENigqZZeDgBb2+7yQrI9TVB4DrgtSoJNeIGZdM/lR4o/EN0ImOEILw0CWuTK7g4doFJoQ3ikchWOqYOa7JpqTNNza88Mr5hUyTWbNZkxilsuncYYrLCIJKhmn5f4j73KdJUzbaEhy+Jo62uGvtRv+5dyGi9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Occ4LbmB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pZCRgTPL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761929824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvehmcE2kAJSmmzwi+vGqjvk9eEe/mMa2mqYilU0ar0=;
	b=Occ4LbmB5aNeTxoQ/nIt0l8LZJ4c35KC+y3V8BDoXrO4WnHouLtbxQrqk/vWdnU4NoAGIY
	aJoi524NslINWIyHWIv+YPV+DUME/jSPE2+nJ6F7t88JyLG4zC/LTvS78BgKsfI7RZLRfx
	nHl9D5JXC55rT6yfnFs944m1vZfI1LdpoBE/cgNwUbUFIQBcP87t93kgz2QW8Btd9i2+uK
	C7aSdEb7MNOB/YNRGiGqb0eFmrLssCfcr42d8HlIz05kdGGU00+2S6qQDst5apj3kU7/Q8
	YglwUqzCYoR5OGRBxeESz6YUJMaDNAUqqKbpxybK2GhsAtjJHB076ONOPsH1uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761929824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvehmcE2kAJSmmzwi+vGqjvk9eEe/mMa2mqYilU0ar0=;
	b=pZCRgTPLVfyPOe0dfV3+H4CuIEQczSimoA3IRk8QC9LD50V3lcweX/4RhpGMPhS+VC8W7V
	eO6Rzt4H39TflsCQ==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, Jens Axboe
 <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim
 Chen <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>, Shrikanth
 Hegde <sshegde@linux.ibm.com>
Subject: Re: [patch V3 20/20] sched/mmcid: Switch over to the new mechanism
In-Reply-To: <72cc0b5f-b1e6-43d4-aaac-ef3ff2e20a01@efficios.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.529828589@linutronix.de>
 <72cc0b5f-b1e6-43d4-aaac-ef3ff2e20a01@efficios.com>
Date: Fri, 31 Oct 2025 17:57:03 +0100
Message-ID: <87tszfrov4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 30 2025 at 12:07, Mathieu Desnoyers wrote:
> On 2025-10-29 09:09, Thomas Gleixner wrote:
>
>> @@ -10702,10 +10758,43 @@ void sched_mm_cid_exit(struct task_struc
>>   
>>   	if (!mm || !t->mm_cid.active)
>>   		return;
>> +	/*
>> +	 * Ensure that only one instance is doing MM CID operations within
>> +	 * a MM. The common case is uncontended. The rare fixup case adds
>> +	 * some overhead.
>> +	 */
>> +	scoped_guard(mutex, &mm->mm_cid.mutex) {
>
> When exiting from a mm where mm->mm_cid.users == 1 (read with
> READ_ONCE()), can we do this without holding the mutex as an
> optimization ?

What's the optimization in that case? The mutex is uncontended and the
extra instructions for taking and releasing it are so trivial that you
can't measure it at all.

But aside of that this might race against a scheduled work which was
initiated by mm_update_cpus_allowed(). So keeping it strictly serialized
makes the code simple and race free :)

Thanks,

        tglx

