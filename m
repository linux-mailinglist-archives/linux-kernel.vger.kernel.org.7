Return-Path: <linux-kernel+bounces-683114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA827AD692E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 09:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B5518870C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F37F21147B;
	Thu, 12 Jun 2025 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YtJi7zzt"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B1C1F12F6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713711; cv=none; b=Jsos6dHsrHPm/2nvBr8B8/dw9ExXCku+FwBHGXw/EzFmlmpIhZ/15qKSZxVlIa5fqNv/H9tT8y4Ytnlhy2q+R66v7EWWl8ncABD7aomWzl2hREah+JaGT+DpQGgPAftaM6rN6zEkAJIPB8lM9YGgX827I3XOhN2T0DiYtxAvFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713711; c=relaxed/simple;
	bh=FXZ9bhH+BLLLl4nJRU+nUNnCam5qUFLuJJuygGh/Na0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ORV7/n/W0LXor4MdheY9pyg0ixJBp1lqnncrK+63LpX+5Mw5sygHsieXOxad79GRVODi8U3AeiGVOKDX3Ev0hHn4T/9yCK1G31LQdMBESxdz/TMp3n44ZkXLACg3RTlx3ON5KhTjHDRTaNGDe+XF0Smzm1jw/eGxPVNYRzX8EFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YtJi7zzt; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C7YotS2803952;
	Thu, 12 Jun 2025 02:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749713690;
	bh=y+SxmXMBIixJUqhr8/6PjgF8JavGa38wPXzRB7ZzE+4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YtJi7zztG8qGrLoiEpIHXrR7NNwIW74ihmj+1Ln0ANs3v0Ctz7EyOwlio7GUUXLLg
	 us6sf76kipjOu7Xwg5+EQ652EJv/G/xFfsrQrHTwSTqcDQLoEVG/JGG2fnsfjHAmv+
	 /PNcNqJme7i3Fo/tsGCtX/7Wd2+gKxQqFtH0h0/g=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C7YnZv2392385
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 12 Jun 2025 02:34:49 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Jun 2025 02:34:49 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 12
 Jun 2025 02:34:49 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Jun 2025 02:34:49 -0500
Received: from [172.24.227.14] (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.14])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C7YibL1802508;
	Thu, 12 Jun 2025 02:34:45 -0500
Message-ID: <affbef6e-f253-4dbb-bf64-3cc7d244acbb@ti.com>
Date: Thu, 12 Jun 2025 13:04:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: fix REFCLK setting
To: Michael Walle <mwalle@kernel.org>, Doug Anderson <dianders@chromium.org>
CC: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "Jernej
 Skrabec" <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20250528132148.1087890-1-mwalle@kernel.org>
 <CAD=FV=WfV1Kr5hFSqf=t0OS3qFSGfQ3_+LQ-57nMKHXRSYvZ-w@mail.gmail.com>
 <9272e36e-e764-4007-9d9e-8e09b9c08d34@ti.com>
 <c0027ff0e63bcc0fd21aab37af991baf@kernel.org>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <c0027ff0e63bcc0fd21aab37af991baf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Michael,

On 10/06/25 12:45, Michael Walle wrote:
> Hi Jayesh,
> 
>>>> +       /*
>>>> +        * After EN is deasserted and an external clock is detected, 
>>>> the bridge
>>>> +        * will sample GPIO3:1 to determine its frequency. The 
>>>> driver will
>>>> +        * overwrite this setting. But this is racy. Thus we have to 
>>>> wait a
>>>> +        * couple of us. According to the datasheet the GPIO lines 
>>>> has to be
>>>> +        * stable at least 5 us (td5) but it seems that is not 
>>>> enough and the
>>>> +        * refclk frequency value is lost/overwritten by the bridge 
>>>> itself.
>>>> +        * Waiting for 20us seems to work.
>>>> +        */
>>>> +       usleep_range(20, 30);
>>>
>>> It might be worth pointing at _where_ the driver overwrites this
>>> setting, or maybe at least pointing to something that makes it easy to
>>> find which exact bits you're talking about.
> 
> Yeah, Jayesh just pointed that out below. I'll add add it to the comment.
> 
>>> This looks reasonable to me, though.
>>
>> I think we are talking about SN_DPPLL_SRC_REG[3:1] bits?
> 
> Yes.
> 
>> What exact mismatch are you observing in register value?
> 
> The one set by the chip itself vs the one from the driver, see below.
> 
>> I am assuming that you have a clock at REFCLK pin. For that:
> 
> Yes, I'm using an external clock.
> 
>> If refclk is described in devicetree node, then I see that
>> the driver modifies it in every resume call based solely on the
>> clock value in dts.
> 
> Exactly. But that is racy with what the chip itself is doing. I.e.
> if you don't have that usleep() above, the chip will win the race
> and the refclk frequency setting will be set according to the
> external GPIOs (which is poorly described in the datasheet, btw),
> regardless what the linux driver is setting (because that I2C write
> happens too early).

I am a little confused here.
Won't it be opposite?
If we have this delay here, GPIO will stabilize and set the register
accordingly?

In the driver, I came across the case when we do not have refclk.
(My platform does have a refclk, I am just removing the property from
the dts node to check the affect of GPIO[3:1] in question because clock
is not a required property for the bridge as per the bindings)

In the ti_sn65dsi86_probe(), before we read SN_DEVICE_ID_REGS,
when we go to resume(), we do not do enable_comms() that calls
ti_sn_bridge_set_refclk_freq() to set SN_DPPLL_SRC_REG.
I see that register read for SN_DEVICE_ID_REGS fails in that case.

Adding this delay fixes that issue. This made me think that we need
the delay for GPIO to stabilize and set the refclk.

Is my understanding incorrect?

I am totally on board with your change especially after observing the
above but is my understanding incorrect somewhere?

Warm Regards,
Jayesh

> 
>> If refclk is not described in dts, then this register is modified by the
>> driver only when pre_enable() calls enable_comms(). Here also, the
>> value depends on crtc_mode and the refclk_rate often would not be equal
>> to the values in "ti_sn_bridge_dsiclk_lut" (supported frequencies), and
>> you would fallback to "001" register value.
> 
>> Rest of time, I guess it depends on reading the status from GPIO and
>> changing the register.
> 
> Not "rest of the time", the reading of the strapping option from the
> GPIO always happens if an external refclk is detected. It's part of
> the chip after all. It will just sometimes be overwritten by the
> linux driver.
> 
>> Is the latter one your usecase?
> 
> My use case is that the GPIO setting is wrong on my board (it's really
> non-existent) and I'm relying on the linux driver to set the correct
> frequency.
> 
> HTH,
> -michael

