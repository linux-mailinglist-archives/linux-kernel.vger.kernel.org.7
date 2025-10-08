Return-Path: <linux-kernel+bounces-845795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6032BC61E5
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829BC3B846A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690B029ACDB;
	Wed,  8 Oct 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="EvH+GnTm"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D11E32D3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759943135; cv=none; b=bykRNc17U8fPtNVWCPvWj4iVTaO8pm9UO1nNmsqHQ8ZPmKieKMxPJylsP4R7ZeCAVN+CvQZaqgT0K9SLToFJ0BHE/LBy7Km3FW9VOjoUGEQOjpmNygXJUYi6G5Kwjbk0E1rZ3wG+iirY+FitlHvRiKomeE0EpfmXQfT+J3zb33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759943135; c=relaxed/simple;
	bh=lykQn+FQT55p68zRDbABBcOsa9TTYqQN8lbfQUCfsfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfL0a6DWSOCs4wG6JKUh4WG4EobsWfZAvbeVzEcpUDVAnF5xUymolrl128HIuFncHYtPWTlnbJhDhF9OKQaDrOLasuFEwLXIv18y2WW+82AI0qFnlZYy+AfuG6rLf/Jm1W6B6sPqgza236LXOEKz/OsfY9oLsLVZaWZxfOkPyMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=EvH+GnTm; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-875d55217a5so2987685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759943133; x=1760547933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PXvJ84I7DoVfJBSKO4yOsPRB7++PVFt2jBMWq/ZPjB0=;
        b=EvH+GnTm+k6YDM8esAi37vaDX+VvfVKdXkH/voeTh7/oothCZg+pvk0hIni90+aoBq
         HIoI9dvfe0/ayaNuYz5s+IWggFAe+4gpY+WrxmvxE5rO+N74IoaVEKqTPKat2Ydoj5sp
         cJlg4JNJ7MirffoJvMEffpuQDPozToeFWWw/KUO6fbWKAOltLjobC5rV3hMKPB1PWJol
         6N3t89xTSOtUD+4PXT2u7wO8IU2aMajIxee5LdFha+VOfR4y+r1vkCtJw+a9WXXlXYKW
         1poyoR5o27mpO6vPCeUNDiBGuCXxZzYOYRhcUcqhQ82bG8fz6qV7Zsjcv7jI8maT3xCE
         HYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759943133; x=1760547933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXvJ84I7DoVfJBSKO4yOsPRB7++PVFt2jBMWq/ZPjB0=;
        b=X3JvhY3CYUaBUusRLRh19P02IcVQ7gsfYLTQhkJpUBDwevKWrZ4sNJRvL09+RJzbDc
         M7X9HxMRFo55/t7V0MQzh0VsUaGidO5WZxL9WJp/xoYsU4AdH/sKydhFWSR8GDOnsAZs
         70AELrUYd8z6CKNTJeIM05AzqviqCw6JleIVybiRZn+u84q74RVtsMy41JzR39b65vOM
         XIs263zhbwMYJM2kMT5PtR6fmLtVmT81WRD88QsL8XC9ZB0cXDJO7OQVC+e5x8Yxj52V
         /6GxWyu1wFchfD01+/FgtN1hrMQhFKFJFdb1eVJk+1YT8ALoqrFh9jHYl785E0s311AL
         SRVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRBr/m/lTC6KxixW3fo9GYoNkGxrJ1MWF4p8iw6/utBY78YbY2pu3skMQRFli+M79V75rmnZWmsOyoDJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1EMJ0gdsvLRiTkLyIeMn+ElpocGzztGsHRwI5eClRz9uFLi4O
	muQkN1dfHi0tWiN90Ji6i6VaoO2FUx4+aitswYEhCV+kWw5W0c8hxrxNHJ34ahQ0HRM=
X-Gm-Gg: ASbGncuBzSqMnzoNEfhWDwClz1dXSJ4jzPx1csRrOVj4rbU9b4zO2p/hTL4/IOWuliB
	W5ctfel0lfi4Vd+aajW+Vwa3E93HVCH2gaxIduZUuuDPv7C4XH0IQVHcASFYRY4s850J/4UrsJc
	DxioeUr1B2QU0Ix/atXT73p3DfvgZRZhOtS7r/zCxh4Ns9a6vfBjag0nA36r7k93FeIoub/oxiN
	riPbdKZdLqRGpRbElki3XK46i+5+/ZIpRBj/+MS1ImNoGKLo9crEweFaBWaBISU4cEiyfLqG7GC
	liQGr0EqmNS7OXfKHGKIssj1n9l/1CXxiq3pXpYSUwIR9LACHsgODJ0ISqlf+jNUqRO2Yw0D2u8
	UCnR9RSRB6wO7EDPr2DKyY/zEswFCU5P+8ep9X9WbYWMN3/29esQjOAr5C9ysIuC3KPsydEUhoP
	1Cq923nsvDIe7QkcgO5WTLrtk+0w9j7H0EOwYFP0Ovn8+eOteyKGE=
X-Google-Smtp-Source: AGHT+IHTTVXTCiYKFRjp/R7MyfRa3HWK9EIiUGj0jtPBpCzSk6p5BgpHTweDq92wD5qHBCW74OIL9A==
X-Received: by 2002:a05:620a:44d0:b0:863:b78e:d159 with SMTP id af79cd13be357-88354ea751amr597920685a.51.1759943132915;
        Wed, 08 Oct 2025 10:05:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf53343sm168514456d6.54.2025.10.08.10.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 10:05:32 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:05:30 -0400
From: Gregory Price <gourry@gourry.net>
To: Frank van der Linden <fvdl@google.com>
Cc: Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org, corbet@lwn.net, muchun.song@linux.dev,
	osalvador@suse.de, akpm@linux-foundation.org, hannes@cmpxchg.org,
	laoar.shao@gmail.com, brauner@kernel.org, mclapinski@google.com,
	joel.granados@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
Message-ID: <aOaZ2o3l7ufX-9Ly@gourry-fedora-PF4VCD3F>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZ8PPWMchRN_t5-@tiehlicka>
 <CAPTztWaH7mJ3ACfqqYr1CFCDycw6Zm727t7wAa4n9Th22bn-yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTztWaH7mJ3ACfqqYr1CFCDycw6Zm727t7wAa4n9Th22bn-yQ@mail.gmail.com>

On Wed, Oct 08, 2025 at 09:08:01AM -0700, Frank van der Linden wrote:
> On Wed, Oct 8, 2025 at 7:59 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > Maybe what we really want is to have a configurable zone rather than a
> > very specific consumer of it instead. What do I mean by that? We clearly
> > have physically (DMA, DMA32) and usability (NORMAL, MOVABLE) constrained
> > zones. So rather than having a MOVABLE zone we can have a single zone
> > $FOO_NAME zone with configurable attributes - like allocation
> > constrains (kernel, user, movable, etc). Now that we can overlap zones
...
> 
> I agree that having mutiple zone properties is probably the way to go.
> 

Ah, I should also mention that I've been kicking around the idea of a
ZONE_DEVICE allocator - but this blows up pretty quickly into
maintaining an entirely separate page allocator for non-general-use
memory, so i didn't want to start off with that until later.

tl;dr: pgmap->alloc_folio(gfp, order)

Then allow driver managed memory to "online" this capacity via
ZONE_DEVICE and integrate *specific* areas of the kernel to use it -
rather than everything.  The device's driver is then responsible for
implementing alloc_folio(gfp, order), and a zone_device_alloc() is
responsible for hitting all the relevant devices for a compatible
allocation.

I alluded to this in the hotness/compression discussions - where there
is some compressed memory you want to draw hard boundaries around how
it is accessed/mapped, but want it available as a demotion source.

https://lore.kernel.org/linux-mm/aNzWwz5OYLOjwjLv@gourry-fedora-PF4VCD3F/

Not sure if i'm just overcomplicating the discussion here, but if we're
talking about new ZONEs then maybe it's worth considering something like
this as well.

~Gregory

