Return-Path: <linux-kernel+bounces-832157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FCEB9E83F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221757AD1FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FDC2E973F;
	Thu, 25 Sep 2025 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhLOPzA9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A138FA6;
	Thu, 25 Sep 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794067; cv=none; b=YpJoT2xgqzoO35gI3myOLW0fgI9Vtdnvdn3+tIsIXI/XNBgD1ZFvZZl01vNBQI49+rO5l9+LP18xI5gBYLwv+zPXNox5WfE9hUuiD1BcgBXPgLMbGaCkX7bHcYtpLwAX2nETzTL+9eGKCIMj8AqfQz+MU4zUP96dYsoL7KNxrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794067; c=relaxed/simple;
	bh=xfXQiQFl7Tui7XJKKsNvDs46qyN1OX4PNUAUOBUQd2g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=GoRtLJQxVi/DUn6ZxGaT03AdOtNw8WNA4zpCaQJW7rKYEuwywsXq8N4cSDDtcz02/ioL0MFY5EwJo/LbXcK1CR73XGHdZYmYfk6eoNsKF76Fzq+mLQ+0kDbzvyuL4ZWJXe55E7tvOiDjXxhCAf6B1cooylrtRjqu7CSya3krOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhLOPzA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED149C4CEF4;
	Thu, 25 Sep 2025 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758794067;
	bh=xfXQiQFl7Tui7XJKKsNvDs46qyN1OX4PNUAUOBUQd2g=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=GhLOPzA967PCCw7XlP2pnKVSM5E+BTjPS6wrBIWagHaG22BtnNAJ47vSD6MdEN+Le
	 sPUGTUs/mQ63cxS7ROkrSbvKIRPxTMmOF1G/DqVcDWqCSkFchLyXlwk9YpeZqJdJ+j
	 Iw1iT63w/VyKZIZKY+ux1OyQPI4BhRsEkgoipDw8AULKU2PbMRruJ719exxqHv8I++
	 Hq3vbsMq4GoKJ4F3/c9RphxH9HKhg1PnLaqmQjMhm+v6CK5AewuXriViXLLFzmoCpd
	 J4w3utXUms1jrsVhkuU3jNSutwtGPVnN7KAIwOaPNlPcLIBvqxL4ueoiORRqfSghzk
	 qiNmNBTMhP45g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 11:54:22 +0200
Message-Id: <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
Subject: Re: [PATCH] rust: slab: add basic slab module
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Uladzislau Rezki" <urezki@gmail.com>,
 <linux-mm@kvack.org>
To: "Elijah Wright" <git@elijahs.space>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250924193643.4001-1-git@elijahs.space>
In-Reply-To: <20250924193643.4001-1-git@elijahs.space>

(+Cc: Lorenzo, Vlastimil, Liam, Uladzislau, MM)

On Wed Sep 24, 2025 at 9:36 PM CEST, Elijah Wright wrote:
> this patch adds a basic slab module for kmem_cache, primarily wrapping
> kmem_cache_create, kmem_cache_alloc, kmem_cache_free, and kmem_cache_dest=
roy.

What's the motivation?

I mean, we will need kmem_cache soon. But the users will all be drivers, e.=
g.
the GPU drivers that people work on currently.

Drivers shouldn't use "raw" allocators (such as Kmalloc [1] or Vmalloc [2])=
, but
the corresponding "managed" allocation primitives, such as KBox [3], VBox [=
4],
KVec, etc.

Therefore, the code below shouldn't be used by drivers directly, hence the
question for motivation.

In any case, kmem_cache is a special allocator (special as in it can have a
non-static lifetime in contrast to other kernel allocators) and should be
integrated with the existing infrastructure in rust/kernel/alloc/.

I think there are multiple options for that; (1) isn't really an option, bu=
t I
think it's good to mention anyways:

  (1) Allow for non-zero sized implementations of the Allocator trait [3], =
such
      that we can store a reference count to the KmemCache. This is necessa=
ry to
      ensure that a Box<T, KmemCache> can't out-live the KmemCache itself.

      The reason why I said it's not really an option is because it discard=
s the
      option for dynamic dispatch of the generic Box type.

  (2) Same as (1), but with a custom Box type. This keeps dynamic dispatch =
for
      the generic Box type (i.e. KBox, VBox, KVBox), but duplicates quite s=
ome
      code and still doesn't allow for dynamic dispatch for the KmemCacheBo=
x.

  (3) Implement a macro to generate a custom KmemCache Allocator trait
      implementation for every KmemCache instance with a static lifetime.

      This makes KmemCache technically equivalent to the other allocators, =
such
      as Kmalloc, etc. but obviously has the downside that the KmemCache mi=
ght
      live much longer than required.

      Technically, most KmemCache instances live for the whole module lifet=
ime,
      so it might be fine though.

      (This is what I think Alice proposed.)

  (4) Solve the problem on the C side and let kmem_cache_alloc() take care =
of
      acquiring a reference count to the backing kmem_cache. The main quest=
ion
      here would be where to store the pointer for decreasing the reference
      count on kmem_cache_free().

      Theoretically, it could be stored within the allocation itself, but i=
t's a
      bit of a yikes.

      However, it would resolve all the mentioned problems above.

I'd like to see (3) or (4), also depending on what the MM folks think.

- Danilo

[1] https://rust.docs.kernel.org/kernel/alloc/allocator/struct.Kmalloc.html
[2] https://rust.docs.kernel.org/kernel/alloc/allocator/struct.Vmalloc.html
[3] https://rust.docs.kernel.org/kernel/alloc/kbox/type.KBox.html
[4] https://rust.docs.kernel.org/kernel/alloc/kbox/type.VBox.html
[5] https://rust.docs.kernel.org/kernel/alloc/trait.Allocator.html

