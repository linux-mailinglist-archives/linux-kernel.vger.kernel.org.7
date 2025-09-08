Return-Path: <linux-kernel+bounces-805317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5AFB4870F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4338188C814
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987F32ECEB4;
	Mon,  8 Sep 2025 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BED/ImHn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39692EAB6D;
	Mon,  8 Sep 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320065; cv=none; b=UGA3f70u/e/6bAZon/7nwR3705mTPNPvQrfagWQzXyLC7GD+wG3a+nXccEgku5wN8K0hCBqthNBYnEgceGZeFsLXUXoW70uVIBdORWJ+xb6thUz8Bnee4llWSaZDqmhrx/kHBgSSLCsL97Psw+6+N6VQC7fWPBoy9/3lrnAh54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320065; c=relaxed/simple;
	bh=PGcMOiibMBT17hb1tPtCXM68d4wcDBo2s2BOvEcSq9U=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=cMl+xQ+qZRGag5yWOToADGssWG/eJsmXH+jWhI8eY9OAH9JVDsdtOy/N7GzXtcxIiq/kG3Siuent6+WhrUJ3y0xg9S1i2dcQJMHBhGStftNdv+c3EeEGI5aDNRp3V0uNVDTbz6wBlklPRyhz8H53rhPPtRB4amo0XFNxxXmIObc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BED/ImHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501CEC4CEF8;
	Mon,  8 Sep 2025 08:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757320065;
	bh=PGcMOiibMBT17hb1tPtCXM68d4wcDBo2s2BOvEcSq9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BED/ImHnfhx2giT5/XSj+ds4qNLbCwiJVIMY56jxgFihnTyeTpzP5t5/Uf+WoKXev
	 kff6yrmiF6j1NsjJDQrh/LXEAw8SKdVkX7p4L2AgNMzphyAWQHrtpEjkuF+d4MKFQ2
	 LR5c52bNgoyyrdb57fxIu2WP/zWDd9dR/tPWLXHCQk17igYmAeeIxxAtvRE/CDg2mB
	 mAH8nqOmmMbRAtZc73iWKQU2KtTfRKogIPytZZo0wUWLkDzrCM8p+g+CRkAXnpt/+D
	 6UO3GHvqi7PcLYXXQgM901irEK5lSFg9Il+63eiet3kKo+sKfUNHM9ZdzRMcskvgwb
	 dqL4gBUUPOW4A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 10:27:40 +0200
Message-Id: <DCN9YYV750Q4.3K9X2EAA3RKJ8@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
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
X-Mailer: aerc 0.20.1
References: <aLshd0_C-1rh3FAg@tardis-2.local>
 <DCLNSNWA7AT7.19OWOXUMJ5ZRJ@kernel.org> <aLzmcK2UM53I2Tbn@tardis-2.local>
 <aLzoyWpOr6eg-3yB@tardis-2.local> <DCMFN8UGD7QN.27HTYEXL87Z8@kernel.org>
 <DCMQVH09L1Y5.3A842FC1NGG5H@kernel.org>
 <DCMVHB8P7Z2G.PCOWPQXBSBT6@kernel.org>
 <DCMW6H0VJ9AP.1XWI1RI9YWO9H@kernel.org>
 <DCMXPGXDXHYT.D9VJ5QBMAVPN@kernel.org>
 <DCMYLXICOGM7.2G4JBQAE7805B@kernel.org> <aL46nRkYj2SlOhl8@tardis-2.local>
In-Reply-To: <aL46nRkYj2SlOhl8@tardis-2.local>

On Mon Sep 8, 2025 at 4:08 AM CEST, Boqun Feng wrote:
> On Mon, Sep 08, 2025 at 01:33:26AM +0200, Danilo Krummrich wrote:
>> On Mon Sep 8, 2025 at 12:51 AM CEST, Benno Lossin wrote:
>> > I actually came up with a third option that looks best IMO:
>> >
>> >     init!(MyStruct {
>> >         x: 42,
>> >         #[with_binding]
>> >         y: 24,
>> >         z: *y,
>> >     })
>> >
>> > The `#[with_binding]` attribute makes the macro generate a variable `y=
`.
>> > `x` & `z` don't give access to their value. (we of course should come =
up
>> > with a better name).
>> >
>> > Any thoughts?
>>=20
>> It may be a bit verbose is some cases, but it makes things pretty obviou=
s, so
>> LGTM.
>>=20
>> How about just #[bind] or #[access]?

I like `#[bind]`.

> #[shadow] or #[maybe_rebind] ? Or #[pin_ref], the last one is clear
> about the purpose.

Hmm in `init!` it's never pinned.

---
Cheers,
Benno

