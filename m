Return-Path: <linux-kernel+bounces-586235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B893A79CCD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 09:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B52B3B47D1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 07:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180642405EB;
	Thu,  3 Apr 2025 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="agKpocDz"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919823F422
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743664852; cv=none; b=g4H+lM0HUa2Avi0SgVSrV9XxcxRtDG4AJbz0EDtDSfJ3bupQC9uvzBUZ4bTytK5lQdrYi7ltQVUGJPZGD2OAOAxw3IMi37JdxhJ30ll3P6CNKcIvn997H9VvCau4eNCqti44EwI4dH9I+EJFQmyO7AtrORpbPi4eJW+9zijr1ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743664852; c=relaxed/simple;
	bh=TDd8xyaBgEDCBfuCTjYEiIFUCJncStQ1dkceRj+++oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEQ9ShRcwg5iv6SxZige/60vXKdomwxDou0TLp2XBOwgyvgfU9q+Q9/+S/ms32aDy4JCnVtorI7GdYpU7y5YoQ49laEkF3dkgdJ3YvfTGTvYb+8JqQj1ITemCeh0DViJKAmiPSERONtScy3/NwXCqQ+PLgt0bYt/3AdsY/wBXHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=agKpocDz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-391342fc1f6so458751f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Apr 2025 00:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743664848; x=1744269648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BD756zHr8WEGmTWHUM//ivzbI/qlnCFevZCrnf/WSH0=;
        b=agKpocDz+G3CdxzdhcmDvJ0LrcO/BzPV0zL3/zhw020oUIipit4+cBnA7Ppo0EVeEe
         u8zfnJAfBg3tTgfqDCXwwYHDq9ezvk3xVgxeOLARfqLpg423sti3Yg1P66ZjSp/t1+4n
         o/a7V/n/7h5jQvY66pRDFooBn43gBn3CwUI9RTnTWV1m4MOGYusHvdDu5n7sz0yQcZW4
         mxj2YaWf2QKppsZU48utv1tZesINe4nb9bRuQMUA+256YgK2n1kF9xz33eJLB4msjDPZ
         F24Xu4bTqYUaMJQaSgu8fjO6w3VigHSRTusah1S7UJbIimOrCcOrXImpdCr7FTBE69NS
         ZZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743664848; x=1744269648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD756zHr8WEGmTWHUM//ivzbI/qlnCFevZCrnf/WSH0=;
        b=JsUQCz2WGs7KrL2oQP4KyHauCRdDWMWdmjcchQkb2ruy4yQEc45cFFtIbBFeJfhafe
         l8l2oU299g7cmP5Q59biv1TCaoSyflUawAH8BeJdDb/64A6d2Tpu4IPIqGDYecNbXLwX
         vJtBODO2Vi+sfT7hQTzckVYtJBLZ6iHWUSw2W1AsboU9mWTEupxZMzfG5q8gXK7OiUqe
         2EGliR88iO19PAcjwIaAD1Etc9oVtwPetbRePOwmU9Mw0F5eeWf+D+chuylo9/f5luLT
         yQta4kH+HFvrYaN1+s38oDffc8e6ZfQOYwnJJvL5ujPiZZCOBPOSBXOhuBOCKvby+BKV
         mLLg==
X-Forwarded-Encrypted: i=1; AJvYcCXvYl78uXJqosQhJUeXDJ9hkKaDOxpDcgpk/DUOkYaJudl7h9dwWoFKWFttRPGhcbfaakiNOcESpoI/h+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzma+FvxRyKrrvtIC2yWjIE8whycjXnEfSRRveta93eyh2tXRSU
	KfS1aNAWG44depTt73YIyVpkJy3pYOmmCstac5iR1UM0s7Dd0S5oBaAvxReIYdk=
X-Gm-Gg: ASbGncvHmp8NQ9QLztfNJJQzI9KGo5MG0sdlKOC+mbj13CL+O/MT3eWKwfXWTHHWlxU
	jPB2mHC38qBBWH5HPSbzMltogMscB3WbkgUauJiKdAF5PFUeQgaetqzf7QVFlmxzP2uOYD9kTyM
	Ne2oYjAYUKS7Fbg4/wFfpNR2RQcYlaOv10tUGSUrwhiUDx27Fbp7TLSW4Rk7v/d12X5JJt1M/Br
	JzW/ADKS+1UlOG0sL7bmXLpNdcnLZRCS73o0i1tDHgaa0MSGrlVZrJd/L3vtwxiFA7HRuzUUgJP
	stCocGBJc+q0y6YvGjvz+mFQ0JiEJaDn6iSwgx2KBMrFkd1sdwxAD1U=
X-Google-Smtp-Source: AGHT+IESfTm4RoUHFqxbeSvl1MMbpOP8xDKxRWMnDQTPhoCmLYL/Nciczkpwk4voGMuKlOVx9Z7g9A==
X-Received: by 2002:a05:6000:4021:b0:391:38a5:efa with SMTP id ffacd0b85a97d-39c120e07e4mr15863646f8f.23.1743664848526;
        Thu, 03 Apr 2025 00:20:48 -0700 (PDT)
Received: from localhost (109-81-82-69.rct.o2.cz. [109.81.82.69])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43ec1663053sm13180535e9.15.2025.04.03.00.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 00:20:48 -0700 (PDT)
Date: Thu, 3 Apr 2025 09:20:46 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, Yafang Shao <laoar.shao@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>,
	joel.granados@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
Message-ID: <Z-42znN1q7dVNM-h@tiehlicka>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <Z-2pSF7Zu0CrLBy_@dread.disaster.area>
 <b7qr6djsicpkecrkjk6473btzztfrvxifiy34u2vdb4cp5ktjf@lvg3rtwrbmsx>
 <Z-3i1wATGh6vI8x8@dread.disaster.area>
 <7gmvaxj5hpd7aal4xgcis7j7jicwxtlaqjatshrwrorit3jwn6@67j2mc6itkm6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7gmvaxj5hpd7aal4xgcis7j7jicwxtlaqjatshrwrorit3jwn6@67j2mc6itkm6>

On Wed 02-04-25 22:05:57, Shakeel Butt wrote:
> On Thu, Apr 03, 2025 at 12:22:31PM +1100, Dave Chinner wrote:
> > On Wed, Apr 02, 2025 at 04:10:06PM -0700, Shakeel Butt wrote:
> > > On Thu, Apr 03, 2025 at 08:16:56AM +1100, Dave Chinner wrote:
> > > > On Wed, Apr 02, 2025 at 02:24:45PM +0200, Michal Hocko wrote:
> > > > > On Wed 02-04-25 22:32:14, Dave Chinner wrote:
> > > > > > Have a look at xlog_kvmalloc() in XFS. It implements a basic
> > > > > > fast-fail, no retry high order kmalloc before it falls back to
> > > > > > vmalloc by turning off direct reclaim for the kmalloc() call.
> > > > > > Hence if the there isn't a high-order page on the free lists ready
> > > > > > to allocate, it falls back to vmalloc() immediately.
> > > > > > 
> > > > > > For XFS, using xlog_kvmalloc() reduced the high-order per-allocation
> > > > > > overhead by around 80% when compared to a standard kvmalloc()
> > > > > > call. Numbers and profiles were documented in the commit message
> > > > > > (reproduced in whole below)...
> > > > > 
> > > > > Btw. it would be really great to have such concerns to be posted to the
> > > > > linux-mm ML so that we are aware of that.
> > > > 
> > > > I have brought it up in the past, along with all the other kvmalloc
> > > > API problems that are mentioned in that commit message.
> > > > Unfortunately, discussion focus always ended up on calling context
> > > > and API flags (e.g. whether stuff like GFP_NOFS should be supported
> > > > or not) no the fast-fail-then-no-fail behaviour we need.
> > > > 
> > > > Yes, these discussions have resulted in API changes that support
> > > > some new subset of gfp flags, but the performance issues have never
> > > > been addressed...

I, at least, was not aware of the performance aspect. We are trying to
make kvmalloc as usable as possible to prevent its open coded variants
to grow in subystems.

> > > > > kvmalloc currently doesn't support GFP_NOWAIT semantic but it does allow
> > > > > to express - I prefer SLAB allocator over vmalloc.
> > > > 
> > > > The conditional use of __GFP_NORETRY for the kmalloc call is broken
> > > > if we try to use __GFP_NOFAIL with kvmalloc() - this causes the gfp
> > > > mask to hold __GFP_NOFAIL | __GFP_NORETRY....

Correct.

> > > > We have a hard requirement for xlog_kvmalloc() to provide
> > > > __GFP_NOFAIL semantics.
> > > > 
> > > > IOWs, we need kvmalloc() to support kmalloc(GFP_NOWAIT) for
> > > > performance with fallback to vmalloc(__GFP_NOFAIL) for
> > > > correctness...

Understood.

> > > Are you asking the above kvmalloc() semantics just for xfs or for all
> > > the users of kvmalloc() api? 
> > 
> > I'm suggesting that fast-fail should be the default behaviour for
> > everyone.
> > 
> > If you look at __vmalloc() internals, you'll see that it turns off
> > __GFP_NOFAIL for high order allocations because "reclaim is too
> > costly and it's far cheaper to fall back to order-0 pages".
> > 
> > That's pretty much exactly what we are doing with xlog_kvmalloc(),
> > and what I'm suggesting that kvmalloc should be doing by default.
> > 
> > i.e. If it's necessary for mm internal implementations to avoid
> > high-order reclaim when there is a faster order-0 allocation
> > fallback path available for performance reasons, then we should be
> > using that same behaviour anywhere optimisitic high-order allocation
> > is used as an optimisation for those same performance reasons.
> > 
> 
> I am convinced and I think Michal is onboard as well for the above. At
> least we should try and see how it goes.

If we find out that this doesn't really work because a fragmentation
of page blocks is a real problem then we might need to reconsider this.

> > The overall __GFP_NOFAIL requirement is something XFS needs, but it
> > is most definitely not something that should be enabled by default.
> > However, it needs to work with kvmalloc(), and it is not possible to
> > do so right now.
> 
> After the kmalloc(GFP_NOWAIT) being default in kvmalloc(), what remains
> to support kvmalloc(__GFP_NOFAIL)? (Yafang mentioned vmap_huge)

We already do support kvmalloc(__GFP_NOFAIL) since 9376130c390a7 IIRC.

-- 
Michal Hocko
SUSE Labs

