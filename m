Return-Path: <linux-kernel+bounces-734141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFBAB07D82
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1BD4A11D9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAD829C347;
	Wed, 16 Jul 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Gl4LSMeT"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32B25C713;
	Wed, 16 Jul 2025 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693540; cv=pass; b=EkLeQhp+AXMvcVAk/zmfLsXAD3V+wpsxjgHuPzdepU3i58a1xm77hjfcp4O6n44pSXZ1mHIv3POg5lYboSgW74lLpOMs/D9Q6P0PmIzCSLOeqBuXg3rfD2UvgdxEYlbVJZn+tecGXHs9fQI0IMh9B4tF5vDdZ3je+nwVv4A0YX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693540; c=relaxed/simple;
	bh=4m8zHCOak+f62EPi329BsZxzSPeANIfks1AjdMIncco=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GV5Uabn7Ifm3BaQJuurnHn3gasWqXKnHhgab6qUczpjjEBswcgnHl/jM6ufEci8lOPD9mBX4zUYJfpEWjp/SpNIzGApT4zjZb3h66J7uH9bKQ8So9EO1GSk5pl4Isz0C6KIU9E2RycKNVX8kb/Fc3LwuK0342cntx9wUPfgKSJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Gl4LSMeT; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752693525; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Pyfn0YbHkkP522Ho62leSs31UlOEq8Ph6mvP1iejpBuF+dbWSkSuNyoyog8oAYLi47BGDuuLqPOvtyYCr7bOJLeQXL5ykx6vd05Fxlgnk6StFZQ2aJJv/xbkuk8jky35U+D/V3Ki6gfSSbUObcr1Jw/dbcHhCxoRglK8NtWszZc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752693525; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0VjJ4c2mLfoMpLDbbWfsXDtpeHHjb7qTAMeR5KY6QC0=; 
	b=nQlEXYePB6RIlFvhEkPcNzHRl9j7chy0jHj2/kFMy5TJfl0PeqrF6tCHImvnyBaZRW0j2OrjdmS1N0kJ9eYgeBREIOGMEAaM2m0stILlej25N8nN4jdzonsdmQqolpXXtud7Ascx/WFEq64lLd69KUlztleqwn8SAltwN1o7Fkc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752693525;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=0VjJ4c2mLfoMpLDbbWfsXDtpeHHjb7qTAMeR5KY6QC0=;
	b=Gl4LSMeTabxNEinFSyjx7pd7zlL7HAvWuPUn4UAz/ZjESfSEWQBVvj1Saxt6MwtI
	7sF9mR3MK5El4FL30nx0qEj79dGgzqKxE4wijnE1dkpFAax81Pz9prrFP3do1z5JDv1
	PYj+fByjO6srVqX1aNQn7SddYXjLYhq8iLUsfll0=
Received: by mx.zohomail.com with SMTPS id 1752693523304714.3019836740996;
	Wed, 16 Jul 2025 12:18:43 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v9] rust: kernel: add support for bits/genmask macros
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <705CD461-60D9-492E-B82F-C88A848A4348@collabora.com>
Date: Wed, 16 Jul 2025 16:18:26 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Alexandre Courbot <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D312AF37-03C4-4469-8BA1-669B62B74EFC@collabora.com>
References: <20250714-topics-tyr-genmask2-v9-1-9e6422cbadb6@collabora.com>
 <DBDP54SLN4EZ.2EQ004NXWCX2L@kernel.org>
 <705CD461-60D9-492E-B82F-C88A848A4348@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External


>=20
>>=20
>> (3) OOC, why did you choose u32 as argument type?
>=20
> No reason. i32 is the default integer type and signed integers don=E2=80=
=99t make
> sense here, so I chose u32.
>=20
> Also, we can trivially promote integers to wider types,  but the other =
way
> around is not true. So my reasoning was that if you had u8, or u16s =
you could
> trivially get u32s using into(), but if you had u32s and e.g. =
genmask_u16
> required u16s, you'd have to resort to try_into() or `as`, which is =
annoying.
>=20
> In any case, feel free to suggest anything else, I think.
>=20
> =E2=80=94 Daniel

I guess that, using the logic above, one could ask "why not u64 then?".

64bit variables are less commonly used, so this would be the inverse
problem, i.e.: we'd see way too many uses of into().

=E2=80=94 Daniel=

