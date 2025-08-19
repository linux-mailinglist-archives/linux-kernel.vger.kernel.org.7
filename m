Return-Path: <linux-kernel+bounces-776231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D990B2CA54
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43996A01BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B982FF646;
	Tue, 19 Aug 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPgkZMxc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB142FE06D;
	Tue, 19 Aug 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623739; cv=none; b=lF8Ox5v8BJJPn9MJMel5vjNTJYvFhwFaI2+A/VnP0Wg6ZsAqroS1VHVWP6oeVDgwFo2qFvGhrAGVszc+LGNMVLWNxePcftmBTB7DVfD7gOTPNh+m6XEPNoeRJVB+fkJ4me1mxro72/o7lrrgS6Zhx+n1mMazP3v8DxDOeKpUbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623739; c=relaxed/simple;
	bh=iSvEjCCJIwfeL7uNmdhXw0eHuwz2naC+TZI5nIPrNmI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=la4Okhy0tsH7oRV6IAsLw9746N1pT16eRVe8Wfe4n4/J0KXUn4Y213DWmYPBzH3lb6ho0AjLxSoepL3yS5Pp9ql9svTL7pD5yE6yrLHC2oM0/jDqauOL3XJXreyb+WrT8JcvYleCp0GMnQ5OvpLQqfXBi2ICsbyQAPqAG95AZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPgkZMxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227DCC4CEF1;
	Tue, 19 Aug 2025 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755623739;
	bh=iSvEjCCJIwfeL7uNmdhXw0eHuwz2naC+TZI5nIPrNmI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uPgkZMxcMHkGdwGG46fbtdE3QhkxGhZ5smU88cXKxZwo8I/r2zuGvRQulJdq2cLV7
	 2HwS/Y8r11lGPdK+Lfa+E8ZhOSKyqzIQWYUZoAIXqy9lJhk7ztM5srVpaDpjrm9m1S
	 Ni0Y/sjqq7PVGwzqQsNQUm/3IQOxDgEsvfjE8TmpZ3f3yiACa5mY4DoowNWnzUW1Xv
	 nxsJdMK2acz/WsowiXvOxTOVeTZSP/3/ynG+cfcVgir74U2NDrNx6p1PnZykjCtQzZ
	 7tj2dIS80syzdAhASqUlsq8clUZfAwS4QEEJi6hVbWIpzlc9SdbHWWyQsx0plZ2NsR
	 0tATU0YaNa1Rg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 19:15:34 +0200
Message-Id: <DC6KO9DJG36S.TQRLQQGJKVON@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Asahi Lina" <lina+kernel@asahilina.net>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
From: "Benno Lossin" <lossin@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Oliver Mangold"
 <oliver.mangold@pm.me>
X-Mailer: aerc 0.20.1
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <2OkNj7ab-vTaPaqMj_KRpIjaKTWgOW-F9Cn-CxnR12E6Dwg4lnjr6fx1vkjnoTx0boUeReeIVDbSyVFBWlYx7g==@protonmail.internalid> <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me> <87o6scdchf.fsf@t14s.mail-host-address-is-not-set> <aKMkvHAfDozzDjkB@mango> <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org> <aKQT92ViZSL841rT@mango> <DC69F17AFLB2.1KZ8JJUIH2CSP@kernel.org> <7ORM055ehFH_Z124bk1l8YRI5whcremycMy8JsSgzMf4rRdagKSDHSloL8sz3O8FmX3k9cni7TG2_EFLyInWbw==@protonmail.internalid> <aKQ5rHqxOBEI2n4w@mango> <87h5y3d6u8.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87h5y3d6u8.fsf@t14s.mail-host-address-is-not-set>

On Tue Aug 19, 2025 at 11:00 AM CEST, Andreas Hindborg wrote:
> "Oliver Mangold" <oliver.mangold@pm.me> writes:
>> You mean of `Ownable`, when `OwnableMut` is removed? Yes. A good questio=
n
>> in that context is, what it actually means to have an `&mut Opaque<T>`
>> where `T` is `Unpin`. If that implies being allowed to obtain an `&mut T=
`,
>> it would we easy, I guess.
>
> You should not be able to get a `&mut T` from a `&mut Opaque<T>`.
> `Opaque` opts out of invariants that normally hold for rust references.

Yes, that function mustn't exist.

>> But what I am wondering is, if we actually want to start using `Pin`
>> at all. Isn't `Opaque` currently used about everywhere pinning is needed=
?
>
> `Opaque` is `!Unpin`, but pinning guarantees does not come into effect
> until we produce a `Pin<Opaque<T>>`.

`Pin<Opaque<T>>` isn't really a thing. You still need a pointer
indirection, so `Pin<P>` where `P: DerefMut<Target =3D Opaque<T>>` so for
example `Pin<Box<Opaque<T>>>`.

---
Cheers,
Benno

