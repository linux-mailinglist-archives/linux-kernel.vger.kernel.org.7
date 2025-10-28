Return-Path: <linux-kernel+bounces-874034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7A5C155CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA87403323
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3B6330336;
	Tue, 28 Oct 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JcFuDfUm"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48142253A0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664200; cv=none; b=pM397+S3z7+Nwz4CgcOmfVRGdIPW1iCoSGitmu6A9daRXFfJ1LvUbFH0+0SaDl4Et8VFUGbNnYCdZR/II3JgKq2q1eO/NrBPz+Zkd02shh5d2v89qmaFzSUeltvMbmQkCrKFY12tegm3h3HrslNwe3o85a6D+gPkaWvHP0ubuRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664200; c=relaxed/simple;
	bh=hLhp57BJ4FJe7BaRm6JxmUcgxCIhvxSY8tIzFRrsP2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AC6gyTgfyiPh//wGobyZ7JZtzIAT6cgukIFY2g/TSdy0BjVI2tCP9dcbkou79gcp4xFFs/mqJjjIjPb/gBNV09JGFZI0qM3lxiN0SsaSCeaptsqAnCacj/uh8IwA4uWijff5hq2QM0upkti8SPhECZ5SZL50hbdTtzfvtX5MZ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JcFuDfUm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AWmIlBHFMo0aYymV49lblPXlL74wuGvYjsKJAEK6+dE=; b=JcFuDfUm+Nm0DQPsF0l7qLJ7Kr
	JPr85A9OrZqTmNIJr0ib4oC3qr/cw/mHC3L/rgP/teTq6SWQTP7Kw1qeuOf6oINMWi5hwvav8Aug1
	U7mzjZVgnjmCC36Wf89OL3ubqed1ELfOCqrbSG55W0JUmFXTKDT33iNiP0tHPlA6X9RGQ7yrtjzfk
	eua2hEDi2OLC1bah6DXDFKZhkyp8un3N7mURBEG+00yNczHAUsA8tgQSpOzoBJxAj+AIIuvKy/Uao
	xEizy/FBSlIGQg6tNUAyFkfFfqhvxpZmnsy1YLVPnqKXsuhKjbAeL5YGZtongWZXTX5wzNOpNvWNd
	WNjyXt7Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDkSq-00000004chr-36mj;
	Tue, 28 Oct 2025 14:14:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EA7E4300289; Tue, 28 Oct 2025 16:09:51 +0100 (CET)
Date: Tue, 28 Oct 2025 16:09:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chris Mason <clm@meta.com>
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
Message-ID: <20251028150951.GD4067720@noisy.programming.kicks-ass.net>
References: <20251027133915.4103633-1-mgorman@techsingularity.net>
 <20251027133915.4103633-3-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027133915.4103633-3-mgorman@techsingularity.net>

On Mon, Oct 27, 2025 at 01:39:15PM +0000, Mel Gorman wrote:
> +enum preempt_wakeup_action {
> +	PREEMPT_WAKEUP_NONE,		/* No action on the buddy */
> +	PREEMPT_WAKEUP_NEXT,		/* Check next is most eligible
> +					 * before rescheduling.
> +					 */
> +	PREEMPT_WAKEUP_RESCHED,		/* Plain reschedule */
> +};

In pre-existing code that isn't modified by this patch, we have:

  if (do_preempt_short)

Which seems to hard rely on PREEMPT_WAKEUP_NONE being 0, please make
that explicit in the enum above.

