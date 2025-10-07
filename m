Return-Path: <linux-kernel+bounces-844066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38707BC0EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2F13C0F77
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796B46BF;
	Tue,  7 Oct 2025 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XUd2WSDY"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973F54279;
	Tue,  7 Oct 2025 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830583; cv=none; b=XmS9MnIxTl5L0LNg6XFV0bc4se9Apqrq4SUwZxBUEufkLcR4DrGTPQ/wqhrOd8oP2C8hKY2ShoJcmqLkv1Jqb6+qzRP9aBG9WjAvWwsC+s7ynq5f8dO6jRHTY5UVjzZJZqjNB+5bNTdA2GLmGeD6U3YsKJ0qsPQZtDnYACFr+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830583; c=relaxed/simple;
	bh=nK8MVajcF8pqPiScWREmhL5RpZREfmHDPX/kdFTajpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aO4xOx5ggvWiJQFON5PZiPGV2nCS0wXnBs5GI9vSOxMW/TJkEkhaWj8hcCcuw6g2rYvA53geyflETnaiWMmORoyMeIAf5kRV9C3++oCloyDSMMVTFV6+eyCcCDzj7rQHO6ce05M0VegNfKXjzKb/4Hz+I/uiBfkJz3myR6gFqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XUd2WSDY; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5979nc3c3800646;
	Tue, 7 Oct 2025 04:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759830578;
	bh=PmEVhmty6pdHDAAc4S5hjPUGsx/BQiuW3gvHO7TsUUI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XUd2WSDYq50Deh+BvEr4VCChbOqwKpIJknOsHSJOo1EPcjkqv/7p7CkNrxvAFwFQH
	 poYUqiCKvf4/AHzpFGeknmdPVoCZ6tDmmUAN35126wAkOLi/7VMNey/p6Xxq/8z5Zo
	 dNy0rMlo71CCKR7tN5hu2HhittVi23ftx3Pck6EM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5979nbHM3983719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 7 Oct 2025 04:49:38 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 7
 Oct 2025 04:49:37 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 04:49:37 -0500
Received: from [172.24.233.150] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.150])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5979nXR9695418;
	Tue, 7 Oct 2025 04:49:34 -0500
Message-ID: <20fd5c31-eb37-4f48-9774-62a05f416bab@ti.com>
Date: Tue, 7 Oct 2025 15:19:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: counter: Add new ti,omap-dmtimer-cap
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>, <wbg@kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, Gokul Praveen <g-praveen@ti.com>
References: <20250909080042.36127-1-g-praveen@ti.com>
 <20250909080042.36127-2-g-praveen@ti.com>
 <6faff5b1-65b1-41ee-aba8-8c06a2bc6f58@kernel.org>
 <9653740a-44fe-46bb-92c8-f7fc26cbe5ee@ti.com>
 <30101fb9-e2eb-4050-896a-7be629ced44d@kernel.org>
 <2de3151b-eedc-4209-8b20-53473cafacef@ti.com>
 <1561d6f5-bc60-4b41-aef5-3e22a23ee133@kernel.org>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <1561d6f5-bc60-4b41-aef5-3e22a23ee133@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof,

On 07/10/25 15:09, Krzysztof Kozlowski wrote:
> On 07/10/2025 18:23, Gokul Praveen wrote:
>> Hi Krzysztof,
>>
>>
>> On 07/10/25 12:05, Krzysztof Kozlowski wrote:
>>> On 26/09/2025 18:06, Gokul Praveen wrote:
>>>>>
>>>>>> +
>>>>>> +  ti,timers:
>>>>>> +    description: Timer instance phandle for the Capture
>>>>>
>>>>> So the only resource is phandle? That's completely fake device then. NAK.
>>>>>
>>>>
>>>>
>>>> The OMAP Timer IP can operate in 3 modes: Timer, PWM mode or capture
>>>> (mutually exclusive).
>>>> The timer/ti,timer-dm.yaml file describes the timer mode of operation.
>>>> It encapsulates base IP block and reg property is also part the same
>>>> binding.
>>>>
>>>> This node represents the capture mode with phandle reference to the
>>>> timer DT node. This is modeled all the same lines as how PWM
>>>> functionality is implemented in pwm/ti,omap-dmtimer-pwm.yaml
>>>
>>> Different modes do not have their own device nodes. It is still one
>>> device, so one device node.
>>>
>>>>
>>>> Now, if this needs to change, please suggest alternate.
>>>>
>>>> One solution is perhaps to add a new property to ti,timer-dm.yaml itself
>>>> to indicate the mode of IP?
>>>
>>> Not sure, depends what this really is and how it is used. I can also
>>> imagine that consumer defines the mod of operation.
>>>
>>
>> For a timer operating in capture mode, there are no consumers actually
>> and the only way we use it is through sysfs.
>>
>> Would it be good enough if I have a separate "mode" property for the
>> dmtimer device node just like how it is done for USB as follows where
>> the usb device node has a "dr_mode" property to decide on whether the
>> usb should act in host, device or otg mode.
> 
> 
> No, because of all my other comments in previous email.
> 
> 
Will having a separate sysfs property for enabling capture mode in 
dmtimer be a viable solution, which will then eliminate the need for a 
device tree property?

It would be great to hear your feedback on this, krzysztof.

Best regards
Gokul

> Best regards,
> Krzysztof


