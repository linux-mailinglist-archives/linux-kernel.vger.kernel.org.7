Return-Path: <linux-kernel+bounces-786211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F5BB35693
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26791B2023B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3372F746F;
	Tue, 26 Aug 2025 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKSUGfzM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C082248A4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196412; cv=none; b=Scd4+oK+bNZWJ9W3Kc8L4BJ9HadVGmuuYxm1IXztDtBeqhNJdtO7q/Gr2kJKxAm91453OGiVk5AfSIl3/lgmIs/3wLdFS6AabG+hIYIRmh3DLXliIrRrhIK6A2fJ0Vk0rtuW/Jh+QK3goLO46AS9czTHTTUAYTRyrWqL20Wy46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196412; c=relaxed/simple;
	bh=sONuKki8B7TwWJ64reiC6mneIthkd8HsVY+Is145MIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJjOBffRic9XqBsIODMC07r5xod/WhfRBFUygOokOC2lMp7y0dABc43BrskNPgznFpXoQmTE7f/eAXbe9JL3E4M4w+aGi/kth2oswPrJnVXOEQGEzN2JdVeVM7R7Pi80mj10C+qvAkeWa1/+8UwJlx9sjaJmh0L0PpeVLsR/LQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKSUGfzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C806C19425
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756196409;
	bh=sONuKki8B7TwWJ64reiC6mneIthkd8HsVY+Is145MIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oKSUGfzMWHSaT+dHxVefkn5yvRO3lWoP1wYvSflK6QtQviyBA9S1sKEUU5boLItSv
	 Rt7Zu9KsM7t5axAyt4jja/yVYEWvWAGECiPMHlW++fvcFdvARRM7rBm2om5P+at7Bl
	 aaNZWBtT9OiI3v2wDwid1+Rz9DCshMQRU+i0gRgQAhtd4/6Wxy++xV+kPxSMYUHTMV
	 Q7a4nJuTcIoqb6Oi7rqhA9wtYkuhEnSFdVBZbNllBMtK3e+lnCbllPMoZ3tv0PQVq7
	 Ux6ajmGnrXLVminGBQ7te0wQqAywQjT5+dXfbThbJg+v5XWnRftO2Nezw75VrqXhuH
	 i3SRgXQrZhujg==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71fab75fc97so44963017b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:20:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRc9L5wyVQfHDfrFFQgHXxLFzpvynNKYVkd8UPyvN2k4Hfwrxb/afcLp5+pYZtzgQNbd3R1OsP2zAE92w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQa/RcWgGcKyQ7SWVs/1oq6/2F/FWr4I08+SS7G+64svsk95bi
	RMuXdFdd7i3xVlxTf0+3dP6zIuJf8pyMhAb1dCtMtWoeOjNC/wSBtz1LlpTpPI4YjBqMWrigRkg
	hx81RLKHHajC0RPOUVP6nrLb+TjdIQJXs3cvlY6OGBg==
X-Google-Smtp-Source: AGHT+IHhfA6toD9smW5R9Eqp3FwdYkE9zYj/5v7I/pPYUBkwflme2INXRlkFY6LnUaCPhnYcS6FDPoXOU1MLbVE8P1c=
X-Received: by 2002:a05:690c:74c7:b0:719:f1b0:5c29 with SMTP id
 00721157ae682-71fdc2b00efmr155584287b3.3.1756196408693; Tue, 26 Aug 2025
 01:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <uyxkdmnmvjipxuf7gagu2okw7afvzlclomfmc6wb6tygc3mhv6@736m7xs6gn5q>
 <CAF8kJuMo3yNKOZL9n5UkHx_O5cTZts287HOnQOu=KqQcnbrMdg@mail.gmail.com>
 <aKC+EU3I/qm6TcjG@yjaykim-PowerEdge-T330> <CAF8kJuNuNuxxTbtkCb3Opsjfy-or7E+0AwPDi7L-EgqoraQ3Qg@mail.gmail.com>
 <aKROKZ9+z2oGUJ7K@yjaykim-PowerEdge-T330> <CAF8kJuPUouN4c6V-CaG7_WQUAvRxBg02WRxsMtL56_YTdTh1Jg@mail.gmail.com>
 <aKXeLCr9DgQ2YfCq@yjaykim-PowerEdge-T330> <CAF8kJuM4f2W6w29VcHY5mgXVMYmTF4yORKaFky6bCjS1xRek9Q@mail.gmail.com>
 <aKgD7nZy7U+rHt9X@yjaykim-PowerEdge-T330> <CAF8kJuMb5i6GuD_-XWtHPYnu-8dQ0W51_KqUk60DccqbKjNq6w@mail.gmail.com>
 <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330>
In-Reply-To: <aKsAES4cXWbDG1xn@yjaykim-PowerEdge-T330>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Aug 2025 01:19:57 -0700
X-Gmail-Original-Message-ID: <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
X-Gm-Features: Ac12FXxNgoR7PbdQwij3wHUVAMYghI2NtgP6p7nAs3QGQFBgR0Y0mJ6P0oIqaU8
Message-ID: <CACePvbV=OuxGTqoZvgwkx9D-1CycbDv7iQdKhqH1i2e8rTq9OQ@mail.gmail.com>
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

On Sun, Aug 24, 2025 at 5:05=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> > How do you express the default tier who shall not name? There are
> > actually 3 states associated with default. It is not binary.
> > 1) default not specified: look up parent chain for default.
> > 2) default specified as on. Override parent default.
> > 3) default specified as off. Override parent default.
>
> As I understand, your intention is to define inheritance semantics depend=
ing
> on the default value, and allow children to override this freely with `-`=
 and
> `+` semantics. Is that correct?

Right, the "+" and "-" need to place in the beginning without tier
name, then it is referring the default.

>
> When I originally proposed the swap cgroup priority mechanism, Michal Kou=
tn=C3=BD
> commented that it is unnatural for cgroups if a parent attribute is not
> inherited by its child:
> (https://lore.kernel.org/linux-mm/rivwhhhkuqy7p4r6mmuhpheaj3c7vcw4w4kavp4=
2avpz7es5vp@hbnvrmgzb5tr/)
Michal only said you need to provide ways for child cgroup to inherit
the parent.
The swap.tiers does provide such a mechanism. Just don't override the
default.  I would not go that far to ban the default overwrite. It is
useful no need to list every swap tier.

BTW, Michal, I haven't heard any feedback from you since I started the
swap.tiers discussion. If you have any concerns please do voice out.

> Therefore, my current thinking is:
> * The global swap setting itself is tier 1 (if nothing is configured).
> * If a cgroup has no setting:
>   - Top-level cgroups follow the global swap.
>   - Child cgroups follow their parent=E2=80=99s setting.
> * If a cgroup has its own setting, that setting is applied.
> (child cgroups can only select tiers that the parent has allowed.)

That is too restrictive. The most common case is just the parent
cgroup matters, the child uses the exact same setting as the parent.
However, if you want the child to be different from the parent, there
are two cases depending on your intention. Both can make sense.
1) The parent is more latency sensitive than the child. That way the
child will be more (slower) tired than the parent. Using more tiers is
slower, that is the inverted relationship. Your proposal does not
allow this?
2) The parent is latency tolerant and the child is latency sensitive.
In this case, the child will remove some swap files from the parent.
This is also a valid case, e.g. the parent is just a wrapper daemon
invoking the real worker as a child. The wrapper just does log
rotation and restarting the child group with a watchdog, it does not
need to be very latency sensitive, let say the watchdog is 1 hours.
The child is the heavy lifter and requires fast response.

I think both cases are possible, I don't see a strong reason to limit
the flexibility when there is no additional cost. I expect the
restriction approach having similar complexity.

> This seems natural because most cgroup resource distribution mechanisms f=
ollow
> a subset inheritance model.

I don't see a strong reason to make this kind of restriction yet. It
can go both ways. Depending on your viewpoint, having more swap tier
does not mean it is more powerful, it can be less powerful in the
sense that it can slow you down more.

> Thus, in my concept, there is no notion of a =E2=80=9Cdefault=E2=80=9D va=
lue that controls
> inheritance.

Then you need to list all tiers to disable all. It would be error
prone if your tier list is long.
>
> > How are you going to store the list of ranges? Just a bitmask integer
> > or a list?
>
> They can be represented as increasing integers, up to 32, and stored as a
> bitmask.

Great, that is what I have in mind as well.

> > I feel the tier name is more readable. The number to which actual
> > device mapping is non trivial to track for humans.
>
> Using increasing integers makes it simpler for the kernel to accept a uni=
form
> interface format, it is identical to the existing cpuset interface, and i=
t
> expresses the meaning of =E2=80=9Ctiers of swap by speed hierarchy=E2=80=
=9D more clearly in my
> view.

Same.

>
> However, my feeling is still that this approach is clearer both in terms =
of
> implementation and conceptual expression. I would appreciate it if you co=
uld
> reconsider it once more. If after reconsideration you still prefer your

Can you clarify what I need to reconsider? I have the very similar
bitmask idea as you describe now.
I am not a dictator. I just provide feedback to your usage case with
my reasoning.

> direction, I will follow your decision.
>
> > I want to add another usage case into consideration. The swap.tiers
> > does not have to be per cgroup. It can be per VMA. [...]
>
> I understand this as a potential extension use case for swap.tier.
> I will keep this in mind when implementing. If I have further ideas here,=
 I
> will share them for discussion.

That means the tiers definition needs to be global, outside of the cgroup.

> > Sounds fine. Maybe we can have "ssd:100 zswap:40 hdd" [...]
>
> Yes, this alignment looks good to me!
>
> > Can you elaborate on that. Just brainstorming, can we keep the
> > swap.tiers and assign NUMA autobind range to tier as well? [...]
>
> That is actually the same idea I had in mind for the NUMA use case.
> However, I doubt if there is any real workload using this in practice, so=
 I
> thought it may be better to leave it out for now. If NUMA autobind is tru=
ly
> needed later, it could be implemented then.

I do see a possibility to just remove the NUMA autobind thing if the
default swap behavior is close enough. The recent swap allocator
change has made huge improvements in terms of lock contention and
using smaller locks. The NUMA autobind might not justify the
complexity now. I wouldn't spend too much effort in NUMA  for the MVP
of swap.tiers.

> This point can also be revisited during review or patch writing, so I wil=
l
> keep thinking about it.

Agree.

> > I feel that that has the risk of  premature optimization. I suggest
> > just going with the simplest bitmask check first then optimize as
> > follow up when needed. [...]
>
> Yes, I agree with you. Starting with the bitmask implementation seems to =
be
> the right approach.
>
> By the way, while thinking about possible implementation, I would like to=
 ask
> your opinion on the following situation:
>
> Suppose a tier has already been defined and cgroups are configured to use=
 it.
> Should we allow the tier definition itself to be modified afterwards?

If we can set it the first time, we should be able to set it the
second time. I don't recall such an example in the kernel parameter
can only be set once.


> There seem to be two possible choices:
>
> 1. Once a cgroup references a tier, modifying that tier should be disallo=
wed.

Even modify a tier to cover more priority range but no swap device
falls in that additional range yet?
I think we should make the change follow the swap on/swap off
behavior. Once the swap device is swapped on, it can't change its tier
until it is swapped off again. when it is swapped off, there is no
cgroup on it. Notice the swap file belongs to which tier is not the
same as the priority range of the tier. You can modify the range and
reorder swap tiers as long as it is not causing swap on device jump to
a different tier.

> 2. Allow tier re-definition even if cgroups are already referencing it.

You can still swap off even if cgroup is still using it.

> Personally, I prefer option (1), since it avoids unexpected changes for
> cgroups that already rely on a particular tier definition.

Swap off and on already have similar problems. We can't change the
priority when the swap device is swapon already. We can go through a
swap off to change it.

Chris

