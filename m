Return-Path: <linux-kernel+bounces-781941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49102B318F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD6C16512E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F5A2FC033;
	Fri, 22 Aug 2025 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ReiU5eCr"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E3A33DF;
	Fri, 22 Aug 2025 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868116; cv=none; b=jQ+n2Rvxu0sDEXzV7GN4VuGcrEIz9/N/djirWo9CusPYQ0T4ZKO8OgkdlMGBacPMCYQd2KG5ga1WmqaLjcWRzHty+GNvzPl99ttAdUHlfz9qZTMiowcIgskxX6oIB8VcnYsJuQdf1+HdjJTMMQoAavt+BVHHzoZGdCFS1Cl5nFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868116; c=relaxed/simple;
	bh=ysoPoAFRDVKq0f4D11s0wRv5ifl1MVlLMdOkK0JD6nY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XFHhjo92hSXOYNmo/Fa/hfoTvXHH2xAtugNbf8kqXnfmekoncjnNI7ho/3dPd+FBPNWn0zeCk9rHifZeEs7SawXi2zEnFIm+lOgjM3qoJisdQRi3UFJoquRK3KAGfd8kqXWnrmx1nLHhjDqTkZPipRRpQNIOEcJdpEt05Grmkk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ReiU5eCr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AAAA2C6B3A2;
	Fri, 22 Aug 2025 13:08:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 59FFF604AD;
	Fri, 22 Aug 2025 13:08:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FDCD1C22D316;
	Fri, 22 Aug 2025 15:08:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755868110; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TqNbHZRcfPtenRRmClNSaYPPGu0G5xAMA+3q9ZY42u4=;
	b=ReiU5eCrKGWkEjja6xxkaTwPoRvb7IVY0ojhE7MBOmIAMAe0jRB8jF7uadLQ4vVaBIqu3R
	J5eeeEDBa0ZJfrPrQZ3TbzN3xPInorEsLyz1M5N9w5lD2wr3pxtQieJTwjEa9lGKfwVuPp
	DQcf73EDIYm8OpWrTRmS1IJYA+7XzaHNV4c3pzCAO2GenFFcTZJx/JKYstO/bw4yozpYsS
	0azze71VcN24gvOTme/q1KZuh5/jpv6ynZIxsEl5BO3OHGLhwrom6oKBa2WVEIUSbXc0up
	HlN3CP0R1dwC+iSTchpcBUEiXlrOEl/u/faXfEGeLKc1SRo+agPRwhAJ08ol/Q==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, andrew@lunn.ch,
 sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, jihed.chaibi.dev@gmail.com
Subject: Re: [PATCH] ARM: dts: armada-370-db: Fix stereo audio input routing
 on Armada 370
In-Reply-To: <20250723224504.70862-1-jihed.chaibi.dev@gmail.com>
References: <20250723224504.70862-1-jihed.chaibi.dev@gmail.com>
Date: Fri, 22 Aug 2025 15:08:25 +0200
Message-ID: <87v7mf5ws6.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Jihed Chaibi <jihed.chaibi.dev@gmail.com> writes:

> The simple-audio-card configuration for the Armada 370 development
> board incorrectly routed the left channel signal ("AIN1L") to both
> sides of the stereo "In Jack".
>
> This commit corrects the typo for the right channel, changing the
> second "AIN1L" entry to "AIN1R" to enable proper stereo input
> recording.
>
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/marvell/armada-370-db.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/marvell/armada-370-db.dts b/arch/arm/boot/=
dts/marvell/armada-370-db.dts
> index a7dc4c04d..a9a05d826 100644
> --- a/arch/arm/boot/dts/marvell/armada-370-db.dts
> +++ b/arch/arm/boot/dts/marvell/armada-370-db.dts
> @@ -119,7 +119,7 @@ sound {
>  			"Out Jack", "HPL",
>  			"Out Jack", "HPR",
>  			"AIN1L", "In Jack",
> -			"AIN1L", "In Jack";
> +			"AIN1R", "In Jack";
>  		status =3D "okay";
>=20=20
>  		simple-audio-card,dai-link@0 {
> --=20
> 2.39.5
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

