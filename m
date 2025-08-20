Return-Path: <linux-kernel+bounces-778043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A0EB2E0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AA2A03825
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19653334386;
	Wed, 20 Aug 2025 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RGKgbBUF"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA810334365
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702221; cv=none; b=GwgnqUuVSqtEs8YeBChhQ7Ex3uGuTW6y26WerlLoAIGpd5NnDFI9/WYvA4tD2m8m0k68+7wxc9GcoQV+18XQGpwbzuCKaKvgF4gW3zbVuirg6wl+t9mdI3TEGdlpmI1XGauycgqF8ffx8bB4bWbw5bQK0Yd77AIW6an0W5FtIT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702221; c=relaxed/simple;
	bh=0EFoaUWPAzWwpgzU3pvmrQ4MhPQdfhcCrBQ3+gdLRWA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=pXg9+NZKJ0tzTPf/5nLN6um1Wr4kpcLwfiS1tFOEsso8GuQRFACX1uouBDZd2On1bn+x1ZgKvdzSZhDsknJ/8BIrHKWfTZJloQDF1iW/UUA7//4zUSAd3QMSARhcn+hN5zqtFRG5Q/UNBC2wxqKDsZmgQb5omxJmrX/nqU8g3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RGKgbBUF; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 390F41A09EE;
	Wed, 20 Aug 2025 15:03:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 04915606A0;
	Wed, 20 Aug 2025 15:03:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EBFDD1C2288F8;
	Wed, 20 Aug 2025 17:03:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755702216; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lqjA40HWWIjcIx3M1y+rukbJMA+JHTWzf+bzksm45x8=;
	b=RGKgbBUF3A7HzCwL7Vmn+Og6nEsHaElJB60UDwiydlP7AsssrNxAwSck4WVkvj7Vc8Lo9Z
	mdQKFd0f+B7EurmhQXSSBf5KHzL4Hqosy0hYUJEIFfOy6bXTHhM/l4+oaFwId94qJ7e8MZ
	JaFrY4mkbhjJT2ZxrqcZEXMTpYz5wgM17tFGqzAd3/bEk9FDK+JQ3gCOKLyZ9wnlwbNgQ1
	hEITtDfZ+DwwciihveWhmsJLKj2UdLUc22V7uAMUUIvTVRgUwI/Zw5waffq4r5c5zAUhoz
	t9LVv82xJ3UwA4k9KCgvcjkzxUonDBV/P2jkuzjWzENI7Gy40BGmZ2HV3Sk/sg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 17:03:26 +0200
Message-Id: <DC7CHN0HU2SJ.EUZIRAIIO3EC@bootlin.com>
Subject: Re: [PATCH net v4 0/5] net: macb: various fixes
Cc: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, "Sean Anderson" <sean.anderson@linux.dev>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Harini Katakam" <harini.katakam@xilinx.com>, "Richard Cochran"
 <richardcochran@gmail.com>, "Russell King" <linux@armlinux.org.uk>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
In-Reply-To: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Aug 20, 2025 at 4:55 PM CEST, Th=C3=A9o Lebrun wrote:
> Changes in v4:
> - Drop 11 patches that are only cleanups. That includes the
>   RBOF/skb_reserve() patch that, after discussion with Sean [1], has
>   had its Fixes trailer dropped. "move ring size computation to
>   functions" is the only non-fix patch that is kept, as it is depended
>   upon by further patches. Dropped patches:
>     dt-bindings: net: cdns,macb: sort compatibles
>     net: macb: match skb_reserve(skb, NET_IP_ALIGN) with HW alignment
>     net: macb: use BIT() macro for capability definitions
>     net: macb: remove gap in MACB_CAPS_* flags
>     net: macb: Remove local variables clk_init and init in macb_probe()
>     net: macb: drop macb_config NULL checking
>     net: macb: simplify macb_dma_desc_get_size()
>     net: macb: simplify macb_adj_dma_desc_idx()
>     net: macb: move bp->hw_dma_cap flags to bp->caps
>     net: macb: introduce DMA descriptor helpers (is 64bit? is PTP?)
>     net: macb: sort #includes
>   [1]: https://lore.kernel.org/lkml/d4bead1c-697a-46d8-ba9c-64292fccb19f@=
linux.dev/
> - Link to v3: https://lore.kernel.org/r/20250808-macb-fixes-v3-0-08f1fcb5=
179f@bootlin.com

And I forgot mentioning that Jakub's comment [0] about wrapping to 80
characters got taken into account. Sorry about that omission!

[0]: https://lore.kernel.org/lkml/20250808160615.695beafe@kernel.org/

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


