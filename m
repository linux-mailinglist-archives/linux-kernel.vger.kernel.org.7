Return-Path: <linux-kernel+bounces-759402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A9B1DD0B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6F35824B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F072147E5;
	Thu,  7 Aug 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmkfJM/L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6F218E96;
	Thu,  7 Aug 2025 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591421; cv=none; b=FdtOD3G524y2wGmiwuYMAe1kFnNhnP08Re72HRNoC0v8QQEG7xxTmJ9vdmQY8WfbbfPIVqnJx6u7nEG9MOF9K06ueovapVptUwAhcJs7xpyZNPrXK3VLtOJjhrsr8E6qRzV2cVsJqPK+3zBXwnXHSOJGa50BNG9EjwzrkqRdIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591421; c=relaxed/simple;
	bh=fvKzj6dUHRc3HjFsvlOPaQYwooIML33QLBDFoF6wir4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=OeTw/lWX1QJT0TgodFqJaxqoVVjA2mJXmZxpQlMVQkR6topc15HCtcGYnsqUSwiDZcTO9sNpE20D1on9+1oDTnIYBuVIV12699YWVfEJ0iHui6q9+BuGmh2fO3GlhN+/25fLp/J1Bb5e4NCcwzy7K/9aBbIjeLBYABjU3hi5MQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmkfJM/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7A2C4CEEB;
	Thu,  7 Aug 2025 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754591420;
	bh=fvKzj6dUHRc3HjFsvlOPaQYwooIML33QLBDFoF6wir4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=lmkfJM/LS6/7uM1TyYApJ0aWL6Xc7yNpgS1I0uzHlMlTxvDhBTz5h8jtlKu8jhaxe
	 q5XLt+pxPU3vUy/IwD3lXnX7/BeC9DVmiroVtHbiuL/SsUq2WXQPalfysR5OBK/xtP
	 nxSygpIcW/9nAK92lvoIRPa9tBwrU1S0M7KhKrcv/3LVfKqfBUch6ahNTFQoIF6oQQ
	 z6KQc+1xDkeZYzap5py/DsIUOGBG8caN/UROmEZ9834uop1nnz8qDxP/oIsN1iyCoJ
	 dSWzwbXWHe/MeyRErzxAYf0gFZxlnP3Qd6BF6nUMCzgKEk4ZIPHwJT0KrD+PQhlqJf
	 ABHHa4Kw494nQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Aug 2025 20:30:15 +0200
Message-Id: <DBWEQWVWLJWA.2JHS152T8YSO1@kernel.org>
Subject: Re: [PATCH 2/3] rust: maple_tree: add MapleTree::lock() and load()
Cc: "Gary Guo" <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Andrew
 Ballance" <andrewjballance@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <maple-tree@lists.infradead.org>, <rust-for-linux@vger.kernel.org>,
 <linux-mm@kvack.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-2-27a3da7cb8e5@google.com>
 <20250726165020.46880c31.gary@garyguo.net>
 <CAH5fLgi-3oT8+5Krzrg5JeagJMm6-8FNVr5G-UAszuhi0qZ1xA@mail.gmail.com>
 <CAH5fLgjB7-xJ2OjVa6nxnUPk-1+wyxPMWQ15-Vc3mUp36+_Rhg@mail.gmail.com>
 <20250727130257.3549ea3c.gary@garyguo.net>
 <imzcbuqlhj3dhzxyk7t44pt3ufxckwlonuqpsdohxuztvk3sss@z4douqoxmxqw>
In-Reply-To: <imzcbuqlhj3dhzxyk7t44pt3ufxckwlonuqpsdohxuztvk3sss@z4douqoxmxqw>

On Thu Aug 7, 2025 at 6:15 PM CEST, Liam R. Howlett wrote:
> * Gary Guo <gary@garyguo.net> [250727 08:03]:
>> On Sat, 26 Jul 2025 18:18:02 +0200
>> Well, `Lock::from_raw` is designed to interact with a C-side lock:
>>=20
>> > Construct a Lock from a raw pointer
>> >
>> > This can be useful for interacting with a lock which was initialised o=
utside of Rust.
>>=20
>
> If it matters for future build out, the tree supports an external lock
> that may not be a spinlock.  This is currently used by the mm for the
> vma management, and others (although willy wants it to go away
> eventually).

When I was considering maple tree for GPUVM, i.e. vma management for GPUs, =
I
would have needed the external lock as well. For GPU VMA management we have
section for which we have to ensure that the tree won't be altered for a
sequence of sleeping operations.

In the worst case we could have used the internal spinlock and yet have an
external mutex for this purpose; an uncontended spinlock shouldn't be that =
big
a deal to take. So, long story short, I think there may be a few cases wher=
e an
external lock can make sense.

Just to recap why GPUVM couldn't leverage maple tree: we have cases where w=
e
have to pre-allocate multiple entries for the tree, whose ranges are yet un=
known
at the time we need to pre-allocate them. Unfortunately, I can't think of a
solution for this given that in this situation we can't predict the number =
of
new nodes this requires.

If however in the meantime there have been ideas to tackle this please let =
me
know, I'd still love to have maple tree for GPUVM.

- Danilo

