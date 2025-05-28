Return-Path: <linux-kernel+bounces-665517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC9AAC6A46
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 15:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF233AE190
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3452286D61;
	Wed, 28 May 2025 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvGahb1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1073A246326
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438635; cv=none; b=eox+7iE/oGukKwIXSVER1UEKdQ96Xv271I1arF+EgNVezm801KRMkV8fg8cIjXxD1dJ51cE6levyMX2KVLfSs2HBNhmUC52vmi2PNCIR8w8k0HmekDuxUgpHkHzZGtxLO6uAUy38BNvcbthIvKvzW+AvrljLC77L+CWwrDmNZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438635; c=relaxed/simple;
	bh=5vKSGaBChbSlR5lX+l//vJBLLeI/kpeZbgb9bJhXdmI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aDr3VDQv/7KThivOQDOJ1proLXV4s4TIwA6FusTkEY5Ip2ShSAMlI3bY/OxUqwJV/DtLB7JElIpjc2e/jf6f+FLcvzqUlZmr8+5cggILt8iubZaSRZ+GzLCc50/S5ZRmg5v8SjSZa+vFi07LYlnjbJtwPmsuE6Lz+zgxDoZRRxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvGahb1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA28C4CEE7;
	Wed, 28 May 2025 13:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748438634;
	bh=5vKSGaBChbSlR5lX+l//vJBLLeI/kpeZbgb9bJhXdmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SvGahb1Do9eqe3wYzPHut9tiGeekau9E3fkbyq23F3FrZk/QHelsJAtjySHEJh/S2
	 BP/9WfUEWcRRx5e+n07v424qqusqgcwVW0B1iKztcH9mvKersXINz2nOVHJ033iSbM
	 t5aeZXGDeNd0MYvnQo5kOg1eZ5YEsJu4zHSkJQHWl9jQQyuONp4yNjCvyTsL3CV/tP
	 y4G3wCbrF7x3FU0EHTfQ0jnZhCxXpwQc2wMCGhb4+JCD4QKVz2RfnSux88ZJGtnKTT
	 3ZWXiI9Euov3Ym4g6mVEjSxIgRGRRyI7qJOAxlrUKosARIRmzlfONW3KZG90X+TrM3
	 9JG2TsMFQCGFg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 May 2025 15:23:47 +0200
From: Michael Walle <mwalle@kernel.org>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Aradhya Bhatia
 <aradhya.bhatia@linux.dev>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, Francesco
 Dolcini <francesco@dolcini.it>, Jyri Sarha <jyri.sarha@iki.fi>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2 03/18] drm/tidss: Adjust the pclk based on the HW
 capabilities
In-Reply-To: <ab5f27ac-6bbe-4746-a2bd-e5f1a667ae91@ti.com>
References: <20250402-cdns-dsi-impro-v2-0-4a093eaa5e27@ideasonboard.com>
 <20250402-cdns-dsi-impro-v2-3-4a093eaa5e27@ideasonboard.com>
 <DA6TT575Z82D.3MPK8HG5GRL8U@kernel.org>
 <8fc0c880-0809-43d6-b03a-1a5728f5d0d4@ideasonboard.com>
 <ab5f27ac-6bbe-4746-a2bd-e5f1a667ae91@ti.com>
Message-ID: <27fa4ad56a57f0c408d3b119a620c1cb@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Devarsh, Hi Tomi,

>>> While testing Aardhya's OLDI support patches [1], I've noticed that
>>> the resulting LVDS clock is wrong if this patch is applied.
>>> 
>>>> In practice, with the current K3 SoCs, the display PLL is capable of
>>>> producing very exact clocks, so most likely the rounded rate is the 
>>>> same
>>>> as the original one.
>>> 
> 
> Yes, display PLL is flexible and device manager should set exact 
> frequency.
> Please note that there was a bug in device manager in earlier releases 
> which
> would prevent setting it to exact clocks. You should try with latest 
> SDK
> release firmware binaries (11.0...(10.1 should also work though)) if 
> seeing
> any misbehaviour in that regard.

Yes, I don't doubt that. But it's the way the driver is handling the
clock w.r.t. to the fixed-clock-divider in the LVDS case which is 
causing
problems.

>>> This is now what I'm seeing. Most SoCs have that fixed clock thingy
>>> for (some?) VPs, e.g. [2]. And clk_round_rate() will return the
>>> fixed clock rate for this clock, which will then result in an LVDS
>>> clock which is way off.
>>> 
>>> I'm testing on an AM67A (J722S) and I've backported some of the
>>> patches as well as dtsi fragmets from downstream. Thus, it might be
>>> as well the case that the fixed-factor-clock node is wrong here.
>>> OTOH other K3 SoCs do this in mainline as well.
>> 
>> Thanks for findings this (It's not a fixed clock, but a (fixed)
>> divider). I can reproduce on my AM62 SK's OLDI output.
>> 
>> I didn't see AM625 TRM explaining the DSS + OLDI clocking. I remember 
>> it
>> was a bit "interesting". Afaics from testing, the VP clock is derived
>> from the OLDI serial clock divided by 7. To change the VP clock, we 
>> need
>> to set the OLDI clock's rate. But the code we have at the moment is
>> using clk_round_rate/set_rate to the VP clock.
>> 
> 
> This is correct. The pixel clock is derived as OLDI clock/7 when OLDI 
> is
> enabled.

What means "if OLDI is enabled"? Is there any other clock otherwise or
none at all? Reading the clock ID desciption in the TISCI documentation,
I presume there is no configurable clock for the first VP at all. I.e.
if one compares it with DSS1 which has two muxed clocks, DSS0 only has
one muxed clock (DEV_DSS0_DPI_1_IN_CLK) and DEV_DSS0_DPI_0_IN_CLK is 
fixed,
presumely thats the fixed /7 clock.

Also how is this handled for the DSS1 (on an AM67A)? The TI downstream
kernel also has a fixed-clock-divider for the VP1 on DSS1, but I think
that is wrong, because it's actually configurable (if OLDI is 
disabled?).

>> And we get the crtc atomic_check called before setting the OLDI clock
>> rate, so it doesn't even work by luck (i.e. if the OLDI clock was set
>> earlier, the VP clock would already have the right rate, and it would
>> seem that everything is ok). In the atomic_check we see the OLDI 
>> bypass
>> clock (25 MHz), which results in 3571428 Hz VP clock.
>> 
>> And with this patch, the code then decides that 3571428 Hz is what the
>> HW can do, and uses it as the pixel clock.

FWIW, I'm seeing exactly 300MHz on the AM67A (the FCLK is 2.1GHz 
according
to k3conf).

-michael

>> 
>> Aradhya, Devarsh, do you remember how the clocking goes here? Or if 
>> it's
>> in the TRM, please point me to it...
>> 
> 
> I think what you described is correct, if any specific questions I can 
> help
> check. But any misbehaviour you are seeing w.r.t clock setting (i.e. 
> what
> driver is trying to set versus what actually is getting set)
> then please dump the dss clock tree along with relevant details of test 
> done:
> 
> k3conf dump clock <display_device_id>
> 
> You can get the device ID via TISCI Doc [1]
> 
> [1]: 
> https://downloads.ti.com/tisci/esd/latest/5_soc_doc/am62x/clocks.html#clock-for-am62x-device
> 
> Regards
> Devarsh

