Return-Path: <linux-kernel+bounces-863521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 602AABF80AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08AC03579CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1803C351FA8;
	Tue, 21 Oct 2025 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YhGxVNDo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zqYaDsIE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99FE3502BE
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071130; cv=none; b=Ls7pKYSC3IghRBEAKdn7lNgxZ5A68PJWXMq2+cdbdQhLTkt1ICs0kGkSAuA11Ain1/44A3BsIKD9m9IYSax6zztuFfwbAvPJwPwjqZLl/X9t5ZaqthoZEqnOH2EAVwXsyc97WykWmcpFMcOq2NL5nh3Qgo2rL5oPuLfWMUQTVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071130; c=relaxed/simple;
	bh=Fpq5TguFnh7GJoFSbAmRLvYFjzZrQe2+wh8QZ39i1tE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I0vfzNZA5wklgsHzMQbmhHic0dnaltWdhspUtByKQSjeid8sAyybtRhneDgZvJk0YwQQPEn1SOV4nVBD/uWRiRiuWQSaLhEs7R+TkodgDiNk62zYv3gYTaqFW8fSAgNRK8lprNWcM6S2/1d2EiEGSMGNFg+pjX7a3ccvtq0r8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YhGxVNDo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zqYaDsIE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761071126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sh6FOKDSjWc03H2twpiTeFyRcRcme/drbYMmxZglaxQ=;
	b=YhGxVNDoCKtV7HeIuqrBiJeooLpxn6AQ8yZQx6GOY6PLLoiQUujWsTC35UKIsRwIMYp3tV
	siDG+DcDTM189/Y57EQ/N7rAsCkc3EnU/LXXkaBn9MFwFocSaaJ0eAe7d0GDxVtZxNwISi
	PY0iuSOAfxLIdMrG6wOzX0DOoDtyX23thWbInxfw6dlnZJ67Nghyxd0zHd01qJBZcHap9v
	ipu6BWl5HG89mHzUS/I2cNsC7ztGHcM1czlkhZROJx6appdfxQOxPUrYIFuwYWU4jR0/6T
	HhokBIXCrUydxyvDMuzMcaxL2n2kzWyJ8ud4Wb0L5ODvwk98TvIT148Z8d4r5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761071126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sh6FOKDSjWc03H2twpiTeFyRcRcme/drbYMmxZglaxQ=;
	b=zqYaDsIEXPxwz2x7ZTsTLVe6g4H162HRTF3cRSiZtZN1YnIrYyJniH4H2xBk7oUJ6AbIbX
	ZpergSaXnYW9e9BQ==
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, TCMalloc Team <tcmalloc-eng@google.com>
Subject: Re: [patch 06/19] sched/mmcid: Prevent pointless work in
 mm_update_cpus_allowed()
In-Reply-To: <20251020082250.GF3245006@noisy.programming.kicks-ass.net>
References: <20251015164952.694882104@linutronix.de>
 <20251015172834.694547089@linutronix.de>
 <20251017111223.GD4067720@noisy.programming.kicks-ass.net>
 <87y0p9zo9y.ffs@tglx>
 <20251017175853.GH3419281@noisy.programming.kicks-ass.net>
 <20251017181911.GR1386988@noisy.programming.kicks-ass.net>
 <87jz0qzl74.ffs@tglx>
 <20251020082250.GF3245006@noisy.programming.kicks-ass.net>
Date: Tue, 21 Oct 2025 20:25:26 +0200
Message-ID: <87v7k8xgbt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20 2025 at 10:22, Peter Zijlstra wrote:
> On Sun, Oct 19, 2025 at 10:32:47PM +0200, Thomas Gleixner wrote:
>> On Fri, Oct 17 2025 at 20:19, Peter Zijlstra wrote:
>> > On Fri, Oct 17, 2025 at 07:58:53PM +0200, Peter Zijlstra wrote:
>> >> Same is true when you offline a CPU come to think of it.
>> >> 
>> >> Same is true if the cpumask is sparse.
>> >> 
>> >> Anyway, just saying, checking against nr_cpu_ids might not be the best
>> >> shortcut here.
>> >
>> > Put another way, nr_cpus_allowed == nr_cpu_ids only work when none of
>> > the masks involved have holes. The moment anything {possible, present,
>> > online} has holes in, it goes sideways.
>> 
>> You're right. I was too narrowly focussed on the normal x86 case, where
>> nr_cpu_ids == num_possible_cpus ....
>> 
>> Let me think about that.
>
> So the obvious idea would be to grow hotplug hooks, such that you can
> do:
>
>   nr_cpus_allowed == num_online_cpus()
>
> But then hotplug will have to iterate all mm's. Doable, but not really
> nice.

Right, but that can be done once the dust settled and if there is
actually a need for it.

Thanks,

        tglx

