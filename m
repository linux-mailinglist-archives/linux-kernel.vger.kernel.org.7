Return-Path: <linux-kernel+bounces-891357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBCEC42862
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 07:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67FE188DB0B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 06:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8A02DECB2;
	Sat,  8 Nov 2025 06:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uzq6smUi"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA852DECA1
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762583595; cv=none; b=f9QW2mDRXeMdUkFZ+i82xM8Wx7JAbnsMayRvX255gPq013de+FO52v/lr41LFcAi7NGPPVQ8Quf5cXtPG7UMYgUPMLXY5jdDrhELCIRqm2HEbkYe8UyvntKD4VtG8hi+WnUBCRhjgeq7eY4NLyxPMypKoyWnq5SBNs6h2wtdA5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762583595; c=relaxed/simple;
	bh=dbfhdtCKn+6nvZ6eJ1H7Lwiq1Z6gbhIUoQCHaumcd70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4zA8GSYg9QXwf3P+5Ypmliyy5oE/CDMql+lMsndpsM+GySkEqeHTdvSBQwpX3wqsrO6sS91tkuDcGK/+HkeejlWX1WkufCyZs2JWx6Q8liJyFiWo51fn4+IRyrO1P6t8RxEs98cB6Wz0mLIxRaEZtE0pOIqoqkU02X/VjQhK4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uzq6smUi; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Nov 2025 22:32:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762583579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J/7T3JLvqIy8G97oSkwZiUgQ/us13qwXbaI51bbYH88=;
	b=uzq6smUiUaadIABNL4WAH3kQ9/NWi6rV98ylBfMFIppw4E+N8btmKbgAwhGrszMoJj9rnz
	CB2k+MOmm4mSUBVKeFZssHPocjdfCursoyR/iyfIffk6nTiCSrZTDcFQJPhgzISSZpcb6J
	ZQS4G8+TUhTtakAd1HkSQXaXtPTzs0Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
 <aQ1_f_6KPRZknUGS@harry>
 <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
 <aQ3yLER4C4jY70BH@harry>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ3yLER4C4jY70BH@harry>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 07, 2025 at 10:20:57PM +0900, Harry Yoo wrote:
> 
> Although it's mentioned in the locking documentation, I'm afraid that
> local_lock is not the right interface to use here. Preemption will be
> disabled anyway (on both PREEMPT_RT and !PREEMPT_RT) when the stats are
> updated (in __mod_node_page_state()).
> 
> Here we just want to disable IRQ only on !PREEMPT_RT (to update
> the stats safely).

I don't think there is a need to disable IRQs. There are three stats
update functions called in that hunk.

1) __mod_lruvec_state
2) __count_vm_events
3) count_memcg_events

count_memcg_events() can be called with IRQs. __count_vm_events can be
replaced with count_vm_events. For __mod_lruvec_state, the
__mod_node_page_state() inside needs preemption disabled.

Easy way would be to just disable/enable preemption instead of IRQs.
Otherwise go a bit more fine-grained approach i.e. replace
__count_vm_events with count_vm_events and just disable preemption
across __mod_node_page_state().

