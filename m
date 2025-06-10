Return-Path: <linux-kernel+bounces-678849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC4AD2F12
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 09:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4467D1649D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 07:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5537F27FD56;
	Tue, 10 Jun 2025 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QxqUQ39l"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BFF27F19F;
	Tue, 10 Jun 2025 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749541442; cv=none; b=DL55l8gDefTi6ih0OpHpxtZF7JYJjuTywbP4YGoTguJkbC1jwpwOdNiLMML3sjra3nK5jHnk3nGz6caoyJ9a+iVLpmBGUcvos2geXQKUnXGd1byQuCt9SYZ8W+q1lP3tj+LsYN3KDZFKGf3P6kbR9ddryvN7SJE9FjeVqYAYtyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749541442; c=relaxed/simple;
	bh=n4N0PgYoQWEoPkKDFB+wwPYRnrm8QkyXvo3El4B0B0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EofpeEnmWpng5nyz3pFB3Qd0CpfUwLuXEKj9bMdTNlJAIwSg5Pzb0uNM6eJOA9TMAuuxMLc3kN0yjArHwaijkVvjwllpNvnjsL7gntsNejwAyI+XjbEEquWWNidEdW4RKFkVjX/HthPC/K5PLfT90A0IlYWJuEiA3YrXPQ56Tqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QxqUQ39l; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55A7hWmC2222638;
	Tue, 10 Jun 2025 02:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749541412;
	bh=EpKnCinqiW5Ium/sM9lgT6Fdt1dZKQWiUdDaDX0h6y8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QxqUQ39lb7skYNIj1xxCq0qaIUbsSxdGRyv3UVYSNXoHunjfjzDTRGKpJfvyAGSS3
	 aZn/r5KPQSRxa2dhsGpexQISPhaSii3T4YQY0DU2dTpZcMtn30z7IEAO2DG/0+3iYM
	 k86ZSLCS6iaiiCL+sgfu72hMDBa+I8xLHHalW+wU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55A7hVaY1959234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 10 Jun 2025 02:43:31 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Jun 2025 02:43:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Jun 2025 02:43:31 -0500
Received: from [172.24.227.14] (jayesh-hp-z2-tower-g5-workstation.dhcp.ti.com [172.24.227.14])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55A7hN5o2564104;
	Tue, 10 Jun 2025 02:43:24 -0500
Message-ID: <71c41c44-1c2e-4fee-a1a8-31472c9f838d@ti.com>
Date: Tue, 10 Jun 2025 13:13:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort
 connector type
To: Doug Anderson <dianders@chromium.org>, <ernestvanhoecke@gmail.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <dri-devel@lists.freedesktop.org>,
        <tomi.valkeinen@ideasonboard.com>, <max.krummenacher@toradex.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <kieran.bingham+renesas@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <max.oss.09@gmail.com>,
        <devarsht@ti.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>
References: <20250529110418.481756-1-j-choudhary@ti.com>
 <2baf3c31-3edf-4c26-bd44-1d0560134871@ti.com>
 <CAMuHMdUi7pf1YfKRjMv_7VuKwjR5XekRXfcEzuPScGzHraGjyQ@mail.gmail.com>
 <84fdbd23-d694-453f-a225-dbac19b34719@ti.com>
 <CAD=FV=XaR6Pq7E-13zR5PC_u=3SD=sc05_TzxWJR2FS040zESg@mail.gmail.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <CAD=FV=XaR6Pq7E-13zR5PC_u=3SD=sc05_TzxWJR2FS040zESg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Doug,

On 10/06/25 03:39, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jun 2, 2025 at 4:05 AM Jayesh Choudhary <j-choudhary@ti.com> wrote:
>>
>> Hello Geert, Krzysztof,
>>
>> (continuing discussion from both patches on this thread...)
>>
>> On 30/05/25 13:25, Geert Uytterhoeven wrote:
>>> Hi Jayesh,
>>>
>>> CC devicetree
>>>
>>> On Fri, 30 May 2025 at 04:54, Jayesh Choudhary <j-choudhary@ti.com> wrote:
>>>> On 29/05/25 16:34, Jayesh Choudhary wrote:
>>>>> By default, HPD was disabled on SN65DSI86 bridge. When the driver was
>>>>> added (commit "a095f15c00e27"), the HPD_DISABLE bit was set in pre-enable
>>>>> call which was moved to other function calls subsequently.
>>>>> Later on, commit "c312b0df3b13" added detect utility for DP mode. But with
>>>>> HPD_DISABLE bit set, all the HPD events are disabled[0] and the debounced
>>>>> state always return 1 (always connected state).
>>>>>
>>>>> Set HPD_DISABLE bit conditionally based on "no-hpd" property.
>>>>> Since the HPD_STATE is reflected correctly only after waiting for debounce
>>>>> time (~100-400ms) and adding this delay in detect() is not feasible
>>>>> owing to the performace impact (glitches and frame drop), remove runtime
>>>>> calls in detect() and add hpd_enable()/disable() bridge hooks with runtime
>>>>> calls, to detect hpd properly without any delay.
>>>>>
>>>>> [0]: <https://www.ti.com/lit/gpn/SN65DSI86> (Pg. 32)
>>>>>
>>>>> Fixes: c312b0df3b13 ("drm/bridge: ti-sn65dsi86: Implement bridge connector operations for DP")
>>>>> Cc: Max Krummenacher <max.krummenacher@toradex.com>
>>>>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>>>>> ---
>>>>>
>>>>> Changelog v2->v3:
>>>>> - Change conditional based on no-hpd property to address [1]
>>>>> - Remove runtime calls in detect() with appropriate comments
>>>>> - Add hpd_enable() and hpd_disable() in drm_bridge_funcs
>>>>> - Not picking up "Tested-by" tag as there are new changes
>>>>>
>>>>> v2 patch link:
>>>>> <https://lore.kernel.org/all/20250508115433.449102-1-j-choudhary@ti.com/>
>>>>>
>>>>> [1]: <https://lore.kernel.org/all/mwh35anw57d6nvre3sguetzq3miu4kd43rokegvul7fk266lys@5h2euthpk7vq/>
>>>
>>> Thanks for your patch!
>>>
>>>>> This would also require dts changes in all the nodes of sn65dsi86
>>>>> to ensure that they have no-hpd property.
>>>>
>>>> DTS patch is posted now:
>>>> <https://lore.kernel.org/all/20250529112423.484232-1-j-choudhary@ti.com/>
>>>
>>> On all Renesas platforms handled by that patch, the DP bridge's HPD pin
>>> is wired to the HPD pin on the mini-DP connector.  What am I missing?
>>
>> If the bridge's HPD is connected to that of the connector, then I am
>> pretty certain HPD will not work for renesas platform. The detect hook
>> always gives "connected" state in the driver (even if it is unplugged).
>> Do you have different observation on your end?
>> If not, then we do need something like this patch while addressing the
>> backwards-compatibility concerns.
>>
>> During v1 RFC[2], I did observe that renesas also have DisplayPort
>> connector type and might require hpd, but since the support was
>> already there and no issue was raised, I assumed it does not require
>> HPD.
>>
>> [2]:
>> https://lore.kernel.org/all/01b43a16-cffa-457f-a2e1-87dd27869d18@ti.com/
>>
>>
>>>
>>> Regardless, breaking backwards-compatibility with existing DTBs is
>>> definitely a no-go.
> 
> FWIW, we are in a little bit of a sticky situation here. We were in a
> bit of a bad place from the start because the Linux driver ignored HPD
> from the beginning but we didn't actually document that people should
> be setting the "no-hpd" property until a little bit later. You can see
> some discussion about this in commit 1dbc979172af ("dt-bindings:
> drm/bridge: ti-sn65dsi86: Document no-hpd") where I noted "this is
> somewhat of a backward-incompatible change." ...but, at the time, it
> wasn't really a big deal because there were very few users (the one in
> tree at the time was cheza, which was a dev board used internally at
> Google).
> 
> ...so, as of that change in May of 2020, it was documented that eDP
> users were _supposed_ to be setting NO_HPD. I even remember Bjorn
> requesting the "or is otherwise unusable" phrasing because we pretty
> much wanted to set this property on everyone using sn65dsi86 as eDP
> (even if they have HPD hooked up) because the debouncing time is so
> long that it was better to hardcode the max delay instead of reading
> the HPD line. Of course, even though we documented that they were
> supposed to have the "no-hpd" property didn't necessarily mean that
> everyone did. The code has never enforced it. I don't believe it even
> checks the property...
> 
> So if there are dts files out there that don't set the property and
> they were submitted after the bindings change in 2020, _technically_
> they've been wrong the whole time. We're not changing history by
> adding a new requirement so much as fixing broken DTS files. Although
> the Linux driver always allowed them to get away with being broken,
> technically DTS is separate from Linux so if they've been violating
> the bindings then they've been wrong. :-P That being said, they've
> been working and it would be nice to keep them working if we can, but
> one could make an argument that maybe it would be OK to require them
> to change...
> 
> 
>> Got it.
>> Let me try to figure out a way to fix it without messing it up.
> 
> While a bit on the ugly side, it seems like perhaps you could just do this:
> 
> 1. If enable_comms is called before the bridge probe happens, just go
> ahead and disable HPD.
> 
> 2. When the bridge probe happens, if you notice that HPD should be
> enabled and comms are on you can just enable HPD then (grabbing the
> comms_mutex while doing it).
> 
> 3. Any subsequent enable_comms called after the bridge probe happens
> shouldn't disable HPD.
> 
> ...you'd probably want a comment about the fact that "no-hpd" property
> is unreliable, which is why we can't figure this out in a better way.
> 
> 


Ernest mentioned in v2[3] that when pdata->bridge.type is not
set, the type field is 0 causing issue for eDP when enable_comms
is called before auxiliary_driver probe.

So it should be okay to check the bridge type for
DRM_MODE_CONNECTOR_Unknown (0) OR DRM_MODE_CONNECTOR_eDP (14) and
disable HPD in both case?
Or equivalently using !(DRM_MODE_CONNECTOR_DisplayPort) as this bridge
would support only these 2 connector types???

Then for DP case, it should behave like you mentioned: First disabling
HPD till types is set in auxiliary_driver probe. And once set to 10,
(for DRM_MODE_CONNECTOR_DisplayPort) enabling it for DisplayPort
connector type.


[3]: 
https://lore.kernel.org/all/mwh35anw57d6nvre3sguetzq3miu4kd43rokegvul7fk266lys@5h2euthpk7vq/

Warm Regards,
Jayesh

> -Doug


