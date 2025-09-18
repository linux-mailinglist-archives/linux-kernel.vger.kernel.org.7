Return-Path: <linux-kernel+bounces-795380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 270F0B3F111
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 00:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F75207528
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49912848A3;
	Mon,  1 Sep 2025 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opyj0/Bq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F1B283FD6
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756766463; cv=none; b=ToeaIX+J8Os9Ymz1ycb6lKpToSCtjpOyDIAasjhrd63XlVDbUlhgRzLvU26AP1CeZFDUFDwEFuCfIH9oEHwi8P1wD7dU3Q2mSoWXPMvVtIvikJoUypn468QWnp/7o64iodZzCZ9xiyzWR1wwGQmMcxVyQ6okNOGJ90aTLxby/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756766463; c=relaxed/simple;
	bh=Af/9QyPAaEGsBy3Mf7hLLR240GCKXs8yf+ZTaNNKgus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsBeTo0KllCcYz1Jjjj5e9MLJFF1YyvMjXn3zcnP1WxedcY5eQAHIon5F/zPkk6ysR4yzQ4ZMucd5ETF/NHg3FI2oBskmyXJ9i1ds1KepuMCTb5wPBEE/XC8BjNeEpwAImZ5aSye6BLqcbDxy/5rUvIrBmXaiTZr5jB7qGg8izM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opyj0/Bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696F2C19422
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 22:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756766463;
	bh=Af/9QyPAaEGsBy3Mf7hLLR240GCKXs8yf+ZTaNNKgus=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=opyj0/BqDxV/lFg/Dptg0hl37DhZX1YYJr1SOtGbNiCfShhgqsT7Ki2nhpFfPg8pp
	 oazpBNw5B2tAg2S+Nslfc8f26RdeFvBSXbfmY2quHTHg8IOHNYixn4+dz1AZMC8Gfp
	 d1Xf5g8UtLazP226hS83NDAVaPLqQYUQQzfLNL0MpPM6t6WItpikwaAfYe+wWn0VFk
	 A9k/WAP5W8nATN4WcOb+UgcGBijVkFDZTZFuhaikod+/zJXi2KWDi2JZw8IiUHJBJ7
	 FweqrdCVpW/PyhW99mwmqxZwW6hxkw9PJ2cyvx8Lt/6ajbe9CMK+TkCSzP5yLK1rQF
	 uf86cs5o6R94A==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d60504bf8so41626207b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 15:41:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhQvGf4PB7PKWixNasItVu+FOfEjzHmd4Nyi9CYrhPkDtMvw9b8WsaYJeltVBhFfR0RkI+Z4OVaUHXNTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY904DKYzQmija9klUuLJTSENGcNDObFYQew2xK99alaaQituh
	bXXaMuL6skMRdpcrvugKdptTPl2KvwPxsm5BtEjM4BIw/HBcQm38CB+ONk0tmy4guyEikqMdBpV
	9skwkqfR5dEn3rJJW8u0hNCRVGbtp/MQG9GuaDbpE8w==
X-Google-Smtp-Source: AGHT+IFVroHuTFPOhi9USxJ6LMi8EqfJgrxL1vb2WylLE59Wf27SaWmiCeRQp7qEdcTavfaT7csVCkC+3A5Y6N34AiE=
X-Received: by 2002:a05:690c:9a87:b0:71f:e430:6673 with SMTP id
 00721157ae682-7227651257cmr113081807b3.26.1756766462278; Mon, 01 Sep 2025
 15:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330> <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>
 <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330> <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
 <aK2vIdU0szcu7smP@yjaykim-PowerEdge-T330> <CACePvbUJSk23sH01msPcNiiiYw7JqWq_7xP1C7iBUN81nxJ36Q@mail.gmail.com>
 <aLJ4fEWo7V9Xsz15@yjaykim-PowerEdge-T330> <CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com>
 <aLRTyWJN60WEu/3q@yjaykim-PowerEdge-T330> <CACePvbVu7-s1BbXDD4Xk+vBk7my0hef5MBkecg1Vs6CBHMAm3g@mail.gmail.com>
 <aLXEkRAGmTlTGeQO@yjaykim-PowerEdge-T330>
In-Reply-To: <aLXEkRAGmTlTGeQO@yjaykim-PowerEdge-T330>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 1 Sep 2025 15:40:51 -0700
X-Gmail-Original-Message-ID: <CACePvbXAXbxqRi3_OoiSJKVs0dzuC-021AVaTkE3XOSx7FWvXQ@mail.gmail.com>
X-Gm-Features: Ac12FXwI2LcCOhohruUFtyvJ4kUoeFS6V52W5x2TBr7ixcpLeC2ZZjBMOo0gpfA
Message-ID: <CACePvbXAXbxqRi3_OoiSJKVs0dzuC-021AVaTkE3XOSx7FWvXQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/swap, memcg: Introduce infrastructure for
 cgroup-based swap priority
To: YoungJun Park <youngjun.park@lge.com>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, gunho.lee@lge.com, 
	iamjoonsoo.kim@lge.com, taejoon.song@lge.com, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:21=E2=80=AFAM YoungJun Park <youngjun.park@lge.com=
> wrote:
>
> Overall, the alignment looks good. Among the three points you suggested,
> I agree with (3) cgroup inheritance. I would like to continue the
> discussion on (1) swap tier lifecycle and (2) allocation logic.

Sure.

>
> 1. swap tier lifecycle
> 2. allocation logic
> 3. cgroup inheritance
>
> > > This part relates to my earlier point on runtime modification. My
> > > intention was to only allow setting the tiers globally, and to align
> > > bitmask with priority ranges. For example, an input like:
> > >
> > >   ssd:100, hdd:50, network_swap
> > >
> > > would translate into ranges as 100+ (bit0), 50=E2=80=9399 (bit1), and=
 0=E2=80=9349
> > > (bit2).
> > >
> > > From your description, I understand you are considering allowing
> > > additive updates, insertions and letting bitmask differ from the rang=
e priority. Is
> > > that correct? In that case we probably need a way to distinguish
> >
> > That is right.
>
> Yes, I agree that add/remove semantics can be supported,
> But it was not fully clear whether there was agreement on the full set
> format, I wanted to state explicitly that my preference is to require
> the full set format for simplicity. That said, if staged insertion and
> removal are considered useful, one possible approach is:
>
> (side note! explanation of the interface was somewhat
> descriptive, which may not have been fully clear. If this explanation is
> sufficient to establish the general direction, I will aim to present it
> more concretely in the patch series. Otherwise, I can provide a more
> detailed explanation in a follow-up email.)
>
>   echo "add ssd:100,hdd:50,network_swap" >/sys/kernel/mm/swap/tiers
Yes, that works. I would skip the "add" keyword.
Also I notice that we can allow " " in place of "," as a separator as well.
Let's call it option 1).

>   echo "add new:80"  > /sys/kernel/mm/swap/tiers
>   echo "remove hdd" > /sys/kernel/mm/swap/tiers

Maybe instead of "remove hdd", just "-hdd" which is similar to how to
operate on swap.tiers.

>
> Alternatively, separate files for add, remove, and show could be used to
> represent staged operations:
>
>   echo "ssd:100,hdd:50,network_swap" >/sys/kernel/mm/swap/tiers/add
>   echo "new:80"  > /sys/kernel/mm/swap/tiers/add
>   echo "hdd" > /sys/kernel/mm/swap/tiers/remove

Let's call it option 2)
I feel that we don't need to have both add and remove interface files.
The above use just one file is simpler. I like the above option 1)
with modification: skip "add" keyboard and use "-" to replace "remove"
keyword. I can give more examples if needed.

Don't like option 2).

> When using the fullset approach:
>
>   ssd:100(bit0), hdd:50(bit1), network_device(bit2)

Oh, the fullset you mean you want to specify the bit for the tier name.
Why? The bit selection can happen automatically thus reducing the
change users give to an invalid bit value, e.g. that bit is already
used. Please educate me what usage case you do need to specify the
bits while auto bit selection is not good enough?

> If we remove the ssd layer and add a new tier:
>
>   echo new:80,hdd:50,network_device >/sys/kernel/mm/swap/tiers

Option 3), full set specification.

Oh, you mean the tier not listed in the above will be deleted.
I prefer the above option 1) then.

Notice there is race when you remove stuff, there will be newly added
the tier can be accidentally removed as well. Again, what is the usage
case you can't do with option 1)?

> The show output could display staged state (imaginary output for understa=
nding):
>
>   ssd:100(bit0), new:80(bit3, in stage), hdd:50(bit1, removing), network_=
device(bit2)

I don't understand what is this "removing" and "in stage", that is
some extra complexity.
What is it trying to solve?

>
> After the hdd tier reference drops to zero:

Drop to zero, how? By swap off or expecting the app using the swap
exits or fault in all swapped pages in that tier?

>
>   ssd:100(bit0), new:80(bit3),  network_device(bit2)

For display we can also make each tier take one line at a time.

>
> > > between =E2=80=9Cadd=E2=80=9D and =E2=80=9Creset=E2=80=9D. Personally=
, I feel supporting only reset
> > > semantics would make the interface simpler, while still allowing add
> > > semantics when the full set is provided again.
> >
> > The counterpart of "add" is "remove". There are two possible ideas to e=
xplore:
> > 1) only allow removing a tier when all swap devices in that tier
> > range have been swapped off.
> > 2) Remove the tier by removing a midpoint from the range. The lower
> > tier automatically gets the range belonging to the tier that was
> > removed. Optionally, you can add another tier back in replacement
> > with different range boundaries. This effectively achieves replacement
> > as well. This approach does not require swapping off the swap device. I
> > like it better. If you want to avoid the race window where the
> > swap device temporarily belongs to the lower tier, you can always swap
> > off the device before performing 2). So 2) can be mixed with 1) as well=
.
>
> I have already explained this from the perspective of option 2 mixed
> with option 1. Let me clarify one point:
>
> If...
> ssd:100, hdd:50, network_device.
> Insertion above 100 becomes visible after ssd removal,

What do you mean by "visible"? Previous discussions haven't defined
what is visible vs invisible. If you use a new term, please define it.
Is visible available to add a new tier on?

> Insertion above 50 becomes visible after hdd removal,
> Insertion above 0 becomes visible after network_device removal.
>
> It means that as long as the tier exists, the referenced priority ranges
> cannot be overridden.
>
> And Regarding swap_tier object lifecycle:
>
> A swap_tier should not be deleted until all devices in the tier are
> swapped off (As you said, references are held). Therefore, cgroups that r=
eference a
> tier should also hold a reference. Silently dropping a tier is problemati=
c
> from a cgroup perspective.

Nope, that is too much reference to track. Each swap device belongs to
only one tier at a time. The swap device will have a pointer or bit
mask of that tier and bump up that tier's reference count when a swap
device swaps on.

> If we allow this, the implementation should behave as follows as I think:
> If a swap_tier is removed, the cgroup=E2=80=99s tier configuration could =
be
> marked invalid. This should trigger an event to the cgroup to notify
> user space.

Trigger event to notify user space? Who consumes the event and what
can that user space tool do? That seems to be the extra complexity we
should avoid. Just stick with the swap off behavior. If you remove the
swap tier. the range of that tier merges to the neighbour tier.  That
way you don't need to worry about the swap file already having an
entry in this tier you swap out.

Please don't keep proposing new interfaces for the sake of it. Try to
get the feature done with an absolutely minimal interface introduced.

> > > > > 2. Slow path allocation uses bitmask skipping; fast path uses per=
-cpu
> > > > >    tier cluster caches.
> > > > If the fast path fails, it will go through the slow path. So the sl=
ow
> > > > patch is actually a catch all.
> > >
> > > Do you mean that if the cluster does not belong to the desired tier i=
n
> > > the fast path, it will skip and then fall back to the slow path? If s=
o,
> >
> > I am describing the existing swap cluster allocator behavior. In my
> > mind, we are using the existing cluster swap allocator code, with
> > constraints that only allow swap entry to be allocated from the
> > affected tier bitmask.
> >
> > > the slow path would need to avoid inserting the cluster back into the
> > > cache, otherwise processes with a global swap view may end up using t=
he
> > > wrong tier device(which must be referenced firstly assumed)
> > > Also cgroup which is tier set experience performance degradation
> > > because, there is possibility to try to alloc swap on slowpath most o=
f the time.
> > > Wouldn=E2=80=99t this have performance implications?
> >
> > I think we are mixing two different concepts. There are swap tiers
> > which decide which swap device to use. Then there is the swap
> > allocator to allocate a swap from the allowed list.
> >
> > If we move to the swap tiers, the swap allocator needs to be swap
> > tiers aware. So it might move to per-cgroup cache list or disable the
> > cache for cgroups that haven't been allocating for a while. The
> > allocation logic should be in the allocator, not in the swap tier
> > layer.
> >
> > > I was thinking that maintaining per-tier per-cpu cluster caches would=
 be
> > > simpler. Then each tier manages its own cluster cache, and we only ne=
ed
> > > an array of per-cpu caches of size =E2=80=9Cmax tiers=E2=80=9D.
> >
> > Again, let's not jump to premature optimizations. Do it the simple way
> > first, then let the measurement numbers guide us.
> > It might be per swap file has a cache not necessary per CPU. per-cpu x
> > per-tier the combination is too big, I am worried about caching too
> > much swap clusters. Each cluster is 2M.
>
> You suggested maintaining per-swap-device cluster caches. As an
> alternative, I would like to suggest a per-device per-CPU cache
> approach, which could be simpler from an integration perspective. It

Each device belongs to one tier, that is the same number as per tier x
per cpu or even more. You might end up catching too many clusters.
Morden server has a very high cpu count. I would stay away per CPU if
I can afford it or find other solutions. Per cpu x another high number
is just a liability waiting for bad things to happen.

> would fit more naturally with the existing allocation logic, remove tier
> awareness from the allocator, and should not introduce functional

The current swap allocator is using a per CPU cluster cache. That
cached cluster is only going to belong to one swap device. When the
swap tier is introduced, the swap allocator behavior needs to be
changed anyway. Because we don't have to "fill this device full"
before moving to the next device.

> differences in behavior. Moreover, since SSD devices are likely to be
> concentrated in only a small number of tiers (with one being the "best"
> tier), the number of clusters actually cached at any time would not be
> large. I am not presenting this as the ultimate solution, but rather as
> a simple and reasonably practical approach to consider. I agree that we
> should revisit and evaluate this approach further.

Let's revisit it when we get more detail. This is internal
implementation detail anyway. The users of swap.tiers don't have to
know about it.

>
> > We DO want some parent level control. That is a real customer
> > requirement. The cons with your proposal is that, if you want to
> > change the whole set from top-level cgroup to child cgroups, you need
> > to traverse the hierarchical chain to set each child cgroup. While
> > walking the child tree, more sub-level cgroups may be added, and
> > you could miss newly created cgroups. It becomes a mess.
> >
> > It is much cleaner if we allow the child cgroup to have the default
> > "swap.tiers" empty. Then you just need to set one value at the top-leve=
l
> > parent cgroup, and all child cgroups inherit it automatically. A child
> > can overwrite it if desired; by default it inherits from its parent.
> >
> > The whole set of cgroups from top-level including children can map
> > into a Kubernetes pod. It is common to perform adjustments on the
> > whole set atomically. We should support it.
>
> Okay I will adopt default inheritance for pod-level and similar use cases=
. A
> child cgroup inherits the nearest ancestor=E2=80=99s mask upon creation. =
If it

You are missing the fact that you need to track two sets of the tier mask.
the "swap.ters" is a local tiername you need to track. Default is empty.

The runtime tier set is the local tier mask walk to the parent, and
collect all parent local bitmasks and aggregate into an effective set.
The effective tier bitmask is used as the swap allocator.

What you purpose still has the same problem at:
1) parent "- +ssd"
2) child "' # same as parent.

If we do what your proposal is. Child will have "ssd" on the bit mask
at creation
When parents remove the "ssd". the child will keep having the "ssd".

In  my original proposal, if a parent removes ssd then the child will
automatically get it as well.

I am not happy that you keep introducing change to my proposal and
introduce the same buggy behavior again and again. Please respect my
time, I am spending my long weekend writing an email to you. Please
don't introduce the same bug again just for the sake of changing
behavior. Be careful and think through what you are proposing.

Chris

