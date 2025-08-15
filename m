Return-Path: <linux-kernel+bounces-771513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA559B2884C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558741CE09BA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64784244186;
	Fri, 15 Aug 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="otoMbQN3"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5F2036F3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755296503; cv=none; b=A7YXdXeMzaDBYAs30yTJtlu2w0jUBbhhhptNdTpy4PqxyJJDdqAdU00IYJzIKi2ueDdZF52DvIVbFfMGZ1TTy5KsigCdwJmoTmPP7lvlt08DnihH2kbx0jU0/qRgfE2tbMbTnL/W3KruVW9bBIYUPMh5AReSErdSoYYBRFCJo3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755296503; c=relaxed/simple;
	bh=4Ez0WKG/3WuzadLVXsjs8HTllh4A7LEq9nEOCJvMRVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eL/Rb5W28A+Ncx+vgi6xCGvuF9CZ8j5Cy4HaKuo4OCmOB2J1Lk4hipeoajP3xlIPcsz6dlz+c5V9PCTXouNZVgg/IrSws7nrWbjEFL4CKYHfKB79f3GK4XIaQ7L3Hq7PNPYe4ui55FooTsYFt1osV/RkoA+fm6LMVU4QKS27EYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=otoMbQN3; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755296499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rgYtSz7R5teKnHMH10nhKu0C+pGzCAV4oleJjtCiZtI=;
	b=otoMbQN3GkVTU0l/Rh3ZMBeC1r1PX/FjhMh9v/jmTvz7zJkTG+nf02A3nyaSN3V526/+f+
	6fSHjQqp7Qi6g+uNEhTUBDjxZOFxIbwdL0bYSmJUS8sD8wp19zOsANFntwx1bbUJ5o2zJ4
	v6k+sHg3pk3N+F6igLB4JuAc1xtJwb4=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  "linux-mm@kvack.org"
 <linux-mm@kvack.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: Regression caused by commit 4687fdbb805a ("mm/filemap: Support
 VM_HUGEPAGE for file mappings")
In-Reply-To: <87plcwdyjs.fsf@linux.dev> (Roman Gushchin's message of "Fri, 15
	Aug 2025 15:12:39 -0700")
References: <87plcw8lyq.fsf@linux.dev> <aJ-gGXNwOMeLBs0W@casper.infradead.org>
	<87plcwdyjs.fsf@linux.dev>
Date: Fri, 15 Aug 2025 15:21:35 -0700
Message-ID: <87bjogdy4w.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Roman Gushchin <roman.gushchin@linux.dev> writes:

> Matthew Wilcox <willy@infradead.org> writes:
>
>> On Fri, Aug 15, 2025 at 11:43:25AM -0700, Roman Gushchin wrote:
>>> The commit 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file
>>> mappings") causes a regression in our production for containers
>>> which are running short on memory. In some cases they are getting
>>> stuck for hours in a vicious reclaim cycle. Reverting this commit
>>> fixes the problem.
>>> 
>>> As I understand, the intention of the commit is to allocate large folios
>>> whenever possible, and the idea is to ignore device-specific readahead
>>> settings and the mmap_miss logic to achieve that, which makes total
>>> sense.
>>> 
>>> However under a heavy memory pressure there must be a mechanism to
>>> revert to order-0 folios, otherwise the memory pressure is inevitable
>>> increased. Maybe mmap_miss heuristics should still be applied? Any other
>>> ideas how to fix it?
>>
>> What's supposed to happen is that we should have logic like:
>>
>>                         if (order > min_order)
>>                                 alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
>>
>> so we try a little bit to free memory if we can't allocate an order-9
>> folio immediately, but we shouldn't be retrying for hours.  Maybe
>> that got lost somewhere along the line because I don't see it now.
>
> Yeah, I see it in __filemap_get_folio(), but not in ra_alloc_folio().
> I'll prepare a fix for this.

Actually I'm wrong. It's there, hidden in readahead_gfp_mask(), and it's
not conditional on the folio order. However it's not helping/not enough.

