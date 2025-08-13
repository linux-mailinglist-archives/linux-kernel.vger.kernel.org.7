Return-Path: <linux-kernel+bounces-766482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA391B2470E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B9F1643CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6CE2EBB91;
	Wed, 13 Aug 2025 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXa7pfH+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9252D1F7E;
	Wed, 13 Aug 2025 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080371; cv=none; b=BDF8qNQtNb9/s4ngDWh74oWPxBMm1k+XGpXtPJuiD0JWmO0MdKYkK2MDnrlDqP2xzjFMkJiBOscWX1D84kKetzMacYqWngXzJTI/SPHaGpF7urhmaxlhCmalykHbSPU3Mv/IDP/IVbYeMXrYWX1tkaG/8zcmPbSUh/SYooVA9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080371; c=relaxed/simple;
	bh=qW9SWoWX6A53AFhzzT38jehPPUJjNU69Tw+gWAuHO48=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=gaW6ZPj/rDbZkAUWpGRrgfzv65ie3kLcT+ELs4KB/x/anN6eQQzma1UgLuM2bcKEhC1ugJodjm5hVOQga7d5yzrv6OXIwruYyCyBy0GBDuIQZ0nWyJX34bG2BtnHYwfw5X3IHBn8Z+P4x91A2Gs8MRHaHwAtgYQSTcS07G1qnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXa7pfH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F519C4CEEB;
	Wed, 13 Aug 2025 10:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755080370;
	bh=qW9SWoWX6A53AFhzzT38jehPPUJjNU69Tw+gWAuHO48=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=fXa7pfH+WHcRrIEQTszchLdqLCY1ttHuNL0sPo1YvUXnQLfMGmX6a1e0j9Hiu73Kh
	 A4Se8wYGmsx+9XO2QWPrr6zDMoVWsCH5CmLB+f3l/8WvNQyWBiTjpCWnPY1H/N78c5
	 L5r7+wBDRF/AC/zvx/JOxLAECcN88fYijNDmt7Q75zyc0qnN1HehKPsYEv4clPZwRS
	 dUutqdh/ZIq2f2ykr3GdtwgNMU2QzOA8VpHKwo7t8TO57GuYemALsKywPDxxlpUlEm
	 iOQ5MKjnh/X4q2+nhwzHUxa0jN7c0wihdky9ohKIe5s0/D+C76KuJFPogUV9fLkldD
	 jTdrx+qbeILYw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 12:19:25 +0200
Message-Id: <DC182DB9HNS9.21ZVBYT6DXHDE@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: alloc: specify the minimum alignment of
 each allocator
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Matthew Wilcox" <willy@infradead.org>, "Tamir Duberstein"
 <tamird@gmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-mm@kvack.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
 <20250811-align-min-allocator-v2-1-3386cc94f4fc@google.com>
 <DC0N2SBVHIS7.2P91EJSTIT1FM@kernel.org> <aJxESG0l4-kyUHXg@google.com>
 <DC16OLU29VX3.16T0QDJF7Q18P@kernel.org>
 <CAH5fLgj0kjGBwZFHjErsa7MCV1fz4xTWwrZAcFzHHnkbvS=OMg@mail.gmail.com>
In-Reply-To: <CAH5fLgj0kjGBwZFHjErsa7MCV1fz4xTWwrZAcFzHHnkbvS=OMg@mail.gmail.com>

On Wed Aug 13, 2025 at 11:32 AM CEST, Alice Ryhl wrote:
> On Wed, Aug 13, 2025 at 11:14=E2=80=AFAM Danilo Krummrich <dakr@kernel.or=
g> wrote:
>>
>> On Wed Aug 13, 2025 at 9:52 AM CEST, Alice Ryhl wrote:
>> > On Tue, Aug 12, 2025 at 07:52:35PM +0200, Danilo Krummrich wrote:
>> >> On Mon Aug 11, 2025 at 2:31 PM CEST, Alice Ryhl wrote:
>> >> > diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/all=
ocator.rs
>> >> > index aa2dfa9dca4c309e5a9eafc7da6a8a9bd7b54b11..25fc9f9ae3b4e471a08=
d77130b374bd1397f7384 100644
>> >> > --- a/rust/kernel/alloc/allocator.rs
>> >> > +++ b/rust/kernel/alloc/allocator.rs
>> >> > @@ -17,6 +17,8 @@
>> >> >  use crate::bindings;
>> >> >  use crate::pr_warn;
>> >> >
>> >> > +const ARCH_KMALLOC_MINALIGN: usize =3D bindings::ARCH_KMALLOC_MINA=
LIGN as usize;
>> >>
>> >> I think this needs the following diff:
>> >>
>> >> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings=
_helper.h
>> >> index 84d60635e8a9..4ad9add117ea 100644
>> >> --- a/rust/bindings/bindings_helper.h
>> >> +++ b/rust/bindings/bindings_helper.h
>> >> @@ -84,6 +84,7 @@
>> >>
>> >>  /* `bindgen` gets confused at certain things. */
>> >>  const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN =3D ARCH_SLAB_MINA=
LIGN;
>> >> +const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN =3D ARCH_KMALLO=
C_MINALIGN;
>> >>  const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;
>> >>  const gfp_t RUST_CONST_HELPER_GFP_ATOMIC =3D GFP_ATOMIC;
>> >>  const gfp_t RUST_CONST_HELPER_GFP_KERNEL =3D GFP_KERNEL;
>> >> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/alloc=
ator.rs
>> >> index 25fc9f9ae3b4..5003907f0240 100644
>> >> --- a/rust/kernel/alloc/allocator.rs
>> >> +++ b/rust/kernel/alloc/allocator.rs
>> >> @@ -17,7 +17,7 @@
>> >>  use crate::bindings;
>> >>  use crate::pr_warn;
>> >>
>> >> -const ARCH_KMALLOC_MINALIGN: usize =3D bindings::ARCH_KMALLOC_MINALI=
GN as usize;
>> >> +const ARCH_KMALLOC_MINALIGN: usize =3D bindings::ARCH_KMALLOC_MINALI=
GN;
>> >>
>> >>  /// The contiguous kernel allocator.
>> >>  ///
>> >>
>> >>
>> >> No need to resend I can fix it up when applying the patch.
>> >
>> > Hmm. Maybe that depends on the configuration? The constant was generat=
ed
>> > for me. Either way, happy with the suggested change.
>>
>> That is a bit odd, I'd like to understand this before merging.
>>
>> All of the definitions in the kernel are defines that shouldn't be picke=
d up by
>> bindgen.
>
> It is possible for bindgen to pick up a #define in some cases. The
> main case where bindgen fails is when the macro is defined in terms of
> a function-like macro. This is why we see so many failures with _IO*
> macros.

I think I see it now, ARCH_KMALLOC_MINALIGN seems to be either a literal or
__alignof__(unsigned long long), either directly or indirecty through
ARCH_DMA_MINALIGN. bindgen doesn't like the __alignof__() extension.

So, I assume you were on arm64? :)

