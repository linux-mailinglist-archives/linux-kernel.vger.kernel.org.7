Return-Path: <linux-kernel+bounces-796717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECC8B40642
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718A0188C08A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFBE2E8B9B;
	Tue,  2 Sep 2025 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z8RnqOW/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z7SFdjE6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041202EDD6B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822111; cv=none; b=OdbY58fC9YthZZzy3bN613Tyi/NGcBTZ5w1HyMbQOH7f8bbJswQ6noqZCIQRIQvvRLRlcuF/5sWAQNPfLBvjnXG4fpz2O/C8KhHdaU6zOtH6Cd51mU7wJN851QJysqNlCKehqmoPgEzsirsC3BWmUJAFZO1+mFETwNUJ+TdWqjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822111; c=relaxed/simple;
	bh=59UdRKkFcaP3p5jILGaPs6mWXRDMQiYUbbdm3YUePe0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V3g31ERYvqVUcFXuRPSoaI7HaU/heMxfRx10qFN47adaH8mnhWZJt8BhVjLZJxrNo7zOibv4QyAjp5mU2aLAsCsqL+hZSAWckzSP81xB81kt0tvXxsyC786CWBAhnrrCZC0J0EmUVD83YxAWHvpJ9l0BT9RTiJfZYvxHXVjiO6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z8RnqOW/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z7SFdjE6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756822104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRP4QvgfyToJOkya1uqq2coNCL4yAm9Cv3inRFxZrtQ=;
	b=Z8RnqOW/4+Iu1KXRUcRWJzAj/xO18y4CrC1c5TeO6bRiaXFGl6oD7cVS/3qUul3EH0O8Z5
	YBbFKYZOxTf0BUzBqfkncskShpkKuK2WVv3Q3qn1ZYzGBxvBjsaxza3hnUN1xKVhpOSJV7
	W7vFGvvxQ4ZLdykpMmU+cgCnd+s2rQDX3C6qYn/9AmKc9KTKaMDEB2sl9Blgx63hoXBXrG
	r4OdIaaNRUeVi0eAWBrrWuVkhVfifuYPt1oKlVN0DkHgaYzJ5djkysJV5jx2NDwFC4B3/0
	Te0qdQ5tZtssy91YPgN+NCd6V6zFCvHT09mSSwdQARAg/uJbwR/mqLy5fWo38w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756822104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRP4QvgfyToJOkya1uqq2coNCL4yAm9Cv3inRFxZrtQ=;
	b=Z7SFdjE6y/3FuzcCMoodTjX5/IfbBBMVJ1PfdZhr+pwvF7E79thaytnSBDGNfkXhBxPl9n
	IXBC0gBEh24dRMCQ==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Huacai
 Chen <chenhuacai@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V2 23/37] rseq: Provide and use rseq_set_uids()
In-Reply-To: <e87fb53b-329b-44dc-a14e-e8c7a49d9adf@efficios.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.741798449@linutronix.de>
 <e87fb53b-329b-44dc-a14e-e8c7a49d9adf@efficios.com>
Date: Tue, 02 Sep 2025 16:08:23 +0200
Message-ID: <878qix0wx4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 26 2025 at 10:52, Mathieu Desnoyers wrote:
>> +{
>> +	u32 cpu_id, uval, node_id = cpu_to_node(task_cpu(t));
>> +	struct rseq __user *rseq = t->rseq;
>> +
>> +	if (t->rseq_ids.cpu_cid == ~0)
>> +		return true;
>> +
>> +	if (!user_read_masked_begin(rseq))
>> +		return false;
>> +
>> +	unsafe_get_user(cpu_id, &rseq->cpu_id_start, efault);
>> +	if (cpu_id != t->rseq_ids.cpu_id)
>> +		goto die;
>> +	unsafe_get_user(uval, &rseq->cpu_id, efault);
>> +	if (uval != cpu_id)
>> +		goto die;
>> +	unsafe_get_user(uval, &rseq->node_id, efault);
>> +	if (uval != node_id)
>> +		goto die;
>
> AFAIU, when a task migrates across NUMA nodes, userspace will have a
> stale value and this check will fail, thus killing the process. To fix
> this you'd need to derive "node_id" from
> cpu_to_node(t->rseq_ids.cpu_id).

Good catch.

> But doing that will not work on powerpc, where the mapping between
> node_id and cpu_id can change dynamically, AFAIU this can kill processes
> even though userspace did not alter the node_id behind the kernel's
> back.

Still not an issue. You might need to reread the related PPC code :)

>> +
>> +	/* Cache the new values */
>> +	t->rseq_ids.cpu_cid = ids->cpu_cid;
>
> I may be missing something, but I think we're missing updates to
> t->rseq_ids.mm_cid and we may want to keep track of t->rseq_ids.node_id
> as well.

Oops. I'm sure I had that mm_cid caching, but somehow dropped it. And
again, no need to keep track of the node id. It's stable vs. CPU ID.

Thanks,

        tglx

