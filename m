Return-Path: <linux-kernel+bounces-765375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219DFB23096
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C895262512D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1329E2FDC57;
	Tue, 12 Aug 2025 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDf+4lx4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB9268C73;
	Tue, 12 Aug 2025 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021160; cv=none; b=tesbhR5ps+9sP8Tj/V2l4lpouSMa95qIwoXZ2LwUfyhJjO7jJLYjGNJHkRFILeCm1CoQR01nwdv2UbuHBYNO0gGbr70eXKcXEumE+tPcUWCXkTTkYMh7ftZxzatYiGwMuv6J2YTSUudmziVIjTegeptapVrQIWLuVVDl4Z9h+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021160; c=relaxed/simple;
	bh=HrWt7KsFmQFhR+gbni5exLfgmFjQs3b24up4/s6MmUg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=a0IaZD9hXM/rswVsx0XKBPR7gWadtHkRCNx7gmNUI1arpPyFU49if6jp6VmXUaAIxPsLBj/IOkmAPqRyJyE0Z+A+00KO/5NWKu6O+VQnWjQ17ICBcKkOW/ewBu7G/fahdPBQua01CYCjkpVslvn2XoT6yC2WEEx1uY1t1hvMpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDf+4lx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48EFC4CEF6;
	Tue, 12 Aug 2025 17:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755021159;
	bh=HrWt7KsFmQFhR+gbni5exLfgmFjQs3b24up4/s6MmUg=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=EDf+4lx4IuM9rw8qi4wI1aL1fFeQH/N1+zaWTH51ERi8hnA7G07qo26tb3konaG7C
	 sMqCLR2++PPj/UJzbowqN3eJHrxckicnDUjnrPXqS426jZIuJuQqTnQwV7+9TTKNpE
	 ryRfutW6sZyjUFRqYcRpiY5mugzhPWIbv2HC0Ivbe/4zPfeFBzg/BxKlcDHdK9+Slp
	 aXAMyKg+rbnfEmYb8gKgzuIHKc/kha6hu4YVSfA6suInHQO2SDLrrzMRDsnYmIb+u7
	 Rt1ask5T+OWQCX0BGHsZr+mkNLbQV54y60NM2DEWzXbKR4NJl1weaKKPE8+JQy5wAq
	 iMpJ232uW+npg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 19:52:35 +0200
Message-Id: <DC0N2SBVHIS7.2P91EJSTIT1FM@kernel.org>
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
Subject: Re: [PATCH v2 1/2] rust: alloc: specify the minimum alignment of
 each allocator
References: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
 <20250811-align-min-allocator-v2-1-3386cc94f4fc@google.com>
In-Reply-To: <20250811-align-min-allocator-v2-1-3386cc94f4fc@google.com>

On Mon Aug 11, 2025 at 2:31 PM CEST, Alice Ryhl wrote:
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator=
.rs
> index aa2dfa9dca4c309e5a9eafc7da6a8a9bd7b54b11..25fc9f9ae3b4e471a08d77130=
b374bd1397f7384 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -17,6 +17,8 @@
>  use crate::bindings;
>  use crate::pr_warn;
> =20
> +const ARCH_KMALLOC_MINALIGN: usize =3D bindings::ARCH_KMALLOC_MINALIGN a=
s usize;

I think this needs the following diff:

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helpe=
r.h
index 84d60635e8a9..4ad9add117ea 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -84,6 +84,7 @@

 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN =3D ARCH_SLAB_MINALIGN;
+const size_t RUST_CONST_HELPER_ARCH_KMALLOC_MINALIGN =3D ARCH_KMALLOC_MINA=
LIGN;
 const size_t RUST_CONST_HELPER_PAGE_SIZE =3D PAGE_SIZE;
 const gfp_t RUST_CONST_HELPER_GFP_ATOMIC =3D GFP_ATOMIC;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL =3D GFP_KERNEL;
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.r=
s
index 25fc9f9ae3b4..5003907f0240 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -17,7 +17,7 @@
 use crate::bindings;
 use crate::pr_warn;

-const ARCH_KMALLOC_MINALIGN: usize =3D bindings::ARCH_KMALLOC_MINALIGN as =
usize;
+const ARCH_KMALLOC_MINALIGN: usize =3D bindings::ARCH_KMALLOC_MINALIGN;

 /// The contiguous kernel allocator.
 ///


No need to resend I can fix it up when applying the patch.

