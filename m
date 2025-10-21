Return-Path: <linux-kernel+bounces-863650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843C4BF8B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923371896D21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54423279918;
	Tue, 21 Oct 2025 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lpcFAJJ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2y0at41g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F023EA9B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761078094; cv=none; b=dUoZirT9iw9xmiwnqLwCjba5d5FZYIHZiwDN9GMsdvBCV9C9jlqfi8iGEYRkxPJjjJvqDIQJW2eV5WH8odb0q7UBRQa2tLSC12gs3YCaw2TFINfZcIlCbMQq6uYVjzDK8gT1rIrUCSBFHNV+YthOIFT/Gjn47XQciYXYIMA8OrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761078094; c=relaxed/simple;
	bh=UNh1LY0RP0SNmST2LTOJLyvXwXZtzakXnLZWDK3MmHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E+aJJGyJ/pV694+QmV3/SwK95LOwY5um/VXrFcA2RzmbSdLK/VrVAZHhgEaz7J3wpQEGrACI1w2bCNBOitlDfC/hsKycAguDO9gMb8CFGqxwK1W0Tna7RukXSJb85b9PUtl9uhCgC5BQ3JyET07CF2idm0lB/ihZvOykeJYX6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lpcFAJJ7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2y0at41g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761078091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCcS9ngVKDAdcAYvazSMUEgKoR1HM6TXh97N7tLqm9w=;
	b=lpcFAJJ7pB1Mq21Idh+ZnJsXpAS4yxD8abQVcd/peHn0Zpm7yYBELSdnIyMtRPNES2F/SX
	9Ul/d6ntixkPMR0Rrj3gfCNjGcv9zqzSGItUzY1wZPfZoezWbbSzF6kq//zwANqzLuXYDG
	x9K4KsQTCBghUp0kndcheyXn/4mngsLvirOePrNPyRVs8FJ9X22kIth0RDdDoHM45B4gON
	GkOibLIBoK2Dr623WnoEnlG9no07Ij8thvbYYBLBS8kEm0p/V4o2EZzMHKokG3qHBZ7+4b
	m/sJ0tMAiNVTNo9penPpAo80pxuJGD3n2HbvxGhBYFPqWNZoFITuIK8vFlcLzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761078091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eCcS9ngVKDAdcAYvazSMUEgKoR1HM6TXh97N7tLqm9w=;
	b=2y0at41ghCwrazhn98XrAWlXJY0ZVd4leCedjvaKO/5azayr27m8AistOkG8S7T3V/dvhT
	JRHH5nN2K3nXn9Cg==
To: Yury Norov <yury.norov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Gabriele Monaco <gmonaco@redhat.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>, "Paul E. McKenney"
 <paulmck@kernel.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 TCMalloc Team <tcmalloc-eng@google.com>
Subject: Re: [patch 07/19] cpumask: Introduce cpumask_or_weight()
In-Reply-To: <aO_iiKKVyKSlXeF2@yury>
References: <20251015164952.694882104@linutronix.de>
 <20251015172834.757776587@linutronix.de> <aO_c3lTmvJyzsOdE@yury>
 <aO_iiKKVyKSlXeF2@yury>
Date: Tue, 21 Oct 2025 22:21:30 +0200
Message-ID: <87ms5kxayd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yury!

On Wed, Oct 15 2025 at 14:06, Yury Norov wrote:
> On Wed, Oct 15, 2025 at 01:41:50PM -0400, Yury Norov wrote:
> Ok, I see now. You want to do a regular cpumask_or(), but return the
> hweight() of the result, instead of a boolean.
>
> The cpumask_or_weight() may be really confused with cpumask_weight_or().
> Can you try considering a different naming? (I am seemingly can't.)

the only thing I came up with was cpumask_or_and_weight(), but that
sounded odd too. cpumask_or_and_calc_weight() perhaps.

> Can you describe the performance impact you've mentioned in the commit
> message in more details?

It's sparing the second loop with the related memory reads. It's about
10-20% faster for a 4k CPU mask (64 iterations) depending on the machine
I test on.

As this is invoked with runqueue lock held, there is definitely a desire
to spare as much cycles as possible.

Thanks,

        tglx

