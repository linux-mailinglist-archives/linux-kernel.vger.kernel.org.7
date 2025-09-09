Return-Path: <linux-kernel+bounces-808123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E921B4F9EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29F67ABAC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FC532A3F2;
	Tue,  9 Sep 2025 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PCG41Usa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DbaV2MbT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A582C0F60
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419853; cv=none; b=Sw7cN7pr62h01nq+bwvUWKABJWbphQEqix6/pc5D1PuCMEBNgBQ2yshEu1wr6R1lZr2KJZ3nB7gt7RCB289e4dKpyPmV2ooT//oAbpJiLVoxM3FUc/B2Fh9sj90agecTvgjMId1KMAwmrWHCS1aTXvEB2kWvLBE1CRzeZXH0/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419853; c=relaxed/simple;
	bh=Oem3COVryyCPOPB7g2lStxd2aIYZKizhF3hAWkNJZr4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iDpaVV2mpLFRltwrjOmUqGC5unl71SXoN5Qo4lOQn/VbNEJn80nS/uJR6zVkq4TM2g/9Ci8osBINIX5hNHLBh8upSvEgfy/NZ+Hlh6cQxBLr/s0/fy6RiIOb0ExNOTNVICPdEatvPac/iAl1+t0tMJbuEPup0VM3Mi0k6cL1ub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PCG41Usa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DbaV2MbT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757419850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJchYhST8gExfD3PITXqdvY3+Gk6l+TtnMz8rwsUCfE=;
	b=PCG41Usa9FAKlYi+UZP8YkgYvxUgXtMvYwL9CoOgMkIg6bHqnlkioAslkpClyBD3wbOPj8
	PcbkbPKh/A8mwTo7TKmp4CYpNDyP4WqMBw8TYjR0eJ2N6A1vs6ln/RacWGmWvZxVoM0aoe
	ThB7IjZe/47eyXKss4RIk+fO82OhMC+UqbONoeiZnIJx3S4im8nrc3k/svtW/C4WDlXj/4
	KjaEy7bIonXCv0/gZXcwrsU84qGXoZisP2AFc/iDFg4dzTu/3/81u8tV+djCL3cxK5MH06
	kR+FocEFDDFGo6wH5ueVw8VdvREAFrDnHgT0utLr2bohmND4ksJjUBujvb8lDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757419850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EJchYhST8gExfD3PITXqdvY3+Gk6l+TtnMz8rwsUCfE=;
	b=DbaV2MbTTqHL8PX+tNIK5xmtmakeEV0ijbP0p/qPOwVT5Y93Fe1Iy1QmExsXZcTF2U+Cnp
	4WvDIxvl57jQmyBQ==
To: Sean Christopherson <seanjc@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>, Paolo Bonzini
 <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V4 07/36] rseq, virt: Retrigger RSEQ after vcpu_run()
In-Reply-To: <aL9uLYpUcOA9Jt4q@google.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212925.708769718@linutronix.de> <aL9uLYpUcOA9Jt4q@google.com>
Date: Tue, 09 Sep 2025 14:10:49 +0200
Message-ID: <87y0qnvnau.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 08 2025 at 17:00, Sean Christopherson wrote:
> On Mon, Sep 08, 2025, Thomas Gleixner wrote:
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -49,6 +49,7 @@
>>  #include <linux/lockdep.h>
>>  #include <linux/kthread.h>
>>  #include <linux/suspend.h>
>> +#include <linux/rseq.h>
>>  
>>  #include <asm/processor.h>
>>  #include <asm/ioctl.h>
>> @@ -4466,6 +4467,8 @@ static long kvm_vcpu_ioctl(struct file *
>>  		r = kvm_arch_vcpu_ioctl_run(vcpu);
>>  		vcpu->wants_to_run = false;
>>  
>
> Finally had a lightbulb moment as to how to eat this hack while not stonewalling
> the entire series.  Can you add something like:
>
> 		/*
> 		 * FIXME: Remove this hack once all KVM architectures support
> 		 * the generic TIF bits, i.e. a dedicated TIF_RSEQ.
> 		 */
>
> to discourage further abuse, and to make it clear that such ugliness isn't anyone's
> first choice.  With that,

Fair enough.

