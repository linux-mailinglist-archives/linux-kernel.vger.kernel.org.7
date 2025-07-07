Return-Path: <linux-kernel+bounces-720207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3387AFB88D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45934A0DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DFB21A928;
	Mon,  7 Jul 2025 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Gu06NPAx"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20EA155A25;
	Mon,  7 Jul 2025 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905466; cv=pass; b=dwJUCRuHAMMGsD6VXSWWpLNU9QSwugkIKoAA5icIw5C+JDixYfFWxPz62VzXyePuloZNn0vlmfOr3MKIu3GvrZhd6mxtugb62lFFrRsHfCiGe78Gxyq22Ed18MSXjYkFfreAxEueiuHRfyvvwugVlvVOk5ZLy0WxuOXnmJU4J48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905466; c=relaxed/simple;
	bh=BjDjwBd9r87lX9F1B42siADD0WR8eh2RD9Fip1EayOY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pg5pfYamOuh7w3robuCrfrRxIfnH2FyToed3L1vYr7St9cB4OdoVRgDc123Vg8Qf+5tbtpo0nmozHltxXpxLHjijYPh2QiWH3unIN+Aib4N2Xdep2JzG0Q3cdI/UttzDECm/PNUQTOpLdv48C7D5G2lgZ03N8SjiHqsn2xGyEcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Gu06NPAx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751905444; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ESW5fM/E3YSZm9GwUDQnVt/ZWVKee4KR0Xg305JjNvnTvtDBR5pynQHo5S5AwzuZeHDjfG0lfLZ2Tz3VpMXOh6Nwyxn3KsdVRB75L7krPJoX1nXD/XE6ttb1VHgicpbmXrzNRm2PGvItkW8gSB7gdmHi8Uxc9E+6eC5AtjVaGMM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751905444; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X3tGjOXurF5qSD0B65SMotAcOZxqr/DqkLlMxW0/MGY=; 
	b=n2AfDodcXJEkh70b/wMXrXHwg3K2gP5ff5eCRpGthquRsD8GqfL3h8rs/Q5eGIsSBd1xgJXWIWYGBz5QufSjk8GoDLm7FPAzX7CG/XBb4Dc2aBp3zU/oBQCCFhXWCECRhZKZYrtp5DkJcKsJXgh+NF/XjIAhngAX4AyZdWf0gsg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751905444;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=X3tGjOXurF5qSD0B65SMotAcOZxqr/DqkLlMxW0/MGY=;
	b=Gu06NPAx2cFicgEByHHO+HmouGhwi4X4OqAmxY8i02zti8UBEr4qEKmWyFS8SR7/
	VAAiA8cKbpG5+KN6x94QKLxEpTOQUxFDceElJ5OANmYakiHDwBml9kn00Ywn57pxJDa
	hIyx1967EqE+/UDOHrcZebuNh9DFZ42WCBVAVcA4=
Received: by mx.zohomail.com with SMTPS id 1751905441570663.5596448002699;
	Mon, 7 Jul 2025 09:24:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v7 1/2] rust: regulator: add a bare minimum regulator
 abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <202507060837.ziqhqXVk-lkp@intel.com>
Date: Mon, 7 Jul 2025 13:23:45 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB256E11-2E6F-4307-A19C-9A64286A1F33@collabora.com>
References: <20250704-topics-tyr-regulator-v7-1-77bfca2e22dc@collabora.com>
 <202507060837.ziqhqXVk-lkp@intel.com>
To: kernel test robot <lkp@intel.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External


[=E2=80=A6]

> All errors (new ones prefixed by >>):
>=20
>>> error[E0425]: cannot find function `regulator_set_voltage` in crate =
`bindings`
>   --> rust/kernel/regulator.rs:258:23
>   |
>   258 |             =
bindings::regulator_set_voltage(self.inner.as_ptr(), min_uv.0, max_uv.0)
>   |                       ^^^^^^^^^^^^^^^^^^^^^ not found in =
`bindings`
> --
>>> error[E0425]: cannot find function `regulator_get_voltage` in crate =
`bindings`
>   --> rust/kernel/regulator.rs:265:42
>   |
>   265 |         let voltage =3D unsafe { =
bindings::regulator_get_voltage(self.inner.as_ptr()) };
>   |                                          ^^^^^^^^^^^^^^^^^^^^^ not =
found in `bindings`
> --
>>> error[E0425]: cannot find function `regulator_get` in crate =
`bindings`
>   --> rust/kernel/regulator.rs:276:53
>   |
>   276 |         let inner =3D from_err_ptr(unsafe { =
bindings::regulator_get(dev.as_raw(), name.as_ptr()) })?;
>   |                                                     ^^^^^^^^^^^^^ =
not found in `bindings`
> --
>>> error[E0425]: cannot find function `regulator_enable` in crate =
`bindings`
>   --> rust/kernel/regulator.rs:290:38
>   |
>   290 |         to_result(unsafe { =
bindings::regulator_enable(self.inner.as_ptr()) })
>   |                                      ^^^^^^^^^^^^^^^^ not found in =
`bindings`
> --
>>> error[E0425]: cannot find function `regulator_disable` in crate =
`bindings`
>   --> rust/kernel/regulator.rs:295:38
>   |
>   295 |         to_result(unsafe { =
bindings::regulator_disable(self.inner.as_ptr()) })
>   |                                      ^^^^^^^^^^^^^^^^^ not found =
in `bindings`
> --
>>> error[E0425]: cannot find function `regulator_is_enabled` in crate =
`bindings`
>   --> rust/kernel/regulator.rs:379:28
>   |
>   379 |         unsafe { =
bindings::regulator_is_enabled(self.inner.as_ptr()) !=3D 0 }
>   |                            ^^^^^^^^^^^^^^^^^^^^ not found in =
`bindings`
> --
>>> error[E0425]: cannot find function `regulator_disable` in crate =
`bindings`
>   --> rust/kernel/regulator.rs:389:32
>   |
>   389 |             unsafe { =
bindings::regulator_disable(self.inner.as_ptr()) };
>   |                                ^^^^^^^^^^^^^^^^^ not found in =
`bindings`
> --
>>> error[E0425]: cannot find function `regulator_put` in crate =
`bindings`
>   --> rust/kernel/regulator.rs:393:28
>   |
>   393 |         unsafe { bindings::regulator_put(self.inner.as_ptr()) =
};
>   |                            ^^^^^^^^^^^^^ not found in `bindings`
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20

I think these need to be in rust/helpers if CONFIG_REGULATOR is not set,
because the stubs are inline functions. I will try this on the next =
iteration.




