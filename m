Return-Path: <linux-kernel+bounces-880450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F1DC25C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8779188B454
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E551FBCA7;
	Fri, 31 Oct 2025 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W3J5HUEr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MWn6tRjo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E9143C61
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923219; cv=none; b=qhVeZrs0Kd4hWniiyl0/8ENHofzCxCJOYQw7UaPlwPee+luJWVBZ+YeZLjur8aX/lBUxmCjr4pUg93ljmNcB/dmpy/fFGY0S89DL/Oi7M9D5fXSQDervAdrdgpdyigqIJQCoF73Jd8KuaHpv1u68ccpTEwT77KiNOwvFtCetuEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923219; c=relaxed/simple;
	bh=7/6VbJnEFzUOkpCEDq6PT0h8f2/cbWOXJThZNAaTlBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NUkCsnoseewvcfa/ajLZ/ew3A7uTJvDdWi+S4mkrw5AFaEt8HyTbV5i2hHoaqV4iAxeoZb+ScBamm52Ex7s5s1eJqJIgWhcuv1FSPRlJk+T8YY7MzA0WC12EVBR/fApT0WxV+vo5lsguDTatQxiOgIz95m7uz0VxhNiebWP8uo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W3J5HUEr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MWn6tRjo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761923215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9NAz2OeXX8Q9qQ0dK8zhDG2LLtrvp1mfSNEe7R7pBuQ=;
	b=W3J5HUErB7VNbNkX5aiE4exUauS2Y6IIYyqrQ+hJPERHhi3L0ZvIxtHZezMzqRIM0XstZE
	taoZdEcI2j46y8T1VX1jvO2QDoxbpWYPk77T61cW27al91ywbD5QTe9pGKpV2H7HYRA8JN
	J1Qgv7P0aDs2v9IFtIr8JeHyPOKlNAcZ6NY1BjDxVTEuvB0b0rqIzmSGeD2QjCL50NOGiX
	uE1Epu/gIijoZZVkC0CL75HxY/ZCGSvJPKy2Q1AXqQP+lLi5rZwlpvtao9vaX+4w8p0CJs
	ySzl1Mr0f5e6rbI08Y70ROLsht37ydh9meQpRUkqCkMiVDRtW65Kxq5mwbPSmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761923215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9NAz2OeXX8Q9qQ0dK8zhDG2LLtrvp1mfSNEe7R7pBuQ=;
	b=MWn6tRjoWwQoLceNsa4N2rUxHpCfdOQ/iWIw3q5x4XvcO1CcEkDuEHkhlvsw4NEmcxtzRT
	elDtxMBsYCmAIbDQ==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, Jens Axboe
 <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim
 Chen <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>, Shrikanth
 Hegde <sshegde@linux.ibm.com>
Subject: Re: [patch V3 13/20] sched/mmcid: Provide precomputed maximal value
In-Reply-To: <36caa866-1f22-4825-aaf5-6e4d2629a4e2@efficios.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.098047550@linutronix.de>
 <36caa866-1f22-4825-aaf5-6e4d2629a4e2@efficios.com>
Date: Fri, 31 Oct 2025 16:06:54 +0100
Message-ID: <87zf97rtyp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 30 2025 at 10:23, Mathieu Desnoyers wrote:
> On 2025-10-29 09:09, Thomas Gleixner wrote:
>>   struct mm_mm_cid {
>>   	struct mm_cid_pcpu	__percpu *pcpu;
>> +	unsigned int		max_cids;
>>   	unsigned int		nr_cpus_allowed;
>> +	unsigned int		users;
>
> I suspect this reintroduces false-sharing between the "users"
> and "lock" fields (updated every time a thread is forked/exits)
> and load of the pcpu pointer which is pretty much immutable.
> This will slow down accesses to the percpu data in the scheduler
> fast path.

At this point yes, but when all bits are in place then the lock fields
end up in a different cache line.

The false sharing issue vs. *pcpu and max_cids is minor, but I can move
the low frequency modified members past the work, so it does not matter
at all. The work stuff is rarely used, so there is no point to worry
about the occasional cache line contention on that.

Thanks,

        tglx

