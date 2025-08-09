Return-Path: <linux-kernel+bounces-761198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5478DB1F5B0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 19:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1410D6256CC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086162BF3D7;
	Sat,  9 Aug 2025 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="v71QqACL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29929CB39
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754761126; cv=none; b=ECxgnioqaAzoiv8N1ob2LJLEuXDSDd28phwVI+UUH3cZb1pgxoxJsNXl9zzWdhVqgSca/uWkUTrFLwyCcUosb081Gl1WdLfRENU3tAQPrM3sWSbKNjM6jOa9M8bqZqVSam3vSU9FW2yuUUy7axBPnCNoKyqIabAsrjeF+ildM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754761126; c=relaxed/simple;
	bh=Wot/69dsHs/GESb54RZeUFnXDmcOEqiL63MrJD9t7XU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SICWMjxuTF4SKyBPhnmYmVJ8Y2EddqrN/8pUS+/OhUI4B/AJJ6HQExMywHZn0uSkjUuVSCZHBVw2sn6UzdgOaKo8ZhFKMksqW82S+IPxq+LPt8C0EI7Ezym0hhh3wknZbJ3J1bDUddaGa3LoEFdtUSGAdV/akf90ydkrqoilpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=v71QqACL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B8EC4CEE7;
	Sat,  9 Aug 2025 17:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754761125;
	bh=Wot/69dsHs/GESb54RZeUFnXDmcOEqiL63MrJD9t7XU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=v71QqACLAlEXZHsJC8YNMN9x1cZKNM313wf7JjuOJkxWPIINOxUYRf1+qfmLGBBws
	 dtp/D9xGTnOqAUzIqeAjnr0aSpvDo7W3WqVEEuztO/9dZCASuFpXPUTKxCGDHqI7V9
	 a+9ZDQnabITo35u/Q5NJ2P97bECh29wOOR8T8eXI=
Date: Sat, 9 Aug 2025 10:38:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Subrata Nath (Nokia)" <subrata.nath@nokia.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: prevent RCU stalls in kswapd by adding
 cond_resched()
Message-Id: <20250809103845.21ca58f0a97c0c1f61c0879c@linux-foundation.org>
In-Reply-To: <aJdkmCP41RhNC9FH@casper.infradead.org>
References: <AM9PR07MB78119166E41E86BE5E7DDCC0882EA@AM9PR07MB7811.eurprd07.prod.outlook.com>
	<aJdkmCP41RhNC9FH@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Aug 2025 16:09:12 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Sat, Aug 09, 2025 at 11:59:16AM +0000, Subrata Nath (Nokia) wrote:
> > Fix this by adding cond_resched() after all spinlock release points
> > in page_vma_mapped_walk() and in the main loop of shrink_zones().
> > These calls, placed outside spinlock-held sections, allow voluntary
> > scheduling and ensure timely quiescent state reporting, avoiding
> > prolonged RCU stalls.
> 
> No.  We're removing cond_resched().  See
> https://lore.kernel.org/linux-mm/87cyyfxd4k.ffs@tglx/
> and many many other emails over the past few years.

tglx's email was sent two years ago.

Meanwhile we have shipped kernels which are emitting nasty warning
splats (which are indications of possible other misbehavior).  So I
think we should proceed with Subrata's change and give it a cc:stable
also.

We already have 285 cond_resched()s in mm/.  If Thomas's idea ever gets
implemented then six more won't kill us.

