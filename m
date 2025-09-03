Return-Path: <linux-kernel+bounces-799277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F755B42970
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FFB161F50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073132D47F2;
	Wed,  3 Sep 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Mjqf/1i+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B2220EB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926244; cv=none; b=Wxp6OPMtYlbAIXZTVN9sObw59H+8IpgKAkl2mrfwA1CgI+lkoHkOMRcF4Ii0RFDFm4mTQlvWE4K/o5tgtPWaHP4I5HQsrad4mE4gjYmXLl4f5hr5cW28F6lmvk7G1pjI/sfGJlufZ9QWRVJMxAxcqy/lTYI98r0B/UDElA1hmPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926244; c=relaxed/simple;
	bh=9Ua+kHD6dZXWFYSTLBnaWhHDHs7De+8cQbEk82diXxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0mXlTzZLej7PBGkpr8ZnB3T8msbxqr+V3OCSLOILg2hkrr3g9+qXcPHZGLk46KVS0yNS+c/krZEdOJJOHXxDMVMU/g7ZFcsx9W7YSHmh3XksSlJCasjSNcRW6SnH5XNVmnQocdLLkUXh4yVpV5lN802xuHy4600zQBgVUsVxfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Mjqf/1i+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756926240;
	bh=9Ua+kHD6dZXWFYSTLBnaWhHDHs7De+8cQbEk82diXxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mjqf/1i+n2F2T+E2x0S+h/VMNrYClSu5CFnbV+Rp0Y5U+ay1NBWFRhnJi8Jl32NRW
	 FVUhJlfRd4kzjpwBnds9OsX1rSCG7kQ9CFgSRP2QPWPAYt9F+NXjAJJz7AKZ0I9hSx
	 HjYuZhWAktlwABJIoqFSkTutstdSByr9eP88LUlUGzwpIYEswV/kgRGfYsDJeEWogx
	 UW3YlN2Z1KVn2h8J0DhBAFDnzitN841ANZnp7rkLUKdVzhlNxhtNaHW+OsF9TnHoC9
	 Ik2GBlPjCNJCXegw/6/TLtZ3h/zpjNmJzP13UcRj+Omdtl6StOpYF6mmhqjM5DKu+f
	 YFjyxmRkoITEg==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9D09E17E1283;
	Wed,  3 Sep 2025 21:03:59 +0200 (CEST)
Message-ID: <80932583-5055-420b-bd92-9ee9ec7d6c1a@collabora.com>
Date: Wed, 3 Sep 2025 22:03:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] drm/bridge: dw-hdmi-qp: Fixup timer base setup
To: Daniel Stone <daniel@fooishbar.org>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250825-rk3588-hdmi-cec-v3-0-95324fb22592@collabora.com>
 <20250825-rk3588-hdmi-cec-v3-2-95324fb22592@collabora.com>
 <CAPj87rN55DOhWeCU1o0=rOkGbrP4M8v+a6xeB5eboLdCiJ-vzw@mail.gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAPj87rN55DOhWeCU1o0=rOkGbrP4M8v+a6xeB5eboLdCiJ-vzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 8/29/25 6:21 PM, Daniel Stone wrote:
> Hi Cristian,
> 
> On Mon, 25 Aug 2025 at 10:57, Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>> @@ -1255,6 +1254,11 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
>>                 return ERR_PTR(-ENODEV);
>>         }
>>
>> +       if (!plat_data->ref_clk_rate) {
>> +               dev_err(dev, "Missing ref_clk rate\n");
>> +               return ERR_PTR(-ENODEV);
>> +       }
> 
> This introduces another bisect cliff, as the Rockchip integration
> isn't added until patch 5/6, meaning together with the previous patch
> the driver isn't usable between patches 1-5. It would be most sensible
> I think to keep a default until the users have been fixed up. But
> maybe a better sequence for this series would be:
> * dev_err_probe() cleanup (easy, no dependencies)
> * add refclk to plat_data (populated but unused)
> * use refclk instead of hardcoded frequency in bridge driver, make it mandatory
> * add CEC IRQ to plat_data (populated but unused)
> * add CEC support to driver, probably make it not mandatory to provide
> CEC IRQ in DT since it doesn't seem required for correct operation?
> * enable CEC in defconfig

Yeah, this is pretty similar to how the initial series looked like.  The
current sequence follows Heiko's suggestion, which I (still) think it's the
correct approach.

Both bisect issues are now fixed in v4:

https://lore.kernel.org/all/20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com/

Thanks for the review!

Regards,
Cristian

