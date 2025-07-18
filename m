Return-Path: <linux-kernel+bounces-736746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A91B0A150
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861EF3AF505
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F722BDC2C;
	Fri, 18 Jul 2025 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZuLZxF+W"
Received: from mail-m21466.qiye.163.com (mail-m21466.qiye.163.com [117.135.214.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FE2BE038;
	Fri, 18 Jul 2025 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836104; cv=none; b=Tni8vvqe97DskVsdsbweudy3/iQ6V1m8LIcMRdgyw5bzVLVnL5Jcf8vhsblJGvn4H4iGBob/MeqUshnQDG3EBm5XzbHSrkToToWxB7cEcUo7SlOkP68RNiodwk3aMYv3Tx55AQbPUpzjslV0fFPjV1GYu8lfABSmiuuZ1nCO/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836104; c=relaxed/simple;
	bh=4gBXVNPAMgtMo6BKUHyszV5QqpivAr39SrMP2YKwJBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Swiv+6WPesJKwknFwSDMrzznFIXhzpQs1IHG/Oa+F73xx6z+kMnchvM+sB+R1F50iw0w8rgEd+Rl0maiKZY2rEDoma3jQOO9SwtD9GjSF1gNrht8dHYVcCB1/sLAUIrem3I/dtRi9xgvVlzxhVsJVUr/Nw/ESrLGHREX/B/O2z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=fail (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZuLZxF+W reason="signature verification failed"; arc=none smtp.client-ip=117.135.214.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c7e0c39a;
	Fri, 18 Jul 2025 18:39:28 +0800 (GMT+08:00)
Message-ID: <45c9eaa6-6ad0-4364-b5f8-b56aa3c44f69@rock-chips.com>
Date: Fri, 18 Jul 2025 18:39:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: rockchip: rk3399-typec-phy:
 Support mode-switch
To: Krzysztof Kozlowski <krzk@kernel.org>, Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20250718062619.99-1-kernel@airkyi.com>
 <20250718062619.99-2-kernel@airkyi.com>
 <20250718-psychedelic-panda-of-defiance-ef6aac@kuoka>
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20250718-psychedelic-panda-of-defiance-ef6aac@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a981d1e190003abkunm7ec24102152465
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkNLGVZMTEseS08eHR9IQ0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZuLZxF+WTFuWApXhP8dJJ5vNLXac2B6ezKmHuKb2coSmmtZwD9oTwpU+21pr6ArbSjEit/L7TtYifgkka1DZNyUpAbFrB1qW0xRuOXbzluQkT5jfXNwcCUszbsRGex/72Cs9IS1/qGQeBzD2IywmuWZwF7+3WYhnThas02obWKs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=zmzQ+FhY/AiTq0leos07zT40/sgCDe3I6hdGUfeDUWc=;
	h=date:mime-version:subject:message-id:from;

Hi Krzysztof,

On 2025/7/18 16:10, Krzysztof Kozlowski wrote:
> On Fri, Jul 18, 2025 at 02:26:15PM +0800, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> The RK3399 has two USB/DP combo PHY. With the help of external Type-C
>> controller, the PHY can switch altmode between USB and DP.
>>
>> Their connection diagram is shown below:
>>
>> external Type-C Chip0 ---> USB/DP PHY0 ---+
>>                                            | <----> CDN-DP controller
>> external Type-C Chip1 ---> USB/DP PHY1 ---+
> It looks like your "external" controller is not described. Look at your
> port property - "Connection to USB Type-C connector". Lack of proper
> hardware description leads you to claim that the PHY is the mode switch.
> I have doubts on that.
>
> You already received the comments that you need to come with rationale
> why making PHY a USB switch is correct. I don't see the arguments for
> that.

Sorry, I didn't get your point before. Now let me clear it up.

The RK3399 USB/DP commbo PHY support  change it's pin mapping, this 
means that we can implement the function of typec switch by changing the 
pin mapping through software configuration. In addition, DP lane can be 
configured for PHYs via software. Therefore, both mode-switch and 
orientation-switch are actually performed by the PHY itself, rather than 
by an external Type-C controller chip. The external chip is only used to 
report PD events.

Besides RK3399, RK3576/RK3588 also integrate these capabilities in their 
USB/DP PHY, with both mode-switch and orientation-switch handled by the 
PHY[0] .

Thanks for pointing this out. I'll add more detail in v3.


[0]: 
https://elixir.bootlin.com/linux/v6.15.6/source/drivers/phy/rockchip/phy-rockchip-usbdp.c#L693


