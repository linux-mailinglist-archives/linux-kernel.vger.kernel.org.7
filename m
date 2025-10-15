Return-Path: <linux-kernel+bounces-855078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B07A0BE02B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98F494F5783
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF273254A1;
	Wed, 15 Oct 2025 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VryohoR7"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC523325488
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552802; cv=none; b=lApIl2HQLFG0ciAOOvgO3CQcxWmoCM6GG23/TMpOQ38xzez3ifVexQUdFZ7zeN3m+r7nIATd5X3D4gXFRfhROqyAHmjVpdlw8NMP5nDyReDzcR+4gdl5JpHgXgQeLXtYr+HasskK7+Tb/7bEk6t4BjgQI+HTdMfZ4xVyKUMoD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552802; c=relaxed/simple;
	bh=00wFJljFesed5/2ArT+Jm3OMExYlXhAfSwnjHvca91I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXyZn/JZOHUwRPy2DLPXgi76pTkZ9l6xQcYpw2WpWUKwybdwWwcFOdJ2CE3jx7HmCONhlge2CJQCHRwlwPPXA+PiBwDxWPyc9VbRLVZhWt0NZ+restrGdW3NCqqkhLnQvvoyxLH3DCwvQW2xiLCFgjVNyOvKBlhBfz6KCKx0Egk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VryohoR7; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Oct 2025 11:26:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760552796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnr93v3DZbINrWDJ19P+8n2apC5wb+Y2uBcsyCCn+Ck=;
	b=VryohoR7UVW+CNLoKRwZEs3zNRn9GvrYMXHCOTsZ3RcnaWxYe9LiI5i3eZg9c4v3RnZcpq
	jAxwjSMDB3bZTSXfoZa3yYC/L1KyXk4uYi9KaW+/pIoKRq5gRt34pJxsVvtzmXMEeJCV1a
	oLjb01YD3ChA4d5Q2LUsAr6FzHLYTss=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Barry Song <21cnbao@gmail.com>, 
	netdev@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Jonathan Corbet <corbet@lwn.net>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Huacai Zhou <zhouhuacai@oppo.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Harry Yoo <harry.yoo@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network
 buffer allocation
Message-ID: <yr6mhjt2dq5mvkdsswbure5qqrofqbguvcln77zmxd43bomlyk@uidixnfu4mla>
References: <20251013101636.69220-1-21cnbao@gmail.com>
 <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
 <aO37Od0VxOGmWCjm@tiehlicka>
 <qztimgoebp5ecdmvvgro6sdsng6r7t3pnddg7ddlxagaom73ge@a5wta5ym7enu>
 <aO5o548uQAuBcw0P@tiehlicka>
 <itljl2e4rwbblmnhe2vucmsvxzbu42x5foszf4y5b63evbitpj@qsxj3amwhts3>
 <aO89YYhEJ-GDPWFg@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO89YYhEJ-GDPWFg@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 15, 2025 at 08:21:21AM +0200, Michal Hocko wrote:
> On Tue 14-10-25 10:22:03, Shakeel Butt wrote:
> > On Tue, Oct 14, 2025 at 05:14:47PM +0200, Michal Hocko wrote:
> > > On Tue 14-10-25 07:27:06, Shakeel Butt wrote:
> > > > On Tue, Oct 14, 2025 at 09:26:49AM +0200, Michal Hocko wrote:
> > > > > On Mon 13-10-25 20:30:13, Vlastimil Babka wrote:
> > > > > > On 10/13/25 12:16, Barry Song wrote:
> > > > > > > From: Barry Song <v-songbaohua@oppo.com>
> > > > > [...]
> > > > > > I wonder if we should either:
> > > > > > 
> > > > > > 1) sacrifice a new __GFP flag specifically for "!allow_spin" case to
> > > > > > determine it precisely.
> > > > > 
> > > > > As said in other reply I do not think this is a good fit for this
> > > > > specific case as it is all or nothing approach. Soon enough we discover
> > > > > that "no effort to reclaim/compact" hurts other usecases. So I do not
> > > > > think we need a dedicated flag for this specific case. We need a way to
> > > > > tell kswapd/kcompactd how much to try instead.
> > > > 
> > > > To me this new floag is to decouple two orthogonal requests i.e. no lock
> > > > semantic and don't wakeup kswapd. At the moment the lack of kswapd gfp
> > > > flag convey the semantics of no lock. This can lead to unintended usage
> > > > of no lock semantics by users which for whatever reason don't want to
> > > > wakeup kswapd.
> > > 
> > > I would argue that callers should have no business into saying whether
> > > the MM should wake up kswapd or not. The flag name currently suggests
> > > that but that is mostly for historic reasons. A random page allocator
> > > user shouldn't really care about this low level detail, really.
> > 
> > I agree but unless we somehow enforce/warn for such cases, there will be
> > users doing this. A simple grep shows kmsan is doing this. I worry there
> > might be users who are manually setting up gfp flags for their
> > allocations and not providing kswapd flag explicitly. Finding such cases
> > with grep is not easy.
> 
> You are right but this is inherent problem of our gfp interface. It is
> too late to have a defensive interface I am afraid.

I am not really asking to overhaul the whole gfp interface but rather
not introduce one more case which can easily be misused. Anyways, this
conversation is orthogonal to the original email and I am fine with wait
and see approach here for now. 


