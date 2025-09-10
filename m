Return-Path: <linux-kernel+bounces-810605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7618B51CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511A2580215
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C4D334394;
	Wed, 10 Sep 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dh/bc1nJ"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59D322A1A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520122; cv=none; b=kL6ScyWtn2w1OYExATh3y5ydo0eWo93mslEjK+U4AGC5Lf7sttMRSbGMDRKwI9Mp8IL7If/lGWEMy1CCVDxlvCPmjiVybsmknINJJ2Zg8oBPC2r5a/zsEpSJM67qCgRV7t0tvWM+EfOmAJEDNKSAnTfGoZl7ue72l7sWhnAOyOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520122; c=relaxed/simple;
	bh=diqf2WHS4uFCSKZi+rbEJXRydCOz2vZxlmmtjMasFC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPK6lAJRwVjOEElxuAbvzILzbyMwxrYNfWBNxF6B7x+0g9V/Pyz15UDsR0wUfJsjWrxUyqoU7hhd5ouyPlzF7Dqn20XDijktt+F/OyFU1FuwoRwNPmQAbRqHxp58D1Y5a+WArDVFIDIuJiAjCM5M+ZV7F6XQXbgFFQgYm2eN2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dh/bc1nJ; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b6004da52bso37607941cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1757520119; x=1758124919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/afnfpJ1dm+2ZpXwedw1BE9/QEgEwYCYpGOT6Wej8o=;
        b=dh/bc1nJGTPsMxstWgD109ycMtzYSRr9IokiDwcgLqCZTMt8/uBxzYioT810gLAIaa
         xtZ63eHLbvKyakXasDRMWYU92o6dXK/7LPmcFGCZHwj2Ej9qP6tsxRgx452784YHprb+
         V0eWFJrSTXe4vDjZug/PLV5wTJD3rIEF4X/EhDkhnZ8u6EDHjKRlXWbLd8vS3vvn3mcv
         YKKlgBSFSQMwo6H0vg/sPyRK0F2Wjx7KU8CZ953fnC/G5MnGGOsAZeod6aYz/Nuw3/Gk
         z/dszlZTH9E2SOr8ITp8y3Q70ScJft1VeRMlAeUNFkeXJxNbbloA6ymErT1QMR5I93Et
         X2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520119; x=1758124919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/afnfpJ1dm+2ZpXwedw1BE9/QEgEwYCYpGOT6Wej8o=;
        b=RKaQOFbqFCcwSJ4lhoceN6Hb7uYkQ296y/4dDMPvecjSaM9bTOi4GEtyrO7sKnyGDj
         YVKjBoVZAehyEXfjoMVymFoykLekx7pYpIp9JfBxyJaXX/VniT79hOSe069fasv41KFt
         UCIoJIIsvteoYqQnXFp1/ArEXWGjKN/s3RM+EpwIT7XyZHHNlA6kvE+5Goy7UsWoJQGf
         FejT0TB276FuVum1i9+RXtm2cwj/HZuChzh4uk7YWfD6t+EbdRkHPgdrCmCtX5/+1lHo
         MWgupbZpUkbayl7okxube3tGhQqHREfO3M9TvkgbEYDO3FvH4IKpDEB8Ggp6esalUtKU
         gg4A==
X-Forwarded-Encrypted: i=1; AJvYcCV0tYW4apRZI/r6U/yts9lFpG0hc9nX7j4OHVcY3Wuuy7sy4Mt5lgFpPF5vLqUyJHVv1SJCm+XJBIyOoJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+NmmZpQ+oBX1ufIRh8nljM4CDoOSd+6fHDeK4eakHLWuDZSZF
	JVAXzOAvVYcDSA5dR51pYgKF7tkjgXcvEh6NtNHxiyFA+LfHDs4ltPc1Pw4p5JhOKmk=
X-Gm-Gg: ASbGnctupT9nSIU47jvpOOiCcjPPV2JA+xUe63du24PTBNWkTt5PuF822xY6jfwpBGa
	c6ihpw7nY/S0qP/KT0Ta8WHEL8Hja1Nsa6cPuJqJiRYiS/b3T2bDxgBAag0OaCSCCbrrUb7x5jT
	WtqEbVPfepU1lbHxzn1gfsavt+gV6LDarjezwTWHzqvxhOokdzT7bwTYEDcZ8GrxrotjLNHVxWx
	fhKLLKy0L2ruWE1ca1Zk5TNqkaKYONzAOLzydXkergrC7GMJuIiNH0WTka9FUC3ZC5i6Am6WG2Y
	NqsI4eo0t0Ypcsd8AljJyNtGldAj7nrFgwkeNxuea5PmFlKdTn8sq7zD2Y1kffk1DhJ7LkABkK5
	3z+yGrE1PwDU17Y5aaCQ=
X-Google-Smtp-Source: AGHT+IFytWxI65pFxb5OOUKBPPF2arzO2Er1TjGaTK1hyE5BuNsItzgl4tbugdmOVSzDn4Aay1Kk8Q==
X-Received: by 2002:a05:622a:17ce:b0:4b5:f800:49ce with SMTP id d75a77b69052e-4b5f858d84emr193745801cf.71.1757520118956;
        Wed, 10 Sep 2025 09:01:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::3:1704])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b61ba6edbesm26958781cf.4.2025.09.10.09.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:01:58 -0700 (PDT)
Date: Wed, 10 Sep 2025 12:01:56 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Jonathan.Cameron@huawei.com,
	dave.hansen@intel.com, hannes@cmpxchg.org,
	mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org,
	raghavendra.kt@amd.com, riel@surriel.com, rientjes@google.com,
	sj@kernel.org, weixugc@google.com, ying.huang@linux.alibaba.com,
	ziy@nvidia.com, dave@stgolabs.net, nifan.cxl@gmail.com,
	xuezhengchu@huawei.com, yiannis@zptcorp.com,
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com,
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com,
	balbirs@nvidia.com, alok.rathore@samsung.com
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
References: <20250910144653.212066-1-bharata@amd.com>
 <aMGbpDJhOx7wHqpo@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMGbpDJhOx7wHqpo@casper.infradead.org>

On Wed, Sep 10, 2025 at 04:39:16PM +0100, Matthew Wilcox wrote:
> On Wed, Sep 10, 2025 at 08:16:45PM +0530, Bharata B Rao wrote:
> > This patchset introduces a new subsystem for hot page tracking
> > and promotion (pghot) that consolidates memory access information
> > from various sources and enables centralized promotion of hot
> > pages across memory tiers.
> 
> Just to be clear, I continue to believe this is a terrible idea and we
> should not do this.  If systems will be built with CXL (and given the
> horrendous performance, I cannot see why they would be), the kernel
> should not be migrating memory around like this.

I've been considered this problem from the opposite approach since LSFMM.

Rather than decide how to move stuff around, what if instead we just
decide not to ever put certain classes of memory on CXL.  Right now, so
long as CXL is in the page allocator, it's the wild west - any page can
end up anywhere.

I have enough data now from ZONE_MOVABLE-only CXL deployments on real
workloads to show local CXL expansion is valuable and performant enough
to be worth deploying - but the key piece for me is that ZONE_MOVABLE
disallows GFP_KERNEL.  For example: this keeps SLAB meta-data out of 
CXL, but allows any given user-driven page allocation (including page
cache, file, and anon mappings) to land there.

I'm hoping to share some of this data in the coming months.

I've yet to see any strong indication that a complex hotness/movement
system is warranted (yet) - but that may simply be because we have
local cards with no switching involved. So far LRU-based promotion and
demotion has been sufficient.

It seems the closer to random-access the access pattern, the less
valuable ANY movement is. Which should be intuitive.  But, having
CXL beats touching disk every day of the week.

So I've become conflicted on this work - but only because I haven't seen
the data to suggest such complexity is warranted.

~Gregory

