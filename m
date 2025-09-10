Return-Path: <linux-kernel+bounces-810155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E3BB516AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70573581BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F00B314B91;
	Wed, 10 Sep 2025 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un0m+nlr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624F276051;
	Wed, 10 Sep 2025 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506746; cv=none; b=pUWkv3X+qbBkypp5XAA9K+Dgh0iR74SYtLV8CtzjlS17dVibC9NquOjOig4u3d7hb6oG8ewL6tQN4/tLcM3oQW3x8ML4sQteO5irPDDp88tx1OaCP8aN259S4pmFloxO1KR4LEPbz3sL2qsyvDe3S71Q64uNS63eiCKS4M18hUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506746; c=relaxed/simple;
	bh=wmdfnuozal+OpHj0U2Ghsg6W++59A0UjBovthF4ZldU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=vCGsmBESkL2UavEhO/ZeSeR31o1uwMc28ZYTsLQgTBbEMbB9EE46qfoo5sR859y6wMBCmuEQYDfkYC7wy0on50hQPBLl+JmlI3RjCv0BYAsU8b653LgoAYCo5TiJXQpVSn9SU8eITnu3Uhp4p9prf4lCDQcrrT957V+Ia3W6HSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un0m+nlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135EBC4CEF0;
	Wed, 10 Sep 2025 12:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757506745;
	bh=wmdfnuozal+OpHj0U2Ghsg6W++59A0UjBovthF4ZldU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=un0m+nlr+IgJu6bPntMKBKDunPlyEd9Iowg1G6i7WcrsdSEiWih1UKG9+aLIdiTEU
	 WueBr1b09782wHdSGr1H+MGyLH2KPIhlpbLYp1Xf0gvk5ravp9u12ZakehKlX6baiH
	 VXGxk2JVv2OBg7gCA67VQ4VrePiOXhqt3L2vmZShh83VqNrkaFPuubgxlq4ZYvgNEP
	 giUeukITlUHT5RoGi3pK5vqp1/s0ueCKwwKxMlQZRpYjH4+MHYsxYXFg4au5ZM7sSb
	 yYaDqJNocGFwgf33uongCt+M/vVpTWY2kBVzEpfFkLEMICPYghPu9dMgD/lggLjXey
	 BfSSnxl65Q0hQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 14:19:00 +0200
Message-Id: <DCP456FHT625.1L5BVZ4LPD8VQ@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Fiona Behrens" <me@kloenk.dev>, "Alban
 Kurti" <kurti@invicto.ai>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access
 previously initialized fields
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250910100755.2361281-1-lossin@kernel.org>
 <aMFQL-Hq1KvBG5lh@google.com> <DCP1Y8N4SRRF.25V7F6PV5ODCQ@kernel.org>
 <CAH5fLgg+-oz_cP9=ke+ukp9qYZAsD=hKqvvGfkJWRcCKdrTQ-g@mail.gmail.com>
In-Reply-To: <CAH5fLgg+-oz_cP9=ke+ukp9qYZAsD=hKqvvGfkJWRcCKdrTQ-g@mail.gmail.com>

On Wed Sep 10, 2025 at 12:40 PM CEST, Alice Ryhl wrote:
> On Wed, Sep 10, 2025 at 12:36=E2=80=AFPM Benno Lossin <lossin@kernel.org>=
 wrote:
>>
>> On Wed Sep 10, 2025 at 12:17 PM CEST, Alice Ryhl wrote:
>> > On Wed, Sep 10, 2025 at 12:07:53PM +0200, Benno Lossin wrote:
>> >> Assigning a field a value in an initializer macro can be marked with =
the
>> >> `#[bind]` attribute. Doing so creates a `let` binding with the same
>> >> name. This `let` binding has the type `Pin<&mut T>` if the field is
>> >> structurally pinned or `&mut T` otherwise (where `T` is the type of t=
he
>> >> field).
>> >>
>> >> Signed-off-by: Benno Lossin <lossin@kernel.org>
>> >
>> > Is there a reason we can't apply this to all fields and avoid the
>> > attribute?
>>
>> Adding the attribute was due to Boqun's concern on v1 [1]. I think it
>> might be surprising too, but I'm also happy with no attribute.
>>
>> [1]: https://lore.kernel.org/all/aLshd0_C-1rh3FAg@tardis-2.local
>
> IMO the ideal is if it works without an attribute. Perhaps trying that
> in the kernel is a reasonable experiment to find out whether that's
> reasonable to do for the general language feature?

@Boqun what is your opinion on this?

I'm open to take v2 or v1, whatever you guys prefer.

---
Cheers,
Benno

