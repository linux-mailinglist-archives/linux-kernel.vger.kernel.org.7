Return-Path: <linux-kernel+bounces-735158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596CDB08B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1EF58581D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027FE299959;
	Thu, 17 Jul 2025 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKzjy+23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB61289367;
	Thu, 17 Jul 2025 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751151; cv=none; b=pcj/Tusp2keBSjV5aw00j4eZGwdX/OW5wgeWxjfPpIex0kq7GVm7KhhLme19seRoxmYnjIe5JzjPEeTrmphOCVQ4Tt/wbT1ONkm801GTX5zshvsNJftX/KPnIPZpOl/ZJWxtrfhOTUvJOswXae58rAvJJwTZ3TgU/LbXoeeuWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751151; c=relaxed/simple;
	bh=UGme35FMYts4C+w0JEhpFk9WMpbpTAudZRkRDn7b2nw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=qDI1jEeaTJuSdys2kkXgN62q17ftefZmpiH2CloPhb9sEzRbIq/KttA7zc5PBjy3BG1EJJg7g+Vere1lOhsJpyww8EZRTpsTmD7qGuXzEHeaH9i5jPsfTbO8JPii4spV0OTVblCbOyI385L++S/ZhInIlH1UT2t/Ov3tAby8t84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKzjy+23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D773C4CEE3;
	Thu, 17 Jul 2025 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752751151;
	bh=UGme35FMYts4C+w0JEhpFk9WMpbpTAudZRkRDn7b2nw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=OKzjy+233mvOwYar9R1WZxxyhXVS/VNF+OjpeRyyzXy+9AQVnO8C6tSNiTxNgN1JO
	 LptR++4v6Aslau5497vxGp0yIwBV74Kcjl4DevatuT7ZqstnNKIcXBXqbEkhgiMAST
	 qUdo4l+yxl6N+vtLQfyI7HcxLFQK7uFVHg4EWsWia4vX/2TZcMoqMuNSdiieDO5EE6
	 Md9GGo64q7f+vktG8iQ2XE1iLrUk+AT53hRzS/jLx7T5PieDAJPjCq1qiyx5Pq6LEA
	 o6wbbZbYJqPA0d29BO2SsItyvknesQ9KkyB4yTDXer7ZcCNvTBxWL2BnVv0R8CbiTY
	 U8MxDSaWsmgLw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Jul 2025 13:19:05 +0200
Message-Id: <DBEAFCFHFU35.1IZI3ZSJSIRAY@kernel.org>
Subject: Re: [PATCH v2] rust: add a sample alloc usage
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Hui Zhu"
 <zhuhui@kylinos.cn>, "Geliang Tang" <geliang@kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Uladzislau Rezki" <urezki@gmail.com>
To: "Hui Zhu" <hui.zhu@linux.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250717095053.49239-1-hui.zhu@linux.dev>
In-Reply-To: <20250717095053.49239-1-hui.zhu@linux.dev>

(Cc: Lorenzo, Vlastimil, Liam, Uladzislau)

On Thu Jul 17, 2025 at 11:50 AM CEST, Hui Zhu wrote:
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index bd2faad63b4f..7c3e68d9ada5 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+=3D rust_dri=
ver_platform.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+=3D rust_driver_faux.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+=3D rust_driver_auxiliary.o
>  obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+=3D rust_configfs.o
> +obj-$(CONFIG_SAMPLE_RUST_ALLOC)		+=3D rust_alloc.o

I think adding an example for large alignment is fine, but let's do this in=
 a
doc-test on VBox in rust/kernel/alloc/kbox.rs. I think adding a separate mo=
dule
for this is overkill.

Note that doc-tests are executed on boot if CONFIG_RUST_KERNEL_DOCTESTS=3Dy=
.

> diff --git a/samples/rust/rust_alloc.rs b/samples/rust/rust_alloc.rs
> new file mode 100644
> index 000000000000..61efde37b5f2
> --- /dev/null
> +++ b/samples/rust/rust_alloc.rs
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (c) 2025, Kylin Software
> +
> +//! Rust alloc sample.
> +
> +use kernel::bindings;
> +use kernel::prelude::*;
> +
> +module! {
> +    type: RustAlloc,
> +    name: "rust_alloc",
> +    authors: ["Rust for Linux Contributors"],
> +    description: "Rust alloc sample",
> +    license: "GPL",
> +}
> +
> +const VBOX_SIZE: usize =3D 1024;
> +const VBOX_LARGE_ALIGN: usize =3D bindings::PAGE_SIZE * 4;

Please use kernel::page::PAGE_SIZE instead.

> +const KVEC_VAL: [usize; 3] =3D [10, 20, 30];
> +
> +#[repr(align(128))]
> +struct VboxBlob([u8; VBOX_SIZE]);
> +
> +// This structure is used to test the allocation of alignments larger
> +// than PAGE_SIZE.
> +// Since this is not yet supported, avoid accessing the contents of
> +// the structure for now.
> +#[allow(dead_code)]
> +#[repr(align(8192))]
> +struct VboxLargeAlignBlob([u8; VBOX_LARGE_ALIGN]);
> +
> +struct RustAlloc {
> +    vbox_blob: VBox<VboxBlob>,
> +    kvec_blob: KVec<usize>,
> +}
> +
> +fn check_align(addr: usize, align: usize) -> bool {
> +    debug_assert!(align.is_power_of_two());
> +    if addr & (align - 1) !=3D 0 {
> +        pr_err!("Address {:#x} is not aligned with {:#x}.\n", addr, alig=
n);
> +        false
> +    } else {
> +        true
> +    }
> +}

I think check_align() is unnecessary -- we don't need to test this in this
context.

Instead, I suggest to add some doc-tests to the `Allocator` impls for `Kmal=
loc`,
`Vmalloc` and `KVmalloc` in rust/kernel/alloc/allocator.rs testing that the=
y
return the expected alignment. This would be a valuable test case for those=
. If
you're interested in adding them, please feel free to do so. :)

> +impl kernel::Module for RustAlloc {
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        pr_info!("Rust allocator sample (init)\n");
> +
> +        let vbox_blob =3D VBox::<VboxBlob>::new_uninit(GFP_KERNEL)?;
> +        if !check_align(vbox_blob.as_ptr() as usize, 128) {
> +            return Err(EINVAL);
> +        }
> +        let vbox_blob =3D vbox_blob.write(VboxBlob([0xfeu8; VBOX_SIZE]))=
;

Given that you initialize it with a value anyways, you can just do

	let blob =3D VBox::new(Blob([0xfeu8; SIZE]), GFP_KERNEL)?;

instead.

> +        if let Ok(_) =3D VBox::<VboxLargeAlignBlob>::new_uninit(GFP_KERN=
EL) {
> +            pr_err!("Allocations for VBox with alignments larger than PA=
GE_SIZE should fail, but here it succeeded.\n");
> +            return Err(EINVAL);
> +        }

This can just be

	assert!(VBox::<VboxLargeAlignBlob>::new_uninit(GFP_KERNEL).is_err());

within a doc-test.

> +        let mut kvec_blob =3D KVec::new();
> +        kvec_blob.extend_from_slice(&KVEC_VAL, GFP_KERNEL)?;

We already have doc-tests for KVec::new() and KVec::extend_from_slice() in
rust/kernel/alloc/kvec.rs.

> +        Ok(Self {
> +            vbox_blob,
> +            kvec_blob,
> +        })
> +    }
> +}
> +
> +impl Drop for RustAlloc {
> +    fn drop(&mut self) {
> +        pr_info!("Rust allocator sample (exit)\n");
> +
> +        // check the values
> +        for b in self.vbox_blob.0.as_slice().iter() {
> +            if *b !=3D 0xfeu8 {
> +                pr_err!("vbox_blob contains wrong values\n");
> +            }
> +        }
> +
> +        if self.kvec_blob.as_slice() !=3D KVEC_VAL {
> +            pr_err!("kvec_blob contains wrong values\n");
> +        }

Here you're basically testing Vec::as_slice(). We don't have doc-tests for
as_slice() and as_slice_mut() in rust/kernel/alloc/kvec.rs. Please feel fre=
e to
add them. :)

> +    }
> +}


