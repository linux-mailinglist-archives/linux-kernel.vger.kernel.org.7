Return-Path: <linux-kernel+bounces-801300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D814AB44382
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7AD73B4C43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2212430BF5C;
	Thu,  4 Sep 2025 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="AffawLXO"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC231158C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004223; cv=none; b=HQbSQn3dMu4X1Gt4k8T7EQi68zm1mtUrNrwB5al9bczjnp1GGwbXaw1g890U4Ive7Pzg+FGi/5Rdy7U6uaIdwTCb2auklmOmOiEI3Lw6YVmbpZ9S1sgml4/Zvhm4y4fA/zgsWP+NI1ZwkxTE95JdrykDsFwSdcA2AxAXTM5pybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004223; c=relaxed/simple;
	bh=YEu8dPngg2CnKNj5veuZs+qoygWXxEpkk6yUm3VBvV8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Bd1IAv3/01zHMCQ1GIJASCMXXLWbsHk3owC2Ho/XRyyGb3F184ZwmJ/CbWOuewncFHC75znV2Ft381oF/0WD8CsGBNtWwQeI0SrH16zP2foH44XsrGC/5RgEs34/9Jd52ajAvSTduPf9Y02f5LGnCrMUy4rxOWZAOydf+5YIkSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=AffawLXO; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1757002722;
	bh=YEu8dPngg2CnKNj5veuZs+qoygWXxEpkk6yUm3VBvV8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=AffawLXO8wxwFaL8UA35kN5vASguMKRYNnMcmuFzWeDCw562OqScXuWN3twFGK9Sn
	 yCNjJzaFt+fYrUz+brfrUwkBibHppZT4Rr3b14dIntPmS04S6EMgx1GGz8QD9gqGoT
	 n6uUcs7SNJb4bGldlBvRDlAgFlArcEtmfEkYj8qQ=
Received: by gentwo.org (Postfix, from userid 1003)
	id 27D7B403B7; Thu,  4 Sep 2025 09:18:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 26F5A40195;
	Thu,  4 Sep 2025 09:18:42 -0700 (PDT)
Date: Thu, 4 Sep 2025 09:18:42 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Frederic Weisbecker <frederic@kernel.org>
cc: Valentin Schneider <vschneid@redhat.com>, 
    Adam Li <adamli@os.amperecomputing.com>, mingo@redhat.com, 
    peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
    dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
    mgorman@suse.de, linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH] sched/nohz: Fix NOHZ imbalance by adding options for
 ILB CPU
In-Reply-To: <aLm6q5-4bZ78cM5P@localhost.localdomain>
Message-ID: <a968dba3-0acb-f175-fb73-aa384a2745a9@gentwo.org>
References: <20250819025720.14794-1-adamli@os.amperecomputing.com> <xhsmhtt23h0nw.mognet@vschneid-thinkpadt14sgen2i.remote.csb> <7438bb3a-96d6-485a-9ecc-63829db74b39@os.amperecomputing.com> <xhsmho6sagz7p.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <f6869880-1f7c-a39b-dc8e-4c3a84ba51ef@gentwo.org> <aLmaJEU-WwVmVdYI@localhost.localdomain> <9c8a2b87-5062-08a6-5a27-f53d986b1be2@gentwo.org> <aLm6q5-4bZ78cM5P@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 4 Sep 2025, Frederic Weisbecker wrote:

> > > That's an argument _not_ in favour of dynamic balancing such as ILB, even for
> > > this usecase in nohz_full (all the other usecases of nohz_full I know really
> > > want static affinity and no balancing at all).
> > >
> > > So I have to ask, what would be wrong with static affinities to these tasks?
> >
> > Static affinities are great but they keep the tick active and thus the
> > rendevous can be off off one or the other compute thread.
>
> How do static affinities keep the tick active?

If you dont use hohz_full and only do static affinities then the tick is
active.

My wish for the future would be that nohz_full would be the default and
that the scheduler does correct load balancing regardless of the cpu being
in tick mode or not. It should automatically switch the tick off if a cpu
goes into 100% compute and ideally there would be no performance
regression if the tick is off.


