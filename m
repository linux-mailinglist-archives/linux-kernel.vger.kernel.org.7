Return-Path: <linux-kernel+bounces-896851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA5EC5164D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59E894FA6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AB627FD78;
	Wed, 12 Nov 2025 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="du4OOMfW"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F82FE58F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939888; cv=none; b=XoDIE+KTmfQUZsSbmLeUrlCx+/lpMO79/0ejIloaSPxzZy5hFn4OyTXBrVoCBvvW1pcG398a2k4qO4sMFz2Nc2c+GVT27Y3BlFoMx3aI04URbC9uozk13lwJ/9vt3GSN93aUBTRjXmLwkL4PFZ2DNRPBiZYFasa7ZFRs1fJQ9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939888; c=relaxed/simple;
	bh=lRHs2b3PU1XMQWNAuMfLar6FdYxKzGJIWTuWW0xBJe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYdUcVwRJ65prNjc4DG65W4eG9zY9aUUJ9Dsm7WQseZBCt4zwcXFagRZ7Ccsg4HI1CFT/Zvpp5LDIRDLNENSBySr5sI1kgVAGUAOHFg7wwEI7+W5RrVqdV4PVEvIcVdrMiU0JJup/knS7dUMtYgMh3iJMgNBx2ELpccBNlhURy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=du4OOMfW; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B7EF382E;
	Wed, 12 Nov 2025 10:29:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762939765;
	bh=lRHs2b3PU1XMQWNAuMfLar6FdYxKzGJIWTuWW0xBJe0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=du4OOMfWVmL7SlfPiGInAeibPEs7dMJtwlcaoSE3+brxITSF92ppzXILMGtCUjGFr
	 xa2zCYLw/r4tZpi/kiRihZZXcRek33u548UTq1/cUcYHKyQlJLTM7ypG2CTCxEfgv6
	 lL++7XeXsS9qOeNW6W3HLl1HTNz9UeWI7sMSTeXI=
Message-ID: <6d17761f-c2c5-422c-a14f-0e560676c21f@ideasonboard.com>
Date: Wed, 12 Nov 2025 11:31:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: xlnx: zynqmp_dp: Support DRM_FORMAT_XRGB8888
To: Sean Anderson <sean.anderson@linux.dev>,
 Mike Looijmans <mike.looijmans@topic.nl>, dri-devel@lists.freedesktop.org,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: David Airlie <airlied@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fb98a918-329e-4536-a0a5-a99b22ba0120@emailsignatures365.codetwo.com>
 <20250627145058.6880-1-mike.looijmans@topic.nl>
 <a8f0de1d-07e8-4e48-8495-9cafa0febcf5@linux.dev>
 <d2759f7e-23a5-4d68-b50f-4c510540bcdd@linux.dev>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <d2759f7e-23a5-4d68-b50f-4c510540bcdd@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/11/2025 23:09, Sean Anderson wrote:
> On 11/4/25 16:53, Sean Anderson wrote:
>> On 6/27/25 10:50, Mike Looijmans wrote:
>>> XRGB8888 is the default mode that Xorg will want to use. Add support
>>> for this to the Zynqmp DisplayPort driver, so that applications can use
>>> 32-bit framebuffers. This solves that the X server would fail to start
>>> unless one provided an xorg.conf that sets DefaultDepth to 16.
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>> ---
>>>
>>>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> index 80d1e499a18d..501428437000 100644
>>> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> @@ -312,6 +312,11 @@ static const struct zynqmp_disp_format avbuf_gfx_fmts[] = {
>>>  		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_RGBA8888,
>>>  		.swap		= true,
>>>  		.sf		= scaling_factors_888,
>>> +	}, {
>>> +		.drm_fmt	= DRM_FORMAT_XRGB8888,
>>> +		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_RGBA8888,
>>> +		.swap		= true,
>>> +		.sf		= scaling_factors_888,
>>>  	}, {
>>>  		.drm_fmt	= DRM_FORMAT_RGBA8888,
>>>  		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_GFX_ABGR8888,
>>
>> Tested-by: Sean Anderson <sean.anderson@linux.dev>
>>
>> I can confirm that this provides a nice performance boost :)
> 
> Actually, I think a better fix would be to make the "video" plane the
> primary one. That plane supports XRGB8888 natively, and then the
> graphics plane can be used as an overlay for e.g. windows or cursors.
True, but I think usually the overlay plane is the video plane, which
supports YUV formats. If we use the video plane as the root plane, then
that one is reserved and there's no "real" video overlay plane.

Did you check my recent reply to the thread? I didn't have too much time
to debug all the combinations and what exactly the userspace does. I'm
inclined to just merge this one which should improve the user experience
quite a bit, even if there are still unclear parts to this. The related
code can be improved later if we figure out the details.

Any objections?

 Tomi


