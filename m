Return-Path: <linux-kernel+bounces-817238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C91CB57FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707E17B1E86
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106DD343212;
	Mon, 15 Sep 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XP/6ecZ9"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560632F76A;
	Mon, 15 Sep 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948003; cv=none; b=JUIIyjVkXVbf2p6aiEuSCIJdWqfBQpgWwXfTJjMuCUq6ncHMmEEzsz4ssapNIdLQ+JLmjvgIEToDdTvVFxF/tlTWTaDDDADpF6L2XE4FE87xrCVZ9fJPKu0r+L3rYCIhqMO4JdY2Ei0gxJFifEoR4hbDlyXffNOwqxcxi7qH2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948003; c=relaxed/simple;
	bh=NI/V1BFu/xw0s0N3NYrfmXM+nPXpri1JQ+T381KWCLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eDebAc9QJP9Enn2NTMEbVcNZ53TYJqmDB2ecAgwgt8H8OEWyDKxjzrLmESUVrNn+WTLcQowFg5rGdaZ/KrCjnpR2eo3DHZaX40mUMpnwfdfxhHBjOCn8Qs1I1ZllwhOQiYZI6NJpHBwm4/Em12GPrzf1T/Lot5/2X4PJCcv95wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XP/6ecZ9; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757948001; x=1789484001;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NI/V1BFu/xw0s0N3NYrfmXM+nPXpri1JQ+T381KWCLY=;
  b=XP/6ecZ96pstD0Ap76SIZxes0dpb2cpnBVvtOQe3m1jWCYexlJTmkQdv
   axDB8U+wXoWERcKCWQ19IST17sMOxaFkRcUwc0YzZbf1U8JnYjAjvFQpJ
   GJjf0u8xhrdAulxDNp7cboXZoZXFsOC4I+7Ts/U3RHA6NYDnQUsP3Z6mF
   T9iuUSjXC1dPOI1Y32jaBa/YhG8qXpv8owl4tQe+PJgPkUDqdH7L4WJPb
   5KCJoPXdtFfTsVV1kdNQzlo4CPl7qRjIdFFbDRxgEM9Lscl0Zpt9IVy69
   tIPTl3l3/kWgqcUD/UmZhy0zsHRL4hiVomYsspo/E+XS6Zqs79bRP+i5A
   w==;
X-CSE-ConnectionGUID: t4nJTFLUQceZvkt6u9W+ug==
X-CSE-MsgGUID: OXxTyGUQRK+73AIK12XuEA==
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="45941907"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2025 07:53:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 15 Sep 2025 07:53:17 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 15 Sep 2025 07:53:15 -0700
Message-ID: <826bb7ba-c4fb-4dd9-9332-88140d7a0eb1@microchip.com>
Date: Mon, 15 Sep 2025 16:53:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: at91: sam9x7: Add peripheral clock id for pmecc
To: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250909103817.49334-1-balamanikandan.gunasundar@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250909103817.49334-1-balamanikandan.gunasundar@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 09/09/2025 at 12:38, Balamanikandan Gunasundar wrote:
> Add pmecc instance id in peripheral clock description.
> 
> Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>

Added to clk-microchip with fix of tab vs. space (made by Claudiu).

Thanks, regards,
   Nicolas

> ---
> Changes in v2:
> - Removed Acked-by tag that was added by mistake
> 
>   drivers/clk/at91/sam9x7.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
> index ffab32b047a0..bce60f7393d5 100644
> --- a/drivers/clk/at91/sam9x7.c
> +++ b/drivers/clk/at91/sam9x7.c
> @@ -403,6 +403,7 @@ static const struct {
>   	{ .n = "pioD_clk",	.id = 44, },
>   	{ .n = "tcb1_clk",	.id = 45, },
>   	{ .n = "dbgu_clk",	.id = 47, },
> +	{ .n = "pmecc_clk",     .id = 48, },
>   	/*
>   	 * mpddr_clk feeds DDR controller and is enabled by bootloader thus we
>   	 * need to keep it enabled in case there is no Linux consumer for it.


