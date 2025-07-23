Return-Path: <linux-kernel+bounces-742504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0EAB0F28C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B885477D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698E02E7165;
	Wed, 23 Jul 2025 12:50:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E126E712
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275037; cv=none; b=gyuHawcvk6YssSe4Dn6Dm5vwp0kS8eOvKPdDClGAMpYM8N1h4nDIcUK/dXEjkViDZAtrnN2kI7TQIn7FSvXLpitQ/GsuyzhFzuUUJJ1/N5eixw9tIt0tpbIBPw94ZSD0HXMQGeLcmfo0o0VmUKJ5joiVGp4yg1Qo/G5jHjj3m4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275037; c=relaxed/simple;
	bh=MSimA2+DDncNbgkF9xykJmmS+FJHGnRa1/2TzOvLbpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoR5AhuMZnzv2j15MpcIol6pPVWSQpvErjbHOTdMvYETN/x4GslKFV/uz8JnzPcI5NVDy6YIp5cR+GkkP7Q2xr9lgwctEhWo2mNgkx8DRxzah9Zr98yMLZKGuMvY0oqrUmLcVs4OjqLy4o7ddzf+MzTHBqo4+9//bwBfdtua0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1ueYvL-0005Ys-Pi; Wed, 23 Jul 2025 14:50:19 +0200
Message-ID: <fdfa4301-7b2d-47c5-9aca-fc00c4408bcf@pengutronix.de>
Date: Wed, 23 Jul 2025 14:50:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] parse horizontal/vertical flip properties
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jacopo Mondi <jacopo@jmondi.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 entwicklung@pengutronix.de
References: <20250718-fpf-media-dt-flip-v1-0-75b3a938b4be@pengutronix.de>
 <ryuew3kxnocj6uqq4nadp3kyaxg27rxlrgnaieyy2hlpz5jkd3@iyetnsbfanee>
 <35debf21-bca7-480f-a61e-7b0494f10ca5@pengutronix.de>
 <mljx67lkcw4kh3cs344iprik244cm7hqfckmg4bj5j5atuyt62@lh2ht4mrtkjq>
 <3ac271c7-a67a-4f6f-935d-256937516068@pengutronix.de>
 <ffzxxsplmivvj7pib7n7lkutbyohl5npofdaxdxtoffo43yatw@gqm64zdgb4iy>
Content-Language: en-US, de-DE
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
In-Reply-To: <ffzxxsplmivvj7pib7n7lkutbyohl5npofdaxdxtoffo43yatw@gqm64zdgb4iy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 7/23/25 14:21, Jacopo Mondi wrote:
> Hi Fabian
>
> On Wed, Jul 23, 2025 at 12:09:58PM +0200, Fabian Pfitzner wrote:
>> On 7/23/25 11:44, Jacopo Mondi wrote:
>>> On Wed, Jul 23, 2025 at 11:29:27AM +0200, Fabian Pfitzner wrote:
>>>> On 7/23/25 11:17, Jacopo Mondi wrote:
>>>>> Hi Fabian
>>>>>
>>>>> On Wed, Jul 23, 2025 at 10:58:28AM +0200, Fabian Pfitzner wrote:
>>>>>> There are cameras containing a mirror on their optical path e. g. when
>>>>>> mounted upside down.
>>>>> How is this different from 'rotation = 180' ?
>>>> If you simply want to flip the output (e. g. horizontally), you cannot do
>>>> this with a rotation.
>>>> The camera I'm referring to is not only upside down, but also flipped
>>>> horizontally.
>>> 180 degress rotation = HFLIP + VFLIP
>> I do not want to do both. Only one of them.
>>> Yes, you can't express 'mirror' in DTS, because DTS are about the
>>> physical mounting rotation of the camera. Sensor drivers shall not
>>> apply any flip control automatically, it's userspace that by parsing
>>> the rotation property through the associated v4l2 controls should decide
>>> if it has to apply flips or not to correct the images.
>>>
>>> What is the use case you had in mind ? Tell the driver through a DTS
>>> property it has to apply flips to auto-compensate ? Because I think we
>>> shouldn't and if I'm not mistaken we also document it:
>>> https://www.kernel.org/doc/html/latest/userspace-api/media/drivers/camera-sensor.html#rotation-orientation-and-flipping
>> I have a camera that does a horizontal flip in its hardware, so the output
> Sorry, I don't want to be annoying, but what does it mean "does a
> horizontal flip in the hardware" ?

Between the sensor and lenses (optical path) there might be a mirror 
that causes a flip of the image.
"Might be" because I do not know if its really something that comes from 
the hardware itself or whether its inside the firmware (for the camera 
I'm using right now).
Either way, I cannot change it. So my idea was to set it via a device 
tree property, such that the driver can "revert" the flip that was made.
I thought, that it might be useful for other drivers as well that face 
similar issues.

>
> In my understanding either "in hardware" means you can't control it
> from software (and so there's no point in telling drivers what to do)
> or you can control it from software and it's a regular HFLIP.
>
>> is not what I want. My example above was misleading. The rotation fixes the
>> "upside down" problem, but does not fix the flip.
>>
>> Doing that in userspace might be a solution, but in my opinion it is a bit
>> ugly to write a script that always sets the flip property from userspace
>> when the device was started.
>> A much cleaner way would be to simply set this property in the device tree
>> such that the driver can be initially configured with the proper values.
> Sorry, don't agree here. What if a sensor is mounted 90/270 degrees
> rotated (typical for mobile devices in example) ? You can't compensate
> it completely with flips, would you 270+HFLIP=90 ? would you leave it
> unmodified ? Userspace has to know and act accordingly, doing things
> in driver (will all drivers behave the same ? Will some compensate or
> other won't ?) is a recipe for more complex behaviours to handle.
Hmm, sure there might be more complex scenarios.
The device tree property is for developer who know that there will not 
be any changes in user space anymore (e. g. cameras that are fixed in place)
And even if, it is still possible to make modifications from user space 
(like for the rotation property). My changes are not enforce any 
restrictions regarding that it is just an optional attribute.
>
>> PS: I have to send this email twice. The first one contained HTML parts that
>> were rejected by some receivers...
>>
>>> TL;DR drivers shall not flip, userspace should. Mirroring is an effect
>>> of drivers applying an HFLIP, because unless I'm missing something
>>> obvious, 'mirror' is not a physical mounting configuration of the camera
>>> sensor.
>>>
>>> FIY we're talking about something similar in libcamera
>>> https://lists.libcamera.org/pipermail/libcamera-devel/2025-July/051533.html
>>>
>>>>>> Introduce two options to change the device's flip property via device tree.
>>>>>>
>>>>>> As there is already support for the panel-common driver [1], add it for cameras in the same way.
>>>>>>
>>>>>> [1] commit 3c0ecd83eee9 ("dt-bindings: display: panel: Move flip properties to panel-common")
>>>>>>
>>>>>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>>>>>> ---
>>>>>> Fabian Pfitzner (2):
>>>>>>          media: dt-bindings: add flip properties
>>>>>>          media: v4l: fwnode: parse horizontal/vertical flip properties
>>>>>>
>>>>>>     .../devicetree/bindings/media/video-interface-devices.yaml        | 8 ++++++++
>>>>>>     drivers/media/v4l2-core/v4l2-fwnode.c                             | 3 +++
>>>>>>     include/media/v4l2-fwnode.h                                       | 4 ++++
>>>>>>     3 files changed, 15 insertions(+)
>>>>>> ---
>>>>>> base-commit: 6832a9317eee280117cd695fa885b2b7a7a38daf
>>>>>> change-id: 20250718-fpf-media-dt-flip-7fcad30bcfb7
>>>>>>
>>>>>> Best regards,
>>>>>> --
>>>>>> Fabian Pfitzner <f.pfitzner@pengutronix.de>
>>>>>>
>>>> --
>>>> Pengutronix e.K.                           | Fabian Pfitzner             |
>>>> Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
>>>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>>>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
>>>>
>> --
>> Pengutronix e.K.                           | Fabian Pfitzner             |
>> Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
>>
-- 
Pengutronix e.K.                           | Fabian Pfitzner             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |


