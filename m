Return-Path: <linux-kernel+bounces-879150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4849EC2263F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7175F3B08ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F25B2D7DE9;
	Thu, 30 Oct 2025 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwRkMg6Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834181EB9E3;
	Thu, 30 Oct 2025 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761858926; cv=none; b=XVR60EbIDHNw7UY/aKxGlbn9+3ZFYrN0ZNyWMobXyQgUfWVX3FvgjRBuKTeVjQYkC/fjSqXn1s40XC6YUuGZqbWLT3AL51uddYL3IdQKSKISLSDgLVtnZ3yaBKMNNh6vFG3EAFCZYFRHx+fY9AHVPqcm1lcinMTxvUBtrQdfyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761858926; c=relaxed/simple;
	bh=bHRp7fCzHDOeTJ7ixpsWLTEPGVtsOymLINlTOXNcp7U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tgFvEXR57InybuRbdzRsXW2O/Arm3K0qKehZ/2rGd++WOR2k6n04b2AO06u+M3ps5isXEDB56vS1RnjDoBjmQj8BpQcXeezTAD38UsL/xL4ubOMv7J1a0EqHX2dB0/IcP4GRZWZTtpk+wDtkLFfLYeuzZnCarn9FW90H5Rkovhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwRkMg6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF9AC4CEF8;
	Thu, 30 Oct 2025 21:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761858926;
	bh=bHRp7fCzHDOeTJ7ixpsWLTEPGVtsOymLINlTOXNcp7U=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=OwRkMg6Ycwcp1YxcTViX/4ZeLQuqjZb0FI3Ocprv6x8JntIqprgj3HbdNX8FWJRzG
	 s9MbHyBRc3n4NkZErHGxPT468sNj5dpqjzro7x2KnggM9mkeEM1uP7t42E0NsvXEa/
	 NY5AiIMYBW167CTd0e46KoT/aQAao8x800cFpKoB0ih/xif5avaojiRczP9VYFI7E1
	 2WM6QcdAG22LEHVjoIBPX9KBsu7vL86cL9x0SslWFKcPRQ1boXZWnvF4LQWx2JxuG3
	 gN9mVoNvxZ6XVwrIUXCyGO4mhNK49yBujy1Ua5NQA7zznIV5n+PM2eorlPjL7ic+0G
	 /0eVUKSWdhENw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 22:15:19 +0100
Message-Id: <DDVYV1VT441A.11L5C11F8R7C9@kernel.org>
Subject: Re: [PATCH RFC 1/4] rust: clist: Add abstraction for iterating over
 C linked lists
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, "David Airlie" <airlied@gmail.com>,
 <acourbot@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <nouveau@lists.freedesktop.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-2-joelagnelf@nvidia.com>
In-Reply-To: <20251030190613.1224287-2-joelagnelf@nvidia.com>

On Thu Oct 30, 2025 at 8:06 PM CET, Joel Fernandes wrote:
> Provides a safe interface for iterating over C's intrusive

I'm not sure we're there just yet, I count eight unsafe blocks in the subse=
quent
sample code.

Don't get me wrong, there is no way to make the API safe entirely, but "saf=
e
interface" is clearly a wrong promise. :)

Some more high level comments below.

> +//! // Rust-side struct to hold pointer to C-side struct.
> +//! struct Item {
> +//!     ptr: NonNull<bindings::c_item>,
> +//! }
> +//!
> +//! impl clist::FromListHead for Item {
> +//!     unsafe fn from_list_head(link: *const bindings::list_head) -> Se=
lf {
> +//!         let item_ptr =3D container_of!(link, bindings::c_item, link)=
 as *mut _;
> +//!         Item { ptr: NonNull::new_unchecked(item_ptr) }
> +//!     }
> +//! }

If you just embedd a pointer to the C struct in a struct Item you don't cov=
er
the lifetime relationship.

Instead this should be something like

	#[repr(transparent)]
	struct Entry<T>(Opaque<T>);

or

	struct Entry<'a, T>(NonNull<T>, PhantomData<&'a T>);

where T is the C list entry type.

You can then have a setup where an &Entry borrows from a &CListHead, which
borrows from a Clist.

I'd also provide a macro for users to generate this structure as well as th=
e
corresponding FromListHead impl.

> +//! // Rust wraps and iterates over the list.
> +//! let list =3D unsafe { clist::Clist::<Item>::new(c_list_head) };

This function has a lot of safety requirements that need to be covered.

It also should be, besides the unsafe FromListHead trait, the only unsafe
function needed.

The Clist should ideally have methods for all kinds of list iterators, e.g.
list_for_each_entry_{safe,reverse,continue}() etc.

Of course you don't need to provide all of them in an initial implementatio=
n,
but we should set the direction.

