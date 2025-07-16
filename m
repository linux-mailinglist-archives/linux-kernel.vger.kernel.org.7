Return-Path: <linux-kernel+bounces-734201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EC9B07E50
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B821F1C2434B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020652BCF5C;
	Wed, 16 Jul 2025 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ByYHREL+"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB7729B771;
	Wed, 16 Jul 2025 19:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695112; cv=pass; b=d1q6FY3h6OBXfpEI6QNkhur8pH/0AQpnC0+lrgRokmiO4YKlJ7iM2Rsmbv/WHC/7GJ4dDsb+7179a4W6MqOutem+LHN4GUSemyOuSZGNjojh7sIT4ngCsXh4ksZM7qFOWdbdBm67xFTf92Cm8IiJlCbGJDmm33WjtJ73JAOA8rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695112; c=relaxed/simple;
	bh=NARzaEJQyDFC0HMf5RYjkvJeTeaw+ygjo8XkK2VD7bg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FGT1yBlitN6znVI9aCYcp7tbGsYDAUkmTeIM6vOCaQwKscj7wjMExdo8Rrefwcu1yRv7pxmY9h2eV8PGDMePuMxyMvScc0Ipb0xbSFVu9LunNNdetXcm+yCHnk1RI/xn9iRS96KZE07R/RJ6K+sJRBURc1ZfKmJHWQnaFiokVZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ByYHREL+; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752695093; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TfbdUrbAtafmvxx370cJ6suLS+ObUsoXpWz4hXpusvUDVIu5xSuaL0DHQVfTgoQXhx20CPaBvvfj4c9IkKwO19dIWrjFRolrfqvhNK/E6/VUTnCmA05IlUwCWQiTUQUs5JGls+ByA7hhkc2VIwx/RHpb2j9IMoeLy3OzyqZJS/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752695093; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E6ktWlv2igDhYD09yx09L8Lelk36VOs3Y0BNzCToH2w=; 
	b=U3nvHT5/pUGZrSfi30LdgCFOIZQHbWtG7YP5We0lP4OmEJUx0IDqptdoH1t3j32s0tbE1LCjGl9fCp9AUva443graYj+M3O2O7NLabKhGHjqoBm1qcAAOdWyhaddPngv6qK9FcY+6kWO4b2niZS5lOW16NtXBzt2hwNNRJ/9A+Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752695093;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=E6ktWlv2igDhYD09yx09L8Lelk36VOs3Y0BNzCToH2w=;
	b=ByYHREL+SIX6bOp7lqHt9VmLen8J891eDuyYBsTmJu09gPjzgaJz+WeuYbIPnOiF
	x87IAptmziRJ4qDhEDFYKdNfWYH5m/7L/vRCieOgqkUfJhzSDIGg3bK1jIs7Rqjr3bQ
	Iwc3pgvlcQM71kWcextl27BkPrz5f16f4t43m8Uc=
Received: by mx.zohomail.com with SMTPS id 1752695090539727.3549366017237;
	Wed, 16 Jul 2025 12:44:50 -0700 (PDT)
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
In-Reply-To: <DBDQASMSS32U.FJBYKS3LWEQ6@kernel.org>
Date: Wed, 16 Jul 2025 16:44:29 -0300
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
Message-Id: <1DCA3EA2-5CBB-4193-B1D3-7E286C344A14@collabora.com>
References: <20250714-topics-tyr-genmask2-v9-1-9e6422cbadb6@collabora.com>
 <DBDP54SLN4EZ.2EQ004NXWCX2L@kernel.org>
 <705CD461-60D9-492E-B82F-C88A848A4348@collabora.com>
 <DBDQASMSS32U.FJBYKS3LWEQ6@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 16 Jul 2025, at 16:32, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Wed Jul 16, 2025 at 9:11 PM CEST, Daniel Almeida wrote:
>> Let=E2=80=99s transfer this discussion to this patch.
>>=20
>>> I also quickly tried genmask and I have a few questions:
>>>=20
>>> (1) Why does genmask not use a const generic? I think this makes it =
more
>>>     obvious that it's only intended to be used from const context.
>>=20
>> I guess none of us thought about it, since the current version also =
works.
>=20
> I think using a const generic would be a bit better for the mentioned =
reason.

Btw, how does monomorphization work here? Would we have to codegen all =
the
versions? Also, I don't think that you can take a range as a const =
generic
argument, i.e., I don't recall ever seeing this syntax:

genmask_u64::<0..=3D63>();

So we'd have to go back to taking two arguments, and it's less ergonomic =
than
a..=3Db (which was discussed a bit at length during the previous =
iterations).
Also it would stand out against the non-const (i.e. checked) versions, =
which would
still take a range as argument.

>=20
>>>=20
>>> (2) Why is there no build_assert() when the range exceeds the number =
of bits
>>>     of the target type? I would expect genmask_u64(0..100) to fail.
>>=20
>> Doesn=E2=80=99t it?
>>=20
>> There is a build_assert in the underlying bit implementation. It was =
redundant
>> to have it both in bit_* and in genmask, because genmask calls bit().
>>=20
>> In your example, bit_u64(100) hits that assert, and so it shouldn't =
compile.
>=20
> Indeed, and it also works, except from doc-tests for some reason, =
which is what
> I tried real quick. :)
>=20

Wait, this was a bit confusing :)
You=E2=80=99re confirming that it doesn=E2=80=99t compile, correct?

> I feel like usize would be a better fit, but not a strong opinion.

I guess this is the same problem as u64: drivers will usually have =
either
i32s/u32s and this would require a cast.

=E2=80=94 Daniel=

