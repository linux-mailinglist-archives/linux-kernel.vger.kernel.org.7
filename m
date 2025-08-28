Return-Path: <linux-kernel+bounces-789661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBD7B398C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FD81BA5798
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282DE2ED164;
	Thu, 28 Aug 2025 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWlDYrxl"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA6125E44D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374701; cv=none; b=CYRpWFPujN1geq61cw+kfXNwiT4LdxlIUxPlYNCzTR2NoEfn8c+swqCJV9eG91ttmFzgC78r9axBfjTmkoy6OiUHiPicvPmOXz/Ue8fLonZPGURJj8SwV8rYmqUb7XXB/Z6VzPnDojiAUz3+bTqOUh3UAmWG0Nc93Tl2pKDW1j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374701; c=relaxed/simple;
	bh=tz4lBuNQIXKl/LHcd5wiowEqT2ARtdze427Yoj6pTJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT6e+dsSuuvMbthuCBEq9bX7aOfZYJ/MYQfEHZ2r/OtKgU44WABL6hkie668mOXDZQIEU3qVdu8cZ3Xn/Qu+cmhc7TTB9CIxLgpehWTYwyLDY2DHhACf70twivVVfEHvlDcSzSsZP84k4j27k3Hax8HRcGE3/gtqK6UeJVmzrrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWlDYrxl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b7c01a708so1098855e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756374698; x=1756979498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fcu0DYxrMs+6R7G4AatSzbn0mHIOQG5qjGHtzkS6pk0=;
        b=LWlDYrxlanihAw8R7gJZGb+EpXshUdBdDR18zUZlEucMOKBUN1xNKJQhn8MzzdbCAM
         YPMXCycSKajsolrfyVE7E7pkRo16VrcvHeL4JJZwrDT6Tbmgytw4EXdkcUPwvuMIW3Lh
         tbFuK1GeoXPh5d38snjmem+Y26I1g0oX8C+ti5kW07EqBeD/gXL2Qbny9+n9AVEPngTZ
         n1TRwak8bOsr8znz2HfQP62o3z+4TZ2gLgs9n6XI+YK19+KiJNwIkQ1HPoRapUxhno9A
         kcOO1elKLnP/15KxPNMigQcYd6gYwRk/2zGUzaqayXzLDkbBtWh6/CnsUgA1+CCU+5kS
         zXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756374698; x=1756979498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcu0DYxrMs+6R7G4AatSzbn0mHIOQG5qjGHtzkS6pk0=;
        b=HjBUFuOfDQcc3oSfZ0/+ko1LzSthrcGEy1TURopoChGsNxzQH6LKR68siocPdxgX5n
         zPrtrONuR1G0gZgEO1zIlj0swDjEx6OMQ1JkxTi9XKgIV4NSeRsq7TEjMjQOF9oloe2N
         5Ot2oP5TSkoZdidbzbjyXKertQqm5tI/ZdSyyXNsH0oc56XeBSYkZ7OJb5NqMhfpCoQb
         f0wjeAgPsMzEpiZkc7QhJQ7k5tOId4BJU9qFfQkBWSl14hjRPttMTnEtR+6xFiAtXgOw
         uE8bGDeNcDcl4lqjPAFrYWv5a6DfbBZvrKZqWJxi2pRsWm/vn7ZCHa+zHn5qAtEXkfsA
         Tjlw==
X-Forwarded-Encrypted: i=1; AJvYcCVYVKxTGMD/ziaLx9DEziHHMz4XSla6UzXBq3vgwen0GaonfiSR/FXluAaK7zm8RAw0KfnslF3a/xf1WtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx906sWGjCdgtTV9xZTTUZNDbecRfn4EWp1BiLry3/vwrZxyQ93
	XR1JmG54x5CA612X0F+8Z2f91Anrr6fWXWbrpzKJlXTup/a3WNdpTKoM
X-Gm-Gg: ASbGnctQ/VP1fXBYUYTtRq3tySdicwF0InMyqnxrjIPky/FIgPQP7fOwJ5Zpf0p8Yno
	a+ns/ZluxpYhPCPxuLYxV4KiaMgyOvYirBnXgx1jaBzK4mmk5odEJ3J05UByheq7YLw/Ab7BMEd
	jFVSCPLNxLGRIafv0svfCnzgQ9vbK6mM3uSXqfZHtk1D3JvO6dOTdXv2Clp/hvj8+Ka4QsvLGky
	47RBP/HRWc2+PgL7wKPOsgllHUP/J6nVVfbxh/lFGi6xFsZ+O+Qzd6dhTJF9Gq1yRU6DcvZpKEY
	PC7LE0sSZtM20czUZN5wzsHiVpKJAV9vFLse4Dxs+OmfEk162URKIKk6YSiH5zFv35e7oOdseBg
	xYk/8uteAQYLTgK85vLvtPm7Ev1tFz6qYDP1daqA=
X-Google-Smtp-Source: AGHT+IGr8n5UrW/1/lXAw9gaGgBuGbNK8ig/FjzziWaJErrSrrUmOz6ZsnV6yI6wYcnNM14gKe6ADg==
X-Received: by 2002:a05:600c:6304:b0:459:443e:b177 with SMTP id 5b1f17b1804b1-45b65f11097mr83864065e9.25.1756374698038;
        Thu, 28 Aug 2025 02:51:38 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:5a::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b797dd66dsm24817265e9.20.2025.08.28.02.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:51:37 -0700 (PDT)
Date: Thu, 28 Aug 2025 02:51:35 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mm/show_mem: Add trylock while printing alloc info
Message-ID: <aLAmp4oayTfkPJ3o@devbig569.cln6.facebook.com>
References: <cover.1756318426.git.pyyjason@gmail.com>
 <7e2bc96faab1a338829e549246189ad96e6c866b.1756318426.git.pyyjason@gmail.com>
 <20250827150619.4e468e68988f224f9f9bea6f@linux-foundation.org>
 <aLAUhXeRVWzLCNNd@devbig569.cln6.facebook.com>
 <c8db3486-4f13-4922-a270-1fbf61e2d782@suse.cz>
 <aLAXsptN4cw05IoZ@devbig569.cln6.facebook.com>
 <2182c715-aaf1-46d1-809e-e4142bc083af@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2182c715-aaf1-46d1-809e-e4142bc083af@suse.cz>

On Thu, Aug 28, 2025 at 10:53:01AM +0200, Vlastimil Babka wrote:
> On 8/28/25 10:47, Yueyang Pan wrote:
> > On Thu, Aug 28, 2025 at 10:41:23AM +0200, Vlastimil Babka wrote:
> >> On 8/28/25 10:34, Yueyang Pan wrote:
> >> > On Wed, Aug 27, 2025 at 03:06:19PM -0700, Andrew Morton wrote:
> >> >> On Wed, 27 Aug 2025 11:34:23 -0700 Yueyang Pan <pyyjason@gmail.com> wrote:
> >> >> 
> >> >> > In production, show_mem() can be called concurrently from two
> >> >> > different entities, for example one from oom_kill_process()
> >> >> > another from __alloc_pages_slowpath from another kthread. This
> >> >> > patch adds a mutex and invokes trylock before printing out the
> >> >> > kernel alloc info in show_mem(). This way two alloc info won't
> >> >> > interleave with each other, which then makes parsing easier.
> >> 
> >> What about the rest of the information printed by show_mem() being interleaved?
> > 
> > Thanks for your feedback, Vlastimil. We cannot use trylock for the rest 
> > part as node filter can be different.
> 
> Right.
> 
> > Do you think we need a lock to prevent the whole show_mem() from being 
> > interleaved and to acquire it at the very beginning? Will it be too 
> > heavy?
> 
> It might be risky so perhaps let's not. Guess we can disentangle by dmesg
> showing the thread id prefix.

I have thought about this. Since each line can interleave with another, we 
would end up adding tid to each line. Not sure if this is acceptable.

Thanks
Pan

