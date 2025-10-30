Return-Path: <linux-kernel+bounces-877437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 538C4C1E1C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CDD1F34D791
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595BB29A310;
	Thu, 30 Oct 2025 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="hqDb4x3b"
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604D17B50A;
	Thu, 30 Oct 2025 02:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761790623; cv=none; b=SuJuerwjXuXRn60Ps/J0dJfeVBCw75Mh7Povq/PJTwebQMlXkprwkJpQaCcYPbWP2r/hwOVaOJVN7ltbZBBbAw7z7q8WQN0oLcBP/ZlOhT6Rib3sbshlQb2Vklm3MnjPiMztDuuJqXziwhkU64HKhMjxcPkHO+TOuOzyYLHib4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761790623; c=relaxed/simple;
	bh=/mzCdVqHEvL3D3Yi6YRm22qJsNK9CIh6ANT7cZjG5f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHtMp7wePP0OfAjZ0KyRTfWTbnS+Vv6Xr9i/fG0HxGhX7OhcgBvDxazlktB3tLTnXm/WTWRaGS4k8mQmEkzc5KaN3hu36Kt2m5lQz/bAimvBhISXYtLBqDIHqiQ7B1AYsT5EAUGMlM9mUiBemZ91HqgXU5i0x1KIcBh7/gUKiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=hqDb4x3b; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1761790616;
	bh=dRHxWofqNvre4c7gYW9pSN8OyvpdSlasaGgbf/HjiS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=hqDb4x3bszkhD0yyEXpcid4LlIz+kWi3sYR1De5R6ckCAJCXUVV9cz3Z0D/ctvfFN
	 e1Wkb8GXkC+aamS1Zj8apEwEghfmXIL0EFyhoPiyckDUKJgewOIcUkZcUHW9KSTFVh
	 pPl/YHdSSL5+4z/22Yzf3SpVctE08YK9eMahFoeU=
X-QQ-mid: esmtpsz21t1761790610t2286961f
X-QQ-Originating-IP: FCJSyEhyWxQkXT6SGDOtofz4EUe9Cd81eY6Os229Qyg=
Received: from [172.16.12.149] ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Oct 2025 10:16:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1275723360735953640
Message-ID: <C6253E8254C80B0F+839b71d0-1bd8-40b7-9515-7ce4a1eb8673@airkyi.com>
Date: Thu, 30 Oct 2025 10:16:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/10] arm64: dts: rockchip: rk3399-evb-ind: Add
 support for DisplayPort
To: Peter Chen <hzpeterchen@gmail.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>, Dragan Simic <dsimic@manjaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
References: <20251029071435.88-1-kernel@airkyi.com>
 <20251029071435.88-11-kernel@airkyi.com>
 <CAL411-o6mF71oBeRsJ-OPZNbLegn4iJ_ELN9xVdppTM3ssUPOw@mail.gmail.com>
 <cc8b583a-77ec-4a7f-97cc-2d148f7fee9f@rock-chips.com>
 <e0c5bda3-7428-49e0-9955-fa23f1e4f35d@rock-chips.com>
 <CAL411-oXfvp-iqN+uRmFHijdmW=1omKwozKOoZ2shxukMHmwPg@mail.gmail.com>
Content-Language: en-US
From: Chaoyi Chen <kernel@airkyi.com>
In-Reply-To: <CAL411-oXfvp-iqN+uRmFHijdmW=1omKwozKOoZ2shxukMHmwPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mzgy3+ovZurwXmt9VpysjQYs7i6RCY+CjEOjVuNDMu+YT3AbFRGFg97W
	Y+Gd3dTHLF3PSGmuOQhjWsflgqGBi1Xpf9dfmH9C4o9L03njp8/uwKvwB8CTdGZyomoN19e
	A/9aoDeCVnUGYqqTEO7CDTVYGQELcsKe3PNLemj5slJFwOgYrK34V9WVRTla27VuwEWYGlG
	ctQudMFauBVMwKdTWBqKmb4Oo/kflYNIaOg0TUE7jgOZQCDzgAFMVfWFQR4HRRfMqBxS/hX
	/wz5slbRIm9D7FlqoGiDLzTPMLSAaV8Bo43LUl/isEo/NUKm41R1n9O4uDUNuKJyM62AKUD
	18JVnPlJgFHjM7M51uM3fCdj1FkqL1+VrI65z95aNQpnA5xq6bnMqI5AmOPnWpYfocFG2EG
	R9WJ3WqOMgakanCqElF/eirLe7MHSTMe9rs5R1FPGz+ra77pwlM0Ci3+YhI0GExPL+sKh6+
	EtbkgleOQiNvRWJPGbEIOADJ9LhbkODHvf9eW8Nkj+HJG0DKNkjWPYl6FxHlN9KCidah+wC
	Jx008E/TUah1o9rJZhVMFJwYnMx1MieIDjZLyxrgggWn2JS9+Ei9m2pTnbrBg6qRyBsQ0nt
	P2Gt4EGeCaB9OQX7vCdDfAUd3ZjVJCeiZGtYOnkhj9Ec8W0gLX7sWysdIdF+gkQurq5IwWZ
	oa1Wx565e614rNwzm6qG+drDFlPnlUUaGWHHWKKpya28a8z1AV/2PSq15zqKcqouzAnD3Sc
	IaUnJTHS0GIljbz0zZ73u0buLeb+89Dnc0jf0FlkeaUXSoNHN+Iqy/MaJTHCPwV1Z08W1TF
	cHeF2La887WIyVT7ad88hgHHCplZXUxMVMGxuv9HDQ7lMF3Z7+KdgKRxZzR2F6GZHPjCt7D
	RTM9aJ9y7VUPm8yL0c/ionzq2RHSdEQyDP/s3tz+nQBN+DtEV+eNF4VVhIBU5faCCAB5lcz
	N2OIuA9v7QQQPNDyYm9sE2p+mDm+37dX1yidstQo1Ew8O+cBihdf38LLM/iBXgFHl5ldy2C
	icb3Xizw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Hi Peter,

On 10/30/2025 9:34 AM, Peter Chen wrote:
> On Wed, Oct 29, 2025 at 6:32 PM Chaoyi Chen <chaoyi.chen@rock-chips.com> wrote:
>> On 10/29/2025 6:21 PM, Chaoyi Chen wrote:
>>
>>> Hi Peter,
>>>
>>> On 10/29/2025 5:45 PM, Peter Chen wrote:
>>>>> +&i2c4 {
>>>>> +       i2c-scl-rising-time-ns = <475>;
>>>>> +       i2c-scl-falling-time-ns = <26>;
>>>>> +       status = "okay";
>>>>> +
>>>>> +       usbc0: typec-portc@22 {
>>>>> +               compatible = "fcs,fusb302";
>>>>> +               reg = <0x22>;
>>>>> +               interrupt-parent = <&gpio1>;
>>>>> +               interrupts = <RK_PA2 IRQ_TYPE_LEVEL_LOW>;
>>>>> +               pinctrl-names = "default";
>>>>> +               pinctrl-0 = <&usbc0_int>;
>>>>> +               vbus-supply = <&vbus_typec>;
>>>>> +
>>>>> +               usb_con: connector {
>>>>> +                       compatible = "usb-c-connector";
>>>>> +                       label = "USB-C";
>>>>> +                       data-role = "dual";
>>>>> +                       power-role = "dual";
>>>>> +                       try-power-role = "sink";
>>>>> +                       op-sink-microwatt = <1000000>;
>>>>> +                       sink-pdos =
>>>>> +                               <PDO_FIXED(5000, 2500, PDO_FIXED_USB_COMM)>;
>>>>> +                       source-pdos =
>>>>> +                               <PDO_FIXED(5000, 1500, PDO_FIXED_USB_COMM)>;
>>>>> +
>>>>> +                       altmodes {
>>>>> +                               displayport {
>>>>> +                                       svid = /bits/ 16 <0xff01>;
>>>>> +                                       vdo = <0x00001c46>;
>>>>> +                               };
>>>>> +                       };
>>>>> +
>>>>> +                       ports {
>>>>> +                               #address-cells = <1>;
>>>>> +                               #size-cells = <0>;
>>>>> +
>>>>> +                               port@0 {
>>>>> +                                       reg = <0>;
>>>>> +
>>>>> +                                       usbc_hs: endpoint {
>>>>> + remote-endpoint = <&u2phy0_typec_hs>;
>>>>> +                                       };
>>>>> +                               };
>>>>> +
>>>> Why USB2 PHY needs to be notified for Type-C connection?
>>> I think the USB-connector binding require a port@0 for High Speed.  So I filled in USB2 PHY here. And I have looked up boards with the same usage, and some of the results are as follows:
>>>
>>> - rk3399-firefly.dts
>>>
>>> - rk3399-pinebook-pro.dts
>>>
>>> - rk3399-eaidk-610.dts
>>>
> Okay.  My question is basic: USB2 PHY supplies DP/DM, and the DP/DM is
> short for Type-C connector,
> and no control is needed for Type-C application.
> Why is there a remote-endpoint connection between USB2 PHY and Type-C connector?

 From the perspective of Type-C, this should not be added.  Is the approach in v2 correct [0] ?

[0]: https://lore.kernel.org/all/20250715112456.101-6-kernel@airkyi.com/

Or is the following approach correct?


port@0 {
     reg = <0>;

     usbc_hs: endpoint {
         remote-endpoint = <&tcphy0>;
     };
};

port@1 {
     reg = <1>;

     usbc_ss: endpoint {
         remote-endpoint = <&tcphy0>;
     };
};

port@2 {
     reg = <2>;

     usbc_dp: endpoint {
         remote-endpoint = <&tcphy0_typec_dp>;
     };
};


>
>>>>> +                               port@1 {
>>>>> +                                       reg = <1>;
>>>>> +
>>>>> +                                       usbc_ss: endpoint {
>>>>> + remote-endpoint = <&tcphy0_typec_ss>;
>>>>> +                                       };
>>>>> +                               };
>>>>> +
>>>>> +                               port@2 {
>>>>> +                                       reg = <2>;
>>>>> +
>>>>> +                                       usbc_dp: endpoint {
>>>>> + remote-endpoint = <&tcphy0_typec_dp>;
>>>>> +                                       };
>>>>> +                               };
>>>>> +                       };
>>>>> +               };
>>>>> +       };
>>>>> +};
>>>>> +
>>>> .....
>>>>>    &u2phy0 {
>>>>>           status = "okay";
>>>>> +
>>>>> +       port {
>>>>> +               u2phy0_typec_hs: endpoint {
>>>>> +                       remote-endpoint = <&usbc_hs>;
>>>>> +               };
>>>>> +       };
>>>>>    };
>>>>>
>>>> There is no switch and mux, how to co-work with Type-C?
>>> I checked the phy-rockchip-inno-usb2.c but did not find any switch or mux. Does this mean that we need to implement them? Thank you.
>> Wait a minute, actually we have multiple hardware interfaces, one of which is Type-C, eventually connected to USBDPPHY, and the other is micro-usb connected to U2PHY.
> I assume the Micro-USB connector does not use Type-C/PD IC, is it
> right? Does it relate to this patch?
>
> Best regards,
> Peter
>


