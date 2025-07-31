Return-Path: <linux-kernel+bounces-751830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF86B16E03
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0983AEBB0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE9A293C4E;
	Thu, 31 Jul 2025 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh/LSoBf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF721FF4C;
	Thu, 31 Jul 2025 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952311; cv=none; b=eT1zKCCN3TUC0LfpZYLtJqZ1QiSAdGlrwX+qi2lroutwcejRLYcWO0+htJ6z15L2KHu3a7zE8zo+Cp5nF/1oTMM5isPy9BJyeF/zFAetxpczqYuZKr9DAXHk8J0h/8kTIutK8qJOVx1DbJBVsXR6al0MATmFLjb3BXFl+IH1+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952311; c=relaxed/simple;
	bh=qeojfxxmvccb8pcM2MlJHVnLYHKrVRTET31iGr7Az2s=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=sfBIxcPteb8EQ1QW3FitmyVWnX5WNmmXIHy2MfJNJjTgelPi8T68Slw7QqKK0TRgZlzkBovlGvrrUOT2jQzTQqmQrNbTOPd0MpvS3Kucjh88g0g8Ff5s/Widt4Oyn8H+6cSE7609VN+1wFhZYh6Qzt/Cxw7bZMHhTS21ZwozuAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh/LSoBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA20C4CEEF;
	Thu, 31 Jul 2025 08:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753952310;
	bh=qeojfxxmvccb8pcM2MlJHVnLYHKrVRTET31iGr7Az2s=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=gh/LSoBfN/GBT7+81naGv3phw0mqi1vcV3yniK5LJHnepstSOcLXhaBAutaJJMeIc
	 aV/8TlM4r+Tm+TDm6UufXuFl9VHxoAibrLvvTjAx9TQvUZMDM9ylMFDxpFMDbCPTvo
	 NO+tB6CaGkyrbj3m8RWrklsiquXhE48BQ3snGtgS0U42vrQULzWsVHVvYAuX6SZcqr
	 /RwWOlqqR6nghwSe3WCp7hFdQDv2LTuve/PXOVPE9d303bTpkXXvCQ5XbTMjycwYyd
	 snlAKCWs2o9z9a+vtK2CkJNXcY2P9qd5YIcuZE6r6dosmdtkX8qIjPrCzoDSmMfOUP
	 4AksBl09Q96dw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Jul 2025 10:58:24 +0200
Message-Id: <DBQ4795SDGV1.3N78SF2Q0VC1P@kernel.org>
To: "Hui Zhu" <hui.zhu@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v8 1/2] rust: alloc: add alignment tests for allocators
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Vlastimil Babka"
 <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <akpm@linux-foundation.org>, <vitaly.wool@konsulko.se>, "Hui Zhu"
 <zhuhui@kylinos.cn>, "Geliang Tang" <geliang@kernel.org>, "Kunwu Chan"
 <chentao@kylinos.cn>, "David Gow" <davidgow@google.com>
References: <cover.1753950392.git.zhuhui@kylinos.cn>
 <420a72447bf1947a3d0f2622fe6e22fe2fd0c776.1753950392.git.zhuhui@kylinos.cn>
In-Reply-To: <420a72447bf1947a3d0f2622fe6e22fe2fd0c776.1753950392.git.zhuhui@kylinos.cn>

On Thu Jul 31, 2025 at 10:42 AM CEST, Hui Zhu wrote:
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator=
.rs
> index 63f271624428..a20111b40529 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -184,3 +184,59 @@ unsafe fn realloc(
>          unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, fl=
ags, nid) }
>      }
>  }
> +
> +#[macros::kunit_tests(rust_allocator)]
> +mod tests {
> +    use super::*;
> +    use core::mem::MaybeUninit;
> +    use kernel::prelude::*;
> +

<snip>

> -#[macros::kunit_tests(rust_kvec_kunit)]
> +#[macros::kunit_tests(rust_kvec)]
>  mod tests {
>      use super::*;
>      use crate::prelude::*;

I think v7 was fine. David probably confused "rust_allocator" with "rust_kv=
ec".
Renaming the kvec kunit tests should, as you correctly did in v7, indeed be=
 a
separate patch.

No need to resend now, I think we can just pick v7.

In general, please send new version a little bit less frequent to leave som=
e
time for people to comment.

Thanks,
Danilo

