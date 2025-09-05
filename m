Return-Path: <linux-kernel+bounces-802136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C06B44DFB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606AB1C804A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7A52BE7D6;
	Fri,  5 Sep 2025 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e6uAehnC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E62BDC01
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053962; cv=none; b=uvnXCrNk88N3BBkHx8pk3zoB6r8SYe8qVCOoBRWkjDoqzmaQY/fKRPtlXA2xrAekGE2fiGPs8VzODUzQ/f2hBpqn/jzEHJBwNDNzJXkLZJU7dtl4L/m7fnfw8+whG/WrqJmmfpCy8b+0zd9tpgB7YJ+kauxp4CFqzzwdoEvvnuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053962; c=relaxed/simple;
	bh=+7T7YDi0eC3wFyrqKUeCl1oFOAZDbzc81FLfZBDTU+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghZ8IFwlugyqonUXhFg9UWL11xbYWsuSQqSQ1w+TmqsOiA303WVeufEveKS3Dc94prOqEnqLUoafc2OMfk0TQBICf6ujdWOHhtxVmzhumQMiAcDlJEMb5vmMihf1PLuNZkB+35a0Cp/PHQ1/4oh/ktDVKb4oodVlvZ8TLjOqQBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e6uAehnC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757053958;
	bh=+7T7YDi0eC3wFyrqKUeCl1oFOAZDbzc81FLfZBDTU+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e6uAehnCU3Tqg7vgAX2kr5jkq6WsX55n8IXGAc6naznjJwO31ev0KLB4nHeIga/u6
	 s/Tw5J83/aamEgYEr9O7VKjAh9gltJ1IcMeZg+n5z3jqlsy7T9p/xGZuDALzsm1Lx/
	 sJRg5riQaNwg4JEWscp3bkG13Ema7go57AwL6s9VuebsvlpMUVs/I8bNGNY6LfCB6I
	 mYumHDp7L+YBH46ak/A+NsEk8egyxk7fPwNMzKhNQDrNfBlrxcCay25FfBfxxY8Nw3
	 W2Ygtj5WKMrphzQO4jV+7AH/Sg+9JSq6xklGpvL8DJkKetA8dF+7Zfzdh7azuq9Oxr
	 2nUbBnORDUv9Q==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 64EFA17E0EB8;
	Fri,  5 Sep 2025 08:32:37 +0200 (CEST)
Message-ID: <b8d068ef-d083-4bb1-b34e-b8ddaa62b436@collabora.com>
Date: Fri, 5 Sep 2025 09:32:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] Add HDMI CEC support to Rockchip RK3588/RK3576
 SoCs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Algea Cao <algea.cao@rock-chips.com>,
 Derek Foreman <derek.foreman@collabora.com>,
 Daniel Stone <daniels@collabora.com>
References: <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
 <ncmsmxdcvhj4jec6wmqf5abrb7nijx7ac2i33tvvcc2prljez3@uks2cb6aunnx>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <ncmsmxdcvhj4jec6wmqf5abrb7nijx7ac2i33tvvcc2prljez3@uks2cb6aunnx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 9/5/25 2:48 AM, Dmitry Baryshkov wrote:
> On Wed, Sep 03, 2025 at 09:50:58PM +0300, Cristian Ciocaltea wrote:
>> The first patch in the series implements the CEC capability of the
>> Synopsys DesignWare HDMI QP TX controller found in RK3588 & RK3576 Socs.
>> This is based on the downstream code, but rewritten on top of the CEC
>> helpers added recently to the DRM HDMI connector framework.
>>
>> The second patch is needed for RK3576 in order to fixup the timer base
>> setup according to the actual reference clock rate, which differs
>> slightly from RK3588.
>>
>> The following three patches setup platform data with the new information
>> expected by the HDMI QP transmitter library, while improving the error
>> handling in the probe path.
>>
>> Please note the CEC helpers were affected by a resource deallocation
>> issue which could crash the kernel and freeze the system under certain
>> test conditions.  This has been already fixed in v6.17-rc1 via commit
>> 19920ab98e17 ("drm/display: hdmi-cec-helper: Fix adapter
>> unregistration").
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> Cristian, I'm sorry for almost off-topic, but as you are working on this
> driver: would it be possible to support HDMI (vendor-specific) and SPD
> InfoFrames in the dw-hdmi-qp driver?

Sure, no worries.  I'll be on leave for the next two weeks, but I can handle
it on my return.

Regards,
Cristian

