Return-Path: <linux-kernel+bounces-892045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 315BAC442F0
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 17:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D1484E6A65
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AF13043C7;
	Sun,  9 Nov 2025 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="eW1UA9p3"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F2530216C;
	Sun,  9 Nov 2025 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707514; cv=pass; b=UkcD3ITw+/cl2VC2WlXU5jeXUDTReiRTmYRP5Mqulv9ZwfyTjwckubpV1lw04US4VbNpNj9tCUj2uXBXbMet9FdaMFjdDxO2Uf/ayaOP+5mwkIzPgHlVFwOX/iEK0I0ltvOK+bDxJPaFlj9bA5ObYN7iarfSQMI2X/MKBnmi2ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707514; c=relaxed/simple;
	bh=wyMTuUjI1reFQ+mad2ftXT0L4h7WPE0hx7QG7FkctIw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ncO3cAy9YxS832ZB5wnVGj9Pj6ICd5J2E9IYH8G0ujKr+dLCt6LqfOD886+rrvP7qhTiEXpYtabwr177EHqdFQwHeiY60g3dBBpJGHp/WtWfLMlJ9uNibiuS1Za8Vj2dgmb1FX+IkpTTXNN0MKOhWO85QHGap7vjS5c5XLfmBz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=eW1UA9p3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1762707484; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iaJ22Y8ELSVGGGdBeuDYatFa6C/NG8tZxxNHkLezTIteWZH5+C2hT5J6qBhWoaMOL8G3YOufBQxLv1sftaKb3xKjhs1T89o+3upBDzbj3rGeVD0OadA4Zg8ZBAPlHaydhd4tXKG7TMQsF7CdU2eFRV85sdN8MgmomCa6/8Cc9ig=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762707484; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wyMTuUjI1reFQ+mad2ftXT0L4h7WPE0hx7QG7FkctIw=; 
	b=hE8MpNTIRYZM/dh3x/mMRz9r53hVTYRDM3vGknABg7Q/IVB0l5mlWvPNBppBZCUe+prCBt/Bjf/E0Jx1MXBxZ5zRD3epi3wHuRdTcR9Lt14J6tp30zab8DlocSmOo6anuzuZAg9klJkrf9M3ZFq+VJZkifeY9nzKTAAf63zXFKs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762707484;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=wyMTuUjI1reFQ+mad2ftXT0L4h7WPE0hx7QG7FkctIw=;
	b=eW1UA9p334Xm3sYAuaDy/mMg3F+yzETskp+U0jyQ5+JnxXzkOEU2KrmmaTXh7Jgp
	EO6Q3xUOPJjvv8oYeOQlKCeqmLH5T8T9IbT159O0vakXXTMEYRQRLNER6K2flVLHcu5
	Wkpzx1vG/jwlB6qLJ/Y8NNIAzMMqbdLEk/im50Jg=
Received: by mx.zohomail.com with SMTPS id 176270748174653.74830281785046;
	Sun, 9 Nov 2025 08:58:01 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v5] rust: add new macro for common bitmap operations
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20251109-feat-add-bitmask-macro-v5-1-9d911b207ef4@gmail.com>
Date: Sun, 9 Nov 2025 13:57:45 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 rust-for-linux@vger.kernel.org,
 felipe_life@live.com,
 linux-kernel@vger.kernel.org,
 Lyude Paul <lyude@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB94045A-37FE-4575-90A6-C97E08F2D117@collabora.com>
References: <20251109-feat-add-bitmask-macro-v5-1-9d911b207ef4@gmail.com>
To: Filipe Xavier <felipeaggger@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Filipe,

> On 9 Nov 2025, at 10:31, Filipe Xavier <felipeaggger@gmail.com> wrote:
>=20
> We have seen a proliferation of mod_whatever::foo::Flags
> being defined with essentially the same implementation
> for BitAnd, BitOr, contains and etc.
>=20
> This macro aims to bring a solution for this,
> allowing to generate these methods for user-defined structs.
> With some use cases in KMS and upcoming GPU drivers.
>=20
> Link: =
https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/=
We.20really.20need.20a.20common.20.60Flags.60.20type
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> Suggested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Suggested-by: Lyude Paul <lyude@redhat.com>
> ---
> Changes in v5:
> - Docs: improve macro documentation.
> - Link to v4: =
https://lore.kernel.org/r/20251026-feat-add-bitmask-macro-v4-1-e1b59b4762b=
c@gmail.com
>=20
> Changes in v4:
> - Use enum: changed flag type from struct to enum.
> - Minor fix: airect casting (flag as $ty) instead of field access =
(.0).
> - Link to v3: =
https://lore.kernel.org/r/20250411-feat-add-bitmask-macro-v3-1-187bd3e4a03=
e@gmail.com
>=20
> Changes in v3:
> - New Feat: added support to declare flags inside macro use.
> - Minor fixes: used absolute paths to refer to items, fix rustdoc and =
fix example cases.
> - Link to v2: =
https://lore.kernel.org/r/20250325-feat-add-bitmask-macro-v2-1-d3beabdad90=
f@gmail.com
>=20
> Changes in v2:
> - rename: change macro and file name to impl_flags.
> - negation sign: change char for negation to `!`.=20
> - transpose docs: add support to transpose user provided docs.
> - visibility: add support to use user defined visibility.
> - operations: add new operations for flag,=20
> to support use between bit and bitmap, eg: flag & flags.
> - code style: small fixes to remove warnings.
> - Link to v1: =
https://lore.kernel.org/r/20250304-feat-add-bitmask-macro-v1-1-1c2d2bcb476=
b@gmail.com
> ---
>=20

I don=E2=80=99t see anything wrong with this patch. Please give me a few =
days to test this on Tyr as well.

=E2=80=94 Daniel


