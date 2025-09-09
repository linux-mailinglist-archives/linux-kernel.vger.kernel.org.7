Return-Path: <linux-kernel+bounces-808718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E376FB503F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC20367905
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9737288C;
	Tue,  9 Sep 2025 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="T4qonAxI"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A1258EFB;
	Tue,  9 Sep 2025 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437367; cv=pass; b=n/NWr8+QlT4xNBSHEIZCjvDQDNbkpxUwXHPRT3zTsaNT3TER92jAVcb5uEvy68EQfQ6cA3atgRn6fW+lNSYNubB0ROSaV+qVZK+DJCCRY7xzPD/qI/QkGp+95CZYdAWiRn9uL+tAL1xRsqeuxaLku76yqr7jKiMqm1xDgRvreDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437367; c=relaxed/simple;
	bh=COSvmSyevD9dcT8YVmVKsH1in6CKNyug3YbUQ0z2sr4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OQF3FjfHvC4xzcVdLo5J6yReeaHyZBLDrCC4T7WI5bzbXl9KLOzdoNUuneHK4rcNGUygen4njFOrmPxDlJ1tyQME7L34cLJSb70uHDkGV9muVLNoQpzDi4JiskXVflumTuzpaw2Sk20iNe3KghLceY5EoYrpBpIv6vVGy3c3Tek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=T4qonAxI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757437345; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YKZiireURZ4Rzt5SBAidjTx9kllIK3dDKh90qaDZjKbAoGhdXjQuGjj6chCoPLGv/hZUChXsitjfDTeXJjULzptsE/Qcu4QlrCzNxbpOCB7P7YdM/TMit2hufpTanEbXfnS70GOlf3adrqno7v5FoPpk08gBDf+HxTxxr3sCVn8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757437345; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=COSvmSyevD9dcT8YVmVKsH1in6CKNyug3YbUQ0z2sr4=; 
	b=as/lt38RK8o00QFSTR0oeSaQJxwrjfTEPzop4egSfkjOrY/5kFRwPnDLdLQD68EdbpgRAtNE3MUI6v/mEs3ribQStdqNGJZSUSwKwQFwsL7yURuvTCFqoPaBgZnQYTRoKL6Bi83oeHbYaCBMATP01OUppNyb2KDlReUe8ghOCYk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757437345;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=COSvmSyevD9dcT8YVmVKsH1in6CKNyug3YbUQ0z2sr4=;
	b=T4qonAxIiDgskQsKS58gmPSEqNQY7IAIARPFKsoTyh9UPqpffsNSaNA/US5h9Fib
	akoCuPkuUa+Pn71NWX45Oln1EvHKHSBceNthI9TCuzYXtMlavf/LK7uFncI4lUVaC3J
	oH5ZwF5LLuPcEytYD1fpr0FAPgeaeblHRHgGJR+w=
Received: by mx.zohomail.com with SMTPS id 1757437342958679.3930952067639;
	Tue, 9 Sep 2025 10:02:22 -0700 (PDT)
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
Date: Tue, 9 Sep 2025 14:02:06 -0300
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
Message-Id: <C22AAFA9-3EE4-4B99-90B9-1E748A0D45AF@collabora.com>
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


A bit out of context now, but I don=E2=80=99t worry too much about =
binary size. I
don=E2=80=99t think there=E2=80=99s enough functions in helpers/*.c to =
justify that.

What I do worry about is the indirection that might get added on the hot =
paths,
like requiring one extra function call (i.e.: for rust_helper_*) for =
every mmio
read/write, for example. That might have non-negligible impacts on =
performance
IMHO.

So yes, I do agree with you that this should be fixed.



> Regards,
> Boqun
>=20
>>>=20
>>> #[cfg(CONFIG_REGULATOR)]
>>> pub mod regulator
>>>=20
>>> in rust/kernel/lib.rs?
>>=20
> [...]


