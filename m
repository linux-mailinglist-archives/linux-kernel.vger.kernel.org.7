Return-Path: <linux-kernel+bounces-793470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 911DBB3D3EF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94777A1A46
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2F319755B;
	Sun, 31 Aug 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="fWf9ipaq"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543774C81;
	Sun, 31 Aug 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756651723; cv=none; b=HH8nc2oXDScuFojSi+gMUH9qkPficDoE2ZiOfJnolwDpt+068wYB6R7dLP2eaJiZ6X0tWAiKEt9BeduIiQYvp7iizhBAwHOnP++f3i/7jottUiajy0ZWrB8+wFtu3zYPKFZ5zJ1oBrmPuY1SOVxx0rhS39gcoGEpi94wO39gIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756651723; c=relaxed/simple;
	bh=yjP8Q67gJ8paeMTc0Y4T9nY+2o85Zvxpki0vD4SYeOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8pQYwU4nWVxIrr3jWH9aBiux2Ydc1NrJ/TH4UmaF9DY6yiXURgxjM97A4btwRg4TVYAicB+cIoRZF5sM2Ye0rMAYbD5j/2FqNwlbjr936y6sK9abfk29qKPaWCXZLOmK0FnZouCdwOuqKZpNDVsMQpa1Bh+p0iL761cWKY3Txg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=fWf9ipaq; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1756651720;
	bh=yjP8Q67gJ8paeMTc0Y4T9nY+2o85Zvxpki0vD4SYeOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fWf9ipaq00vZUxq/dTf2JtUZL10xEi1Y+KpE+y1VHQyODXE2Y+fzvb+ML9Xi2Bjrp
	 l1E48TJYZc+tfp7pyL8pL/x4ict/9uLUT8n73SHugBA5II3sSYR2nLuu82UoeE2REs
	 iPpDyjX++d+r7iJLrm+Y1DJsTxDIEgtox5MuHsvggotH9CKdx6qKgnTHN5TuMe6x7A
	 d7x2CPSqSoazj+jJIjbR+HmO4yoP06KONwTeg1MMBovuwqxfIPfkmOCqZcqj5RY2zu
	 vN7jGth3kexhm5aNok/9gkAohriJBghqo+Ll3IoB2iWc6Hyj3KAby5dE+2bkCR6WjE
	 82/why8OE8naQ==
Received: from WahpenayoPeak.tahoma.link (unknown [IPv6:2600:4040:50be:5a04:7b87:89ea:8410:bae3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 21D4427E468;
	Sun, 31 Aug 2025 14:48:40 +0000 (UTC)
Date: Sun, 31 Aug 2025 10:48:39 -0400
From: Erik Beck <xunil@tahomasoft.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HINLINK H68K
Message-ID: <20250831104839.7b71f2fc.xunil@tahomasoft.com>
In-Reply-To: <5285B176-5178-4F6F-8FB6-B898AC0EC939@tahomasoft.com>
References: <021c2e76-cbde-4a2e-a165-a61223cdff93@lunn.ch>
	<5285B176-5178-4F6F-8FB6-B898AC0EC939@tahomasoft.com>
Organization: Tahoma Soft
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 30 Aug 2025 18:21:18 -0400
Erik Beck <xunil@tahomasoft.com> wrote:

> > On Aug 30, 2025, at 17:38, Andrew Lunn <andrew@lunn.ch> wrote:
> >=20
> > =EF=BB=BF =20
> >>  =20
> >>> +&gmac0 {
> >>> +    assigned-clocks =3D <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
> >>> +    assigned-clock-parents =3D <&cru SCLK_GMAC0_RGMII_SPEED>;
> >>> +    assigned-clock-rates =3D <0>, <125000000>;
> >>> +    clock_in_out =3D "output";
> >>> +    phy-handle =3D <&rgmii_phy0>;
> >>> +    phy-mode =3D "rgmii-id"; =20
> >>=20
> >> Please change phy-mode here to "rgmii". This change will yield an
> >> ethernet speed throughput change of a factor of 100+. =20
> >=20
> > Rockchip by default do bad things with RGMII delays.
> >=20
> >  tx_delay:
> >    description: Delay value for TXD timing.
> >    $ref: /schemas/types.yaml#/definitions/uint32
> >    minimum: 0
> >    maximum: 0x7F
> >    default: 0x30
> >=20
> >  rx_delay:
> >    description: Delay value for RXD timing.
> >    $ref: /schemas/types.yaml#/definitions/uint32
> >    minimum: 0
> >    maximum: 0x7F
> >    default: 0x10
> >=20
> > Try setting both of these to 0. And then use 'rgmii-id'.
> >=20
> >    Andrew =20
Setting both gmac0 and gmac1 to phy-mode=3Drgmii-id with tx/rx delay set to
<0x0> yields about a 7x improvement from ~6 Mbs (with phy-mode=3Drgmii-id a=
nd
tx/rx delay unset) to about 43 Mbps, which is still well below the ~950 Mbs
with phy-mode=3Drgmii and tx/rx delay unset.

Regards,

Erik

>=20
> Thank you!
> >=20
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip =20


