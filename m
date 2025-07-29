Return-Path: <linux-kernel+bounces-748739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E87B1457E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5CA7A1A47
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309DC17CA17;
	Tue, 29 Jul 2025 00:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xrwEEQVv"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F4A36D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 00:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753750738; cv=none; b=V1XvSRnFTv2g6ZbMYQQJB5NCqSjbtHfXbXUDv0cDtod06aH2Pnx8qCZHL+/G3M+sfXUU0zLtBQ1WvwPd282mW7zcLDkXKOREoPEoZyITzZhZ7cWbIXOR54Xdh6eGn0FljtvakMiATGrafJV4y1DYXD88Is/FGKWDdrNiGa1tvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753750738; c=relaxed/simple;
	bh=iRKluoG0ORmSSDqjWR4ijvki4535P/pxscuVsTiBCVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZevEo7WdUdtPaL81whOiTcJKLZL92sxcoXIRXnoP6QhWzne/oDvZZ8bqxFCGuGoxbinCJdOWgtsV5u6GgWnSg+rtqFK0KuXj/huLlE9ECLiiZ7nuXXZES7/Vp2IGxbVH/G/hagw7NNyh2uO5GO0i8MYoCOfAeAdXAeWMg/w+/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xrwEEQVv; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753750733; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=8sHiU/z1+EfhzcvKq8hAl8DbAdb9A/SIystch4PdxfY=;
	b=xrwEEQVve1hdA7jvf2x78zvLftnNc7oSXsyb08K9sz45qxTk2ofcEPWhyoPpJeDrT+N44ncLGhT+xbJp5jShxIgeFj3RViQ4oE8x4y+rebetnn2ZvgGsKDWVOP49ReOwi5MxMNJioIqkUD/gJRN6JAmvNxfF8/GMjbKdPu/8zfM=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WkNec9L_1753750730 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Jul 2025 08:58:50 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Zi Yan
 <ziy@nvidia.com>,  Matthew Brost <matthew.brost@intel.com>,  Rakie Kim
 <rakie.kim@sk.com>,  Byungchul Park <byungchul@sk.com>,  Gregory Price
 <gourry@gourry.net>,  Alistair Popple <apopple@nvidia.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  kernel-team@meta.com,
 Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] mempolicy: Clarify what RECLAIM_ZONE means
In-Reply-To: <20250728145109.1524733-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Mon, 28 Jul 2025 07:51:07 -0700")
References: <20250728145109.1524733-1-joshua.hahnjy@gmail.com>
Date: Tue, 29 Jul 2025 08:58:49 +0800
Message-ID: <87tt2v24om.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Mon, 28 Jul 2025 09:44:06 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>
>> Hi, Joshua,
>> 
>> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>> 
>> > The zone_reclaim_mode API controls reclaim behavior when a node runs out of
>> > memory. Contrary to its user-facing name, it is internally referred to as
>> > "node_reclaim_mode". This is slightly confusing but there is not much we can
>> > do given that it has already been exposed to userspace (since at least 2.6).
>> >
>> > However, what we can do is to make sure the internal description of what the
>> > bits inside zone_reclaim_mode aligns with what it does in practice.
>> > Setting RECLAIM_ZONE does indeed run shrink_inactive_list, but a more holistic
>> > description would be to explain that zone reclaim modulates whether page
>> > allocation (and khugepaged collapsing) prefers reclaiming & attempting to
>> > allocate locally or should fall back to the next node in the zonelist.
>> >
>> > Change the description to clarify what zone reclaim entails.
>> >
>> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>> > ---
>> >  include/uapi/linux/mempolicy.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
>> > index 1f9bb10d1a47..24083809d920 100644
>> > --- a/include/uapi/linux/mempolicy.h
>> > +++ b/include/uapi/linux/mempolicy.h
>> > @@ -69,7 +69,7 @@ enum {
>> >   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
>> >   * ABI.  New bits are OK, but existing bits can never change.
>> >   */
>> > -#define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
>> > +#define RECLAIM_ZONE	(1<<0)	/* Prefer reclaiming & allocating locally */
>> >  #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
>> >  #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
>> >  
>> >
>> > base-commit: 25fae0b93d1d7ddb25958bcb90c3c0e5e0e202bd
>
> Hi Ying, thanks for your review, as always!
>
>> Please consider the document of zone_reclaim_mode in
>> Documentation/admin-guide/sysctl/vm.rst too.
>
> Yes, will do. Along with SJ's comment, I think that the information in the
> admin-guide should be sufficient enough to explain what these bits do, so
> I think my patch is not very necessary.
>
>> And, IIUC, RECLAIM_ZONE doesn't mean "locally" exactly.  It's legal to
>> bind to some node other than "local node".
>
> You are correct, it seems you can also reclaim on non-local nodes once you
> go further down in the zonelist. I think my intent with the new comment was just
> to indicate a preference to reclaim and allocate on the *current* node, as
> opposed to falling back to the next node in the zonelist.
>
> With that said, I think your comment along with SJ's feedback have gotten me
> to understand that we proably don't need this change : -) 

TBH, I think that it's good to make some change to the comments.
Because IMHO, the original comments are bound to some specific
implementation details.  Some more general words may be better for the
user space API description.

---
Best Regards,
Huang, Ying

