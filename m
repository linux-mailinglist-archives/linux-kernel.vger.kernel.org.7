Return-Path: <linux-kernel+bounces-834455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E81BA4BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D26A1C2285A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8AA308F16;
	Fri, 26 Sep 2025 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPZBN41d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D8308F14;
	Fri, 26 Sep 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905891; cv=none; b=TJonlDGPH7JdAkMrMjA/pcYeqpJTpj1NlJe+uVptNad9R1Gbir3x+DsWJu45/JPeKV4MLCocJUNle0d+11BcLXQWWqqjPXxp0A0PXkL0zzrnXy8DJL9mtQMUOA7qPoepI16fL5w92jCSGaIVG00idp9ay8rWAZFih5ydh/ZgB3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905891; c=relaxed/simple;
	bh=jVJK8LGegwhqO+0VtnrfQPb/RxRKwtl+yfaKeB1SOzw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=fiji/sLEvI3PD3/TrULn+9qLJ8r0SASLcmtO38TI9KrX70aluGavtjzHKdQj4xWd7VOF+COFKMaxDqpdRvVWZI2X/rf7e43/kXf6ceo9pKlpUyR9h9Qi6arz+0BYL+Ftj94WDfABlF1vBk/eKnGEw3mtReH5yUlPorF3nDDpotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPZBN41d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702C0C4CEF4;
	Fri, 26 Sep 2025 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758905891;
	bh=jVJK8LGegwhqO+0VtnrfQPb/RxRKwtl+yfaKeB1SOzw=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=jPZBN41d8N96n+QGhajTpesnYkcN2IRpa1XMCib2BywYLEKk1Spw3TAKs3LwC1b2M
	 qY0Z+dgyIpC8LGOS6ZL/Cn/+lAulX1IZ09FjtYhdqQuqusr+SGmUM+3Ddpc9L9e51r
	 UZ1o2GEs1kuCWhKKkDqsYfsa0aJjDdWyQJLYPcIsPCnfxtBgw3oZM8SjC5ropmpM8o
	 7Eof93GrxvT2tMPOAffuYTLrEIofYzBFq0WwvQRJ7bgsn1UM3BEekBngPtpCau5goe
	 sZr+Ex9RQ+W6LsAJibJ0AtFLre7el6+KhvUr5S/3+ljfXBv4uoLJV2bkNaR+WXCbws
	 QO4mGuPklEuGg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Sep 2025 18:58:06 +0200
Message-Id: <DD2W3LCC7FWA.2X90YAPLI1FGC@kernel.org>
To: "Vlastimil Babka" <vbabka@suse.cz>
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
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
 <5f09b7f5-e7de-4333-8de5-322eb6d93aa9@suse.cz>
 <DD2UB5P01XW7.1GW33112S22Y@kernel.org>
 <DD2URCNO2P88.168J48GHSJRRL@kernel.org>
 <1f5ae3bd-db21-4042-b177-55464644ce2e@suse.cz>
In-Reply-To: <1f5ae3bd-db21-4042-b177-55464644ce2e@suse.cz>

On Fri Sep 26, 2025 at 6:32 PM CEST, Vlastimil Babka wrote:
> On 9/26/25 17:55, Danilo Krummrich wrote:
>> On Fri Sep 26, 2025 at 5:33 PM CEST, Danilo Krummrich wrote:
>>> The only thing we need on the Rust side is that existing allocations re=
main
>>> valid even if the cache is destroyed. Or the other way around the cache=
 is
>>> silently kept alive internally.
>>=20
>> Or to express it in C code:
>>=20
>> 	struct kmem_cache *cache =3D kmem_cache_create();
>> 	struct Foo *foo =3D kmem_cache_alloc();
>>=20
>> 	// After this call cache will never be accessed; leaves a zombie cache,
>> 	// since foo is still alive.
>> 	kmem_cache_destroy(cache);
>
> This will cause a WARN.
>
>> 	// This must still be valid.
>> 	foo->bar =3D 42;
>
> Yes this will be safe.

That's great!

>> 	// Frees foo and causes the "zombie" cache to actually be destroyed.
>> 	kmem_cache_free(foo);
>
> The free will be fine. But not cause the cache destruction, as that would
> require checks on each free. But should be fine wrt safety if we only lea=
k
> some memory due to a wrong usage, no?

Yes, technically that's safe, but we wouldn't prevent the leak, which still
is not desirable (and not our ambition for a Rust API).

From a C standpoint, both the warning and the cache leak could be solved by
making kmem_cache_destroy() fallible as you mentioned previously.

On the Rust side the cache would be represented with a struct KmemCache<T>
(where T is the type that should be allocated by the cache).

kmem_cache_destroy() would be called from KmemCache<T>::drop(), which is no=
t
fallible. But even if it were, we can't enforce that users keep the KmemCac=
he
instance alive as long as there are allocations.

So, either we always keep the KmemCache<T> alive for the whole module lifet=
ime
(which depending on whether its built-in or not could be considered a memor=
y
leak as well). Or we ensure that the last kmem_cache_free() also frees the =
cache
if kmem_cache_destroy() was called previously.

OOC, does the cache pointer remain valid if kmem_cache_destroy() is called =
while
allocations still exist? I.e. is this, except for the WARN(), valid code?

	kmem_cache_destroy(cache);
	kmem_cache_free(foo);
	kmem_cache_destroy(cache);

At a quick glance it appears to me that things would go south in
kmem_cache_release(). Anyways, I don't think it would help, if it would be =
the
case.

