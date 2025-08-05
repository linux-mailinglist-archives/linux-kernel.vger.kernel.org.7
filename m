Return-Path: <linux-kernel+bounces-756049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF3BB1AF2A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D79B7A3C98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263B922DA1C;
	Tue,  5 Aug 2025 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HLMeHboF"
Received: from mail-m49207.qiye.163.com (mail-m49207.qiye.163.com [45.254.49.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1422D4C0;
	Tue,  5 Aug 2025 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377684; cv=none; b=JtwgLf23Uc+l1Wo9cEYynqD2UIWNm/C0YmTBAyBfe8iQwbYbJRsCyEXfbPeFRCNSUoXlIoJxDqj13C4Jyt0pohR4Ua7mU/0lUNRpBRde1syRXiybf3IXqsqjioaJAKLnWZZkQ9gXIpDb+j4v+4nvgvE9v2UsiUXFfsW+AaMWi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377684; c=relaxed/simple;
	bh=txeMeTM1K1fU0841wKd2zS/Can/n/pBvJI//WUzOV0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWc2HOS1g9E2hMPMw7/2KdK6enVU3oL0MgZc3DhNgbItJ03w2TR8YqQvUWu2eUFbrMCXdHuj7G2B6lFpmfe6uy5p6G3IdUzSfg0Y4wKRDMZhvAPSBBRLOKCT1L80B5MRLhT+IgkjmWV3VAdQoC65kNgkpXQXjVVl3FaKYlVEqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HLMeHboF; arc=none smtp.client-ip=45.254.49.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1e545294d;
	Tue, 5 Aug 2025 14:32:18 +0800 (GMT+08:00)
Message-ID: <f726862a-bd18-43ee-b307-8daef2451e6b@rock-chips.com>
Date: Tue, 5 Aug 2025 14:32:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add Type-C DP support for RK3399 EVB IND board
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 Peter Robinson <pbrobinson@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
References: <20250729090032.97-1-kernel@airkyi.com>
 <3kefqzjewmsyzfvyi33kvlgjd6jphjg3fsnixb3of7yb3xkgs2@hgi6xfkgd653>
 <63ec11cf-7927-431a-995e-a5fc35ef1ba7@rock-chips.com>
 <pk5wecbbpxn7v4bdwtghhdnm76fmrmglelytljwfb4cgvpu2i6@rk5turgyt5xq>
 <0207826d-a987-4464-b306-29bdbfac45bc@rock-chips.com>
 <3e880194-5ac8-4056-929c-ac103bedc737@oss.qualcomm.com>
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <3e880194-5ac8-4056-929c-ac103bedc737@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9878ee449203abkunm21aca6f168f34c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1OQlZNGE9ITU9JS0kYThhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=HLMeHboFPO9wilguf8Zww8hXY4kbZfK9VFChLUgfBMO8X5hUaMfgVTyd06GEiVyB5KDQckmsuLy2uIYRxl3vsF4giA/oylz5ntb+gbaaVKjwwRowlrEkDLe/4llvgSnl7ioQdUFDYOTlUb1y1uFWNDDmWoAcEGyenpvv0wyxVLo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=OBvhoezUSc7NI8tAcl9t1xhx6CLTBuvUQsqUuAHfhvo=;
	h=date:mime-version:subject:message-id:from;

Hi Dmitry,

On 8/5/2025 12:26 PM, Dmitry Baryshkov wrote:
> On 05/08/2025 09:13, Chaoyi Chen wrote:
>> Hi Dmitry,
>>
>> On 8/2/2025 5:55 PM, Dmitry Baryshkov wrote:
>>
>> [...]
>>
>>
>>>> Currently, the software simply selects the first available port. So 
>>>> if user
>>>> plugs in DP dongles in both USB-C ports, the DP driver will select 
>>>> the first
>>>> port. This process is implemented in cdn_dp_connected_port() .
>>>>
>>> I think Stephen Boyd has been looking on similar issues for 
>>> Chromebooks,
>>> which were sharing DP controller between several USB-C ports. I don't
>>> remember what was his last status. I think there it was easier since 
>>> the
>>> bifurcation point was the EC.
>>
>> I think the latest progress should be here: [0]. It seems that it 
>> hasn't been updated for a while.
>
> Might be :-(
>
>>
>> [0]: https://lore.kernel.org/all/20240901040658.157425-1- 
>> swboyd@chromium.org/
>>
>>
>>>
>>> I think, CDN-DP needs to register up to two encoders and up to two
>>> connectors, having a separate drm_bridge chain for each of the DP
>>> signals paths (in the end, you can not guarantee that both branches 
>>> will
>>> have the same simple CDN-DP -> PHY -> USB-C configuration: there can be
>>> different retimers, etc).
>>>
>>> Both encoders should list the same CRTC in possible_crtcs, etc. Of
>>> course, it should not be possible to enable both of them.
>>>
>>> This way if the user plugs in two DP dongles, it would be possible to
>>> select, which output actually gets a signal.
>>
>> That makes sense, but this might make the DP driver quite complex. I 
>> will see if I can make it happen.
>
> I think it's trading one burden for another, because CDN-DP currently 
> has a complication of calling cdn_dp_get_port_lanes() / 
> cdn_dp_enable_phy() in a loop rather than just enabling one instance.

Yep, I will give it a try.


>
>>
>>
>>>
>>>>
>>>>>> BTW, one of the important things to do is to implement extcon-like
>>>>>> notifications. I found include/drm/bridge/aux-bridge.h , but if the
>>>>>> aux-bridge is used, the bridge chain would look like this:
>>>>>>
>>>>>> PHY0 aux-bridge ---+
>>>>>>                      | ----> CDN-DP bridge
>>>>>> PHY1 aux-bridge ---+
>>>>>>
>>>>>> Oh, CDN-DP bridge has two previous aux-bridge!
>>>>>>
>>>>>> Now, I try to use drm_connector_oob_hotplug_event() to notify HPD
>>>>>> state between PHY and CDN-DP controller.
>>>>> Does it actually work? The OOB HPD event will be repoted for the 
>>>>> usb-c
>>>>> connector's fwnode, but the DP controller isn't connected to that 
>>>>> node
>>>>> anyhow. If I'm not mistaken, the HPD signal will not reach DP 
>>>>> driver in
>>>>> this case.
>>>> Yes.  What you mentioned is the case in
>>>> drivers/usb/typec/altmodes/displayport.c . I have also added a new 
>>>> OOB event
>>>> notify in the PHY driver in Patch 3, where the expected fwnode is 
>>>> used in
>>>> the PHY. So now we have two OOB HPD events, one from altmodes/ 
>>>> displayport.c
>>>> and the other from PHY. Only the HPD from PHY is eventually passed 
>>>> to the DP
>>>> driver.
>>> This way you will loose IRQ_HPD pulse events from the DP. They are used
>>> by DPRX (aka DP Sink) to signal to DPTX (DP Source) that there was a
>>> change on the DPRX side and the DPTX should reread link params and 
>>> maybe
>>> retrain the link.
>>
>> Sorry, I still don't quite understand your point. I think the entire 
>> notification path is as follows:
>>
>> Type-C mux callback -> RK3399 USBDP PHY -> PHY calls 
>> drm_connector_oob_hotplug_event() -> DP driver
>>
>> Are you concerned that the IRQ_HPD event is not being handled 
>> somewhere along the path? Is it that the Type-C mux callback didn't 
>> notify the PHY, or that after the PHY passed the event to the DP 
>> driver via the OOB event, the DP driver didn't handle it?
>
> The IRQ_HPD is an event coming from DPRX, it is delivered as a part of 
> the attention VDM, see DP_STATUS_IRQ_HPD. It's being handled by the 
> altmode displayport.c driver and is then delivered as an OOB hotplug 
> call. However, it's not a mux event, so it is not (and it should not) 
> being broadcasted over the typec_mux devices.
>
> The way we were handling that is by having a chain of drm_aux_bridges 
> for all interim devices, ending up with a drm_dp_hpd_bridge registered 
> by the TCPM. This way when the DPRX triggers the IRQ_HPD event, it is 
> being handled by the displayport.c and then delivered through that 
> bridge to the DP driver.

I think the issue goes back to the beginning. The key is to reuse the 
logic in displayport.c, and the previous approach of directly setting 
the fwnode has already been rejected. Is it a good idea to register the 
aux hpd bridge in displayport.c? In this way, we don't need to register 
it with a bunch of PD drivers (such as fusb302), which seems like a more 
generic solution.



