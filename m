Return-Path: <linux-kernel+bounces-838522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D51BAF624
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9659E7AE4B7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED567226165;
	Wed,  1 Oct 2025 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NbPxSJyg"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941C1D61B7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303370; cv=none; b=qFFvLgGAUnLTT0LX+dXVF3oU1THLIa5VrzfifXt6zuhiVqDaRyvlu4nddz9JjdeNdmecqMbYLFMn1K676iwtz0eHW46xeZ75aswr63cN7KRRpGt1EoncK2Sw+jUc8oK6QWTI+5BRhEuHuuzOT6qcKizfqOaFCB5o1o8rXzzP8KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303370; c=relaxed/simple;
	bh=1S5zzLqY1K2SmswcNNyq3lgCNg3w91cM/nUsslaHe30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjGNB435/VZmhC6DFUhKyO6KWU2WNw5WYm/kLEaMFPjsxgMKkT8mJU4KYD4wdF+Gp2SdxKWVozybckbWgKMofW4Va2D7CTPgVxGBqut38FjccGXbZVbnAQBbIiy/0aqiD1rpXxfmbSl6mlt5roYeK1JFzskyF8tz1oW6YMi/tT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NbPxSJyg; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-795be3a3644so39153296d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 00:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759303367; x=1759908167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/dGsRtrk3NgIPfHc9qy1Hht+Zu4gDykb2oRP+kyh1y8=;
        b=NbPxSJygL7BUg21XfQMGhX3sFDuvpeUIoIA5wG+JaoXwxM7s3E3CTMhodO2cwS9I5H
         Y8refzp1kTxoEURLWJkbLO1nfER9WJZW63Cr5IBp1USXWTAW+5zaq2pWbn5b+ghe1+4o
         yZ8YfYeIaF+FmXz77+lSJgdgK0NimTLGsFNEuKWVqyQGqzmT/iPOQyDSQ0phl3xKnge4
         E77p05m33QpQQW6y999yx839tlv4eCL6SnnJsM16Om/V/1CNKqcUNsfAhr/PxJuThbiR
         HJWHQyUbBCdb4K+YI81D7T9mlPyX/QvLDMfLcX+ZtXbudVSjMSQ9ieLZi64GSyhf8hw3
         8vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759303367; x=1759908167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dGsRtrk3NgIPfHc9qy1Hht+Zu4gDykb2oRP+kyh1y8=;
        b=qqJgnj66rulyOxAX/tkJs7KxWUKcRUmUXC+WVVOhtU90Elbw4pWEkP+uCrxhMhe8zn
         bUOzq9Wv4oHgCGeyBoCtMfLWxSsLKS+/4pPYU3YbptkfcUj2qaRC8tB55gM4Ymumdd4G
         m5tjutTkKBZBaPMZbMapX5v1kosIirHy0MTXixvmIp9YM/da8r/HMrrsHuyLgG/xb/Xm
         ABCpMJCQNxaMwmlNJpM4Ck7lOZd3z3emuysWTnl/whBm3/+7TlTTa5Oq0fTXbdGyGQeE
         NIL3nse1Gbyk+Ln/ufNnxVE1zBpYKFVrOqs5qSUJD0+Vw3owDoo3nAvNef0wi/UduLyJ
         G5qw==
X-Forwarded-Encrypted: i=1; AJvYcCXvU3jD/1xCJihjQkmrfOLGRVZH2vHxIIjy1aZkm0oqjNl3TgnKZj2HPcUmZvfqZqg+hnewMLhH5xvGmiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoWsuX6MhgvyMRxibzHEtOzwoQLHkizBhHBy/o6kOmQkzvX0ck
	ktVv6SdeNLJahxwZXnrwss2GKc/6R/jwpu3cpsih0ByKJUnMmg571wtjPI98ylUxW44=
X-Gm-Gg: ASbGnctP/MGdMNsm/owtxzpGa6KspWW6G6RJDyXjZUIazgx/kWusFJM4sS0BkAh7J69
	2CXtRLWklniThlOxm/NTMriT3/bYfMntdORG+teMYef5iw6aUFlRrPLyPsmateyFoDv5jvazQB4
	UFcE9YUzGmZDHF9P0PTOMh4tf1+6uAeNCX+ZTMHfDYJRrtp2ZF+ro/ly3oOXxorMZsfnMSORFbY
	IYVbkbECjrhtqWUm9BrJzEpwbi40eSt1CQda8HR5+K1XHNPlRgnTjnEsetRPoJr4x/wjZyCxA6Y
	hnHr8jTlko99rkmy2uSOa7Ujl+Wy9kghug0owcqcAie3AMsLrb0xYTi+aG3pFooA2y7SwSxn5Mo
	NpiFy760+y3Oxhobu3Mk5gUY9VM8am3ekKHbgpHnsYOS57K2kARLuB9rGmyxju91pSGVOSXJC4L
	9MVkVnSyPqXXTuvE0ZSA22lICcVGlqGw==
X-Google-Smtp-Source: AGHT+IEb4zYPFyY51hBg9M62QR/+6dWkMsCJckH5yirdBRASwDVM76yHqNVz6fekjl8pBVjStIx0HQ==
X-Received: by 2002:ad4:4ee6:0:b0:863:5c7a:728a with SMTP id 6a1803df08f44-873a547f9a5mr32344286d6.37.1759303366554;
        Wed, 01 Oct 2025 00:22:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8013cdf31besm107925176d6.18.2025.10.01.00.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 00:22:45 -0700 (PDT)
Date: Wed, 1 Oct 2025 03:22:43 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>,
	Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, dave.hansen@intel.com, hannes@cmpxchg.org,
	mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org,
	raghavendra.kt@amd.com, riel@surriel.com, sj@kernel.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
	nifan.cxl@gmail.com, xuezhengchu@huawei.com,
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com,
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com,
	balbirs@nvidia.com, alok.rathore@samsung.com, yiannis@zptcorp.com,
	Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <aNzWwz5OYLOjwjLv@gourry-fedora-PF4VCD3F>
References: <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
 <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
 <20250917174941.000061d3@huawei.com>
 <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
 <20250925160058.00002645@huawei.com>
 <aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>
 <20250925162426.00007474@huawei.com>
 <aNVohF0sPNZSuTgI@gourry-fedora-PF4VCD3F>
 <20250925182308.00001be4@huawei.com>
 <aNWRuKGurAntxhxG@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNWRuKGurAntxhxG@gourry-fedora-PF4VCD3F>

On Thu, Sep 25, 2025 at 03:02:16PM -0400, Gregory Price wrote:
> On Thu, Sep 25, 2025 at 06:23:08PM +0100, Jonathan Cameron wrote:
> > On Thu, 25 Sep 2025 12:06:28 -0400
> > Gregory Price <gourry@gourry.net> wrote:
> > 
> > > It feels much more natural to put this as a zswap/zram backend.
> > > 
> > Agreed.  I currently see two paths that are generic (ish).
> > 
> > 1. zswap route - faulting as you describe on writes.
> 
> aaaaaaaaaaaaaaaaaaaaaaah but therein lies the rub
> 
> The interposition point for zswap/zram is the PTE present bit being 
> hacked off to generate access faults.
> 

I went digging around a bit.

Not only this, but the PTE is used to store the swap entry ID, so you
can't just use a swap backend and keep the mapping. It's just not a
compatible abstraction - so as a zswap-backend this is DOA.

Even if you could figure out a way to re-use the abstraction and just
take a hard-fault to fault it back in as read-only, you lose the swap
entry on fault.  That just gets nasty trying to reconcile the
differences between this interface and swap at that point.

So here's a fun proposal.  I'm not sure of how NUMA nodes for devices
get determined - 

1. Carve out an explicit proximity domain (NUMA node) for the compressed
   region via SRAT.
   https://docs.kernel.org/driver-api/cxl/platform/acpi/srat.html

2. Make sure this proximity domain (NUMA node) has separate data in the
   HMAT so it can be an explicit demotion target for higher tiers
   https://docs.kernel.org/driver-api/cxl/platform/acpi/hmat.html

3. Create a node-to-zone-allocator registration and retrieval function
   device_folio_alloc = nid_to_alloc(nid)

4. Create a DAX extension that registers the above allocator interface

5. in `alloc_migration_target()` mm/migrate.c
   Since nid is not a valid buddy-allocator target, everything here
   will fail.  So we can simply append the following to the bottom

   device_folio_alloc = nid_to_alloc(nid, DEVICE_FOLIO_ALLOC);
   if (device_folio_alloc)
       folio = device_folio_alloc(...)
   return folio;

6. in `struct migration_target_control` add a new .no_writable value
   - This will say the new mapping replacements should have the
     writable bit chopped off.

7. On write-fault, extent mm/memory.c:do_numa_page to detect this
   and simply promote the page to allow writes.  Write faults will
   be expensive, but you'll have pretty strong guarantees around
   not unexpectedly running out of space.

   You can then loosen the .no_writable restriction with settings if
   you have high confidence that your system will outrun your ability
   to promote/evict/whatever if device memory becomes hot.

The only thing I don't know off hand is how shared pages will work in
this setup.  For VMAs with a mapping that exist at demotion time, this
all works wonderfully - less so if the mapping doesn't exist or a new
VMA is created after a demotion has occurred.

I don't know what will happen there.

I think this would also sate the desire for a "separate CXL allocator"
for integration into other paths as well.

~Gregory

