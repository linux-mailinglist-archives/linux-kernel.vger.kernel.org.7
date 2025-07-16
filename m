Return-Path: <linux-kernel+bounces-732708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C92B06B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF214E1334
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DA322D793;
	Wed, 16 Jul 2025 01:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="WzL1xQNd"
Received: from mail-m19731116.qiye.163.com (mail-m19731116.qiye.163.com [220.197.31.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1602E3700;
	Wed, 16 Jul 2025 01:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752628756; cv=none; b=pKQkfTyZ5lhsRFz3cjs/coUbkLFAUARfFOoNRPGWkCOlx0KEw/4MpEIPr69KDvD6qUUw0XWtMgu2xhqaJeNck3AhxW7OKONRxZlFup4OCb77CqJpkPzGuQXPKoTzkcwzzG7Mo023R3efxctseIcdhTVfsZ79NGcLOFAOAWK6pYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752628756; c=relaxed/simple;
	bh=WMNwDLUTzomfhPueszHsaY0EouNa6iWnvb8N3y3u0EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oytHXSzAce8lTbTndKJnGACzmaV3/bLluiYlTadEPvhx7HHhFuysNMyEijn+NFcCLkrY0gkZ78r8w051vWa1f1PR3KM2pInWIWf4BQx7eNN0u1vgQ6mK3Ft72kxS0QT/n2VjKZsxnzBRftRtb9z4kGvywhObUsJQi1BjsCNZWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=WzL1xQNd; arc=none smtp.client-ip=220.197.31.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [127.0.0.1] (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c20f26cc;
	Wed, 16 Jul 2025 09:18:56 +0800 (GMT+08:00)
Message-ID: <9e6c432a-9bed-474c-afa9-fd6ada8bb8f8@rock-chips.com>
Date: Wed, 16 Jul 2025 09:18:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: phy: rockchip: rk3399-typec-phy: Support
 mode/orientation switch
To: Krzysztof Kozlowski <krzk@kernel.org>, Chaoyi Chen <kernel@airkyi.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
 Diederik de Haas <didi.debian@cknow.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20250715112456.101-1-kernel@airkyi.com>
 <20250715112456.101-3-kernel@airkyi.com>
 <4dfed94c-665d-4e04-b527-ddd34fd3db8f@kernel.org>
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <4dfed94c-665d-4e04-b527-ddd34fd3db8f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh0eSVZKSEpKS0pIQh5KHR1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
X-HM-Tid: 0a9810d0310c03abkunmd19fa1411423d24
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBg6LTo*FDE0NwlMMVFCFTc8
	KTUKCSlVSlVKTE5JTUlDTE9NS01JVTMWGhIXVRgTGhQCElUYEx4VOwkUGBBWGBMSCwhVGBQWRVlX
	WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSExITTcG
DKIM-Signature:a=rsa-sha256;
	b=WzL1xQNdru/zKe4DMlBTqwjgA2IwGOyI3/txUXdcBAVE1KQqUbQT9JBMVDdMm8ZIMgaP0HN8jb4iceyiqmOwPb0XX7j6gmpr27mF8e13nD8gV8pFdhA9hTR5AW1FxVdoVWvT2k+f5qv827ZzKc29N2+W2JtkLU7e4ajVmc3kr0g=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=y9UGnpqAWUlGLKMTmekl851slDMZjV5j64meupx2I6w=;
	h=date:mime-version:subject:message-id:from;

Hi Krzysztof,

On 2025/7/15 19:34, Krzysztof Kozlowski wrote:
> On 15/07/2025 13:24, Chaoyi Chen wrote:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> Add support for Type-C orientation and altmode switch.
>> The Type-C controller can be specified to handling switching.
> Please describe the hardware in details. Above sentences don't help me
> to understand this.

I will add more description in v2.


>
>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>   .../bindings/phy/rockchip,rk3399-typec-phy.yaml    | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
>> index 91c011f68cd0..a885c6893a90 100644
>> --- a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
>> @@ -43,6 +43,20 @@ properties:
>>       description:
>>         Phandle to the syscon managing the "general register files" (GRF).
>>   
>> +  orientation-switch:
>> +    description: Flag the port as possible handler of orientation switching
>> +    type: boolean
>> +
>> +  mode-switch:
>> +    description: Flag the port as possible handler of altmode switching
>> +    type: boolean
>> +
>> +  port:
>> +    $ref: /schemas/graph.yaml#/properties/port
>> +    description:
>> +      A port node to link the PHY to a TypeC controller for the purpose of
>> +      handling orientation switching.
>
> You are using usb-switch.yaml properties in phy node, which raises
> questions whether this is actually complete. It might be, but commit msg
> is so vague that I have doubts.
>
> Also, why only one port?
>
> Or wait... you already have ports! two of them. This needs to stop, why
> are you adding more?

Oh, I will try to reuse them. Will fix in v2.


>
> Best regards,
> Krzysztof
>
>

