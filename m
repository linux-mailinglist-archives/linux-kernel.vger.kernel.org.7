Return-Path: <linux-kernel+bounces-832667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDB4BA00DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA661C20D64
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E412DEA95;
	Thu, 25 Sep 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nHV54Mnj"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B652DCC04
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811285; cv=none; b=UJ0maN6fQGJG+ZDJggnQkExFGGClPGIpFfZnZP8UAYdyuD1hOf/6HBh1VvcFumLsKkweZjuVVLmcSM8LsPiZ5B8jjuliPuYyvsJzV9kp0J9J4Sd/X3w25E0xi0iJq2KXluTsH9PneK11sT6EmAw4GFx66UPpxF1D8kBtjp0NDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811285; c=relaxed/simple;
	bh=Mc98K+o9MyGVxxAKFc2LuzMV/0CYrG5WHVOS9huGLf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnHLtIShSDbDPx2KeuYiRGWUwg4jLm2rbyxdJszTKGSH8/lpaZydhUQFyx+4cCGuD+tImfxbGu8NfJ6WlIooHKGZ5ScatzDyAy9ugAGml42yTPOLQ3qFiS3E5ox0w5g40NUmhjJiFjGrJ7C2AI/QD2Uq9cVxm2A3QkSCpnaoVRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nHV54Mnj; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8f33dad2d7cso51812639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758811282; x=1759416082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MonnHrFBlLbKfxAqCg2RgfcciUCPzHDcG9rP4ZA+VFA=;
        b=nHV54MnjtluVXX0h0a9lLnWuDyWDsDJ4q+LfCDwegGpWAEo3tq13GV01Et/V3ypV+E
         v9jpXgCRG167t70wxgpQ8Ks24FHll7KMKlTqc0nEaU6JaGxQZA5Y9S5fmTQzTBwCSmmC
         OjHxrmYjad20DusFxwrlC33X/8kVR9jHoB1OtA0aqi7YSIeLf8UNvn1Dmh5bYSXFsSt4
         mXj3Hg+7psSu94VzvO4wA5IPUzYmJfvgt/bvb7iZUx6TtBge0S7h4poJiS0/nhD6a4Ft
         Ett4EcRmv7ipId/kvRpZeCAFTeEfheCo0et8ndVzjK7JWMl/LRDSCNpFT1X09IIs8qAr
         fKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758811282; x=1759416082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MonnHrFBlLbKfxAqCg2RgfcciUCPzHDcG9rP4ZA+VFA=;
        b=cXd2X0XJgtD2Lo8x1l/Hsl1DxzMk9pRqkzjRDxC2B8Y9GxXjMtWx/8TMEDUsg586os
         bLlQoTCsQgxzz3bgZbC/JsR8chegfqb+JwcEFCgAzcN5mjcr5fGtFPfF9h+ZpGrdcBUf
         nedkyjTEaT1WVXE9VQA7BAl6qiFBZI3IktSKV1hGA3PEJ6NBD8sDyeYIqdZbMmtS2a74
         4ALl5cmrjCinH3wMKLLRvM9P/Y1wHE/6cQ1UhDZxKaYmAG9gLg9e+Pis8N9VjXzQMZ4P
         iR+vulAZ81kTGk4wWjp+f6IEIthNXxTEC7208Nuo/BwPR+Uwp+sXiiBCqydjkctL+haH
         J09w==
X-Forwarded-Encrypted: i=1; AJvYcCVFWxn1shKnYNe2xuAsT50IdLNt2uew32b4CX0o2uT9+wMMLLISuIIIs2FpRSMLUnMT4mWR3dNVPVwCoEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1TwZ4rFSP5fZbVdmo32rnpWmflUhonpmQhabJmX+IY+QwkUR
	NBwJY303n8625AAQqDgQbs9mmzub2q1HouZ5tlGLPqhmITLmsapP8pdoEzNJpxD+arM=
X-Gm-Gg: ASbGncuPKi96vycrl8JkstDn7LdJHbC0Vzg/f5yCBHi118nrULwY9KmWZySEHqvhS/Z
	JyrECnRaWuj6t+vik1n0fPFsjSaOsQViyR+U+xqFnqpzYu/+jL5Ebu0hMXq9jfx6+Q5FIPFdLUz
	tY/8wwdYCfwnask5gO3+FEsye6Hj00A1KyxglcknkRVC2ECOooLsVqPvhRi8WswwO28WHOuR3O3
	8bOzT509frITjtkIRhSk439cRGVcaWCx0FhojeYiKHUhRHzUR5Y0M6RkaPGx4aBG/nH6VqGcy2M
	OWxEdflX+Z8f6oagiNUSnr3p7UwIegq0D74nQBnfdjyTkA2pl+7F+PzW8CTxlkOJtoSHDLjFqhj
	MEvMhsFtnOvya5S3whVEr5KJKM3mDSO8ChvzzkfUznLY/uWxXL5644SIeHdlWY+mn+GRU9Va2EL
	g=
X-Google-Smtp-Source: AGHT+IFTMmFL5XyKbSmyHPZUijAtEKCfXMRWWA8DP+zvHaZMXznIcTuoDIxLpn6A+DpNfM4CvL5RkA==
X-Received: by 2002:a05:6602:3427:b0:890:1f62:492c with SMTP id ca18e2360f4ac-90153366535mr509131239f.8.1758811282156;
        Thu, 25 Sep 2025 07:41:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (50-32-2-77.vng01.dlls.pa.frontiernet.net. [50.32.2.77])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6a5ae382sm875785173.64.2025.09.25.07.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 07:41:21 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:41:19 -0400
From: Gregory Price <gourry@gourry.net>
To: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
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
Message-ID: <aNVUj0s30rrXEh4C@gourry-fedora-PF4VCD3F>
References: <20250910144653.212066-1-bharata@amd.com>
 <aMGbpDJhOx7wHqpo@casper.infradead.org>
 <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
 <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
 <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
 <20250917174941.000061d3@huawei.com>
 <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>

On Thu, Sep 25, 2025 at 04:03:46PM +0200, Yiannis Nikolakopoulos wrote:
> > 
> > For the hardware compression devices how are you dealing with capacity variation
> > / overcommit?  
...
> What is different from standard tiering is that the control plane is
> checked on demotion to make sure there is still capacity left. If not, the
> demotion fails. While this seems stable so far, a missing piece is to
> ensure that this tier is mainly written by demotions and not arbitrary kernel
> allocations (at least as a starting point). I want to explore how mempolicies
> can help there, or something of the sort that Gregory described.
> 

Writing back the description as i understand it:

1) The intent is to only have this memory allocable via demotion
   (i.e. no fault or direct allocation from userland possible)

2) The intent is to still have this memory accessible directly (DMA),
   while compressed, not trigger a fault/promotion on access
   (i.e. no zswap faults)

3) The intent is to have an external monitoring software handle
   outrunning run-away decompression/hotness by promoting that data.

So basically we want a zswap-like interface for allocation, but to
retain the `struct page` in page tables such that no faults are incurred
on access.  Then if the page becomes hot, depend on some kind of HMU
tiering system to get it off the device.

I think we all understand there's some bear we have to outrun to deal
with problem #3 - and many of us are skeptical that the bear won't catch
up with our pants down.  Let's ignore this for the moment.

If such a device's memory is added to the default page allocator, then
the question becomes one of *isolation* - such that the kernel will
provide some "Capital-G Guarantee" that certain NUMA nodes will NEVER
be used except under very explicit scenarios.

There are only 3 mechanisms with which to restrict this (presently):

1) ZONE membership (to disallow GFP_KERNEL)
2) cgroups->cpusets->mems_allowed
3) task/vma mempolicy
(obvious #4: Don't put it in the default page allocator)

cpusets and mempolicy are not sufficient to provide full isolation
- cgroups have the opposite hierarchical relationship than desired.
  The parent cgroup will lock out all children cgroups from using nodes
  not present in the parent mems_allowed. e.g. if you lock out access
  from the root cgroup, no cgroup on the entire system is eligible to
  allocate the memory.  If you don't lock out the root cgroup - any root
  cgroup task is eligible.  This isn't tractible.

- task/vma mempolicy gets ignored in many cases and is closer to a
  suggestion than enforcible.  It's also subject to rebinding as a
  task's cgroups.cpuset.mems_allowed changes.

I haven't read up enough on ZONE_DEVICE to understand the implications
of membership there, but have you explored this as an option?  I don't
see the work i'm doing intersecting well with your efforts - except
maybe on the vmscan.c work around allocation on demotion.

The work i'm doing is more aligned with - hey, filesystems are a global
resource, why are we using cgroup/task/vma policies to dictate whether a
filesystem's cache is eligible to land in remote nodes? i.e. drawing
better boundaries and controls around what can land in some set of
remote nodes "by default".  You're looking for *strong isolation*
controls, which implies a different kind of allocator interface.

~Gregory

