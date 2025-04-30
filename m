Return-Path: <linux-kernel+bounces-627116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014ADAA4B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 14:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A474E3FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15C425B1EF;
	Wed, 30 Apr 2025 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ERwIhe2K"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59625A621
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017109; cv=none; b=XVUqMYk5c5/SI5Yw7jXTDndJHXxRCKWFHgWvFZD1Em82D0+QEPDeEr02guIlhxTtgbIV7eJdCtXTBzvZcdj0PN21eHzpMjwv3cgmp4bFuvsFNu5TctMjbXcy3snMr6hjAiFB83t4akhinP+Z+YZLhD6gDxGB/zoL0eZa5z8vKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017109; c=relaxed/simple;
	bh=raxdQ2PUzo4294bXe2kpUGFCV0Y0wngoPwLYkkeWKRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0Aq+HAJiC4xkXkCeIXcE3GHItNcKTZFAShAtyv1ceYAdO7Tn6SspZQ3mVzy7SGx26yhlWHd3uRXULa+dKTneIcWKul3UIIx33IADvVBvMfWwlQNLRi3D8nT5lo8zsDj0ris0fA6RSSHdzBl+B53tsu//gK2zkf/BNK5s1vUrjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ERwIhe2K; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 30 Apr 2025 05:44:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746017103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OL6pMpPrHxyalMOEj7Fjs8lPAUCwXWRv7qPE6i/mzfw=;
	b=ERwIhe2KSaPvDzZid2uMe37+8TaX+7mKx4+9WR7jMGe8+VJZdwPZmH2/xOXwnWqVITMkiR
	Ui97Kbpco+3k4kBbX4xeHq+Iuy6Q4h8AANT93TUkd1Hps8TLlTlxh2fTZmSCTYODBRpvcE
	hX7V3ZbTLrXw956QCoYrR+LCdSU0HVQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 1/3] llist: add list_add_iff_not_on_list()g
Message-ID: <aBIbRhLjmO-fKKGr@Asmaa.>
References: <20250429061211.1295443-1-shakeel.butt@linux.dev>
 <20250429061211.1295443-2-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429061211.1295443-2-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 28, 2025 at 11:12:07PM -0700, Shakeel Butt wrote:
> As the name implies, list_add_iff_not_on_list() adds the given node to
> the given only if the node is not on any list. Many CPUs can call this
> concurrently on the same node and only one of them will succeed.
> 
> This is also useful to be used by different contexts like task, irq and
> nmi. In the case of failure either the node as already present on some
> list or the caller can lost the race to add the given node to a list.
> That node will eventually be added to a list by the winner.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  include/linux/llist.h |  3 +++
>  lib/llist.c           | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/include/linux/llist.h b/include/linux/llist.h
> index 2c982ff7475a..030cfec8778b 100644
> --- a/include/linux/llist.h
> +++ b/include/linux/llist.h
> @@ -236,6 +236,9 @@ static inline bool __llist_add_batch(struct llist_node *new_first,
>  	return new_last->next == NULL;
>  }
>  
> +extern bool llist_add_iff_not_on_list(struct llist_node *new,
> +				      struct llist_head *head);
> +
>  /**
>   * llist_add - add a new entry
>   * @new:	new entry to be added
> diff --git a/lib/llist.c b/lib/llist.c
> index f21d0cfbbaaa..9d743164720f 100644
> --- a/lib/llist.c
> +++ b/lib/llist.c
> @@ -36,6 +36,36 @@ bool llist_add_batch(struct llist_node *new_first, struct llist_node *new_last,
>  }
>  EXPORT_SYMBOL_GPL(llist_add_batch);
>  
> +/**
> + * llist_add_iff_not_on_list - add an entry if it is not on list
> + * @new:	entry to be added
> + * @head:	the head for your lock-less list
> + *
> + * Adds the given entry to the given list only if the entry is not on any list.
> + * This is useful for cases where multiple CPUs tries to add the same node to
> + * the list or multiple contexts (process, irq or nmi) may add the same node to
> + * the list.
> + *
> + * Return true only if the caller has successfully added the given node to the
> + * list. Returns false if entry is already on some list or if another inserter
> + * wins the race to eventually add the given node to the list.
> + */
> +bool llist_add_iff_not_on_list(struct llist_node *new, struct llist_head *head)

What about llist_try_add()?

> +{
> +	struct llist_node *first = READ_ONCE(head->first);
> +
> +	if (llist_on_list(new))
> +		return false;
> +
> +	if (cmpxchg(&new->next, new, first) != new)
> +		return false;

Here we will set new->next to the current head of the list, but this may
change from under us, and the next loop will then set it correctly
anyway. This is a bit confusing though.

Would it be better if we set new->next to NULL here, and then completely
rely on the loop below to set it properly?

> +
> +	while (!try_cmpxchg(&head->first, &first, new))
> +		new->next = first;

Not a big deal, but should we use llist_add_batch() here instead?

> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(llist_add_iff_not_on_list);
> +
>  /**
>   * llist_del_first - delete the first entry of lock-less list
>   * @head:	the head for your lock-less list
> -- 
> 2.47.1
> 

