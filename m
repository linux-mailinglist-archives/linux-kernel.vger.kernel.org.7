Return-Path: <linux-kernel+bounces-771781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AAAB28B79
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83A21CE6BBF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A522192E4;
	Sat, 16 Aug 2025 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nycIx506"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217210E3
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755329660; cv=none; b=SG00HvL6CzwfO1uM1uaGFv7CE4u7toJo4r//kid2WRQslEZnkWrNFUJuSt+lvhJIl85aIFC2afSxhvYjssMk+Gi7fWbKowEPGhCah9kA8q08hFDuMPMiC5Xya9JC/Up5QrAtVrrzsMzXmGYFdmriAvE09HsgdWcW6mVsxWETifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755329660; c=relaxed/simple;
	bh=RBllP1HyuurzngS1PYFclVqgZxQMsi/60lRopv0XgZs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vgjk9+mGI8sov5bEsqNFn+fwG19hR9lHhsPQbVYj2UTYud1faYwDKDDAcwWTcQJwP2KhMK9kqhIt2LSyHsTg74j5EXma9WHYqWRa3ji82Fsc58EIWCKYNMcveQLMC/KmE3c5Hf70Dp35OxkOq23TKEZ3IU2h2+7i+R2JtUjiAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nycIx506; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B273EC4CEEF;
	Sat, 16 Aug 2025 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755329659;
	bh=RBllP1HyuurzngS1PYFclVqgZxQMsi/60lRopv0XgZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nycIx506DjjSuPyBwZha4dR4dyULJn+oZM7AxMBlxDvtnotMOCCCtdejoR/8MEOND
	 +iwwu3/QA833OQNZvhpg01GPq5VHljkRvw8UeRkJA0hpM3D6wGzqGGMo4oe1WC6HfL
	 Cc82ObFNcUhvbo9BctYnSIjtatfuWm8qXsnYVHbQ=
Date: Sat, 16 Aug 2025 00:34:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] mm/cma: print total and used pages in cma_alloc()
Message-Id: <20250816003418.b2a62f6ddbcf9468fde87a18@linux-foundation.org>
In-Reply-To: <701bfbb4-6c12-4614-a322-def3ca923c78@redhat.com>
References: <20250816042842.3959315-1-gxxa03070307@gmail.com>
	<ee29262a-911b-4a97-b619-0dea3b657252@redhat.com>
	<20250815234528.882ab58247cefc96e4137811@linux-foundation.org>
	<701bfbb4-6c12-4614-a322-def3ca923c78@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 08:56:47 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 16.08.25 08:45, Andrew Morton wrote:
> > On Sat, 16 Aug 2025 08:27:39 +0200 David Hildenbrand <david@redhat.com> wrote:
> > 
> >>> @@ -858,8 +869,8 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
> >>>    	if (!cma || !cma->count)
> >>>    		return page;
> >>>    
> >>> -	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
> >>> -		(void *)cma, cma->name, count, align);
> >>> +	pr_debug("%s(cma %p, name: %s, total pages: %lu, used pages: %lu, request pages: %lu, align %d)\n",
> >>> +		__func__, (void *)cma, cma->name, cma->count, cma_get_used_pages(cma), count, align);
> >>
> >> 		^ one space missing for proper indentation.
> >>
> >> But doing another spinlock cycle just for debugging purposes? That does
> >> not feel right, sorry.
> > 
> > If we're calling pr_debug() frequently enough for this to matter, we
> > have other problems!
> 
> We call it for each and every actual CMA allocation? I really don't see 
> why we want to just randomly make CMA allocation latency worse.

pr_debug() is 12 million times more expensive than a spin_lock()!

> Is the existing pr_debug() a problem? Maybe. But who actually has debug 
> messages enabled in any sane setup?

Nobody, clearly.  If anyone enabled pr_debug() in here, they'd
immediately have to remove those statements to get any work done.  Kill
it.


