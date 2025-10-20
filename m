Return-Path: <linux-kernel+bounces-861283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BF3BF24A2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC4A3B4B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6D7283FEA;
	Mon, 20 Oct 2025 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="QNkQ3EIZ"
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15881283FF9;
	Mon, 20 Oct 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976093; cv=none; b=Rc/VBgq0B4iiFyyDA15N/kutEjzKttHSCXDAPxyMFdqcIQW4boKJCl/9G+8XGNUKS5ld+CApno7mHvWVte1sv9lswFeDFWUjQmD5AuAtKiWOiyM9XYEaDJ0lIkphNQXfOAi6F3nw2Urfe4CYOp0i7OvtJmFa9Uq4vgzgTlsPoOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976093; c=relaxed/simple;
	bh=6UAYYbRl6gVxoWFWJmquglKp4qMFnwIKcWIe1rtXLbg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=T289z1O8g+K4LDJbEQFzr1vf5LWmJx6Z4/c7OT0KgNuiptlYRmRlFYeqW2zQzj3xKv/65fR9MUhVHbCTtiXvt0F9hHKG23bExf12qxp4H5ieI77kuM+uqgra3B/rYyMX/bk8Kuzvzv+idc0vqhJKt7bIkparx6kBtpJucS49xp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=QNkQ3EIZ; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 2641782854A5;
	Mon, 20 Oct 2025 11:01:31 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 6o93uEcNXNI3; Mon, 20 Oct 2025 11:01:29 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 9A8B7828851D;
	Mon, 20 Oct 2025 11:01:29 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 9A8B7828851D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1760976089; bh=9XOvRKZB3ZHxwazpGMcpCeHjuLjttzMXe5TLIp4gLwQ=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=QNkQ3EIZlV+10wfyNPSUJwaX1AJh4R3JpucrJc8ooITpdIhyvJ7G1fmq8HYjisO3U
	 wiNUHduXl6At9Xg1WnGkXm2iTI39JSILVTduAzaeiA9T3KPJ3tmKNvpQ9HmA9QbHa0
	 LR6xK9LY3dMenwsi+59F8E8iZcSGDJf7nuyuDeWQ=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Mn7UjrjG7kFk; Mon, 20 Oct 2025 11:01:29 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 6F9BD82854A5;
	Mon, 20 Oct 2025 11:01:29 -0500 (CDT)
Date: Mon, 20 Oct 2025 11:01:26 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: robh <robh@kernel.org>, devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lee Jones <lee@kernel.org>, 
	Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Message-ID: <1626454153.1801886.1760976086710.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <f6f9cfc9-b26e-4358-8781-6ce75075d13f@linaro.org>
References: <948400747.1748562.1758824253627.JavaMail.zimbra@raptorengineeringinc.com> <20250929141113.GA3987541-robh@kernel.org> <924260297.1801829.1760974499327.JavaMail.zimbra@raptorengineeringinc.com> <f6f9cfc9-b26e-4358-8781-6ce75075d13f@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: mfd: Add sony,cronos-cpld
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC141 (Linux)/8.5.0_GA_3042)
Thread-Topic: dt-bindings: mfd: Add sony,cronos-cpld
Thread-Index: +XTYI2SaT+vzvvqrHcY8ELCXWJUT7g==



----- Original Message -----
> From: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "robh" <robh@kernel.org>
> Cc: "devicetree" <devicetree@vger.kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Conor Dooley"
> <conor+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Lee Jones" <lee@kernel.org>, "Georgy
> Yakovlev" <Georgy.Yakovlev@sony.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>
> Sent: Monday, October 20, 2025 10:58:40 AM
> Subject: Re: [PATCH 1/4] dt-bindings: mfd: Add sony,cronos-cpld

> On 20/10/2025 17:34, Timothy Pearson wrote:
>>>> +  watchdog:
>>>> +    type: object
>>>> +    description: Cronos Platform Watchdog Timer
>>>> +
>>>> +    allOf:
>>>> +      - $ref: watchdog.yaml#
>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +        const: sony,cronos-watchdog
>>>
>>> There's no need for a child node here. 'timeout-sec' can just go in the
>>> parent node.
>> 
>> Could you elaborate on this please?  As far as I can tell we ref watchdog.yaml
>> and need some kind of compatible string, so why would I break out timeout-sec
>> directly here?
> 
> 
> Please look where the comment was placed. Under $ref? No. Under this
> compatible. $ref goes to the parent, obviously.

This is not an area of the kernel I'm normally changing, so I appreciate the insight.  None of this yaml syntax is particularly obvious the first time it's encountered, at least not to me.

> You do not need kind of compatible string. Parent already has one. You
> do not need compatible strings at all to instantiate Linux drivers.
> That's pretty common pattern for most of MFD-like devices, plenty of
> examples in the kernel.

Understood.

