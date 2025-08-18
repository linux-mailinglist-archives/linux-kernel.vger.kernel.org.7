Return-Path: <linux-kernel+bounces-774443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE986B2B249
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C157561757
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFF01FBE87;
	Mon, 18 Aug 2025 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g4ow2P33";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="95gMMDS2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ECA19E992
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755548492; cv=none; b=cxM3LkWFe4PX7opySC3LhUK6eKfvoYHJn07QkgjQIRsqvUdCcD0XLD0T3AJ3brH5A2k1LAvnDK3uF8gku+K94HTrCk697ewdTlvol0hFp5gGsfzHs4+w7CDpvzhNuD/tsAjr5nh5TVTI6otPoQojvOZ7nUwMTYSIZ/0uXyLKdhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755548492; c=relaxed/simple;
	bh=QnFF18xM7NF5umi2GsQJs9I66Cz++OQUu9BiSNz0mgs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d3MkrURnumMwElkDkBEY421OnREm0rRvu9ZO/fNDwQP5/Z97xXbkLk7kVtxekpJmszqbd6tRhLw1jExkhjYqh+oyJbuLiY5irYYGhg1bZlp+IP+oWMLQVGSZKg9JzkYXM071qPlbO7tUV8xknPLqTPERA1jRYbMf/aLULjksAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g4ow2P33; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=95gMMDS2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755548489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Wzo+lLYrZ31wjnZN20owwWFH9AEgr+5AmwhileF3+c=;
	b=g4ow2P33zEQjmKEhc7ULHlzh6OE5rj+t1oBr1lGT6Wgbna66klE1yBSVBm8MKvV4ro2l/U
	6MZAKJoCB2S508deK0ZcaEMUm7cgJrCDtXu3/AKYF8A3SWVW6cwPfrHd6eS9rUkh1o81Ry
	GTdAjgzI/1CRbu6YgF7sTsKxOUlX26t/GrLDr6rKU2IHFuQb9KaUMpOpfMsgiZqJ937yxt
	quD6dci2gxTnBfgG2veMAuXrsIirM1l/Tivq0BfL/zyUsK7w4uCd9d007P9BRljs015Trt
	dQuBZxchS8+9e9f4DQVSjy2AtBLWky/YNHr1J4bPEIhBK5rDWhD1l/AOhnpCJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755548489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Wzo+lLYrZ31wjnZN20owwWFH9AEgr+5AmwhileF3+c=;
	b=95gMMDS29EhlfwimG+DpZXupwql4Abo819mY1MZ9kbUNVI+D5/GNjsTKhutohRKh4vB2FC
	fgkJhFB5BBgBlYAg==
To: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch 00/11] rseq: Optimize exit to user space
In-Reply-To: <e6906764-66bb-437d-8082-b1d6a48ffa55@efficios.com>
References: <20250813155941.014821755@linutronix.de>
 <12342355-b3fb-4e78-ad5b-dcfff1366ccf@kernel.dk> <87bjoi7vqx.ffs@tglx>
 <6b428c1f-4118-4ede-8674-eceee96036c1@kernel.dk> <877bz67u3j.ffs@tglx>
 <87y0rh63t0.ffs@tglx> <e6906764-66bb-437d-8082-b1d6a48ffa55@efficios.com>
Date: Mon, 18 Aug 2025 22:21:26 +0200
Message-ID: <87a53wxtx5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 18 2025 at 13:38, Michael Jeanson wrote:

> On 2025-08-17 17:23, Thomas Gleixner wrote:
>> Michael, can you please run your librseq tests against that too? They
>> have the same segfault problem as the kernel and they lack a run script,
>> so I couldn't be bothered to test against them. See commit 2bff3a0e5998
>> in that branch. I'll send out a patch with a proper change log later.
>
> I ran the librseq test suite on the new branch on a Debian Trixie amd64 
> system and it succeeds, here are the rseq stats before and after.

Thanks!

> Before:
>
> exit:             746809
> signal:                3
> slowp:                99
> ids:                1053
> cs:                    0
> clear:                 0
> fixup:                 0
>
> After:
>
> exit:          229294046
> signal:               11
> slowp:              4570
> ids:              615950
> cs:              2493682
> clear:            194637
> fixup:           2299044

That looks about right. Can you reset the branch to

     commit 85b61b265635 ("rseq: Expose stats")

which is just adding primitive stats on top of the current mainline
code, and provide numbers for that too?

That gives you 'notify: , cpuid:, fixup:' numbers, which are not 1:1
mappable to the final ones, but that should give some interesting
insight.

> If you want to run the librseq tests on your system, just do the regular 
> autotools dance and then run 'make check'.

Might be useful to put such instructions into README.md, no?

Thanks,

        tglx

