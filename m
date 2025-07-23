Return-Path: <linux-kernel+bounces-742187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E85B0EE73
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8493A4ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3738C286D55;
	Wed, 23 Jul 2025 09:29:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6458A2868BA
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262987; cv=none; b=jPLD8WZvivEPFM0O7oNKLHQ+00oQnCFw69aZk7ZpMPYbLL80hdcigb4UL0STOfSdZImeVeoByuLQCCWof8kGIu+w1i+Hq8YlsHHNent3dcbsquWKvgBXnrAJhUSdtjbppr6Mw8MACiRbLLd+Dpk6wSxecN1UZdobplF75WkL9V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262987; c=relaxed/simple;
	bh=MdmN0BHl9qK/x/8lXU5gTxriBjlVUKoKDGlmM00y1EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWzNS0Aebkqx5WJXcytEyenIf/UZzoJg6eQJ3318jDmmK+JSnhh9/Oj7DgCWp/xBk0y+MJKcRzRcsC9Zoj4UYPQiFeSYTTWWHu9+6TaC5DVh8NzNr8GhFwWD+NfBBRHo5GQRTSHJxec0KueGMB4ijaUf2muyxhiLWLgjJoxakDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1ueVmy-0008Tw-Ui; Wed, 23 Jul 2025 11:29:29 +0200
Message-ID: <35debf21-bca7-480f-a61e-7b0494f10ca5@pengutronix.de>
Date: Wed, 23 Jul 2025 11:29:27 +0200
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
Content-Language: en-US, de-DE
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
In-Reply-To: <ryuew3kxnocj6uqq4nadp3kyaxg27rxlrgnaieyy2hlpz5jkd3@iyetnsbfanee>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 7/23/25 11:17, Jacopo Mondi wrote:
> Hi Fabian
>
> On Wed, Jul 23, 2025 at 10:58:28AM +0200, Fabian Pfitzner wrote:
>> There are cameras containing a mirror on their optical path e. g. when
>> mounted upside down.
> How is this different from 'rotation = 180' ?
If you simply want to flip the output (e. g. horizontally), you cannot 
do this with a rotation.
The camera I'm referring to is not only upside down, but also flipped 
horizontally.
>
>> Introduce two options to change the device's flip property via device tree.
>>
>> As there is already support for the panel-common driver [1], add it for cameras in the same way.
>>
>> [1] commit 3c0ecd83eee9 ("dt-bindings: display: panel: Move flip properties to panel-common")
>>
>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>> ---
>> Fabian Pfitzner (2):
>>        media: dt-bindings: add flip properties
>>        media: v4l: fwnode: parse horizontal/vertical flip properties
>>
>>   .../devicetree/bindings/media/video-interface-devices.yaml        | 8 ++++++++
>>   drivers/media/v4l2-core/v4l2-fwnode.c                             | 3 +++
>>   include/media/v4l2-fwnode.h                                       | 4 ++++
>>   3 files changed, 15 insertions(+)
>> ---
>> base-commit: 6832a9317eee280117cd695fa885b2b7a7a38daf
>> change-id: 20250718-fpf-media-dt-flip-7fcad30bcfb7
>>
>> Best regards,
>> --
>> Fabian Pfitzner <f.pfitzner@pengutronix.de>
>>
-- 
Pengutronix e.K.                           | Fabian Pfitzner             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |


