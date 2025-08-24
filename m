Return-Path: <linux-kernel+bounces-783573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCEEB32F24
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3545D202D58
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFD1274FD0;
	Sun, 24 Aug 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="a4kTDiri"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430B184E;
	Sun, 24 Aug 2025 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756033033; cv=none; b=JaOO97tIVXoJvC/HwF4JIDhiPnv8kRE9t8tkxy2KWgn6u3AgY3tYcM4temPibYIN1KSDBeuV+CW6MbRQwNy5VieK+qp+RI91F/Qe01lrfADDYWyKm4B6MPWAxV+6ZadKFRsN08tGQKBbdY3mecWyE51Zfxx/Y8m9UWSS34t7RqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756033033; c=relaxed/simple;
	bh=P0mt7TzoLG/4PyNUbPLOpLehUkcO9dGyQzCVQLh/Vr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVayZwnuagWQE3wKMboclz4cQJFSOPQgGWOUKGKhUM2Ymm2MnbpoX1dmBdPQKBe98QUE/q610Seoe5fe6NgWRgJ52kBctsl+W0I+L4WezDVvVsCUF8/reExIb2tvTSwtq5v7aFU7HZQ5bbSQyuY67wRsYeTQ0RCkREqKHF6fi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=a4kTDiri; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=SvhkTLwnsyU6LHTKXKMHL524UpqTw6jFMLYcBdGhtHU=; b=a4kTDiris9yS3x12O7/dXFjzBQ
	mNtLHCnN4WqJdpm+eNdWPbTyLsNyWsRq5b8cslO5gYhxfU0jQtFdSC6WqV1Cyw4ZPbqe+LKXAE+5K
	r7HRh4OjrJ4n7PJM6X0GEvHjddsnMTGyqC7LPYN48Xzmr7j0gBDchFpMNscsM8ghogIMeIWIELLc5
	/IDma2X/PeG/q/HJ5V7J/nL/2zHIxXGyumfeeQVjwWgpHIX2qd6KIP1eRc6ZNh0xzRDbpZpx5u9Jg
	1c8Ffu4QhIKVDJSwpnh0TgGvs/Vv7lGJfyC56s9sNpPs+deAnQM/w8VEd2BTuaQhVJayOm0yQf5pJ
	b/GPTOZQ==;
Received: from [62.245.128.201] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uq8PJ-0005c9-Ne; Sun, 24 Aug 2025 12:57:05 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hsun Lai <i@chainsx.cn>,
 Alex Bee <knaerzche@gmail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable+noautosel@kernel.org
Subject:
 Re: (subset) [PATCH 1/2] arm64: dts: rockchip: Fix wifi interrupts flag on
 Sakura Pi RK3308B
Date: Sun, 24 Aug 2025 12:57:05 +0200
Message-ID: <16812972.uLZWGnKmhe@phil>
In-Reply-To: <175603280229.3445205.18144135063810636432.b4-ty@sntech.de>
References:
 <20250818090445.28112-3-krzysztof.kozlowski@linaro.org>
 <175603280229.3445205.18144135063810636432.b4-ty@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Sonntag, 24. August 2025, 12:54:43 Mitteleurop=C3=A4ische Sommerzeit sch=
rieb Heiko Stuebner:
>=20
> On Mon, 18 Aug 2025 11:04:46 +0200, Krzysztof Kozlowski wrote:
> > GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> > These are simple defines so they could be used in DTS but they will not
> > have the same meaning: GPIO_ACTIVE_HIGH =3D 0 =3D IRQ_TYPE_NONE.
> >=20
> > Correct the interrupt flags, assuming the author of the code wanted same
> > logical behavior behind the name "ACTIVE_xxx", this is:
> >   ACTIVE_HIGH  =3D> IRQ_TYPE_LEVEL_HIGH
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [2/2] arm64: dts: rockchip: Fix Bluetooth interrupts flag on Neardi LBA33=
68
>       commit: c9f986a54d4031a9b9dff1eb616b0796aa28c730

Waiting a bit more for patch1, to possibly get some testing.


Heiko




