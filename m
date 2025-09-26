Return-Path: <linux-kernel+bounces-834321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A2BBA4702
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6BE1C02D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B8721B9F1;
	Fri, 26 Sep 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOIxIqaX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FF919FA93;
	Fri, 26 Sep 2025 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900842; cv=none; b=rNOCpo8DwBFCZs+mNi8DY2gTqh9J5jwAuxZro/PvM1EUXQ3gREUZ98FY8VkvjcpcSXifVPjSa8/KosvNmTlMzxrfuHE+qRQupK3i8cihIYEIzNEYqj5PFZXVsC1eL3ktIinFFzPgvXtxafoiOFR9ywlGl2AJE9fqZTQHUMO933k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900842; c=relaxed/simple;
	bh=AyEuhcc/KBdFsnEyAfH3GoL7xIxURJXhcw3SPv7GPgQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=tyl8gN97ZA/iD6FTXJiJ867lgakhobH22CEyVM7qeuYvtn1ahXbqZOlUSP7Zl/1j3rHfrpHUx8hi/NX75Dd6TPyneovmsl0C+6TEf2JgeKhfHTou2RicCFtZJ3HKzWeFPmewmkMw1mtOpsfWNQ36bCo1tULHt7P5uVSZMBIcMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOIxIqaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22B1C4CEF4;
	Fri, 26 Sep 2025 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758900842;
	bh=AyEuhcc/KBdFsnEyAfH3GoL7xIxURJXhcw3SPv7GPgQ=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=JOIxIqaX/xLyzXWjbGYfeZLPHoJF0M3M3FYuJUkkkYntrH4fkEfMceJJ1aAs0+DhD
	 S6ayU35ln1PxQnbxa1LIg7HpXJnpPvkhktw1oWHcGJYH8fd/+Y0Oak0CXai9ZNqgKw
	 WK3F9vvwgotDBpvpziEcrNbF+16oEbmkMsh8Q2s0kWwc12zePQregiF55Ll2Ku0o/O
	 YwAMv0aAGZdbhi5tPz6h8TqxdinlGMyOb8oTpr2OapoTcVjtoCRdWt1QKRjvpZEfJ4
	 sV5uuQQ8XYRrMgzeHQ2ZVEzeyIehrttjNEYro/EozUWVUIsOGa+NYUCSioqa8H+/4e
	 bYASHKTy3TLvQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Sep 2025 17:33:57 +0200
Message-Id: <DD2UB5P01XW7.1GW33112S22Y@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: slab: add basic slab module
Cc: "Elijah Wright" <git@elijahs.space>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Uladzislau Rezki" <urezki@gmail.com>, <linux-mm@kvack.org>
To: "Vlastimil Babka" <vbabka@suse.cz>
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
 <5f09b7f5-e7de-4333-8de5-322eb6d93aa9@suse.cz>
In-Reply-To: <5f09b7f5-e7de-4333-8de5-322eb6d93aa9@suse.cz>

On Fri Sep 26, 2025 at 5:00 PM CEST, Vlastimil Babka wrote:
> On 9/25/25 11:54, Danilo Krummrich wrote:
>> (+Cc: Lorenzo, Vlastimil, Liam, Uladzislau, MM)
>>=20
>> On Wed Sep 24, 2025 at 9:36 PM CEST, Elijah Wright wrote:
>>> this patch adds a basic slab module for kmem_cache, primarily wrapping
>>> kmem_cache_create, kmem_cache_alloc, kmem_cache_free, and kmem_cache_de=
stroy.
>>=20
>> What's the motivation?
>>=20
>> I mean, we will need kmem_cache soon. But the users will all be drivers,=
 e.g.
>> the GPU drivers that people work on currently.
>>=20
>> Drivers shouldn't use "raw" allocators (such as Kmalloc [1] or Vmalloc [=
2]), but
>> the corresponding "managed" allocation primitives, such as KBox [3], VBo=
x [4],
>> KVec, etc.
>>=20
>> Therefore, the code below shouldn't be used by drivers directly, hence t=
he
>> question for motivation.
>>=20
>> In any case, kmem_cache is a special allocator (special as in it can hav=
e a
>> non-static lifetime in contrast to other kernel allocators) and should b=
e
>> integrated with the existing infrastructure in rust/kernel/alloc/.
>>=20
>> I think there are multiple options for that; (1) isn't really an option,=
 but I
>> think it's good to mention anyways:
>>=20
>>   (1) Allow for non-zero sized implementations of the Allocator trait [3=
], such
>>       that we can store a reference count to the KmemCache. This is nece=
ssary to
>>       ensure that a Box<T, KmemCache> can't out-live the KmemCache itsel=
f.
>>=20
>>       The reason why I said it's not really an option is because it disc=
ards the
>>       option for dynamic dispatch of the generic Box type.
>>=20
>>   (2) Same as (1), but with a custom Box type. This keeps dynamic dispat=
ch for
>>       the generic Box type (i.e. KBox, VBox, KVBox), but duplicates quit=
e some
>>       code and still doesn't allow for dynamic dispatch for the KmemCach=
eBox.
>>=20
>>   (3) Implement a macro to generate a custom KmemCache Allocator trait
>>       implementation for every KmemCache instance with a static lifetime=
.
>>=20
>>       This makes KmemCache technically equivalent to the other allocator=
s, such
>>       as Kmalloc, etc. but obviously has the downside that the KmemCache=
 might
>>       live much longer than required.
>
> I don't know enough of Rust to follow why is that. What does mean "much l=
onger"?

Nothing Rust specific, I just point out that if the kmemcache does not need=
 to
be tied to the module lifetime (but a more narrow scope for whatever reason=
), it
would still need to live as long as the module lives with (3). Which for
built-in means forever, which would likely be "much longer". :)

>>       Technically, most KmemCache instances live for the whole module li=
fetime,
>>       so it might be fine though.
>
> I think so, yeah.
>
>>       (This is what I think Alice proposed.)
>>=20
>>   (4) Solve the problem on the C side and let kmem_cache_alloc() take ca=
re of
>>       acquiring a reference count to the backing kmem_cache. The main qu=
estion
>>       here would be where to store the pointer for decreasing the refere=
nce
>>       count on kmem_cache_free().
>
> Pointer to what, the ref counter? If it's part of struct kmem_cache, then=
 we
> have pointer to that in kmem_cache_free(). Even when kfree() is used, it =
can
> be (or rather already is) obtained. So that's not the issue (unless I
> misunderstand).

Yes, the reference count.

> But we wouldn't want to pay the cost of the atomic updates of the refcoun=
t
> for all caches. If done only for Rust-created caches, the implementation
> also would better not to add branches to all allocation/free fastpaths.

Indeed, that's why I was wondering if you see other options to deal with th=
is in
the MM layer, and reading the below, it seems like you even already do.

> But also why is this refcounting needed? What would happen on the Rust si=
de
> if someone destroyed the cache too early?

Well, that's the question. I thought that if the cache is destroyed potenti=
al
remaining allocations become invalid.

If that's the case we have to ensure that all allocations are freed before =
the
cache is destroyed.

> In the underlying C implementation
> we notice it (reliably AFAICT), warn and abort the destroy (leaving it as=
 a
> kind of zombie) so I'd say it's safe. So if Rust needs to know if the
> destroy was successful or premature, we could probably just return the
> result instead of the current void.

The only thing we need on the Rust side is that existing allocations remain
valid even if the cache is destroyed. Or the other way around the cache is
silently kept alive internally.

>>       Theoretically, it could be stored within the allocation itself, bu=
t it's a
>>       bit of a yikes.
>>=20
>>       However, it would resolve all the mentioned problems above.
>>=20
>> I'd like to see (3) or (4), also depending on what the MM folks think.
>>=20
>> - Danilo
>>=20
>> [1] https://rust.docs.kernel.org/kernel/alloc/allocator/struct.Kmalloc.h=
tml
>> [2] https://rust.docs.kernel.org/kernel/alloc/allocator/struct.Vmalloc.h=
tml
>> [3] https://rust.docs.kernel.org/kernel/alloc/kbox/type.KBox.html
>> [4] https://rust.docs.kernel.org/kernel/alloc/kbox/type.VBox.html
>> [5] https://rust.docs.kernel.org/kernel/alloc/trait.Allocator.html


