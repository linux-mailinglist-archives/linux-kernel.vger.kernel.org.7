Return-Path: <linux-kernel+bounces-897472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C05C531B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24208423B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C5919C566;
	Wed, 12 Nov 2025 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jofjwsss"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8E338F20
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958913; cv=none; b=BL14+vl4EzPAZzQQTT1ae8LFFEcvyBZHyKL+VI0Wc432coMNd9EbTXFVBhFUpIAXelDXIaN7FC60iOC/aFnIVV7yqZlxnlQv+83W1ydjFjDFDhRw+NE+yudznh+vPuRPuw2p1FeROk7xyqixiBqOcuKGOx8oBN/hJ+iCd9R4+ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958913; c=relaxed/simple;
	bh=o6/bL4MYU+f2UOEryFTp4L5qf1SWg3IyYODLr4T3ckA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LniwkwCtqQs/4fLrpHb4GKsicw5mAmYqFLyvQwN2semWTxEgv19/dGlqm26SELCAZ+eC0VL/E7PjLYYyfislxGQP95ksimuVe0K90H/gwDeeZQlbber4jhD2PYQXOuuIF/CwvTKAmg+F3/x3cqkF5uIcM+Ga+rUDOxEXWHtfuYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jofjwsss; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xP/7ZgPtLxO6wgz0uO/5plwH3ptvWelS/+FdkJ+O+UA=; b=jofjwsssjrOe152ppgR2/xg6Pk
	5vTN3xXY5fl/bBBtqBFl5XOPJNvn1RKmdLOAJ5aEKzP4H+RWIo1tOQRitpPSb/JQT34MOIv7E9ZN8
	dNVqEJt4fnKAEO/Gai/pgsarpxPrLc/JpUOBx8W6TH5sYrfZZotUQbOXQCMmCo7eZMYUp8a+N1kZI
	hlDy/CwLhHy7sJPluNqBtvs2sFg4ksUmGogwimys2kiB5jm1CXc6sEiCw5e8erXAVeo1SokzhmtSj
	MEaWCJQC7XYffrQxqHD8phOGAKKKNjfoDG7ZMqPP8NpDcu9LAXhhw3SRhJeXf/eK6Whv/D6uz9CB9
	8gYVt8Rw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJBHN-0000000FdOq-0OuA;
	Wed, 12 Nov 2025 13:52:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 12F2E300265; Wed, 12 Nov 2025 15:48:23 +0100 (CET)
Date: Wed, 12 Nov 2025 15:48:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Message-ID: <20251112144823.GE3245006@noisy.programming.kicks-ass.net>
References: <20251112122521.1331238-1-mgorman@techsingularity.net>
 <20251112122521.1331238-3-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112122521.1331238-3-mgorman@techsingularity.net>

On Wed, Nov 12, 2025 at 12:25:21PM +0000, Mel Gorman wrote:

> +	/* Prefer picking wakee soon if appropriate. */
> +	if (sched_feat(NEXT_BUDDY) &&
> +	    set_preempt_buddy(cfs_rq, wake_flags, pse, se)) {
> +
> +		/*
> +		 * Decide whether to obey WF_SYNC hint for a new buddy. Old
> +		 * buddies are ignored as they may not be relevant to the
> +		 * waker and less likely to be cache hot.
> +		 */
> +		if (wake_flags & WF_SYNC)
> +			preempt_action = preempt_sync(rq, wake_flags, pse, se);
> +	}

Why only do preempt_sync() when NEXT_BUDDY? Nothing there seems to
depend on buddies.

