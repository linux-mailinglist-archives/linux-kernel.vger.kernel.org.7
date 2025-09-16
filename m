Return-Path: <linux-kernel+bounces-818277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2DBB58F40
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F9618831EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AACB2E6CA2;
	Tue, 16 Sep 2025 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="nWPVUPfN"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986033A1DB;
	Tue, 16 Sep 2025 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008088; cv=none; b=Z3kytwcDZ1Djj3sjwNYOJMdnCAU8oz4aZrA3tPGroJI/DHyuNNtN6ZoH1jgdLFB7N07R7Rexk6dzqVKC247W2CDpASV13udz+7fVB/M4JWpe7IbO2mZhhNCOv+7VeWIHWbC0oj2p2vgTXIf5duVc/rZ7RvGLBNHzb7ySJUpPTl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008088; c=relaxed/simple;
	bh=2tvWpy9//f4u6Qkza2AV+2NNgm7HG+OKTo/m7egh1Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUZnNR2f+ef6E2XEMF5QhtbgbEIeWF0UxM8EKKOatPHGKOGjLnOH7j2gpsk8LwnmKvEWukeJzlqLpabSajraTHqiZDY7y+5zetstkTKQ4B3oc4j8sQsiUATZwmXADVlwvzX5zxOwzfKOHB5692vRl9Sd/cgqaEMh/qXkxaydgQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=nWPVUPfN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=/d8NPHHoHLLLmfSMKxDnV22O73BappyZrrJ8bU33Oq4=; b=nWPVUPfN5V9OJZVJkYajiP2J7z
	n7rLQ8eY3R8jFRO4V8BbRorqcFQMSOjp3y0hBD+AvTBcS4x2NfEuIQ/j8o9E+mGiWhPMOXGDCBt6F
	vuPV42fW4SRZv+r1VTBNfZgFcPJkKbyJbK5mVqmay2y3o12STWu82wMw/5KNZLuhLYcRPq6ts2gDs
	OO8KT2QOU9lgVcisSBM6Tq4b/VV1WQUBWtzcWgTyribLGpUXFRi0v7bXv8brcjYSfG2pinDj2IfCA
	2uCV5clSNof+eLiy+B2GK0zuFSd0cQoMF8HPrfZIrPIaD6FnpZ/6sDFnWO/VbZbbeF8GhtiMMLMV6
	8Lf289rg==;
Received: from i53875bfd.versanet.de ([83.135.91.253] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uyQCw-00066R-7K; Tue, 16 Sep 2025 09:34:34 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: "Rob Herring (Arm)" <robh@kernel.org>, Kaison Deng <dkx@t-chip.com.cn>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>, Jimmy Hon <honyuenkwun@gmail.com>,
 linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jonas Karlman <jonas@kwiboo.se>, linux-rockchip@lists.infradead.org,
 Andrew Lunn <andrew@lunn.ch>, Dragan Simic <dsimic@manjaro.org>,
 Wayne Chou <zxf@t-chip.com.cn>, Kaison Deng <dkx@t-chip.com.cn>,
 FUKAUMI Naoki <naoki@radxa.com>, Conor Dooley <conor+dt@kernel.org>
Subject:
 Re: [PATCH v3 1/2] dt-bindings: arm: rockchip: Add Firefly ROC-RK3588-RT
Date: Tue, 16 Sep 2025 09:34:32 +0200
Message-ID: <3034003.o0KrE1Onz3@diego>
In-Reply-To:
 <EEABCC59F39E8FC5+04995f9826d047eeb5f4bada25c3dd93e50983b0.camel@t-chip.com.cn>
References:
 <cover.1757902513.git.dkx@t-chip.com.cn>
 <175794446144.2732898.9504412064423841025.robh@kernel.org>
 <EEABCC59F39E8FC5+04995f9826d047eeb5f4bada25c3dd93e50983b0.camel@t-chip.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Dienstag, 16. September 2025, 05:28:33 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Kaison Deng:
> On Mon, 2025-09-15 at 08:54 -0500, Rob Herring (Arm) wrote:
> > On Mon, 15 Sep 2025 10:22:04 +0800, Kaison Deng wrote:
> > > This documents Firefly ROC-RK3588-RT which is a SBC based on RK3588
> > > SoC.
> > >=20
> > > Link: https://en.t-firefly.com/product/industry/rocrk3588rt
> > >=20
> > > Signed-off-by: Kaison Deng <dkx@t-chip.com.cn>
> > > ---
> > >  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >=20
> >=20
> > Please add Acked-by/Reviewed-by tags when posting new versions.
> > However,
> > there's no need to repost patches *only* to add the tags. The
> > upstream
> > maintainer will do that for acks received on the version they apply.
> >=20
> > If a tag was not added on purpose, please state why and what changed.
> >=20
> > Missing tags:
> >=20
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> >=20
>=20
> Ok. Do I need to resend the next version for the missed tags?

nope, that is not necessary, I can pick up the one from v2.

Heiko



