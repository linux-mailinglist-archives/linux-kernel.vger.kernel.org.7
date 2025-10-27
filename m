Return-Path: <linux-kernel+bounces-871153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8B0C0C87B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7E694F5D09
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274E22F25F6;
	Mon, 27 Oct 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YsmeIQP8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oSFIPMt9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AA2F3632
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555281; cv=none; b=k1uKvXn4oLdtDHrGMxdXar+wz5VjWG5X7Obf70oK1kydvIrPS9EqOjzJgiZev6mXIOgajANI+sV9KxIZaGjoa7kczrdKhKHvpvGBwEllh1v4Ukpu6VDmhU8H/zkGsXSVXZZysmiAi16iz9AilwhooZDpJQhTHfBlRY0vlNrdRsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555281; c=relaxed/simple;
	bh=YBmwTIvn4p00rYbr/pLTzquF/LQGyMuikin2At+knsA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YATf/eEcR2LgWcXN1SI+zVzJcpAmfosQR8BB8wqnIRQSYEVCFypML5jyfrQdwyDiacUUlT+BQDvstbh4vp21gq5dc0LsHvJHSr9zdP5isQAwhS3WGG+R2fh2UYbmrtw6f3him85w++Ozk6/UHX69aaHGcPiQJZjqV7G+VYP+nfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YsmeIQP8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oSFIPMt9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761555278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wADVRJvytaaWYRB+ePAV85hnF5m9541y74Pe50E1fZI=;
	b=YsmeIQP8S5/E25k3rwutuq+qQsolOVlhOTHUnDexDGFCkFrHdxhoqTT3j4HSbjWO/eh3bh
	ws51Q5qDygFbUuo9tkbjwBPSyDMCe7ZduKzOsVawUkjTHIVQ0SGfBb0WK+GaAGv/Q3j5rH
	QbE7eR6KkenDzVeTCiEc9aiVvHER+zUJJ9sZz/hpZweEJ9/q6Ud0ZpQ0F9lNcMEtRosSQc
	nsP6h/NOsI6hq2iYLLdgDgO/MPXa8gIwYj2RiIjZVLQepB2mgtUrjeggM4hqUj9K+Zw2ER
	1/zXoGSDqOvFmIBy0/WHQck8aQpTlOXvnIp3D4ruoF6dMeLf4TQpJTGPwpOv9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761555278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wADVRJvytaaWYRB+ePAV85hnF5m9541y74Pe50E1fZI=;
	b=oSFIPMt9Z1bsEXRk4Vnk69ZGkKjQvDEd3BNgP5hBFPT/ptpcHdW4WkGr7AjAEYIF46zjmZ
	p6nXBMQn7vCpeiDA==
To: Shrikanth Hegde <sshegde@linux.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>
Subject: Re: [patch V2 16/20] sched/mmcid: Provide new scheduler CID mechanism
In-Reply-To: <9076c353-a22b-4c38-bd30-fb10eb0ae851@linux.ibm.com>
References: <20251022104005.907410538@linutronix.de>
 <20251022110556.399477196@linutronix.de>
 <9076c353-a22b-4c38-bd30-fb10eb0ae851@linux.ibm.com>
Date: Mon, 27 Oct 2025 09:54:36 +0100
Message-ID: <87ldkwwwqb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27 2025 at 10:41, Shrikanth Hegde wrote:
> On 10/22/25 6:25 PM, Thomas Gleixner wrote:
>> The MM CID management has two fundamental requirements:
>>=20
>>    1) It has to guarantee that at no given point in time the same CID is
>>       used by concurrent tasks in userspace.
>>=20
>>    2) The CID space must not exceed the number of possible CPUs in a
>>       system. While most allocators (glibc, tcmalloc, jemalloc) do not
>>       care about that, there seems to be at least some LTTng library
>>       depending on it.
>>=20
>> The CID space compaction itself is not a functional correctness
>> requirement, it is only a useful optimization mechanism to reduce the
>> memory foot print in unused user space pools.
>>=20
>
> Just wondering, if there is no user space request for CID, this whole mec=
hanism
> should be under a static check to avoid any overhead?

The problem is that CID has been introduced unconditionally with RSEQ
and there is no mechanism to opt-in. So we could go and change the ABI,
but as you know that's generally frowned upon.

I thought about adding a static key, but that'd be systemwide and
would probably required to be opt-out for the same reason.

>> +static inline unsigned int mm_get_cid(struct mm_struct *mm)
>> +{
>> +	unsigned int cid =3D __mm_get_cid(mm, READ_ONCE(mm->mm_cid.max_cids));
>> +
>> +	for (; cid =3D=3D MM_CID_UNSET; cpu_relax())
>
> This triggers an compile error on ppc64le.
>
> In file included from ./include/vdso/processor.h:10,
>                   from ./arch/powerpc/include/asm/processor.h:9,
>                   from ./include/linux/sched.h:13,
>                   from ./include/linux/sched/affinity.h:1,
>                   from kernel/sched/sched.h:8,
>                   from kernel/sched/rq-offsets.c:5:
> kernel/sched/sched.h: In function =E2=80=98mm_get_cid=E2=80=99:
> ./arch/powerpc/include/asm/vdso/processor.h:26:9: error: expected express=
ion before =E2=80=98asm=E2=80=99
>     26 |         asm volatile(ASM_FTR_IFCLR(                             =
        \
>        |         ^~~
> kernel/sched/sched.h:3615:37: note: in expansion of macro =E2=80=98cpu_re=
lax=E2=80=99
>   3615 |         for (; cid =3D=3D MM_CID_UNSET; cpu_relax())
>

Duh. Did not notice because x86 implements cpu_relax() as a static
inline while PPC has it as a plain macro define. Let me move it out of
the for() then.

Thanks,

        tglx


