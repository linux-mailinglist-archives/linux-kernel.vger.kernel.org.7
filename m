Return-Path: <linux-kernel+bounces-724610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CFBAFF4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50731C864D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA8C2459E0;
	Wed,  9 Jul 2025 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TVkOOLw6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F362801
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100673; cv=none; b=jySVZ7oLlupCxpaQ+AMFSscPNgNlCdBG1cabnVtAn7N2J4oO+4/p0qwn2070PXSw/MjRvPYYib00n/ajXGx9beIKunX1n9qLqMYZfVtJusJ0eIo7VoVihtqww6CSEbK64KjKnDQP/mOikCQRFKeOafrUdCY2b9rlOPfxFJ4IyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100673; c=relaxed/simple;
	bh=3Yo7S9AlDHTOVi1lH1wCOpYInVI0gXSaPoeLmvy4qU8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gxyaxnxpA1h+Is3zpk4gi4FW0LgjfoRDa8o9TiwFqFe218mTLszYzyWjllRBUi3hH6aPlsKYeLzDN8e87T7U/qcU7h3LriY+jhJ2nlVb0PpA8mpO08IZLcNBw/b5q5VgMXqrPYoALGOdffs+DlgtnvA1cJ0axX9BfYTgj659oYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TVkOOLw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A32C4CEEF;
	Wed,  9 Jul 2025 22:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752100672;
	bh=3Yo7S9AlDHTOVi1lH1wCOpYInVI0gXSaPoeLmvy4qU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TVkOOLw65NVOFSXfa22OygcpxRMZFGshWoJQFUda4xXmvD4IHovmZ2vAMt9BZZHQH
	 CoxNO+CCKuV8fhS6k1qHycJPRTHSi8snKSxSM0t0UrZGYfT6wqzBZrM7woW1HQ2n2e
	 Z9g7jTalKtw4E9c/50kfvhZfO9vMuYDBhibknCpI=
Date: Wed, 9 Jul 2025 15:37:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: implement "memory.oops_if_bad_pte=1" boot option
Message-Id: <20250709153751.222ea2d1de1313a22a69e64e@linux-foundation.org>
In-Reply-To: <4e1b7d2d-ed54-4e0a-a0a4-906b14d9cd41@p183>
References: <4e1b7d2d-ed54-4e0a-a0a4-906b14d9cd41@p183>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 21:10:59 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Implement
> 
> 	memory.oops_if_bad_pte=1
> 
> boot option which oopses the machine instead of dreadful
> 
> 	BUG: Bad page map in process
> 
> message.
> 
> This is intended
> for people who want to panic at the slightest provocation and
> for people who ruled out hardware problems which in turn means that
> delaying vmcore collection is counter-productive.
> 
> Linux doesn't (never?) panicked on PTE corruption and even implemented
> ratelimited version of the message meaning it can go for minutes and
> even hours without anyone noticing which is exactly the opposite of what
> should be done to facilitate debugging.
> 
> Not enabled by default.
> 
> Not advertised.
> 
> @@ -490,6 +498,13 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss)
>  static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>  			  pte_t pte, struct page *page)
>  {
> +	/*
> +	 * This line is a formality to collect vmcore ASAP. Real bug
> +	 * (hardware or software) happened earlier, current registers and
> +	 * backtrace aren't interesting.
> +	 */
> +	BUG_ON(oops_if_bad_pte);
> +

Oh.  A pretty simple thing to do with bpf?  A script to tell the kernel
"dump vmcore if you get here" would have applications in places other
than print_bad_pte()?

That's what bpf_panic() was for (https://lwn.net/Articles/901284/) but
it apparently didn't get merged for <reasons>.


