Return-Path: <linux-kernel+bounces-814724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30769B557C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9C53A73B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ACD2D3EDD;
	Fri, 12 Sep 2025 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ajUrnPb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yrw1xrqg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082B2D29CA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709904; cv=none; b=FnMWNYPYMfc+vea0b57MRtTu56K+HJpwa5darkEv7rOy11hDdhBX3u0H75gMyjqkdr1H4kOScQB6eIZy34VBwqUeLUslPC+Az+t1hNiG8+iyLMFBFEPHivDlJfPr3ZfRUXQrddGgljJbZcsIgsk0GeX9OzJ0xbeSvICs9UczQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709904; c=relaxed/simple;
	bh=oJY7URpSRG0kj30NRwJv8YoKMilihSVterakCGvoBgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s5CSVTP0vVmvtNfWyKre3IooaaE4wmZ4/nWAEcE2sUjIhjt9/nXkjdAOfJ18feMGYe0OKfSuPAmpb+gW9q9qf6OPHsaNVZk98qZ8zHL+ml8QbuqULDdZh53jDozl1OXnVzutGEKiG/ZRfWW7e5be66zDx+HXs1ZgiEN38SPtXFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ajUrnPb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yrw1xrqg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757709900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GnHFQoA22R9OIAKpYUYtldUEJsVc1TZlzefEOYnRjyU=;
	b=1ajUrnPbBYzxBsDMI1pNbsBVLn0HUGlWP+m3jg2AoPDyoln2ufGbHirD1GcMMki2ntFloM
	UUb4/ApwMHd44DGuMzrluwojDsdRH2rKZ5hf2F4g9BMJ9a86fVh8DqkXXyKiQyep0wXs6j
	kqB5y8KRmI7B/+hECeEf4sS0rYRbCIDgh4wDJKx4CTCWYoxPnfyRNyUyiwsqYP1hNxhHMr
	MvDACaB7xF81Syu7O2cZTXZl1wo0TCuH/MvACxzTXlHXMzCiKJG+LrcdLQhPFPRF2hx02g
	WUMw1X+SZwy3/DdHq9sOH/QL9b5Wr29cvq2oHIDn2qYd1mzVLB6EELG6qOY6wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757709900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GnHFQoA22R9OIAKpYUYtldUEJsVc1TZlzefEOYnRjyU=;
	b=yrw1xrqgI8ScaWEwnPNYoSEuDfyU65Q0xB7Fd61/yTsccn7iamcrRJQyiXAkInkgiDzJ8W
	ULO6FA3Unz9LFdDw==
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
Subject: Re: [patch V4 09/36] rseq: Introduce struct rseq_data
In-Reply-To: <4d653cb5-2a1a-4f11-96c4-289976ac8212@efficios.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212925.841373090@linutronix.de>
 <4d653cb5-2a1a-4f11-96c4-289976ac8212@efficios.com>
Date: Fri, 12 Sep 2025 22:44:59 +0200
Message-ID: <877by3qu2c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 09 2025 at 09:30, Mathieu Desnoyers wrote:
> On 2025-09-08 17:31, Thomas Gleixner wrote:
>> The boolean members are defined as u8 as that actually guarantees that it
>> fits. There seem to be strange architecture ABIs which need more than 8 bits
>
> seem -> seems

This is an inverted sentence, i.e. the subject is after the verb. Let me
rephrase it in the regular sentence order:

  Strange architecture ABIs seem to require more than 8 bits ...

The subject is 'ABIs' which is plural. Therefore it requires the plural
form of the verb 'seem', i.e. no 's' at the end. The inversion of the
sentence does not change that at all.

Think about this variant of the sentence:

      There are strange architecture ABIs ...

According to your logic this would be:

      There is strange architecture ABIs ...

which is obviously wrong, no?

I'm not a native speaker, but basic grammar rules are exactly the same
for native and non-native speakers as far as I know.

Thanks,

        tglx


