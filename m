Return-Path: <linux-kernel+bounces-774361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8E0B2B156
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337B8189BD1A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192DC27603A;
	Mon, 18 Aug 2025 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T+dOXorp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534D275AF4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755544034; cv=none; b=RkSOQF0lSc6F2QpuqFTsDdsqVPvvwvD2EAbzpqb4IEyzEDYCJVaSvNVu6Rr8+32nRLwnaFTpP2sL2kEqiRFhIyrTlJb7X6BwJV+mwCOpYFu/kbrVJn7GtAiEF0t0QeIBgYWNnFwA74g3S2ECsa7mRfSv4zkbgz+Fyw9sZfkwj5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755544034; c=relaxed/simple;
	bh=J1eZ5XRnn37Z4WoTM1MwkW3Lzx55zP9wT2RCCr2Fek8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AecdOxOHCA4MgOMMZ2Xv6mcdUVXeYk6N7TwH2VfnjHxwqPq4NxBMCuxEkKWBsy/Ee9YqDPHrlIdwMPkFm2vyIJz/Avmdg2nScOZ56ROMWykZi+t39zDlqpIjNpahUV7ylWzLOLsCM720au8lpUmGPzM+svIwA75kSgDS46wggb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T+dOXorp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755544030;
	bh=J1eZ5XRnn37Z4WoTM1MwkW3Lzx55zP9wT2RCCr2Fek8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T+dOXorp7h6JkyqQNCAl3wEg59iUtraI+4nqQcP3GDoxAF3zAW30U5hEipVY1cJz2
	 GB4gEqSAP56qRrL7xutGFdR8R2KprrgSO3seOvQcdalMuWf85dsu0ztLYBA5HCt3pm
	 sX+/mLif1mvrChQziqoWg1zmUnZN4h37RqrtBNszwrlj/CCmtyAKXyBlV41JgeUOSt
	 ik1yYwVSu/NYdZhXp0abqJkJOhq8dp0rME4YI9c4grLdXUK7RkEuLPcXcs/grHHScQ
	 GGR97OJCKcu9w3hyVtXNKBnJit1C4i8rUoqep8gidfZQ+2IPPxxnOjlny0zoAxJADS
	 hoIDakPN2mOyw==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D485E17E04C0;
	Mon, 18 Aug 2025 21:07:09 +0200 (CEST)
Message-ID: <a3632629-188f-4645-a8b9-825075684194@collabora.com>
Date: Mon, 18 Aug 2025 22:07:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] phy: hdmi: Add HDMI 2.1 FRL configuration
 options
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250805-phy-hdptx-frl-v2-0-d118bd4b6e0b@collabora.com>
 <20250805-phy-hdptx-frl-v2-1-d118bd4b6e0b@collabora.com>
 <3d796f6c-d1d0-4499-8e63-bd37bfcc7c3a@oss.qualcomm.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <3d796f6c-d1d0-4499-8e63-bd37bfcc7c3a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 8/16/25 1:23 AM, Dmitry Baryshkov wrote:
> On 05/08/2025 14:56, Cristian Ciocaltea wrote:
>> Add support for configuring the Fixed Rate Link (FRL) mode for HDMI
>> PHYs.
>>
>> For improved clarity, also rename existing HDMI mode to HDMI_TMDS.
>> Since this mode is currently not being used explicitly, no further
>> changes are needed.
> 
> 
> I'd say, this need some explanation, especially for those who don't have access 
> to the HDMI standard. Please mention that FRL is an alternative to the traditional TMDS mode, etc.

Done in v3 [1].

> 
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   include/linux/phy/phy-hdmi.h | 14 ++++++++++++--
>>   include/linux/phy/phy.h      |  3 ++-
>>   2 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/phy/phy-hdmi.h b/include/linux/phy/phy-hdmi.h
>> index f0ec963c6e84f1b7728acafc824dff191c6b873d..0b26472d8defcc9ded142d4283e29861dc2b3746 100644
>> --- a/include/linux/phy/phy-hdmi.h
>> +++ b/include/linux/phy/phy-hdmi.h
>> @@ -6,16 +6,26 @@
>>   #ifndef __PHY_HDMI_H_
>>   #define __PHY_HDMI_H_
>>   +#include <linux/types.h>
>> +
>>   /**
>>    * struct phy_configure_opts_hdmi - HDMI configuration set
>> - * @tmds_char_rate: HDMI TMDS Character Rate in Hertz.
>>    * @bpc: Bits per color channel.
>> + * @tmds_char_rate: HDMI TMDS Character Rate in Hertz.
>> + * @frl.rate_per_lane: HDMI FRL Rate per Lane in Gbps.
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
>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>> index 13add0c2c40721fe9ca3f0350d13c035cd25af45..04c84c1dbd6dac55fd04c54203cff4f9d939d970 100644
>> --- a/include/linux/phy/phy.h
>> +++ b/include/linux/phy/phy.h
>> @@ -44,7 +44,8 @@ enum phy_mode {
>>       PHY_MODE_SATA,
>>       PHY_MODE_LVDS,
>>       PHY_MODE_DP,
>> -    PHY_MODE_HDMI,
>> +    PHY_MODE_HDMI_TMDS,
>> +    PHY_MODE_HDMI_FRL,
> 
> I'd maybe suggest keeping PHY_MODE_HDMI and having two submodes: one for TMDS (default), one for FRL.

Also done in v3 [1].

Thank you for the review!

Regards,
Cristian

> 
>>   };
>>     enum phy_media {
>>

[1] https://lore.kernel.org/all/20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com/

