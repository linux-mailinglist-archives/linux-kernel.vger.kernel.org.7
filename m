Return-Path: <linux-kernel+bounces-754601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3D7B199F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBC53B56A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 01:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15631F4C98;
	Mon,  4 Aug 2025 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="IoCV9S6H"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E6381AF;
	Mon,  4 Aug 2025 01:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754271524; cv=none; b=WvUVfgViHVzPyYXkfdXwpkcT8IRoq8iOyB+oKjRiBW/FTJpxiqvbknd7HWl9fxD+Q5vB6PM5PgoATy12CUkTlf16Pj1rJSw/FTKtK828zkvWrlThdpc9YwSAULGwKiJ3MhaP6wikdxIs495UHw2rZAj13/F5s9UlMaiLX1lCRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754271524; c=relaxed/simple;
	bh=K0fmX2jpwV/gvmwq7SFAn/6INWSi5gMMueD8SBA981g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XYI7Tkb7kwyHjCrWUfIviiriX50nY56pdVmN7kcLwhrJyI3aRqiTlBixBrMB9BCiH0LzLCTSuMhVVMmS6PXPV6PS6z8IEmdQ44+yY/rleSOUUf6Y5Io8qaa8n0rm4NTklVx3pWKA/4Ay/aWftKlEb814Kyah+9wQBFL2ZKf3mrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=IoCV9S6H; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754271513;
	bh=K0fmX2jpwV/gvmwq7SFAn/6INWSi5gMMueD8SBA981g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IoCV9S6HbSiiB7Te0cgkRtVTIjvsS7DCtdWqbWirzzDtD9Iic3sT/pwyTHnauvshR
	 Bijw02uFdbBL9sDjji/iyVbfexp5n1r9EzLdfYwN3ofVi5zeXNknYPBXPxUKoYsMcQ
	 rehrpPgqkK3P63R0kOGrYecXI93nHTA0y0RY0MP/4eUeG98CPuaB+KsJeOm6oOaYgg
	 lE3Lg0bTnSLPnRFmmE+GCzf4y24t0nX9/FkOd9rQQIYkkBmFrgbuHXcTiENtxamUUZ
	 NJgv3eqNxqKR6SkTgh0VBdSFtMD/TCJlUSeLqk4tuHwl2QpDU5sPdOqcHq+x2mEbeG
	 gpi5U6yV2zbxQ==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CD4BD67B49;
	Mon,  4 Aug 2025 09:38:31 +0800 (AWST)
Message-ID: <1afcfa0244bb2ad184fac49145fe6856b257c5af.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/6] ASpeed FSI DT clean-ups
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Eddie
	James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org
Date: Mon, 04 Aug 2025 11:08:30 +0930
In-Reply-To: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rob,

On Thu, 2025-07-31 at 17:12 -0500, Rob Herring (Arm) wrote:
> There's a whole bunch of FSI related DT warnings on ASpeed platforms.
> This series fixes most of them except some related to SBEFIFO.
>=20
> The remaining SBEFIFO warnings are from some deprecated properties noted=
=20
> with 'remove when userspace is fixed'. Not sure if they can be removed=
=20
> now or soon. If not, perhaps the deprecated properties need to be=20
> properly documented.
>=20
> All the patches here are independent, so DTS changes can go via ASpeed=
=20
> tree and FSI bindings via FSI tree (or ack if you want me to take the
> bindings instead).
>=20
> Rob
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Rob Herring (Arm) (6):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: Drop "no-gpio-delays"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: Drop "fsi-master" compat=
ibles
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: Add missing "ibm,spi-fsi=
" compatibles

Thanks for this. I've applied patches 1-3 to the BMC tree. I'll leave
the binding changes for you to take as indicated by Eddie in his
response on patch 1.

Andrew

