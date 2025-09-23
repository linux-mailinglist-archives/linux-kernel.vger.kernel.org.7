Return-Path: <linux-kernel+bounces-828185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15B8B94214
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D30F2E09E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F2F266B41;
	Tue, 23 Sep 2025 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="cm2djMyY"
Received: from mail-m15567.qiye.163.com (mail-m15567.qiye.163.com [101.71.155.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0012AE99;
	Tue, 23 Sep 2025 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758598967; cv=none; b=dsK3/wykd34UMzb9YTDnUarZHqNDO9MGEPMWQmmAEc+s8L75aRc31mdApniSHNJOsulYgxblbF2m5UcNGYTkG/u8u/2CpTSLsgpkz4l9qhP082Um+Vf35IgmFZr4wwqVZy80bYydP2JWzpp5rTZxVbpwWLMfypLkWhXmKBBXkUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758598967; c=relaxed/simple;
	bh=YsIYnVzfSPxpVvjt/XAKbJoZbnK0hdwHhRGcmpD5Jhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KigWzXXebsLxfp+MGZjh8wZ6JBIxrzyHFVvMYeG18i1V+8c1Wo8JpkhEtQ1/+RIObbg4s2u8L6+UreI03m4Ul3sCEp6DyeiLD80za/Ih99VSjy4yp7WWftcABqLfbVgBXTFwFi0sRjq1Z9aW0mYvsdasuUeTHgRERn8duvrdoFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=cm2djMyY; arc=none smtp.client-ip=101.71.155.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 23b93816f;
	Tue, 23 Sep 2025 11:42:38 +0800 (GMT+08:00)
Message-ID: <7265bd00-3e44-40d7-8b53-0e4cd90f2717@rock-chips.com>
Date: Tue, 23 Sep 2025 11:42:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dt-bindings: phy: rockchip: rk3399-typec-phy:
 Support mode-switch
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Chaoyi Chen <kernel@airkyi.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
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
 <533d41bd-9293-4808-85f3-8fb6dc8bcda7@rock-chips.com>
 <mpyfe63tzxzxyyqf4vxwmrewzeosnaftlkko7pq2ynld6u3lcz@wlpixckov4hg>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <mpyfe63tzxzxyyqf4vxwmrewzeosnaftlkko7pq2ynld6u3lcz@wlpixckov4hg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9974aa8dc603abkunm5757e026ec32e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxhCSlZIGB0ZGEMdQ05PHh9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=cm2djMyY1KSH7R7fj+BsJrZJpRz+hFv7DR4CBPuZ4cXqi3Is0Xjfft+/qnuL+x3z0kVzyLXAGY05jU733OTg60njGbJQ4gL9W3wM+iO1LEwMSFrycz0UveCTLgVqGInCPgDsc1qJPFl0nezkToL/8ryZ29AAW5Px2Zd+JK2flzQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=4KUKqQ7mqQ2zVDBXjqLvwFYHz4+0xl7oABzJGnrMKc8=;
	h=date:mime-version:subject:message-id:from;

On 9/23/2025 11:17 AM, Dmitry Baryshkov wrote:

> On Tue, Sep 23, 2025 at 09:53:06AM +0800, Chaoyi Chen wrote:
>> Hi Dmitry,
>>
>> On 9/23/2025 9:12 AM, Dmitry Baryshkov wrote:
>>> On Mon, Sep 22, 2025 at 09:20:34AM +0800, Chaoyi Chen wrote:
>>>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>>
>>>> The RK3399 SoC integrates two USB/DP combo PHYs, each of which
>>>> supports software-configurable pin mapping and DisplayPort lane
>>>> assignment. These capabilities enable the PHY itself to handle both
>>>> mode switching and orientation switching, based on the Type-C plug
>>>> orientation and USB PD negotiation results.
>>>>
>>>> While an external Type-C controller is still required to detect cable
>>>> attachment and report USB PD events, the actual mode and orientation
>>>> switching is performed internally by the PHY through software
>>>> configuration. This allows the PHY to act as a Type-C multiplexer for
>>>> both data role and DP altmode configuration.
>>>>
>>>> To reflect this hardware design, this patch introduces a new
>>>> "mode-switch" property for the dp-port node in the device tree bindings.
>>>> This property indicates that the connected PHY is capable of handling
>>>> Type-C mode switching itself.
>>>>
>>>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>>
>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>
>>>> Changes in v4:
>>>> - Remove "|" in description.
>>>>
>>>> Changes in v3:
>>>> - Add more descriptions to clarify the role of the PHY in switching.
>>>>
>>>> Changes in v2:
>>>> - Reuse dp-port/usb3-port in rk3399-typec-phy binding.
>>>>
>>>>    .../devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml  | 6 ++++++
>>>>    1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
>>>> index 91c011f68cd0..83ebcde096ea 100644
>>>> --- a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
>>>> +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
>>>> @@ -51,6 +51,12 @@ properties:
>>>>          '#phy-cells':
>>>>            const: 0
>>>> +      mode-switch:
>>> Having the mode-switch here is a bit strange. I think the whole PHY
>>> device should be an orientation-switch and mode-switch. Otherwise it
>>> feels weird to me.
>> I think this is a difference in practice. In the previous binding, there was already an orientation-switch under the usb-port. I trying to add both an orientation-switch and a mode-switch to the top-level device in v2. And Krzysztof reminded me that adding a mode-switch under the dp-port would be better, so I changed it to the current form :)
> I couldn't find the comment on lore. Could you please point it out?

Sorry, it is v1. I added an orientation-switch and a mode-switch in the top-level PHY [0]. Comment is here: [1]


[0] https://lore.kernel.org/all/20250715112456.101-4-kernel@airkyi.com/

[1] https://lore.kernel.org/all/4dfed94c-665d-4e04-b527-ddd34fd3db8f@kernel.org/



>>
>>
>>>> +        description:
>>>> +          Indicates the PHY can handle altmode switching. In this case,
>>>> +          requires an external USB Type-C controller to report USB PD message.
>>>> +        type: boolean
>>>> +
>>>>          port:
>>>>            $ref: /schemas/graph.yaml#/properties/port
>>>>            description: Connection to USB Type-C connector
>>>> -- 
>>>> 2.49.0
>>>>
>> -- 
>> Best,
>> Chaoyi
>>
-- 
Best,
Chaoyi


