Return-Path: <linux-kernel+bounces-783452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D53B32DCB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5FE4814E2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 06:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCFC24291C;
	Sun, 24 Aug 2025 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="B7OGi2Fb"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9B14A4CC;
	Sun, 24 Aug 2025 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756017699; cv=none; b=Z3c78TdjPidJO3K5zulCfIEAjvRqas/USB3xvP20/P/uFv0nWzNI8PuT6Heea9DzoN1S7TdFiWUitRSSeWyEAHIXTnNB0aBNDW3Mt7OIoKPvwWQe8WJ7zl3FZTJwDUjS1xaRvADVMk33RS1Uz+mVZQvZdCiEVVJRkDyisj5pL1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756017699; c=relaxed/simple;
	bh=M7yul9i85Mw+31aLD3gbg1jKDEIcn1etxQNbD3o0Dwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acBe1c8w0q5hN7gnnawHXBh7YgY8FQUjptgo5sDWOa9tTsGdIzDbxfP6EqlzoBmbJeZuTCuBd4fkrGA0mT5UyCG1st5FlCbkNSQBMctVuKfRw2vywphUJ07iHjIl/dcOGs9dZ8Z8zIOPuDmlmjNQhyyBDRURCGFlBzI+SQZrulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=B7OGi2Fb; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=VZCaMapTETng5pIytVlEMZBY5TruZH+760du3o1zOpA=; b=B7OGi2FbZnIosyM5CTBNRrnNKH
	eKExY8+NIQyIVYn8PaHlqmcoXZhRWWjD1f9czvj4Q/fTXfS7RrPvP5WZGz7Eereqnw2FDXvFldL4G
	JvcHyBM72S2YdAcbpKYRGQDj3H7I/FsqqJZnyZI+Q0XvSjsInDm7iWgG6yKHOqhRYD5oy7SSXJaHj
	OaJpdhCCYGBCFo+/zd1fTak8eHrqgauBfoWMj5zTegBFvOqFn3ynxjeXzPkkA/hhT/g5xFaVfTtAC
	ow479OHIuOwfeOJ0ri3/20piHCMKpahgSRUJ2eYSn/Lrawb9LPGIIi2eCAIOINGq3qyWbiOoKv5GK
	EWTT/clQ==;
Received: from [212.111.254.164] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq4Px-0007JE-D7; Sun, 24 Aug 2025 08:41:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH v2 2/3] arm64: dts: rockchip: remove vcc_3v3_pmu regulator for
 Radxa E52C
Date: Sun, 24 Aug 2025 08:41:28 +0200
Message-ID: <7988840.GXAFRqVoOG@phil>
In-Reply-To: <0318E801E3D6726D+65c4f189-4e22-4a9b-83d7-cbb0816df373@radxa.com>
References:
 <BCD8E43E564BC334+1e45d36f-edc7-4c3c-90c9-7b0f2a52360f@radxa.com>
 <20250819134028.634780-1-amadeus@jmu.edu.cn>
 <0318E801E3D6726D+65c4f189-4e22-4a9b-83d7-cbb0816df373@radxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 20. August 2025, 04:10:24 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb FUKAUMI Naoki:
> Hi Chukun,
>=20
> On 8/19/25 22:40, Chukun Pan wrote:
> > Hi,
> >=20
> >> How about the following instead?
> >>
> >> @@ -538,7 +538,7 @@ regulator-state-mem {
> >> 				};
> >> 			};
> >>
> >> -			vcc_3v3_s3: dcdc-reg8 {
> >> +			vcc_3v3_pmu: vcc_3v3_s3: dcdc-reg8 {
> >> 				regulator-name =3D "vcc_3v3_s3";
> >> 				regulator-always-on;
> >> 				regulator-boot-on;
> >=20
> > On rk356x, the Flash chip is usually powered by VCCIO_FLASH, which
> > is also connected through a 0 ohm resistor, so I didn't write like
> > this. e.g. https://github.com/torvalds/linux/commit/a706a593cb19
>=20
> I think it should match the schematic, i.e. it should be "vcc-supply =3D=
=20
> <&vccio_flash>;".

I very much agree :-) .

Having at least the phandle match the schematics nameing is very helpful
when someone tries to look something up between those two.


Heiko



