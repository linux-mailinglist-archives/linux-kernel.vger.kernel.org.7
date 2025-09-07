Return-Path: <linux-kernel+bounces-804829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163F5B48072
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 23:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D98E1896B69
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 21:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E53221D3EA;
	Sun,  7 Sep 2025 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECsCyA9q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678DA1C28E;
	Sun,  7 Sep 2025 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757281158; cv=none; b=CK8YnoKLbgo+dqhDxtB8bDR7ppBeSfbdQ/6G/fxSd220d9iX7cx0kJd9IlAhvBbHtiwkuqIjy3bjpX2bruuJDZPPUzdLgGuE/tLyz4LZSPLEMM+5b7FpU6nRcDe447D8USi/oM06pNFke9nUdSnaWTSvJ3SW/47Mi55V6rNTzCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757281158; c=relaxed/simple;
	bh=g2BuCmO24IGiRlULssHIrCTTWeLKsrRnFKiQgSZg2co=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=ZwXnlL3xtLX1ojySV1OD7qncOju003F5FNVf3mXXTr7uv59ViJE42z6c6mppGWXhHh6yPLR1sudcCmgfOaL0BmDwFDkYORRdPq9T+rTb5YhtHGbjZc2sGAuEUk90H2ZlPpbfsrJvpqraKA6oGe0BDjgqj/DduiV21N2fB+be608=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECsCyA9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D736DC4CEF0;
	Sun,  7 Sep 2025 21:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757281157;
	bh=g2BuCmO24IGiRlULssHIrCTTWeLKsrRnFKiQgSZg2co=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=ECsCyA9qLhm7cAs/tKGzM8nKQGoI73/ODe+FnyMF1lG1smzQIw1QPW0MKtM00HclD
	 svO0Pr/jkx+UXkrqn4Mk6BGlLE2VYHtmtOpf0VG8pkAAj4vNiWBXp6il2UmNElrYik
	 poKrYRejLFhxJQcNL0f0DipbE6v1NbRfsYgkprhpU396PbHcGWokG67yEdU1NLYWvt
	 Q+6M3zutZNm2VdkoKXy5CXuod1fcBdssAej6hV/hK8zeg0ee1A3Lc37iMz0Eu0BACT
	 TzCu42Tfes+p6vTBfawhtGA3HWvM+/kM41B1isKT3JjsEOdaHmXxyDd8FP6nfm4I/p
	 KqC8sgriWg92w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Sep 2025 23:39:13 +0200
Message-Id: <DCMW6H0VJ9AP.1XWI1RI9YWO9H@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Fiona Behrens" <me@kloenk.dev>, "Alban
 Kurti" <kurti@invicto.ai>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: pin-init: add references to previously
 initialized fields
References: <20250905140047.3325945-1-lossin@kernel.org>
 <DCL1DPN708H0.3JTL93J2GD2DR@kernel.org> <aLshd0_C-1rh3FAg@tardis-2.local>
 <DCLNSNWA7AT7.19OWOXUMJ5ZRJ@kernel.org> <aLzmcK2UM53I2Tbn@tardis-2.local>
 <aLzoyWpOr6eg-3yB@tardis-2.local> <DCMFN8UGD7QN.27HTYEXL87Z8@kernel.org>
 <DCMQVH09L1Y5.3A842FC1NGG5H@kernel.org>
 <DCMVHB8P7Z2G.PCOWPQXBSBT6@kernel.org>
In-Reply-To: <DCMVHB8P7Z2G.PCOWPQXBSBT6@kernel.org>

On Sun Sep 7, 2025 at 11:06 PM CEST, Benno Lossin wrote:
> On Sun Sep 7, 2025 at 7:29 PM CEST, Danilo Krummrich wrote:
> I have some ideas of changing the syntax to be more closure-esque:
>
>     init!(|this| -> Result<MyStruct, Error> {
>         let x =3D 42;
>         MyStruct {
>             x,
>         }
>     })
>
> There we could add another parameter, that would then serve this
> purpose. We should also probably rename `this` to `slot` & then use
> `this` for the initialized version.

I think that's a pretty good idea, but the part that I think is a little bi=
t
confusing remains: `this` will need to have different fields depending on w=
here
it's accessed.

> But as I said before, implementing the `this` thing from a macro
> perspective is rather difficult (I have two ideas on how to do it and
> both are bad...).
>
>> But as you say, that sounds tricky to implement and is probably not very
>> intuitive either. I'd rather say keep it as it is, if we don't want some=
thing
>> like the `let b <- b` syntax I proposed for formatting reasons.
>
> I don't feel like that's conveying the correct thing, it looks as if you
> are only declaring a local variable.

Yeah, it's not great, but given that it's a custom syntax it also does not
create wrong expectations I'd say.

Anyways, I'm fine with either. For now we probably want to land the version=
 as
it is and revisit once you settle on the syntax rework you mentioned above.

