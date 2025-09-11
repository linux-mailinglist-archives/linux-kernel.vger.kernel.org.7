Return-Path: <linux-kernel+bounces-812552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3E6B5399F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D636B1CC0554
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9473570B9;
	Thu, 11 Sep 2025 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jjuyBWfX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8wFI/npo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F8624729C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609423; cv=none; b=YK4nPoTQZlbVoFhua15tGD2fV1cfhmqXPinT+mCGuwZQBg4T095kCx4IXDxetzquCv/Ylr/qt/pqNA3o6k8GCbF/IoAbhzUoKiQ8ypXuY43GbHFc1aecolGZuQXRbx6RxMW0uaVXmqAc8Revu9FnuqFSLok+odPslkzLybc74iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609423; c=relaxed/simple;
	bh=xIGGQGZn1+NT+gdmWkjGnX73fbnj32gKRhY7JImqTjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QBFnMnqt6Aj3LUk1Zj9QIDbcftwWglvi4LmRT9K40CmBiQgA/5JJHGMbn170sNFh8cqG5t75ZoQtAIsDPa6P9r16DeCNM3bTD6dc3mjla3qhQV2ymaBxjsh4QjOFs4B5wbxtzh8AktXIS0FsmlRjp1p0Rqjm2Pg2V8Gb3qPaK1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jjuyBWfX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8wFI/npo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757609419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cPyCUsSF0QWEU/Xmk0/clZmTwXHJ2XsLcWUchGMw/eQ=;
	b=jjuyBWfXKIMrREtMwP1Dt6JViGCX0RYQ48RkhibKhGwSTKnVt/DUq+/OiEtfwPPqVmThye
	YXiVj7TRUBB7cK9xLJC+SQb0AvXAVT5XqRMrtEH+byxsNV96La6zl8b9hpc2F544aBMTKo
	UUFb6jrzEzlWAbINMAVymA42Y5HT5GumFAY8B0ZqeEf/xQWt5BDCPcYpz8dI2oKA26Ne7a
	3WM/mBBxB7ihYeNUY4Vsllyesuo1kZN0SwWY+C6j2FIgSA6ddR+l/xuBF/4wNG4CEHwPGe
	KfjAINxMA4L9a+LMN6pdS+xk6Y0z4dmiJ/R3/Vf6HxouEfUEzGtXta8rTh3HbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757609419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cPyCUsSF0QWEU/Xmk0/clZmTwXHJ2XsLcWUchGMw/eQ=;
	b=8wFI/npoE4o7/tBPjLzaDMqUcnXfBQZx8ip8ahAnVxIHRCLt7koZWXNKJcPWmcL4D1KLFm
	9NXu8TIXiUjDZ6Cg==
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
Subject: Re: [patch V4 28/36] rseq: Switch to fast path processing on exit
 to user
In-Reply-To: <5c1e0366-1016-4cc0-9b86-888e8c5c2a31@efficios.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212927.058801648@linutronix.de>
 <84d9beb2-85e7-4fc0-b403-0514bd87ae8b@efficios.com>
 <5c1e0366-1016-4cc0-9b86-888e8c5c2a31@efficios.com>
Date: Thu, 11 Sep 2025 18:50:18 +0200
Message-ID: <87segtq6gl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 11 2025 at 10:45, Mathieu Desnoyers wrote:
>> Mathieu
>>

<REMOVING ~170 lines of non-content to find a single line of information>

          Seriously?
</>          

>
> Just making sure you don't miss one additional comment below...

Contrary to you, I trim my replies, so I found it...

