Return-Path: <linux-kernel+bounces-804870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F089EB4811C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 00:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB4B3B6B62
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 22:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47B6226CE5;
	Sun,  7 Sep 2025 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn9ebj5m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475073597A;
	Sun,  7 Sep 2025 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757285468; cv=none; b=YtpCAsZFSPINPWhRTDc3nVex3UN00T7MD9zAXmpdtsgsyLPHEoXEccqLRg7Tsc2qpiTLM9cNEZx+kOusvMIi2x/aBX+kbLiBdjl8/PSIoTyG/jQeKq6qG4zDtjt+PLhkt05UBWwWDJNQJGR/KieNgXdoAPXjxo5f0F/rUkkZ5cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757285468; c=relaxed/simple;
	bh=fGTCI6P9ODPKffPJ8VaT5xwiykzdLEdHOnQvoxGRM0E=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=HSNo/maug4ln0CWHru1vqBEXvyu/rRXlTOj7djGjOIvbcg611oRdw4xaFF+//pQHthXF02p94tjYaGB6J4ikxbh8wtK7lWjpwNzWxDu8nGH1rO66lPMt3TJR4Uu80Jmc9PxO7nAawsEmBXj/RJ61iOw9CtT2f1nCAU8uBTN/YRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn9ebj5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937D4C4CEF0;
	Sun,  7 Sep 2025 22:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757285467;
	bh=fGTCI6P9ODPKffPJ8VaT5xwiykzdLEdHOnQvoxGRM0E=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Nn9ebj5mWCCwon78T5jk2zTUli/MpCoW/zNc5NuiejJw++46mbBMREx8zLLjMj5iO
	 RPiPrp3M5FtyCj7sevS1Oul2dYjFDuXrzhq18IYJyI5aCccHtqzVcILTZpTejdOyTR
	 7tiszVKcx/5Hmc5xRS/bNiPO9kFX36H04oezCu5PyyQyGCtS0Es3MijkqRUSF05ses
	 HemmMH2StyNm6gTx2rRp/3RCcAy7kn/LLbYM9/u5HuY4ShPWc+Zf/844ELMHKZBo8I
	 07QcaNZXdr/XOMnLIjlsLPnyL9a5L0hvLxr7KmYf9Uy+X2U8DFuLtl7iPK54aVKUvR
	 3dChO8EYnqMAA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 00:51:02 +0200
Message-Id: <DCMXPGXDXHYT.D9VJ5QBMAVPN@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
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
Subject: Re: [PATCH] rust: pin-init: add references to previously
 initialized fields
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250905140047.3325945-1-lossin@kernel.org>
 <DCL1DPN708H0.3JTL93J2GD2DR@kernel.org> <aLshd0_C-1rh3FAg@tardis-2.local>
 <DCLNSNWA7AT7.19OWOXUMJ5ZRJ@kernel.org> <aLzmcK2UM53I2Tbn@tardis-2.local>
 <aLzoyWpOr6eg-3yB@tardis-2.local> <DCMFN8UGD7QN.27HTYEXL87Z8@kernel.org>
 <DCMQVH09L1Y5.3A842FC1NGG5H@kernel.org>
 <DCMVHB8P7Z2G.PCOWPQXBSBT6@kernel.org>
 <DCMW6H0VJ9AP.1XWI1RI9YWO9H@kernel.org>
In-Reply-To: <DCMW6H0VJ9AP.1XWI1RI9YWO9H@kernel.org>

On Sun Sep 7, 2025 at 11:39 PM CEST, Danilo Krummrich wrote:
> On Sun Sep 7, 2025 at 11:06 PM CEST, Benno Lossin wrote:
>> On Sun Sep 7, 2025 at 7:29 PM CEST, Danilo Krummrich wrote:
>> I have some ideas of changing the syntax to be more closure-esque:
>>
>>     init!(|this| -> Result<MyStruct, Error> {
>>         let x =3D 42;
>>         MyStruct {
>>             x,
>>         }
>>     })
>>
>> There we could add another parameter, that would then serve this
>> purpose. We should also probably rename `this` to `slot` & then use
>> `this` for the initialized version.
>
> I think that's a pretty good idea, but the part that I think is a little =
bit
> confusing remains: `this` will need to have different fields depending on=
 where
> it's accessed.

Yeah (that's also the main issue with the macro implementation).

>> But as I said before, implementing the `this` thing from a macro
>> perspective is rather difficult (I have two ideas on how to do it and
>> both are bad...).
>>
>>> But as you say, that sounds tricky to implement and is probably not ver=
y
>>> intuitive either. I'd rather say keep it as it is, if we don't want som=
ething
>>> like the `let b <- b` syntax I proposed for formatting reasons.
>>
>> I don't feel like that's conveying the correct thing, it looks as if you
>> are only declaring a local variable.
>
> Yeah, it's not great, but given that it's a custom syntax it also does no=
t
> create wrong expectations I'd say.

I'd say it looks like combining the `<-` operation already used by the
`init!` macro & a `let` binding. Thus introducing a local variable
that's (pin) initialized in-place. Not a field of the current struct.

> Anyways, I'm fine with either. For now we probably want to land the versi=
on as
> it is and revisit once you settle on the syntax rework you mentioned abov=
e.

I actually came up with a third option that looks best IMO:

    init!(MyStruct {
        x: 42,
        #[with_binding]
        y: 24,
        z: *y,
    })

The `#[with_binding]` attribute makes the macro generate a variable `y`.
`x` & `z` don't give access to their value. (we of course should come up
with a better name).

Any thoughts?

---
Cheers,
Benno

