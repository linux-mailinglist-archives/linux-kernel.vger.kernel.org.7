Return-Path: <linux-kernel+bounces-852819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135B1BD9FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B978D543A63
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC769280331;
	Tue, 14 Oct 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k3QLVk9X"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCBD248F5A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452049; cv=none; b=M2MqVHv2WZbrOZzHXGF+RJ0BO7WzFLBUKfZZUtHxVK+s96mdIgm8ILtUJMTMhnEd1mSxCv1ovzlM4io520BD444y812PCaYggCY78JW2B+F8U2jMGti33svIKp+sKG7wF+2RXo1LYN3enTGJ0DkwPpZf1Gmxd7mIHa6iF5Fmn4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452049; c=relaxed/simple;
	bh=2mtpYjwNY1Cxf7Imzrlx6hIdQ1tGeCPxf+hk9SsJ97M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK+QLlCBg/HmLFaEeUGMJ4l0mGbqTh44603FZ0pGlzRJ7Jto5sf3gj0H9zYgRdPpTXmDBYlx+Fnnt+gG5x1BMt833L6vNLLCJGCi+c33anZkndN0Zgs2lHjvrLZIUOUaibsW9akPK7O5yuwK3NZif96HlzyQgRpnB75ShZtgM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k3QLVk9X; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Oct 2025 07:27:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760452035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xmzBJXabx4eUefij6QpqRo9hlKdZJcNNossFkRf2xhs=;
	b=k3QLVk9X68xj0fW6ouutSzsm3KP1k+huwBQS4la+ENxodaZmV1oopg1OpXPyzLIXwI72fH
	TrU/4mvpvnFPc9jGyZ8pDZjO7OKQLmcXgz95maiE/Cd/Vv6kBa7GFlp+ufqNaTfL0Gpng7
	aFqkMZaxH/Fh3qXtoaq4BaCYW68nmRc=
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
Message-ID: <qztimgoebp5ecdmvvgro6sdsng6r7t3pnddg7ddlxagaom73ge@a5wta5ym7enu>
References: <20251013101636.69220-1-21cnbao@gmail.com>
 <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
 <aO37Od0VxOGmWCjm@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO37Od0VxOGmWCjm@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 14, 2025 at 09:26:49AM +0200, Michal Hocko wrote:
> On Mon 13-10-25 20:30:13, Vlastimil Babka wrote:
> > On 10/13/25 12:16, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> [...]
> > I wonder if we should either:
> > 
> > 1) sacrifice a new __GFP flag specifically for "!allow_spin" case to
> > determine it precisely.
> 
> As said in other reply I do not think this is a good fit for this
> specific case as it is all or nothing approach. Soon enough we discover
> that "no effort to reclaim/compact" hurts other usecases. So I do not
> think we need a dedicated flag for this specific case. We need a way to
> tell kswapd/kcompactd how much to try instead.

To me this new floag is to decouple two orthogonal requests i.e. no lock
semantic and don't wakeup kswapd. At the moment the lack of kswapd gfp
flag convey the semantics of no lock. This can lead to unintended usage
of no lock semantics by users which for whatever reason don't want to
wakeup kswapd.

