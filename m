Return-Path: <linux-kernel+bounces-863437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 315E6BF7DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 991323571CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EF334E762;
	Tue, 21 Oct 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hrRd5SNO"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6834B34D4D5
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067147; cv=none; b=Xsy2iUE8ROuvYIz3gOdaHNbqdmvKjBaF4+UW/r9p/mmJvP+Ghnb25aFbEjVhGQme9GXa1mnuYIjbCrcDF1gkYlOQL+AnKi4p95LBKpz3qX5rn+SOP31Suv8T3mKFT5Tf0i93z+Ao6lH9aAfRtx4ZRGuWvte/MHAZ7yoZn2dxj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067147; c=relaxed/simple;
	bh=0GYHmRQ9tcV+LIRUwKLQ8RepVBHBBbfruCW2tYqvByw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3qtguZh18DfVKenIdRQWEnzUdzZlzsawN5vyqq1kIQCpQ+KgKdy9+iUu5APb/VbiEDljHGo2SpM7LtY+RmKCZj8vztaqeuuDbmwSARjo4MStT76AzRt0YJbOjIE9CEntyXpx+dmL4dt8JieijG4Esl2mJ1UQO5EvU+wsbVMo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hrRd5SNO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ykV+jxwgx3scsYaAj9BJAr7mzNa0sWr6khkMESTiO9Y=; b=hrRd5SNOjx3PNgq+FmZpQ94JMJ
	oQfV9O4kkx95Zz1mJguID6w6iQbJCahC3WjwtFZQTcqlYCVDK3rDxXPezS0c2akYOQjgXoepJASNY
	mFSh14a7FPlufxL3o736JVm6i/6JTw8VADh8aSrfYbGTMo4kZRgSFCiYpF/iiAZNlKB5RXBdSEdTx
	XycIA+nS38InqhKnEXo3E/4Pd6IqifyCuuAjKL/GRqw8s6qncjLEe/GWywaRbqs3tykBemHxRmX0j
	emKJAGaVQRuQtdnkCScUwmljvNK07Wv7aZyuANrGPHI0V5g5/7ahbithf0zgqMRMw3rgOwXBX8h02
	JobkSnkg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBF8u-00000000tC4-162X;
	Tue, 21 Oct 2025 16:23:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1E590303178; Tue, 21 Oct 2025 13:11:32 +0200 (CEST)
Date: Tue, 21 Oct 2025 13:11:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Aditya Gollamudi <adigollamudi@gmail.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/sched: removed unused *cpumask ptr in
 kernel/sched/sched.h
Message-ID: <20251021111132.GP3245006@noisy.programming.kicks-ass.net>
References: <20251020220601.176639-1-adigollamudi@gmail.com>
 <20251020221728.177983-1-adigollamudi@gmail.com>
 <xhsmho6q0lm8q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmho6q0lm8q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Tue, Oct 21, 2025 at 09:58:29AM +0200, Valentin Schneider wrote:
> On 20/10/25 15:17, Aditya Gollamudi wrote:
> > From: Adi Gollamudi <adigollamudi@gmail.com>
> >
> > v2: fix formatting and style errors found by checkpatch.pl. no actual functional changes
> >
> > v1: remove use of cpumask ptr initialized at the top of the mm_cid_get() function to nothing.
> > remove initialization of cpumask ptr in the same function, "cpumask = mm_cidmask(mm);" because
> > it is not used later.
> >
> 
> Please see Documentation/process/submitting-patches; the version changelogs
> don't belong in the patch body but should rather be put after the '---'
> marker line.
> 

Also, please search the archives before sending patches like this.
You'll find I have at least 5 versions of this patch already, and I'm
still not convinced its worth applying.

