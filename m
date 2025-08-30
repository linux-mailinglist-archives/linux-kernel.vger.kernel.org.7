Return-Path: <linux-kernel+bounces-792977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FB0B3CB18
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5341BA40C0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF5258EC8;
	Sat, 30 Aug 2025 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="aR8iw5dA"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D165D221F2F;
	Sat, 30 Aug 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756559669; cv=pass; b=TztvpMPDDyOfltYsEO9KRjbtIgjofNiC49tUbhHn8E9GvkIVwinubA2sZ0WRrZqAnDcsALOPYWCMm4i/qSkWFOVjn+OYFMJOiLaUwUN9nx2ENYWksQ64/j7hIS8GldE3fMWoue/TrBcjqKTU7zkaUiN1z21fHg4tWVMjiP+Q7hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756559669; c=relaxed/simple;
	bh=g/6h3MLOSw8E8JP8tDMoxF5DD0aa4WZk2z8vXWSE5Ls=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JWT/PpSeIB3UBqZTDLVBLSJN7iBBxjj3WMk1pd2fojzlEnjqYY/VP7DEEVm5rPU6eGvCEnx/iaK79gdRZf6zq1/rQlGwisdGLuvGVoHfRfHOPLYZyj5bxUt+SHE8Iy51MZeN00LByN/VS90aCTyDIONisL7TOmCSCbYPBK5c/w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=aR8iw5dA; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756559643; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GSTOsbarP6cnJ4c7azrFt4csIcZ5vK1ow9O+TuyJGXVQnx4w3iN+YIL8J+oD8v3yT8VbM/8EonsXGa0hm2M59U/xmMpDfswudXZlvNkIlG13V6TEGQyzBFEwK5jmbL03eyxXIAqBC5qxMgfBZeKFuMmcledaUKxkvEYLy29CH+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756559643; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=z0GxsGKSQjORQ1YKSQHGOGk0jyVSUNf6PTaoVMnRtnc=; 
	b=RJwdIn9Kjd6XHjirpb9U91gZHQAVJIOWRzpd2LoqPRlijfYh45w5fGM2Lb/Q6GXkyylSjYLDfRnN51rMWkOe04GTQezKaXJXpyZf9MHw7X2Mz28AQspsaI9lM7BafBFu68smOc6TdcSE4BlrEhkOGKhyMsKv9XMu98y8tiC9eMU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756559643;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=z0GxsGKSQjORQ1YKSQHGOGk0jyVSUNf6PTaoVMnRtnc=;
	b=aR8iw5dAX9ylLPQQTCOpQ3cb1R/kT8EqschFp6SQzqTqGKJnpmKOh1Xb5+dFsIFq
	EoIvGOVLrDtZlDxgAFG9vXDIv/PE4h/jlahLSqBJdfmIR8g/swnMTP8IaXWIlvnFzyG
	UmdumQUIqpESAesdw7s5dnAM/5LF6VOnDeLQecWM=
Received: by mx.zohomail.com with SMTPS id 1756559641661303.35423052507974;
	Sat, 30 Aug 2025 06:14:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/2] rust: regulator: add devm_regulator_get_enable API
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DCFID32NEFH0.3JB41XV88JZ3F@nvidia.com>
Date: Sat, 30 Aug 2025 10:13:45 -0300
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
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
Message-Id: <DB27F561-30AD-400E-811B-19CEAE511CFA@collabora.com>
References: <20250829-regulator-remove-dynamic-v1-0-deb59205e8e9@collabora.com>
 <20250829-regulator-remove-dynamic-v1-2-deb59205e8e9@collabora.com>
 <DCFID32NEFH0.3JB41XV88JZ3F@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Alex,

> On 30 Aug 2025, at 02:20, Alexandre Courbot <acourbot@nvidia.com> =
wrote:
>=20
> On Sat Aug 30, 2025 at 6:11 AM JST, Daniel Almeida wrote:
>> A lot of drivers only care about enabling the regulator for as long =
as
>> the underlying Device is bound. This can be easily observed due to =
the
>> extensive use of `devm_regulator_get_enable` and
>> `devm_regulator_get_enable_optional` throughout the kernel.
>>=20
>> Therefore, make this helper available in Rust. Also add an example
>> noting how it should be the default API unless the driver needs more
>> fine-grained control over the regulator.
>>=20
>> Suggested-by: Danilo Krummrich <dakr@kernel.org>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>> ---
>> rust/helpers/regulator.c | 10 ++++++++++
>> rust/kernel/regulator.rs | 42 =
+++++++++++++++++++++++++++++++++++++++++-
>> 2 files changed, 51 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/rust/helpers/regulator.c b/rust/helpers/regulator.c
>> index =
cd8b7ba648ee33dd14326c9242fb6c96ab8e32a7..11bc332443bd064f4b5afd350ffc045b=
adff9076 100644
>> --- a/rust/helpers/regulator.c
>> +++ b/rust/helpers/regulator.c
>> @@ -40,4 +40,14 @@ int rust_helper_regulator_is_enabled(struct =
regulator *regulator)
>> return regulator_is_enabled(regulator);
>> }
>>=20
>> +int rust_helper_devm_regulator_get_enable(struct device *dev, const =
char *id)
>> +{
>> + return devm_regulator_get_enable(dev, id);
>> +}
>> +
>> +int rust_helper_devm_regulator_get_enable_optional(struct device =
*dev, const char *id)
>> +{
>> + return devm_regulator_get_enable_optional(dev, id);
>> +}
>> +
>> #endif
>> diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
>> index =
60993373f4d911f4f0cbec2510f0c67efa24a51b..73d4c9b56dca9c676793d78e35e5758d=
18eef3e8 100644
>> --- a/rust/kernel/regulator.rs
>> +++ b/rust/kernel/regulator.rs
>> @@ -18,7 +18,7 @@
>>=20
>> use crate::{
>>     bindings,
>> -    device::Device,
>> +    device::{Bound, Device},
>>     error::{from_err_ptr, to_result, Result},
>>     prelude::*,
>> };
>> @@ -70,6 +70,26 @@ pub struct Error<State: RegulatorState> {
>>     pub regulator: Regulator<State>,
>> }
>>=20
>> +/// Enables a regulator whose lifetime is tied to the lifetime of =
`dev`.
>> +///
>> +/// This calls `regulator_disable()` and `regulator_put()` =
automatically on
>> +/// driver detach.
>> +///
>> +/// This API is identical to `devm_regulator_get_enable()`, and =
should be
>> +/// preferred if the caller only cares about the regulator being on.
>> +pub fn enable(dev: &Device<Bound>, name: &CStr) -> Result {
>=20
> The name `enable` sounds like it just enables a regulator, which is a =
bit
> confusing IMHO. Maybe `get_enable` or `get_enable_for`? Not sure what
> would be idiomatic here.

So I thought about get_enabled, but I thought the "get" nomenclature was
confusing. For example, "get" acquires a refcount, but for the devm_ =
version
the refcount management is transparent. In this sense, I thought that =
just
"enable" would convey the idea better, i.e. "enable this and forget =
about any
lifetime management at all".

If you still think that using the "get" prefix is better, I can change =
it no
worries :)

>=20
>> +    // SAFETY: `dev` is a valid and bound device, while `name` is a =
valid C
>> +    // string.
>> +    to_result(unsafe { =
bindings::devm_regulator_get_enable(dev.as_raw(), name.as_ptr()) })
>> +}
>> +
>> +/// Same as [`enable`], but calls =
`devm_regulator_get_enable_optional` instead.
>=20
> Maybe explain in one sentence what =
`devm_regulator_get_enable_optional`
> as it might not be completely obvious.

Perhaps adding a link?

>=20
>> +pub fn enable_optional(dev: &Device<Bound>, name: &CStr) -> Result {
>> +    // SAFETY: `dev` is a valid and bound device, while `name` is a =
valid C
>> +    // string.
>> +    to_result(unsafe { =
bindings::devm_regulator_get_enable_optional(dev.as_raw(), =
name.as_ptr()) })
>> +}
>> +
>> /// A `struct regulator` abstraction.
>> ///
>> /// # Examples
>> @@ -146,6 +166,26 @@ pub struct Error<State: RegulatorState> {
>> /// }
>> /// ```
>> ///
>> +/// If a driver only cares about the regulator being on for as long =
it is bound
>> +/// to a device, then it should use [`regulator::get_enabled`] or
>> +/// [`regulator::get_enabled_optional`]. This should be the default =
use-case
>=20
> I suppose you mean `enable` and `enable_optional` instead of
> `get_enabled` and `get_enabled_optional` (although I personally would
> favor the latter :)).

Hmm, something happened here. I always make sure to run rustdoc before
submitting, and it did not error out even though this function does not =
exist.

In any case, my bad.

=E2=80=94 Daniel




