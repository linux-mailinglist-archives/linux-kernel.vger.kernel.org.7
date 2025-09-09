Return-Path: <linux-kernel+bounces-808516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB77DB500C4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1942A7A6F53
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6B9350844;
	Tue,  9 Sep 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="p4JuKygy"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C12E35207F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430830; cv=none; b=sjvfjuZTBtgFCL2fU5czL5JfSuxR4SV7EOanrJtORJL/1+B4nVP4zM3w9VCjSQDjNLkxW9+hJRKPiiv5Tp0O1t7ak8fKAAb81l17msKQ8iboP2xfA49Kkxwf1YZjbKSeSwquJnUwuDo/yx7pBWfXi+pgGpSfGuumapqzhHLKbV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430830; c=relaxed/simple;
	bh=q10CkdeySaOwMmKxAuBnw6h23p1G/gZls4sxkL4hzgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlwLlb0N+FXKbLiu5uHUxCWg8OOJW8BVG2Y9dCuzr5XweVqIuZU+pgVztd51IUPCFK+KcnSkIIUSEb6Y/F40iu9cDv2T2qxAmNUvg2hYNKnwJql6rUHMIBERSYD3P5W7G52ZoZSoSByKPTFx+NOtNeIpsbxjK93n3fSBDGsPOiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=p4JuKygy; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-805a55c09aeso543312985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1757430827; x=1758035627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uf+yTceGU5JGkt+Uo/sIFQ6JanTGXEu2guYeVg+ECaw=;
        b=p4JuKygyijnYyJwESu+Ieapxw4i4aNtZDASQYGExL8tKKFWQ7JjLbbo8EP78lZJOxi
         fId8vgNWv9C7LG79osjCDJ8HR7Fs/845OO5dpZfOVcQ4ZF0uXMJ4Bx0Yco7KsAchYIrZ
         1l/ieasp1vtie8NHyeG7PGUZ5a2ZSN/W3ssDZ5fqk09Y7f7tAlxgLIWwxM1bECujpUBl
         Tq8Z/lWP5c2R1XbLkaIu46zilQ1dgSy0O4R2BPJUGGjWHfcgi9XfFTVgBHkEWGLTjt4m
         NQ/aWZLS4asueb0XsrV8s1IW/OpxrHaLfdO1c3dKU0dBgFYAA7NuoTcHo7Ar2czP0FTR
         Ka4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757430827; x=1758035627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf+yTceGU5JGkt+Uo/sIFQ6JanTGXEu2guYeVg+ECaw=;
        b=tUzMXqoh8MOgkM9hA/VV8kJ+68sIslhHeZ+lyHGiyC8Dm0gb2wkCY1i1vT9zXzOR8P
         1bqGKRLswz5narEXs8DWLY0Os/Jjk16DGCCtZjXZ9axwALKkN1Y0TVm+yNxs9h8UIli6
         /ahkC0++N9JpmUAR8vwX/rls90Iqh4CqtfWd95AQe+9W75WIUXCoLDHddrh07PthIqfo
         Ib2OPtlnyBnyicfishtazQFBXt34CNBA9TNh5GtfktxVG/smiclUsDmmDSkzwhKmkocp
         JoF5K7wwhDByKoTwr2OUOOa+ZBne058Vkg+sPr3gdIPpTtlkl+FksrsEV2jKJLFbe1DC
         yWYw==
X-Forwarded-Encrypted: i=1; AJvYcCXidCLqHP3t+EdtuqT7b3WHZhsOSfPqUDBHgPeOwSS22p0X6tvbJX9B7ZgTorpXOSgnYU4CYxwVZ44ZeaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHbOQtwV0a5J5JQhRIrrLyZvG6NDZP73f1PsHIgxEzuncp+jo9
	qVjXqc3Ea0o7TlFjBAw7VBq2FdxEqltdW/bOXkFbEVlIWbjjzJ63UAMe9vfMmksQGJY=
X-Gm-Gg: ASbGncsVNUV3CCFct43tf6r9LQg5OeNGfSoXOHM0UKEqKcQ1uFYtz9+hGLLuIXzPLXQ
	vBQycWkYJMaCPbT2rDBEGKvM+WnlyS1y2nai4H1iXI6J2LMIpLH7fLNlQQRVWwtDdQJwZrNW0V/
	2BA4l+4wNxfOAsUd9Uu9PI0pWUl69WaIiTdA0EZONU47pFogBbNoZM1JCVZTBSNk/Rn0+K26aSY
	d5Rt74SIKa1CAc6hKZWqkAIZG2lUk/GRl158kPbgh3b2dXmLvEIWTLhu6btDjx8C/H9RqfHVH8Y
	sHgkwqo1+3VyUt7qYgjWayJjTNIPKGjg6oGfVHtjggMDdZ11FIbvrFZMzVheS7KkLrd95O4bWg6
	SKV6vHOQ0nB8K
X-Google-Smtp-Source: AGHT+IFk1mNsRoXg6pueACyEECW6Z59QmlqnpPcT14EM2tD1B0zWQIgkHrVzU+oQQccJBi9dAKzUgQ==
X-Received: by 2002:a05:620a:c44:b0:803:7023:36b5 with SMTP id af79cd13be357-813c2efc949mr1318765985a.59.1757430827104;
        Tue, 09 Sep 2025 08:13:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:600::1463])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-81b5f8fff60sm132842285a.60.2025.09.09.08.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:13:46 -0700 (PDT)
Date: Tue, 9 Sep 2025 16:13:45 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: remove unused zpool layer
Message-ID: <20250909151345.GE1474@cmpxchg.org>
References: <20250829162212.208258-3-hannes@cmpxchg.org>
 <20250829190728.60675-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829190728.60675-1-sj@kernel.org>

On Fri, Aug 29, 2025 at 12:07:28PM -0700, SeongJae Park wrote:
> On Fri, 29 Aug 2025 17:15:27 +0100 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > With zswap using zsmalloc directly, there are no more in-tree users of
> > this code. Remove it.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> [...]
> > --- a/Documentation/admin-guide/mm/zswap.rst
> > +++ b/Documentation/admin-guide/mm/zswap.rst
> [...]
> >  When a swap page is passed from swapout to zswap, zswap maintains a mapping
> > -of the swap entry, a combination of the swap type and swap offset, to the zpool
> > -handle that references that compressed swap page.  This mapping is achieved
> > -with a red-black tree per swap type.  The swap offset is the search key for the
> > -tree nodes.
> 
> Nit.  s/red-black tree/xarray/ ?

Yeah, I just kept the changes scoped to the removal of zpool.

But this file indeed needs a general update beyond the changes in this
series. I'll send a separate patch to clean this up.

> Acked-by: SeongJae Park <sj@kernel.org>

Thanks SJ

