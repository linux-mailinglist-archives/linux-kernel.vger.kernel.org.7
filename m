Return-Path: <linux-kernel+bounces-814136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10965B54FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B8E1885894
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C52930B527;
	Fri, 12 Sep 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ma45wmIq"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7065B296BD0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684229; cv=none; b=YteS2NyuDErl4ghu3oLp2973sz+4omrF2Q9EaLktMKmJxN/Yd/sAMEsCRkPF80d5jf1ViTwOZe8hWrdqbNwaQeS3763K1Ha7061uTjikjUrZCTM/um9uWkjSWpPnpfTaJplEzoitHaSmyzapj3sJydd00V9aDlsarC25BNYkvJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684229; c=relaxed/simple;
	bh=RWTW4K5eP4TSPhMx3HngqWzPlbT3R5Y5FLEaVy22UJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4C6poQLh8QzN69xvNz5b7vR7Zkm5l3H+o6UFoivBrYE8XMqRyLthh8bTembvY1f0TkYs6TuV4n6tet+ChjhzTLl6tPZqeCce+JyoHmrteyHsu/4x2bm9+ppk1Pmj0+O7tcKx3BkhYz5ujztd5O1fZj/6f1/SYBRx6OefF/58SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ma45wmIq; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-817f23fea68so90682085a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1757684226; x=1758289026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMM405brjjFdnpjK1r8i1H+eFiy2IHFybvmi8f16fpw=;
        b=ma45wmIqeJoW/dmADYDGMgV2ZRK5TRXZFol/rsTXY4kGeTpjNbwMeTRtrGDdkqJ6Ty
         JgGSn9GQr+cxscPPgPhMkMLPulCtvwRotZQ6aPAE8mZb0D62SEj1lV76YUsf6gHi0dRO
         7+uO+Utanm+IoMtL4likXzIaBDv/jM5Pti2JdPT2RLA9iV5LUPW2cprl/lHi44ei5KFk
         kY5zkoo20601UdNKSA49EbMLa+ZtPGK738MmcpP8E+29l0sLr87D8YT//D9SS9u3hSsq
         Y4NOjiZWiT0GO43nVFlBhQMIVbAr8PlbPJynpNikNsZ82eyYQyv+csz56J2NSKTPYxEp
         9Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684226; x=1758289026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMM405brjjFdnpjK1r8i1H+eFiy2IHFybvmi8f16fpw=;
        b=fW3cCCdbQPmDUU17cLpH5o2MR01Ut5tkrG9odbJ0Fy6HqD9FJaoeiBJyx+LlxSC2OB
         oD6NuWkQIlxAd+Bk1bKhLZWJZTmdlz452OUMt77L/iYcGs1DMytP3hul+VoMC31lONy9
         lK+ZC2X8dVG1TDOFwZxjNly7seFXcNQVCoLna7ojzXhXheZ50m9pD4Cd0LUXwfK0QM23
         hc78aJ3TfI5oPYdWsubDznnIoati/HGGuWec+v+uDyaVAHyvRBmnqBm7Xtylm2Zu+kxN
         clEn8aQx5GbLY3drWtgtze47y8102qICj5CC7JJSHlQZmQbr3D3Cpa7ipxbPN344SIeP
         /DLA==
X-Forwarded-Encrypted: i=1; AJvYcCUyWPzouC5RObhqnaZFbZriO+0gllZKyYZ8eypwSKE4YC01TS0G5BM6yBmiC9q6zmTbGdPNayPIjLZCJA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweohgkr27WsYScMo9cMBL5RRRp2tyeCmXiL/X6ErlRe4a7z90t
	kPStswRm8KaFKQHW0+DYYm+BEm++Ty5SxW4zpBCBKLCDfI+NceKpkmzV4ZScNCL6tfA=
X-Gm-Gg: ASbGncs23ABnJ0DcA07yx7n2D1K+fTHUY05/+hwlTLQJPpN3bDiDGb47C5Xt/Nhht8e
	nXML64mxDpUQqGTt9v8oIl3zlZInR2HypWrE9ZSat9YDK+pBmp1xAHnr0bl0h1N6bNI2U8kzvml
	g1c1vJ6lg4fpqf7idDqjtjoXXvAFxtBXNmMrHGH0xR6tXsAibJ4QUddK/vDTecUmKy6NXVT1oUK
	qdXxZA4X5A+nHyICjh2sPrHQHu/UnoOH5q+iTRdUfEsxLpHru9yolcOBqlbV2dsFVMlHNEfXibO
	AaI6Yo2AnBOigWcYWvBHKPrjFxH22kR4gOhsrFUDQyC32xhhB5i+wtw/CaOwAnsLFlk1HFXkDDh
	g835Ss2DtipCWkUnEzWSyYg==
X-Google-Smtp-Source: AGHT+IH1l85hOnywb8IKpBRIwjiNyZNrQdv1GYRya5V6eeksFNDva+bovkUz+anne+WxO6cXhs6oQQ==
X-Received: by 2002:a05:6214:2429:b0:72d:8061:93fb with SMTP id 6a1803df08f44-767bb3b6516mr31641516d6.11.1757684225728;
        Fri, 12 Sep 2025 06:37:05 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-763c03a7fa1sm26881466d6.59.2025.09.12.06.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 06:37:04 -0700 (PDT)
Date: Fri, 12 Sep 2025 09:37:01 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
	sunnanyong@huawei.com, vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
	jglisse@google.com, surenb@google.com, zokeefe@google.com,
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org,
	hughd@google.com, richard.weiyang@gmail.com, lance.yang@linux.dev,
	vbabka@suse.cz, rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
Message-ID: <20250912133701.GA802874@cmpxchg.org>
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>

On Fri, Sep 12, 2025 at 02:25:31PM +0200, David Hildenbrand wrote:
> On 12.09.25 14:19, Kiryl Shutsemau wrote:
> > On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
> >> The following series provides khugepaged with the capability to collapse
> >> anonymous memory regions to mTHPs.
> >>
> >> To achieve this we generalize the khugepaged functions to no longer depend
> >> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
> >> pages that are occupied (!none/zero). After the PMD scan is done, we do
> >> binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
> >> range. The restriction on max_ptes_none is removed during the scan, to make
> >> sure we account for the whole PMD range. When no mTHP size is enabled, the
> >> legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
> >> by the attempted collapse order to determine how full a mTHP must be to be
> >> eligible for the collapse to occur. If a mTHP collapse is attempted, but
> >> contains swapped out, or shared pages, we don't perform the collapse. It is
> >> now also possible to collapse to mTHPs without requiring the PMD THP size
> >> to be enabled.
> >>
> >> When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
> >> 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
> >> mTHP collapses to prevent collapse "creep" behavior. This prevents
> >> constantly promoting mTHPs to the next available size, which would occur
> >> because a collapse introduces more non-zero pages that would satisfy the
> >> promotion condition on subsequent scans.
> > 
> > Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
> > all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
> > 
> 
> I am all for not adding any more ugliness on top of all the ugliness we 
> added in the past.
> 
> I will soon propose deprecating that parameter in favor of something 
> that makes a bit more sense.
> 
> In essence, we'll likely have an "eagerness" parameter that ranges from 
> 0 to 10. 10 is essentially "always collapse" and 0 "never collapse if 
> not all is populated".
> 
> In between we will have more flexibility on how to set these values.
> 
> Likely 9 will be around 50% to not even motivate the user to set 
> something that does not make sense (creep).

One observation we've had from production experiments is that the
optimal number here isn't static. If you have plenty of memory, then
even very sparse THPs are beneficial.

An extreme example: if all your THPs have 2/512 pages populated,
that's still cutting TLB pressure in half!

So in the absence of memory pressure, allocating and collapsing should
optimally be aggressive even on very sparse regions.

On the flipside, if there is memory pressure, TLB benefits are very
quickly drowned out by faults and paging events. And I mean real
memory pressure. If all that's happening is that somebody is streaming
through filesystem data, the optimal behavior is still to be greedy.

Another consideration is that if we need to break large folios, we
should start with colder ones that provide less benefit, and defer the
splitting of hotter ones as long as possible.

Maybe a good direction would be to move splitting out of the shrinker
and tie it to the (refault-aware) anon reclaim. And then instead of a
fixed population threshold, collapse on a pressure gradient that
starts with "no pressure/thrashing and at least two base pages in THP
a region" and ends with "reclaim is splitting everything, back off".

