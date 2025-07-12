Return-Path: <linux-kernel+bounces-728662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA3CB02BA2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 17:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A7616EA5A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020BD275AF7;
	Sat, 12 Jul 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="I4LlRyPs"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276618D
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752333404; cv=none; b=ovQyFb2VW7BpVinLhYWfqyFG00wTSxuQhjo6HcaMyyIi0wJOmZrQE5KW8iHoNr1WStGqwFcxgdt2ODb3bL9FggctrKb2+I7YlrNQLkEEDbTkHGZz8N7tuqFHB2ytHrRVMmL1RPqSAJlc69R/FORNHg7/QPzpQeLyJ59NhzsN4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752333404; c=relaxed/simple;
	bh=GDX7vCjMy9J+OPd2MRRWaTyOZtthmmXSESvSOqHsSH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrNCXwnUnL6SyhPuVSR084+O/EJQZrdGQWArB7pFZoL6eVSHppHtNH2SZRSU8kFudkeIYtQ0Y8r3KV7E31+dQk70MfPlcwDA86WwPJk/dCsOrrcKNNRkNTt8SQOdbV50VIc6YFyuS83p8QkGNdxJE5g6aAYjiuNl0fAcOlJ0vN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=I4LlRyPs; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752333395;
 bh=lZx2NZXuKQJ5MZ9Menod0GULsbjcKgAMbN3yCF9Zij0=;
 b=I4LlRyPsrbV1u1ILcc6P5UDAn4U8BWbzZmbWqbddvJ4VAlZolwTUS8OW5zHzw0EIFvxuLXewR
 1+L7KIdj1O2//cNwRee9D2m+/UwVYpbQfbxIT+gQK9xIvdXs3n3/GiPzQVKJOasGGORrsIGLD67
 b0nyQTlYYEzjfkzeDdz7Jcb1WpDDI3OemflkVKxOnIUMhDu3P2DrNO4ekFnuRxUqF2bJJPfF7cI
 6di1w5Ed+AIv80xnPRo/aLLZirT039JbWz9T67zJN0zMbxC7LoLmd6ryBpcpAaEVE/8PhO2g9bM
 coiqxo0Hw8A3YXsN+jpcFnWH0gZanCvIkHvJLG58tvfA==
X-Forward-Email-ID: 68727c4bd7dd91652d167c59
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d4bc7bf4-bc56-4fd8-9121-379ac974b236@kwiboo.se>
Date: Sat, 12 Jul 2025 17:16:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: rockchip: Add ArmSoM Sige1
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 ziyao@disroot.org
References: <acbbf570-7a56-4d88-a631-32acd13d29c7@kwiboo.se>
 <20250712040019.165440-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250712040019.165440-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/12/2025 6:00 AM, Chukun Pan wrote:
> Hi,
> 
>>> Should this label be named as led-0/led-1?
> 
>> The nodes must include 'led' anywhere in their name according to schema:
>>
>> """
>> patternProperties:
>>   # The first form is preferred, but fall back to just 'led' anywhere in the
>>   # node name to at least catch some child nodes.
>>   "(^led-[0-9a-f]$|led)":
>> """
>>
>> Using the color name similar to the the pin labels in schematics made
>> most sense to me.
>>
>> Do you want me to change these to conform to the more restricted
>> ^led-[0-9a-f]$ pattern?
> 
> This will be better.

Will change the node names of the leds in a v3.

> 
>> I only try to enable controllers for devices that are properly described,
>> so I ignored the pwm-fan and its required pwm6 controller. Mostly
>> because it make more sense to describe the fan once thermal support is
>> completed, work [1] currently being blocked by a rk356x otp series [2]
>> and that depends on a rk3576 thermal series [3].
> 
> Ok, I got it. Is usb2.0 also stuck?

USB2.0 is mostly stuck due to my limited time and possible power-domain,
will try to send the USB2.0 patches to mailing list tomorrow.

Regards,
Jonas

> 
> Thanks,
> Chukun
> 
> --
> 2.25.1
> 


