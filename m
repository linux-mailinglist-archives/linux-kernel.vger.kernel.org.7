Return-Path: <linux-kernel+bounces-731647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8F2B057A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C521E7AB99B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCBE2D77FF;
	Tue, 15 Jul 2025 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwrUcIoP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988DC34545;
	Tue, 15 Jul 2025 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574914; cv=none; b=PHtrKWFYwCs5BJDJxNuwH0etvWyPBHl2QxUgh2KacVsPR7ylcVqam1Z/I65XJwb7kPDZpNUo0KRvwS/8ZBD5cD2ofh/w+ZwIh99H65+6XnwASEdIbACg1tzS2mTIXlwp29XNoej4FP25immhDuOC0n42D70c/kl9RWOakkICWfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574914; c=relaxed/simple;
	bh=3fI0sIyC6QvfuLV/Cy0sgafRGz9R2/GQ6EOZB1tSsIg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=QPUbB9dDJHDxEj1bow7GSde1jZaop8HnqTc9N0KgCyWM0fkVnKmGSj+YoBEIBQ1K4fiSK2+PRFX7o3K3JQyeokhsoAjBVHCKRTiqgLthBAH4IpWz6W8P/9X2+5sKvKcEmMH3wfIFe7E3Ykss4cN4wTGTtB9aYUDyEYtTf8MWrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwrUcIoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F71C4CEE3;
	Tue, 15 Jul 2025 10:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752574914;
	bh=3fI0sIyC6QvfuLV/Cy0sgafRGz9R2/GQ6EOZB1tSsIg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=iwrUcIoPUzM98i0KrBucfHAUuQfuqTpdtI5NMJpIU10O1pkI7DnfjVGm7gzHlLjaR
	 OuplIQv6NbXSUw1S+qfqMDzfrOp2Evf/bYCLV0x5Lic88EV/A2WTjMpozZb9v4N0xe
	 o/iz/c1XuE5suiCgipiXi4w7ljeeCD+7LyDDV6VuhVumbh9Tm7P+B/Fahr9KBdq8Zt
	 BQ2U0wFxsi64Xmv1P5w1AP1/McKUkYtCyk+ZSpVyOLUC2kASjv/13+bug8mC54DWDA
	 97ihYZhL0z28BZrZD2QnX7UY+Z3NdEQhcKDQOvaTB1JFGSFO6H7JeZXhP1ZIDPO2rT
	 vCdTJkMOpXfEA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 12:21:49 +0200
Message-Id: <DBCJYEIGYQIG.2E341O2W3LX2S@kernel.org>
Subject: Re: [PATCH 0/3] rust: allocator: Vmalloc: Support alignments larger
 than PAGE_SIZE
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
In-Reply-To: <cover.1752573305.git.zhuhui@kylinos.cn>

Hi Hui,

On Tue Jul 15, 2025 at 11:59 AM CEST, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> There is a TODO in Vmalloc::realloc "Support alignments larger than
> PAGE_SIZE."
>
> These commits make allocator vmalloc support alignments larger than
> PAGE_SIZE.
> The function vrealloc_align is added to vmalloc.c to support reallocating
> aligned vmap pages.
> When Vmalloc::realloc intends to reallocate memory aligned beyond PAGE_SI=
ZE,
> vrealloc_align should be used instead of vrealloc, thus enabling support
> for alignments larger than PAGE_SIZE.

Thanks for the patch!

Please note that there is already a rather progressed patch series addressi=
ng
this [1].

However, I'd be interested in your use-case for alignments larger than
PAGE_SIZE. :)

> And add a sample to the samples memory allocator usage.

The example looks a bit odd, more on that in the corresponding patch.

We already have other examples in the form of documentation tests [2]. Not =
all
of them are for VVec, some of them are for KVec and KVVec, however, they al=
l
share the same code, only the allocator backend differs.

If you'd like to introduce additional examples, please do so in the context=
 of
documentation tests in rust/kernel/alloc/kvec.rs.

If you enable CONFIG_RUST_KERNEL_DOCTESTS they're compiled and executed at =
boot
time.

[1] https://lore.kernel.org/lkml/20250709172345.1031907-1-vitaly.wool@konsu=
lko.se/
[2] https://rust.docs.kernel.org/kernel/alloc/kvec/type.VVec.html

