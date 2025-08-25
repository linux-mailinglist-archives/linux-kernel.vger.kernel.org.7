Return-Path: <linux-kernel+bounces-784576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF122B33DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C821A829A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCFC2E54D5;
	Mon, 25 Aug 2025 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qrWvt8LS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133352E54AF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756120608; cv=none; b=c0wBBJ+rqqTzltATNtDaS5rs3M2VAGHdhdvp0idA/8BtGy+eU0RbYOphZ3w+E5yeDwoCLI03LR32++fBw2FG43evKOasbv4wriCzcCklHVvHwqOMMBwcXTcaNJ0vL3pjwUILaa8UiruME65dcUEIBti+F4qW36zSqtdIK0T/Wt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756120608; c=relaxed/simple;
	bh=SPJR7uJhGInz2KZGEddoMGVHGiCZrKkJviN5g68Z/ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svTz/iLZrTIYSOrM3a5IT/7tBSlD+8eMBl6CbmWvQt+AKL+ovWRHeCmGPlKde5z0cP5xJb5WUVyk81P9sSZK8Fgg6OuhPBvodYW9xbUSu9EAFPwQnZklpseOGKeGFa1Or9P/XlULplOTyMl9Pmot4fkfGDdQX4HJr2RP+LVu6zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qrWvt8LS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rrl9UkyUdItDNcAw/xne76M1VkKyzNn65MaBaQl4+bY=; b=qrWvt8LS1VSqG3guB31QEa6+W3
	DmMrTK3TCmfxI+GKCA5dUYZAcGtNU/8Xxu4Zsbn8YONkr/MdEI1r/V8dwuQoBP/8RAyMilZ6i0THs
	CnciEapdlkCA/AYniymoc9NA8jpWtMDze+qE5NNhJ2xSN4mf7BfxQkpJq3rqE9qs8zEO7rN8/9qq2
	kgHR48zNhgSMmf8bQbkWR3L7RJTwdmqI9Bcqftv5sFVG72RzsXGpc8GyyPL0adeK2GGYiyMkof/xM
	7sPlnRgXxEAzB/3Xt7ZikH4kevq7oF5xTUK1NpSJkvGMFClIWj/svkGPHJ9XFx1NuE7Dd8z7kaMOF
	CwjFW/eg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqVBb-0000000CF5M-142f;
	Mon, 25 Aug 2025 11:16:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 100EB3002ED; Mon, 25 Aug 2025 13:16:27 +0200 (CEST)
Date: Mon, 25 Aug 2025 13:16:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@alien8.de>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	srikar@linux.vnet.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH v5] sched/fair: Use sched_domain_span() for
 topology_span_sane()
Message-ID: <20250825111627.GW3245006@noisy.programming.kicks-ass.net>
References: <20250715040824.893-1-kprateek.nayak@amd.com>
 <20250825091910.GT3245006@noisy.programming.kicks-ass.net>
 <5940cd15-b207-416a-b4e4-b5953f4cbf47@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5940cd15-b207-416a-b4e4-b5953f4cbf47@amd.com>

On Mon, Aug 25, 2025 at 04:17:52PM +0530, K Prateek Nayak wrote:

> The above helpers may need guarding behind CONFIG_SCHED_{SMT,CLUSTER,MC}
> if I'm not mistaken. Possibility for some unification and cleanup with:
> 

> Thoughts?

I hate we need __maybe_unused on static inline functions, but yeah, that
might be nicer.

Can you fold the lot and stick that nice Changelog on? Then I'll get it
into sched/core and we can forget all about this stuff.

