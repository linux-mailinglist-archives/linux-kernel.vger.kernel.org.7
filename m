Return-Path: <linux-kernel+bounces-844025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87788BC0DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26E1D4F538E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776022D8363;
	Tue,  7 Oct 2025 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SS4qpDwa"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB42D6E64;
	Tue,  7 Oct 2025 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829041; cv=none; b=qr+gpUrXx++4XOLbhW01LplzzmlzD8X110SpfGUGMhmzr1+4V8bwn7JNlU4QDezPqcENyoFU3KjXce6OX3cIej1huj3eKQkvrabGu0fLJu8DNiSdVMgVMeqAWDAdcfofzUSUmSTSvBmg6SPfGJlcaUFRNM9wgSXE/pqTGAM7IcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829041; c=relaxed/simple;
	bh=C0Rmi9/ZF8JQ+C/kj+5uenpyVL0bJN5L8jlcLnWGOC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=evsPZgk890yf4Krmbf2CTJ+kHp8+XEFJiJN6NCWyASzVjlc9g32CiOpsV4HGPPKXO37Zy8JTMjuodtFF9otXxVfhb07PcKJnBVKd9h7fP0CoBWowr/yD1bwPVdLYY4G2CEOLQb+6/akfTqN7TBXaEFnWKAE83++/nGW27AnukKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SS4qpDwa; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5979No2W3731660;
	Tue, 7 Oct 2025 04:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759829030;
	bh=nfNXuTjguVwiBFAaPC3Z8FUDucM5kSOhplVJ5WEiNQ8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SS4qpDwayst7hg/H3eGubBAD4GyGfBUBKO6zKsqGVTOjvKf5ZF9wUK1+RSRfJm69R
	 PTARQRPOqh5jeVzbaBwNRT4akZKR0KYX/f4W9S4038nncnCNWWxg/2zKQS8WQD3KLF
	 raeJWT3CtdqBrNoGAyCo4F89s6laSpJuiMqPNVRU=
Received: from DFLE206.ent.ti.com (dfle206.ent.ti.com [10.64.6.64])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5979No34591270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Oct 2025 04:23:50 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Oct
 2025 04:23:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Oct 2025 04:23:50 -0500
Received: from [172.24.233.150] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.150])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5979Nk56904969;
	Tue, 7 Oct 2025 04:23:47 -0500
Message-ID: <2de3151b-eedc-4209-8b20-53473cafacef@ti.com>
Date: Tue, 7 Oct 2025 14:53:46 +0530
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
CC: <u-kumar1@ti.com>, <n-francis@ti.com>
References: <20250909080042.36127-1-g-praveen@ti.com>
 <20250909080042.36127-2-g-praveen@ti.com>
 <6faff5b1-65b1-41ee-aba8-8c06a2bc6f58@kernel.org>
 <9653740a-44fe-46bb-92c8-f7fc26cbe5ee@ti.com>
 <30101fb9-e2eb-4050-896a-7be629ced44d@kernel.org>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <30101fb9-e2eb-4050-896a-7be629ced44d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof,


On 07/10/25 12:05, Krzysztof Kozlowski wrote:
> On 26/09/2025 18:06, Gokul Praveen wrote:
>>>
>>>> +
>>>> +  ti,timers:
>>>> +    description: Timer instance phandle for the Capture
>>>
>>> So the only resource is phandle? That's completely fake device then. NAK.
>>>
>>
>>
>> The OMAP Timer IP can operate in 3 modes: Timer, PWM mode or capture
>> (mutually exclusive).
>> The timer/ti,timer-dm.yaml file describes the timer mode of operation.
>> It encapsulates base IP block and reg property is also part the same
>> binding.
>>
>> This node represents the capture mode with phandle reference to the
>> timer DT node. This is modeled all the same lines as how PWM
>> functionality is implemented in pwm/ti,omap-dmtimer-pwm.yaml
> 
> Different modes do not have their own device nodes. It is still one
> device, so one device node.
> 
>>
>> Now, if this needs to change, please suggest alternate.
>>
>> One solution is perhaps to add a new property to ti,timer-dm.yaml itself
>> to indicate the mode of IP?
> 
> Not sure, depends what this really is and how it is used. I can also
> imagine that consumer defines the mod of operation.
> 

For a timer operating in capture mode, there are no consumers actually 
and the only way we use it is through sysfs.

Would it be good enough if I have a separate "mode" property for the 
dmtimer device node just like how it is done for USB as follows where 
the usb device node has a "dr_mode" property to decide on whether the 
usb should act in host, device or otg mode.

&usb0 {
	status = "okay";
	dr_mode = "host";
};


> Or mode of operation could be even configured runtime, thus not suitable
> for DT at all.
> 
> Best regards,
> Krzysztof


