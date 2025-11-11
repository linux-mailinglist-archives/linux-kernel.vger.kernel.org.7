Return-Path: <linux-kernel+bounces-895258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91FC4D5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18747189681D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67003355033;
	Tue, 11 Nov 2025 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YSQ1ITM9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0872355028
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859841; cv=none; b=KlOdvVXMucFn95LnIqF3Iw1lhjH9xHSf8Sj+SQo3Ji/0wDclHrxFYMyslAjA2DJFbDNZYPOTB7VEc/z4uwAVV0OO8xUf5v6aUdmCFs3jcH/EslDl4U5VjH5sYWsSW5YoP+FXcNClzccs5mq9VZnBNfShHH7wU4dcaZRJGP43epw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859841; c=relaxed/simple;
	bh=RpWsHD5f75175/edKPGA+S9s1MGnsbXe0M6k9lQj6yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saOS9Irt7z9qGy82ISBrR32mZAFNOIF0t/2aUJXsJbZ4XyW++6rw3WTKUCKfhs1kgwdzedWjfUujxxgkDAtRz6L8PY0g6rBmXlaHTQcRVnK5+hERict9YGllIuPPUJ1kCHHL5D1Wl684bPYga97lkNzDzfUXECZPRQQnjHc7qYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YSQ1ITM9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RpWsHD5f75175/edKPGA+S9s1MGnsbXe0M6k9lQj6yI=; b=YSQ1ITM9ZERz9vounU08f7c8xW
	rJ/qHvVX38wKNjUua4yBacS+3ioCm5Nth4i0oRntF6RXol5vn2F/vbJhOdjfo8rts7o28n+KpMRkR
	ioptTV0naJux9zC7npfFGNtldQUmyYTmHIQ9UqhhEDoowAbip+2WWOJeWVYn9KaA/lycE8MdzqIMS
	VwPzbsRlerW3n23OHQ1wl0eP5hq+YgqHR9NETKBEWykOtL7KSOxF1E18T95RiNSRy9rLA0YFxRTSO
	fjDVMoOlg0GyYnvaYR1yKbRyRTcwonfBWZ0IKF4JS34Zbt7rsSDkcAR9GuGYs73hn2D56GrNNAsJW
	O5jbF42g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vImNB-00000004BuK-2CFo;
	Tue, 11 Nov 2025 11:17:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0A7AD300328; Tue, 11 Nov 2025 12:17:17 +0100 (CET)
Date: Tue, 11 Nov 2025 12:17:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>, arighi@nvidia.com
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <20251111111716.GL278048@noisy.programming.kicks-ass.net>
References: <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
 <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>
 <20251030184205.GB2989771@noisy.programming.kicks-ass.net>
 <20251031130543.GV4068168@noisy.programming.kicks-ass.net>
 <1f2ad071e59db2ed8bc0b382ae202b7474d07afc.camel@redhat.com>
 <20251031152005.GT3245006@noisy.programming.kicks-ass.net>
 <2daa2e6217eeaa239616303626c0d73d808ae947.camel@redhat.com>
 <20251031154455.GU3245006@noisy.programming.kicks-ass.net>
 <20251101000057.GA2184199@noisy.programming.kicks-ass.net>
 <b8454329ce061f0c113b25b9400e2b0771fa9e27.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8454329ce061f0c113b25b9400e2b0771fa9e27.camel@redhat.com>

On Tue, Nov 11, 2025 at 10:58:51AM +0100, Gabriele Monaco wrote:

> Is there a reason why dl_server_stop() doesn't reset the running flag?

Yes. Suppose we're boosting a task, and that task has a small sleep
(mutex or whatever). The dl_server won't have anything to actually boost
and will stop itself, clearing running (if dl_server_stop() were to
clear running).

Then if the initial fair task wakes up again, we'll (re)start the
dl_server, but since !running, it will go do the whole defer/zero-laxity
thing again, making out task wait for a whole period until it can run
again.

Conversely (dl_server_stop(), like now, does *not* clear running), if
running is retained, the dl_server is able to immediately resume its
still valid runtime.

Put otherwise, a fair task that always runs and a fair task that has
micro-sleeps should more or less behave the same. We should not punish a
micro-sleep with a whole second delay.

Now, if the sleep is long, we'll find the deadline is in the past and
then it pushes the activation forward and we go ... Oooh to E.

Let me go draw that line in the diagram.

