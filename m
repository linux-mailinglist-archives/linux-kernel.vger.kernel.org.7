Return-Path: <linux-kernel+bounces-724736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1942AFF659
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB281C22471
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E83D846C;
	Thu, 10 Jul 2025 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rZB4rIyk"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38CF3BB48
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752109728; cv=none; b=D89CLDGmH+0W+HA501pE8iPhxrf9kohNVx9XIphikUkFBj99HHL/4pfZUDRQQTfoMOGXVSD6IxpbSkyAgYRtLAASYEMYP+JoLLlTSeTwhSuGHeffbhxYupstH0LazVNOIYfX4ObFILM0tliqoPpVnkchJBaejRSeeKAKs03lcJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752109728; c=relaxed/simple;
	bh=FbD+dyWJQw9d7fJye3J0/MZOz530Binm7qw42BlBT/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdEn+g0otlF2oEwqZxRrYSnKGJFd9a/YlJn4rPjjfC2wU1s2pbpvt2uPZehCeyh6CWkhyjkhkFuoTaEZyCNE5YYZaj0IVHA0FUht+ubaXAr7XofWykK2QbhrkjEgP/PByh4Bpam8uqdOpuas+GF++TCzrCFkN18Fp4CtDMv8Ymk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rZB4rIyk; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b34eff8d-0c14-4085-bff1-f01ff3349637@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752109723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQ7oeQnXsRQ8nWk5JQ1NTJSWCTeX2lGsMRWJSN26Cvc=;
	b=rZB4rIykMxvqdSZtMQlQY3CQFNA0HMZFuaNpe4+91cvARvipziOB4FXevzVvBR86afLYxq
	tO0FhRvu1IulcmV36xdzkka0lDnvJAq9ES1hOJTztXlOENh1XNpHXtRNtOq1tKMpFP6BFW
	DFGJq4ZS9vG5maTIrOWhfSMWi0XIsoA=
Date: Thu, 10 Jul 2025 02:08:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 7/7] net: dsa: microchip: Disable PTP function
 of KSZ8463
To: Tristram.Ha@microchip.com, olteanv@gmail.com
Cc: Woojung.Huh@microchip.com, andrew@lunn.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, maxime.chevallier@bootlin.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, marex@denx.de, UNGLinuxDriver@microchip.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250709003234.50088-1-Tristram.Ha@microchip.com>
 <20250709003234.50088-8-Tristram.Ha@microchip.com>
 <20250709073503.kffxy4jlezoobqpf@skbuf>
 <LV3PR11MB874269079536CDB53183760DEC49A@LV3PR11MB8742.namprd11.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <LV3PR11MB874269079536CDB53183760DEC49A@LV3PR11MB8742.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/07/2025 23:59, Tristram.Ha@microchip.com wrote:
>> On Tue, Jul 08, 2025 at 05:32:33PM -0700, Tristram.Ha@microchip.com wrote:
>>> From: Tristram Ha <tristram.ha@microchip.com>
>>>
>>> The PTP function of KSZ8463 is on by default.  However, its proprietary
>>> way of storing timestamp directly in a reserved field inside the PTP
>>> message header is not suitable for use with the current Linux PTP stack
>>> implementation.  It is necessary to disable the PTP function to not
>>> interfere the normal operation of the MAC.
>>>
>>> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
>>> ---
>>>   drivers/net/dsa/microchip/ksz8.c | 11 +++++++++++
>>>   1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
>>> index ddbd05c44ce5..fd4a000487d6 100644
>>> --- a/drivers/net/dsa/microchip/ksz8.c
>>> +++ b/drivers/net/dsa/microchip/ksz8.c
>>> @@ -1761,6 +1761,17 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
>>>                                           reg16(dev, KSZ8463_REG_DSP_CTRL_6),
>>>                                           COPPER_RECEIVE_ADJUSTMENT, 0);
>>>                }
>>> +
>>> +             /* Turn off PTP function as the switch's proprietary way of
>>> +              * handling timestamp is not supported in current Linux PTP
>>> +              * stack implementation.
>>> +              */
>>> +             regmap_update_bits(ksz_regmap_16(dev),
>>> +                                reg16(dev, KSZ8463_PTP_MSG_CONF1),
>>> +                                PTP_ENABLE, 0);
>>> +             regmap_update_bits(ksz_regmap_16(dev),
>>> +                                reg16(dev, KSZ8463_PTP_CLK_CTRL),
>>> +                                PTP_CLK_ENABLE, 0);
>>>        }
>>>   }
>>>
>>> --
>>> 2.34.1
>>>
>>
>> What prevents the user from later enabling this through
>> ksz_set_hwtstamp_config(HWTSTAMP_TX_ONESTEP_P2P)?
> 
> The PTP engine in KSZ8463 is first generation.  The DSA PTP driver used
> by KSZ9477 and LAN937X is for second generation, which uses tail tag to
> pass along receive/transmit timestamp and port information.
> 
> It is not likely the PTP driver will be updated to support KSZ8463.
> Currently that driver code is not activated except for KSZ9477 and
> LAN937X.

I believe Vladimir was asking about software options and the answer is
that this switch is added with .ptp_capable = false in the patch 2.


