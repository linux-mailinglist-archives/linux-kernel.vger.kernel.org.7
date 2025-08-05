Return-Path: <linux-kernel+bounces-755804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D326B1ABFF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 03:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE67618A063F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A368199FB2;
	Tue,  5 Aug 2025 01:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fwKIOlub"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB4A41
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 01:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357269; cv=none; b=OoVlds9CgV8UhBFE3V1RcVvyca9reCniEkiisSmMw+yxc8lm1WtSmeYAvNpj/Bl972QqwWCXosqkaXV+gTMGkltcEQ1i82BTkbbU7LlnkaCWpeqOpT5AHS0a9sdv5oAemxANcJMLaicAd3VsUlojBIpCqCi9z1EgCi1MPUt9K1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357269; c=relaxed/simple;
	bh=W2v63slmJvMHXUswWSRGoeuuZo+HwtzUVbRQ0WVTVKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k3+owOSd8g3xL0mM1fN3XutCgErZ0MRDcf9FXQc+D1OH2Xq0I/8AZQbXEad1M6UOkBSRRcqXJOvI99uKrLj9veI7dOZvXktGFSX0yhHleEQqas0M7l5IErZfqASF2zAOujsm0nfAqsDqZvF76CyqX3zMTOnSgE8jA2ESYmsnm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fwKIOlub; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754357264; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=cZXKId3PeNNKVOXuI9328ERbsEKYr4cnkti2rofiC30=;
	b=fwKIOlubHlVY0IM0L5d0jWgAW+W2vDZexJ4mXa+mlMeiZncTdZq4aBCHiI6nBGdcMCZIngnqQaaL7iQn89osxYyuWO9/yDrJE6a0ZW0oy/6O0RzixYTNlcNEfEeR9qBgyjjDOXbQaBUpe8NPjlgXAvjylTGX9WAlYjbXgY8anWs=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wl3-62P_1754357262 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 09:27:43 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  SeongJae Park
 <sj@kernel.org>,  David Hildenbrand <david@redhat.com>,  Zi Yan
 <ziy@nvidia.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Brost
 <matthew.brost@intel.com>,  Rakie Kim <rakie.kim@sk.com>,  Byungchul Park
 <byungchul@sk.com>,  Gregory Price <gourry@gourry.net>,  Alistair Popple
 <apopple@nvidia.com>,  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  kernel-team@meta.com, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] mempolicy: Clarify what zone reclaim means
In-Reply-To: <20250804144200.1047918-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Mon, 4 Aug 2025 07:41:59 -0700")
References: <20250804144200.1047918-1-joshua.hahnjy@gmail.com>
Date: Tue, 05 Aug 2025 09:27:30 +0800
Message-ID: <871ppqy2v1.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Mon, 04 Aug 2025 09:24:31 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>
>> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>> 
>> > On Fri, 01 Aug 2025 08:59:20 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>> >
>> >> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>> >> 
>> >> > The zone_reclaim_mode API controls the reclaim behavior when a node runs out of
>> >> > memory. Contrary to its user-facing name, it is internally referred to as
>> >> > "node_reclaim_mode".
>> >> >
>> >> > This can be confusing. But because we cannot change the name of the API since
>> >> > it has been in place since at least 2.6, let's try to be more explicit about
>> >> > what the behavior of this API is. 
>> >> >
>> >> > Change the description to clarify what zone reclaim entails, and be explicit
>> >> > about the RECLAIM_ZONE bit, whose purpose has led to some confusion in the
>> >> > past already [1] [2].
>> >> >
>> >> > [1] https://lore.kernel.org/linux-mm/1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com/
>> >> > [2] https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.intel.com/
>> >> >
>> >> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>> >> > ---
>> >> >  include/uapi/linux/mempolicy.h | 8 +++++++-
>> >> >  1 file changed, 7 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
>> >> > index 1f9bb10d1a47..6c9c9385ff89 100644
>> >> > --- a/include/uapi/linux/mempolicy.h
>> >> > +++ b/include/uapi/linux/mempolicy.h
>> >> > @@ -66,10 +66,16 @@ enum {
>> >> >  #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
>> >> >  
>> >> >  /*
>> >> > + * Enabling zone reclaim means the page allocator will attempt to fulfill
>> >> > + * the allocation request on the current node by triggering reclaim and
>> >> > + * trying to shrink the current node.
>> >> > + * Fallback allocations on the next candidates in the zonelist are considered
>> >> > + * zone when reclaim fails to free up enough memory in the current node/zone.
>> >> > + *
>> >> >   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
>> >> >   * ABI.  New bits are OK, but existing bits can never change.
>> >> 
>> >> As far as I know, sysctl isn't considered kernel ABI now.  So, cghane
>> >> this line too?
>> >
>> > Hi Ying, 
>> >
>> > Thank you for reviewing this patch!
>> >
>> > I didn't know that sysctl isn't considered a kernel ABI. If I understand your
>> > suggestion correctly, I can rephrase the comment block above to something like this?
>> >
>> > - * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
>> > - * ABI. New bits are OK, but existing bits can never change.
>> > + * These bit locations are exposed in the vm.zone_reclaim_mode sysctl and
>> > + * in /proc/sys/vm/zone_reclaim_mode. New bits are OK, but existing bits
>> > + * can never change.
>
> Hi Ying,
>
>> Because it's not an ABI, I think that we could avoid to say "never".
>
> My personal opinion is that we should keep this warning, since there has
> already been an example before where a developer tried to remove this bit [1],
> and this broke some behavior for userspace configurations. However, if I
> understand your comment correctly, you are suggesting that we should change
> the wording to not include "never", since sysctls are no longer an ABI (and
> therefore we should be OK to change what the values mean?)
>
> If that is the case, then I can send in another patch since I think the goals
> are a bit different for the two patches. With that said, I think we should
> keep the warning just to avoid any breakages in userspace, even if sysctl
> might not be considered an ABI anymore (also I must have missed this, I didn't
> know this at all!)

Sorry for confusing.  I agree that we shouldn't change the sysctl
interface in most cases.  I just thought that we could soften the
wording a little?  For example,

New bits are OK, but existing bits shouldn't be changed.

I think that it's still clear that we don't want to change the existing
bits.

However, my English is poor.  So, my suggestion may not make sense.

>> > Thanks again for your review Ying, I hope you have a good day : -)
>> 
>> Welcome!  You too!
>> 
>> With some trivial tweak, please feel free to add my
>> 
>> Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
>> 
>> in the future version.
>
> Thank you for your review Ying! Since there is a question remaining about what
> to do with the "never" statement, I will wait to send out a v3 with your
> review : -) 

---
Best Regards,
Huang, Ying

