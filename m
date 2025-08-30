Return-Path: <linux-kernel+bounces-793177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 328C3B3CFD4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 00:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92215189DADD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 22:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D933275860;
	Sat, 30 Aug 2025 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="fCHcki9x"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9838242D8C;
	Sat, 30 Aug 2025 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756592491; cv=none; b=i5KVgcEcjEelNeFaTvSmzlyn71ALF1qTGBHAd6n51Y5WOBl7DI9CsLtcSI+0WsI7cBt+MoODXfC+/2atOFGIGaLt6doQ0gwxKwxx0F2ehNf5XzGQ7R12D+TJMoFKOB8MUcCuTNdmsC3d/A0eMQogDIKYAa9+gSQI2jUttBg889U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756592491; c=relaxed/simple;
	bh=PHHa9DYJXHmkMKGNgwfkJoajblJ2zg1bqfQoS17QsXk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=P9ATsZKlyPWSF5D2+wI3u1vJpuzw92ZetHNQWsXuEOMeP6U5qbgL0+omOuXQq1Qnkkok9Wrb1GCKaLZJRlB/mWQbjDAEfPffsZkpXnwFiPYMzaf91mVzmLqQhEaFbCr47sMCimEpuCAAEmZGKSixt+fRTYlgWMFsTOwaoEBG86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=fCHcki9x; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1756592489;
	bh=PHHa9DYJXHmkMKGNgwfkJoajblJ2zg1bqfQoS17QsXk=;
	h=From:Subject:Date:References:Cc:In-Reply-To:To:From;
	b=fCHcki9xdG3Dvrq2syz9niM89EurPYsCQfzVB9C4tRpXoHcsQt7GtBKdF9lX2/662
	 D1BJ6upsinoIgPJkDDD1+xQsO4XubDIZilP1wF8bdyRb1RYfT2LLRtOHQYpb5BAdy9
	 by2xmgQcsAgfrSTiT4824AYbdhtk01dB5w8xpRaABkmtZP+6q04CrLpV0IwcdJSGEJ
	 LnBE3b9peOpeN9+DlFfyUpGCSf4HQN/90EykaqxtN8izOmJ9De6pStlw3dGkqOCZW2
	 CfEOjV2AM8mv11At0Ij0pHYzutIbpICOQKmUnomTyL6kv3e2WAQtJJGUV3D/FIRHKi
	 0mJsbcNapKzzg==
Received: from smtpclient.apple (unknown [IPv6:2600:1000:b0ec:e674:574:f959:86e5:7770])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id ED14527E468;
	Sat, 30 Aug 2025 22:21:28 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Erik Beck <xunil@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HINLINK H68K
Date: Sat, 30 Aug 2025 18:21:18 -0400
Message-Id: <5285B176-5178-4F6F-8FB6-B898AC0EC939@tahomasoft.com>
References: <021c2e76-cbde-4a2e-a165-a61223cdff93@lunn.ch>
Cc: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <021c2e76-cbde-4a2e-a165-a61223cdff93@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: iPhone Mail (22G100)



> On Aug 30, 2025, at 17:38, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> =EF=BB=BF
>>=20
>>> +&gmac0 {
>>> +    assigned-clocks =3D <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
>>> +    assigned-clock-parents =3D <&cru SCLK_GMAC0_RGMII_SPEED>;
>>> +    assigned-clock-rates =3D <0>, <125000000>;
>>> +    clock_in_out =3D "output";
>>> +    phy-handle =3D <&rgmii_phy0>;
>>> +    phy-mode =3D "rgmii-id";
>>=20
>> Please change phy-mode here to "rgmii". This change will yield an etherne=
t
>> speed throughput change of a factor of 100+.
>=20
> Rockchip by default do bad things with RGMII delays.
>=20
>  tx_delay:
>    description: Delay value for TXD timing.
>    $ref: /schemas/types.yaml#/definitions/uint32
>    minimum: 0
>    maximum: 0x7F
>    default: 0x30
>=20
>  rx_delay:
>    description: Delay value for RXD timing.
>    $ref: /schemas/types.yaml#/definitions/uint32
>    minimum: 0
>    maximum: 0x7F
>    default: 0x10
>=20
> Try setting both of these to 0. And then use 'rgmii-id'.
>=20
>    Andrew

Thank you!
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

