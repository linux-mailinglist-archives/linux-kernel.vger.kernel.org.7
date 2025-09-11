Return-Path: <linux-kernel+bounces-812484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2354DB538BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08D43A79F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5261135082D;
	Thu, 11 Sep 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kCy1I/4p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/b8oBpzf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDEA1ACEAF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606912; cv=none; b=CWyWPuu+H7SYSb+zlnw9WRylUJbYp5AnLdJ20FUNwJNbKf81gFceyfG3Orlnri0XhE5Sqbj4l4aSJHEJKF5d4spYbLDSjI8BeDeQz1PkBMqnZeGFbKY6SKq4Vk3sQZZExkVRtURBpsR+wTTZMyctLSMMTGXMpxAOXnDPhnOeeME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606912; c=relaxed/simple;
	bh=ALtwD3nkFpsn21nflnW8WCMBoCvlqLFjp+n+CDq8Bmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FIzvnvvm6foPnOgneTfK7sgW6vD5AvOHD6PsctqriGKUggyUB9qVuA2dxzeyiajZRlJxTKzCdWYPAgWxqVuY3ouUoyuiEPF61/ULvmLUfNbjwQqBfP3Tc3CchVHhTYv7l+iW9VPgvKPxpEXGJADmvW4bB/nUhv0zD+us5fDm2Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kCy1I/4p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/b8oBpzf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757606909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rtftTCr0uyk0T0ztP7XLXAUwMAADbprFx8itfTXteEE=;
	b=kCy1I/4puobbmlTUbVi+NM+ZYA68sonMMx+uu557/2pb3effPuwXdvdZYa/YvVOk/H70pV
	uL/c1a7iahcQyyd2ZLmoy0GgKBaFYP2sRWOro4a1lkjWbuACJ9YA2VXS7qn46sfFMDG9z1
	H7JJlHIY3eg1c+PJFIKJAopZyl34vlUhAzJLUw7NI+44gTOdUjUofimFYPK4YrQfUYGc3M
	ZLQ92Ib/B75/3im1YsubJBbTTMcjOfqhtoEXSAwpQ/FxH2xEKZytW20Y8YPipb1IKZW4pz
	f0gGczqBfeNMeGxV65lJLVWjCFG8djJDWpcOMZH0AMApClR/ypom1yTNroqTog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757606909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rtftTCr0uyk0T0ztP7XLXAUwMAADbprFx8itfTXteEE=;
	b=/b8oBpzfeKPXwSqCktu0sLKkl1kXAL+oRsUHzYVHkzCxk5k0poUMvvdvQEeBc7DZU/Spgk
	ZplaIVN0VCSC28Ag==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V4 27/36] rseq: Implement fast path for exit to user
In-Reply-To: <ad0e0d2c-75e0-42c2-85d4-5232a5fb8af9@efficios.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212926.993963056@linutronix.de>
 <ad0e0d2c-75e0-42c2-85d4-5232a5fb8af9@efficios.com>
Date: Thu, 11 Sep 2025 18:08:28 +0200
Message-ID: <87y0qlq8eb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 11 2025 at 10:27, Mathieu Desnoyers wrote:
> On 2025-09-08 17:32, Thomas Gleixner wrote:
>> The initial decision to invoke any of this is based on two flags in the
>> event struct: @has_rseq and @sched_switch. The decision is in pseudo ASM:
>> 
>>        load	tsk::event::has_rseq
>>        and	tsk::event::sched_switch
>
> I suspect that my earlier comment about has_rseq and AND applies here
> as well. We could probably remove the has_rseq load and the AND
> altogether and just load sched_switch for the conditional branch ?

Same comment as before.

