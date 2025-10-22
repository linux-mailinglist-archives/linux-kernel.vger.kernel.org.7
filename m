Return-Path: <linux-kernel+bounces-864429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FB7BFAC73
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC661A052B8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D96A2FF149;
	Wed, 22 Oct 2025 08:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D5jaGHRj"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A5E2DF155
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120341; cv=none; b=KzCkduyk4i0jiR4ldteJX9hSATdCtUtug1PAfHueG7LRi5XTbykkdiO3UTME3RnmC1PZNJOfhHLvT6SoBMKzRUaAPMGrLUrHnVI/AEl3bF5hXLFeqlpFspF6CQv8fM7Cy3Mwon2rVgrPcqaZYa0R2KcWHEudZ3DsXjwHXTkT/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120341; c=relaxed/simple;
	bh=kJTxADCnrPF0C0LvVodDKJ12ZmW8l1cU1TiDilEriAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa+kWYtJe6ALTM48tF4zRsPizkti9iNFOPf8yrNvxlaKLb8uBiDHy/7tJHzTqoa3/RWbBZk0AHtyetShaDqavTvE7dpmoSwVEAhugNsckYm4P+xx3YWNIpX8JLSx2p2iMpub4Ab+j23BU/ILLBfLdN/2c9luzMoMrF5Y86cuBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D5jaGHRj; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B5266C0B8B8;
	Wed, 22 Oct 2025 08:05:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 60537606DC;
	Wed, 22 Oct 2025 08:05:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2BE5102F2426;
	Wed, 22 Oct 2025 10:05:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761120336; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=kBupXQ4ndi9PJAUUH78feYD9ZDDfnknJ54B3Giecuio=;
	b=D5jaGHRj29QBP6bpOSZhaQ3XytiuSkJYYMW1+84OY/eNXqaDbMIHwRSpoHyMyKFY/tp8pS
	kML5zTRiOWAHZ55gF8b4etMnOZque/NKLfhIPDbxlm2hLcGG9PzEU/Gp2jT5dVqC7xCdkw
	yB4dNuKpVKOCUSsf0cym7SXGT1T/nNjesUifJf0AWvoVCmDx6zjgyPYUJFLcbi3fo1Tj/r
	d3ND6scDT/T1LopE/idfcyu3VZkp2DS/62ofGZK58zj3ZT0nCp2FPSplaNxjy8ujbDvIF7
	XfhpVS5DN5Ot2o3d+LJWjyETXm3wrxxynpc0hezYeiczQnXqD3j8+/XLPefWGQ==
Message-ID: <53a53236-3cdf-420f-aa7e-6b00bc854b20@bootlin.com>
Date: Wed, 22 Oct 2025 10:05:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/5] net: macb: rename bp->sgmii_phy field to
 bp->phy
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, =?UTF-8?Q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
References: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
 <20251022-macb-eyeq5-v2-4-7c140abb0581@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251022-macb-eyeq5-v2-4-7c140abb0581@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 22/10/2025 09:38, Théo Lebrun wrote:
> The bp->sgmii_phy field is initialised at probe by init_reset_optional()
> if bp->phy_interface == PHY_INTERFACE_MODE_SGMII. It gets used by:
>  - zynqmp_config: "cdns,zynqmp-gem" or "xlnx,zynqmp-gem" compatibles.
>  - mpfs_config: "microchip,mpfs-macb" compatible.
>  - versal_config: "xlnx,versal-gem" compatible.
> 
> Make name more generic as EyeQ5 requires the PHY in SGMII & RGMII cases.
> 
> Drop "for ZynqMP SGMII mode" comment that is already a lie, as it gets
> used on Microchip platforms as well. And soon it won't be SGMII-only.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks Théo,

Maxime

