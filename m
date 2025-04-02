Return-Path: <linux-kernel+bounces-585187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E7A790AB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 16:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE663B789F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 13:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF3F23AE7C;
	Wed,  2 Apr 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="o/sYsEgs"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980423BCF5
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602398; cv=none; b=cGcNK2IcZUojGfxLzqLP1AtYT3+YcgJD7Q4xndGEg0OVVRLDX58OgaX/l6KoUp0FVtOYfNCU6cM+1lnObajsXWX0zqkC2xtEleBsNSF7Pc/nH7m3d1eRfDx4Tv8UICXfosHuNZUiIav1r1iQRWOZjc2LVcFqhbIDp4MvP6kfEgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602398; c=relaxed/simple;
	bh=/4DaEGIXW044d5Cp6y0Go9pn44Yqu5BwIGbuF/5NnPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CS0wsmUoT6r4XLhNIU3ThL4IX0MQV6pkQP8Rbv2TEqCOrv+IX8Lc77kTXDhUp0za5IIji+pPZegn+easWTDLC1HS44PNqvQJM+GKAeZl2jLS2CuapyJAxRChCOLzaEyec3A5G1n/NyOLlB7tnLjLM+e8RCU0QW4YQj0Ru6MAXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=o/sYsEgs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 687186A2;
	Wed,  2 Apr 2025 15:58:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1743602282;
	bh=/4DaEGIXW044d5Cp6y0Go9pn44Yqu5BwIGbuF/5NnPg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o/sYsEgsM8snr1va7GPLJuvk+/RkfQw87WQmvP4kFt4xa7umWK8F2cmxKkQEnaX6r
	 k2duMI/kT0ycPpZuIbK2xj1RbsiELaBgJJSenp1loV0YzR5BvmOBo+mwLijcmAm459
	 0UKCViWg906d0Y2ZsprUwATb955oZzCdoShVC/1Q=
Message-ID: <4015caef-1afb-4c3f-8768-a3a5d51390a0@ideasonboard.com>
Date: Wed, 2 Apr 2025 16:59:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] phy: cadence: cdns-dphy: Update calibration wait
 time for startup state machine
To: Devarsh Thakkar <devarsht@ti.com>
Cc: sakari.ailus@linux.intel.com, u.kleine-koenig@baylibre.com,
 vigneshr@ti.com, aradhya.bhatia@linux.dev, s-jain1@ti.com,
 r-donadkar@ti.com, vkoul@kernel.org, kishon@kernel.org, mripard@kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250326152320.3835249-1-devarsht@ti.com>
 <20250326152320.3835249-3-devarsht@ti.com>
 <5465d2dd-d81a-4e33-b76f-cbbd3386c725@ideasonboard.com>
 <223da324-4de7-4e62-b001-ea89c4768a13@ti.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <223da324-4de7-4e62-b001-ea89c4768a13@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 02/04/2025 16:35, Devarsh Thakkar wrote:
> Hi Tomi,
> 
> Thanks for the review.
> 
> On 02/04/25 17:12, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 26/03/2025 17:23, Devarsh Thakkar wrote:
>>> Use system characterized reset value specified in TRM [1] to program
>>> calibration wait time which defines number of cycles to wait for after
>>> startup state machine is in bandgap enable state.
>>>
>>> This fixes PLL lock timeout error faced while using RPi DSI Panel on 
>>> TI's
>>> AM62L and J721E SoC [2].
>>>
>>> [1] AM62P TRM (Section ):
>>> https://www.ti.com/lit/pdf/spruj83
>>>
>>> [2]:
>>> Link: https://gist.github.com/devarsht/89e4830e886774fcd50aa6e29cce3a79
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 7a343c8bf4b5 ("phy: Add Cadence D-PHY support")
>>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>> ---
>>> V2: Introduced this as as separate patch
>>>
>>>   drivers/phy/cadence/cdns-dphy.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/ 
>>> cdns-dphy.c
>>> index c4de9e4d3e93..11fbffe5aafd 100644
>>> --- a/drivers/phy/cadence/cdns-dphy.c
>>> +++ b/drivers/phy/cadence/cdns-dphy.c
>>> @@ -30,6 +30,7 @@
>>>   #define DPHY_CMN_SSM            DPHY_PMA_CMN(0x20)
>>>   #define DPHY_CMN_SSM_EN            BIT(0)
>>> +#define DPHY_CMN_SSM_CAL_WAIT_TIME    GENMASK(8, 1)
>>>   #define DPHY_CMN_TX_MODE_EN        BIT(9)
>>>   #define DPHY_CMN_PWM            DPHY_PMA_CMN(0x40)
>>> @@ -405,6 +406,8 @@ static int cdns_dphy_configure(struct phy *phy, 
>>> union phy_configure_opts *opts)
>>>       reg = FIELD_PREP(DPHY_BAND_CFG_LEFT_BAND, band_ctrl) |
>>>             FIELD_PREP(DPHY_BAND_CFG_RIGHT_BAND, band_ctrl);
>>>       writel(reg, dphy->regs + DPHY_BAND_CFG);
>>> +    writel(FIELD_PREP(DPHY_CMN_SSM_CAL_WAIT_TIME, 0x14) | 
>>> DPHY_CMN_SSM_EN | DPHY_CMN_TX_MODE_EN,
>>> +           dphy->regs + DPHY_CMN_SSM);
>>
>> This sounds like a TI specific characterized value, but the function 
>> here is a generic one. Also, is the value same for all TI SoCs? Or is 
>> it per-soc?
>>
> 
> No this is not TI specific value. As mentioned in commit message, 0x14 
> is the cadence characterized default value for calibration wait time 
> which they put in as reset value in the IP (if you reset the IP you will 
> see calibration wait time as 0x14) to be used by software for optimal 
> initialization.

If it's a register default value, why do you need to write it? Also, why 
do you say "characterized reset value"? I can't find any reference to 
this in the TRM (in the patch you point to the TRM, but not where to 
find the data there). The reset value of 0x14 could be just a default 
value, not characterized at all. And if this is a bandgad related wait 
timeout, shouldn't it be set before the BAND_CFG registers? Although 
It's not clear what those do.

  Tomi


