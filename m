Return-Path: <linux-kernel+bounces-775523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF93B2C01E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12D7720F59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDCF326D48;
	Tue, 19 Aug 2025 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BvTH/O9N"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2390322DB8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602431; cv=none; b=Pw1rpPIAzWT+ha4mW2QwX5JoHeERd2EloAYtiHuaB1Xwn4USrboioozOZtBG+DqdgGbfVsyB3YWvMJeODCZCWL/Cze4Cb/ZI+v5lXFb+bikpClGT/f4aWB8dWvLwc66HNO1/sejuJVVQQepYfuWnKKOCLM3Uy8HCuiZ/pO4p3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602431; c=relaxed/simple;
	bh=L8tNZa8rFAjIaVfhYUnPCfD9vH3EZUr5qfXZi344qpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWiOaM/Q84bBpTH2ZyNluouNhTS/HL1MJ5RN8cwkWSV7QUMl+kZyzBzC6sDQh/fNMHmHHXrzbN81HrFc42xETJOnU6+xra6pCj060NznNjd/1dRBbQvonicty8VMnyXiDpIqRUMqkigO39IUZcuweuHw4/b/JCe4b/zf+z1sGJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BvTH/O9N; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755602427;
	bh=L8tNZa8rFAjIaVfhYUnPCfD9vH3EZUr5qfXZi344qpM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BvTH/O9NLxfQd2rkp0s0OxsNVlHxCwne83pic3+AH1jjGWltxmJhzts/BE6K/Uj4j
	 5KE799gb0YKREeZkqh2jpdpyR07wi2lgfEZxp/2Ix3R0GBiFK2L7jckPycchNCvvli
	 1BZkRaUVBybtE0pQR+CFvmqxMetyB/J/YbrhgK1YqdzUdbOIAvmIaRUEZ4qyF9Erjh
	 cJI95i/SYINRbBLLWjpsmZE1E/6Hp3jvlO90cMY2i8dmuHzoWZPuptYKx64BqjMsnS
	 6pYAztXE5++OTYC+52Uitnh6h6Q2FhHkkMKRieROWXQxj1GtjVaqDzrVEtYio/H78V
	 Ypjt8Z+hTYcrA==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4620F17E135D;
	Tue, 19 Aug 2025 13:20:27 +0200 (CEST)
Message-ID: <d4624c04-93c3-4db4-a45d-ed111901a5fc@collabora.com>
Date: Tue, 19 Aug 2025 14:20:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] phy: hdmi: Add HDMI 2.1 FRL configuration
 options
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com>
 <20250818-phy-hdptx-frl-v3-1-c79997d8bb2b@collabora.com>
 <3f857197-1cd1-4c18-88e9-e8c00d95af82@oss.qualcomm.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <3f857197-1cd1-4c18-88e9-e8c00d95af82@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/25 3:42 AM, Dmitry Baryshkov wrote:
> 
> 
> On 18/08/2025 21:59, Cristian Ciocaltea wrote:
>> The HDMI 2.1 specification introduced the Fixed Rate Link (FRL) mode,
>> aiming to replace the older Transition-Minimized Differential Signaling
>> (TMDS) mode used in previous HDMI versions to support much higher
>> bandwidths (up to 48 Gbps) for modern video and audio formats.
>>
>> FRL has been designed to support ultra high resolution formats at high
>> refresh rates like 8K@60Hz or 4K@120Hz, and eliminates the need for
>> dynamic bandwidth adjustments, which reduces latency.  It operates with
>> 3 or 4 lanes at different link rates: 3Gbps, 6Gbps, 8Gbps, 10Gbps or
>> 12Gbps.
>>
>> Add support for configuring the FRL mode for HDMI PHYs.
> 
> Could you please point out corresponding DRM patches? 
> They might be WIP or incomplete. I'd like to see how this works on the consumer side.

Sure, please check the top-most commits prefixed with [WIP-FRL] in [1].  In
particular, phy_set_mode_ext() is being called in [2].

>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   include/linux/phy/phy-hdmi.h | 19 +++++++++++++++++--
>>   1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/phy/phy-hdmi.h b/include/linux/phy/phy-hdmi.h
>> index f0ec963c6e84f1b7728acafc824dff191c6b873d..83330d359e3ae345554f20429519da14506b8ab5 100644
>> --- a/include/linux/phy/phy-hdmi.h
>> +++ b/include/linux/phy/phy-hdmi.h
>> @@ -6,16 +6,31 @@
>>   #ifndef __PHY_HDMI_H_
>>   #define __PHY_HDMI_H_
>>   +#include <linux/types.h>
>> +
>> +enum phy_mode_hdmi {
>> +    PHY_MODE_HDMI_TMDS,
>> +    PHY_MODE_HDMI_FRL,
> 
> There is no unified approach for PHY submode names. Nevertheless I'd suggest something like PHY_HDMI_MODE_TMDS / _FRL. 
> It follows more closely the networking / USB submodes. An alternative might be to use PHY_SUBMODE_HDMI_TMDS / _FRL.

I'd go for PHY_HDMI_MODE_{TMDS|FRL} and I should probably also rename the
enum to phy_hdmi_mode.

> But it's really a nit and/or bikeschedding.

No worries, let's handle this.

>> +};
>> +
>>   /**
>>    * struct phy_configure_opts_hdmi - HDMI configuration set
>> - * @tmds_char_rate: HDMI TMDS Character Rate in Hertz.
>>    * @bpc: Bits per color channel.
>> + * @tmds_char_rate: HDMI TMDS Character Rate in Hertz.
>> + * @frl.rate_per_lane: HDMI FRL Rate per Lane in Gbps.
> 
> This works nicely until HDMI Forum adds an rate not being even Gbps. 
> Is there a reason for not using ULL and bps following the tmds_char_rate design?

This is for consistency with the related members of struct drm_hdmi_info:

    /** @max_frl_rate_per_lane: support fixed rate link */
    u8 max_frl_rate_per_lane;

    /** @max_lanes: supported by sink */
    u8 max_lanes;

>> + * @frl.lanes: HDMI FRL lanes count.
>>    *
>>    * This structure is used to represent the configuration state of a HDMI phy.
>>    */
>>   struct phy_configure_opts_hdmi {
>> -    unsigned long long tmds_char_rate;
>>       unsigned int bpc;
>> +    union {
>> +        unsigned long long tmds_char_rate;
>> +        struct {
>> +            u8 rate_per_lane;
>> +            u8 lanes;
>> +        } frl;
>> +    };
>>   };
>>     #endif /* __PHY_HDMI_H_ */
>>
> 

[1] https://gitlab.collabora.com/cristicc/linux-next/-/commits/rk3588-hdmi-frl
[2] https://gitlab.collabora.com/cristicc/linux-next/-/commit/86dd2cbbccdc71a3b5db87fdf876370dc3b6f2df#90498bf5e199fded685141134e7c623ef4f4411c_132_215 


