Return-Path: <linux-kernel+bounces-853265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA359BDB10E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681D44075F0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5C02874E1;
	Tue, 14 Oct 2025 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JVcmS4Pr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474B23A99E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470390; cv=none; b=YkPNVKXgSoudyeh1B0gn9zO1MgmbDEzP+v6NGhCqHQ/JqSEL8O9Xq8lMY78OKlFF7XoZvDk2U9T/TKpKT19HTALwA3Z4sF0SL7zMwvG77Qp7v6ATs1KZHm8GIf4ZBnWpSKNSMPx/Irbd8uMTI9d/QoQK6AAT2VkBqV5qJhANsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470390; c=relaxed/simple;
	bh=lYoyy2SA1f2lUurrSBXzp92VvsodTAx20rR69AMykyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtJYGWnFBsWFysFdnsYsVPdCEmCpt1tzRUi3sKGWrvY5NJcEol8o3OUrhO5AQzN64v2/g4eL+Wq+ckpE5AiWOZkS8fu865bc8anoOodxG6X21otUfOlLw0ThZFfqN2KqasTumjbnH+RZY23nepeecCfxd02QfNmzAZalQoJivbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JVcmS4Pr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lYoyy2SA1f2lUurrSBXzp92VvsodTAx20rR69AMykyo=; b=JVcmS4PrNOuBepTT1bSwOUWGd6
	Fsw8qAbYWbqxVXTdkcWa642Bvw1jFZ2XKSf5N2H0LCmKtQigQI07fX4Qzcv6RjmbmxCU3Q10qTA2t
	wE26gr339LLxt4t3azLnyTSAjguXsNKotHDMx2SQYvQLoO+zY6UW3+VT2/ynZUnTdn87h39vu4LVc
	aJi4DSZcuh9CnJ2ceU9yQuauy+P3P4koWODgOQmaD9N4PrQQqB72mtd/uFYHWC4gMCkPEvt5GtoYn
	Y4Eu0pk0+uBeFFNFd68Y0haxIa5OX+p6ooQmaPj81CCZ8CTpAJEx6uYnzXPnQp4tuhRoxt9PyUCwS
	yY/BJQRQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8klY-0000000GjnV-2JCl;
	Tue, 14 Oct 2025 19:33:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 550BB300212; Tue, 14 Oct 2025 21:33:00 +0200 (CEST)
Date: Tue, 14 Oct 2025 21:33:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
References: <20251007122904.31611-1-gmonaco@redhat.com>
 <20251014095407.GM4067720@noisy.programming.kicks-ass.net>
 <a0ccf27f5e12a11d2e9dc951ceaf7f9d103f67f6.camel@redhat.com>
 <20251014102541.GS3245006@noisy.programming.kicks-ass.net>
 <83a5971ef07226737421737f889795ec57b6fa6c.camel@redhat.com>
 <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>

On Tue, Oct 14, 2025 at 06:01:10PM +0200, Juri Lelli wrote:

> Shouldn't idle time be accounted (subtracted from runtime) as well, though?

Argh, indeed. Then I suppose we should look at bringing some of that
'idle-for-whole-period' logic to try and actually stop the timer at some
point if nothing happens.



