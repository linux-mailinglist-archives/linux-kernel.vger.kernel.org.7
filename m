Return-Path: <linux-kernel+bounces-808503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E08B500A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F2916EDC4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F5B350D5A;
	Tue,  9 Sep 2025 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ZeTsIQ3p"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1D322DBD;
	Tue,  9 Sep 2025 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430311; cv=pass; b=TcTOFv3+BTNiBJaHKF1rzkJ/I19/aAhttnkKBRDN4SFIhFb0LOVRf1jb6VJj8z0Rg2c2ZjLZaolkEyL/MjK95P/2QRuYKVGyBx+zJuHTWgKCoDEq7q5q1A+t0zJxIERq/ELceUwK6IQ74JiV9aR/XZEepbuWfYDcDdT0DNsvvdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430311; c=relaxed/simple;
	bh=yDLf6FUIpxyM6JQkVsExyR9HWXD6aOEbYtFCWKiryfo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HiNf+Qsb8lj2+MUBre7px9rcIXZJsbvdIdJ50YkyRxV50i+AcqKslGur/1OfGXhKbt5A6yJ9Y+wfGTvKGewoOcOYpo8DYeRTULPKsHfTVdUYIikSGUpBBrymmL1nS47fzHWZwCBObygb79sa4Wpsk3Jo8xHfJAqqPvmhk5DJGkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ZeTsIQ3p; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757430294; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=atPcNjuQ0qRC25CQqaY6qoS8+Wmy8G0vn2oCPHglb5RvqQtU6QTzwQ8ul/lLXyvepWeIGU3kCAv0FDqI1upoHP11+dC75+v4G+2+LGeRf7I2Ln6fjZW3NYNi6xkubrdn1d8qB2O7d0gP3WeYO0m33MJrpFWrhgIof5vwawzxr1U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757430294; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yDLf6FUIpxyM6JQkVsExyR9HWXD6aOEbYtFCWKiryfo=; 
	b=kCrvyp1goLyh9tcOTcM4d3ntfdkMhB4F5bbvm+1klR9E94xionbIAdpv+1Sa5CQWTCwUr/8JraeO8xdvcmw2X+dW4y0AfokDVy0nC2QP7costMvoD3sPuHGGpe/L8VMZNPl+/QjOhbJo2tPz2XDKhpkWQvXvcF4QoFYEuu5qpjo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757430294;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=yDLf6FUIpxyM6JQkVsExyR9HWXD6aOEbYtFCWKiryfo=;
	b=ZeTsIQ3pb4is2GznOIc2TjzuoD9CuLdg6n6LKIdpFdxcyN7h8WCAxt9/wrzD56Ep
	ybCPBXCQgAqJR278J3J1Y7GxQixuIPVVuldpohadR/caOvizZgO+UPC7dP8Exkx717R
	vVoOcMhNl/hAeRDLTmVkGFajfZbjfOFfpr246Lok=
Received: by mx.zohomail.com with SMTPS id 17574302917281020.9439590750935;
	Tue, 9 Sep 2025 08:04:51 -0700 (PDT)
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
In-Reply-To: <aL_PwXck1HsLp5wH@tardis-2.local>
Date: Tue, 9 Sep 2025 12:04:35 -0300
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
Message-Id: <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Boqun, thanks for chiming in!

> On 9 Sep 2025, at 03:57, Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
> On Mon, Sep 08, 2025 at 08:10:28PM -0300, Daniel Almeida wrote:
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
>> rust/helpers/regulator.c | 10 +++++++++
>> rust/kernel/regulator.rs | 58 =
+++++++++++++++++++++++++++++++++++++++++++++++-
>> 2 files changed, 67 insertions(+), 1 deletion(-)
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
>=20
> These two functions are already EXPORT_SYMBOL_GPL(), so you won't need
> to add rust_helper for them. Creating rust_helper_*() for them will =
just
> export additional symbols.

These are inlined (stubbed) if CONFIG_REGULATOR is not set, so we need =
the
helpers to get around that, IIUC.

In fact, doing the change you proposed will result in Intel=E2=80=99s =
bot
complaining. Same for all other functions defined in the helper C file.

=E2=80=94 Daniel


