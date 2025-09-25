Return-Path: <linux-kernel+bounces-832559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526DEB9FABB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0805F1710D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134F2857C1;
	Thu, 25 Sep 2025 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Z2jnGeKn"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC104A00
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808396; cv=none; b=T6vHfJPOsDLG9X2OaPqem4SKa/7hsy1OV9KNJQM6t7yAzq2H1fBHv7j7ntHh2dJhHTy5r1RktZsd3fWIBzsNEX/9Uo75su4NDUd66P2ngV7N1pywbojENp1jiCNUhHHRGbJkWZbX2Xh1dIQxwIPhAOfVEbYI8u6TayszpNDnipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808396; c=relaxed/simple;
	bh=5GPXU72Yi2pGdxi06ghSImkLArlamnQdGUBBlh3Kom8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7JR471TH0kTT9oIPGESGiY04BGOTSl6a+WXcq8oUmwPIjm3ZleE8XKOfFFVRyS8lr66W1VAqL5wwjg3MYRv93IYhMYcFZLy+qvdM2Ka/gWSWupXm+Py8xfbB4ByqRfeYZ/dQTPIuVspQakP8A7pxh7j3jk2AvPmBN+UaShxtOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Z2jnGeKn; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cXZtG1Czxz9sbX;
	Thu, 25 Sep 2025 15:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758808390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAUWvNEGwTrS1d/ZAgvY+yoUNM0DnzZllEjx/sqMi0I=;
	b=Z2jnGeKnHpoLB783jGuiZdmFUwvC0RLzDnmkQ2Nf8tBGI9iLF/DrDgZb8t20wVc5gS2m9c
	86tn21hJjeXQ2eAXRa4WSKU7Q5hIQLt8icpxL51aYbbF1hEhQtrIMF3oQ5gDQjjbCA4PF9
	5s+tdAJOJ4ImZ0IHx5XsbRgpBTEEXT1X23RqQSMdGlPXauTP2tBncS17lNpRJyugqUv/HP
	UjUU/Ggpg1AcPqv7UrHhVDG/IaUU5QBa+jlVh9d665w/9CuyHdqNTDcuwsaRdDx4xvJ7ya
	x5mzUL5GUmjA0gh+asUaN2JFi+sIEWFRLy+bPoaFT8uQLiHA+uZ0dteG45wH0g==
Message-ID: <5cac35a3-80f4-43ab-b8f8-7b9217740083@mailbox.org>
Date: Thu, 25 Sep 2025 15:53:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/panel: sitronix-st7789v: fix sync flags for
 t28cp45tn89
To: Sebastian Reichel <sre@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Riesch <michael.riesch@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <20250924-t28cp45tn89-fix-v1-1-8e8f52239c84@collabora.com>
 <6e50e9fb-10f5-48e6-bc04-ec66ca90a626@mailbox.org>
 <hktw42pbb4rk3azapasigphhlbndkh5pmcm6fucdvk3ukoiull@dpoh7amjyymh>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <hktw42pbb4rk3azapasigphhlbndkh5pmcm6fucdvk3ukoiull@dpoh7amjyymh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: fjoy1ce7tsnn91b7e78dp3d8fjm3z3jg
X-MBO-RS-ID: 0adee058fcd22b63828

On 9/25/25 2:48 PM, Sebastian Reichel wrote:

Hello Sebastian,

> On Thu, Sep 25, 2025 at 02:15:41AM +0200, Marek Vasut wrote:
>> On 9/24/25 11:46 PM, Sebastian Reichel wrote:
>>> From: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>
>>> I planned to set the polarity of horizontal and vertical sync, but
>>> accidentally described vertical sync twice with different polarity
>>> instead.
>>>
>>> Note, that there is no functional change, because the driver only
>>> makes use of DRM_MODE_FLAG_P[HV]SYNC to divert from the default
>>> active-low polarity.
>>>
>>> Reported-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>> Closes: https://lore.kernel.org/all/20250923132616.GH20765@pendragon.ideasonboard.com/
>>> Fixes: a411558cc143 ("drm/panel: sitronix-st7789v: add Inanbo T28CP45TN89 support")
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>> ---
>>>    drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
>>> index 04d91929eedda092b966b8cffdef5b267748f190..dedf0a390a88dd45a8179e2d22e872128c87cfda 100644
>>> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
>>> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
>>> @@ -261,7 +261,7 @@ static const struct drm_display_mode t28cp45tn89_mode = {
>>>    	.vtotal = 320 + 8 + 4 + 4,
>>>    	.width_mm = 43,
>>>    	.height_mm = 57,
>>> -	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC,
>>> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC,
>> Is this panel somehow special with its NHSYNC / PVSYNC , compared to the
>> other supported panels, which all use PHSYNC / PVSYNC ? I would expect all
>> of these DSI TCON to use the same polarity, how come this one needs NHSYNC ?
> 
> I wrote this based on reverse engineering incl. quite a bit try-and-error and
> don't have very good data about the panel. Using DRM_MODE_FLAG_PHSYNC like all
> the other panels results in garbage data on the display.
Interesting.

Can you please add that information as a code comment in V2 and also add 
to V2 my

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you

