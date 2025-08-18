Return-Path: <linux-kernel+bounces-772913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 983CBB29941
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88EDC16685D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D21D26E6FA;
	Mon, 18 Aug 2025 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="jNmes4O9"
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E1270EDE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496805; cv=none; b=Twu3EmjUp+uX4Gy+gWbXhR4Bd6w+QoUJ8A0bvJbt8uAjosD4zDZ8Q/EdhMN6euW3pHcRSbkSA0NVSA0NmLp9HH25ld5Mi4IASvo15fcOL3BzQ8duqUr8XShxJOnGr15D6QSTCewjxDQkleiCLlIxFAK5gNJ2ob2vGcF8Yx7zv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496805; c=relaxed/simple;
	bh=wORigAie0fiYMxhzI6L5fiZcWzlfKLbDv5YjO8Y0F1w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVXbSUXoOVXqJ5MV0VlK7tt1JnDuFmHvpeQ1Oj7z7GeNc2R8BJpd83KbXnjDieku7jaHpD54a6vvfB4tH1iPK6uE5tZ4MqklduF2ivK0Sw/HRO18nn0k7B5IfMVxrAg/kN/ZwRtxcXotEWgnO1/BzVeer1+97QH+eKXOilcdqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=jNmes4O9; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1755496795; x=1755755995;
	bh=wORigAie0fiYMxhzI6L5fiZcWzlfKLbDv5YjO8Y0F1w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jNmes4O9xc6bS828QP5HelCHwHuDunmdP1Pd3BCwX6VL36/4Fkg483ivi+xysDuhW
	 UxrlhiVUT2gkQsJLgfEzSgy/dU4c+AKVGuZ4cnqnBAnyVmW1J8TZaj8sAHxeV2K1bG
	 iFt9zrCJ3UdI55YImplUQimxXT94kQJENRmn6REBARMx0Iw+zwcpvjrwnOr1V17PyW
	 rePbmbGHjSRYnevoLoZdGcGd/c0gcXtDD/Ol4zvwAySDQW9LUj9dpsVjw3r42HZXUz
	 FZa7ixk4/ZIsKYCdfBFL/6XSFzwy5QNt3X1w9AUqgVe1fATnj6pWyirhufa/hcTJHx
	 iTncLUbUGW7tw==
Date: Mon, 18 Aug 2025 05:59:51 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/4] New trait OwnableRefCounted for ARef<->Owned conversion.
Message-ID: <aKLBUwwAnR0fPaMz@mango>
In-Reply-To: <875xeoevvr.fsf@t14s.mail-host-address-is-not-set>
References: <OYpTDi4YYXiWvLG3nO_8_WKsgOl9KOpun9l3a34m0jza6nmEWDCLTldSwCfZ2PRRprjXqGmrgSL2JN8rPOQH8Q==@protonmail.internalid> <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me> <875xeoevvr.fsf@t14s.mail-host-address-is-not-set>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 9aaa9cf2437c21b81693ead90fe955f10970a011
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250815 1212, Andreas Hindborg wrote:
> Hi Oliver,
>=20
> "Oliver Mangold" <oliver.mangold@pm.me> writes:
>=20
> > This allows to convert between ARef<T> and Owned<T> by
> > implementing the new trait OwnedRefCounted.
> >
> > This way we will have a shared/unique reference counting scheme
> > for types with built-in refcounts in analogy to Arc/UniqueArc.
> >
> > Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> > ---
>=20
> In case it might save you some work, I rebased your series on v6.17-rc1:
>=20
> https://github.com/metaspace/linux/commits/217c7ba3b95213abf9c1ce1a98ca49=
6a48401f10
>=20
Thanks a lot. I will use it. I hope I find some time soon.

Oliver


