Return-Path: <linux-kernel+bounces-771753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098E7B28B2B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA737A99CF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1797F7DA93;
	Sat, 16 Aug 2025 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WLo0hP0a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB53176E8
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755326729; cv=none; b=YKp2TyDR/Q5V2wnNzvYiVmb6MX6SJdNULUT84ycEJI8f2/Vzb1XkHzN5EDa33+cploHHfEqbGV7XW632wGGWMyZBErQjS/uAWErnROPsQlf8n3st6KsZ+8VQF3/6Bs/LkDISfnmWGAUpsa5kdBFoxp49HGoCr97ni/7YGijyhZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755326729; c=relaxed/simple;
	bh=5R00YWd+L8BLM4jpI4cC+VInXivZSEPyPux+YvERhtw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=twl/VtaD0HKVRoXfc0kIPqCgyyxRNHkIOef+mWi6IDJhZtPXYR1Ag9oXHIGQeo1QbU3HGW6cb6URkJ5FzfiFH/Sglvy9PIH3WfYGBeVEdjsvGijy5SY6E3OVLM390guInFQi011PekkgJ+NLnIyysKccfGar4Sf7/7Hi7UpWhiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WLo0hP0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998FBC4CEEF;
	Sat, 16 Aug 2025 06:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755326729;
	bh=5R00YWd+L8BLM4jpI4cC+VInXivZSEPyPux+YvERhtw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WLo0hP0aHSROMn5PAPeCO3qG33A6GRLcVcxkTFNDBNduNndF42YAycygNLJ1CFA2t
	 h75DNkowXZm52qoumajuAUOqn2oTuO0VhN0S3AfojLGCsTdxk6O+l5N2xujt3Gdcoe
	 jv5DPo58066ib/zGYpsN1OdkOVlSHfz6fuCwgNIM=
Date: Fri, 15 Aug 2025 23:45:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] mm/cma: print total and used pages in cma_alloc()
Message-Id: <20250815234528.882ab58247cefc96e4137811@linux-foundation.org>
In-Reply-To: <ee29262a-911b-4a97-b619-0dea3b657252@redhat.com>
References: <20250816042842.3959315-1-gxxa03070307@gmail.com>
	<ee29262a-911b-4a97-b619-0dea3b657252@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 08:27:39 +0200 David Hildenbrand <david@redhat.com> wrote:

> > @@ -858,8 +869,8 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
> >   	if (!cma || !cma->count)
> >   		return page;
> >   
> > -	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
> > -		(void *)cma, cma->name, count, align);
> > +	pr_debug("%s(cma %p, name: %s, total pages: %lu, used pages: %lu, request pages: %lu, align %d)\n",
> > +		__func__, (void *)cma, cma->name, cma->count, cma_get_used_pages(cma), count, align);
> 
> 		^ one space missing for proper indentation.
> 
> But doing another spinlock cycle just for debugging purposes? That does 
> not feel right, sorry.

If we're calling pr_debug() frequently enough for this to matter, we
have other problems!

