Return-Path: <linux-kernel+bounces-845632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3769BC5904
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83C764ED069
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784C92F3609;
	Wed,  8 Oct 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cebxWFv8"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77A22A7E6
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937030; cv=none; b=HdAAowqQooSiJP97SOWjbCK+74lobj8dBFyX9vSJbxC4zMfkYDXh9trez/InGlpB1LYZCOMhGOwTODii2FouQkxSPYgGmytifR8PyTe5VKfpa3ILfIIzHeaM2OdUcjYGzZArpnA4sNjGn5EyG9rqGNqt8Y+eQhHIMqihLukrto8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937030; c=relaxed/simple;
	bh=l9os6ZO8dPY7bfQh/0jGGJRonldCJsuxvWJYvxUUJAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qez63AYrq3XHm42X62VwJ73+eF9eictlZWsO3EBF+07YP3andh3hAYd7FwpiDWpY0TNJHcyw7aVPbuxlWvfXg/wCZN153gtn1fOV7dM1U3gz3Ak4xt3AtY7rEsGWPXVtvPrTO2kFPUH41FpBQQC/XU1h+5QrDj5ZOrnIE+/XcdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cebxWFv8; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso6500250a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759937026; x=1760541826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEFKGIEcuas2Pari3eoGaAS3BufIbyvqNDimCw+KvpQ=;
        b=cebxWFv8EJqPNUrzmjVbTGNroZHu/D3PH9uWTrbbR54e7gke8WRw0GnQwsYE6H2Bdf
         m5ZKXmocBQrRLEQxUqkvM2ZhZ5kZe4d1qLImQwjuCUArAyZhRMpF++I+coXLDecnKIyY
         2ccjiBPt8+JK4upy4cIU6gB36lN5n/h4d4zDE+P8sG4q+PaEql6T5XVvZI1lTLQaddTY
         0rmzeJUiRtPsA4R5jAVI7EdZKrNLM9LRZMFPruEDf4YPZhV3Yz98rBjPOp90+8ITiNmm
         ApDcTvjylchy+D5dxGyGHnmBgpSl/oJrWfTgdhlkF+I6fnoUNg53Cnio0HeRR85YsNfu
         qAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759937026; x=1760541826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEFKGIEcuas2Pari3eoGaAS3BufIbyvqNDimCw+KvpQ=;
        b=KS4HWepW5OTYyur49jEnmzENX2GR+UZXSDBdlIfEreza24QIL29isIW+FExE5NPXbu
         ZQZkf8qGCP+ymt/nM3hbjm4JZBBFPq3TnclraeuZ3atmZ1k2vSRYFgscRm1AwIoQrsgA
         P68eM/FjezoVZsML7u7iIRKnvS3hQRND6ZfmyHfYMzB0/P8o+9IZ9bRxOkVbY6Zx1czO
         AS+vFaLrJqEWtwJ4iW09HfoENNEDjionYvZPRHGCY+wro5noWkqIlXH8Ql5bKL0xXtxY
         Vab8R7Q5JK9fn1/W8MytVrGkNsANcJrFkA05LXELBDtebQxd89pdfhN7x5haQ5LoT1o9
         dcJg==
X-Forwarded-Encrypted: i=1; AJvYcCXVBVGmRsmh2RQPq9WhRQngOJ7Q0xyMpRNHIgIdQGdpHu85cpgrCbIkGfe56G5cei4hBfHMQDDR8TxgQAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOSysOP7kx4ExenrsEqnU6AuVpfQCi//9XXc0IkG8OLGi/NYyB
	zjBy9OjSMzJZaRVTqcWRrS37t1Qn97cKD3JguotwB0f3mANUiVraH6HCh76mYXoBj4Q=
X-Gm-Gg: ASbGnctsm7288lmzAfNadq14STMHel7TlKLHXH0OVHwRL+dX8xTE/apFEtN3x/ABbdh
	qk/1ZliBH9MHhVldJxiDvBX6ix4op/uVL7noxeUiq8Cc30+88gNIQqw1m1D6QdUIW+na5eJZyWR
	gs57mJ4ISifniY1/ED8mqrJgxwj6Om1K+LRUSjzZl9u+F7LyBA/ohX2gbfgSTVdJD0ytAcP0zAO
	Koidar4JHh7Vk9v9jJUuAlCDcGicp/e94m6Mm1XHz9ZR9lDfi1KtPpniiGEsex3CuSmi46skxBX
	dXpD3XAStNi8yCTJ4AodGN6wx928yLYS7qx55T9Q3PGixvMxlEfB2jvh+11MDXDSH/4z5aMmrEN
	3fkv0lb+Fkdk8nq+b7KePfRK+fHRGUx6+5PYex2/N42Qam46c43kDtONgkNN/
X-Google-Smtp-Source: AGHT+IGNuMGqHdw+uNNDnAnIMkPJmLsC8kdVFIi2VETZkBtQkqYRsFlkZfBi/u6TL2LUyonVmTrK0w==
X-Received: by 2002:a17:907:c14:b0:b45:8370:eef6 with SMTP id a640c23a62f3a-b50aaa9d0f5mr485367066b.19.1759937026160;
        Wed, 08 Oct 2025 08:23:46 -0700 (PDT)
Received: from localhost (109-81-95-234.rct.o2.cz. [109.81.95.234])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b486970b2ffsm1711555666b.47.2025.10.08.08.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:23:45 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:23:44 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, corbet@lwn.net,
	muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org,
	hannes@cmpxchg.org, laoar.shao@gmail.com, brauner@kernel.org,
	mclapinski@google.com, joel.granados@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@suse.de>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
Message-ID: <aOaCAG6e5a7BDUxK@tiehlicka>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZ8PPWMchRN_t5-@tiehlicka>
 <271f9af4-695c-4aa5-9249-2d21ad3db76e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <271f9af4-695c-4aa5-9249-2d21ad3db76e@redhat.com>

On Wed 08-10-25 17:14:26, David Hildenbrand wrote:
> On 08.10.25 16:59, Michal Hocko wrote:
> > On Wed 08-10-25 10:58:23, David Hildenbrand wrote:
> > > On 07.10.25 23:44, Gregory Price wrote:
> > [...]
> > > > @@ -926,7 +927,8 @@ static inline gfp_t htlb_alloc_mask(struct hstate *h)
> > > >    {
> > > >    	gfp_t gfp = __GFP_COMP | __GFP_NOWARN;
> > > > -	gfp |= hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
> > > > +	gfp |= (hugepage_movable_supported(h) || hugepages_treat_as_movable) ?
> > > > +	       GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
> > > 
> > > I mean, this is as ugly as it gets.
> > > 
> > > Can't we just let that old approach RIP where it belongs? :)
> > > 
> > > If something unmovable, it does not belong on ZONE_MOVABLE, as simple as that.
> > 
> > yes, I do agree. This is just muddying the semantic of the zone.
> > 
> > Maybe what we really want is to have a configurable zone rather than a
> > very specific consumer of it instead. What do I mean by that? We clearly
> > have physically (DMA, DMA32) and usability (NORMAL, MOVABLE) constrained
> > zones. So rather than having a MOVABLE zone we can have a single zone
> > $FOO_NAME zone with configurable attributes - like allocation
> > constrains (kernel, user, movable, etc). Now that we can overlap zones
> > this should allow for quite a lot flexibility. Implementation wise this
> > would require some tricks as we have 2 zone types for potentially 3
> > different major usecases (kernel allocations, userspace reserved ranges
> > without movability and movable allocations). I haven't thought this
> > through completely and mostly throwing this as an idea (maybe won't
> > work). Does that make sense?
> 
> I suggested something called PREFER_MOVABLE in the past, that would prefer
> movable allocations but nothing would stop unmovable allocations to end up
> on it. But only as a last resort or when explicitly requested (e.g.,
> gigantic pages).
> 
> Maybe that's similar to what you have in mind?

Slightly different because what I was thinking about was more towards
guarantee/predictability. Last resort is quite hard to plan around. It
might be a peak memory pressure to eat up portion of a memory block and
then fragmenting it to prevent other use planned for that memroy block.
That is why I called it user allocations because those are supposed to
be configured for userspace consumation and planned for that use. So you
would get pretty much a guarantee that no kernel allocations will fall
there.

-- 
Michal Hocko
SUSE Labs

