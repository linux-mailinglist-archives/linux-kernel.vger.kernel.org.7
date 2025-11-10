Return-Path: <linux-kernel+bounces-893329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7192AC47164
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F9C188834F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147C311C10;
	Mon, 10 Nov 2025 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mhtdGE1u"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150C3112DD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783487; cv=none; b=V9KSOr62ZqnsNNhrdDcvhXzgjk3We0FZneHIfIrpymE9z2EB6BVDPBmS9PDZCxBiw14G7So77yYdmbZqXMTl+bk8zv2t42z/MGwM/oZG4Xg7aJzIhTn/tt742pfhm4uE0b7LRVdJprNeQlPSgZEDaAwSUpvcDZn8y4Qr3BbDv48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783487; c=relaxed/simple;
	bh=m3qE8Rw+WJZE0ik8phINLzthkZmZ1U3n5sYGUr6tZm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN/rM5yTV0gCfNL8+hP64aIP842OqggR8hcg6HZCbPt2d2zXn6kzNlrNiX4kZcfnkgWsrq2GGJPLbXNXaR1LED/68aSez9BDfu2W6tNaJNnnznj5SohHinNZtkijvCn6/vWdY/k0vQORMH5A4Hhpa3QbUnA2IuQTxRW+Tc7S23A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mhtdGE1u; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/mPM2btZSLh2MeU4Gdnh/eNe1IuUiAZPukkHH596UHo=; b=mhtdGE1ual9a4AcKPBtbBiGcXa
	ggzT/6YXAbbm1eKNvml8WA/AKRC/qZfdtb6vrXbMDzkmQsOfenKoGb6/sP1DlQkqSH+I89mBxiCY+
	m1iCLK545Gk480vmyC1lyD4zJ6WVnOgeS+dzv7WJqwf1Bl5g1QF3ksJ2IB60DwnjRqCvGuLzAAedg
	hujRZXe/BFkKGiTZyh3XmKiEcTQ7dYzJFm6oNIY5eTNlXq6AfcfUGRq3E2C2E27wy8ga9l0QrtZbF
	NQ31S67+zzSmTnI7vsCtmsW3mvFOJydUFNGXEog6iH07dtDdXbm8ogcXsXG/HJm/UPJfyixR2mteO
	TFuPeRQA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vISVZ-0000000GlPm-2SsN;
	Mon, 10 Nov 2025 14:04:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7484530029E; Mon, 10 Nov 2025 15:04:36 +0100 (CET)
Date: Mon, 10 Nov 2025 15:04:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Chris Mason <clm@meta.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Josh Don <joshdon@google.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/fair: Small cleanup to sched_balance_newidle()
Message-ID: <20251110140436.GX3245006@noisy.programming.kicks-ass.net>
References: <20251107160645.929564468@infradead.org>
 <20251107161739.525916173@infradead.org>
 <bcd48c73-b65f-47be-917b-7fb2b8ed8ec0@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcd48c73-b65f-47be-917b-7fb2b8ed8ec0@arm.com>

On Mon, Nov 10, 2025 at 02:55:34PM +0100, Dietmar Eggemann wrote:
> On 07.11.25 17:06, Peter Zijlstra wrote:
> > Pull out the !sd check to simplify code.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/sched/fair.c |   10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -12811,14 +12811,16 @@ static int sched_balance_newidle(struct
> >  
> >  	rcu_read_lock();
> 
> Maybe scoped_guard(rcu) here?

Thought about that, but ideally we'd simply remove all that. This has
IRQs disabled and that is sufficient.


