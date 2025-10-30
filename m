Return-Path: <linux-kernel+bounces-877633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB15C1EA15
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A47919C2387
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DC73074BA;
	Thu, 30 Oct 2025 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="aQQwn+va"
Received: from mail-m19731108.qiye.163.com (mail-m19731108.qiye.163.com [220.197.31.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA321ABAC;
	Thu, 30 Oct 2025 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807049; cv=none; b=AB6VH9LXn+t/0EzS22DcYYlttIzIXupXOJ4YxndyvGRWz3qGz3VaBRIbBzcN6R5s4a2bVihspmPcnru3q7t8Qm+dgyvfN063mNSO5n+gfoPJyFKqNFhc3KOyd/hnhOnbsCBDeSFNSdJmmjEmAY693nFtMTcIFQN4sqEu0FdOCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807049; c=relaxed/simple;
	bh=KFdC6+i2jqgKsEB/pvnx7H9NNfCX7ZYGZw3iw7qO1BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qt/DpOb4BHgxObnNAq7tDpsB+hKWVxVjKfiTJGuI0rURylci3b+F1q3YPnLBBsvfz1vPjvHJwhRW9CNtBEOjYncudZRADJ2kX2L3XfUFBZ8kSHTqZx5/kQiFajEfBB6GPQIweFvPBjvCJJfg9gPXrS4Bj5oeWIFB8Palbw2Aqqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=aQQwn+va; arc=none smtp.client-ip=220.197.31.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.149] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 27bf20e38;
	Thu, 30 Oct 2025 14:50:33 +0800 (GMT+08:00)
Message-ID: <e2fcc437-0650-4fdf-bb75-3463a80299fe@rock-chips.com>
Date: Thu, 30 Oct 2025 14:50:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/10] arm64: dts: rockchip: rk3399-evb-ind: Add
 support for DisplayPort
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Chaoyi Chen <kernel@airkyi.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
 <C6253E8254C80B0F+839b71d0-1bd8-40b7-9515-7ce4a1eb8673@airkyi.com>
 <CAL411-pULVu4AYybW9oW7kmr4M_kJhdytgBjLPb4y6w_2dj+0w@mail.gmail.com>
 <7853bbf0-34e5-4880-a2f4-2d73f25cd5e6@rock-chips.com>
 <CAL411-rFK0o_cxBO_yJFHWurGFKxZGxw6=kpqxRipMetJskTaQ@mail.gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <CAL411-rFK0o_cxBO_yJFHWurGFKxZGxw6=kpqxRipMetJskTaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a33e1e5d603abkunm4fdeafe247c99d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhoeTlZCTEtOQ0pKTk1CSUNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	5VSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=aQQwn+vaju0fkVYqlzGfwsD04Z6mA/IUGFwt2/LybJDUI6VkbH4gPP3HejyR9GH2oDyovSq2B+HP/lZguM+2DXuCAwhyjbvdkv8Sy0w8O/SXgQZqRujAaeLAQmJ0w9DPTEMHz7SyhBw9i5kJ4Bq+y9Ft8urfVEBjRCZLvy8wSI0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=sctOfaMCaVQx0TE/izjuKTlWuoHc1phPG68ypDI+DRY=;
	h=date:mime-version:subject:message-id:from;

On 10/30/2025 2:13 PM, Peter Chen wrote:

> On Thu, Oct 30, 2025 at 11:14 AM Chaoyi Chen <chaoyi.chen@rock-chips.com> wrote:
>> On 10/30/2025 10:50 AM, Peter Chen wrote:
>>
>>>>> Okay.  My question is basic: USB2 PHY supplies DP/DM, and the DP/DM is
>>>>> short for Type-C connector,
>>>>> and no control is needed for Type-C application.
>>>>> Why is there a remote-endpoint connection between USB2 PHY and Type-C connector?
>>>>    From the perspective of Type-C, this should not be added.  Is the approach in v2 correct [0] ?
>>>>
>>> Have you tried debugging based on upstream code?
>> Yes, I have tried both the v2 and v8 approaches, and both can work.
>>
>>
>>> v2 is correct, but the dts needs to improve.
>>> - There is a remote-endpoint connection for USB role switch between
>>> Type-C connector
>>> device and USB controller device
>>> - There is a remote-endpoint connection for orientation and lane configuration
>>> between Type-C connector device and USB/DP PHY device.
>> In v8 patch5, we implemented typec_mux and typec_switch in the USB/DP PHY.
>>
>> I think the current remote-endpoint connections are all child node of the USB/DP PHY. That is:
>>
>>
>> &tcphy0_dp {
>>       mode-switch;
>>       ...
>> };
>>
>>
>> &tcphy0_usb3 {
>>       orientation-switch;
>>       ...
>> };
>>
>>
>> Does this still need to be improved? Thank you.
>>
> Hi Chaoyi,
>
> There are two questions I have still not seen the answer to:
> - Why USB2 PHY is related to your Type-C patch?

I was just following other people's approach. Sorry, this should be removed from the dts.


> - How does the USB role switch event notify the USB controller driver, eg dwc3?

Sorry, I misunderstood what you said before. There is indeed a missing usb-role-switch now. I referred to the approach in rk3588-evb1-v10.dts. Is the following way of writing correct?

&usbc_connector {
     ports {
         #address-cells = <1>;
         #size-cells = <0>;

         port@0 {
             reg = <0>;

             usbc_orien_sw: endpoint {
                 remote-endpoint = <&tcphy0_typec_orien_sw>;
             };
         };

         port@1 {
             reg = <1>;

             usbc_role_sw: endpoint {
                 remote-endpoint = <&dwc3_0_role_switch>;
             };
         };


         port@2 {
             reg = <2>;

             usbc_dp: endpoint {
                 remote-endpoint = <&tcphy0_typec_dp>;
             };
         };
     };
};

&usbdrd_dwc3_0 {
     status = "okay";
     usb-role-switch;

     port {
         #address-cells = <1>;
         #size-cells = <0>;
         dwc3_0_role_switch: endpoint@0 {
             reg = <0>;
             remote-endpoint = <&usbc_role_sw>;
         };
     };
};

&tcphy0_usb3 {
     orientation-switch;

     port {
         tcphy0_typec_orien_sw: endpoint {
             remote-endpoint = <&usbc_orien_sw>;
         };
     };
};

&tcphy0_dp {
     mode-switch;

     port {
         #address-cells = <1>;
         #size-cells = <0>;

         tcphy0_typec_dp: endpoint@0 {
             reg = <0>;
             remote-endpoint = <&usbc_dp>;
         };
     };
};


> Peter
>>> Peter
>>>
>>>> [0]: https://lore.kernel.org/all/20250715112456.101-6-kernel@airkyi.com/
>>>>
>>>> Or is the following approach correct?
>>>>
>>>>
>>>> port@0 {
>>>>        reg = <0>;
>>>>
>>>>        usbc_hs: endpoint {
>>>>            remote-endpoint = <&tcphy0>;
>>>>        };
>>>> };
>>>>
>>>> port@1 {
>>>>        reg = <1>;
>>>>
>>>>        usbc_ss: endpoint {
>>>>            remote-endpoint = <&tcphy0>;
>>>>        };
>>>> };
>>>>
>>>> port@2 {
>>>>        reg = <2>;
>>>>
>>>>        usbc_dp: endpoint {
>>>>            remote-endpoint = <&tcphy0_typec_dp>;
>>>>        };
>>>> };
>>>>
>>>>
>>>>>>>>> +                               port@1 {
>>>>>>>>> +                                       reg = <1>;
>>>>>>>>> +
>>>>>>>>> +                                       usbc_ss: endpoint {
>>>>>>>>> + remote-endpoint = <&tcphy0_typec_ss>;
>>>>>>>>> +                                       };
>>>>>>>>> +                               };
>>>>>>>>> +
>>>>>>>>> +                               port@2 {
>>>>>>>>> +                                       reg = <2>;
>>>>>>>>> +
>>>>>>>>> +                                       usbc_dp: endpoint {
>>>>>>>>> + remote-endpoint = <&tcphy0_typec_dp>;
>>>>>>>>> +                                       };
>>>>>>>>> +                               };
>>>>>>>>> +                       };
>>>>>>>>> +               };
>>>>>>>>> +       };
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>> .....
>>>>>>>>>      &u2phy0 {
>>>>>>>>>             status = "okay";
>>>>>>>>> +
>>>>>>>>> +       port {
>>>>>>>>> +               u2phy0_typec_hs: endpoint {
>>>>>>>>> +                       remote-endpoint = <&usbc_hs>;
>>>>>>>>> +               };
>>>>>>>>> +       };
>>>>>>>>>      };
>>>>>>>>>
>>>>>>>> There is no switch and mux, how to co-work with Type-C?
>>>>>>> I checked the phy-rockchip-inno-usb2.c but did not find any switch or mux. Does this mean that we need to implement them? Thank you.
>>>>>> Wait a minute, actually we have multiple hardware interfaces, one of which is Type-C, eventually connected to USBDPPHY, and the other is micro-usb connected to U2PHY.
>>>>> I assume the Micro-USB connector does not use Type-C/PD IC, is it
>>>>> right? Does it relate to this patch?
>>>>>
>>>>> Best regards,
>>>>> Peter
>>>>>
>> --
>> Best,
>> Chaoyi
>>
>
-- 
Best,
Chaoyi


