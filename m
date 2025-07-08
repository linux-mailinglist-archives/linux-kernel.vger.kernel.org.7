Return-Path: <linux-kernel+bounces-721499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 935A1AFCA05
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6603B60AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9CF2D29AA;
	Tue,  8 Jul 2025 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="r3/mwM4c"
Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E321FF29
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976142; cv=none; b=MpBq9tdULdlN2846TY0LuTswjCVfC2XCuw99QISHNh6+gOkW7l/WPd6WdzUJpAsqxS5UtIab40ejkN75rsVcM/7uPfsJeK3v9FSUnztbbrObbHiqrry1r0It04S79Bk46o6FXBkLynLYllSE9Eo1uKrQZmC+pUKouebkqbkwy/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976142; c=relaxed/simple;
	bh=MyWahUVsrSw8VyeEhoUXrvr4RI83F70zTnzpkVi7jpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeMKdPutqcu/+xQxZpW1Eo9OrLuHyw77abYFwy3XYwb9WyIRVplIExyQY34Efu9vODMj9gKE2qwUDod7dpSJI901Du9EVxayD4DBlJHLH3WbWRguim3FhUjVYv9WuZd+Q0fNZ9UrSle2VdCkF9sX5HRLTDpt34igKKQIMD+ouiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=r3/mwM4c; arc=none smtp.client-ip=202.108.3.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1751976136;
	bh=HYlykt8mV3P/ZhjukZ1Yc4iNnbMPL5Jbgc7pI6fvUHU=;
	h=From:Subject:Date:Message-ID;
	b=r3/mwM4cnYyMZPb4FWGGHRA13q4+XJBNMn94ucjz9ZSq6hM1RD4R4GgzQ+FIJm8l9
	 q+1e43ZXKK3owJJ2QPlEErTEx1pmEst0y2EeVptPw7etmblViC/Si+mbEcItPoJT78
	 IkPol0bAslNibLpmUQyHLS3CfcDFusk84qZ03icE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 686D08BF000014B9; Tue, 8 Jul 2025 20:02:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3186586816260
X-SMAIL-UIID: 90A9BA681F414F48B01ED350FFBC0836-20250708-200208-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/3] futex: Use RCU-based per-CPU reference counting instead of rcuref_t
Date: Tue,  8 Jul 2025 20:01:56 +0800
Message-ID: <20250708120156.2938-1-hdanton@sina.com>
In-Reply-To: <20250708091626.BYR6lG2J@linutronix.de>
References: <20250707143623.70325-1-bigeasy@linutronix.de> <20250708085640.2918-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 8 Jul 2025 11:16:26 +0200 Sebastian Andrzej Siewior wrote:
> On 2025-07-08 16:56:39 [+0800], Hillf Danton wrote:
> > On Mon,  7 Jul 2025 16:36:22 +0200 Sebastian Andrzej Siewior wrote:
> > > +static bool futex_ref_get(struct futex_private_hash *fph)
> > > +{
> > > +	struct mm_struct *mm = fph->mm;
> > > +
> > > +	guard(rcu)();
> > > +
> > Like regular refcount_t, it is buggy to touch fph if futex_atomic drops
> > to 0. And more important guard(rcu) does not prevent it from dropping to 0.
> 
> What is your intention with this? There is an inc-if-not-zero to ensure

I am just simply wondering why get and put do not work without the rcu guard?

> this does not happen. And it has to drop to zero in order to get
> replaced.
> 
> > > +	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
> > > +		this_cpu_inc(*mm->futex_ref);
> > > +		return true;
> > > +	}
> > > +
> > > +	return atomic_long_inc_not_zero(&mm->futex_atomic);
> > > +}
> > > +
> > > +static bool futex_ref_put(struct futex_private_hash *fph)
> > > +{
> > > +	struct mm_struct *mm = fph->mm;
> > > +
> > > +	guard(rcu)();
> > > +
> > > +	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
> > > +		this_cpu_dec(*mm->futex_ref);
> > > +		return false;
> > > +	}
> > > +
> > > +	return atomic_long_dec_and_test(&mm->futex_atomic);
> > > +}
> 
> Sebastian

