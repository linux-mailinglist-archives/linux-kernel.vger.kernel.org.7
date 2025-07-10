Return-Path: <linux-kernel+bounces-726517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B36F6B00E07
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30B61C20B81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E684F28DF06;
	Thu, 10 Jul 2025 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tTfexU95"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB6722338
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183840; cv=none; b=Tc3tbyLEfNnJtLYZiq2n0Iy9oYes4l2ma6hmWf5CL2pPVXD7y2lKXnkixT4Su0yPrYtwHiHk6xQm7NTgtj1jAghckZovdnHyP0eDkNvYwL3N094IeZqqYqO42zMlcZ2K4gVsYh6NMGQdywHtSczi7pM+V/8z9AYkxArHYa2qOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183840; c=relaxed/simple;
	bh=vhE5fgHbJMdujN7tlr7CtvmBwY8+MnN527EJ8tnqCDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neZN3NblFpM6kLTMwRw8SQMIjJgVsBn810ongpeLiwyDo/xQCaMiUp3gE0C8aKI2Az5r3N+tw5k6nrIexPceDBUjcGOoIzxOuOV4Ig7epqKCOnwB8afQNe1jk7uN5qyu35iEK+4Kw0gnEu7+YJTszMel1EYN0KsaheQlBN5eLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tTfexU95; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Yot/lVhOPL+QunGdP+vqzQLV/Yuarw2iaa8zW809OMk=; b=tTfexU95wuWnLKZw6H9Q2MqdAv
	kE0u8YouiKTJVKTPu078bf93t6z8kaKmy3wd9Y8oM0qzGGPY5W2TYx8IGgkjNUw180P+hIpj9Zxa8
	BIMK5GrSuFxA/bcQfGbGx4/A6pp0Wf1POIQ51Pzn+/a++Nu9mdjSZAD1W2pJktVaB/wXS3BlWrzFB
	w9OfAkD36Iv8vg5lwUJcmWFJGDGRdcdYB3kM5QTFUlf41yu2OVy/SN7ovh+ceCmr4Pekg/K4hzGV9
	hdEv5AOUnFStziTQCxjGdRFOvwouHK0xuY2EiOaHlfY2BO62znUYkEusLaqwnUwrAKNwAC5aFGoOB
	gr8qn88A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZz3Y-0000000ARrZ-3VJf;
	Thu, 10 Jul 2025 21:43:52 +0000
Date: Thu, 10 Jul 2025 22:43:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH] mm: consider disabling readahead if there are signs of
 thrashing
Message-ID: <aHA0GBVJmAt-WS2j@casper.infradead.org>
References: <20250710195232.124790-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710195232.124790-1-roman.gushchin@linux.dev>

On Thu, Jul 10, 2025 at 12:52:32PM -0700, Roman Gushchin wrote:
> We've noticed in production that under a very heavy memory pressure
> the readahead behavior becomes unstable causing spikes in memory
> pressure and CPU contention on zone locks.
> 
> The current mmap_miss heuristics considers minor pagefaults as a
> good reason to decrease mmap_miss and conditionally start async
> readahead. This creates a vicious cycle: asynchronous readahead
> loads more pages, which in turn causes more minor pagefaults.

Is the correct response to turn off faultaround, or would we be better
off scaling it down (eg as low as 64k)?

I like the signal you're using; I think that makes a lot of sense.


