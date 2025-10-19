Return-Path: <linux-kernel+bounces-859761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35350BEE7EB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFC6D349DF5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A782EBB80;
	Sun, 19 Oct 2025 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="HvLCDDOx"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE72EB86A
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885658; cv=none; b=jpzQ23kdUsCaPqrKrgIQCGgPgDHqUF44Yq0i3rDDnb3yZ8j4yF4MT17Q6rq8uMriCrFAPu6/7fxSFnhDqcUn+oQJc6AKeo8yWCsfxixks/CYvxP25H9AM7VQrgflecjWcbBr44qAEmugQiK/55Glj+FWQsC/8mv7DJYkH4ufWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885658; c=relaxed/simple;
	bh=d8Pg8R6x1/+u9bA7hzs8YDo6dejzJbgbgCiliVrbRa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jr6+QGi/0neCg3d0j3WkIJQt1BfeXAukEgVan9LBF+qjMggRH7YnoA9P0TBjxqZ2NwaKCuJTprp5lCfPm9ZENn/2+7WjHty6zkhP87lypwh+sn7qZJMExwdMcRaCX1wMvQHyAO8t9ySa8x+/jaIEad21JczLvJoi6he51Jk+wqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=HvLCDDOx; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1760885656;
 bh=qSqIvRJaVaOD2FEuoL8TgkWRa8SKjL48NnFIM4Gn36w=;
 b=HvLCDDOxfoI6KE1hVe4pL0dVSIURHh8GJWMW+DFTvdNyB50bsOOsvU4LpcSjrDMB87/2eQrbL
 C3H+YI/j0uWO07Qx0ak9YOY803EB9q1MMwuZQSOX2AhSHNX7wIdzHSllfv7dUToPYkxJROAlIjf
 0n/wzp9XTVvNZ6OLmt4fp69u3yjNLhhYsgmgYygPtMOwspzmXmicaTk0bJ/G7m09L0xHNZsMCRm
 0vbCzZB2rxYl53d73YaURF73t3+CNklEdMs8UXW632o9p5nkBB7uhe2AL68WlzRlqWOx5xuMG+h
 iEflwOaaU5w0O/R1RKFSi9TT7ZVI+injU0CwztfdP22Q==
X-Forward-Email-ID: 68f4f9393ada90b94ba980e5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ff1765b0-ad78-4bdb-94fa-c58456358781@kwiboo.se>
Date: Sun, 19 Oct 2025 16:44:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] phy: rockchip: inno-usb2: Add support for RK3528
To: Vinod Koul <vkoul@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jianwei Zheng <jianwei.zheng@rock-chips.com>
References: <20250723122323.2344916-1-jonas@kwiboo.se>
 <20250723122323.2344916-6-jonas@kwiboo.se> <aJtip49r8R3-2XXi@vaman>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <aJtip49r8R3-2XXi@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vinod,

On 8/12/2025 5:49 PM, Vinod Koul wrote:
> On 23-07-25, 12:23, Jonas Karlman wrote:
>> From: Jianwei Zheng <jianwei.zheng@rock-chips.com>
> 
> Please do not send encrypted emails over public mail lists
> 
>>
>> The RK3528 has a single USB2PHY with a otg and host port.
>>
>> Add support for the RK3528 variant of USB2PHY.
>>
>> PHY tuning for RK3528:
>>
>> - Turn off differential receiver in suspend mode to save power
>>   consumption.
>>
>> - Set HS eye-height to 400mV instead of default 450mV.
>>
>> - Choose the Tx fs/ls data as linestate from TX driver for otg port
>>   which uses dwc3 controller to improve fs/ls devices compatibility with
>>   long cables.
>>
>> This is based on vendor kernel linux-stan-6.1-rkr5 tag.
>>
>> Signed-off-by: Jianwei Zheng <jianwei.zheng@rock-chips.com>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 74 +++++++++++++++++++
>>  1 file changed, 74 insertions(+)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> index cd1a02b990ef..b8950d9f9e97 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> @@ -1507,6 +1507,28 @@ static int rk3128_usb2phy_tuning(struct rockchip_usb2phy *rphy)
>>  				BIT(2) << BIT_WRITEABLE_SHIFT | 0);
>>  }
>>  
>> +static int rk3528_usb2phy_tuning(struct rockchip_usb2phy *rphy)
>> +{
>> +	int ret = 0;
> 
> Superfluous init

I would think it make it much clearer to init to zero because we are
bitwise OR return values from the following calls.

> 
>> +
>> +	/* Turn off otg port differential receiver in suspend mode */
>> +	ret |= regmap_write(rphy->phy_base, 0x30, BIT(18) | 0x0000);
>> +
>> +	/* Turn off host port differential receiver in suspend mode */
>> +	ret |= regmap_write(rphy->phy_base, 0x430, BIT(18) | 0x0000);
>> +
>> +	/* Set otg port HS eye height to 400mv (default is 450mv) */
>> +	ret |= regmap_write(rphy->phy_base, 0x30, GENMASK(22, 20) | 0x0000);
>> +
>> +	/* Set host port HS eye height to 400mv (default is 450mv) */
>> +	ret |= regmap_write(rphy->phy_base, 0x430, GENMASK(22, 20) | 0x0000);
>> +
>> +	/* Choose the Tx fs/ls data as linestate from TX driver for otg port */
>> +	ret |= regmap_write(rphy->phy_base, 0x94, GENMASK(22, 19) | 0x0018);
> 
> No error checking?

Error checking is happening in the function calling this internal ops.

Similar to the other tuning ops in this driver it does not matter
exactly what fails, the use of |= is there to help simplify the function
and for the caller to just error out if any of the write fails.

I will shortly send a v2 without changing anything in this patch.

Regards,
Jonas

