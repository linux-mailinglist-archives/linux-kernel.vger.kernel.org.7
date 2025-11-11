Return-Path: <linux-kernel+bounces-896320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF6DC50177
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F12BD34D01E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3257246788;
	Tue, 11 Nov 2025 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M2vt0uH+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF035CBC6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904920; cv=none; b=UPxnHmGz5m75b0hrthyd6yOVbBnnGBE9Ah4C3DFNFKLCriJjtBQ67vW5400mk/xHuHCGNILSeyqbtQXR0An3jz+hNAKitU9GT5jm/qjC3f5H02D0mqk6u9cTMKoxUNcEmXlY04dHajOIwqxHRcOFhyaYFI1196mE/xUMUrlRPno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904920; c=relaxed/simple;
	bh=FXS2195HdvuacL8cAJSqhNLqJ6/8m8aNe7EdqbioGIs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A8Wy3VTQXGXQ732I7Chg8ofU0vN5qs+ekzVrX7wcJzJSDwaC8UIxdCO9ZkdxEp3JjW5lrcV9Bl5peJWGWwRAxwtOA4mDhZozAxN/Pz9OXe75gCoTphu8SRW8Wz9MH01lNY5Mk2uCD1P41ZsFpklzmkeFManbeHe4H0SJSdDJ14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M2vt0uH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34607C19423;
	Tue, 11 Nov 2025 23:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762904919;
	bh=FXS2195HdvuacL8cAJSqhNLqJ6/8m8aNe7EdqbioGIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M2vt0uH+VTB3VZGUYDyR3hgkhk1P4pSTj7Pji7bDh4pVQh51O2hSCkzKfpgiM3la8
	 Y+fj6dDgnmVYfkvX3p9ktrrnnuRDI06k2r4ahXk33xQtkdyc4sdk2pyncrFjHoW+hl
	 +VXuFQzx63uh/ep81BfqmkFyWIM0Ev+mnjUN3RqQ=
Date: Tue, 11 Nov 2025 15:48:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Manish Kumar <manish1588@gmail.com>, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_isolation: clarify FIXME around shrink_slab()
 in memory hotplug
Message-Id: <20251111154838.0951555906fa923ec642cfd4@linux-foundation.org>
In-Reply-To: <7e43294a-03d5-42e5-bec2-5fbcfab97b69@redhat.com>
References: <20251015175041.40408-1-manish1588@gmail.com>
	<7e43294a-03d5-42e5-bec2-5fbcfab97b69@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 21:26:42 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 15.10.25 19:50, Manish Kumar wrote:
> > The existing FIXME comment notes that memory hotplug doesn't invoke
> > shrink_slab() directly. This patch adds context explaining that this is
> > an intentional design choice to avoid recursion or deadlocks in the
> > memory reclaim path, as slab shrinking is handled by vmscan.
> > 
> > Signed-off-by: Manish Kumar <manish1588@gmail.com>
> > ---
> >   mm/page_isolation.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> > index b2fc5266e3d2..2ca20c3f0a97 100644
> > --- a/mm/page_isolation.c
> > +++ b/mm/page_isolation.c
> > @@ -176,10 +176,16 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
> >   
> >   	/*
> >   	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
> > -	 * We just check MOVABLE pages.
> > +	 *
> > +	 * This is an intentional limitation: invoking shrink_slab() from a
> > +	 * hotplug path can cause reclaim recursion or deadlock if the normal
> > +	 * memory reclaim (vmscan) path is already active. Slab shrinking is
> > +	 * handled by the vmscan reclaim code under normal operation, so hotplug
> > +	 * avoids direct calls into shrink_slab() to prevent reentrancy issues.
> 
> This is the first time I hear about this reentrance issue.
> 
> How did you come up with this explanation?
> 

-ETIMEDOUT, I'll drop this patch.

