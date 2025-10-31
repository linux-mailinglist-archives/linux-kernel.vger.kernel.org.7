Return-Path: <linux-kernel+bounces-880349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CACC2592F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AE0B4EF589
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B8D34B1B9;
	Fri, 31 Oct 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kxcFP4UT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQEAfg5N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD1223DF0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920849; cv=none; b=B2qFakmWDgDoKmG/wg74sp9WXM3kT/fZFI8UrG+xGi2Zk58l1xsrOm6tN0kbfT4xmKzYb0UgmJ5IBcD0eR/xXoGyjZUSgXHS+K5GPZiYCznKiRHcIAOhIm+JH7ktgbErlHlYt9g8nFd/iS0XcCiOwP94rScn+bRM5A2KFnFzA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920849; c=relaxed/simple;
	bh=6dabikcygS5NFGAJn1YRnp2DMF+Tl2EmigcpVURkj3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kp7Nl+Dr2YSVZGQ2eAeEvZLI609Oxt2NPAuRAkHErqzsAWwUhBRRPrqi+CFaP8it2nb56MHBzOtJjct9Ife2sG3aXSNkvsnWrZ+6Lvp8eCb/HrbLAC4owJQ56/CKNIjemrrvOlYLL422yf5ERckif28dfypOl8NZ9VisqthE+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kxcFP4UT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQEAfg5N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761920844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puHnyc20p8sAWYsRHJv+bIg840wKApr1Wt+zvBnTdM4=;
	b=kxcFP4UTZ2S10SgJ6dYc5lS2OufRvY5RnnE1p3+oWjSJjM0QPalpHavX01uiWMwewtyr+f
	sZDgr/Vg8H3nQMG5WuUHxt2HN6puLXWxiDShZRsrMzPUuYvtRS0eD7o++yf6YLAoMxw4HY
	qqI3szZ2xJQgrcjQAUpgMK6fmEzj3vJhi1kZMun/KBFnSiI3lhoIlJGeRq5tvPik9352Vg
	AbSoWvcwlz9haEhIbTj65cOVBasgsPOB/vKidXbnOtlaeAwJAl/ZG5N+l/YyWgiCZkAeDH
	eBi0MeUgH/dkp1kMSWTbEczve69FsMOIU89sb724CNlHlKytr9hFx8Njv7cBRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761920844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puHnyc20p8sAWYsRHJv+bIg840wKApr1Wt+zvBnTdM4=;
	b=GQEAfg5NIAuBSHfOmdTtuzRwmt0TdRXgRmKGX/DAfCom4x00fMq/uucuKMpdan9+TZ/bKD
	F6kLOZ06Wv2LU6Cg==
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, Sean Christopherson <seanjc@google.com>, Wei Liu
 <wei.liu@kernel.org>
Subject: Re: [patch V6 20/31] rseq: Replace the original debug implementation
In-Reply-To: <C1AC58DD-70DC-49C3-A590-2A0198AE974D@oracle.com>
References: <20251027084220.785525188@linutronix.de>
 <20251027084307.212510692@linutronix.de>
 <C1AC58DD-70DC-49C3-A590-2A0198AE974D@oracle.com>
Date: Fri, 31 Oct 2025 15:27:22 +0100
Message-ID: <878qgrtad1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30 2025 at 21:52, Prakash Sangappa wrote:

>> On Oct 27, 2025, at 1:45=E2=80=AFAM, Thomas Gleixner <tglx@linutronix.de=
> wrote:
>>=20
>> Just utilize the new infrastructure and put the original one to rest.
>>=20
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> [=E2=80=A6]
>> void rseq_syscall(struct pt_regs *regs)
>> {
>> - unsigned long ip =3D instruction_pointer(regs);
>> struct task_struct *t =3D current;
>> - struct rseq_cs rseq_cs;
>> + u64 csaddr;
>>=20
>> - if (!t->rseq.usrptr)
>> + if (!t->rseq.event.has_rseq)
>> + return;
>> + if (!get_user(csaddr, &t->rseq.usrptr->rseq_cs))
>> + goto fail;
>
> I believe get_user() would returns non zero(-EFAULT) on failure.=20=20
> Noticed test program dies with segv when command line parameter rseq_debu=
g=3D1 is set.=20
>
> So, It should be
>   if (get_user(csaddr, &t->rseq.usrptr->rseq_cs))
> 	goto fail;

Indeed

