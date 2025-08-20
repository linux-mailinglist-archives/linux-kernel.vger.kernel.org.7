Return-Path: <linux-kernel+bounces-776822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B01FB2D1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDE31C24B48
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3348C21CC49;
	Wed, 20 Aug 2025 02:17:55 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA32202F8B;
	Wed, 20 Aug 2025 02:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755656274; cv=none; b=GvAZINxQnfbyEy+4QwDW3aOQOAG9FbkpQfM7hFGeA9LcZOAd18peMnFP48gClxZxGaER75t2Nr0kUVBOeRKBilch/OQyTGjiAhPBxNzrYo1oOf+CSj33irRhPzFs8x+MaudBiMpv5vvYnJEQOIPuwXu9Yb87EI4tKKbPv54s5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755656274; c=relaxed/simple;
	bh=CtjNduMpa6vBd17voRHpTk9aBOQS+GxxSurGRGrOvL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9+Y0ZPHTClBnZ2fcpWc4pV/7+3Zm1P4SYH9GsbB9UIenOIOO7Vp45557vl+VqArdQ1nHx6Nr+ZlnlkI4bLlia7lSTnSyJKhGgmK2D/ESOwFSGUJuri3e9vPiYrQmT2Dq34fqrBRiHgpHvUj27TnrIFbUb/xSIkGHyfnXq2D4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1755656213t5f3e686c
X-QQ-Originating-IP: Ak+PhEWaVg7vGtjuhuEht2sFkVHdkBKroE3obuaqw14=
Received: from [IPV6:240f:10b:7440:1:74a0:7bf7 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Aug 2025 10:16:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 737961017978575348
Message-ID: <1D03D9D55EB70125+5dd53657-8d25-44b8-9098-d50ed83422b2@radxa.com>
Date: Wed, 20 Aug 2025 11:16:50 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: update pinctrl names for
 Radxa E52C
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <ABB74D9D1E3774F3+5a8c0d7d-fb7f-47c0-8308-e2b69f0628c1@radxa.com>
 <20250819150038.874297-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250819150038.874297-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Obs4Jap+oQoElEGq0Lc5JCw+Xektz5mLbP5RVRl29pHgLbh1bR4O+EAw
	xU974t2idpKBM+kVij2aqJ/iWYAMBjYxPeN3V2KLggL2w6O2XlwlTcddob/stHHSCEXq5bh
	2wN4zpH1H6P3o6fITDklD+nvaKOVgkN8YxpgeZBLE0a1+NzHwg/gkNEwm61Ps2xiDRgJjqb
	qLfeIU3P/2tpdDrcosS1w0xSRJ+8nN4hXcflwwYZ++gWIGpDuAha54+ap2cl03MJ1dcsA8p
	rxoCnwelsNGFQilUTUf/+ca/RliHQcfaOgp+oiAhrNI+3FYO93f4KmCV3d/aPnozgeJVTeu
	V5CH4lInD2sooD8SOiJ1ANmNVG9x6e/+ZjtLgy7ZaTv6FXnyf35kooFzWi1QXO5QmiOrgiN
	PL/+v690/6Gt0f0v9Py22m1D5MBx1JiEPcipnkompcC9jsbBwNHk3B8jDJ7zqI7MaeoMImh
	luETTpH0rKjLrdLhcyFIjYjxFZe7Y1/x4KRwzgWKC4Z5TqY8avChRaaNhBYPyNOZu8p8yho
	CutfioZntOrOPnwMZ8cRi1LVCv3R63N5El0WUq43Zq/QQ0HgAsvzo+SIe7TGX6Iwn3mq6Ei
	XWhCF6QoBFb6qNQek4Wj3KxeoxChMV77kfk9sooMfafgNwGxnDpxS3SItmziTmR+wFCNrUs
	ewIHMmMPzETGW0f1X7FlQn8HwLCnlAAEJ3xuhBRi/IsLkqSonW0xtfHib7imOa7OZqvpqM4
	LWzHthfKuMx9QYwpjANiuPGqbn5pzIeQh5BYD5nPT3nukVTPWeFBAiWvldzHTO3r4I+VH6x
	VjERtqJDBkt7zLbGfaeSwnrxFeebE+cLaaL9LQQtsaLKqLT+R+daZGuGdA/a0dqvIJQIjJ2
	QxwYl7lvrWGi2gwOW+7JYUJQ9QxKS+f5/QrWVkR8z8hIozMlH2IT76tu5PfZBmi1dXTUuVm
	dXedPW6PMK/gWLSk3LxFUAYYibmDz6ruwwmVpyCbQGWfqxU0ThM01PBwLuOCn1vlH/FRM+K
	A84NmXUjTz6AgGfEjxEHXnzmldcFg=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Hi Chukun,

On 8/20/25 00:00, Chukun Pan wrote:
> Hi,
> 
>> "The name of a node should be somewhat generic".
>>
>>    https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst?plain=1#L193
> 
> Usually we use the name on the schematic. For example, the patch for e24c:

I don't mind using names that match the schematic, as long as the device 
tree maintainer doesn't object.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> https://lore.kernel.org/lkml/20250727144409.327740-4-jonas@kwiboo.se/
> 
> ```
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gpio0_a0_user>;
> ```
> 
> If this is incorrect, I will abandon the pinctrl changes for
> the user key and power LED.
> 
>>> -		vcc_5v0_pwren_h: regulator-5v0-1 {
>>> -		usb_otg_pwren_h: regulator-5v0-0 {
> 
> But I don't think the above is correct.
> 
>>    https://lore.kernel.org/all/20241216113052.15696-1-naoki@radxa.com/T/#u
>>
>> (I don't understand why this only applies to me...)
> 
> I don't know this. I thought the nodenames of pinctrl and regulator
> were a bit weird, so I changed the pinctrl's.
> 
> Thanks,
> Chukun
> 
> --
> 2.25.1
> 
> 
> 


