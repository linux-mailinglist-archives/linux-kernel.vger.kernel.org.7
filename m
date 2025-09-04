Return-Path: <linux-kernel+bounces-800572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB5DB43975
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38DF1C8110D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6FE2FC001;
	Thu,  4 Sep 2025 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="gBHU3Amu"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846CB1917FB;
	Thu,  4 Sep 2025 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983776; cv=pass; b=ADmXjcoKHvIH99yN1wLc41c6wY3oQxRgjtNq7slWYTr8E4jZxkRR2Aujt8x3EdgtYFcFDP3gJKyhv5y8hlC1dBfw4/PXUSqvTrMilinOz3eBTI3FLuLTBlDV1kSu0KMvVP+K2uDDxeFI++ACdx71u7aHUm9WUhmefbxt6DLOwYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983776; c=relaxed/simple;
	bh=3UgIibTB47PeQZqU+bSLcHe5zQ85KUGU4yiKuuPW16U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KXP7oCtg+TgRY/wXpQEiN2D+Dp6v/qeJzKmipwbUD0LqWNo9BHFGXCqydoJvIAFxdGhB7c/Uzva2WUhNfQp0pKmEWIoAqpiXIgKMteUR7mE9hBisiVmCBxvvQ0qaRGWmIT1yjtclkV3nyT73GJ+4HdaA21CQ9p/DipuB3jQxMT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=gBHU3Amu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756983757; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YGrZaiFXgz/dcAD/GhG5qWejTWpckke2xtxufSRxDWuIJ8TfsHzsQxzSDX1D1IstkMHOGXUlrdb4GRh0IHLqvh5GLRU0VgsT2nAVtVGcyIr8h/jnKsRO3FhUEoVY1wlOvYsnh2+gXQnqHXqgSWQVQ2yYffpbMCdybTmSIuZbIZ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756983757; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M+c8sBfNK7jTMhcj9S/0VC9pw8RniI4xywgLwf5sppE=; 
	b=bCvYFODO7/KwS+25DN9Px9ISAIUCdCXbhvPcsqXI9TlcLdCp0D1SXxr7hmoIqTni/oj23iG0zWqhnl8s/UZSRsdl4rBmc3Zv0XdOmmL8TAYN3l5QV0t0Dsot0n08onTDCYznArS1n710ERwgk3DfUu9VIc4cwABpL/aXshgkOYU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756983756;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=M+c8sBfNK7jTMhcj9S/0VC9pw8RniI4xywgLwf5sppE=;
	b=gBHU3AmuyBe8B5E0E8wU5a6jJhJv1uugBOQrrisM+9rIaGMuTo8Rcf4quNHKP8E0
	liL6RHiyLZ6rYKSeMfr2d25Il4g17l2rBOreViwmNCxDBEfQbJOCCG+eXjGd8HLPd3R
	wDIwvWOs8v6Sw3RcjnY+u0UYYMf5EUjtrWad5Z70=
Received: by mx.zohomail.com with SMTPS id 1756983753966635.954770851991;
	Thu, 4 Sep 2025 04:02:33 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 1/2] nova-core: Add a library for bitfields in Rust
 structs
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DCJOUO214EXC.32MFBN80VJW3K@nvidia.com>
Date: Thu, 4 Sep 2025 08:02:16 -0300
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 linux-kernel@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8498F151-B4DF-43D3-981E-FAE598964CA2@collabora.com>
References: <20250824135954.2243774-1-joelagnelf@nvidia.com>
 <DCBGLCQVD1RF.6V5UT0NQ4GLB@nvidia.com>
 <444ebd64-7a90-46a6-b885-2c114aa59284@nvidia.com>
 <DCJOUO214EXC.32MFBN80VJW3K@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 4 Sep 2025, at 00:16, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> On Thu Sep 4, 2025 at 12:15 AM JST, Joel Fernandes wrote:
> <snip>
>>>> +use kernel::prelude::*;
>>>> +
>>>> +/// Macro for defining bitfield-packed structures in Rust.
>>>> +/// The size of the underlying storage type is specified with =
#[repr(TYPE)].
>>>> +///
>>>> +/// # Example (just for illustration)
>>>> +/// ```rust
>>>> +/// bitstruct! {
>>>> +///     #[repr(u64)]
>>>> +///     pub struct PageTableEntry {
>>>> +///         0:0       present     as bool,
>>>> +///         1:1       writable    as bool,
>>>> +///         11:9      available   as u8,
>>>> +///         51:12     pfn         as u64,
>>>> +///         62:52     available2  as u16,
>>>> +///         63:63     nx          as bool,
>>>=20
>>> A note on syntax: for nova-core, we may want to use the `H:L` =
notation,
>>> as this is what OpenRM uses, but in the larger kernel we might want =
to
>>> use inclusive ranges (`L..=3DH`) as it will look more natural in =
Rust
>>> code (and is the notation the `bits` module already uses).
>>=20
>> Perhaps future add-on enhancement to have both syntax? I'd like to =
initially
>> keep H:L and stabilize the code first, what do you think?
>=20
> Let's have the discussion with the other stakeholders (Daniel?). I =
think
> in Nova we want to keep the `H:L` syntax, as it matches what the =
OpenRM
> headers do (so Nova would have its own `register` macro that calls =
into
> the common one, tweaking things as it needs). But in the kernel crate =
we
> should use something intuitive for everyone.
>=20

I don=E2=80=99t specifically care which syntax is used. We will adapt to =
it.

=E2=80=94 Daniel


