Return-Path: <linux-kernel+bounces-856551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DE3BE46F7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9C42359A12
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70213215043;
	Thu, 16 Oct 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hib2KEcK"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8925D32D0EE
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630536; cv=none; b=LdqNwhwIQ/k0nfa8o9vW/EiLXqRxkZOLxE5A4whWLvvwcsOSlKTS9UJZT8EkCW/0Xy4bM63npq+dVYe9ft/chKyH0C2/eyJ2qpswIkzPzHTMmLAdXiSrIg/AdqVyXec/71Zqpj2uo8WNL8E8xFxKEHBeOxWCFQ+QzQCXYl2kFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630536; c=relaxed/simple;
	bh=Jm5LFvuTsFviGvBUlicQ2eYMOi51TET+zqZPdHcM6s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjUpLfL8Xf3ulekLybwMdSkwRDTaDpkmJ8PbH6R3yrqcuwjR0FZCFJuM450baZqAzq68VJfr9/wQTH/hVGHU8tQfGzYnKWnLs6DT7vbcpCPa/hk16WXk1mN6PU3jJY+ap8c9h7BnISZn67C0gjkvvxukbZRZTGYPmBqMX+1dOjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hib2KEcK; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 16 Oct 2025 09:02:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760630531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1bCIY+Fg4sgbbQh9/xqod7Q4jwfUiWgOzkJiNXMpw0=;
	b=Hib2KEcKq2hR8k4Ibve9BxCvscugQVL/Swl4CdjpYofAhCPpTVu108HgiRRCnno8FIVj23
	EzoyVoztcziQTefW9Y3hYfYIEAkWLFBxGW0H9epN1r4aH7NaU/eVAzN4KoVySJK5yp/yaJ
	mj8mf9MN+hq6vmGrYDsdx1qX1/2m55U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Wei Wang <weibunny@meta.com>, netdev@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: net: track network throttling due to memcg memory
 pressure
Message-ID: <pwy7qfx3afnadkjtemftqyrufhhexpw26srxfeilel5uhbywtt@cjvaean56txc>
References: <20251016013116.3093530-1-shakeel.butt@linux.dev>
 <59163049-5487-45b4-a7aa-521b160fdebd@cdn77.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59163049-5487-45b4-a7aa-521b160fdebd@cdn77.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 16, 2025 at 12:42:19PM +0200, Daniel Sedlak wrote:
> On 10/16/25 3:31 AM, Shakeel Butt wrote:
> > The kernel can throttle network sockets if the memory cgroup associated
> > with the corresponding socket is under memory pressure. The throttling
> > actions include clamping the transmit window, failing to expand receive
> > or send buffers, aggressively prune out-of-order receive queue, FIN
> > deferred to a retransmitted packet and more. Let's add memcg metric to
> > indicate track such throttling actions.
> > 
> > At the moment memcg memory pressure is defined through vmpressure and in
> > future it may be defined using PSI or we may add more flexible way for
> > the users to define memory pressure, maybe through ebpf. However the
> > potential throttling actions will remain the same, so this newly
> > introduced metric will continue to track throttling actions irrespective
> > of how memcg memory pressure is defined.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Reviewed-by: Daniel Sedlak <daniel.sedlak@cdn77.com>

Thanks.

> 
> I am curious how the future work will unfold. If you need help with future
> developments I can help you, we have hundreds of servers where this
> throttling is happening.

I think first thing I would like to know if this patch is a good start
for your use-case of observability and debugging. What else do you need
for sufficient support for your use-case? I imagine that would be
tracepoints to extract more information on the source of the throttling.
If you don't mind, can you take a stab at that? In the long run, we want
more flexible definition of memcg memory pressure. Let us know of any
requirements you have for that. Thanks again for continuosly pushing
this conversation.

