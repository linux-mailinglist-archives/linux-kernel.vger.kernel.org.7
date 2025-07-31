Return-Path: <linux-kernel+bounces-751488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A30B16A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F705A7D11
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCFC130A54;
	Thu, 31 Jul 2025 01:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iW3lBMCI"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA910785
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753926566; cv=none; b=panlDayheIwWWyTSrU4hpYYNQhzbCiDYlC2bA1nF/l7bwbFAG3gnJ5+Tr9X8lKxGTR2gR6nny2ZUPvWL9or/uDATAb/G+b2CmMJhmxToCCzF54Dy6zrPibWPPApLxgDq4USUq3JKsRLiNv36+5IgjZl0+/Us+VArS/30HWhl6Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753926566; c=relaxed/simple;
	bh=tNPiBujisFHb997GEtpT9Y1QYvcWujeiJOwyNJVXRM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B5TOcsc3IKtPx6nqVlIZiNsXx0DCtDnG7pAuFEFNKP0B4XtjuTzx8q73+Gh5/SBWwh+VG+c+T2iTshckSojS5wYFQONv98Yjnv1tLo9X1i9o1GnjRIgtkTFVrONl79e071gTfsykOW6+HDG/3bB1PPhGbTI/9QpSY0zqhKnjOxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iW3lBMCI; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753926556; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=FoVQBKqrO0J50OdfYlBRAT9heWx+qni6PljTTrIPCl4=;
	b=iW3lBMCIEhMek+VOvbjIDEjTYOw0ONTDHCRWEH0PPO6TpKzfcP5lOyrQ8ival9oZLFvgFTzkQKtJ94IiOhjxL0qQw1+sdOVsrfob8wQMmg6oSx32PnIbCXH1HOlF3He2Hh80wtc+ML2/JJainzcedKXNkImmQkOVJKz+9u+sHqI=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WkWQwrt_1753926535 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 09:49:14 +0800
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
In-Reply-To: <20250730201908.2395933-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Wed, 30 Jul 2025 13:19:07 -0700")
References: <20250730201908.2395933-1-joshua.hahnjy@gmail.com>
Date: Thu, 31 Jul 2025 09:48:54 +0800
Message-ID: <87tt2t9lkp.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Tue, 29 Jul 2025 08:58:49 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>
>> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>> 
>> > On Mon, 28 Jul 2025 09:44:06 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>> >
>> >> Hi, Joshua,
>> >> 
>> >> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>> >> 
>> >> > The zone_reclaim_mode API controls reclaim behavior when a node runs out of
>> >> > memory. Contrary to its user-facing name, it is internally referred to as
>> >> > "node_reclaim_mode". This is slightly confusing but there is not much we can
>> >> > do given that it has already been exposed to userspace (since at least 2.6).
>> >> >
>> >> > However, what we can do is to make sure the internal description of what the
>> >> > bits inside zone_reclaim_mode aligns with what it does in practice.
>> >> > Setting RECLAIM_ZONE does indeed run shrink_inactive_list, but a more holistic
>> >> > description would be to explain that zone reclaim modulates whether page
>> >> > allocation (and khugepaged collapsing) prefers reclaiming & attempting to
>> >> > allocate locally or should fall back to the next node in the zonelist.
>> >> >
>> >> > Change the description to clarify what zone reclaim entails.
>> >> >
>> >> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>> >> > ---
>> >> >  include/uapi/linux/mempolicy.h | 2 +-
>> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
>> >> > index 1f9bb10d1a47..24083809d920 100644
>> >> > --- a/include/uapi/linux/mempolicy.h
>> >> > +++ b/include/uapi/linux/mempolicy.h
>> >> > @@ -69,7 +69,7 @@ enum {
>> >> >   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
>> >> >   * ABI.  New bits are OK, but existing bits can never change.
>> >> >   */
>> >> > -#define RECLAIM_ZONE	(1<<0)	/* Run shrink_inactive_list on the zone */
>> >> > +#define RECLAIM_ZONE	(1<<0)	/* Prefer reclaiming & allocating locally */
>> >> >  #define RECLAIM_WRITE	(1<<1)	/* Writeout pages during reclaim */
>> >> >  #define RECLAIM_UNMAP	(1<<2)	/* Unmap pages during reclaim */
>> >> >  
>> >> >
>> >> > base-commit: 25fae0b93d1d7ddb25958bcb90c3c0e5e0e202bd
>> >
>> > Hi Ying, thanks for your review, as always!
>> >
>> >> Please consider the document of zone_reclaim_mode in
>> >> Documentation/admin-guide/sysctl/vm.rst too.
>> >
>> > Yes, will do. Along with SJ's comment, I think that the information in the
>> > admin-guide should be sufficient enough to explain what these bits do, so
>> > I think my patch is not very necessary.
>> >
>> >> And, IIUC, RECLAIM_ZONE doesn't mean "locally" exactly.  It's legal to
>> >> bind to some node other than "local node".
>> >
>> > You are correct, it seems you can also reclaim on non-local nodes once you
>> > go further down in the zonelist. I think my intent with the new comment was just
>> > to indicate a preference to reclaim and allocate on the *current* node, as
>> > opposed to falling back to the next node in the zonelist.
>> >
>> > With that said, I think your comment along with SJ's feedback have gotten me
>> > to understand that we proably don't need this change : -) 
>> 
>> TBH, I think that it's good to make some change to the comments.
>> Because IMHO, the original comments are bound to some specific
>> implementation details.  Some more general words may be better for the
>> user space API description.
>
> Hi Ying, sorry for the late reply.
>
> I think that is a good point. Then maybe in that case, we can take SJ's comment
> and leave information about both the implementation detail (i.e. that it will
> perform shrink inactive_list on the zone), and that it will prefer this over
> allocating on the next node as a general description of what happens?

Yes.  Something like this, or

Try to reclaim in the current node/zone before allocating on the fallback.

> On that note, one thing that I felt was slightly undercaptured in
> Documentation/admin-guide is what "zone reclaim" actually means. What it does
> is of course well captured by its name, but it misses the nuance of preferring
> reclaim over fallback allocation.
>
> Actually the whole motivation behind all of this conversation is because I saw
> zone reclaim preventing allocation into a second node in a 2-NUMA node system
> and was a bit confused until I understood what the implication of having
> zone reclaim was.

Yes.  It's good to improve the document.  If it makes you confusing, it
may make others confusing too.

> Anyways, I can probably spin the patch to include information about what
> zone reclaim is, in the comment block above the bits.
>
> But please feel free to correct me if you feel that the descriptions available
> in both the mempolicy.h uapi file or the Documentation/admin-guide is already
> enough.

Thanks for doing this.

---
Best Regards,
Huang, Ying

