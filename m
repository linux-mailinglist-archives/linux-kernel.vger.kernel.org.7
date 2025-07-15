Return-Path: <linux-kernel+bounces-731670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AAAB057FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494F04E4D43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6114D2D837B;
	Tue, 15 Jul 2025 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg9BVJUE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C025E2CA9;
	Tue, 15 Jul 2025 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575877; cv=none; b=rrh//UtvBRgXa8RWNT92qHTuVjK//GMtWcLWYhtqq8ti/nB7DJHP+K68m4MHkW5PwdvDx4Oj4zxgowsXCAU7bJcslIFmobVeMDxY7DJPeaUbV5Gjr0jXtPoUtGqJJg/OGwxISPcBWXFBQDOx2OIuxN7Xds9bf/dq8YGoO1k11mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575877; c=relaxed/simple;
	bh=nvxs4JefX2Fe4yKb5WKZ7M6l9ON2bv8gKISzvr7j2i4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=KB4X9bJNPLOyVX6zZhJ80xmJu8X/l+/8JnXKlyB5x7G3VruL3bEzByRHWBWZnk81T0hquTqLOL4VzBLkM86e1kiT/qmtdab/bOQegI0XmtwNAapxh7glq6dk6Lqr3f1LtTec/zDi2x1Qs1bfN/uTxR5TSjsIpgyYV8ExnygPJgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg9BVJUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FC4C4CEF1;
	Tue, 15 Jul 2025 10:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752575877;
	bh=nvxs4JefX2Fe4yKb5WKZ7M6l9ON2bv8gKISzvr7j2i4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=sg9BVJUEjWs0T11lxnAPKFTb5iCEvHqTj6KKLXpyKytQ/mQER+vjv2fmRR6ACiJLO
	 2SVYf2uLn3nM8483OjsXGrxbXD87wLFC4cdhVQmIHDZJogP/DcPiJ32zks10sYS1km
	 dylH8vRsKifhYMF9u5KQw0AX+ssSLXTdv2YcchVagpRIxtUeJxOrRSGe0mxskM12es
	 n7Z+322O01Cll8G+IlSihqBD2Hn2zj2RSDrYi2502JB2XTcHXtPfZSeg1CuegxTOwt
	 ts/JHVlcRmnNRI1CCPSqxpGtVd8PR64ByCtbyV0XLBqPftKzyPt3XrxjLV7USldrok
	 Dhw0+bN+ZI86w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 12:37:52 +0200
Message-Id: <DBCKAOSOMXHB.3IEHVGIH7ZANN@kernel.org>
Subject: Re: [PATCH 3/3] rust: add a sample allocator usage
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Uladzislau Rezki"
 <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Geliang
 Tang" <geliang@kernel.org>, "Hui Zhu" <zhuhui@kylinos.cn>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <rust-for-linux@vger.kernel.org>
To: "Hui Zhu" <hui.zhu@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <cover.1752573305.git.zhuhui@kylinos.cn>
 <ea067b4df1cef7f724a9e8ef0d345087f06ad6a7.1752573305.git.zhuhui@kylinos.cn>
In-Reply-To: <ea067b4df1cef7f724a9e8ef0d345087f06ad6a7.1752573305.git.zhuhui@kylinos.cn>

On Tue Jul 15, 2025 at 11:59 AM CEST, Hui Zhu wrote:
> +impl kernel::Module for RustAllocator {
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        pr_info!("Rust allocator sample (init)\n");
> +
> +        let mut vmalloc_vec =3D KVec::new();
> +        for (size, align) in VMALLOC_ARG {
> +            let (ptr, layout) =3D vmalloc_align(size, align)?;

Ok, I think I get the idea, you want to demonstrate how to use the Allocato=
r
trait for raw memory allocations.

However, doing so is discouraged unless there's really no other way. One ob=
vious
example are Rust's own memory allocation primitives, such as Box and Vec.

So, instead of this raw allocation, you can just use VBox::new() or
VBox::new_uninit() in the following way.

	[repr(align(ALIGN))]
	struct Blob([u8; SIZE]);

	// Creates a vmalloc allocation of size `SIZE` with an alignment of
	// `ALIGN`. The allocation is freed once `b` is dropped.
	let b =3D VBox::<Blob>::new_uninit(GFP_KERNEL)?;

This way you don't have to handle the layout and the Allocator type yoursel=
f and
you also don't have to care about explicitly calling vfree(), VBox does all=
 this
for you.

> +
> +            let (addr, is_ok) =3D check_ptr(ptr, size, align);
> +            if !is_ok {
> +                clear_vmalloc_vec(&vmalloc_vec);
> +                return Err(EINVAL);
> +            }
> +
> +            vmalloc_vec.push((addr, layout), GFP_KERNEL)?;
> +        }
> +
> +        Ok(RustAllocator { vmalloc_vec })
> +    }
> +}

