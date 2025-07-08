Return-Path: <linux-kernel+bounces-722422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD94AFDA31
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073D31C26A7E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809C24501E;
	Tue,  8 Jul 2025 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugLTLrUk"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF1A1F3FED
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011535; cv=none; b=OfXARzOcgH/dLG5otcrrXD2FiYgQSaz96L/L+oavn6TjfVE001KYTifPQFjFXYc1XSXllVGf8zKART7iSsY5icPrvRfz2jq+97CB6zIYPXK8Hby4z5T7psfdWmGTSMhm8oYChxRnqjX50LFCYsHA7h2G/Vvg/rNDlRS28EjThZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011535; c=relaxed/simple;
	bh=ILmBq0z003tCR68DHLuQ5sTqApg9X/MvIGkGCvSMMYM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bLPIJvkUQRcqLo+CW0U+o8V9Z/G/lh7iUHswRzjbW/QdDn282j4+9RE1ZJAMIed7Lv771V3PDpKplgoUyBeCw2NnaXkNXG0GaP5XMFv2+Qe7uDZjat5PAMYXfzEq6/4/cZMpvgk0dWZJpQeAnGAb0MbMDsLQC5KVgIifzL9I2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugLTLrUk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23dd9ae5aacso27055ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 14:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752011533; x=1752616333; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFuaNm2ayRYoFvr6rcAXmSr+Jy2sCJau+JzQR/c3+dA=;
        b=ugLTLrUklBkvupQkW5E9Wd44SenJY3C/fvoa7Lp+Yw1KobTW1OXAP+5hqtUTdSCdyc
         EsrZd77UOPgGdeh+SPTytPCeWHLkoyZj7GGmK6NNL+FCmibbYz+y/xaO/MfV763nCB7+
         vZh4laLZ5Ewt41DSdScz95F9Aql3d9z5xN0Zns2HHy/HBCRStVYtODJPWmB4b4KxJj6h
         R3Qc6tgyNhlA+4BEQrFodghuq7MjLbA4wMPwAQBTtf2xPHdW8/vYMkSIdoD99d5IzaFH
         KzdH8eWF+6VaGAiwHsJ1uPbflFG+nIE27SPTp7Q42RyRhEawgaH7t2+vRDg1hK+bLQuy
         +ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752011533; x=1752616333;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFuaNm2ayRYoFvr6rcAXmSr+Jy2sCJau+JzQR/c3+dA=;
        b=Q2GEncmdXES43R9zKgQhnxrnQk2GcPVgoSuCKP/RmJm8n7IY+gBcyAuPg4YxAJZlLT
         kIUKMj+NCvrK64e/xLdV1kaWrNrHpy4nMvZLlc1LBz4ldMDu9phGSfOOKhuJtoQpjQQJ
         nXDdXv7OFxJAaoo8mEw1bZCKaUtK575iDdUlTXgASxu8kvdWeIVVZTvgmw0WK31bnqDu
         hate4pabCnrmNjgPRc5bvvbV7LQ8iY8lPDGYZp/UU+/sMr9qvgPbNbS72oLQznITdQNw
         kmhZ2hrNvcLB4DO6ofNkANA2/69+kJqAR+7uQOEeFbTJcm4BGqTqqYVv68GsiNby7KfG
         hEQw==
X-Forwarded-Encrypted: i=1; AJvYcCU3/uL6QqNAo9R1e5sS9AC0C2VnRwl+tWjJVls7hwmEMnV+LJLgauSdqxccSAO0nsus1RNyLzqS6krfVOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYBKPRZ2bk0ZRjA8hOppnxjgpCjNJ1A8Jdt/WOVvOm8G7ceCJK
	Z7/xpxHou8K+Q3XGtStfWR/3ARO9xEDMSnpeyh2rcPUePmU2p5QTpt+Dsl48sN/YoQ==
X-Gm-Gg: ASbGncthVgangvVKHEk384y0ia9DNrr+gDZwf1q8WoUGgqSH1mO8kqiXl9vUzk1iq2X
	YRBacPVowmjvRMNfBnXdBTeAWJcbw2YP+2TW8Yk9WLgbDxO62bnu4gaMZCHWleTlnLv2yA1tZVO
	hV0A4hwm3PQX3Y53Pi4Ygl+5VNxlItunSTmKF5AviNUlgzx2TJDSTGwgJ35jG98JIvgxHm2EVpf
	7tOfeG934rJ+AVohCMXr2ntqztJ5/QzIZ0k6eq0Yd3k6fYonawO1S7G1ARQNxUfe4ZZOIiewe8C
	YI+LhHxAOii31TGC9sytPkHWdqh7iPepn7V/DUBoq2QhMU1206H0VFv62HoGyd80u2lH5Ifb6Bv
	t/yjhY4aNq29Q1xSc8F8u4im8cDep403MJotVtjsHQkQShUhb1sw7wOBY
X-Google-Smtp-Source: AGHT+IF45OwGTEC5RF+KhmGbkBcBUddvRkcYc3wFn0dk9gCbzmXprk0zNoyYa2/0mobtR8fV6BB2Rg==
X-Received: by 2002:a17:903:19e6:b0:234:8eeb:d81a with SMTP id d9443c01a7336-23dda3c4955mr873735ad.16.1752011532837;
        Tue, 08 Jul 2025 14:52:12 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:d72c:f2e1:5256:5aa1] ([2a00:79e0:2eb0:8:d72c:f2e1:5256:5aa1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3003f9f9sm62518a91.5.2025.07.08.14.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:52:12 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:52:11 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
cc: Casey Chen <cachen@purestorage.com>, 
    Andrew Morton <akpm@linux-foundation.org>, surenb@google.com, 
    corbet@lwn.net, dennis@kernel.org, tj@kernel.org, cl@gentwo.org, 
    Vlastimil Babka <vbabka@suse.cz>, mhocko@suse.com, jackmanb@google.com, 
    hannes@cmpxchg.org, ziy@nvidia.com, roman.gushchin@linux.dev, 
    harry.yoo@oracle.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    linux-doc@vger.kernel.org, yzhong@purestorage.com, 
    Sourav Panda <souravpanda@google.com>
Subject: Re: [PATCH] alloc_tag: add per-NUMA node stats
In-Reply-To: <cvrr3u7n424dhroqi7essjm53kqrqjomatly2b7us4b6rymcox@3ttbatss6ypy>
Message-ID: <3c9b5773-83ed-4f13-11a8-fcc162c8c483@google.com>
References: <20250610233053.973796-1-cachen@purestorage.com> <cvrr3u7n424dhroqi7essjm53kqrqjomatly2b7us4b6rymcox@3ttbatss6ypy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Jun 2025, Kent Overstreet wrote:

> On Tue, Jun 10, 2025 at 05:30:53PM -0600, Casey Chen wrote:
> > Add support for tracking per-NUMA node statistics in /proc/allocinfo.
> > Previously, each alloc_tag had a single set of counters (bytes and
> > calls), aggregated across all CPUs. With this change, each CPU can
> > maintain separate counters for each NUMA node, allowing finer-grained
> > memory allocation profiling.
> > 
> > This feature is controlled by the new
> > CONFIG_MEM_ALLOC_PROFILING_PER_NUMA_STATS option:
> > 
> > * When enabled (=y), the output includes per-node statistics following
> >   the total bytes/calls:
> > 
> > <size> <calls> <tag info>
> > ...
> > 315456       9858     mm/dmapool.c:338 func:pool_alloc_page
> >         nid0     94912        2966
> >         nid1     220544       6892
> > 7680         60       mm/dmapool.c:254 func:dma_pool_create
> >         nid0     4224         33
> >         nid1     3456         27
> 
> I just received a report of memory reclaim issues where it seems DMA32
> is stuffed full.
> 
> So naturally, instrumenting to see what's consuming DMA32 is going to be
> the first thing to do, which made me think of your patchset.
> 
> I wonder if we should think about something a bit more general, so it's
> easy to break out accounting different ways depending on what we want to
> debug.
> 

Right, per-node memory attribution, or per zone, is very useful.

Casey, what's the latest status of your patch?  Using alloc_tag for 
attributing memory overheads has been exceedingly useful for Google Cloud 
and adding better insight it for per-node breakdown would be even better.  

Our use case is quite simple: we sell guest memory to the customer as 
persistent hugetlb and keep some memory on the host for ourselves (VMM, 
host userspace, host kernel).  We track every page of that overhead memory 
because memory pressure here can cause all sorts of issues like userspace 
unresponsiveness.  We also want to sell as much guest memory as possible 
to avoid stranding cpus.

To do that, per-node breakdown of memory allocations would be a tremendous 
help.  We have memory that is asymmetric for NUMA, even for memory that 
has affinity to the NIC.  Being able to inspect the origins of memory for 
a specific NUMA node that is under memory pressure where other NUMA nodes 
are not under memory pressure would be excellent.

Adding Sourav Panda as well as he may have additional thoughts on this.

