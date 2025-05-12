Return-Path: <linux-kernel+bounces-644035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14278AB35D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 13:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1ED168BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E512918D2;
	Mon, 12 May 2025 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="R3LxhEyL"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02A291886;
	Mon, 12 May 2025 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747048865; cv=pass; b=BGPBYVbLZRbHvriB8vdm9nAGHUFr4IGb5yTOpOhm/wgqqN2n8NJ4dr0zxF3JQfP7rG8av28FngZhV07QTkLMZqNoLUrJDL9pEET/rivbpg7W/vSbJZ+ia9vKBJYGNgurOd5k750UFZUEMTi6pcIyWQDzSMz8Qs4G6SzZkKBHMw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747048865; c=relaxed/simple;
	bh=fmR6fYqFrhWsjxGe1HOlntFlYUX6RV99vix96HuSf/Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=s7oyHmRMeoB85nY2H5MwlHP1tnuFUQgQZntIdCBWMcZTPNa61fvOKDqqQGn8venARuIywBYB4SH1+ObM/NUOyhHR2pZG9bp8Wy+gssR1kOxjk/8OLLq/Ok2wPls7XVlc6dtO9y+LYnXy4QXBtQajYG1oWV4TxeB5AcZbqjZJ0u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=R3LxhEyL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1747048809; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IGKqITX6Hjk690RY4FGEkhcu0uueDzYWH+OLU72fXnXH6OOjN7ZatAhSq64w3SvZnjFb4K7mPg78q/+VY6Cy/UgVseEW17UQ0plnO+1zKo7Zp0zrrN1mKzoriGnzcfMbpPm/H4TC+NoxwFJyxE9YH09oFkW4mqrLzNnXXeTpexc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747048809; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=g90Nw/fmAwO4pS0osmfC5pCtVd1LdCVyskY3AiteFZ8=; 
	b=GSz+wyQ0B6J5lticVKsosdIHC/sAwq6EkWhn+PJ9fdBFQDAolCQYBoMYPZDkVMiTnz345VHIf8cGZv0VOg+MyURqAPNnoknsrIs2Re6qZ8Duj5MpwIKheuCbvSLYnjr6GeBEJU+JyJTNrIVROm6ENaDTF/cOwDHsNprxCFGeuC4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747048809;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=g90Nw/fmAwO4pS0osmfC5pCtVd1LdCVyskY3AiteFZ8=;
	b=R3LxhEyLq2DqfFYmblbWb4c+h3W1emUUlpHrUoLXj01DG1IuMN1Guo4mY/Kp6YFw
	IprYx4QLCd3qwdqfNiVVsonHKMMiRVdYpAcTn53vRBcgZqED4b0hu/QS6OZDRm1wgBO
	Rl/5YiS0EOBOTaJQFoGiM1VJYjH5nTYtW1kQ2wAk=
Received: by mx.zohomail.com with SMTPS id 1747048806755289.84670803140045;
	Mon, 12 May 2025 04:20:06 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [RFC PATCH 0/2] scatterlist rust bindings
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
Date: Mon, 12 May 2025 08:19:48 -0300
Cc: dakr@kernel.org,
 lyude@redhat.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 airlied@redhat.com,
 rust-for-linux@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Petr Tesarik <petr@tesarici.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sui Jingfeng <sui.jingfeng@linux.dev>,
 Randy Dunlap <rdunlap@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <78DB1F66-9DF5-4679-ADC4-177BED5D4FDE@collabora.com>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-ZohoMailClient: External

Hi Abdiel,

> On 12 May 2025, at 06:53, Abdiel Janulgue <abdiel.janulgue@gmail.com> =
wrote:
>=20
> Hi,
>=20
> Here are the scatterlist bindings that has been brewing for a while in =
my
> local tree while working with Nova code. The bindings are used mostly =
to
> build the radix3 table from the GSP firmware which is loaded via dma.
> This interface can be used on top of existing kernel scatterlist =
objects
> or to allocate a new one from scratch.
>=20
> Some questions still need to be resolved, which mostly come from
> the DeviceSGTable::dma_map() function. Primarily, what if you call
> bindings::dma_map_sgtable() on an already mapped sg_table? =46rom my

Perhaps we should introduce a type for buffers which are known to be =
mapped. Then
we can simply not offer the option to map for that type.

> experiments it doesn't seem to do anything and no indication is =
returned if
> the call succeeded or not. Should we save the "mapping info" to a list
> everytime we call DeviceSGTable::dma_map more than once?

What mapping info are you referring to?

>=20
> Hoping this initial submission will generate some discussion. I'd like =
to
> acknowledge valuable feedback from Danilo Krummrich and Lyude
> Paul in shaping this up.
>=20
> Abdiel Janulgue (2):
>  rust: add initial scatterlist bindings
>  samples: rust: add sample code for scatterlist bindings
>=20
> rust/bindings/bindings_helper.h |   1 +
> rust/helpers/helpers.c          |   1 +
> rust/helpers/scatterlist.c      |  25 +++
> rust/kernel/lib.rs              |   1 +
> rust/kernel/scatterlist.rs      | 275 ++++++++++++++++++++++++++++++++
> samples/rust/rust_dma.rs        |  14 +-
> 6 files changed, 316 insertions(+), 1 deletion(-)
> create mode 100644 rust/helpers/scatterlist.c
> create mode 100644 rust/kernel/scatterlist.rs
>=20
>=20
> base-commit: dd21715de3dfa6f6457432ce909e5f7eb142a7d2
> --=20
> 2.43.0
>=20
>=20

=E2=80=94 Daniel=20


