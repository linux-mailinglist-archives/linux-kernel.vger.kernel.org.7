Return-Path: <linux-kernel+bounces-819492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA00B5A196
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDF9487733
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2D11E98F3;
	Tue, 16 Sep 2025 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JcLDBl8v"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909E1E7C2E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051957; cv=none; b=LRACDdXGwlI4lBQB8K7fxW4Okt8Dghz6H5FBbgH2WtdFnX6zfpbwDNvC/UziF1ARt3ci+Xbu5e28A2p+jqDMQQUtByHr6Oh5osGG/1dm58L3uCKcNgt+5XxyJltW5XbBdDdcJ67XhrQp/UPOAcNMP0Tyy2oABRFsEAMMAew+Cuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051957; c=relaxed/simple;
	bh=TWGxZ3L+V7o5P7pz8r6SN4KRp51T4ZDSL281NwsdtsA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QpPrlw0vharKOTGCdpbD361nVq6SJm6Gq+WtyNembH14y1yBxXdOdWggh4d0ClGroiVslyPIddtlfNIklqKm0BhXNv06u1DrXiML49CXSlcUXwCqLbPDxyRdBSNodDAOkcplTCryX9b29jBJDo+x5FnZL+AVmhud7yMaTRtiZJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JcLDBl8v; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-267c90c426dso7265ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758051955; x=1758656755; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WXM3OherOxXkqWIyrsQ9zL8fL1brdbQvLSDZy9IQvPI=;
        b=JcLDBl8vVRWhtWSDHANdgK67oqZn8O+p3m6zBWSAQP/mM57hcEEw56yIEvSX7xGz/g
         ZkNK8+iuS9mnr4H/4VR5C39aV9ehvh98VHSTqEd57oQSqY9pHPyO5oNBgzBFqiVCmM6F
         xSSES6lV41/fRIi1vMVDzXMc4vy9+tD0ZTV2GRWMQEo4oiQz3XUo+gwo1GSsdGOzb9XI
         jnCFU5N77T+rBwRALwFmY00oelDf9quNDtnHlzw0i5xiMthUK7naf2P7e01LooG0u6ah
         zCWA33wJcQhBPo1Q+6W46jU3pHKluHA3jO0EgVFvDrLUeDr3olnjBlcDincd+Uv1wudY
         4F9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758051955; x=1758656755;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXM3OherOxXkqWIyrsQ9zL8fL1brdbQvLSDZy9IQvPI=;
        b=uR8kaE7SvnqiJsRe3HT1ihI+h0dElGCCqxx5mL8YEhijFBzPLKrYQhIl6vyzTBvP7s
         4UgVZF25ExLuEZMlBlrzi6B7C5w+1GDIqn+RMAEYTHn/qhyKtbAf8pensHJNxrFpOFmu
         dalHlU3wK2S3q8UgJVZITrDW4Ko8Gu6P2fGfrD0wmclYxUzQjx/ca8sdD41/hDs8eqGs
         u1kZ0a8xuVFo49TfttJ3nYjVOA96AcB8kczdK6TZF9nZjV4YMzroAKW1GjiiOFkj2K8H
         r+v+HjSThqmuVv+enFqtknNonTxvWMsaYo1SVk0xMuDQtQQzOQFQo563oUkdn7oNMPO0
         jp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDnNxA/HbdQEisMx1Eu7lKuHOytYsvC+66403jWbLAZH/W1YGJXMnCd8p+/ELQ6Q/MOGKA4LQyLpBwA8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dPh02mOdnCs2FVRIIYvhd65OBlxXPjiBWSKjUfCG3cBAe3A3
	bLmGGl6DIy7qEYHXIT0bnkDqC5Z4k6f5TGIuRLpgFF5CTRZSocxaMjH3z98OPGxphA==
X-Gm-Gg: ASbGnctcESN3BuZS+K+McdP0Qn4F6MuZ2Txo7ajvV0aQYC9TRsqHu5bHq04YxfxqbKN
	9Za2DpH24Aeo6x4gDobNF/6gNDVw+kgiNpuoZ9VbyfO0hKG7rK5u9SllFtsyi4dCcEomlnLDw1h
	LgOd22kwOXha43uBcK7byl3EpKgsO0B7EJZEf3cOJilWZoylU7VWHNycyZ+9BkDQHxmKuz6oYS8
	AaglG+R5I124IyvawK3SShp4PF9ViTMSFfxSLzfE2CVu85TB1yMpC6cC/T6wVGcnWgJkuZoED2G
	21yWa/rlxmWgzz0Xsm4eKDS2JxuEOxlPlBW/tHodvMA2WVpj5/3g3y/WDUL3rT/7v0j9Trarm39
	0hXRaWmSZPahdWzDn0YgiHtrStPILiJj0ETYtTclXgP+HxYTvRfW24c92rqQc7Rw4IUSmdxiKOX
	vmMn4PNJwb5o8lbX2aoio990UuBdJ5nP4ezi56jkm7OXfINEH6YiNs1G4=
X-Google-Smtp-Source: AGHT+IGjPGu9s+AIR2l3SAAz572RtyzuJretv9YBUb86Qie1/rNMrtg4jD6x3++QZ4cS6ZRI4s1Hjg==
X-Received: by 2002:a17:902:d4c2:b0:248:a039:b6e3 with SMTP id d9443c01a7336-26800f661e8mr985795ad.10.1758051954838;
        Tue, 16 Sep 2025 12:45:54 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:3226:ed0a:4c73:99d2] ([2a00:79e0:2eb0:8:3226:ed0a:4c73:99d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651ca217d2sm79165505ad.43.2025.09.16.12.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 12:45:53 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:45:52 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Gregory Price <gourry@gourry.net>
cc: Matthew Wilcox <willy@infradead.org>, Bharata B Rao <bharata@amd.com>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    Jonathan.Cameron@huawei.com, dave.hansen@intel.com, hannes@cmpxchg.org, 
    mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org, 
    raghavendra.kt@amd.com, riel@surriel.com, sj@kernel.org, 
    weixugc@google.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
    dave@stgolabs.net, nifan.cxl@gmail.com, xuezhengchu@huawei.com, 
    yiannis@zptcorp.com, akpm@linux-foundation.org, david@redhat.com, 
    byungchul@sk.com, kinseyho@google.com, joshua.hahnjy@gmail.com, 
    yuanchu@google.com, balbirs@nvidia.com, alok.rathore@samsung.com
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
In-Reply-To: <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
Message-ID: <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
References: <20250910144653.212066-1-bharata@amd.com> <aMGbpDJhOx7wHqpo@casper.infradead.org> <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Sep 2025, Gregory Price wrote:

> On Wed, Sep 10, 2025 at 04:39:16PM +0100, Matthew Wilcox wrote:
> > On Wed, Sep 10, 2025 at 08:16:45PM +0530, Bharata B Rao wrote:
> > > This patchset introduces a new subsystem for hot page tracking
> > > and promotion (pghot) that consolidates memory access information
> > > from various sources and enables centralized promotion of hot
> > > pages across memory tiers.
> > 
> > Just to be clear, I continue to believe this is a terrible idea and we
> > should not do this.  If systems will be built with CXL (and given the
> > horrendous performance, I cannot see why they would be), the kernel
> > should not be migrating memory around like this.
> 
> I've been considered this problem from the opposite approach since LSFMM.
> 
> Rather than decide how to move stuff around, what if instead we just
> decide not to ever put certain classes of memory on CXL.  Right now, so
> long as CXL is in the page allocator, it's the wild west - any page can
> end up anywhere.
> 
> I have enough data now from ZONE_MOVABLE-only CXL deployments on real
> workloads to show local CXL expansion is valuable and performant enough
> to be worth deploying - but the key piece for me is that ZONE_MOVABLE
> disallows GFP_KERNEL.  For example: this keeps SLAB meta-data out of 
> CXL, but allows any given user-driven page allocation (including page
> cache, file, and anon mappings) to land there.
> 

This is similar to our use case, although the direct allocation can be 
controlled by cpusets or mempolicies as needed depending on the memory 
access latency required for the workload; nothing new there, though, it's 
the same argument as NUMA in general and the abstraction of these far 
memory nodes as separate NUMA nodes makes this very straightforward.

> I'm hoping to share some of this data in the coming months.
> 
> I've yet to see any strong indication that a complex hotness/movement
> system is warranted (yet) - but that may simply be because we have
> local cards with no switching involved. So far LRU-based promotion and
> demotion has been sufficient.
> 

To me, this is a key point.  As we've discussed in meetings, we're in the 
early days here.  The CHMU does provide a lot of flexibility, both to 
create very good and very bad hotness trackers.  But I think the key point 
is that we have multiple sources of hotness information depending on the 
platform and some of these sources only make sense for the kernel (or a 
BPF offload) to maintain as the source of truth.  Some of these sources 
will be clear-on-read so only one entity would be possible to have as the 
source of truth of page hotness.

I've been pretty focused on the promotion story here rather than demotion 
because of how responsive it needs to be.  Harvesting the page table 
accessed bits or waiting on a sliding window through NUMA Balancing (even 
NUMAB=2) is not as responsive as needed for very fast promotion to top 
tier memory, hence things like the CHMU (or PEBS or IBS etc).

A few things that I think we need to discuss and align on:

 - the kernel as the source of truth for all memory hotness information,
   which can then be abstracted and used for multiple downstream purposes,
   memory tiering only being one of them

 - the long-term plan for NUMAB=2 and memory tiering support in the kernel
   in general, are we planning on supporting this through NUMA hint faults
   forever despite their drawbacks (too slow, too much overhead for KVM)

 - the role of the kernel vs userspace in driving the memory migration;
   lots of discussion on hardware assists that can be leveraged for memory
   migration but today the balancing is driven in process context.  The
   kthread as the driver of migration is yet to be a sold argument, but 
   are where a number of companies are currently looking

There's also some feature support that is possible with these CXL memory 
expansion devices that have started to pop up in labs that can also 
drastically reduce overall TCO.  Perhaps Wei Xu, cc'd, will be able to 
chime in as well.

This topic seems due for an alignment session as well, so will look to get 
that scheduled in the coming weeks if people are up for it.

> It seems the closer to random-access the access pattern, the less
> valuable ANY movement is. Which should be intuitive.  But, having
> CXL beats touching disk every day of the week.
> 
> So I've become conflicted on this work - but only because I haven't seen
> the data to suggest such complexity is warranted.
> 
> ~Gregory
> 

