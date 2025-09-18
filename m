Return-Path: <linux-kernel+bounces-822156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB1CB832DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB293ADCC2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CDA2DE6EE;
	Thu, 18 Sep 2025 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XWoH4YFh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A2B2DA760
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177794; cv=none; b=OqfnsLv+w3rb38yu3+oFSbt4yfaQtjqZJEVM70Tk9TCpCt7/3Cb8lE30u3h0onuTt4QnO5QffxEsVPzd0E76AjawIHZFL3S8frUuIndQ3xMkWNWaOZq08hhnGHmHNO7ADJ3Ad8NmUWyP+wug+Q1o6H8DF58WEY6we59FnfAq0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177794; c=relaxed/simple;
	bh=7k8zgSkqtDkKEsKfNO1cv2e6Y61ZDSDzRMh2EFG0Fag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U22jhKb+JT1hqnV8FO7oAaQ6+V2dn/XVc6gvST/jOuqv++K7pUpNOZErQyn9A1QTvrjYUGnMRx97cPLP+5k4+zR8PAxHjZua4QsPYwqrFJPL9AFdsYnY3H3lRFr/iDXp5O6TbFusHeasB5hLQuf5OnymhGs/jpoQKVtUn5yiM3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XWoH4YFh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xQ01SRHt8Kl3gO/hwlHK4SDdqX0acYxBGghBpBCSQgU=; b=XWoH4YFhSBxNxTs1rZGMtMRA/M
	fjSqg+cnvR/o2HUlEOgdqGHL9zbPFrcUktWBiey8aTHy+8CSXCXRzgAnbI2FtNlx4KaMuihmaOpyq
	J1Mno5MgpaofcjXmIRsVaeA+z38NcgkZA5QCd9i64TjcJR1FbwNef/mdx9xKGcxHRWnESvV5K1C94
	3pu7OeVxivaV92DCKRdE7fJN7I99RYJeCGIfVSxXgtu1ggHvqoi7EqyUy5b3zFFODNarQgnxcKiBN
	F9PbGc610dDrYP1vbQA1MqrIJP2AyIUtPz2NDT3fn7Ib3SIdyEaTJuM2+Ht2pEeAWg7ZGTCdaOZkC
	/4srO+7A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz8M9-0000000E7hj-3lif;
	Thu, 18 Sep 2025 06:43:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B0862300328; Thu, 18 Sep 2025 08:43:00 +0200 (CEST)
Date: Thu, 18 Sep 2025 08:43:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Fernand Sieber <sieberf@amazon.com>
Cc: bsegall@google.com, dietmar.eggemann@arm.com, dwmw@amazon.co.uk,
	graf@amazon.com, jschoenh@amazon.de, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	tanghui20@huawei.com, vincent.guittot@linaro.org,
	vineethr@linux.ibm.com, wangtao554@huawei.com,
	zhangqiao22@huawei.com
Subject: Re: [PATCH v2] sched/fair: Forfeit vruntime on yield
Message-ID: <20250918064300.GV3419281@noisy.programming.kicks-ass.net>
References: <20250916140228.452231-1-sieberf@amazon.com>
 <20250916160036.584174-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916160036.584174-1-sieberf@amazon.com>

On Tue, Sep 16, 2025 at 06:00:35PM +0200, Fernand Sieber wrote:
> After further testing I think we should stick with the original approach or
> iterate on the vruntime forfeiting.
> 
> The vruntime forfeiting doesn't work well with core scheduling. The core
> scheduler picks the best task across the SMT mask, and then the siblings run a
> matching task no matter what. This means the core scheduler can keep picking
> the yielding task on the sibling even after it becomes ineligible (because it's
> preferrable than force idle). In this scenario the vruntime of the yielding
> task runs away rapidly, which causes problematic imbalances later on.
> 
> Perhaps an alternative is to forfeit the vruntime (set it to the deadline), but
> only once. I.e don't do it if the task is already ineligible? If the task is
> ineligible then we simply increment the deadline as in my original patch?
> 
> Peter, let me know your thoughts on this.

Sorry, I missed this email earlier. I'll go ponder it a bit -- my brain
is esp. slow today due to a cold :/

