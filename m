Return-Path: <linux-kernel+bounces-802838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1282CB45789
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CE47C5753
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F95352FC8;
	Fri,  5 Sep 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjkX2rTH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C747134DCD4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074565; cv=none; b=J79RrE5C4iwi5YdXVB+lzizsycSulheWct3dycHsIGJyHEZiEHUbQsg2RNCN5nwmqc3sKAawzgUsV3FsmCfM7C7nBU2D8iljIm/YA3UF0f3Dp1nhIaITym3gkX0lN860R/glgHPdOpU2ib0mKHgmioCRnak4lVLpPMGtafLd4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074565; c=relaxed/simple;
	bh=IeIn9zD1jaaHFqhCteyThYXRmtSddElqpSt6gqLaM0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEhrDGNtgJgfrAxtUSftGUqGb1R58Q08sZrD/MJKwSQLYnRCtVteRwU6/5vXnqKwlinqqG9WIhmuIhPZg4ecVSfdq7E16EY7+i/e/u0GE47nHG+6eDS2EEodVqFvWMIxb+3h9WvLXqIT9Q/o62Pxjryeoy/NExd2c8fmWHNQ1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjkX2rTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177B7C4CEF1;
	Fri,  5 Sep 2025 12:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757074565;
	bh=IeIn9zD1jaaHFqhCteyThYXRmtSddElqpSt6gqLaM0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjkX2rTHtHC0g1z+GJDSBAVzBV7JoNrfp0cEuMIUdiomsA1RZEzEOYZKmSgnLEDrL
	 svcYWVu2WwSyfO7ypbbXSn+8w+8IkZ00kaBOrfuHTfjawnyJG9vDzTT02CkpY/YsmP
	 EGS3BZmyzwaVYcZqbK4IqE3DYUbqtjjx4j/VsuyVIixOMES8obOG4saiSplP09plyo
	 /nHSnXgj2eOTGlyBXHdqIP363zXwpFU3kaRaI9gphqpQP/9LOmMlP1iHXVlFZgL05D
	 Rli6WkNvF95/EKazs+NPDPSdtPqhqFrQDLXyi2nosgKAj5l1BhOJX7iXdEtZUpn1O+
	 nf3+AEKEsVB6Q==
Date: Fri, 5 Sep 2025 14:16:02 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for ILB
 CPU
Message-ID: <aLrUgpOshn5mg6sL@localhost.localdomain>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com>
 <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com>
 <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <f6869880-1f7c-a39b-dc8e-4c3a84ba51ef@gentwo.org>
 <aLmaJEU-WwVmVdYI@localhost.localdomain>
 <9c8a2b87-5062-08a6-5a27-f53d986b1be2@gentwo.org>
 <aLm6q5-4bZ78cM5P@localhost.localdomain>
 <a968dba3-0acb-f175-fb73-aa384a2745a9@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a968dba3-0acb-f175-fb73-aa384a2745a9@gentwo.org>

Le Thu, Sep 04, 2025 at 09:18:42AM -0700, Christoph Lameter (Ampere) a écrit :
> On Thu, 4 Sep 2025, Frederic Weisbecker wrote:
> 
> > > > That's an argument _not_ in favour of dynamic balancing such as ILB, even for
> > > > this usecase in nohz_full (all the other usecases of nohz_full I know really
> > > > want static affinity and no balancing at all).
> > > >
> > > > So I have to ask, what would be wrong with static affinities to these tasks?
> > >
> > > Static affinities are great but they keep the tick active and thus the
> > > rendevous can be off off one or the other compute thread.
> >
> > How do static affinities keep the tick active?
> 
> If you dont use hohz_full and only do static affinities then the tick is
> active.

If you don't use nohz_full then the tick is active, yes :-)

> My wish for the future would be that nohz_full would be the default and
> that the scheduler does correct load balancing regardless of the cpu being
> in tick mode or not.

Provided we ever manage to run nohz_full without tradeoffs (offloaded 1Hz tick,
RCU user/kernel overhead, cputime accounting overhead, use hrtick when
preemption must be maintained) then yes it would make sense but we are very
far from that. I'm not even sure this will ever be possible.

> It should automatically switch the tick off if a cpu
> goes into 100% compute and ideally there would be no performance
> regression if the tick is off.

Automatically means the kernel has to guess and make conclusion after some
execution time. That doesn't sound right, especially when nohz_full is used
with strong jitter-free guarantee, which has been the case for every usecases
so far.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

