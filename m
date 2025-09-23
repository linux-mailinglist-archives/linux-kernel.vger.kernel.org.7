Return-Path: <linux-kernel+bounces-828092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3CBB93EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84723447D57
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DB2272E63;
	Tue, 23 Sep 2025 01:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FVAuvIC6"
Received: from mail-m1973197.qiye.163.com (mail-m1973197.qiye.163.com [220.197.31.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A244946C;
	Tue, 23 Sep 2025 01:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592705; cv=none; b=uSVtxiaBbRUvGB4dlMqh8L8wUg002aj2Ro1RaVqmso7v6mWmHnAzQaE0OQEAph55bvF95fIGV8ii2CfZyVCslADKo95mCmE6WwdRm49Uero8xqxKwq3iXQaLtcO+UUUENiFHxF/WxzRr8QLFhqsXsUHsJTSBA9nR5ly9rRpVzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592705; c=relaxed/simple;
	bh=kwpF0sC1ejDxVrtPyMqwsFSSr8a4hQm9E1QnACx1Rmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkIWxPIb+IcVyQdIOnZTe/brPRa/KhsIgixYWNy/9dVt6ms+s24/GhccYtaWqcRh7UnHmNpg8j9ETUhgGqnQ+xYIlsE8QZ00X+0YLRw+fzuaOcEbdwDZfmUN0BvZYLHa0xjXdTRAjDiEb9n5AdgRLtYqm4/IKgQyn/Rarz6eS48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FVAuvIC6; arc=none smtp.client-ip=220.197.31.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 23b4ad8a0;
	Tue, 23 Sep 2025 09:53:08 +0800 (GMT+08:00)
Message-ID: <533d41bd-9293-4808-85f3-8fb6dc8bcda7@rock-chips.com>
Date: Tue, 23 Sep 2025 09:53:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dt-bindings: phy: rockchip: rk3399-typec-phy:
 Support mode-switch
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Chaoyi Chen <kernel@airkyi.com>
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
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20250922012039.323-1-kernel@airkyi.com>
 <20250922012039.323-3-kernel@airkyi.com>
 <eb6ogrepo5acwcj5gpdolxxyg3xrx7kz6zrbizzseqyavvitfd@cnzurelqeh4t>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <eb6ogrepo5acwcj5gpdolxxyg3xrx7kz6zrbizzseqyavvitfd@cnzurelqeh4t>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9974464da503abkunm22f00280b9170
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJCS1ZMS0JNSEhIGktMGUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FVAuvIC6WtCOkl7iGSCNBPn3NST+u7LAfgkkz8bBSPG57/anneDVRUxQD3phPFobGTw+H2FPJ/3RW8oPuZRKAoRqzyfzCBiMzGiX/zF3oVAyQoce5gghiL9LICOcDeJyrqy+JhX3wovoruTkQeXgpo19obUlwY5peVyclSu6Dic=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=XLei+uFr5YZHJ93sMcV3QqaOLicJRVy9CC898it139A=;
	h=date:mime-version:subject:message-id:from;

Hi Dmitry,

On 9/23/2025 9:12 AM, Dmitry Baryshkov wrote:
> On Mon, Sep 22, 2025 at 09:20:34AM +0800, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> The RK3399 SoC integrates two USB/DP combo PHYs, each of which
>> supports software-configurable pin mapping and DisplayPort lane
>> assignment. These capabilities enable the PHY itself to handle both
>> mode switching and orientation switching, based on the Type-C plug
>> orientation and USB PD negotiation results.
>>
>> While an external Type-C controller is still required to detect cable
>> attachment and report USB PD events, the actual mode and orientation
>> switching is performed internally by the PHY through software
>> configuration. This allows the PHY to act as a Type-C multiplexer for
>> both data role and DP altmode configuration.
>>
>> To reflect this hardware design, this patch introduces a new
>> "mode-switch" property for the dp-port node in the device tree bindings.
>> This property indicates that the connected PHY is capable of handling
>> Type-C mode switching itself.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>
>> Changes in v4:
>> - Remove "|" in description.
>>
>> Changes in v3:
>> - Add more descriptions to clarify the role of the PHY in switching.
>>
>> Changes in v2:
>> - Reuse dp-port/usb3-port in rk3399-typec-phy binding.
>>
>>   .../devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml  | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
>> index 91c011f68cd0..83ebcde096ea 100644
>> --- a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
>> @@ -51,6 +51,12 @@ properties:
>>         '#phy-cells':
>>           const: 0
>>   
>> +      mode-switch:
> Having the mode-switch here is a bit strange. I think the whole PHY
> device should be an orientation-switch and mode-switch. Otherwise it
> feels weird to me.

I think this is a difference in practice. In the previous binding, there was already an orientation-switch under the usb-port. I trying to add both an orientation-switch and a mode-switch to the top-level device in v2. And Krzysztof reminded me that adding a mode-switch under the dp-port would be better, so I changed it to the current form :)



>
>> +        description:
>> +          Indicates the PHY can handle altmode switching. In this case,
>> +          requires an external USB Type-C controller to report USB PD message.
>> +        type: boolean
>> +
>>         port:
>>           $ref: /schemas/graph.yaml#/properties/port
>>           description: Connection to USB Type-C connector
>> -- 
>> 2.49.0
>>
-- 
Best,
Chaoyi


