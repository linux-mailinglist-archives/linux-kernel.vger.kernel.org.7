Return-Path: <linux-kernel+bounces-833014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4005DBA0FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366621BC4996
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358583148CD;
	Thu, 25 Sep 2025 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBzzN4io"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85585202976;
	Thu, 25 Sep 2025 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824129; cv=none; b=VI4AT7tNwNnPYJJH6Lvi7PQgsVc4vQ09LTcqZwTWJnMR7rKy9REFn7sCjBcedHYdBEwUqXzXUPrjx+RJHvhyErGESzFsTBaj+1q3Mn6n0s5g6HcJGf45ZYidL95G4zNV6E8+EFrH4pSm1GmrUeAQMwbMHaBd3qfhh2z0u/7AgjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824129; c=relaxed/simple;
	bh=OMdYq83OkDKRZw/s0mDBqBorGXDjzGEN2c30eHemUKI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=TPZiHZAnhbiN81clunf3e5mlcCa/vtql6tysHn8A+kLkXjHeBjKhQopuEFi7LO2vRcVN1bd+IzmFLeWwia6TGrYftycurGl8FO1r8TWQpdCI9PBLLkMThvlnKy7I7LbGoU8hczeI6teRWHEIidzDunouE7ydsyCjPACUV+LP7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBzzN4io; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F585C4CEF0;
	Thu, 25 Sep 2025 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758824129;
	bh=OMdYq83OkDKRZw/s0mDBqBorGXDjzGEN2c30eHemUKI=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=SBzzN4iotExRcTbbma5iJDp7MBTjmmMi+tQHAjQzvsHtCym4Ru5wRiMbgImHdPZJF
	 B+OvIroSkk2F73eg/cLAq5o+oS2m+qMINsm9df/Z0ymKrabIohccfOXrRu11ghovgk
	 zskV/wwOWu2ygf9jLBU94isVGCa2IxTCOVxblHC2HlBE5JgM89BVCnTGucwqp+UXp3
	 FDa+ke32ls4d2bqwiKyudpvvWkpd+CeGDBT8ZUe4VljXQHlzlyqNcuLCw4Es2yFatx
	 R7xNiWJEW8Yxb9rTxi2e78G4Gb27LPIzMTvvUrJiXC6Xd5+3XoZqgBNKWV4cooRyXa
	 ts+VNbcqrMMPg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 20:15:23 +0200
Message-Id: <DD234804U7YK.3S2MBUJSFHF8J@kernel.org>
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
 <DD22FI7F2ZHT.32SL8PXFZZHV3@kernel.org>
 <6e9c820f-070b-409e-ac25-af96b8b962c6@elijahs.space>
In-Reply-To: <6e9c820f-070b-409e-ac25-af96b8b962c6@elijahs.space>

On Thu Sep 25, 2025 at 8:05 PM CEST, Elijah wrote:
> On 9/25/2025 10:43 AM, Danilo Krummrich wrote:
>
>  > Anyways, I'd also like to hear some more opinions, especially=20
> regarding (4), as
>  > mentioned.
>
> ok I just looked it over. I think (4) isn't really viable, the cache=20
> pointer storage overhead is probably too much (in addition to some=20
> complex issues).

Probably, given that kmemcache is meant to be used when we have a lot of (s=
mall)
allocations.

However, I'd like to hear from the MM folks, if there may be options in the
existing infrastructure, or if it's really a dead end.

What are the other complex issues you are referring to?

> I don't really like having a macro (so (3) basically)=20
> and I think there are issues with non-static caches, I don't know=20
> specifically though. obviously (1) doesn't work. (2) is exactly what I=20
> was thinking specifically for rbtree. IMO the only useful options are=20
> (2) and (3). I would say maybe implement (2) first and if you want=20
> macro-generated ZST allocators they can wrap whatever that Box ends up=20
> being.

I'm not sold on duplicating the Box code just yet. What issues are you refe=
rring
to?

