Return-Path: <linux-kernel+bounces-750455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7778B15B77
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABA2176406
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7E92701C0;
	Wed, 30 Jul 2025 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="e4sxHj22"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1510E3;
	Wed, 30 Jul 2025 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867524; cv=none; b=ULkkx64ScNnJ+cpWiCrhHrGFtNhTZxJhTfHcQTkmV4TuGXwScobZtCQaxICUq7+G8qqWZGbuD83Xop7k2ZIpqSWcYEOav+r1mw6Q63dKhpC2wStYCSqszM2JPeXbCI4RG/POUle0dNoUxdYaYhT1IT6jwj+URqwLjWIH+lMoFp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867524; c=relaxed/simple;
	bh=1MHRdEhKZxS+HzmEBYk4+Y9wIW2b2Cp3Qo/0aeWItA8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a8A0Lko+zEe2zHK3Y2k4+1Rg9eR1zq6J2BOfsvQr42AfcNE9A4y2X9/h0tVGYvhOGUsKRf52Kf5NiRMzMt2bTWyDVS3OZjE6w7p7IoSzjBJxUZ0u06oyVEo/+XCFRNNOXgQotL+FY5wATzRRrUEDsTon+QvcGeTM5Nxb8tI9rhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=e4sxHj22; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753867493;
	bh=5TbeNkB8ldYnEXcb1m/XCnlkvWahX+znrHwbJGCTAgI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=e4sxHj22ssG9WshGpEQw4/82BvBQlHPX2H7STjxx3r1jrON8BKSgiafI3Hmj0/Yv5
	 hmQgFhbcGVV0PqHM1Uk/JFbaBbVheew75ICke1xkiBsfAFCl2iMNVgpvuC8Jk12bmL
	 BodaX7yPyeqk4zXHeX0w9Bg4zBxQksdEvUnbhFD4=
X-QQ-mid: esmtpgz10t1753867490t9a6472fa
X-QQ-Originating-IP: lQl0MESZLYhgwmh4DSr716DxfUxHtn7Ebgq7yyCQOZc=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 30 Jul 2025 17:24:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1206265350598173633
Message-ID: <B751D49737DD10DC+00a0ff95-476a-4d0a-9bc6-40e77012a554@uniontech.com>
Date: Wed, 30 Jul 2025 17:24:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Cryolitia <liziyao@uniontech.com>
Subject: Re: [PATCH v6 1/2] hwmon: add GPD devices sensor driver
To: Antheas Kapenekakis <lkml@antheas.dev>, Guenter Roeck <linux@roeck-us.net>
Cc: Cryolitia@gmail.com, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 Celeste Liu <CoelacanthusHex@gmail.com>, Yao Zi <ziyao@disroot.org>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>,
 someone5678 <someone5678.dev@gmail.com>,
 Justin Weiss <justin@justinweiss.com>, command_block <mtf@ik.me>
References: <20250314-gpd_fan-v6-0-1dc992050e42@gmail.com>
 <20250314-gpd_fan-v6-1-1dc992050e42@gmail.com>
 <CAGwozwENLOOS5q1Bs5SEh3FFJAY-=kcVimf5U+tWzy6HaiGd=g@mail.gmail.com>
 <bb57fe1d-fde9-45f8-9f5c-0836a6e557ff@roeck-us.net>
 <CAGwozwGdZ5tzHg7_TF5d_AWVDmypP987XS-x_GWqrSF81PiG2Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGwozwGdZ5tzHg7_TF5d_AWVDmypP987XS-x_GWqrSF81PiG2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: M8e5kblytUZR2/NuQijMYYgSbRTX+/osZL2apFBDKqF1qD11KeQzMDJZ
	MKJ6iEbl3t5lYh5lHhA3fy8ZcXlQrYg/QLkEYarE6spLY5Xx4L9ZyIH6sfRPGohUX/W3YDK
	TkIAawT2jwST69e/zbz3lg3no8Ir0MJsqzoYYLV+BxqVzVd5nvNy3+nRY5RrgU6qg8rsYNd
	ypjw68yzysNWWMIRVVc9vudmL5JtFWAeJ6gs3WLi0UbcplVmQBprKeZcWI+CYIE9sGFQlQc
	QCcd9di0kFcYJjrTuwi2vOQMS+JfpCeaLni4Djg0StCp+kmfmty+94SaG5D2NMaEZWpa4Hm
	x4WFL6pqe3o89iqmi4xdvx9Hm25jhtCeCWLICfUDEJE1BFvQDd18bEFGTVTuUpo203oUPft
	VU4Inu/85MvhYh1cPVsiBCS+aAdTSvq/eRvWicdXf3E7MVCGSGNmHnSed8qmzjLC3+Z3egn
	aNzcXayNIMLKEbsxVVRlHSBnlMrvutNiAZekTbQlgpWQkCq5rV1k6ET61IFNNlxbrqJ5mLo
	ai74BR1hSvc3NHUNhYkFwkIlGDc5TEX1FzaAFL25NY2o2GNBJO98etCeOBpIzuQWqQ/wNSs
	yy8z/Wq5iH2eF6ZIDsi+6qYIco7sSdu3znqpRKcmPkU3UKXvsDdBFOaVRfWxx1HicQ58+Je
	3kfUVGQ86EEMT5usnNz2+azdWg8J6Rai+Q9TyKPr+EJjPV31HOZ4Xb7KZA2lgmAzE8u5eWq
	hlK6+4/WtooIeDw2DviXmnu8kZUCIkPoj/rsq1BXW7IiTpKf6XwZ7QbIQEqNsELpGh2GPOh
	n6BFkvrOP2bjn0uXPqdKiCe2iiIwSPwkQ3ELme16A+9hKTTloEzIPvE44fkHlNepZxGuJ8H
	GRJ7X6RYRjdJ7kigaqCFzFpAgEU3nNW2ChWcHlTvuda+g02jJSlo04gCWzR87AaHYn6ocND
	8a4FgaWGto/n7u+jVmNKn4NO4GkdWkvyG8xtNE+6h2fJcj+XedaO+uQebaJG09UTyOD9Jwm
	gp/XU0JAsR4RIcVaEFz11uMBOIPt0Db+Q8P3xp3Q==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Thank you for raising this valid concern. We've closely monitored GPD's
development plans and currently see no indication of EC functionality
expansion beyond thermal sensors in the foreseeable future. Given this
observation, we believe placing the driver in hwmon remains appropriate
for now.

That said, we fully respect your maintainer perspective on
future-proofing. If you feel strongly that platform/x86 would be a safer
long-term home despite the current scope, we're happy to move the driver
there immediately. We're committed to finding the most sustainable
solution for upstream.

------
Apologies for mistakenly replying to Antheas Kapenekakis instead of the 
mailing list.

I am Cryolitia <cryolitia@gmail.com> that previously sending the patch. 
Due to work, I changed my email address. GPG can verify it's the same 
person: 
https://keyserver.ubuntu.com/pks/lookup?op=vindex&search=0x84dd0c0130a54df7
------

在 2025/7/19 00:38, Antheas Kapenekakis 写道:
> On Thu, 17 Jul 2025 at 04:32, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 3/13/25 13:58, Antheas Kapenekakis wrote:
>>> On Thu, 13 Mar 2025 at 21:10, Cryolitia PukNgae via B4 Relay
>>> <devnull+Cryolitia.gmail.com@kernel.org> wrote:
>>>>
>>>> From: Cryolitia PukNgae <Cryolitia@gmail.com>
>>>>
>>>> Sensors driver for GPD Handhelds that expose fan reading and control via
>>>> hwmon sysfs.
>>>>
>>>> Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
>>>> devices. This driver implements these functions through x86 port-mapped IO.
>>>>
>>>> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
>>>> ---
>>>>    MAINTAINERS             |   6 +
>>>>    drivers/hwmon/Kconfig   |  10 +
>>>>    drivers/hwmon/Makefile  |   1 +
>>>>    drivers/hwmon/gpd-fan.c | 681 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    4 files changed, 698 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 0fa7c5728f1e64d031f4a47b6fce1db484ce0fc2..777ba74ccb07ccc0840c3cd34e7b4d98d726f964 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -9762,6 +9762,12 @@ F:       drivers/phy/samsung/phy-gs101-ufs.c
>>>>    F:     include/dt-bindings/clock/google,gs101.h
>>>>    K:     [gG]oogle.?[tT]ensor
>>>>
>>>> +GPD FAN DRIVER
>>>> +M:     Cryolitia PukNgae <Cryolitia@gmail.com>
>>>> +L:     linux-hwmon@vger.kernel.org
>>>> +S:     Maintained
>>>> +F:     drivers/hwmon/gpd-fan.c
>>>
>>> A problem we had with oxp sensors is that once OneXPlayer expanded
>>> their EC to include e.g., battery capacity limits, it was no longer
>>> appropriate for it to reside in hwmon. I expect GPD to do the same
>>> sometime in the near future. If that is the case, should we
>>> futureproof the driver by moving it to platform-x86 right away?
>>>
>>
>> My problem with platform drivers, especially with x86 platform drivers,
>> including the OneXPlayer driver, is that the developers responsible for
>> those drivers refrain from implementing the client drivers as auxiliary
>> drivers but instead like to bundle everything into a non-subsystem
>> directory. I have always wondered why that is the case. My best guess
>> is that it is to limit and/or avoid subsystem maintainer oversight.
>> Does that work out for you ?
> 
> Particularly for simple ECs such as OneXPlayer and GPD boards I think
> keeping all the addresses in the same file makes sense. E.g., I just
> sent a Fixes for the OneXPlayer G1 AMD variant and it was one commit
> instead of 2 or 3. At least for me it was practical, I did not
> consider having a lesser oversight as a benefit when making that
> choice.
> 
> But I do understand the concern.
> 
> Antheas
> 
>> Not objecting, I am just curious.
>>
>> Guenter
>>
>>
> 


