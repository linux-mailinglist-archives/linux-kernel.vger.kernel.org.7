Return-Path: <linux-kernel+bounces-870397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFB8C0A9F9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9492418850B4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670E2DC76C;
	Sun, 26 Oct 2025 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jYEK2j8m"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8FA26CE3C
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488742; cv=none; b=Q1CtD5hJPY6CaqvBn5c9eDA7aqGcCjEinBuga/JfzKlDCTRfwEltuRbhfx2NmlyytA7mBsOrcYUkAPyz4wxaFjJZVAxmfFuKMplIEsRnSoY6Feq6TdRdvnupyS3LGcUyCMEM0WjhUHxskywatSfvP6JRZSSB50GdcDKoHFjZa0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488742; c=relaxed/simple;
	bh=fZzdDNqOPU2LD5Cr3Y4I/rcmMm7L/R5MuQNpz1al0Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMxxIQbfR0A5QGyKw1tVmepbkQzycKgesW7CLCVcLmQzVCEH1der81xUFknkFzRlOk+zMFXYHSMW8bvbpMummJa4AVVc2be+yATvUafCa4UMrp9asUrXGYiD5+9LPcAQT69jGOqxehyO7rWTohfHAxwdv5tDfW2FVffsPs0A/T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=jYEK2j8m; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=fZzd
	DNqOPU2LD5Cr3Y4I/rcmMm7L/R5MuQNpz1al0Kw=; b=jYEK2j8mqSUJ/dqw1Nrm
	9egsBStRq9HjiEGMeHi1JpHIeFq7bYC8GR2rVMLsO0dyiUxaPPkI8YmZO8Z/QUsi
	eANyS6QQA4aPl3Qflm5Qose/6/u4GXJW/PpW1XGjhIm6VJ58NDeo0OiC3/Dvb6TN
	VQsEnVRVpTWhO9Nknr8V3aQh9b9bln3uOk5YGmVHrlbYw7BlNRt3OH4ChL9zVPdX
	GWaOF1n1hY9sOGFFFNHVfkeH9WWj5ftu1r5HTN5TIeW5SvR8a2H3J6PTKJ8pP8KB
	l+PXg+iJHpqf81Ys/+CPF58d+kQNdQns7ucB/SdFdcuGJT5aHjeEdY6fhWDdc5q+
	Aw==
Received: (qmail 3272668 invoked from network); 26 Oct 2025 15:25:29 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Oct 2025 15:25:29 +0100
X-UD-Smtp-Session: l3s3148p1@0QLzjRBC7JUujntU
Date: Sun, 26 Oct 2025 15:25:28 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Igor Korotin <igor.korotin.linux@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>, Tamir Duberstein <tamird@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH v6 0/3] rust: i2c: Add basic I2C driver abstractions
Message-ID: <aP4vWJ6ec3ozpeYz@ninjato>
References: <20251005102226.41876-1-igor.korotin.linux@gmail.com>
 <4d6d737e-6e9d-4d33-8402-940947170872@gmail.com>
 <8b0718a3-bf3f-4037-be2e-540ba1879405@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MF2WjlpwlWdLLZVz"
Content-Disposition: inline
In-Reply-To: <8b0718a3-bf3f-4037-be2e-540ba1879405@kernel.org>


--MF2WjlpwlWdLLZVz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Igor, Wolfram: If you rather want to avoid the conflict, I can also take this
> initial series through the driver-core tree.

This is totally fine with me. You can add for this series:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you!


--MF2WjlpwlWdLLZVz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmj+L1QACgkQFA3kzBSg
KbaMUA/7B9Wn0ouBkAH+Tijm+iA/nBTPpQ2K9Jcxe0UABZ103nzQq4pamnXJbs5F
GKhMD1D5X/OLRHEWDku8fPdNrZOaOWeN7pcyJpywCzWNFcWxvtL7fN4Pmq6STpiv
6NYmkAe1CDbqqTXkPzhKGfSVvGjfVNI9uXwLEHbmf1AO2fIBIWHiCe+XDqTR2HSV
O6WuJNynZwtmznRyRUgN2UCy0Dleu6C91Ixsnw/q6cotiF2oF7KNzr6Kb9aoNx/b
mYIYjctbY5PpYxqZd+O09Tg228r7dmwp+brgyJyOXQu96iQxw8zOy+Tr6TOP/1ZY
dQQ59daUFLNex/rR2xGkoxt0PQ6n65MqnmaV+f0Fkhw0HvL48qT2CbtRdUp/YS2o
u2C6gAFuOTEHIptQGMOGvVvOLPRiVjZbkvtDs7xfn5IE0YaOXIUy/KYdtxwQi0yp
7bLEfFsriFxR9fIjQpFSbADd8CA1Z9Bng+Oji9jI9TxDL+Xqt368zvDUyNX8bYud
hSn1WjmwhwcRcls2k2vZbXGcZ3vI5MD8V65jFwa99JP6z9Q8fG2YXKOYomzg8Csz
U1tkUoIXwtpbqbKfbDAMVdacNepRLlZV6mSnnc4OjjH980snFw6z4Tl0uS3wMUa/
nsPHfE2SeloN0Hmg4fE9vHZUbHYcgEZZmrlf7QYQ6/Qmo0AQEIQ=
=jFmX
-----END PGP SIGNATURE-----

--MF2WjlpwlWdLLZVz--

