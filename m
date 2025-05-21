Return-Path: <linux-kernel+bounces-657396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71366ABF3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 14:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59E71BA74D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 12:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C9C26560A;
	Wed, 21 May 2025 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pxlgghmO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D51264A92;
	Wed, 21 May 2025 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829149; cv=none; b=dgALn+/PrmZCKoaiCS52vynaK4rkBlbpF7GzGCctudmF9l5lbvfIHvkk27qVKEHQFVlOi3Q7hqPxoc+CmS1+jv+jvb3IO7QxRqW/RdKie3QHpRM1nyJGADr882W+cWV5G7PEkzArKBoWmQRnZzXWbR/kI5HpY15zecRH1+E71AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829149; c=relaxed/simple;
	bh=6y6pA2v91iQmSvQgFz0Uojt+/84qWji3dUd8c5vCkkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idWlK6KTJb2doRgBcLHm1vuWcwbS/Kdz/L7OSz1lNemOuIF0dFLmD/+S619MRE9oObfefI7GgpmX+gp5wJ9P9O6Pyhh70jQn/Lm4QgBqdedZhDP3szK/oGvTIMRw1voM7ogkcNnXtUkFONshEmBKOXIQ2DCK1h3I0c1+cqfDzyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pxlgghmO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fiwT5IEBfiiewAOT9kPl+ck8nR9/bB1A4OgJlEVgr4w=; b=pxlgghmOtwAjfkB5+OFBi+X16q
	CIldROuYOtG65qBi/T1OmF9JzmMDUj2tRHenO4jH/OrGMrOwx3bvfvmOOdPMqvBBVwx8sr+sG89Pp
	Gh2EdoAIxGHbXQV3dskV5JrwErhXiClfC051cA+F141HG83ExLpCY3hU+oL4qXp1AeH70u8DfhHWk
	mEruWH94WUvG286y74YuXmn1bRX/MPngMEWGqPXBRt9c/F0HRPJ868HdiOPmDEkSxDeJql2Z1wJUB
	AVxOSYRFHcQUT30ZVYrcT1AZE3ASlpFE0IFx7hGe6Cm8yDbNzqKyl94cF8BC5qB37jrCZoYQbfUwL
	wNEdK4Jg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHiCc-00000004ctY-0qD5;
	Wed, 21 May 2025 12:05:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A0548300583; Wed, 21 May 2025 14:05:41 +0200 (CEST)
Date: Wed, 21 May 2025 14:05:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, namhyung@kernel.org, irogers@google.com,
	mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, eranian@google.com,
	ctshao@google.com, tmricht@linux.ibm.com, leo.yan@arm.com
Subject: Re: [PATCH V4 02/16] perf: Only dump the throttle log for the leader
Message-ID: <20250521120541.GD39944@noisy.programming.kicks-ass.net>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520181644.2673067-3-kan.liang@linux.intel.com>

On Tue, May 20, 2025 at 11:16:30AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The PERF_RECORD_THROTTLE records are dumped for all throttled events.
> It's not necessary for group events, which are throttled altogether.
> 
> Optimize it by only dump the throttle log for the leader.
> 
> The sample right after the THROTTLE record must be generated by the
> actual target event. It is good enough for the perf tool to locate the
> actual target event.

So while both patches change behaviour; the first patch should preserve
all that was done and simply do more. OTOH this patch explicitly changes
behaviour in that what was done, is now no longer done.

Are we very sure there isn't a tool that expect per event throttle
messages?

I'll take the patches, but I'm somewhat suspect of this one.

