Return-Path: <linux-kernel+bounces-858048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C58BE8ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 115E24EE451
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85B9330320;
	Fri, 17 Oct 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZjZ1mn4m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3jW5LeHs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053D330319
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705814; cv=none; b=j7mVI2z6GAnbuXhM6GVNffM/mHzW5StYaU8r2oOhDy8u2HlQyGAV92lz92p/8fjeXfZaPwhxEMlxDU+M3p2P/TH6oobNQZ2CauJCtq+f8vYWY55u9Dgk39cXEj/LfVLsHNnNJRU6s3+vjFbLU+j36MvHyA4EfCRDgHcLr4XrM8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705814; c=relaxed/simple;
	bh=tkw+JgQj4Lu5EVL4rxXAZ/UOMAZtDR9EXla/S5Y0TT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C0Cj5LumUcYCKj7qpT7Nt3zWVlYK/UGJViTnCZeLSid0J5R+D8HwC/jlI839WEiXbc43zOzYoqpz0MPq62hQ74yIFKi64k7O1wR4yOvwfVRJEEO6YN101o/zOzIMtzJLpbmjOqsDereo8CqzbtdcwdUqak2ovkCCmWM+HOg7GoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZjZ1mn4m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3jW5LeHs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760705810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/Y8+633mZamgRyeMp8imyH73FrBP34H1AVqn1g2DhU=;
	b=ZjZ1mn4msyaKLn4kGk2jAbhY6vMRT0ZXcg8E+yKQ5y9LdVuLJ91r+qy+E9qjp65bybx/K8
	8D9WrP7mMIMc7og1qyVztZmCFt+22CsLUD1WnH27MFcQxKuu3WKdgjxa8Jq9U+rGPsbWOv
	R9XqTa0DW0uY1uZDcsc2A3A8anBgo0S04dRi2/rKmPuh3AypNvUi3U7bEvhQT5CB2Lzl+p
	uCFDipJ2HEXRT5Ac3mFRTqleIrbU4kqFRfAr9sGktZQTWUZVkk/J8y7+ut6HSUWNK8OHOD
	vhFsqbYgs2uB2m8HliKM81xSrS6lsImsioGPdr7Vu6OdTBhfV3RR/rXtfw8s4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760705810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G/Y8+633mZamgRyeMp8imyH73FrBP34H1AVqn1g2DhU=;
	b=3jW5LeHszwSVSa2SIrGybzfAFc8DGVFNuUAT9wnJR9f1m1IkHOqguxz/8DPnyFS2rjMwPX
	26xklOMv8zIzMcAg==
To: Florian Weimer <fweimer@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Gabriele Monaco <gmonaco@redhat.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Tim Chen <tim.c.chen@intel.com>, TCMalloc Team
 <tcmalloc-eng@google.com>
Subject: Re: [patch 00/19] sched: Rewrite MM CID management
In-Reply-To: <lhuzf9plq78.fsf@oldenburg.str.redhat.com>
References: <20251015164952.694882104@linutronix.de>
 <lhuzf9plq78.fsf@oldenburg.str.redhat.com>
Date: Fri, 17 Oct 2025 14:56:49 +0200
Message-ID: <87v7kdznxq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 17 2025 at 13:31, Florian Weimer wrote:
> * Thomas Gleixner:
>
>> The CID space compaction itself is not a functional correctness
>> requirement, it is only a useful optimization mechanism to reduce the
>> memory foot print in unused user space pools.
>>
>> The optimal CID space is:
>>
>>     min(nr_tasks, nr_cpus_allowed);
>>
>> Where @nr_tasks is the number of actual user space threads associated to
>> the mm.
>>
>> @nr_cpus_allowed is the superset of all task affinities. It is growth
>> only as it would be insane to take a racy snapshot of all task
>> affinities when the affinity of one task changes just do redo it 2
>> milliseconds later when the next task changes its affinity.
>
> How can userspace obtain the maximum possible nr_cpus_allowed value?

get_nprocs_conf(3), which reads /sys/devices/system/cpu/possible

