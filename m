Return-Path: <linux-kernel+bounces-796965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C210AB40A1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EB147B236E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2DB324B0C;
	Tue,  2 Sep 2025 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FUUfI3WX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C62D5C8B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829095; cv=none; b=UUnbPumJAaGh5wmeTGSXjYPCfOby2WVjaTJSbF5+721KozmYc7wkzkSeTlk8TObKZy5LEJz01EEWHDN+7SFHGl47YFWtklxnNBUxDNoFWRTWXw4vS0Y8xjcvW7lrlcPnx/jvVNnzOB6MP7nXZrL7lrIFMX8RzYqqhOLBN58767s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829095; c=relaxed/simple;
	bh=ovWdbmcLBmA33JBDYg84OE2PqHzIKb6iNt+T6eoF2kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB7AxXn0eBsyGeoMT5EqqFd5C1eUf9ba7bV1zKYG/oX9RKGszIuLW0T75CMbpHbRRgbkv6tEHbs070Vnm25JQpf8ceuJ7/Ykct2gHwDQEmjauaH9gHCe4v+xgnluWTXSxiKOvZit0Wh05LnAEolSszFEYPw2VwBYS5oxNpvXNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FUUfI3WX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756829092;
	bh=ovWdbmcLBmA33JBDYg84OE2PqHzIKb6iNt+T6eoF2kw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FUUfI3WXYc1B8QJ6WeBpPvR0+1cMVN778Sl29SAmhAoSko8l+RH/Bxm0WuqqyJJW1
	 lrMAWYbfZ80CGBKTAcbSG/5phmbYDtRElhkRWQsS9uubdqJ8wRB8MMfG+ZuqR0EuH5
	 cc4hQYsR8yFJX4o5sAEOP2F17NHZFKm/Loaa7WpvuUrKY1fNLRA9RgbCkxZUyWSGld
	 ZMvRimQ+t3ZM3ANHSvPz18MV+Wjp08FasY9xoJR+TY+A4eE9FUKLI9OF72e5kPK8jO
	 J7wJyFTpc76oxwxhQbs+xMKsWOMZ1oUXQNvGMP9PG9O5KdeNyGwlOdVxEehCPDsBh3
	 4dG8NXOEAcTIg==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E63E17E131D;
	Tue,  2 Sep 2025 18:04:51 +0200 (CEST)
Message-ID: <fc9baa6d-ed38-478b-9338-8a76986639da@collabora.com>
Date: Tue, 2 Sep 2025 19:04:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Introduce BACKGROUND_COLOR DRM CRTC property
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Matt Roper <matthew.d.roper@intel.com>
References: <20250902-rk3588-bgcolor-v1-0-fd97df91d89f@collabora.com>
 <50e3f25c-f4e1-40f6-8e36-23193863f1ee@foss.st.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <50e3f25c-f4e1-40f6-8e36-23193863f1ee@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Raphael,

On 9/2/25 4:19 PM, Raphael Gallais-Pou wrote:
> 
> 
> On 9/2/25 11:27, Cristian Ciocaltea wrote:
>> Some display controllers can be hardware-configured to present non-black
>> colors for pixels which are not covered by any plane (or are exposed
>> through transparent regions of higher planes).
>>
>> The first patch of the series introduces the BACKGROUND_COLOR DRM
>> property that can be attached to a CRTC via a dedicated helper function.
>> A 64-bit ARGB color value format is also defined and can be manipulated
>> with the help of a few utility macros.
> 
> Hi Cristian,
> 
> Thanks for this work ! :)
> 
> FWIW I sent a series also based on Matt's work four years ago:
> https://lore.kernel.org/dri-devel/20210707084557.22443-2-raphael.gallais-pou@foss.st.com/
> 
> IIRC at the time there was some questions around the pixel format used for the
> property, and non-opaque color vs alpha pre-multiplication.
> Mind that on STM32MP platforms alpha channel for the background color is not
> supported.
> 
> Hope the thread can bring some insights.

Thanks for pointing this out, I will consider it for v2.

Regards,
Cristian

