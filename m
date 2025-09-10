Return-Path: <linux-kernel+bounces-809932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CEDB5139A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980951759A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7FE3126AE;
	Wed, 10 Sep 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnA73z3D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747325A34B;
	Wed, 10 Sep 2025 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499148; cv=none; b=bBQUDz/casKNP8NjBLupYqKGLqpZe0aH2gDipWfQbYtQiWQQFv/E7kGC7hM57qtN7wEHyIpovwHmm8XmUNrlqxu0S6CKGjU+mUyiWR+GTyA0rHT/FUJpcrBpaBPHdQq5FH+Q/VdDu6srJ80ut0vYaXcmZMPp25NGkqK4r7zEKSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499148; c=relaxed/simple;
	bh=bYXhpBox2lBn11Q9QPO3VJPiL3p6yhug4eB2dcXMO+g=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XLIjkOsvJgNZoSYMV5l8WRDOYIYOPr6L8cafXbnJC6DlU/DhZxf3lPN3aLvXQg+7nsgXF+DdICZhYvBIeYIdBYjsFz1WdvsdgCpHhruNUtEehHp3pW62HsUfueoGK1PTJkadPqmEZbAmw9Zrlq/HHPCjD2b3KlTn02KQDzEkEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnA73z3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426C1C4CEF0;
	Wed, 10 Sep 2025 10:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757499148;
	bh=bYXhpBox2lBn11Q9QPO3VJPiL3p6yhug4eB2dcXMO+g=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=VnA73z3D8HGvjHrGBGTrr2EkW7eMKJC+or4GVSL5gp79sdzZM5IgmKmlBMOROgMNU
	 yz85+U4FBS45CKXaBCgT53p/sw7KXybyaEpXht6FWfF6UhrMRubJBNbxcIie4ykH89
	 KwrPi5YaCR0L1oTabyR/QFxoXploXtErb3sEUMPepDfnqrcmRdm9hTobk3J64D8BpK
	 AeGZzgb8dtJfIrF9Jv9KJ/voa8hJjWtH03vhBbhYc3iJxmIlhyNYKI5EJPK9vsfM1Q
	 aIUiTPbKVs4OhNsSdACqBC+qFVtC5NDx4vFvUv9jwKNohNXphoKUjK5jvfzkXrubIP
	 eoDmk7CBZct8A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 12:12:23 +0200
Message-Id: <DCP1G8B2LF4X.3R6HTYHUX3YAR@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Fiona Behrens" <me@kloenk.dev>, "Alban
 Kurti" <kurti@invicto.ai>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: pin-init: add references to previously
 initialized fields
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <aLzoyWpOr6eg-3yB@tardis-2.local>
 <DCMFN8UGD7QN.27HTYEXL87Z8@kernel.org>
 <DCMQVH09L1Y5.3A842FC1NGG5H@kernel.org>
 <DCMVHB8P7Z2G.PCOWPQXBSBT6@kernel.org>
 <DCMW6H0VJ9AP.1XWI1RI9YWO9H@kernel.org>
 <DCMXPGXDXHYT.D9VJ5QBMAVPN@kernel.org>
 <DCMYLXICOGM7.2G4JBQAE7805B@kernel.org> <aL46nRkYj2SlOhl8@tardis-2.local>
 <DCN9YYV750Q4.3K9X2EAA3RKJ8@kernel.org>
 <DCNALVTE4DIN.1K0U4BGN35CHI@kernel.org> <aL8wnJcro6uXiD74@tardis-2.local>
In-Reply-To: <aL8wnJcro6uXiD74@tardis-2.local>

On Mon Sep 8, 2025 at 9:38 PM CEST, Boqun Feng wrote:
> On Mon, Sep 08, 2025 at 10:57:36AM +0200, Danilo Krummrich wrote:
>> On Mon Sep 8, 2025 at 10:27 AM CEST, Benno Lossin wrote:
>> > On Mon Sep 8, 2025 at 4:08 AM CEST, Boqun Feng wrote:
>> >> On Mon, Sep 08, 2025 at 01:33:26AM +0200, Danilo Krummrich wrote:
>> >>> On Mon Sep 8, 2025 at 12:51 AM CEST, Benno Lossin wrote:
>> >>> > I actually came up with a third option that looks best IMO:
>> >>> >
>> >>> >     init!(MyStruct {
>> >>> >         x: 42,
>> >>> >         #[with_binding]
>> >>> >         y: 24,
>> >>> >         z: *y,
>> >>> >     })
>> >>> >
>> >>> > The `#[with_binding]` attribute makes the macro generate a variabl=
e `y`.
>> >>> > `x` & `z` don't give access to their value. (we of course should c=
ome up
>> >>> > with a better name).
>> >>> >
>> >>> > Any thoughts?
>> >>>=20
>> >>> It may be a bit verbose is some cases, but it makes things pretty ob=
vious, so
>> >>> LGTM.
>> >>>=20
>> >>> How about just #[bind] or #[access]?
>> >
>> > I like `#[bind]`.
>> >
>> >> #[shadow] or #[maybe_rebind] ? Or #[pin_ref], the last one is clear
>> >> about the purpose.
>> >
>> > Hmm in `init!` it's never pinned.
>>=20
>> I thought about #[shadow] as well, but it is not really accurate I think=
, as we
>> might not shadow anything. #[maybe_rebind] sounds a bit like it conditio=
nally
>> rebinds, as in "it may not do anything", but it always binds.
>>=20
>> So, I think it should one clear instruction, i.e. #[bind], #[access], #[=
ref],
>> #[use], #[let], etc.
>
> In that sense I think `#[let]` is best? Because it indicates this field
> initialization works as a `let`-statement (in term of creating a new
> binding), of course I don't have strong ojections against other options.

Ultimately I decided to go with `#[bind]`, since I felt like `#[let]`
might be confused with just having a let statement (ie replacing the
assignment with a let binding).

`#[bind]` also might be confused with some device binding I guess, but
we can rename it's too bad.

---
Cheers,
Benno

