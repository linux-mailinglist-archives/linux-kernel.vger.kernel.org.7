Return-Path: <linux-kernel+bounces-760598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F93EB1ED87
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B261C28164
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96AF2882D3;
	Fri,  8 Aug 2025 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNfrTrhZ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E12877CB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754672194; cv=none; b=lX8emE3Rn5Eena44VAC6bUHmi78GcG/0YwD9JnSEQZw8C6tXP0wUJEzh+MX6XHC0snaBBfEa/tPBpG/fLZvGp/Ayr0Qc70yF0a2BK2L+D9EPltjXA8+dd/96h9HpsPM/3A5eOx+r2FENFYXqGjMVdM1TkU1bfA6E4L0KVwm8HMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754672194; c=relaxed/simple;
	bh=9Z24nirufDa8xLk65TSvZCtRIvop0bN16dZv8Lz4GtE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfMIjjnzYEph0D5FAEgqIBP+abkjDeDdJb9dl/SOcezYgj6T1tzdomNcl7p9EW9BDPLs+jcBAx26OvTQGiok4mK90FJUHfPbECwLkrmn1tYilfjxueb6KAULSFCevZUmi3XMDnuYwiphVvTiZpILFwrXrU/fdmGIzxXTaFHSshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNfrTrhZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55502821bd2so2439008e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754672189; x=1755276989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7LBLfDTvzbGx3yFmcXI/cuVRKB9os7wxht5tPJbty3k=;
        b=KNfrTrhZU+on7XKwr7djiyjI24wuShfHpLfVXrsMiqOSpruG9N1iOVMI/uEKPXpEOa
         gLtJwKgMGrazy50Wjut9WNBQ3TmVXH7pGc5syKvis/Qv9TNR3XrovrQLhOMes4uuTUlc
         a59Acy3O+/Ks1WlOfVAL+13flxjeW8JIc3UZUISalvY8/1GnMfycFfR3rlauLCcpE+fr
         pfw7ZnYBfZ6REYzsnYY5ABxNzePFXWtDeWsP6Rw7F594qF5O4mgFZb1oBq79rIUtfuOC
         OS+18wOhKg0wT1qBjzwbDEn7hRV0soqjzGZuLOdPIlaFGUyVQkY9LkkhTrM7FqANwcf8
         A9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754672189; x=1755276989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LBLfDTvzbGx3yFmcXI/cuVRKB9os7wxht5tPJbty3k=;
        b=WfKGY8OHit3E7u1vwdYf/expPjhdMiKYWB/mZItlAhcwwOgWRIFg3BiydWcpO10ueE
         5IprUJy1EnlMMQGDSZfrC4mu67W7gPdcIja+0uRJheMJCxAh14k/61ScfHngR9FWoUM3
         u62C0P34qEPSV5hKb6pRWuG4J3nqFMR3R3VJQFT0GbBaknjYSUkFb47kqKiRZBmWxR4x
         33WcXCTUINK/RorMMjsDg9PLcJaf+fvybnyDZ0h2CWGqCOWjU1iaAI8/fN46i72Gfh+0
         EiJlh6maU7zqNFnh+03ME8h4h1m2rZkwyGVs3mTrgTFIzUSiVCoGKMOuOCBvjoLlcrwP
         aJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCUI1BRVWbaciTTLxv9hSpW7TCCfb96aw4GSz3spQBpiV0qj1ZgspozWSfvez2hg+WPHceApGHaoP504ZD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5t3aDr+EOUjKB6eIEg2XGokGSa+3Qr+l2hIBY97jgKe/bJZwz
	/EM8O9kP6QpjX9Z2zMoMqg+tnA8jLnX0UAq6NdFPPU+K6GYFWoMB6z+Y
X-Gm-Gg: ASbGnctlw8e+g8Cw27tR80ZGPpMQsSmPDLfliynxMOl35L3ozG+8QEzuRylmfUznb5u
	P0dLL4TfLera7tzvGziR6HSHC661BXjvjNs2qNil0o7cBIO5OiqazXg2XjNmvroNI5ppcW/LSNF
	C/3kfoAQMREOZlsdjn3VFNR4wZhKxaVh7orr8YSZZgWC6wC5+PN5BCj0FxHQwiH0qxlXun9wQ7S
	a21tpcqgRzP1uzuOjXt+paBPtGAP4cr79brRP1s4FtYQg1fAFm7GFuaN8yViaHWbWdZJZOQ2c/R
	c2+UQOKc2YYIR6T3FeW47UEABH8wOe9SI0Y1Ij9lEtRMYPF2aysx1Xf2wuvHWEeRe3/ioDTaHb2
	KKfycfIgmE4a/bgpNPFtrxmNilRYzqoPam7J3JUcatuOlFDxIkw==
X-Google-Smtp-Source: AGHT+IFdThAy+vd4lzX1BCpXC1ZlUiH5NrUOgca2mq23ylMZkZXKQZwttX8IRO0lbgeUS7mg2X1dzA==
X-Received: by 2002:a05:6512:3a81:b0:55b:82cd:71ff with SMTP id 2adb3069b0e04-55cc010e021mr1064169e87.37.1754672188569;
        Fri, 08 Aug 2025 09:56:28 -0700 (PDT)
Received: from pc636 (host-90-233-217-11.mobileonline.telia.com. [90.233.217.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabb8asm3154101e87.145.2025.08.08.09.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 09:56:27 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 8 Aug 2025 18:56:25 +0200
To: Michal Hocko <mhocko@suse.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] mm: Drop __GFP_DIRECT_RECLAIM flag if PF_MEMALLOC is
 set
Message-ID: <aJYsOe3nxP6Nuwsz@pc636>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-9-urezki@gmail.com>
 <aJSU3O-pUnTnl_wP@tiehlicka>
 <aJX3zbr8QsIs1LOw@pc636>
 <aJYGpPoaZwYZZ3Ze@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJYGpPoaZwYZZ3Ze@tiehlicka>

On Fri, Aug 08, 2025 at 04:16:04PM +0200, Michal Hocko wrote:
> On Fri 08-08-25 15:12:45, Uladzislau Rezki wrote:
> > On Thu, Aug 07, 2025 at 01:58:20PM +0200, Michal Hocko wrote:
> > > On Thu 07-08-25 09:58:10, Uladzislau Rezki wrote:
> > > > The memory allocator already avoids reclaim when PF_MEMALLOC is set.
> > > > Clear __GFP_DIRECT_RECLAIM explicitly to suppress might_alloc() warnings
> > > > to make more correct behavior.
> > > 
> > > Rather than chaning the gfp mask would it make more sense to update
> > > might_alloc instead?
> > > 
> > Hm.. I was thinking about it but decided to drop the __GFP_DIRECT_RECLAIM
> > instead just to guarantee a no-reclaim behaviour, as it is written now to
> > the flag.
> > 
> > >From the other hand after this patch we would have some unneeded/dead
> > checks(if i do not missing anything). For example:
> > 
> > [1]
> >     WARN_ON_ONCE(!can_direct_reclaim);
> >     /*
> >      * PF_MEMALLOC request from this context is rather bizarre
> >      * because we cannot reclaim anything and only can loop waiting
> >      * for somebody to do a work for us.
> >      */
> >     WARN_ON_ONCE(current->flags & PF_MEMALLOC);
> > [2]
> >     /* no reclaim without waiting on it */
> >     if (!(gfp_mask & __GFP_DIRECT_RECLAIM))
> >         return false;
> > 
> >     /* this guy won't enter reclaim */
> >     if (current->flags & PF_MEMALLOC)
> >         return false;
> > 
> > [3]
> >     /* Caller is not willing to reclaim, we can't balance anything */
> >     if (!can_direct_reclaim)
> >         goto nopage;
> > 
> >     /* Avoid recursion of direct reclaim */
> >     if (current->flags & PF_MEMALLOC)
> >         goto nopage;
> > etc.
> > 
> > But, yes, might_alloc() can be modified also.
> 
> I do not have a _strong_ preference but my slight preference would be to
> deal with this in might_alloc. Not sure what other think.
> 
No problem, that i can easily switch to.

--
Uladzisau Rezki

