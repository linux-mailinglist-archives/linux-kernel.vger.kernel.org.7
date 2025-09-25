Return-Path: <linux-kernel+bounces-833008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAB9BA0F93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D201BC07D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A03313286;
	Thu, 25 Sep 2025 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCu6O0CK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3A13B2A0;
	Thu, 25 Sep 2025 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823698; cv=none; b=Oinemvpeww3lU4XCl/+fAnnYGFaKPZMOl7I4Xex1WMtT6w8sSvPsmiMM0WD5ObKmSc5rRSXki+9LdeTfkdmeX/SEu1d+keljGNxK1reUwk1xFy/eUC7/PIzgTnab9k/wrrc6pcDIGmIL90JbbNG3kJk9zL5fmULixNoGR0Wu2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823698; c=relaxed/simple;
	bh=IhODLG7SpC8UqyOFOuzbmh0gcIPtUBtutMgkCPYtEUk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=jOGYwBLFZ9p16NJJzqnY7v6CnJqMHkhAMnzjYXivAlY69n/dBV5uqAuD+l2Iehra23a1VRA6rP+fSLtvmCqiL3YZbomzvcPJTB4v6TxGY5OXCQ2VHk4dD1W1VuC2i3NDE7DCoGMYYaRQKJkbhWb5wmNZ2pahh7ZFkL5JuLqfFg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCu6O0CK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DCDC4CEF7;
	Thu, 25 Sep 2025 18:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758823698;
	bh=IhODLG7SpC8UqyOFOuzbmh0gcIPtUBtutMgkCPYtEUk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=VCu6O0CK3C1ef63EnTIG+lUmaIsdZkkSe1ltZTKpv+91uTh6+AjhH0TkIsDJJy1Us
	 AIcqy1EbJe/0A6P/lr1YLsOkv5kUc+dhLl33PWTq2LSCeEXhFCaKAvrd+xhA7b546P
	 3CWDoQc01y+F1MYSoCIqWM/trQ7FaCxKUApR3QpeRphIY8FE2voJMj/gH2nK/+vTlQ
	 ndlsHXiGA0f57OJkWXLJ9PUTJKQ0IECqwTG5OaHDHihAtmnJpoKmljf0T9f2cu08wz
	 WF7Sj+sPjU3rfdgQ6DOUK3RUAbKQg3V1BwyLw4G/8qdx1KykUGS9BXE7XnYSANZP3O
	 tkYHsJILaJzYw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 20:08:13 +0200
Message-Id: <DD22YQ6BWOVR.3NCRQJHLL63DO@kernel.org>
Subject: Re: [PATCH] rust: slab: add basic slab module
Cc: "Elijah" <me@elijahs.space>, "Elijah Wright" <git@elijahs.space>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Uladzislau Rezki" <urezki@gmail.com>, <linux-mm@kvack.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
 <73d7d53f-439b-44a9-98ca-0b1c8fbc1661@elijahs.space>
 <DD22FI7F2ZHT.32SL8PXFZZHV3@kernel.org>
 <bypo74mzotejpsjdqd55sxygq3wjffnnimpm3vhm2xr5bddmen@lt6sr77ys73g>
In-Reply-To: <bypo74mzotejpsjdqd55sxygq3wjffnnimpm3vhm2xr5bddmen@lt6sr77ys73g>

On Thu Sep 25, 2025 at 8:02 PM CEST, Liam R. Howlett wrote:
> * Danilo Krummrich <dakr@kernel.org> [250925 13:43]:
>> On Thu Sep 25, 2025 at 7:20 PM CEST, Elijah wrote:
>>=20
>
> ...
>
>>=20
>> > I was thinking of maybe creating something like KBox for kmem_cache bu=
t=20
>> > I didn't want to touch allocator code yet, I figured I would just crea=
te=20
>> > the groundwork for that to exist. rbtree.rs uses KBox now but I'm not=
=20
>> > sure it should, at least if it's going to scale to many nodes
>>=20
>> Ok, so you want to support kmemcache for rbtree nodes. Ideally, you shou=
ld also
>> have a use-case for that, but given that we'll also need kmemcache in ot=
her
>> drivers (such as Nova) anyways, I think that's fine.
>
> This seems different than what exists on the C side, at least to me.
> The rbtree is implemented by embedding the links to the prev/next into
> the struct which is using the tree.
>
> The above sounds like the nodes of the rbtree are allocated on its own
> and not part of another allocation on the rust side?
>
> That is, the kmemcache would allocate the struct that contains the
> rbtree linkage (or nodes, I guess), but not the nodes alone.

On the Rust side the rbtree's Node structure looks like this:

	struct Node<K, V> {
	    links: bindings::rb_node,
	    key: K,
	    value: V,
	}

The allocation would be for the entire rbtree::Node and not only for the C
struct rb_node.

