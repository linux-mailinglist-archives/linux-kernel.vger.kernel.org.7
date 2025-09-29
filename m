Return-Path: <linux-kernel+bounces-836802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C3DBAA985
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63837189CDA9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA4A23D2A1;
	Mon, 29 Sep 2025 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAraSubB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8492BB17;
	Mon, 29 Sep 2025 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759177564; cv=none; b=j3zcx5CEPdXnDcYLJqbN/WYpNykkuH0pLqkSDLkdYAlJ/dGX1bMpRI2gWqoWrSki13c9eEijK6tVBS8IdvtTsnsryTprXEB9DI0fI2MdSuiKfSzybxh7g/hZ/5bYFkh59vQMYTxYL9q6Y1kdtHJBhbdE47srUSxT9b4WzH94nck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759177564; c=relaxed/simple;
	bh=g3SiTYjVTxCd0bvy26AS//Wa/hjyLJSQCblqZEbFsN8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=JUpD8Z1iOcv4JwwYQiC2xq8YF3e6gIv1cmT7coQMNiXvXlyM9eKeEY4ABr+U62F9/PCIjQomRQ9bAz7NHBVTAK/MmzPWe/OdEv6eOfnyjPsS+cfi2fLJ2et4Pm0DMlVYhznvAv54MSWwLvscWH/tkxQTimZU04onlPaoW25V2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAraSubB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11619C4CEF4;
	Mon, 29 Sep 2025 20:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759177564;
	bh=g3SiTYjVTxCd0bvy26AS//Wa/hjyLJSQCblqZEbFsN8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=qAraSubBaP3G53iNyUq2zgaBdRPkblRFx37CeccjQlPbxLoWUf3X7Ge3LGaoKkqVc
	 aFtw7jFkNg8mTsfRRol8c9o8Vq+jQpPl8hzCM21g2r0QjY7AOvb8LPuX2x46bzF5DV
	 7GFz8Fq5byzL3g7CHVgJhOaYeXBaCkBJiwjc495jCx7HNoMvXFnDtinXBJZftZ31tx
	 Lup7AYuzTo6qECaTwqgVDiBu53M2ZHBbOIJ2HDEepfxjt6Z/uQX/yuhleiBNhlHcYR
	 MCodxsexUBnSMLY1zpyRsPMELKHEdksPf7I9sjaicOYYAgBedPXsnJumDpd9+1g/2J
	 98foxi5GJNaTg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Sep 2025 22:25:57 +0200
Message-Id: <DD5KED38XJS7.3DIP0BEWMD1XV@kernel.org>
Subject: Re: [PATCH v4 1/6] nova-core: bitfield: Move bitfield-specific code
 from register! into new macro
Cc: "Greg KH" <gregkh@linuxfoundation.org>, "Benno Lossin"
 <lossin@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <acourbot@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>, "Yury
 Norov" <yury.norov@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, <nouveau@lists.freedesktop.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250920182232.2095101-1-joelagnelf@nvidia.com>
 <20250920182232.2095101-2-joelagnelf@nvidia.com>
 <2025092157-pauper-snap-aad1@gregkh>
 <DCYHCLM67KRZ.366VS9PDKLYKY@kernel.org>
 <2025092125-urban-muppet-1c2f@gregkh> <20250923222434.GA2479829@joelbox2>
 <2025092425-sinuous-playoff-3618@gregkh>
 <76f87707-17d8-4cb0-8c81-e67ebf62984a@nvidia.com>
In-Reply-To: <76f87707-17d8-4cb0-8c81-e67ebf62984a@nvidia.com>

On Mon Sep 29, 2025 at 9:26 PM CEST, Joel Fernandes wrote:
> On 9/24/2025 12:40 PM, Greg KH wrote:
>> On Tue, Sep 23, 2025 at 06:24:34PM -0400, Joel Fernandes wrote:
> [..]
>>=20
>>> For the separate issue of enforcing endianness with respect to (across)
>>> multiple fields, I agree with you that if the user's backend (the consu=
mer of
>>> the data) is not doing such conversion, say via regmap, then that becom=
es a
>>> problem. But that problem is orthogonal/different and cannot be solved =
here. =20
>>=20
>> But that is exactly what these macros are being defined here for, so to
>> ignore that is going to cause problems :)
>>=20
>
> If needed, happy to add endianness support as needed by providing additio=
nal
> options to the macro. Based on this thread, it sounds like we want see if=
 that
> is really needed here or can be solved elsewhere (?). The mental model I =
kind of
> have is this macro should only be dealing with CPU native endianness, muc=
h like
> bitfields in C deal with CPU endianness. Hmm.

At least for register!() we don't need anything else than CPU endianness. I=
n
fact, as described in [1], any representation is fine as long as it is
consistent.

[1] https://lore.kernel.org/all/DD0ZTZM8S84H.1YDWSY7DF14LM@kernel.org/

