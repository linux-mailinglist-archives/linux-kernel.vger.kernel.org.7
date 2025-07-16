Return-Path: <linux-kernel+bounces-732742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA5BB06BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC32A562697
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A3273D96;
	Wed, 16 Jul 2025 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QAuzT6Lq"
Received: from mail-m19731105.qiye.163.com (mail-m19731105.qiye.163.com [220.197.31.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B952D052;
	Wed, 16 Jul 2025 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752632080; cv=none; b=ELacg1HbEF2OuqQBfryFPW2eobUJbzHCUMZeiFlRncABdmD6XV4R4/E5G8wUUezY/tzl6H1qkikwu8PiwDXlCMVbaG7UFsKSW3JEdzvQpODthaWvyIfbOcAN+2ebbyb73eVTdyOlTAcWX+deRDcNMntWOFPCjGRjiu/GDjXw2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752632080; c=relaxed/simple;
	bh=jrGwyN1RduzvZ7jeMJyqrFs8dr2ZTzT7n9MW6fKq/8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIZ1k+BusjbqKm+egWHpHqrmQ35ni8tMvqfn6QW2ZhMzoYSGIn8TSTxTUg65eLGuAlm63ShLlBuIi2q4pOQyt45m17NCoUTSvvsW7kSqUo/0mAbNFvQxU6pZOt0T2XzP6yIPdhvshfDfnwKES3wj8OJ0ZYmPO5NwoTtPPTSvL9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QAuzT6Lq; arc=none smtp.client-ip=220.197.31.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [127.0.0.1] (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c21ae026;
	Wed, 16 Jul 2025 09:38:51 +0800 (GMT+08:00)
Message-ID: <91933881-e91e-4e3f-a027-1a28a30823ed@rock-chips.com>
Date: Wed, 16 Jul 2025 09:38:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: rockchip: rk3399-evb-ind: Add support for
 DisplayPort
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
 <20250715112456.101-6-kernel@airkyi.com>
 <c62d168b-92b5-44a2-9a9a-402d7f4815a2@kernel.org>
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <c62d168b-92b5-44a2-9a9a-402d7f4815a2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQklOSlYeGE9NHU5DGE4eHk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0
	NVSktLVUpCWQY+
X-HM-Tid: 0a9810e26b8b03abkunm2384780b142b984
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PiI6Vjo4SDEzQgk3TgsMCwMQ
	Mj0wC1FVSlVKTE5JTUlCQk9LTUtNVTMWGhIXVRgTGhQCElUYEx4VOwkUGBBWGBMSCwhVGBQWRVlX
	WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSEJITTcG
DKIM-Signature:a=rsa-sha256;
	b=QAuzT6LqqsdRYzbgiQV0dzdyntiVHNrp/6t4TvOeZeNboxwtNUTzyldzugRxbhjyKOZ8NlArNywxKchxXvUB4wm/zoE9KD7sZsPgRwe0l9DPt4qQm7qka21rrg6UUIf7MziMjtmBrwi7GvrXQG91QQYTnAdRN0D9i1vZOrsBPi4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=hOSQSL8Ks5IN7rF3LDLzamVst2rGAcbD12z6Zr7VP7c=;
	h=date:mime-version:subject:message-id:from;

Hi Krzysztof,

On 2025/7/15 19:37, Krzysztof Kozlowski wrote:
> On 15/07/2025 13:24, Chaoyi Chen wrote:
>>   /dts-v1/;
>> +#include <dt-bindings/usb/pd.h>
>>   #include "rk3399.dtsi"
>>   
>>   / {
>> @@ -19,6 +20,16 @@ chosen {
>>   		stdout-path = "serial2:1500000n8";
>>   	};
>>   
>> +	vbus_typec: vbus-typec-regulator {
> use consistent naming. How other regulators are called? foo-regulator?

Will fix in v2.


>
>> +		compatible = "regulator-fixed";
>> +		enable-active-high;
>> +		gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vcc5v0_typec0_en>;
>> +		regulator-name = "vbus_typec";
>> +		vin-supply = <&vcc5v0_sys>;
>> +	};
>> +
>>   	vcc5v0_sys: regulator-vcc5v0-sys {
>>   		compatible = "regulator-fixed";
>>   		enable-active-high;
>> @@ -29,6 +40,16 @@ vcc5v0_sys: regulator-vcc5v0-sys {
>>   		regulator-max-microvolt = <5000000>;
>>   		regulator-min-microvolt = <5000000>;
>>   	};
>> +
>> +	sound: sound {
>> +		compatible = "rockchip,rk3399-gru-sound";
>> +		rockchip,cpu = <&i2s0 &spdif>;
>> +	};
>> +};
>> +
>> +&cdn_dp {
>> +	status = "okay";
>> +	phys = <&tcphy0_dp>;
>>   };
>>   
>>   &cpu_b0 {
>> @@ -341,6 +362,66 @@ regulator-state-mem {
>>   	};
>>   };
>>   
>> +&i2c4 {
>> +	i2c-scl-rising-time-ns = <475>;
>> +	i2c-scl-falling-time-ns = <26>;
>> +	status = "okay";
>> +
>> +	usbc0: fusb302@22 {
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Thank you for the explanation. Will fix in v2.


>
>
>> +		compatible = "fcs,fusb302";
>> +		reg = <0x22>;
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&usbc0_int>;
>> +		vbus-supply = <&vbus_typec>;
>> +		status = "okay";
> Why? What disabled it?

Oh, that is redundant. Will drop it in v2.


>
>> +
>> +		usb_con: connector {
>> +			compatible = "usb-c-connector";
>> +			label = "USB-C";
> Best regards,
> Krzysztof
>
>

