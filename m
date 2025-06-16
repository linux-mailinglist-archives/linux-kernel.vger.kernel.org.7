Return-Path: <linux-kernel+bounces-688115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5B1ADADD5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 12:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8782A188E3CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DBE29B8CE;
	Mon, 16 Jun 2025 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BaOhuSjW"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D426FA5E;
	Mon, 16 Jun 2025 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750071342; cv=none; b=NyLrJQUuGhMY5z+XhUS5cv3qFVEvHJiMiG84IQYnCzHsJhh8RMIt6wgoFZqlWTJh6JMknd02mTb/8ReyVnQL4sg2KU41XVVsaKZ8spQptZiMF3Ba2tHqjHaYDvKOXDnxx9KsPU7si5BL8KLDTbZKRh42FMrLUVqzWWAbdZb8Oyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750071342; c=relaxed/simple;
	bh=aDoIFUDPbKlkZs2LaI4PiAZe0ItSZiaPAXg5nePkjDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gTHyJ3+y5dBXUaWQFR7CwJnyd6KaB8Xj9Krt4eKojTHUVkSM1x1W6IsD4d16hRrH9svFvXqgmRaRj+6cV5+MmFiE1eASKIeHwEDzT4OdJiKut17Gi+8BY6R+WpTORYLpDsaOJQ8WWzpihov5I1+SYm4nuOeUjdD+oWiHlKRPiX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BaOhuSjW; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750071336; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=i8EdbzyYXZcEWHaoQ9QBBBH1FZsnTBo/AD39uza65v0=;
	b=BaOhuSjWV2CRDTzhpmjBaK/4xbXSSvO9tMNMleL/tVkUBnw8CMQeBDW8X6ChHLz8dFt8EvhI+hfN3COW2tBNagx8BBfQnl8PycM3h8nEwV1s9i64r+UW9Lgfxuf5MyW/r1MjFvYJbFAsO0yvVLj8BA3E1YDsuMrCpTYxqaSfPR4=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WdwwWRd_1750071334 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Jun 2025 18:55:34 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,  sj@kernel.org,
  akpm@linux-foundation.org,  corbet@lwn.net,  ziy@nvidia.com,
  matthew.brost@intel.com,  joshua.hahnjy@gmail.com,  rakie.kim@sk.com,
  byungchul@sk.com,  gourry@gourry.net,  apopple@nvidia.com,
  bijantabatab@micron.com,  venkataravis@micron.com,  emirakhur@micron.com,
  ajayjoshi@micron.com,  vtavarespetr@micron.com,  damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/4] mm/mempolicy: Expose policy_nodemask() in
 include/linux/mempolicy.h
In-Reply-To: <CAMvvPS5U8exSvy0fknfhv8ym_dKgMVa7cfMOqn0fGyd+NSjSuQ@mail.gmail.com>
	(Bijan Tabatabai's message of "Fri, 13 Jun 2025 11:33:18 -0500")
References: <20250612181330.31236-1-bijan311@gmail.com>
	<20250612181330.31236-2-bijan311@gmail.com>
	<5a50eeba-b26d-4913-8016-45278608a1ee@redhat.com>
	<CAMvvPS5U8exSvy0fknfhv8ym_dKgMVa7cfMOqn0fGyd+NSjSuQ@mail.gmail.com>
Date: Mon, 16 Jun 2025 18:55:32 +0800
Message-ID: <87zfe83qhn.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bijan Tabatabai <bijan311@gmail.com> writes:

> On Fri, Jun 13, 2025 at 8:45=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
>>
>> On 12.06.25 20:13, Bijan Tabatabai wrote:
>> > From: Bijan Tabatabai <bijantabatab@micron.com>
>> >
>> > This patch is to allow DAMON to call policy_nodemask() so it can
>> > determine where to place a page for interleaving.
>> >
>> > Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
>> > ---
>> >   include/linux/mempolicy.h | 9 +++++++++
>> >   mm/mempolicy.c            | 4 +---
>> >   2 files changed, 10 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
>> > index 0fe96f3ab3ef..e96bf493ff7a 100644
>> > --- a/include/linux/mempolicy.h
>> > +++ b/include/linux/mempolicy.h
>> > @@ -133,6 +133,8 @@ struct mempolicy *__get_vma_policy(struct vm_area_=
struct *vma,
>> >   struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
>> >               unsigned long addr, int order, pgoff_t *ilx);
>> >   bool vma_policy_mof(struct vm_area_struct *vma);
>> > +nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
>> > +             pgoff_t ilx, int *nid);
>> >
>> >   extern void numa_default_policy(void);
>> >   extern void numa_policy_init(void);
>> > @@ -232,6 +234,13 @@ static inline struct mempolicy *get_vma_policy(st=
ruct vm_area_struct *vma,
>> >       return NULL;
>> >   }
>> >
>> > +static inline nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy=
 *pol,
>> > +                             pgoff_t ilx, int *nid)
>> > +{
>> > +     *nid =3D NUMA_NO_NODE;
>> > +     return NULL;
>> > +}
>> > +
>> >   static inline int
>> >   vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *ds=
t)
>> >   {
>> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> > index 3b1dfd08338b..54f539497e20 100644
>> > --- a/mm/mempolicy.c
>> > +++ b/mm/mempolicy.c
>> > @@ -596,8 +596,6 @@ static const struct mempolicy_operations mpol_ops[=
MPOL_MAX] =3D {
>> >
>> >   static bool migrate_folio_add(struct folio *folio, struct list_head =
*foliolist,
>> >                               unsigned long flags);
>> > -static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
>> > -                             pgoff_t ilx, int *nid);
>> >
>> >   static bool strictly_unmovable(unsigned long flags)
>> >   {
>> > @@ -2195,7 +2193,7 @@ static unsigned int interleave_nid(struct mempol=
icy *pol, pgoff_t ilx)
>> >    * Return a nodemask representing a mempolicy for filtering nodes for
>> >    * page allocation, together with preferred node id (or the input no=
de id).
>> >    */
>> > -static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
>> > +nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
>> >                                  pgoff_t ilx, int *nid)
>> >   {
>> >       nodemask_t *nodemask =3D NULL;
>>
>> You actually only care about the nid for your use case.
>>
>> Maybe we should add
>>
>> get_vma_policy_node() that internally does a get_vma_policy() to then
>> give you only the node back.
>>
>> If get_vma_policy() is not the right thing (see my reply to patch #2),
>> of course a get_task_policy_node() could be added.
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>
> Hi David,
>
> I did not use get_vma_policy or mpol_misplaced, which I believe is the
> closest function that exists for what I want in this patch, because
> those functions
> seem to assume they are called inside of the task that the folio/vma
> is mapped to.
> More specifically, mpol_misplaced assumes it is being called within a
> page fault.
> This doesn't work for us, because we call it inside of a kdamond process.
>
> I would be open to adding a new function that takes in a folio, vma,
> address, and
> task_struct and returns the nid the folio should be placed on. It could p=
ossibly
> be implemented as a function internal to mpol_misplaced because the two w=
ould
> be very similar.
>
> How would you propose we handle MPOL_BIND and MPOL_PREFFERED_MANY
> in this function? mpol_misplaced chooses a nid based on the node and
> cpu the fault
> occurred on, which we wouldn't have in a kdamond context. The two options=
 I see
> are either:
> 1. return the nid of the first node in the policy's nodemask
> 2. return NUMA_NO_NODE
> I think I would lean towards the first.

You can try numa_node_id() first, then fall back to the first nid in
the nodemask.

---
Best Regards,
Huang, Ying

