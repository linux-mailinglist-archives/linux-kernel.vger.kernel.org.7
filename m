Return-Path: <linux-kernel+bounces-887520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2039C386DB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C0B3B4B8D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE089274B58;
	Thu,  6 Nov 2025 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuuaFbep"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7B928E5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762387224; cv=none; b=K11YjGyCHHvSgnjpQoDrce+ZXdP57YH94WfOBtLkFcxO/5sEAxamsBYdg3OASLT9IFHhufnDbKHXRbeGXrQXcVTYKrp7kz+uZDaqQxjmy3pVAn9N1N6nbm1lExuLiiNHLukamp/MgpHVzcvRup9o2Tzp2wythQ++dHBq5H7HcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762387224; c=relaxed/simple;
	bh=8MLnt+XglQZk2yYFdRLxYI7oowvX/sdme0l9dh+SAX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBeWhHuJ9JTrnyifL204P7rZqmNcKgk/wM8/E93W26uYbA5FcSGdkUJSsq28PkaCxuljva5Bg0C8nzaiqu50p8iuCw3vB7VkGQTe6LgFsWzPnj6F0ifWeCCCkMbl6wgJOYSAQ0LtQ+nxWsY+4ETl2O82Bo5xD6xpHpSpAZqvlDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuuaFbep; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3414de5b27eso362719a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762387222; x=1762992022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xdi2SbNzBRTUXMlj2tQpqfAaio37iPV8pPO566c4vYQ=;
        b=GuuaFbep4eHy3SMVfE07AKI/w+Hg2klwIm+3Xr4D8ocpwuT6W/lEjy7qShXn7a1sP9
         zhhO5sA2xn4VZcnoHyJjxJHm58sYTmShOXA8J/Rb9EkEUjiGGwG4X7SEaW++zAMyCeyX
         MmrJ0tx/FZEDXPuc/dtrUKpDRfagfalUAUdhzbFJIshNicVLsWt3idtFaLXmday6g5t5
         kprxnEP6kb5ecMZL64nNgG7q9jGFX3qitcwWPhkISLOT4cTf48huHUoLbGET9PoqyRkn
         8+Klow6dVp1doNjX6+09hYIACWK64hZRk3ItDBBwHd65Puw5eK0BGN7nSuBlV5IxSv9o
         l2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762387222; x=1762992022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xdi2SbNzBRTUXMlj2tQpqfAaio37iPV8pPO566c4vYQ=;
        b=dn4pnXp3JTk61CHTaWa5isnBLaj9VkpiF67Z3d4R6Mkf04Ly4syGjaQ97RIDldOUwL
         yn54E/NAkESw3QP7bvcSSFbOtaO/xb2q4O54cESHkqKf9PVItRKr3/dFBcZiXPLLyJRE
         haBcLYgex01+lBn9IYeewkcLuPTRZizY6NsfLjF9qzGN4VlvX1UBEBj0P6/JtzZeUtbw
         +5btu1SILxy8rrILf/GvvYEisPKXo1l7KRwd3G+xaFJtdNKzZUHAap+NA7m/oPNZClmK
         xrvI1etP0ULVINwAnyJlh9CsRuy+cKnIdEpnde4AP5X7yToIVLCG6ucORY/g5JwsDJdz
         pVpA==
X-Gm-Message-State: AOJu0YwpfSJxTvZQU+28Is0FJxeN6XfUYJxbxTzooR9LaGoDZCsUfv+C
	xuk2Z773v+kAqHLka92gko+rSCA5tqH3sl7CDmQPDcbyfI3Y4yb9w1Fn
X-Gm-Gg: ASbGncsHaE4Oj6mcBrxFfm3u80h6grKb7e+Ups0rtCYT9Bx8ZvdgRU3cCot28vIaS93
	kD5D9LMvSrMBEMoV326aOhlCiPsBs9o1cODGGBpg65jUw2lkxmZkF7zGDx276XFnMCdgLWhXR86
	F3UiRm8d6k0rktaXhEg+2ujtqUv0qkWOVKyoTYeIJbgzFtzOy3OQo0iAmizY7NQdh5EEcjQM1cS
	KNUFs8yIAB7kVxeQneD3Mx26Kro7ICTRsKOuq+y/BUbrPaK3dSvGGvhq0G3bR18ZFegyMLE8iG0
	GDOyMRD8OW1qAS2X5IjMSeaByn4jWhYoCxxx5MryWqk4yQjiJLdUaB+1QKT+2G82+hCSndFG9ij
	c2odXbWUj5gwkFHaMl6CBPGXbAU4SGFqQtn4qiROhBYfMHxkTIwQvpvIE+Ek1PSpyk3BmnRJ/Fy
	4r6rK2QOvkMgzW7KC33KayPalo/kuQPNjvI7k7c1poAG8=
X-Google-Smtp-Source: AGHT+IHGfj9th0acpdDFjz42m74ilf/decQCNexo/5AMGZVdg/gkNfCJVX6eIBxzLZID9Xwzn+qfZg==
X-Received: by 2002:a17:90b:5824:b0:340:b152:65c0 with SMTP id 98e67ed59e1d1-341a6debc8fmr6184346a91.26.1762387221835;
        Wed, 05 Nov 2025 16:00:21 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a69b33c7sm4100865a91.18.2025.11.05.16.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:00:21 -0800 (PST)
Date: Wed, 5 Nov 2025 16:00:19 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Message-ID: <aQvlE8Hcy0uYAAmh@fedora>
References: <20251103190429.104747-1-vishal.moola@gmail.com>
 <20251103190429.104747-2-vishal.moola@gmail.com>
 <aQopoAj3i2jdIX6V@pc636>
 <CA+KHdyWxjqAxVEBjOun9VxoeErWEyba3OvcJveLqnRuBLk2RLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyWxjqAxVEBjOun9VxoeErWEyba3OvcJveLqnRuBLk2RLA@mail.gmail.com>

On Wed, Nov 05, 2025 at 02:16:24PM +0100, Uladzislau Rezki wrote:
> > On Mon, Nov 03, 2025 at 11:04:26AM -0800, Vishal Moola (Oracle) wrote:
> > > Vmalloc explicitly supports a list of flags, but we never enforce them.
> > > vmalloc has been trying to handle unsupported flags by clearing and
> > > setting flags wherever necessary. This is messy and makes the code
> > > harder to understand, when we could simply check for a supported input
> > > immediately instead.
> > >
> > > Define a helper mask and function telling callers they have passed in
> > > invalid flags, and clear those unsupported vmalloc flags.
> > >
> > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > ---
> > >  mm/vmalloc.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 0832f944544c..290016c7fb58 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3911,6 +3911,26 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > >       return NULL;
> > >  }
> > >
> > > +/*
> > > + * See __vmalloc_node_range() for a clear list of supported vmalloc flags.
> > > + * This gfp lists all flags currently passed through vmalloc. Currently,
> > > + * __GFP_ZERO is used by BFP and __GFP_NORETRY is used by percpu.
> > > + */
> > > +#define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
> > > +                             __GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY)
> > > +
> Also we do support %GFP_NOFS and %GFP_NOIO flags.

Both of those are subsets of GFP_KERNEL, so I felt it was redundant to
add.

