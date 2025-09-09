Return-Path: <linux-kernel+bounces-808720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF9CB503FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6566A3A81DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54EC35E4D2;
	Tue,  9 Sep 2025 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="cGaH/LqN"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFEF316911;
	Tue,  9 Sep 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437467; cv=pass; b=YLF6GTMwd3obFwR7yL3kj4Ns0r72bSDViUUp09ttuiSKbBatINzm1YQ6Gq1etXA6s0ivrGiNFjerKg34x3vzp8TO57lhh/9ivnGTYY7Z7xbxU73Tvcl/55cFDYHvUaDylYZ2/dmnkh8gi3lMttQLBASjqFRekhoS7IO2gPVuJZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437467; c=relaxed/simple;
	bh=5dGQK8wJM38VE5tVHI9D9YwSya8XbhZ8wjwloKJ7eOI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=U86rBSS983MD4Wj/Q9py3msEV2tkCpCp9mgsHQ2b9flhmlE20PnlsrMWmeiiNLtQfeyHGY+QbX7GYGHYWY7s80RRDwLS9+b2Y4QE0diLDIS9KYjbvSUL3sFU2BiWdSSCD0drb18ckPcYzx491HGfMMThxPBmz9cjVxM4t7vHKqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=cGaH/LqN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757437446; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fWdsfauvBL12Rfb+NxXRjUPFl+ZifP6gmcvtdHOGPhKSfIg9vLGMvnDaZPJ4kr2sZhleD4OJYzuRlkR5T4/rF+16rpEouHPqdSgX7rXiZskBKFiiTkc3rRjhIAJBHaWQVqiG317efYzCSrecoJkwIf7y+dnPH5ya5dKoYXIW5vA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757437446; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5dGQK8wJM38VE5tVHI9D9YwSya8XbhZ8wjwloKJ7eOI=; 
	b=IVik97SCfKVmUfcP/freebJwfPwdrvODx/2OdzSqV89FMGYFUzYUkS6kA3VSmENJdZvkzPnLdCf1hG4A1IcTmFVWQfLw/pYdtEOV3RgaaTA8WE/kzBGOuRsc6BWBZfV8KlXdEi1iDTh04AkhPLbZBPbJrWW/K6Czcb1ad0vsqBU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757437446;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=5dGQK8wJM38VE5tVHI9D9YwSya8XbhZ8wjwloKJ7eOI=;
	b=cGaH/LqNt7AsgVZlxU9jNqN4pnM+U5laOaqmZKjRuaii7M5yymveUr8JbCn51FeD
	JOKixunsQi8hTF4NLmMbtztLKItK1dzkoSOT0TNuTSDvNC9Uv/rzuyDYnuUUD5MDs8o
	OsIshNeaT3bZU3QxHO/4cJ6+Moklm7N53H3iVVfg=
Received: by mx.zohomail.com with SMTPS id 1757437442807427.4205442612746;
	Tue, 9 Sep 2025 10:04:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aMBYjIo2O77Dp2VV@tardis-2.local>
Date: Tue, 9 Sep 2025 14:03:46 -0300
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2897332E-7746-41E0-8A03-129F574A7224@collabora.com>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local>
 <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
 <aMBJ805QjQcPdRol@tardis-2.local>
 <8CA69D19-754C-43F5-96CD-B7060C68B025@collabora.com>
 <aMBYjIo2O77Dp2VV@tardis-2.local>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 9 Sep 2025, at 13:40, Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
> On Tue, Sep 09, 2025 at 01:12:51PM -0300, Daniel Almeida wrote:
>>=20
> [...]
>>>>> These two functions are already EXPORT_SYMBOL_GPL(), so you won't =
need
>>>>> to add rust_helper for them. Creating rust_helper_*() for them =
will just
>>>>> export additional symbols.
>>>>=20
>>>> These are inlined (stubbed) if CONFIG_REGULATOR is not set, so we =
need the
>>>> helpers to get around that, IIUC.
>>>>=20
>>>=20
>>> Well, then the question is why we want to compiler regulator.rs if
>>> CONFIG_REGULATOR=3Dn? Shouldn't we do:
>>=20
>> Yes, we do want to compile regulator .rs. There=C2=B4s been prior =
discussion on
>> this (see [0] below, but also [1]).
>>=20
>=20
> Thanks for the pointers. Well I guess we really need helper inlining
> badly ;-)
>=20
> Regards,
> Boqun
>=20
>>>=20
>>> #[cfg(CONFIG_REGULATOR)]
>>> pub mod regulator
>>>=20
>>> in rust/kernel/lib.rs?
>>=20
> [=E2=80=A6]

Ah, by the way, that seemed to be your only comment. I will wait some =
more for
the discussion to die down and then send a new version addressing =
Danilo=E2=80=99s
points. Can I get your r-b, or is there anything else you=E2=80=99d like =
to see
changed?

=E2=80=94 Daniel



