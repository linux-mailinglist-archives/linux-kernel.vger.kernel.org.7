Return-Path: <linux-kernel+bounces-746820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A07AB12B99
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 19:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F4167AC220
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D16288511;
	Sat, 26 Jul 2025 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHJEnOlq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192F280B;
	Sat, 26 Jul 2025 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753550179; cv=none; b=tITVHca+z7gbQcbbf2aX+DUIcdB+Q51zA0jzFgt/WCXOZMxHHwzPSOSPOl2V0NM//7eSo8DA8X+GdpoLEBFeb8w8nT9JmJVx9pv6IpLfflMWViATapjnar6kjnzLU+zrzgcICHC+ECcDWv8p7BMtieKnZuKDq7NI6lJv3FGjhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753550179; c=relaxed/simple;
	bh=lJoV30Lp8jeFkrHdcpX9lFWnSAxypLwuqXIyL1i3Cz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzmoTXCe4edJOI0Y2SdrKm4fWPMyuJAjANEe8grCYml9AHjfXp60wJoYoRez2pmDSYeLUBvUcnSHOUyG5vJPf4aXT3dFE83G8M2c2wJG4O3bESEh1Kp9Ckauf2IrAiKlO6cXaIB+yLzpr9qAflD3LmjufOw83Jz4v94LQmkXCiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHJEnOlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A438C4CEED;
	Sat, 26 Jul 2025 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753550178;
	bh=lJoV30Lp8jeFkrHdcpX9lFWnSAxypLwuqXIyL1i3Cz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHJEnOlqIukFwK2kpQCRE/qZraohP2lhwc29t7If7eBUdDykZgnFgB5uYujezEj6T
	 gI5wjCBaV1/31W/THeDxjd9SXTsbjlUxJY552jkOkb9t3sC+j51k3uIPbMq7KqJXg/
	 KRiNpPLmXDkwKzlYHfX12ciC/ZnNLFI0Ikpu8n3eF0kD3w0HzqOM+CklYTkXOtjvbA
	 0Or7zIu9jQDF5g3S0HuOgvYWtVYTOAmIqNgDRRsBYcJ/uVdHCeiOKE8HBeXfoEEAtn
	 jW908qqMsgmnr2Q/7b8ChkyrqVK1scsxd5b+0xfGFb7ffp20ZE8jSJ6LjM1NlMIASR
	 34YnGnjqhVTVw==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	zuoze <zuoze1@huawei.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com
Subject: Re: [RFC PATCH] mm/damon: add full LPAE support for memory monitoring above 4GB
Date: Sat, 26 Jul 2025 10:16:16 -0700
Message-Id: <20250726171616.53704-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <527714dd-0e33-43ab-bbbd-d89670ba79e7@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Quanmin,

On Sat, 26 Jul 2025 11:14:19 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> 
> 在 2025/7/26 4:22, SeongJae Park 写道:
> > On Fri, 25 Jul 2025 11:15:22 +0800 zuoze <zuoze1@huawei.com> wrote:
> >
> >>
> >> 在 2025/4/23 1:43, SeongJae Park 写道:
> >>> On Tue, 22 Apr 2025 19:50:11 +0800 zuoze <zuoze1@huawei.com> wrote:
> >>>
> >>> [...]
> >>>> Thanks for the patches - I’ve noted the RFC series and user-space
> >>>> updates. Apologies for the delay; I’ll prioritize reviewing these soon
> >>>> to verify they meet the intended tracking goals. Appreciate your
> >>>> patience.
> >>> No worry.  Please take your time and let me know if there is anything I can
> >>> help.
> >>>
> >>> I think we can improve the user-space tool support better for usability.  For
> >>> example, it could find LPAE case, set addr_unit parameter, and convert
> >>> user-input and output address ranges on its own.  But hopefully the current
> >>> support allows simple tests of the kernel side change, and we could do such
> >>> improvement after the kernel side change is made.
> >>>
> >>>
> >> Hi SJ,
> >>
> >> Apologies for the delayed response. We've verified your patch in our
> >> environment and confirmed it supports LPAE address monitoring.
> > No worry, thank you for testing that :)
> >
> >> However,
> >> we observed some anomalies in the reclaim functionality. During code
> >> review, we identified a few issues:
> >>
> >> The semantic meaning of damon_region changed after addr_unit was
> >> introduced. The units in damon_addr_range may no longer represent bytes
> >> directly.
> > You're right, and this is an intended change.
> >
> >> The size returned by damon_sz_region() now requires multiplication by
> >> addr_unit to get the actual byte count.
> > Again, this is an intended change.  damon_sz_region() callers should aware this
> > semantic and updated accordingly, if it could make a real problem otherwise.
> > If you found such changes required cases that this patch series is missing,
> > could you please list up?
> >
> >> Heavy usage of damon_sz_region() and DAMON_MIN_REGION likely requires
> >> addr_unit-aware adjustments throughout the codebase. While this approach
> >> works, it would involve considerable changes.
> > It has been a while since I wrote this patch series, but at least while writing
> > it, I didn't find such required changes.  Of course I should missed something,
> > though.  As I mentioned above, could you please list such changes required
> > parts that makes problem?  That would be helpful at finding the path forward.
> >
> >> What's your perspective on
> >> how we should proceed?
> > Let's see the list of required additional changes with why those are required
> > (what problems can happen if such chadnges are not made), and discuss.
> 
> Hi SJ,
> 
> Thank you for your email reply. Let's discuss the impacts introduced after
> incorporating addr_unit. First of all, it's essential to clarify that the
> definition of damon_addr_range (in damon_region) has changed, we will now use
> damon_addr_range * addr_unit to calculate physical addresses.
> 
> I've noticed some issues, in mm/damon/core.c:
> 
>   damos_apply_scheme()
>       ...
>       unsigned long sz = damon_sz_region(r);  // the unit of 'sz' is no longer bytes.
>       ...
>       if (c->ops.apply_scheme)
>           if (quota->esz && quota->charged_sz + sz > quota->esz)
>               sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
>                       DAMON_MIN_REGION);  // the core issue lies here.
>           ...
>           quota->charged_sz += sz;    // note the units.
>       ...
>       update_stat:
>           // 'sz' should be multiplied by addr_unit:
>           damos_update_stat(s, sz, sz_applied, sz_ops_filter_passed);
> 
> Currently, DAMON_MIN_REGION is defined as PAGE_SIZE, therefore aligning
> sz downward to DAMON_MIN_REGION is likely unreasonable. Meanwhile, the unit
> of sz in damos_quota is also not bytes, which necessitates updates to comments
> and user documentation. Additionally, the calculation involving DAMON_MIN_REGION
> requires reconsideration. Here are a few examples:
> 
>   damos_skip_charged_region()
>       ...
>       sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
>                       r->ar.start, DAMON_MIN_REGION);
>       ...
>       if (damon_sz_region(r) <= DAMON_MIN_REGION)
>                       return true;
>       sz_to_skip = DAMON_MIN_REGION;
> 
>   damon_region_sz_limit()
>         ...
>       if (sz < DAMON_MIN_REGION)
>           sz = DAMON_MIN_REGION;

Thank you for this kind and detailed explanation of the issue!  I understand
adopting addr_unit would make DAMON_MINREGION 'addr_unit * 4096' bytes, and it
is not a desired result when 'addr_unit' is large.  For example, if 'addr_unit'
is set as 4096, the access monitoring and operation schemes will work in only
>16 MiB granularity at the best.

> 
> Now I can think of two approaches, one is to keep sz in bytes, this requires
> modifications to many other call sites that use these two functions (at least
> passing the corresponding ctx->addr_unit. By the way, should we restrict the
> input of addr_unit?):
> 
>   damos_apply_scheme()
>       ...
>   -    unsigned long sz = damon_sz_region(r);
>   +    unsigned long sz = damon_sz_region(r) * c->addr_unit;
>       ...
>   -    damon_split_region_at(t, r, sz);
>   +    damon_split_region_at(t, r, sz / c->addr_unit);
> 
> The second approach is to divide by addr_unit when applying DAMON_MIN_REGION,
> and revert to byte units for statistics, this approach seems to involve
> significant changes as well:
> 
>   damos_apply_scheme()
>       ...
>       sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
>   -                    DAMON_MIN_REGION);
>   +                    DAMON_MIN_REGION / c->addr_unit);
>       ...
>   update_stat:
>   -    damos_update_stat(s, sz, sz_applied, sz_ops_filter_passed);
>   +    damos_update_stat(s, sz, sz_applied * c->addr_unit, sz_ops_filter_passed);
> 
> These are my observations. What's your perspective on how we should proceed? Looking
> forward to your reply.

I think the second approach is better.  But I want to avoid changing every
DAMON_MIN_REGION usage.  What about changing DAMON_MIN_REGION as 'max(4096 /
addr_unit, 1)' instead?  Specifically, we can change DAMON_MIN_REGION from a
global macro value to per-context variable (a field of damon_ctx), and set it
accordingly when the parameters are set.

For stats, I think the users should aware of the fact DAMON is working with the
addr_unit, so they should multiply addr_unit to the stats to get bytes
information.  So, I think the stats update in kernel is not really required.
DAMON user-space tool may need to be updated accordingly, though.

I didn't take time to think about all corner cases, so I may missing something.
Please let me knwo if you find such missing things.


Thanks,
SJ

[...]

