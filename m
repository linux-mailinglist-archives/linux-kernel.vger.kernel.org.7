Return-Path: <linux-kernel+bounces-893359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CB2C4727A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906733BE88A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5384B3128C8;
	Mon, 10 Nov 2025 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ggTb4Yvk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47D312813
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784546; cv=none; b=A0XzmG6Xe6K4K+poQXs82vziYOGhdxCRQ3UWVS4UUMmq/TJy22fPPtyEAAA10mLzt2wthxh2bRbMQNon4V+AK8kbvl+MnSMAef7IpCU6gub+JvEusdcPpptX135/vRiCBUmvvmhjwKrAuiWrbPKL+IhXqsTVtRfVdvQ5Eg/Xk34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784546; c=relaxed/simple;
	bh=riqluud7DRBnsD2rjaWhV/ylLC40XHZ/UFfYhjGom0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUe5BhZKXbf1sl3CxrJGIMuXzUw2Ge2KkhjHgYCwH7ZN5Ja7zmzSBTaTRobs+ySdWZcHEcVAbL49sMIeWovl5PYEeU7yGzyAYbU9lA1jQ0PKabdIG1juSDPe9r/8TPw0NPI23FIaC3eEh6/vz3UW6UsE4nYUaCf/jfPPPNNdIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ggTb4Yvk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762784543;
	bh=riqluud7DRBnsD2rjaWhV/ylLC40XHZ/UFfYhjGom0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ggTb4YvkwduTIa72FOaubny4AQdcIVM0N2hzfb3g9yhsmd7ewtO18d5tPS+IxfSw4
	 GSSnXzjTkEF1e2nCFMvvaE+gZ/HJp+vU99BRjumDHumlyyiVXAGQ+jtpXbZRbIUaWG
	 7r/+tGhHGessAWBxEPgya7AbYzPEbIzHYxA7bb7JN+R5AHMwjAP1hUmfQuZh01Nym0
	 5LQj+ZjiueEI9J5O4Jy8ghyVqZHwUcYjgDNJFAhY/SrkLlS5I88ji9Qb303tZUlSWu
	 1N86wT9NMg7goRR1FVUO7UeYDSNSpX/xQDTBF/xd4GJ8qKYcFSrkcyh8/jZS9Wojd4
	 B+wUHqMNAVpDw==
Received: from [192.168.1.90] (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 61C7E17E1299;
	Mon, 10 Nov 2025 15:22:22 +0100 (CET)
Message-ID: <0e7d78e0-36ee-4115-b224-dbf4bda87ede@collabora.com>
Date: Mon, 10 Nov 2025 16:22:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Introduce BACKGROUND_COLOR DRM CRTC property
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Robert Mader <robert.mader@collabora.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Matt Roper <matthew.d.roper@intel.com>
References: <20251013-rk3588-bgcolor-v2-0-25cc3810ba8c@collabora.com>
 <x33zabb5un2boben6r4qp3vvrgca5s37gmseespdwwbajumdxx@mcxe6or5p63m>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <x33zabb5un2boben6r4qp3vvrgca5s37gmseespdwwbajumdxx@mcxe6or5p63m>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 11:55 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 13, 2025 at 09:27:17PM +0300, Cristian Ciocaltea wrote:
>> Some display controllers can be hardware-configured to present non-black
>> colors for pixels which are not covered by any plane (or are exposed
>> through transparent regions of higher planes).
>>
>> The first patch of the series introduces the BACKGROUND_COLOR DRM
>> property that can be attached to a CRTC via a dedicated helper function.
>> A 64-bit ARGB color value format is also defined and can be manipulated
>> with the help of a few utility macros.
> 
> 
> Please provide IGT tests. I'd at least check that using the
> BACKGROUND_COLOR results in the same CRC as then one when there is a
> plane covering the whole screen.

Done:

https://lore.kernel.org/all/20251110-crtc-bgcolor-v1-1-28669b692970@collabora.com/

> Additional note. I see a value in having the CRTC property for the
> background colour. However it might be more flexible to reuse old
> proposal for solid fill planes ([1]) and instead implement the lowest
> Z-order plane supporting only solid fill colour as an image source.

Thanks for pointing this out.  Will keep it in mind as for now there is no
(immediate) plan to consider the alternative(s).

