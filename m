Return-Path: <linux-kernel+bounces-874062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AC7C156A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553341886455
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1AA33A029;
	Tue, 28 Oct 2025 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KE1qR1mc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2521239E7F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665087; cv=none; b=hVXgXoP2pPsHQwVnT9bOso8p7+a0uXHlyEO8UEnuCeYUTeA3YB9XyNnHODWoDOk+SEGOt3SMOXDBPRH9Sl9VZUT1/btOiH7rPNBosXaqQUdel7fg+RgqMqUd+1E0N3vMSwEkXkQ+p3LX1yJWPvm/Oyoz8N7KmQngVztk/pLZdE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665087; c=relaxed/simple;
	bh=aNk99UalTGwijupNSbWQmEeAIhQV4fyxuz2lZ6raB8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gD/mIHcnV5Ou8WP9cpsV42iStFKDpAYoT3IURt/7OhvPu+aMdRlnqDdjMe1cuQz1agmnU9z0gPipX5RmkTqsXnZpJnLiaZJurW1I0CVwWS3CsCg2KBaOEu0n0qWdDo+lV9Sfuv+KklkeePdKHo89d66f/ozou6S7bXxbAghpLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KE1qR1mc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761665083;
	bh=aNk99UalTGwijupNSbWQmEeAIhQV4fyxuz2lZ6raB8U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KE1qR1mcIPBMQqUvCOe8SKBlL6lza7JasYZqvvO4b+yB5WfVxZOIEO/mfAoOLAkU/
	 +RdF+PDdbqoUsbewOURnFmifJabsAdpv2em5BVXV+7q97zlFiE7Qyg9Z4VjslvysT7
	 Qjy0WeaDD08lo7onj8AJir70MxZEiGUjJ7PBZ8jkrEJpTEMqhRY7+miWxygdy3tN8j
	 uOWGKfL60s9uklDgn18/ZE67xH8i1BS1nVY/+74evb3NgbGB7WdMrcRbqgY7nMK0KF
	 UsO/4bdwBjeMeZRbXZH4qq/TOcI5xi9Gu8nVSG+AHDwb7Rci94DZ/7rIIa1saxcz5h
	 89AyVnQGBJXxQ==
Received: from [192.168.1.90] (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BF23917E055D;
	Tue, 28 Oct 2025 16:24:42 +0100 (CET)
Message-ID: <13c3810b-8197-4a42-9089-d20a78b8126f@collabora.com>
Date: Tue, 28 Oct 2025 17:24:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] Add HDMI CEC support to Rockchip RK3588/RK3576
 SoCs
To: Mark Brown <broonie@kernel.org>
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
 linux-kernel@vger.kernel.org, Algea Cao <algea.cao@rock-chips.com>,
 Derek Foreman <derek.foreman@collabora.com>,
 Daniel Stone <daniels@collabora.com>, Aishwarya.TCV@arm.com
References: <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
 <6f3f126d-72c1-48cb-a9c8-8d354af2a3d5@sirena.org.uk>
 <410fa913-e86b-4ffd-9d79-ce804f0271ff@collabora.com>
 <63003a7e-8d3d-433a-8a44-54fe8740bc3a@collabora.com>
 <5678895e-2647-42db-b3f0-86a21b9bc225@sirena.org.uk>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <5678895e-2647-42db-b3f0-86a21b9bc225@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 5:08 PM, Mark Brown wrote:
> On Tue, Oct 28, 2025 at 04:57:03PM +0200, Cristian Ciocaltea wrote:
> 
>> This seems to have been already addressed:
> 
>> https://lore.kernel.org/all/20251017-drm-bridge-alloc-getput-bridge-connector-fix-hdmi_cec-v2-0-667abf6d47c0@bootlin.com/
> 
> Ah, good.  Hopefully that lands soon, do you have any idea what's
> holding it up?

I guess it's just the complexity, since that is part of a larger work concerning DRM bridges:

https://lore.kernel.org/all/20250926-drm-bridge-alloc-getput-bridge-connector-v2-1-138b4bb70576@bootlin.com/

