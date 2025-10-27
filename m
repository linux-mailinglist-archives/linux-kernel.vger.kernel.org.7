Return-Path: <linux-kernel+bounces-872301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA98C0FD96
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0541E19A3CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0074431960D;
	Mon, 27 Oct 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rAopcPGW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B403081AE;
	Mon, 27 Oct 2025 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588472; cv=none; b=CE8GVmamXj0O5H2JtVtv+5ixQOSoV6Es6sBs6X29GrxQdjX6/P6ivDQC8HPlPfn678CJHoVqOtjSxrjLtVJurfDIvbcMxaXfWqbMVbAHurLxcTJhhQJhbluP5IU1sTj9U+lAYf4ojGwInFOmScrJqwIjvnrk0njPJ2cqQ+tgiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588472; c=relaxed/simple;
	bh=Y0IxQdwXFJbaZ0RbrxxHqrbIn4xmFy4S6FyRt1/zpbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZnEdRDB5pqfYnuwrBtUkmYnUYW7erpKOAvhusnluoW815qFtNS6mOzNdMCje8bWw9SKQZTYG1Onon+IyD98WIk9espwFcdF7CaljpaZMCIUJzHgWzKpBmG8zDj6DkZtS1cuDSSoyGEu6d1hv4wrIPz71fsPkhWc6XnE4W9CXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rAopcPGW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bDMsS2DiIEOBXANnWGU/hfbfv+twCpqA5UEG+wQp8ak=; b=rAopcPGWrHD+zS5v5XHUwRa0f5
	l5d1Z+q07hSqTJaopJcJ3Lg8RExGlRJEo3oOG/qMOzS7sUiJuKIqYwR8Qp0/VsJIVSa5bzli6OQLX
	6yHWaIA01ZnBTFMvOWAmZtSIKuBKbBV0HuHOglikqmz93OxiUZvCBao8ntNm9FUc7y/Qjf00/2Ooq
	nZ8NUuB6AygGhehoxQqZ1GERZZgz047DIzdg2tlV8mJ/ZNaaSL/FgTzUfCdH0LO8BmipXXKpFfA0c
	51yttNCxrAPsxhMfrTkzRcMXzZhec2tPOWUIrcQH1Pi6DIDgsiMlMTO/NI5zo905g3ogUo/daZ8R2
	pFa5yUNg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDQlQ-00000002l77-1zyP;
	Mon, 27 Oct 2025 17:12:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3119630049D; Mon, 27 Oct 2025 19:07:43 +0100 (CET)
Date: Mon, 27 Oct 2025 19:07:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <20251027180743.GA988547@noisy.programming.kicks-ass.net>
References: <20251025001849.1915635-1-tj@kernel.org>
 <20251025001849.1915635-4-tj@kernel.org>
 <20251027091822.GH3245006@noisy.programming.kicks-ass.net>
 <aP-XAGrWQY1d6Bq9@slm.duckdns.org>
 <20251027174953.GB3419281@noisy.programming.kicks-ass.net>
 <aP-0dkIQa7iwHv5e@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-0dkIQa7iwHv5e@slm.duckdns.org>

On Mon, Oct 27, 2025 at 08:05:42AM -1000, Tejun Heo wrote:
> > Also, why is this patch already in a pull request to Linus? what's the
> > hurry.
> 
> Hmmm? It shouldn't be. Let me check again. No, it isn't. What are you
> looking at?

Hmm, my bad, moron-in-a-hurry-can't-read and all that. I though it was
included in this one:

  https://lkml.kernel.org/r/36450bebbc782be498d762fcbcd99451@kernel.org

