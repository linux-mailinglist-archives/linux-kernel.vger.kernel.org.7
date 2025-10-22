Return-Path: <linux-kernel+bounces-864446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0101BFAD0E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F6B1889847
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603ED2FF159;
	Wed, 22 Oct 2025 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0KfuQQMD"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBAD2F290B;
	Wed, 22 Oct 2025 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120600; cv=none; b=lp2qKRJ5DJKgu7U/s3lCkLt13kQy7SPlgYTS2+Gbvy0xCizweGC1dgSnky7CsYUVPHDs1kRzGTfcI8odknPyNrVQd1aZOMtSY8kxPWaTrinftPadHESfUCz3CcOpRMGbvpqZZwXXsSz9v6+0+nihBJCL45mOaoKJi9bYZSh+N8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120600; c=relaxed/simple;
	bh=Ist7iXsFS/EtIeLfo+26/9ri6j+gatskDLyPArpudyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMEQ2Mhq/Sd/R2yWQC474VpeV5y8kHpPdS9V4zmTCpdNpnstnA+Ed13S7CAAlRcBltJF8+1ruAyVj1Om99zOP1XTcjCK7MumidAZTo2iPsIrBFLn+wd7Wg/QDubzxxvsWDBRyYkzq/dEGe2LKF+q9kb6qUigtbtonJUY9rGMYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0KfuQQMD; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ED95BC0B8B3;
	Wed, 22 Oct 2025 08:09:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A53DE606DC;
	Wed, 22 Oct 2025 08:09:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F51C102F2357;
	Wed, 22 Oct 2025 10:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761120595; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=eFCQ4jx45F1FYN8BqQ6y7HUaiF9XH7IuNi4lw4uwUHU=;
	b=0KfuQQMDRPIv7aFraJgEJgBaBQp4xDq6zkX4ez3L0k0oTa8lzTT3LExxbsvZo7zW7YoJeh
	xal0jqVWdMtlSuOJCWASzxDHrXsG+4obIOuGcY9GIqSoJ6fnoZraeUXfl0Ki185YKh1IYr
	s9EiapCGt/7WWh8FvEQoE555NnTwNPOQwmVSo/+RPY9xyFzL1eX1ltoZ5zCGdZ7R3wRpJ+
	exy1Hreb6QP9sBwCS7vEjR5pIN8+/cZGAY3U8cItUS4C+3FyCpp7BiVfKmbFxj1mohERxT
	AS6+M9Umc0+8noHgeC//ZAY5Rw5GrhTjUdQFjRSgQUFLLKU64GJYUTKZeRCVhg==
Message-ID: <ef92f3be-176d-4e83-8c96-7bd7f5af365f@bootlin.com>
Date: Wed, 22 Oct 2025 10:09:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
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
 <20251022-macb-eyeq5-v2-5-7c140abb0581@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251022-macb-eyeq5-v2-5-7c140abb0581@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 22/10/2025 09:38, Théo Lebrun wrote:
> Add support for the two GEM instances inside Mobileye EyeQ5 SoCs, using
> compatible "mobileye,eyeq5-gem". With it, add a custom init sequence
> that must grab a generic PHY and initialise it.
> 
> We use bp->phy in both RGMII and SGMII cases. Tell our mode by adding a
> phy_set_mode_ext() during macb_open(), before phy_power_on(). We are
> the first users of bp->phy that use it in non-SGMII cases.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

This seems good to me. I was worried that introducing the unconditionnal
call to phy_set_mode_ext() could trigger spurious errors should the
generic PHY driver not support the requested interface, but AFAICT
there's only the zynqmp in-tree that use the 'phys' property with macb,
and the associated generic PHY driver (drivers/phy/phy-zynqmp.c) doesn't
implement a .set_mode, so that looks safe.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks !

Maxime


