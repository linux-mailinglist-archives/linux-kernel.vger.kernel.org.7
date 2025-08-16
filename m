Return-Path: <linux-kernel+bounces-771589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317A0B2891C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A963762032E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27F9BE46;
	Sat, 16 Aug 2025 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F6xjs7bF"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52052AD24
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302948; cv=none; b=fs6NZkv7UvP2Bz+9ztR3qi4Y7MMcxszwFfqWS7D+5wxWjxI3VGZRZp6vYj9egLb+6C07UgwBYqgeIQAGg1LRynl2D174X0d7w7QZ9tEXxmH5W8DbhkzMSUrgdrPIzDM9Eqd+4R3Xij/fv3vBLOFnPXeCElKCSVDFS2zsQWjEN+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302948; c=relaxed/simple;
	bh=+/GLCMIhg9sLCS0QTiU948foQlcKrt84QhsAxGsmJXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8S8X4lRyh9DcrtdpIiDEOyonhWlHwXMtjfiUWBn17Jtrwf/pHGJFiek1O9OwYokNMBw2jliYzvnwqnwTBhF9+siDOnIc5VudYbWB9l/b8J/llsWZDNc9saejbrwSqdD4JEcGsBe/+RDPwZqD91wIPxSyNQslgaKObcAKnhCQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F6xjs7bF; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Aug 2025 17:08:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755302943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0r/mIKpY0PQV2sB8PsmrUnYDf1plRua+xy+T8mUH/bc=;
	b=F6xjs7bFizjs+tCUS35yzfythJ7KOvZGjmhaAR8aU64T+aTDm4KtiDKmZevZsCWpOzL+wO
	/SDd2sUhQ6PtjCLrQb4T/W3A1Vd8fyFZM/UF47RO7MQUIQ2zOzdsAKAtUGosQbD5cWNrjn
	xuG1e7G9YQwvBw8VnSiCBbfsHTyouno=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mark MGLRU as maintained
Message-ID: <22qegz4vktquv22nome6csd4vngvwcaeydoyg3ttqoal5vum27@knjvryszxbdm>
References: <20250815215914.3671925-1-axelrasmussen@google.com>
 <7a46f7jwlwgkbdjvbxjaalrrdamgtxkptmytllhkr2qv4ovbge@nbugfzavwh5w>
 <CAJHvVchYa-vUcQo92awyHE663n-iMsLK31o+1FKrMvdLMAuUOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVchYa-vUcQo92awyHE663n-iMsLK31o+1FKrMvdLMAuUOg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 04:40:26PM -0700, Axel Rasmussen wrote:
> On Fri, Aug 15, 2025 at 4:13 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Fri, Aug 15, 2025 at 02:59:14PM -0700, Axel Rasmussen wrote:
> > > The three folks being added here are actively working on MGLRU within
> > > Google, so we can review patches for this feature and plan to contribute
> > > some improvements / extensions to it on an ongoing basis.
> > >
> > > With three of us we may have some hope filling Yu Zhao's shoes, since he
> > > has moved on to other projects these days.
> > >
> > > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > > ---
> > >  MAINTAINERS | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index daf520a13bdf..8e987f2668cd 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -16058,6 +16058,23 @@ F:   mm/mempolicy.c
> > >  F:   mm/migrate.c
> > >  F:   mm/migrate_device.c
> > >
> > > +MEMORY MANAGEMENT - MGLRU (MULTI-GEN LRU)
> >
> > Why not just add yourselves (and the missing files) to the existing
> > reclaim section? Eventually we want a single reclaim solution, so why
> > not start with single reviewer section?
> 
> Sure, I can see the argument for that.
> 
> I suppose the case against would be, perhaps the folks already listed
> in the RECLAIM section don't want to additionally get e-mail for the
> extra files listed in this patch? (Perhaps mostly the MGLRU
> documentation, the rest of them aren't necessarily MGLRU specific.)
> 
> I don't have a strong preference either way, I think mostly I'd be
> interested to know Andrew's or the other reviewers' preference. Note
> Lorenzo suggested a separate MGLRU section here:
> https://lkml.org/lkml/2025/8/14/271
> 

I would not be too worried about folks getting emails for MGLRU. Anyways
whatever Andrew decides is fine with me.


