Return-Path: <linux-kernel+bounces-754881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0554B19DF8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D173BAA9C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2086823D294;
	Mon,  4 Aug 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVsqgoRF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F223BD13
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297397; cv=none; b=QDaSqxHi18RFshXzQZWSFvsKkeTgTergHfwcw2LLsy572rXjJON2zPL6mHAnBgrqUd+l6hPTQ0/vdKbl6+upZVHdN6vP8LfxHuF6qQE7VqrS7Zlik1niFbNrje1wFfCaG/b5qc2HnJQtK3UDOoCj71cV7/1tnq5BQGdzvekDae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297397; c=relaxed/simple;
	bh=OE8DCHLkOjXraIy9L8Rlx5syMeADjgWTJOCY9F+7ouM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWTg0gqu/nFJtHIWZuwyGVFKMNxGIq+k5xucSbRXYVnpp86goHJ5K/geoqyYXi57zdDQvCusPWkMvKo0U3e0I+XZeRLYOsqgAa7I8/wsz44HFQnlcngl+UUyKMEElhoGuFSKWzcW32DKJwZBEWE77t2zpwZH5ckQcMdaQMpO51U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVsqgoRF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754297396; x=1785833396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OE8DCHLkOjXraIy9L8Rlx5syMeADjgWTJOCY9F+7ouM=;
  b=kVsqgoRFp5kJ/ez1+3ifWpGlJBb8HJhKK/TIRrAL4iTGZuTRMQpKnr+B
   cckPU+J2JL/4X1770pJkhCWrY/rJWqv9+2e2Rp56VjgXFMjqSybpKxUsb
   Q4Hgh1aB2kNOWS6rg4SfzWHPsGqC1lf+SJ1oSPdlrO8DLXmCWGOkNDcYK
   9SaVcPgBpuCjjMnUZRnvX22cIXZBlyRvRAmdLSYk/5QPNt7UBaRcIpY/9
   gbPycvIyRC1MCTPwgZ1CdHIK3FmXrPCrXQZQqoWjEXBNOIYcU+d0WQ8AP
   tV3V93wj5yKaogtUu8gvdBkRCPEynJkNWMzppZpkixKlTUAt/y7PZVTmn
   A==;
X-CSE-ConnectionGUID: lgtWjeoOTmqTxb4OjwscNA==
X-CSE-MsgGUID: v1j0gHn7TFuDyXek2LcM8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="82002472"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="82002472"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:49:51 -0700
X-CSE-ConnectionGUID: /1A55KLXQ4eC/wnpkngSSw==
X-CSE-MsgGUID: Fy/qhbotSmCMeWPChw5yrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="194937262"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.53])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:49:48 -0700
Date: Mon, 4 Aug 2025 16:49:45 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, Barry Song <21cnbao@gmail.com>,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>, yi1.lai@intel.com
Subject: Re: [PATCH v4] mm: use per_vma lock for MADV_DONTNEED
Message-ID: <aJB0Kdc6cx1lGkdb@ly-workstation>
References: <20250607220150.2980-1-21cnbao@gmail.com>
 <aJAFrYfyzGpbm+0m@ly-workstation>
 <1d1d97f9-2a67-4920-850e-accf4c82440e@redhat.com>
 <4fa8f492-c7ef-451c-8dc7-38b031c8a092@bytedance.com>
 <d9d0890e-2837-49dc-9ca8-1d6c28e95a21@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9d0890e-2837-49dc-9ca8-1d6c28e95a21@redhat.com>

On Mon, Aug 04, 2025 at 10:30:45AM +0200, David Hildenbrand wrote:
> On 04.08.25 10:26, Qi Zheng wrote:
> > 
> > 
> > On 8/4/25 3:57 PM, David Hildenbrand wrote:
> > > On 04.08.25 02:58, Lai, Yi wrote:
> > > > Hi Barry Song,
> > > > 
> > > > Greetings!
> > > > 
> > > > I used Syzkaller and found that there is general protection fault in
> > > > __pte_offset_map_lock in linux-next next-20250801.
> > > > 
> > > > After bisection and the first bad commit is:
> > > > "
> > > > a6fde7add78d mm: use per_vma lock for MADV_DONTNEED
> > > > "
> > > > 
> > > > All detailed into can be found at:
> > > > https://github.com/laifryiee/syzkaller_logs/tree/
> > > > main/250803_193026___pte_offset_map_lock
> > > > Syzkaller repro code:
> > > > https://github.com/laifryiee/syzkaller_logs/tree/
> > > > main/250803_193026___pte_offset_map_lock/repro.c
> > > > Syzkaller repro syscall steps:
> > > > https://github.com/laifryiee/syzkaller_logs/tree/
> > > > main/250803_193026___pte_offset_map_lock/repro.prog
> > > > Syzkaller report:
> > > > https://github.com/laifryiee/syzkaller_logs/tree/
> > > > main/250803_193026___pte_offset_map_lock/repro.report
> > > > Kconfig(make olddefconfig):
> > > > https://github.com/laifryiee/syzkaller_logs/tree/
> > > > main/250803_193026___pte_offset_map_lock/kconfig_origin
> > > > Bisect info:
> > > > https://github.com/laifryiee/syzkaller_logs/tree/
> > > > main/250803_193026___pte_offset_map_lock/bisect_info.log
> > > > bzImage:
> > > > https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/
> > > > main/250803_193026___pte_offset_map_lock/bzImage_next-20250801
> > > > Issue dmesg:
> > > > https://github.com/laifryiee/syzkaller_logs/blob/
> > > > main/250803_193026___pte_offset_map_lock/next-20250801_dmesg.log
> > > 
> > > Skimming over the reproducer, we seem to have racing MADV_DONTNEED and
> > > MADV_COLLAPSE on the same anon area, but the problem only shows up once
> > > we tear down that MM.
> > > 
> > > If I would have to guess, I'd assume it's related to PT_RECLAIM
> > > reclaiming empty page tables during MADV_DONTNEED -- but the kconfig
> > > does not indicate that CONFIG_PT_RECLAIM was set.
> > 
> > On the x86_64, if PT_RECLAIM is not manually disabled, PT_RECLAIM should
> > be enabled
> 
> That's what I thought: but I was not able to spot it in the provided config
> [1].
> 
> Or is that config *before* "make olfconfig"? confusing. I would want to see
> the actually used config.
> 
> 
>
My kernel compiling steps:
1. copy kconfig_origin to kernel_source_folder/.config
2. make olddefconfig
3. make bzImage -jx

I have also uploaded the actual .config during compiling. 
[2] https://github.com/laifryiee/syzkaller_logs/blob/main/250803_193026___pte_offset_map_lock/.config
CONFIG_ARCH_SUPPORTS_PT_RECLAIM=y
CONFIG_PT_RECLAIM=y
 
> [1] https://github.com/laifryiee/syzkaller_logs/tree/main/250803_193026___pte_offset_map_lock/kconfig_origin
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

