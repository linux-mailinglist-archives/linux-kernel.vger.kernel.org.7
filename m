Return-Path: <linux-kernel+bounces-754591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE80BB199D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C79174ECD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 01:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854E01EA7CC;
	Mon,  4 Aug 2025 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="esVDAqRU"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422AB29A1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 01:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754270701; cv=none; b=IPJunCOkieipwiWxGjipWho6MkHl6nDg8nteF12zwr9OmmrmsaVDwdgFzutPbNu8t9BuNlo5ykrWERTWVHq5fCr0RurpXfS9NhoaNeoVA5BtFVsIPGT/s4vPiApFBG+ZAZaOp03JxzNIOXSiyAhRPKcoV3mSBqFQqrHG8VbKokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754270701; c=relaxed/simple;
	bh=lBe1qSPgw4QXHHXslrEpP7PMufdFdef2wPoqFmROmfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xf+ea6QfotFkL5sXhcJ3n2clu9FyBJXmOxPxPmFIMD96HmzOsA08A2ZfqjbUyqr6maNuGQWCM+tcTrrE+CwPzGtCkUMe6qKM4IG4gJmvTBrRqaSgStDrbnTS/sd5/gfe1fPVxtn7C5vflFkfxuY44itAaNgixckJ0hziObOCkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=esVDAqRU; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754270690; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=ngPeLVtN22D10xiauIRgXoZxyNy5qt56LuaZTotpsjc=;
	b=esVDAqRUhaIPgt+gG1YHdtiyWSYezMhYmIZVHLFSXCYfDaPOx01vswWJWOLL1WW6K8Qjz/CsLfVVt9QcOXu3LbuUQvn9dXnqur1AILk7s14aBQwypQVs0oZeIuqK/y6ceP3ZzqS/e6fxUBuOQTadHgQGsWGMX7lEkwxXkUUfC5c=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WktIPnF_1754270672 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Aug 2025 09:24:48 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  SeongJae Park
 <sj@kernel.org>,  David Hildenbrand <david@redhat.com>,  Zi Yan
 <ziy@nvidia.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Brost
 <matthew.brost@intel.com>,  Rakie Kim <rakie.kim@sk.com>,  Byungchul Park
 <byungchul@sk.com>,  Gregory Price <gourry@gourry.net>,  Alistair Popple
 <apopple@nvidia.com>,  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  kernel-team@meta.com
Subject: Re: [PATCH v2] mempolicy: Clarify what zone reclaim means
In-Reply-To: <20250801144840.2067350-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Fri, 1 Aug 2025 07:48:39 -0700")
References: <20250801144840.2067350-1-joshua.hahnjy@gmail.com>
Date: Mon, 04 Aug 2025 09:24:31 +0800
Message-ID: <8734a7zxo0.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Fri, 01 Aug 2025 08:59:20 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>
>> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>> 
>> > The zone_reclaim_mode API controls the reclaim behavior when a node runs out of
>> > memory. Contrary to its user-facing name, it is internally referred to as
>> > "node_reclaim_mode".
>> >
>> > This can be confusing. But because we cannot change the name of the API since
>> > it has been in place since at least 2.6, let's try to be more explicit about
>> > what the behavior of this API is. 
>> >
>> > Change the description to clarify what zone reclaim entails, and be explicit
>> > about the RECLAIM_ZONE bit, whose purpose has led to some confusion in the
>> > past already [1] [2].
>> >
>> > [1] https://lore.kernel.org/linux-mm/1579005573-58923-1-git-send-email-alex.shi@linux.alibaba.com/
>> > [2] https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.intel.com/
>> >
>> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>> > ---
>> >  include/uapi/linux/mempolicy.h | 8 +++++++-
>> >  1 file changed, 7 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
>> > index 1f9bb10d1a47..6c9c9385ff89 100644
>> > --- a/include/uapi/linux/mempolicy.h
>> > +++ b/include/uapi/linux/mempolicy.h
>> > @@ -66,10 +66,16 @@ enum {
>> >  #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
>> >  
>> >  /*
>> > + * Enabling zone reclaim means the page allocator will attempt to fulfill
>> > + * the allocation request on the current node by triggering reclaim and
>> > + * trying to shrink the current node.
>> > + * Fallback allocations on the next candidates in the zonelist are considered
>> > + * zone when reclaim fails to free up enough memory in the current node/zone.
>> > + *
>> >   * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
>> >   * ABI.  New bits are OK, but existing bits can never change.
>> 
>> As far as I know, sysctl isn't considered kernel ABI now.  So, cghane
>> this line too?
>
> Hi Ying, 
>
> Thank you for reviewing this patch!
>
> I didn't know that sysctl isn't considered a kernel ABI. If I understand your
> suggestion correctly, I can rephrase the comment block above to something like this?
>
> - * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
> - * ABI. New bits are OK, but existing bits can never change.
> + * These bit locations are exposed in the vm.zone_reclaim_mode sysctl and
> + * in /proc/sys/vm/zone_reclaim_mode. New bits are OK, but existing bits
> + * can never change.

Because it's not an ABI, I think that we could avoid to say "never".

> Thanks again for your review Ying, I hope you have a good day : -)

Welcome!  You too!

With some trivial tweak, please feel free to add my

Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>

in the future version.

---
Best Regards,
Huang, Ying

