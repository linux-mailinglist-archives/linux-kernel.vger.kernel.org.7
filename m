Return-Path: <linux-kernel+bounces-899542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F00DFC5819B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73E084E612A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9821DF74F;
	Thu, 13 Nov 2025 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T8vElxvm"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A7723D7D2;
	Thu, 13 Nov 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045886; cv=none; b=pJpzZX0OBvJ5DwLCj03Xp+QMzx+riVRe8wc5/21WiVwGz8sDX8+sIj0/45aJLPsz/Zw4in2r+q9wIXkf8PiMfxmxQ7xcQEnHdyEUC/KvH3w0YpZLy+YCfqkl+nmLS2DxKi4EwEU+2ETcjGA9jZAQAmpdt316I+dd2T2YFjzAOUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045886; c=relaxed/simple;
	bh=3Uu21/c6Hbs21uxpxbmZo7JhKjwRedtSvTBuDxAnxMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=bnoZm8SBNOZsSdawEKekpcm89RPqcM6qCt4lQL1o0R3wobLYkGCgwwNg16R/aSLxGSY9/7GT7fbd404fK77bfUVYtGDyqnGdjop0PTlxMt1Jy49YeN+ZlLsT6wHIDYWKOZoH5j1aPRF6ejAO5TcWtdS5RVVqoaYXjamilF1qyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=T8vElxvm; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251113145759euoutp01fef0a97a0ebaf8bd2c8d8fa9cc795730~3mOLljyiZ1322713227euoutp012;
	Thu, 13 Nov 2025 14:57:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251113145759euoutp01fef0a97a0ebaf8bd2c8d8fa9cc795730~3mOLljyiZ1322713227euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763045879;
	bh=ogp7tQuY4ykhbwHIKUJTRYSar7oRQokZNx6TlxIJ+5c=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=T8vElxvmkwwSu1Wl5s0VXj6iVdl2A5s7iYFjmFeFPouxsJm1ZPkAuL/pj3v38TcxU
	 /xoPUpVOskKRLjECmF0grhpoxv/PVum1bvXNYzG6n+Owrs/cxRuPbe4zkZQdEvAzaI
	 PFjnHtKU80hgiAFcv2hYlDM5zIbRHGRMVNt0srsQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251113145758eucas1p1bca3e4e91b329de9c52de40c7d86d093~3mOLC8LIJ0576905769eucas1p1J;
	Thu, 13 Nov 2025 14:57:58 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251113145757eusmtip2959d20c844dc6203e206300997e642d0~3mOJlt2ga3124231242eusmtip2e;
	Thu, 13 Nov 2025 14:57:57 +0000 (GMT)
Message-ID: <e1696331-1271-46a8-adb6-9fed4521f22b@samsung.com>
Date: Thu, 13 Nov 2025 15:57:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/13] drm: starfive: jh7110: Enable display
 subsystem
To: Conor Dooley <conor@kernel.org>, Maxime Ripard <mripard@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Dmitry Baryshkov
	<dmitry.baryshkov@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>, Hal Feng
	<hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Xingyu
	Wu <xingyu.wu@starfivetech.com>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay
	Abraham I <kishon@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
	Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
	<jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>, Philipp
	Zabel <p.zabel@pengutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Icenowy Zheng <uwu@icenowy.me>, Maud Spierings
	<maudspierings@gocontroll.com>, Andy Yan <andyshrk@163.com>, Heiko Stuebner
	<heiko@sntech.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20251111-matriarch-diocese-b314e7bdaf81@spud>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251113145758eucas1p1bca3e4e91b329de9c52de40c7d86d093
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251108010451eucas1p1c7bf340dbd2b1b7cbfb53d6debce7a2e
X-EPHeader: CA
X-CMS-RootMailID: 20251108010451eucas1p1c7bf340dbd2b1b7cbfb53d6debce7a2e
References: <CGME20251108010451eucas1p1c7bf340dbd2b1b7cbfb53d6debce7a2e@eucas1p1.samsung.com>
	<20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>
	<20251110-clang-baking-b8b27730356e@spud>
	<00e897dc-9966-439b-a74a-7604a1870027@samsung.com>
	<20251111-footing-eclair-332f5f0769f2@spud>
	<20251111-matriarch-diocese-b314e7bdaf81@spud>



On 11/11/25 19:37, Conor Dooley wrote:
> On Tue, Nov 11, 2025 at 06:14:48PM +0000, Conor Dooley wrote:
>> On Tue, Nov 11, 2025 at 04:33:28PM +0100, Michal Wilczynski wrote:
>>>
>>>
>>> On 11/10/25 20:35, Conor Dooley wrote:
>>>> On Sat, Nov 08, 2025 at 02:04:34AM +0100, Michal Wilczynski wrote:
>>>>> This series enables the display subsystem on the StarFive JH7110 SoC.
>>>>> This hardware has a complex set of dependencies that this series aims to
>>>>> solve.
>>>>>
>>>>> I believe this is a PHY tuning issue that can be fixed in the new
>>>>> phy-jh7110-inno-hdmi.c driver without changing the overall architecture.
>>>>> I plan to continue debugging these modes and will submit follow up fixes
>>>>> as needed.
>>>>>
>>>>> The core architectural plumbing is sound and ready for review.
>>>>>
>>>>> Notes:
>>>>> - The JH7110 does not have a centralized MAINTAINERS entry like the
>>>>>   TH1520, and driver maintainership seems fragmented. I have therefore
>>>>>   added a MAINTAINERS entry for the display subsystem and am willing to
>>>>>   help with its maintenance.
>>>>
>>>> Yeah, bunch of different folks wrote the drivers, so lots of entries.
>>>> Pretty much all as you've done here, authors are responsible for the
>>>> individual components and Emil is the platform maintainer but
>>>> responsible for most drivers.
>>>>
>>>> Do you need any feedback dt wise on the RFC, or is it too likely that
>>>> we'll both waste our breath if the DRM folks don't approve of your
>>>> approach for the rest of this series?
>>>
>>> Hi Conor,
>>>
>>> Thank you for your response.
>>>
>>> That's a fair point about the risk of the DRM approach being rejected.
>>> While I can't be certain, I'm hopeful that part is relatively
>>> straightforward, as it primarily integrates other recently reviewed
>>> (though not yet merged) components like the inno-hdmi bridge and dc8200
>>> drivers.
>>>
>>> To be honest, I was more concerned that the DT part of the series would
>>> be more problematic. Given that, I would find it very helpful to get
>>> your feedback on the DT aspects now, if you have the time.
>>
>> Right. You'll definitely want some actual DRM people to weigh in though
>> before making changes, I am really not familiar enough with this type of
>> hardware to know if the breakdown is correct.
> 
> It looks generally sane to me chief, but as I said I am not really
> familiar enough with this sort of hardware to have a real take on it.
> Sorry, you'll need to get your affirmation about how you've laid stuff
> out elsewhere :/

Thanks for the look, Conor.

I appreciate the sanity check on the DT side. I'll focus on getting the
necessary feedback from the DRM maintainers regarding the architectural
breakdown before spinning a v2.

[Adding Dmitry Baryshkov and highlighting Maxime, Heiko, and Robert]

Could you folks take a brief look at the driver split in this series?

Conor has reviewed the DT bindings and they look sane to him, but we
need to verify that the architectural split between the
phy-jh7110-inno-hdmi and the DRM bridge driver is acceptable for this
Innosilicon IP.

I am particularly interested if the current handling of the PHY tuning
parameters (as described in the cover letter) fits the modern DRM
bridge/PHY paradigm, or if this should be modeled differently given the
similarities to Rockchip implementations.

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

