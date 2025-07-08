Return-Path: <linux-kernel+bounces-721584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BE0AFCB5F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5899516FF7D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023CB2DBF5D;
	Tue,  8 Jul 2025 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIZ2F5MI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA621F4CB2;
	Tue,  8 Jul 2025 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980008; cv=none; b=Mf2zMPexJRVXojT09ZKwD8Jr0sW87qd7DPl/DWaFh3nVJN9znRXHapYCNNeCJp364Ut53WCKnCnksZXON9fe1WRqg5abrMG7Y2sB79rp3AkKgsHiAhG5eCsIAjyfQ9mSLWaG9N+v5V94lZvml1Y+s9HlHJ2gPsHDRiVD/8HBumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980008; c=relaxed/simple;
	bh=XYrkKyZgWY8IZZADaNP4i2qGUIJ6T7ql6F4XTIyDbng=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Bh0NxQpPPv01l4QcJakZ7fJqzsjSsOhJA542Z8Pro/cK117ukMHfA8Kh60hPQl4EWMa/jnqIsqsowlzx5YgbXkhgV8Ky0teDPUinPIbyjZSLtaotTodieYYDAMiyOeU2rP7voeIJ3wGKwj6WMpiWJiOOYVsNa3Jt9Tv+8l4+SWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIZ2F5MI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823DDC4CEED;
	Tue,  8 Jul 2025 13:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751980007;
	bh=XYrkKyZgWY8IZZADaNP4i2qGUIJ6T7ql6F4XTIyDbng=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=SIZ2F5MIVn07HFPiPituRdZFG44LNOIGtrVnYx7LilEbdLOmD4bi9B5falz4Br5Bp
	 8P1HY9/3aoQ82h2ONhMJVH4VTfgE8dEsgzvdFN1092G2B4C6WcT5nEw8Lvow6QaUuI
	 LL+iwsQCXe/X6Iu9FJ3D1YgxSbg36sajctGKmSE8uk/+uWravLegj4xPDpc8zHFu4n
	 0Zbc4R3hh17hjiOBT4Q7JzjZyPuvxmPRZ0dlxknkdg34wcHvNtvz+APaoxmJrBL3bq
	 Tbxhn8VpxqYfe3OQrngk+fPd6+S6fliqWO2mgB280BFP9ynGjoZIo2FUh4Ao6LqbJN
	 lf3t/wv0IL+dQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 15:06:43 +0200
Message-Id: <DB6P2UQM08LH.2ALUM6EKC3Q45@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Asahi Lina" <lina+kernel@asahilina.net>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
From: "Benno Lossin" <lossin@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Oliver Mangold"
 <oliver.mangold@pm.me>
X-Mailer: aerc 0.20.1
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me>
 <DB1IPFNLFDWV.2V5O73DOB2RV6@kernel.org> <aGtv9qs682gTyQWX@mango>
 <DB5PPGOWNW4K.2C5A4UE9V9IEF@kernel.org> <aGzrZqIrStGD_UBp@mango>
 <CANiq72kWFYS-inzFPTQAGdPRBr7MffZLR9q7iWiT_j2w_e99MQ@mail.gmail.com>
In-Reply-To: <CANiq72kWFYS-inzFPTQAGdPRBr7MffZLR9q7iWiT_j2w_e99MQ@mail.gmail.com>

On Tue Jul 8, 2025 at 12:16 PM CEST, Miguel Ojeda wrote:
> On Tue, Jul 8, 2025 at 11:57=E2=80=AFAM Oliver Mangold <oliver.mangold@pm=
.me> wrote:
>>
>> Note, though, that I already moved it from types.rs to types/ownable.rs =
on
>> request. It seems to me different people here have different ideas where=
 it
>> should be placed. I feel now, that it would make sense to come to an
>> agreement between the interested parties about where it should finally b=
e
>> placed, before I move it again. Could I ask that we settle that question
>> once and for all before my next revision?
>
> Yeah, if there is a disagreement with something said previously, then
> it should be resolved before starting to ping-pong between approaches
> with more and more patch versions. Reviewers can forget or they may
> not have read an earlier comment, but you did the right thing
> mentioning there is such a conflict in opinions.

Yeah, I checked and that was Andreas on v9. @Andreas what do you think?

I think we should just get rid of `types.rs` and split it into:

* `opaque.rs`
* `foreign.rs`
* `scope_guard.rs` (this might need a better name)

`Either` can just be removed entirely, `AlwaysRefcounted` & `ARef`
should be in the `sync` module (I already created an issue for this) as
well as `NotThreadSafe` (or we could create a `marker` module for that).
Thoughts?

---
Cheers,
Benno

