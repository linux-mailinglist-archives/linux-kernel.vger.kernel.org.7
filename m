Return-Path: <linux-kernel+bounces-886042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C4C34955
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2751560AFC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5262E7BBB;
	Wed,  5 Nov 2025 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mu4bSgU6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OOhAvgeb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8342E8B7A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332494; cv=none; b=XDyEWLb3J2+YE0ILnatNeEh/hco/vnaKJv5XU3GU3jg8LYf2wdN2CsaaE+isEQVAtaY8McaJkaYDbS2+dG1R3x7pwbyzx/N/SH/alt7r5rIXL0f4VqenPAR1HIPSlNqYbImyXpqw+aaJOHS0lY/TFds2PK6wp0jkdtgy43LQ79E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332494; c=relaxed/simple;
	bh=JKqnqsg+ieMpZzGXlmdAj98/tbFIzoe6OozVEOZiSls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjXr5FbYdpvIzBlFd8xfU5uY9NF4HFbz0FOEPfS2QmohPl847KQIoEjqSyKyOt5+L4YEHU9/7TNqqk1+zBZ0BaWpUI/qrtiomZAvD5SXWBcmBw5tNkUF2D4+j6r3NbyabZ18TdiDdNsNOSJtlbd7katLB0jMe2G4u7xgBuZenv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mu4bSgU6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OOhAvgeb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Nov 2025 09:48:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762332490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIgLnzghnI+Iy/ceP5DulbWqbXB/m5x6Y1ztoDof79w=;
	b=Mu4bSgU68HQGFb/rRoYRjXYTXmPYcurCjVjtS34Zy82s2mTFtakwmSvN4TTa/SnpaqOdxR
	31xwdDiPU2C7c72KuePG0JkzuRPV/LhwtAnSpkFBao9fMWmVjh7NvseXbJwoQkC8TdsiD6
	j6AFSmWSun3TNOTNSqs+zIfLzfgdZY7qpPtJpu0osKV2kjY+X9FpGixZxf5WI3tRLNoDiR
	7IpPR1o03f1LsakPMcr+qdRipl65dpkG10XHxe9CunfPyELHX1VklgpsUnQt5bsiRZ/Dfi
	/aSefElH2SaH5PhTOFcw3DSDZsay0aJhqBPA1JlKr3Uqkzg1d8gxD/PF1+j13g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762332490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uIgLnzghnI+Iy/ceP5DulbWqbXB/m5x6Y1ztoDof79w=;
	b=OOhAvgebpPt83108HwN0QQauQXcKoCNoPW2ahuhKlx7Qb4BqQA0NdssMnjLENRLcY+Moz7
	NZQ6YFKlrzcOMXBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Mel Gorman <mgorman@suse.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp: Suppress false DEBUG_PREEMPT warning in
 smp_call_on_cpu()
Message-ID: <20251105084808.7-nsQ6lT@linutronix.de>
References: <20251024070714.4047816-1-namcao@linutronix.de>
 <20251024140832.46JNLRvL@linutronix.de>
 <87ikfolvjx.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ikfolvjx.fsf@yellow.woof>

On 2025-11-05 09:42:42 [+0100], Nam Cao wrote:
> >> +
> >> +	/* suppress warnings from debug_smp_processor_id() */
> >
> > If you want to add a comment, what about something like
> >
> >   /* Preserve not being migratable such as SMP variant does */ 
> 
> Wouldn't it be a bit misleading? It's true that technically SMP variant
> is not migratable, but that's because it is a per-cpu thread, not
> because of migrate_disable(). To me, the comment sounds like that there
> is also a migrate_disable() in SMP variant.

A per-cpu thread ensures that the control flow can not migrate to
another CPU. This is also what stops debug_smp_processor_id() warnings
from work invoked from queue_work_on() vs queue_work().

> Nam

Sebastian

