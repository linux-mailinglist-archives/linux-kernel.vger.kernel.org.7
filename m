Return-Path: <linux-kernel+bounces-808605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5FCB50235
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648193B53EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D91D33EB15;
	Tue,  9 Sep 2025 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="X69xpkj0"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B236124;
	Tue,  9 Sep 2025 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434405; cv=pass; b=uW3j4l4pDGn92vL1jegqlH9WlAjtcEARBRg9GEu9u7CTSmPntlJy//WZfRXwtlacme2I2K7BXJAP0XyeAXsEYtC9jwXOpruS2ygPbwRcg/tiDvcMOgykTpkViyoSI0qosNYBW/jyFxkoBdblxOmGJbD3LT/0FJT0ncjrPftmtv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434405; c=relaxed/simple;
	bh=16EcF/iYO/Q987hJE3vHax7ubkQSrv8htSNhM9tPQZU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=smPs+USByiLi9YrXX+Zg3JlBhMNcEkS2SyYgiPdKpfK4uvVmZ374EL6Ym+NCtu+pVdG6vAAcf9DVrcW39Sd1dvYNUSo0rSvp7t3ApzIVL6+sUBluSuzprc3HtzLLeZry+g8/BsL3JkBjrEtWkGraUHdYJ+vjeZo0OW1Ya6zT7DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=X69xpkj0; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757434389; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=atUOZXQRSK/DXAWNftmQAt+h4rUMp7ZFthyhYEiHJPW2lCDaWP6qrHtL38oHxHOZ6DJH9zcMU44SUlS76/+tt66YJWxmON8MCv7xsotUBNyu6JlAorxlV2LLg6ZZA3vo6kUBiYZ9/5onYt0UtRDHTIt+crRG+cZDb9DWBGYbLbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757434389; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=16EcF/iYO/Q987hJE3vHax7ubkQSrv8htSNhM9tPQZU=; 
	b=WGJl16zmiD7maN9N/i2zdiuHDUWG4CvGtTuYTnNmsscEskvCjniktK7jIi4k8KEytZ3sMMl5z1hzuYHO8J3ZV74DXGvq7untiEfdY89qkcDMztgqa1IvN6516bzOoJNydSVido7OYkml/aCWcorpiBwp6U5Xpp8OaUd9FcyG8CE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757434389;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=16EcF/iYO/Q987hJE3vHax7ubkQSrv8htSNhM9tPQZU=;
	b=X69xpkj0nSvR+fDAGJZ5Y0sGMkD3puMrdA0CpKk1GhitMVY6HiH9xC7iMAL9RvnT
	nfpqraHaeTRkNcUkRmSkGIEfAVphdHm+4Wb3zmGIz1qmCYajR+R3iomjvZ2kRWetJOj
	0ewet1cjx+WH2A9kz/jJoK/5JhCr6DY4JewvrPTw=
Received: by mx.zohomail.com with SMTPS id 1757434387476350.1436464211441;
	Tue, 9 Sep 2025 09:13:07 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aMBJ805QjQcPdRol@tardis-2.local>
Date: Tue, 9 Sep 2025 13:12:51 -0300
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8CA69D19-754C-43F5-96CD-B7060C68B025@collabora.com>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local>
 <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
 <aMBJ805QjQcPdRol@tardis-2.local>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 9 Sep 2025, at 12:38, Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
> On Tue, Sep 09, 2025 at 12:04:35PM -0300, Daniel Almeida wrote:
>> Hi Boqun, thanks for chiming in!
>>=20
>>> On 9 Sep 2025, at 03:57, Boqun Feng <boqun.feng@gmail.com> wrote:
>>>=20
>>> On Mon, Sep 08, 2025 at 08:10:28PM -0300, Daniel Almeida wrote:
>>>> A lot of drivers only care about enabling the regulator for as long =
as
>>>> the underlying Device is bound. This can be easily observed due to =
the
>>>> extensive use of `devm_regulator_get_enable` and
>>>> `devm_regulator_get_enable_optional` throughout the kernel.
>>>>=20
>>>> Therefore, make this helper available in Rust. Also add an example
>>>> noting how it should be the default API unless the driver needs =
more
>>>> fine-grained control over the regulator.
>>>>=20
>>>> Suggested-by: Danilo Krummrich <dakr@kernel.org>
>>>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>>>> ---
>>>> rust/helpers/regulator.c | 10 +++++++++
>>>> rust/kernel/regulator.rs | 58 =
+++++++++++++++++++++++++++++++++++++++++++++++-
>>>> 2 files changed, 67 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/rust/helpers/regulator.c b/rust/helpers/regulator.c
>>>> index =
cd8b7ba648ee33dd14326c9242fb6c96ab8e32a7..11bc332443bd064f4b5afd350ffc045b=
adff9076 100644
>>>> --- a/rust/helpers/regulator.c
>>>> +++ b/rust/helpers/regulator.c
>>>> @@ -40,4 +40,14 @@ int rust_helper_regulator_is_enabled(struct =
regulator *regulator)
>>>> return regulator_is_enabled(regulator);
>>>> }
>>>>=20
>>>> +int rust_helper_devm_regulator_get_enable(struct device *dev, =
const char *id)
>>>> +{
>>>> + return devm_regulator_get_enable(dev, id);
>>>> +}
>>>> +
>>>> +int rust_helper_devm_regulator_get_enable_optional(struct device =
*dev, const char *id)
>>>> +{
>>>> + return devm_regulator_get_enable_optional(dev, id);
>>>> +}
>>>> +
>>>=20
>>> These two functions are already EXPORT_SYMBOL_GPL(), so you won't =
need
>>> to add rust_helper for them. Creating rust_helper_*() for them will =
just
>>> export additional symbols.
>>=20
>> These are inlined (stubbed) if CONFIG_REGULATOR is not set, so we =
need the
>> helpers to get around that, IIUC.
>>=20
>=20
> Well, then the question is why we want to compiler regulator.rs if
> CONFIG_REGULATOR=3Dn? Shouldn't we do:

Yes, we do want to compile regulator .rs. There=E2=80=99s been prior =
discussion on
this (see [0] below, but also [1]).

>=20
> #[cfg(CONFIG_REGULATOR)]
> pub mod regulator
>=20
> in rust/kernel/lib.rs?

This was the original approach, but this is incorrect behavior (again, =
see
[0]). The right thing to do is to call the stubs if CONFIG_REGULATOR is =
not
set, not make the regulator API unavailable.

>=20
>> In fact, doing the change you proposed will result in Intel=C2=B4s =
bot
>> complaining. Same for all other functions defined in the helper C =
file.
>>=20
>=20
> With above, we probably can remove the whole helper file for =
regulator.

Given the above, we cannot remove the file, and we must also add the =
devm
helpers as they are in the current patch.

=E2=80=94 Daniel

[0] =
https://lore.kernel.org/rust-for-linux/a1b3561d-f5de-4474-85ef-1525a6c36bc=
5@arm.com/T/#mdf9d4005ee99929d0009ccc988efbc0789164b6d

[1] =
https://lore.kernel.org/rust-for-linux/25e9a9b6-4d81-4731-98fa-add40ccd4aa=
b@sirena.org.uk/





