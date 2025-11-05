Return-Path: <linux-kernel+bounces-886463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA16DC35AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2A9A4E245E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE5D3126B3;
	Wed,  5 Nov 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XUj/OKLV"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79AB2641FB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346413; cv=none; b=M5OtABHmJgaQwB+cJdx2SrTzsfsgmwyeTnzeMAnL0WZCR6j19lErWP9Nz32gs/73IEAefvXG4xgkUbs+qXPXq7Mb+WUnxm51gJdFEwS9JY+nfav8E8c2IoIpYco9GbaNqvf6JbFyzqCWJWP8H8GJIo+GPXISD85MIVQHyEuHwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346413; c=relaxed/simple;
	bh=9vKj67iakbcTIdLLoTrk3T6B82VmWN8TfwxCHjEY9NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVXPzkLXAair+G+N0I8dQq+Qp8TaZZDNczNKgi68/uZX5VYLHmW/J8y/brzuD+e1/9J4/MSdxfO/rzydglI7j54hLiy1v5HGPp06Wd2z1k+SX393oWuGwnokblUDylCK/uAfB9z5LuEqc5uVv5S7um2K3jSFs7bdyuPM7YHRogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XUj/OKLV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9vKj67iakbcTIdLLoTrk3T6B82VmWN8TfwxCHjEY9NI=; b=XUj/OKLVHsd2xg3I7IDn7ozpcT
	98ghxrY/sODS459O4KfecoX+BiCTQKsLqudfCEsPiFO3fD69pSc1+5UsvaziVEDOeYWewfZyUzv81
	KUILwNJjp58pnx7DpupEHJDfBbJ0XMr8FlFDnnRv8yoDTPOvAXexrOKsrQRsY9ijBwVkGYTyW9Nzm
	xRFWu0AevRvuXcD6ZiG15VtwBIf+CHGXx/OV3ZSIYux3WwxRBjnCZkEyMYaThoD9fGfRklAkOLI16
	j9ONwP/pDN5gRcjyLdRJiAJ+PY4qItsqKQSRJtVxsRBndLfOKs6QDURGXXKjoJ+1Ven+wgvafg++Z
	pkSjpL6w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGcnp-00000005zMG-3wcz;
	Wed, 05 Nov 2025 12:39:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A66EF300230; Wed, 05 Nov 2025 13:39:54 +0100 (CET)
Date: Wed, 5 Nov 2025 13:39:54 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	wulibin163@126.com, tanghui20@huawei.com, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com
Subject: Re: [PATCH EEVDF NULL deref] sched/eevdf: Fix NULL deref when
 avg_vruntime nears overflow
Message-ID: <20251105123954.GM3245006@noisy.programming.kicks-ass.net>
References: <20251103130441.1013188-1-quzicheng@huawei.com>
 <20251103202611.GE3245006@noisy.programming.kicks-ass.net>
 <7cdcc98e-990e-4408-ba75-57dd0229316e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cdcc98e-990e-4408-ba75-57dd0229316e@huawei.com>

On Wed, Nov 05, 2025 at 06:47:40PM +0800, Zicheng Qu wrote:
> This is the reproduction patch. We encountered a similar issue on a
> normally running kernel, and after analysis, we deliberately constructed
> a comparable scenario. Since it is difficult to control the conditions
> from user space, we proactively modified certain parts of the kernel
> code to simulate the issue (the code includes detailed explanations).

Thanks!

> As for the zero_vruntime patch, after applying it, we have not
> observed any crashes over than 24 hours.

Excellent, I'll go think about the SCHED_CORE case and make it a proper
patch then.

