Return-Path: <linux-kernel+bounces-877183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DACC1D62B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEDFA4E497A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD6B31987A;
	Wed, 29 Oct 2025 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b6NiZCXz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lc0fafdj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6031961E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772163; cv=none; b=Qp++g8M42NoW4h9h6zexqwXqdFgdVUh86ddp4xPHHzs4EeHHFE0MnW6qXyQRLWmmYrl4bg6cVLVZ0LMq6yF49BCn2wBEhk78up/Ab7r744ijItdaGY4snCL0k+xiBd6Ql8C12kT90mMyfEEbTrMm97DHJz5WmBajdNPYuNCh+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772163; c=relaxed/simple;
	bh=7DWQPdQMuRVgPHqcPqKVNKXN6scq7kbIW1IUxN+B5Os=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qziRC2X9solKZvz6Z4tlmbkMDPYCRqYrvEbgoe5W/hrXDVmuBOelMsHhZTIHzIubyhZjINub7Ouf3SbErxV0RG+8pMKXdnnfPnKmOl9NsHF1dOpsZW7V4Ta2SomMcq6M7P7hhUd0RFPaKiwd9pjy1ZysEcIueZaiC2w9W3e8qvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b6NiZCXz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lc0fafdj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761772159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WWq3ow0VQlrA04OxMPe+Z433jfos5Hg+AyWd59I+hqI=;
	b=b6NiZCXzZw4t97oSjaFVgg8LbTV1JYDQ2N7SEm54aYPtwG+aaeM5C+AKDThW4LdQgZS75K
	khm2tOYyFEIA8jsvfQdG91rDi4n+9wuG5QmKBLS4bp45bS+8/XAr4ycFgeiHOiiix1fPDx
	jybRCO8MJQick7r0q+K5YD5k4V4LbduLwGSaBH/LkstQAOyOckhbJfxVRq9HlEqOH9i5kK
	v7u++f02phWb/803pDeLXuWqgrcbMVTqQg2TTi+6iaW8r7Wj41mdWekXQtYG4w0WqK5WS4
	EWGBmcy4/ugziHJb2DZDwYktqiHYqlDpfhHHQhqTkTvxRw9mwHDIWhtWDOemtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761772159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WWq3ow0VQlrA04OxMPe+Z433jfos5Hg+AyWd59I+hqI=;
	b=lc0fafdjVICYpdBYP1/GEd7rcH0qgZ7QdVWW1G/fXoB07dM+M1yj+e6eaJJgmpYyhETmwK
	Fem4q1MvktbrJQAw==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, Jens Axboe
 <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim
 Chen <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>, Shrikanth
 Hegde <sshegde@linux.ibm.com>
Subject: Re: [patch V3 03/20] sched/mmcid: Cacheline align MM CID storage
In-Reply-To: <996b1e7a-59df-4638-9dd8-ff6edbe8d1d4@efficios.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.466070081@linutronix.de>
 <996b1e7a-59df-4638-9dd8-ff6edbe8d1d4@efficios.com>
Date: Wed, 29 Oct 2025 22:09:18 +0100
Message-ID: <87y0ottny9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 29 2025 at 11:39, Mathieu Desnoyers wrote:
> On 2025-10-29 09:08, Thomas Gleixner wrote:
> [...]
>>   struct mm_cid_pcpu {
>>   	unsigned int	cid;
>> -};
>> +}____cacheline_aligned_in_smp;
>
> What's the point in cacheline aligning this per-CPU variable ?
> Should we expect other accesses to per-CPU variables sharing the
> same cache line to update them frequently from remote CPUs ?
>
> I did not cacheline align it expecting that per-CPU variables are
> typically updated from their respective CPUs. So perhaps reality
> don't match my expectations, but that's news to me.

It depends. While per CPU variables are typically updated only on the
local CPU there are situations where there is cross CPU access and it
really depends in which proximity it ends up. I made it that way because
I saw the accesses prominent in perf top, which means there is
contention on the cache line.

Thanks,

        tglx

