Return-Path: <linux-kernel+bounces-692920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F11C4ADF89F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 23:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3291BC3DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C911927CCE7;
	Wed, 18 Jun 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JO57uXEy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F127A46A;
	Wed, 18 Jun 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281600; cv=none; b=Dw/oiK9MDf98WMNXmKRQyBek92A+UAmWM8aPfYPH8PDx+7LC0byWKNk+0vcFdA3Vegdbh1zhtY1r1LIj9SbRqoTtbaEAqxhYPSkmBSRUQPsMH830kiSEk576u0Pd+4st791JNJp6vODU6Aw0PnJdmWSJ8ZAMaIIHlrtRAghzz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281600; c=relaxed/simple;
	bh=EbB/q7SwaM5yceRQWTsTZPY00Jn2CZRLRyHwoouPMjk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=FWGyuHoFpPu0v236KFKv1X1qGS+nQtQcVqKjKW+6t9oozEtPySyEURryi/bIaroPYbzMHrQJhUGyQl22FehrLK1afnaw7nQMdEZ/CF8016mqA1zP/Zlo+EJqj3fllaBRCHPUEFPv3khtj+PEHpHIPvm0Jv0K2yv8yDlDyAdx1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JO57uXEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989E3C4CEE7;
	Wed, 18 Jun 2025 21:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750281600;
	bh=EbB/q7SwaM5yceRQWTsTZPY00Jn2CZRLRyHwoouPMjk=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=JO57uXEybUK/Jmj/mZoksyy4r/4rZUpThA9wzRSVbwNieiLu/8+IXRkYK+5gTY4nX
	 G+DI+/gQkky9XgTCQaZdxcKMug9o161UDbRD/nsjfsg+geq7S4fTGxfQOUQO5jZFE7
	 28BR686y6vupGG6VSkEGJjs91Em3EAQFADpW8FwNN7iR9KJgiAtAa8plHUqIgVaEKq
	 Ad5Vl3jORribqoRc6+5XkNvPDWepwiQmIqOBuwFVM/YSwZ7PJjsqMIMN/Qs9lCSpzl
	 qFlgXhRRpytuJPPGmy+mTQwOg06RzaQtR2RRntMuOfPDqz0qBsX6ziXbvS5Yff4h1m
	 eA56Xv2s6WRew==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Jun 2025 23:19:56 +0200
Message-Id: <DAPZ1KYN5FB6.3C7CI4Y0OKOE0@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Asahi Lina"
 <lina@asahilina.net>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/5] rust: types: Add Ownable/Owned types
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250502-unique-ref-v10-0-25de64c0307f@pm.me>
 <20250502-unique-ref-v10-1-25de64c0307f@pm.me>
 <D9VS2Q4IX7LH.3JLXQUMWYJ2FP@kernel.org> <aFKICIo8L958iFbz@mango>
In-Reply-To: <aFKICIo8L958iFbz@mango>

On Wed Jun 18, 2025 at 11:34 AM CEST, Oliver Mangold wrote:
> On 250514 1132, Benno Lossin wrote:
>> On Fri May 2, 2025 at 11:02 AM CEST, Oliver Mangold wrote:
>>=20
>> > +/// - That the C code follows the usual mutable reference requirement=
s. That is, the kernel will
>> > +///   never mutate the [`Ownable`] (excluding internal mutability tha=
t follows the usual rules)
>> > +///   while Rust owns it.
>>=20
>> I feel like this requirement is better put on the `Owned::from_raw`
>> function.
>
> Thinking about it some more, the problem I see here is that if the type
> implements `OwnableMut` this requirement changes from "never mutate" to
> "never access at all".
>
> The safety requirements between `Ownable`, `OwnableMut`, `RefCounted`,
> `OwnableRefCounted` and `AlwaysRefCounted` are interacting, but I agree
> that, when looking at it a certain way, `Owned::from_raw()` is the place
> where one would expect these to be. I'm not sure anymore what is best her=
e
> :/

I still think `Owned::from_raw` is the correct place to put this.

>
>> > +pub unsafe trait OwnableMut: Ownable {}
>>=20
>> I don't like the name, but at the same time I also have no good
>> suggestion :( I'll think some more about it.
>
> There was already a bit of discussion about it. I had my own implementati=
on of this
> where I used the names `UniqueRefCounted` and `UniqueRef`, but after disc=
overing
> this version from Asahi Lina, I took it as it was, keeping the name.
>
> No one else came up with different suggestions so far, so maybe we should=
 just leave it
> at `Owned`/`Ownable`?

I'm just hung up on the `Mut` part... Haven't come up with a good
replacement yet.

---
Cheers,
Benno

