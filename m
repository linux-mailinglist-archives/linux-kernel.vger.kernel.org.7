Return-Path: <linux-kernel+bounces-832991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0407BBA0ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D70620F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ECA30E0CD;
	Thu, 25 Sep 2025 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Unxgyn6m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493E27FB35;
	Thu, 25 Sep 2025 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822192; cv=none; b=DDRhFXPvJBjN7WFL82XcXoHfL4iM0V5nEt79LkDHNjDEpq5VS5UnLNPDAeONXaAqB0iXO0jY6A1jc/BJ8JX8AzGOjdCd4ljLDmUXeBuT0VdUVu1eNUVwmkr66Aly17uIrkD5VGZaL+6PJp/BKkvUH2va9zm9V1+oYCcUurEJDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822192; c=relaxed/simple;
	bh=6dZOpQBW/lA06q/6Y0/CJJMMvmBCufgtJLcVYXd+Yfg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Qjc1J6vPySZFFsJSJ5qI804tDewX/jNe8T2+pW/P9c6jO0DMNkpvmPJQ3f4bFVZieUk+y7SYYsFnujylfW9u8AP1r0uwMOrIAwNX0uWxjuTDOUwaamXwBe1UCDpQLw/UIN95O+6LYpmA0SgqMyzEyUZ2oInP9Obuhb/PUvpYqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Unxgyn6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B12C4CEF0;
	Thu, 25 Sep 2025 17:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758822192;
	bh=6dZOpQBW/lA06q/6Y0/CJJMMvmBCufgtJLcVYXd+Yfg=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=Unxgyn6m7xG/mtrp/KMSCQcwsdWhvmbLsFz1bfLIqPGVJCUcZWeuF+KwUFW26waeR
	 8MQML/BxvpUuHYelcSdzftz1B00QmRjVh7LCS/lLBL9vxo+4VTdtiQbxIjlL74Vhp5
	 0tJl1HChfVNE2/tfseyYLcAMEmYBJtdz5xIqcD6QUWoWtjOjMv20GxQiV+9BZ29xxz
	 J3rohqJvaoADCqb2zpCatsovUTTVK6zeeqsLmciSTN0zjAWWMu5nwUCS2hcCyhluXL
	 NZ3E/mUUDvBTzhSSDq1JncC8kE3n63LY7wnUeVGgIcpkD3pXbdjGPHK+vdN2QAYHlm
	 Nmx3+nvqDOnow==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 19:43:06 +0200
Message-Id: <DD22FI7F2ZHT.32SL8PXFZZHV3@kernel.org>
Cc: "Elijah Wright" <git@elijahs.space>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Uladzislau Rezki" <urezki@gmail.com>,
 <linux-mm@kvack.org>
To: "Elijah" <me@elijahs.space>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: slab: add basic slab module
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
 <73d7d53f-439b-44a9-98ca-0b1c8fbc1661@elijahs.space>
In-Reply-To: <73d7d53f-439b-44a9-98ca-0b1c8fbc1661@elijahs.space>

On Thu Sep 25, 2025 at 7:20 PM CEST, Elijah wrote:

Please don't top post [1]; use interleaved style instead.

[1] https://subspace.kernel.org/etiquette.html#do-not-top-post-when-replyin=
g

> I was thinking of maybe creating something like KBox for kmem_cache but=
=20
> I didn't want to touch allocator code yet, I figured I would just create=
=20
> the groundwork for that to exist. rbtree.rs uses KBox now but I'm not=20
> sure it should, at least if it's going to scale to many nodes

Ok, so you want to support kmemcache for rbtree nodes. Ideally, you should =
also
have a use-case for that, but given that we'll also need kmemcache in other
drivers (such as Nova) anyways, I think that's fine.

However, in any case this should be integrated into the rust/kernel/alloc/
infrastructure in one of the ways described below.

As mentioned, I would like to see (3) or (4). (2) may be viable as well, bu=
t I
really hate the resulting code duplication (not having dynamic dispatch for=
 a
kmemcache backed Box is probably not that big of a deal though).

Anyways, I'd also like to hear some more opinions, especially regarding (4)=
, as
mentioned.

> On 9/25/2025 2:54 AM, Danilo Krummrich wrote:
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
>>    (1) Allow for non-zero sized implementations of the Allocator trait [=
3], such
>>        that we can store a reference count to the KmemCache. This is nec=
essary to
>>        ensure that a Box<T, KmemCache> can't out-live the KmemCache itse=
lf.
>>=20
>>        The reason why I said it's not really an option is because it dis=
cards the
>>        option for dynamic dispatch of the generic Box type.
>>=20
>>    (2) Same as (1), but with a custom Box type. This keeps dynamic dispa=
tch for
>>        the generic Box type (i.e. KBox, VBox, KVBox), but duplicates qui=
te some
>>        code and still doesn't allow for dynamic dispatch for the KmemCac=
heBox.
>>=20
>>    (3) Implement a macro to generate a custom KmemCache Allocator trait
>>        implementation for every KmemCache instance with a static lifetim=
e.
>>=20
>>        This makes KmemCache technically equivalent to the other allocato=
rs, such
>>        as Kmalloc, etc. but obviously has the downside that the KmemCach=
e might
>>        live much longer than required.
>>=20
>>        Technically, most KmemCache instances live for the whole module l=
ifetime,
>>        so it might be fine though.
>>=20
>>        (This is what I think Alice proposed.)
>>=20
>>    (4) Solve the problem on the C side and let kmem_cache_alloc() take c=
are of
>>        acquiring a reference count to the backing kmem_cache. The main q=
uestion
>>        here would be where to store the pointer for decreasing the refer=
ence
>>        count on kmem_cache_free().
>>=20
>>        Theoretically, it could be stored within the allocation itself, b=
ut it's a
>>        bit of a yikes.
>>=20
>>        However, it would resolve all the mentioned problems above.
>>=20
>> I'd like to see (3) or (4), also depending on what the MM folks think.

