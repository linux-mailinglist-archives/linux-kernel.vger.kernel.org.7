Return-Path: <linux-kernel+bounces-729672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5DEB03A25
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21AEB1891B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FBF23A989;
	Mon, 14 Jul 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YWT0Jv1q"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EEB198E8C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483467; cv=none; b=BrS0HbnVFuoAG/5CVPI44nIPFng2IOLUqF/PY0T3hYFgVeo23Z6+kc0VT55ZHO54f8FNPT5GOgiNwgWgkqHBKaXR3EWfUNN32RzHtn7ppqk7iP+R8iZ6i0UN5TAXPW0z1nkb5biGVOLSk+VFVKPYxiWXdLEsbfgdv9hF8/tuOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483467; c=relaxed/simple;
	bh=TBZOnMOJrvNQ4QWCY/1VlrxplWTM7R3zW9huyEwCz0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaZa7gPEqk254l7KgTwJMl/JkNDLAyqgjXN/zDITXFDTFdBmpTEj68NpVZxJNFZa7RqY7+Wt/NEU867HDuCy4k3L5RJtKvJS2m7aEDtcVPEsQVANBHvMjA0WnOJdqPtbNFFncIdLMScwQHer+odZAgI/arWTeDPNfK1JLI4blVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YWT0Jv1q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t2UpYQwB+D7PZb318IHnhuH4uZMwRt/xC1ltZf6ovAY=; b=YWT0Jv1qRf5qEOAxINeYcfP9VA
	BfLVOGn3wc/8R6EGz+sXgwaXJxvXiI9nIf6bk7xSJF1C2iHfud71p0Dm4hQDVUxDCQg+fooIakYaW
	H41ku8qY35P9QPhPJo1TBgHSU2YfhkwtWqS2p6C2gvPsRa/Uq2a+xFer1rWDqB4sJlnquHanAVxuo
	vhXv5oubWIPe3qxQjvCzf6k+RV0+yoIOzx9BJx1o2LRB6TfHabYrSVN80wfL5WQiGZ5DhEO+z/1Pl
	KYK4lFjdUeDtzLnFJ32NmJe1e9IHX2k2u/1cL+xYkV1jxuvw5eILbh8Nbe3e1gvv7maOEqtoa/4tI
	tew/3yew==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubF05-00000006aFt-3BAX;
	Mon, 14 Jul 2025 08:57:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 51E06300186; Mon, 14 Jul 2025 10:57:29 +0200 (CEST)
Date: Mon, 14 Jul 2025 10:57:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Li Chen <me@linux.beauty>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Li Chen <chenl311@chinatelecom.cn>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] smpboot: introduce SDTL_INIT() helper to tidy
 sched topology setup
Message-ID: <20250714085729.GM905792@noisy.programming.kicks-ass.net>
References: <20250710105715.66594-1-me@linux.beauty>
 <20250710105715.66594-2-me@linux.beauty>
 <ba4dbdf8-bc37-493d-b2e0-2efb00ea3e19@amd.com>
 <20250711130601.GD905792@noisy.programming.kicks-ass.net>
 <0305d98a-0300-429a-adc2-39fd9b3af876@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0305d98a-0300-429a-adc2-39fd9b3af876@amd.com>

On Mon, Jul 14, 2025 at 09:33:42AM +0530, K Prateek Nayak wrote:

> Works for me! If you need a formal commit message:

Thanks, much better than the badly edited thing I put in place.

> P.S. Are we still considering the following for v6.16 cycle?
> https://lore.kernel.org/lkml/20250709161917.14298-1-kprateek.nayak@amd.com/
> 
> If not, I can rebase it on top of queue:sched/core and send it out with
> the conflicts resolved to save you a couple of edits :)

Already done, about to push out.

