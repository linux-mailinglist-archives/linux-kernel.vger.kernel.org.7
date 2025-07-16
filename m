Return-Path: <linux-kernel+bounces-734130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D36FB07D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6F93B1A23
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13598299ABF;
	Wed, 16 Jul 2025 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Kt31Qzce"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDCF2857F1;
	Wed, 16 Jul 2025 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693158; cv=pass; b=T9rto/bJJQgjGcjpTOJXnuHo5XmEg+Ap+W3shUcOnjZrQuJR3/ZVtAydnMalHTASewT5hqkrb1YdScGjPipi7mRU2F3BnQVtvR09fkTcA7+Pi9TR7N6jq/cMofmj4YvFa+yWPfmfoHyPf6zFLiuTOXpMrCcJeg3vdrCGmnfd1Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693158; c=relaxed/simple;
	bh=Z9YLL/KYQcPg7VCohMKpFkg2UMvC1o5Sjo7cplh1bLo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=buXhLM5/lZEsqBUBMI9pUY/UUsM/7eUpzXIk1xuyANSRX3Vmyt7C83hmCv+oAPd77iys/p9cPb02oIO0REkVnXYL/J9ciA4vcIzV6srFY2iTeiGu2nMlxPfdPwYtQFpJ2LIMtWgOL6FSpUpwkoDFqM2urP+Gl1B5SONs0TUUg0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Kt31Qzce; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752693140; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gRru1CRaWPppehqxXg5z5WcLnQlxdTfiT6A1khOJxaDUs4YDMBdwibF5Jz7K2JmPj7SBMy+ooJMYHfCbrvkGiOD/yMrRL0PkBCSXztRFp3lN0Ujl4hZlnHGPzNFzJy4MR8xSVhOWeusog3JApB+gBw1If/iOhOpLpDZ7q/RoK/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752693140; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AUaMNgnJFrrwocEksdC9n4xT3OB9Me+gl37KEZNP2ko=; 
	b=Rr3E5+IbVgbhtB42oEfe/R7IpLKdhf2hvNGaX5Pk4ypa5BoghxejZ3cgT34EE1WpJ052hvIejLKN4jWVgEiwdrRd8tkJGN7j3+mofWfTDsAtCq9BBL4EvbLPr3EV9aktv0ODh6oupV/D6okhKyWuHCo4Y3cZoGcFWH8DNg8VJWA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752693140;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=AUaMNgnJFrrwocEksdC9n4xT3OB9Me+gl37KEZNP2ko=;
	b=Kt31Qzce/Z2i7Wt5oI0HbXwPY/hPsDqnVRgPUvbYDIDzka19QJ2Q+ahB8kUKLkOA
	3bHUFg2AEi3GhluBQOB48Y+g9G7pxDRWvHrYhOpJkUzdSDcSo3HOwd/x17FH34A/u9k
	hCK9ZWKedY5fXfHiXzlqN2akSaNESuza5LTTcogY=
Received: by mx.zohomail.com with SMTPS id 1752693137275375.23860396474515;
	Wed, 16 Jul 2025 12:12:17 -0700 (PDT)
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
In-Reply-To: <DBDP54SLN4EZ.2EQ004NXWCX2L@kernel.org>
Date: Wed, 16 Jul 2025 16:11:59 -0300
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
Message-Id: <705CD461-60D9-492E-B82F-C88A848A4348@collabora.com>
References: <20250714-topics-tyr-genmask2-v9-1-9e6422cbadb6@collabora.com>
 <DBDP54SLN4EZ.2EQ004NXWCX2L@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Danilo,

>=20
> Just for reference, I asked some questions regarding this code in [1].
>=20
> Additional to "Why does genmask_u64(0..=3D100) compile?" I would =
expect the
> corresponding genmask_checked_u64() call to return None.
>=20
> [1] https://lore.kernel.org/lkml/DBDP0BJW9VAZ.5KRU4V4288R8@kernel.org/
>=20

Let=E2=80=99s transfer this discussion to this patch.

> I also quickly tried genmask and I have a few questions:
>=20
>  (1) Why does genmask not use a const generic? I think this makes it =
more
>      obvious that it's only intended to be used from const context.

I guess none of us thought about it, since the current version also =
works.

>=20
>  (2) Why is there no build_assert() when the range exceeds the number =
of bits
>      of the target type? I would expect genmask_u64(0..100) to fail.

Doesn=E2=80=99t it?

There is a build_assert in the underlying bit implementation. It was =
redundant
to have it both in bit_* and in genmask, because genmask calls bit().

In your example, bit_u64(100) hits that assert, and so it shouldn't =
compile.

Note that I can't add a test for this because "compile_fail" tests are =
not
supported yet, but there is a test for the checked version, i.e.:

+    /// // `80` is out of the supported bit range.
+    /// assert_eq!(genmask_checked_u64(21..=3D80), None);

> Additional to "Why does genmask_u64(0..=3D100) compile?" I would =
expect the
> corresponding genmask_checked_u64() call to return None.

The test above proves that it returns None.

>=20
>  (3) OOC, why did you choose u32 as argument type?

No reason. i32 is the default integer type and signed integers don=E2=80=99=
t make
sense here, so I chose u32.

Also, we can trivially promote integers to wider types,  but the other =
way
around is not true. So my reasoning was that if you had u8, or u16s you =
could
trivially get u32s using into(), but if you had u32s and e.g. =
genmask_u16
required u16s, you'd have to resort to try_into() or `as`, which is =
annoying.

In any case, feel free to suggest anything else, I think.

=E2=80=94 Daniel=

