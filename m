Return-Path: <linux-kernel+bounces-768793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE67B2658A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63C4A21D11
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA162FCBEF;
	Thu, 14 Aug 2025 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="OXQ5NJFB"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCC2FA0C9;
	Thu, 14 Aug 2025 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175176; cv=pass; b=ADxnOCbNVKu0iLwd3t3HpBaZtHZoYEB4EmDBQ+maqZBnJjbm1Y1rF1+GZwrmhDZb+lMolTV+wvgsZlmHj4OxO6/RoZE8DpWW7rCHoTdSpc8YOGrZ6KjG5nrqs2DoZSiSE6AbVhdlRN8Zn6ldx2Ph879MBXh86ZWEiMCQQ9/tamQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175176; c=relaxed/simple;
	bh=swsZ61pLGJ4jo8/qPA4Fexe23uwltcFhTwTEkL3zDHs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JoOrDyZV33B6cHj2UTRx3+yI8OlIVU6rEAqcPYzb7aT7ASHFEurPey7q+8Qj3Ymg3rRltrB/g1sIIEYgUF9FUBgxkBrbQouxQCyzVFS/XEOcwFT0i4e8QU44IHO5FdAJm0mgPd2UbcIPzqtHE0r0OviocszDj1MgaUsU1Ccfko0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=OXQ5NJFB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755175136; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X4fwlHBMggOzGyGWWjo8plbrs2IOxRETM4eIjmY2MmndKCXojpvT71RF/u7otxFBDPYkLD21hIFjpFpD6AjcEoZdytuf/yFd3ftrZ/hKhSaCHKQI90lOWJRnTn/JNQZJF4KACr4OPwJnk1G7UoFDObr6eqLALj3S8mZyywbRmGo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755175136; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+Vu80FDSkV/ra3f3s6oko3bfl071bY2li9WH4zeUyz8=; 
	b=AV2fJh0CPp/Ob7Z9IR7an2orcUkMh0H4z5aXplXLcat/vtcHodO4QnUjH5oNM5lHO2uYNXQ0cYJmeF4gQQudw9WO5T8XrMfb4rlQeDDvC8Y4f8HRs52vRN18/HQr5wQXDbuAGXKd0BMy9QUOK4bXPGqpcapwo6HHHlcrx24DOM0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755175136;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=+Vu80FDSkV/ra3f3s6oko3bfl071bY2li9WH4zeUyz8=;
	b=OXQ5NJFB2nYH0BXLwk2W8YwpSve/mcSq0DMhhBg+5qYFBkUfCWqrp5RL0dLgCwW8
	RnZ1ct8pIFKRkH7uxQe38NNN5rRwxYlxUB0fXPXqd/TBTHnyrqxEInTALHBaIdZX7yT
	lrqHUO42XuMxCebkN12emP/+pkQYepphtyDejB/Q=
Received: by mx.zohomail.com with SMTPS id 1755175135123867.0633490787785;
	Thu, 14 Aug 2025 05:38:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250814141302.1eabda12@nimda.home>
Date: Thu, 14 Aug 2025 09:38:38 -0300
Cc: Benno Lossin <lossin@kernel.org>,
 Lyude Paul <lyude@redhat.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 will@kernel.org,
 longman@redhat.com,
 felipe_life@live.com,
 daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <76D4D052-79B6-4D3F-AAA1-164FF7A41284@collabora.com>
References: <20250621184454.8354-1-work@onurozkan.dev>
 <20250724165351.509cff53@nimda.home>
 <ec32fc5f5a8658c084f96540bd41f5462fa5c182.camel@gmail.com>
 <20250806085702.5bf600a3@nimda.home>
 <539d3e0da773c32a42b4ab5c9d4aa90383481ff6.camel@redhat.com>
 <DBVLEGFYBWKE.2RW8J853CJHTY@kernel.org> <20250814141302.1eabda12@nimda.home>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Onur,

> On 14 Aug 2025, at 08:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Hi all,
>=20
> I have been brainstorming on the auto-unlocking (on dynamic number of
> mutexes) idea we have been discussing for some time.
>=20
> There is a challange with how we handle lock guards and my current
> thought is to remove direct data dereferencing from guards. Instead,
> data access would only be possible through a fallible method (e.g.,
> `try_get`). If the guard is no longer valid, this method would fail to
> not allow data-accessing after auto-unlock.
>=20
> In practice, it would work like this:
>=20
> let a_guard =3D ctx.lock(mutex_a)?;
> let b_guard =3D ctx.lock(mutex_b)?;
>=20
> // Suppose user tries to lock `mutex_c` without aborting the
> // entire function (for some reason). This means that even on
> // failure, `a_guard` and `b_guard` will still be accessible.
> if let Ok(c_guard) =3D ctx.lock(mutex_c) {
>     // ...some logic
> }
>=20
> let a_data =3D a_guard.try_get()?;
> let b_data =3D b_guard.try_get()?;

Can you add more code here? How is this going to look like with the two
closures we=E2=80=99ve been discussing?

>=20
> If user wants to access the data protected by `a_guard` or `b_guard`,
> they must call `try_get()`. This will only succeed if the guard is
> still valid (i.e., it hasn't been automatically unlocked by a failed
> `lock(mutex_c)` call due to `EDEADLK`). This way, data access after an
> auto-unlock will be handled safely.
>=20
> Any thoughts/suggestions?
>=20
> Regards,
> Onur
>=20

=E2=80=94 Daniel=

