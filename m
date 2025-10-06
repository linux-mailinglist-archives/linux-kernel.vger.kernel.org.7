Return-Path: <linux-kernel+bounces-843148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70614BBE7DC
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BF63A67F5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC170283FE5;
	Mon,  6 Oct 2025 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fe/cNu0r"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F2AA926
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764630; cv=none; b=RkDOz4o7RLEn5r6cPtn+52R/blcbqfVhtFzYo94XHqsLPx1k/4zxiE9RqcEao9sK46tKgaONLnQu0HcP7HvNFhYy8sTlWHGta+kUrhJQuacqeVUBSoBSCCSKoVCQMm3AVEtplbbOoeV7NUh9AmFczfHsydivoObp38ssNwuIvn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764630; c=relaxed/simple;
	bh=KfEpPX6KTwp0yN4qfLT4LXJb5WVsFjNmfSxhuw6//Tg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RIm97tjfYkqs2/8RqllFXR4X2UehQZe03DK+KMjQPn00ml/DmAriVpb09yfTVE1G68HmY4d4rbBUljdg//kCHCpWEec7FsgkGPCo59f9wnWuC/3cksSZ0dp0atIpLOd7KSwIL46RNw6Vj8f7uHjo8Yte2+oMLEHA0EAph9c9e6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fe/cNu0r; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ff21cbd1-dc77-43ae-85a8-dc6a56a1cefa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759764625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXyoKN4j7tjDil/ht3RE4A/98xpfn+XOg18nSC63YxI=;
	b=Fe/cNu0rr623OU3+9Ti9ilVTCZn9uAu/4R9seUwKi1wiqTULHwiFAtmOQfNqBi/s98yzjN
	GERZwA4JTt8odBfVuDE6VeHz2PmiluWbhv/obSptS1gcMUx/ZcQ3Us/dAVtmGn5r5OyVHg
	0z4dog6KEnfJc3NI3xAgiS/dd3DYNyA=
Date: Mon, 6 Oct 2025 16:30:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v13 3/4] drm/atomic-helper: Re-order bridge chain
 pre-enable and post-disable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
To: Vicente Bergas <vicencb@gmail.com>
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com,
 alexander.sverdlin@siemens.com, andrzej.hajda@intel.com, devarsht@ti.com,
 dri-devel <dri-devel@lists.freedesktop.org>, jernej.skrabec@gmail.com,
 Jonas Karlman <jonas@kwiboo.se>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lumag@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, nm@ti.com, rfoss@kernel.org, simona@ffwll.ch,
 tomi.valkeinen@ideasonboard.com, tzimmermann@suse.de, vigneshr@ti.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Douglas Anderson <dianders@chromium.org>,
 Damon Ding <damon.ding@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Linux Rockchip Support List <linux-rockchip@lists.infradead.org>,
 Devarsh Thakkar <devarsht@ti.com>
References: <CAAMcf8BfxMJx+5ttEXx0kONP2OYWSLFqEYF6rfVBKoRg5TKZzQ@mail.gmail.com>
 <bea50d14-2311-46ad-bb30-9d60a4c5e3a2@linux.dev>
Content-Language: en-US
In-Reply-To: <bea50d14-2311-46ad-bb30-9d60a4c5e3a2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

+rockchip maintainers

Hi Vicente, all,


I went through the drivers and the affected areas in the gru-kevin
chromebook pipeline last week, but nothing has stood out.


Pipeline:

rockchip,display-subsystem / rk3399-vop (Big/Lite) (CRTC) ->
rk3399-edp (Encoder) -> analogix_dp_core (Bridge) ->
sharp,lq123p (edp-panel)

I am unable to debug this further since I do not have the hardware.

I could use some help, especially from folks who understand the hardware
requirements better.


On 11/09/25 09:01, Aradhya Bhatia wrote:
> Hi Vicente,
> 
> Thank you for the bisection and reporting the issue.
> 
> On 10/09/25 16:17, Vicente Bergas wrote:
>> Hi,
>> this patch causes a regression. It has been reported in
>> https://bugzilla.kernel.org/show_bug.cgi?id=220554
>>
>> It affects the gru/kevin platform (arm64,RK3399) with the Panfrost DRM driver.
> 
> I believe the Panfrost DRM driver may only be for the GPU.
> 
> Based on the dts files in arm64/rockchip/, this is the pipeline of the
> gru-kevin setup that I understand.
> 
> 	rk3399-vop (Big/Lite) -> rk3399-edp -> sharp,lq123p (edp-panel)
> 
> The setup seems to be using the drm/rockchip drivers for the display
> controller and for the bridge.
> 
>>
>> When it boots in console mode, the blinking of the cursor keeps the display on.
>> If it is turned off via /sys/class/graphics/fbcon/cursor_blink, then
>> the display briefly shows each key press presented on screen for less
>> than one second and then powers off.
>>
>> When starting the graphical mode (wayland), if there are no
>> applications drawing on the screen, the only way to keep the display
>> on is by continuously moving the mouse.
>>
> 
> Okay!
> 
> I will have a look through the drivers. In the meanwhile, please do
> report back if you find any other observations.
> 
> 

-- 
Regards
Aradhya


