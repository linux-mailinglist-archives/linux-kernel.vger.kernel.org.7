Return-Path: <linux-kernel+bounces-788724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3FBB38945
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481257C4A89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16742D2483;
	Wed, 27 Aug 2025 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Ve0PpHKk"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3501278E7C;
	Wed, 27 Aug 2025 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318059; cv=pass; b=FLdEgOZmGrUuMMSkqVmfy0LWNZ7gasZeXDZwEcZAvtxYQR5XR+Xvgj80mi0J7+63V2Ig0z7Q6fBkEoaDIXN8MWjljHtalhuVED8KXHvSLayvHnyKf6/qLkNVKfHYjbBDf4EygyUVdhelCB3uzWyHPiQS1ERISEWBidTwWb56dAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318059; c=relaxed/simple;
	bh=AxBXSo2Fw9dOVAY+F5+8EtyXRQYdzP12cThOUbkVjNc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qm1OnizjlSyy3pylK6w0EP7MG4pmCFvdlDnWylcxEzuPBzSCZmQI38dRYlPLG61srcblIHQdVNPCibHwVMYduzunUoqdvcKTGUXqQGSJ0HrKwjysc7wrrKD3xenwxE7cawPqAa/2J3cj+Y5dxG/0sX/g34CjsD91XLCIHrb8B2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Ve0PpHKk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756318039; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c1nmMz2S9S1ZGqwABq9+dpokY3U1sUFFJprD86IyLryfIZ1CXhvym9qXOHjKN51d7lGWbYq4XkBgWTRrrgpCUaxmmoKmBSxsGtGXf/JtwQsYZlSv72vlr9Au/R35EGg1Y/RYJsSx6TXS2URXh/ZuZsD00+/OIG/qAChNmnZASH8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756318039; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=guGifk1/HZu+Zmhvno/QhB/iuQPf/SeDPeL8b6rcCwc=; 
	b=H3jkqNIQeiBEpYquY9uIxZqWvIVeOcEEIip6j+tMULWxePBzlUw5aJW1H7pHO+AShVm5sNjnwOitkl2vBoaLairZlZk9ltw1BXsJ0q4hzqFPTXLelEoPqQB54pEOhuRU3gLHTc/vt4RoenQh+5CralUbbo419ui5evFGEF3C5EQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756318039;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=guGifk1/HZu+Zmhvno/QhB/iuQPf/SeDPeL8b6rcCwc=;
	b=Ve0PpHKkcJ7zab7sYjunETGK47CDA7AmestbEnP1Pzp0m4ss3PGn7SIfkZ+uXEu3
	2RQkuXTRofhlbxQeLv46Ik8//AOKLettQiiqFg8HBYmkhk736+3iqdjsBl+tbLblbRv
	UcPnE5aqMl7oR6plrW2NuD7Dy9Wa3+DSuUaG0dPE=
Received: by mx.zohomail.com with SMTPS id 1756318036312813.3265747381319;
	Wed, 27 Aug 2025 11:07:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] rust: regulator: use `to_result` for error handling
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250821090720.23939-1-work@onurozkan.dev>
Date: Wed, 27 Aug 2025 15:06:59 -0300
Cc: rust-for-linux@vger.kernel.org,
 lgirdwood@gmail.com,
 broonie@kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <707352A3-B026-4A8A-9D8E-5E0E7BDA2F19@collabora.com>
References: <20250821090720.23939-1-work@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 21 Aug 2025, at 06:07, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Simplifies error handling by replacing the manual check
> of the return value with the `to_result` helper.
>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
> rust/kernel/regulator.rs | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
> index 65f3a125348f..73ad4ad4747d 100644
> --- a/rust/kernel/regulator.rs
> +++ b/rust/kernel/regulator.rs
> @@ -267,11 +267,8 @@ pub fn set_voltage(&self, min_voltage: Voltage, =
max_voltage: Voltage) -> Result
>     pub fn get_voltage(&self) -> Result<Voltage> {
>         // SAFETY: Safe as per the type invariants of `Regulator`.
>         let voltage =3D unsafe { =
bindings::regulator_get_voltage(self.inner.as_ptr()) };
> -        if voltage < 0 {
> -            Err(kernel::error::Error::from_errno(voltage))
> -        } else {
> -            Ok(Voltage::from_microvolts(voltage))
> -        }
> +
> +        to_result(voltage).map(|()| =
Voltage::from_microvolts(voltage))
>     }
>=20
>     fn get_internal(dev: &Device, name: &CStr) -> Result<Regulator<T>> =
{
> =E2=80=94
> 2.50.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

