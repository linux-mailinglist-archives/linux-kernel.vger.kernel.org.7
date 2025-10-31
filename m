Return-Path: <linux-kernel+bounces-879857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 456F2C24413
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF0E1A62D72
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567CE333423;
	Fri, 31 Oct 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b="Sk1C+fBa"
Received: from mail13.out.titan.email (mail13.out.titan.email [18.198.78.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669EA3321B9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.198.78.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904100; cv=none; b=e44jYPcw+A7+ZjoyrCOXRqQC3Bqbg4gMnu2VRpuCpvmq7PVbuGxy4VhXYgdI3xzk6jKxxjFqETFrEmQX/TqYx98M9HXmBEEwGf4JbF2u7vNXj9p+On6k1zBH6W6mEgOlESDosTJURule7zKDIj9EBBWLc61/zoOG4e4j4DwHEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904100; c=relaxed/simple;
	bh=vD7rnnpMGJDT6CzjLc3kTsDqbVvqyCLi7Za4XZg6JB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF8pvJsFu/1+tRDSos8teekRMgS3JaIuxOeLVKEzOe6NbpzMq/TzRzYDHOZ4jB5xMwotF4OG3ZU1xk7vyO5/lvPAS8J21gbkxblM0S+rWCGajxcR9iwzpYA1DLUAhcTqfOfWowLMnLLX6xfWnf5OjfDfl2VYMXmj9858y0lZ3iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; dkim=pass (1024-bit key) header.d=techsingularity.net header.i=@techsingularity.net header.b=Sk1C+fBa; arc=none smtp.client-ip=18.198.78.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from localhost (localhost [127.0.0.1])
	by smtp-out0101.titan.email (Postfix) with ESMTP id 4cybky4VDZz4vxV;
	Fri, 31 Oct 2025 09:48:10 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=xtTa0MbORNmRUPtPHMQNWNMjHbdmcvYMVp6WwLms89Y=;
	c=relaxed/relaxed; d=techsingularity.net;
	h=date:subject:mime-version:in-reply-to:to:cc:references:from:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1761904090; v=1;
	b=Sk1C+fBatfGmdvn3hPqxLZLN18DKNPVgwXqjb6RzIswrUiDopgaTZKzpWQln04WH9z8Gi4Gb
	N+gsjKCrAWGMWIYhAuO9Wz2z6Ze7ruEowcDGyRz5pryW2PyE2+KMzJjSYvZ58OIv3WpaQwNInec
	p5RNr9eOqslZK16z/lqTOpfY=
Received: from techsingularity.net (ip-84-203-16-53.broadband.digiweb.ie [84.203.16.53])
	by smtp-out0101.titan.email (Postfix) with ESMTPA id 4cybky0Sc5z4vxG;
	Fri, 31 Oct 2025 09:48:10 +0000 (UTC)
Date: Fri, 31 Oct 2025 09:48:09 +0000
Feedback-ID: :mgorman@techsingularity.net:techsingularity.net:flockmailId
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Chris Mason <clm@meta.com>
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Message-ID: <edlaifqiesdehyqgipykrvphzfifmjlowpla6thycu6mynihxq@waywnd3svgze>
References: <20251027133915.4103633-1-mgorman@techsingularity.net>
 <20251027133915.4103633-3-mgorman@techsingularity.net>
 <20251028150951.GD4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20251028150951.GD4067720@noisy.programming.kicks-ass.net>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1761904090483755673.2237.6819030729221816545@prod-euc1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=AMAIbF65 c=1 sm=1 tr=0 ts=690485da
	a=SAet2ifMzLisiRUXZwfs3w==:117 a=SAet2ifMzLisiRUXZwfs3w==:17
	a=Q9fys5e9bTEA:10 a=CEWIc4RMnpUA:10 a=GjBizfQDLlqNznDqvmUA:9
	a=PUjeQqilurYA:10

On Tue, Oct 28, 2025 at 04:09:51PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 27, 2025 at 01:39:15PM +0000, Mel Gorman wrote:
> > +enum preempt_wakeup_action {
> > +	PREEMPT_WAKEUP_NONE,		/* No action on the buddy */
> > +	PREEMPT_WAKEUP_NEXT,		/* Check next is most eligible
> > +					 * before rescheduling.
> > +					 */
> > +	PREEMPT_WAKEUP_RESCHED,		/* Plain reschedule */
> > +};
> 
> In pre-existing code that isn't modified by this patch, we have:
> 
>   if (do_preempt_short)
> 
> Which seems to hard rely on PREEMPT_WAKEUP_NONE being 0, please make
> that explicit in the enum above.

Will do.

-- 
Mel Gorman
SUSE Labs

