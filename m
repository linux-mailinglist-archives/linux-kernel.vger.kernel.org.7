Return-Path: <linux-kernel+bounces-853330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57437BDB4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780E8547A27
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E9E306B0D;
	Tue, 14 Oct 2025 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="AU+V64vL"
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F82BD5BC;
	Tue, 14 Oct 2025 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474830; cv=none; b=GCoo5UIQ3j3C8bN0BTTQ4YV7Hg/kf9D/Jf9i/ueB2nCoTD4TWLIEon/NgqKgitO7dOmkYOxiN5zw6aKuhdScZW+mBnZ13t4LNbGiuJP1gPfqiUM0H5wL+aGV2Tlzseu5mRWNFs3teWa7QrF9Do2WIBQNtWEjvWWUislR0qQ0xjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474830; c=relaxed/simple;
	bh=O2xu8KT6jgh+ye6JsDNiUiafB4U434onqsAXqGafFck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUH2RDj0jXCpoa1+Nbl0XjwXXLsKcdzf06hB30sVN72j6bu6cyfm/WTeNcdMQHXfW4S2Zd3G1KeYoUdJMfyb5zQiDDwdjgHI5WcRRm87ePGiPJpfiWy+UkoAvyh/EvHPr/saRIEWcolzuXcBr7mD6kkZFnRKaXcYmaoAaIvqbv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=AU+V64vL; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A2EB102E6F;
	Tue, 14 Oct 2025 22:46:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1760474820;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nuqzPscocXsv4QGjyp5D1JTIpMR6i71bIBd2xUs9GwA=;
	b=AU+V64vLJIS8nNCskYQUQ6xa5LNBOJsrT6MDC0ynISJ+E0kFKF3GtvEtSz185FJmQxjXj5
	NMdf69XtvShQojk/cVcN0D0hWzNXGhBW8o/URYh2/xE2BBRDlAxYewSODWq/h2u9CNj4Fo
	EC3iVycbEEkQ4M7YamcnnIY0kkj3GdfvqfxyhrUkt4mhIjXPwa8lM+Ay0rE1yNDkCRKvN0
	5ePw+RoIlzKOMiy9rDshvnVvYr3CQxvwwoBXhcEPbJm6ZwD9cnAubrZfjYUFOVvJhAS4ON
	Cquol+3D3I13/Kv8RKPivc3yPZDAt1uZCb0pEh6zLHYURMD6Y9HRd63QQd2o+A==
Message-ID: <ddc44948-4816-452f-8b78-b1dfe44d507b@nabladev.com>
Date: Tue, 14 Oct 2025 22:46:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] ARM: dts: imx: add power-supply for lcd panel
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@dh-electronics.com
References: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
 <20251014-imx6_dts_clean_2-v1-1-508b36e5a3fd@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20251014-imx6_dts_clean_2-v1-1-508b36e5a3fd@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 10/14/25 9:38 PM, Frank Li wrote:
> Add power-supply for lcd panel to fix below CHECK_DTBS warnings:
>    arch/arm/boot/dts/nxp/imx/imx6q-evi.dtb: panel (sharp,lq101k1ly04): 'power-supply' is a required property

...

> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
> index b29713831a74489e8cc0e651c18a40d85f9f9113..04e570d76e42cd67a38e0f3b2301598f712e6bd4 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
> @@ -199,7 +199,7 @@ touchscreen@38 {
>   		reg = <0x38>;
>   		interrupt-parent = <&gpio5>;
>   		interrupts = <4 IRQ_TYPE_EDGE_FALLING>; /* GPIO E */
> -		power-supply = <&reg_panel_3v3>;
> +		vcc-supply = <&reg_panel_3v3>;
This looks like a different kind of change ?

