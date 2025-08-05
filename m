Return-Path: <linux-kernel+bounces-756323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1992B1B2AE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA957AC938
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEC6259CB9;
	Tue,  5 Aug 2025 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QO3VG4Co"
Received: from mail-m15571.qiye.163.com (mail-m15571.qiye.163.com [101.71.155.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BCA2F30;
	Tue,  5 Aug 2025 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754394174; cv=none; b=ugsY06mJhkK/CLp4AQNBWMwBaiudH4+9lSzQtZNVioeK3XEUWLlURC3bPeO6v1tsBf/0ED/4QhXIGHmGf/XrTHYy3HG8TK7cZbVKx9kmHzekb50G3YOQwx5utVsAv83PNMlMytE7w3TUK+1WxBoOwqJPvjCxj0GHlHkb0qBxTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754394174; c=relaxed/simple;
	bh=L5ldlbFu5pDoOtnpE4tyXKBO8AqpD2Fapi9uut7eKq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+kq8zUAGBhRj3E80EKpRgmQMLHKIvAVL8cvfb5UilxW0P3rJDrDOUPg2YAROTRPKR+kjTUXe9QnJYTuiuCfrEqwSekGafdYlWvEUvEwYL9/ym8Xkce/bg99WPanWeyoUe+yV6G4KjZoRbrHXRfFcaR0tM8NFMQMwwApl/lUlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QO3VG4Co; arc=none smtp.client-ip=101.71.155.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (gy-adaptive-ssl-proxy-3-entmail-virt135.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1e5e73aa8;
	Tue, 5 Aug 2025 19:07:10 +0800 (GMT+08:00)
Message-ID: <a7988745-ea31-45cd-8ffd-905e6e4d1315@rock-chips.com>
Date: Tue, 5 Aug 2025 19:07:09 +0800
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
 <f726862a-bd18-43ee-b307-8daef2451e6b@rock-chips.com>
 <6nfmxwtwcvuyo2jaao7fele7jcgcykfpy7czbcbjmjxv7cs5sc@dmbtot73kw63>
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <6nfmxwtwcvuyo2jaao7fele7jcgcykfpy7czbcbjmjxv7cs5sc@dmbtot73kw63>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9879e9ebce03abkunm2a7119d6701883
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGksaS1YZHR1IHR8ZTUoZGRpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QO3VG4Co4nsteQv8Qv57Hfls+cf5t683+xOusxx1peKmZ26y3oXrzV2n1Yh8IPkMsUuZPGO92FYmZYsqJJuvr7R1Do+nJTWWLEytFOuX7IY7byJ2OCGPylXYwmvRz5z63+IDQxi0wCeE+ZhGlRNJmm2zpuZgUlf2I/6B0gWLdlA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=DcI3MBPSj0BIlngssBgBDQc0EsKF1spVCU2qV220AlE=;
	h=date:mime-version:subject:message-id:from;

On 8/5/2025 6:44 PM, Dmitry Baryshkov wrote:

> On Tue, Aug 05, 2025 at 02:32:17PM +0800, Chaoyi Chen wrote:
>> Hi Dmitry,
>>
>> On 8/5/2025 12:26 PM, Dmitry Baryshkov wrote:
>>> On 05/08/2025 09:13, Chaoyi Chen wrote:
>>>> Hi Dmitry,
>>>>
>>>> On 8/2/2025 5:55 PM, Dmitry Baryshkov wrote:
>>>>
>>>> [...]
>>>>
>>>>
>>>>>>>> BTW, one of the important things to do is to implement extcon-like
>>>>>>>> notifications. I found include/drm/bridge/aux-bridge.h , but if the
>>>>>>>> aux-bridge is used, the bridge chain would look like this:
>>>>>>>>
>>>>>>>> PHY0 aux-bridge ---+
>>>>>>>>                       | ----> CDN-DP bridge
>>>>>>>> PHY1 aux-bridge ---+
>>>>>>>>
>>>>>>>> Oh, CDN-DP bridge has two previous aux-bridge!
>>>>>>>>
>>>>>>>> Now, I try to use drm_connector_oob_hotplug_event() to notify HPD
>>>>>>>> state between PHY and CDN-DP controller.
>>>>>>> Does it actually work? The OOB HPD event will be repoted
>>>>>>> for the usb-c
>>>>>>> connector's fwnode, but the DP controller isn't
>>>>>>> connected to that node
>>>>>>> anyhow. If I'm not mistaken, the HPD signal will not
>>>>>>> reach DP driver in
>>>>>>> this case.
>>>>>> Yes.  What you mentioned is the case in
>>>>>> drivers/usb/typec/altmodes/displayport.c . I have also added
>>>>>> a new OOB event
>>>>>> notify in the PHY driver in Patch 3, where the expected
>>>>>> fwnode is used in
>>>>>> the PHY. So now we have two OOB HPD events, one from
>>>>>> altmodes/ displayport.c
>>>>>> and the other from PHY. Only the HPD from PHY is eventually
>>>>>> passed to the DP
>>>>>> driver.
>>>>> This way you will loose IRQ_HPD pulse events from the DP. They are used
>>>>> by DPRX (aka DP Sink) to signal to DPTX (DP Source) that there was a
>>>>> change on the DPRX side and the DPTX should reread link params
>>>>> and maybe
>>>>> retrain the link.
>>>> Sorry, I still don't quite understand your point. I think the entire
>>>> notification path is as follows:
>>>>
>>>> Type-C mux callback -> RK3399 USBDP PHY -> PHY calls
>>>> drm_connector_oob_hotplug_event() -> DP driver
>>>>
>>>> Are you concerned that the IRQ_HPD event is not being handled
>>>> somewhere along the path? Is it that the Type-C mux callback didn't
>>>> notify the PHY, or that after the PHY passed the event to the DP
>>>> driver via the OOB event, the DP driver didn't handle it?
>>> The IRQ_HPD is an event coming from DPRX, it is delivered as a part of
>>> the attention VDM, see DP_STATUS_IRQ_HPD. It's being handled by the
>>> altmode displayport.c driver and is then delivered as an OOB hotplug
>>> call. However, it's not a mux event, so it is not (and it should not)
>>> being broadcasted over the typec_mux devices.
>>>
>>> The way we were handling that is by having a chain of drm_aux_bridges
>>> for all interim devices, ending up with a drm_dp_hpd_bridge registered
>>> by the TCPM. This way when the DPRX triggers the IRQ_HPD event, it is
>>> being handled by the displayport.c and then delivered through that
>>> bridge to the DP driver.
>> I think the issue goes back to the beginning. The key is to reuse the logic
>> in displayport.c, and the previous approach of directly setting the fwnode
>> has already been rejected. Is it a good idea to register the aux hpd bridge
>> in displayport.c? In this way, we don't need to register it with a bunch of
>> PD drivers (such as fusb302), which seems like a more generic solution.
> displayport.c comes into play only when you actually attach a DP dongle,
> which is too late for bringing up the display pipeline. But your point
> is valid, it might be worth moving drm_dp_hpd registration to
> typec_port_register_altmode().

Very insightful, thank you! I will try to do this in v4 :)



