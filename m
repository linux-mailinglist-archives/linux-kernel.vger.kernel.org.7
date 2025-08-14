Return-Path: <linux-kernel+bounces-769163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D08B26AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8AF3BE8EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEED21CC62;
	Thu, 14 Aug 2025 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mC3quBJ7"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C998F58;
	Thu, 14 Aug 2025 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184987; cv=none; b=aQohXFp/JpT19s82fhEAvJTsnw060gti3hCX5/abHeR/ZFSdI55XeHbf7jFAXKmV7REeQcbKLYZDZO5Mk3ZucsuR3O6dcIEMnDymWlkvyT2mPXQ0TKkcriQHGKypF8WfmBWHFEqQmILn+BpUG4LkD3Ja5fzUCwRn9OWhbA5fNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184987; c=relaxed/simple;
	bh=qjtO41c38rpuKsYV5ayAQzQ9BLfZGevGWrqxNM6oyTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RaaBwHz6nS1/DRwQqKG5cMRZ9nGHIMa2lKudNFmIbb+qHhxC5cqZ+/MaxFbNP8hhkVdphuQg5tqMnQMJigO4pIgO7kg3r/OM3bjaQ6eWV+UOmIgO280VsT9kxi1HqFlsIrYvNZ55txOhqNPjs5wliMFzn5XDVQ38owHuY48B3Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mC3quBJ7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755184985; x=1786720985;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qjtO41c38rpuKsYV5ayAQzQ9BLfZGevGWrqxNM6oyTM=;
  b=mC3quBJ7Pg12S678iCnWHT7686LiIoAhAA3EpmxFDyq3SZvxUFt6qnBo
   W0ToffjhyQ3gdHLuftZsNXn3jhVAPAnfr1MDNGf56Pu9AIH8jpJqSP48d
   cquCbMWEJ99gyZ3BMaWEKOheQ3A9lQm3fxYD2028VHZhB2f0dV5o4gXum
   Hnz97rIdp11DXHuEOCnxnDRFHH3LUhfNcnNGnCu6nlHSKxB7R0u1QFoYV
   JDi8dZiYCVrEXJ0e/a61AclbCjp+znOYtCN++1tt1At2bloNzLG/W6J4m
   cG015o7pP/f+PYIurDAeImWAsAnSKOqw0WDiDwyZKJiUI8DzJFmeCn9RB
   Q==;
X-CSE-ConnectionGUID: OtV+OFDYSuOsKLpywoW1nQ==
X-CSE-MsgGUID: GwQnAvf/ThKdu6dsdqUvnw==
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="44660456"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2025 08:23:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 14 Aug 2025 08:22:54 -0700
Received: from [10.150.206.71] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 14 Aug 2025 08:22:51 -0700
Message-ID: <10824956-cb3a-4ccc-bea4-0f7310090db7@microchip.com>
Date: Thu, 14 Aug 2025 17:22:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 001/114] clk: at91: peripheral: fix return value
To: <bmasney@redhat.com>, Michael Turquette <mturquette@baylibre.com>,
	"Stephen Boyd" <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Paul Cercueil <paul@crapouillou.net>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>
CC: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <soc@lists.linux.dev>
References: <20250811-clk-for-stephen-round-rate-v1-0-b3bf97b038dc@redhat.com>
 <20250811-clk-for-stephen-round-rate-v1-1-b3bf97b038dc@redhat.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <20250811-clk-for-stephen-round-rate-v1-1-b3bf97b038dc@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2025 at 17:17, Brian Masney via B4 Relay wrote:
> From: Brian Masney <bmasney@redhat.com>
> 
> determine_rate() is expected to return an error code, or 0 on success.
> clk_sam9x5_peripheral_determine_rate() has a branch that returns the
> parent rate on a certain case. This is the behavior of round_rate(),
> so let's go ahead and fix this by setting req->rate.
> 
> Fixes: b4c115c76184f ("clk: at91: clk-peripheral: add support for changeable parent rate")
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
>   drivers/clk/at91/clk-peripheral.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
> index c173a44c800aa8cc6970c266995f4a60b0a38554..629f050a855aaebfd1a03ff87c2b016cd2284a5a 100644
> --- a/drivers/clk/at91/clk-peripheral.c
> +++ b/drivers/clk/at91/clk-peripheral.c
> @@ -279,8 +279,11 @@ static int clk_sam9x5_peripheral_determine_rate(struct clk_hw *hw,
>          long best_diff = LONG_MIN;
>          u32 shift;
> 
> -       if (periph->id < PERIPHERAL_ID_MIN || !periph->range.max)
> -               return parent_rate;
> +       if (periph->id < PERIPHERAL_ID_MIN || !periph->range.max) {
> +               req->rate = parent_rate;
> +
> +               return 0;
> +       }
> 
>          /* Fist step: check the available dividers. */
>          for (shift = 0; shift <= PERIPHERAL_MAX_SHIFT; shift++) {
> 
> --
> 2.50.1
> 
> 


