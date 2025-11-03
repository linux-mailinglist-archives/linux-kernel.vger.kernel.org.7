Return-Path: <linux-kernel+bounces-882980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C96EAC2C131
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3703188C03E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D6526C3AE;
	Mon,  3 Nov 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LsXlgl30";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dJ6PLeb4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF2265629
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176488; cv=none; b=n0LMI5Lc8vm46On/NqkhQANnJ3LY5IEr9hmd8RumNZs2U8iNe4Wae8fU1fFjji63qOdAeanCro9I09dwBxvoUmM36svNaJUz6+vbprb5SBXDdCzhwTtKjZFI+mtv4fRJTANb6K4OEdUy89rUQT6JB09lqTDATgvLORhYJ0SjxrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176488; c=relaxed/simple;
	bh=b7G2qm0HnGJniKLxCGXZ2ooxpRdxzu7y1Euk2kB4ydQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=exb/q0P98VCSZgWs25jrcadP5VqrdieExla+oWqEJ8WhTXb6KsdVtoVRwaaKCd8ZXZipqo67CT6zJWY5r6oyf2vA/tWz/ZkYCc0bLheyRklrc+EqzrI3wdVl7rB7BQTDJXeqTfnvQUKxLYhK2AA06J5vjD+BPTLKvt2PeGQ+hvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LsXlgl30; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dJ6PLeb4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762176484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3h2bJ/FNA85uqXLMAmHxQlPHnKHNzu2LkySt72HDas=;
	b=LsXlgl30LUqKQVQJcOoKzxQ4SVqB56+6y/FIhFPqbA59T3ros1ucPX1Yk6Da0F+Yk+OeME
	JAQr6yQZtMXaF7s6+y5bdGhxLx6ZfYULYgibyI3zs1v6HnTS37+abwU6erhzkf+uRUQdN3
	C/O7ewhJpAW2oUYJkdMg5DglqWL3gu4lP2Z9ovciaCmJuCMVpHVB3gqg4X5mWE9NEnQmYE
	9ZCQ47celJmuU1UpremMxrGhS3otFbVSSZj7yaxEisy17CjVPBbtTzva4K/o/uGRTu5Tmo
	jr6sLUsQIbLm4iljOchUQ5XldxpIKTmZ7QRTOwLhu9kNHYsIrt8kFe68gWgcmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762176484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3h2bJ/FNA85uqXLMAmHxQlPHnKHNzu2LkySt72HDas=;
	b=dJ6PLeb4eIyJBuGq9QzEMCY5jqh/nsQKCjZAhhSDdxQbk6A5x8Y/dzizfkif54C2NcHlRg
	DskYeDctigr4SxCA==
To: Shrikanth Hegde <sshegde@linux.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [patch V3 09/20] cpumask: Cache num_possible_cpus()
In-Reply-To: <4cdfd743-3cfd-4317-8e24-0f94e6fa8d39@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.846126176@linutronix.de>
 <4cdfd743-3cfd-4317-8e24-0f94e6fa8d39@linux.ibm.com>
Date: Mon, 03 Nov 2025 14:28:03 +0100
Message-ID: <87tszbw8ik.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 03 2025 at 15:36, Shrikanth Hegde wrote:
> On 10/29/25 6:39 PM, Thomas Gleixner wrote:
>> Reevaluating num_possible_cpus() over and over does not make sense. That
>> becomes a constant after init as cpu_possible_mask is marked ro_after_init.
>> 
>> Cache the value during initialization and provide that for consumption.
>> 
>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>
>
> Observation:
> I see below usage which could be improved too?
> kernel/irq/affinity.c:		set_vecs = cpumask_weight(cpu_possible_mask);
> lib/tests/cpumask_kunit.c:	KUNIT_EXPECT_EQ_MSG(test, nr_cpu_ids, cpumask_weight(cpu_possible_mask),
>
> Specially irq_calc_affinity_vectors, it seems to take cpus_read_lock, but I don't think
> that lock is protecting possible cpus. possible cpus can't change after boot. No?

It can't. So yes the cpus_read_lock() is pointless.

