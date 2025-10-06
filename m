Return-Path: <linux-kernel+bounces-842770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A7BBBD866
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A65C18961CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6075C215F42;
	Mon,  6 Oct 2025 09:54:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FA22135D7;
	Mon,  6 Oct 2025 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744497; cv=none; b=rXgfv9BYcDFucb4TFLkXx12RLkda7fecU9EbBaD05o58iNiDLL4SLsJOBW8CUA3wJxfaOyae/k4OAG7fkKBMHsy96YyK+04bMkYu+3j3dCOYf6OVnXVfakeotQMz3XMdY0YTT+qo5e0VD6RFPIEp7PWtBzuODzL7FsuwS1Ooobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744497; c=relaxed/simple;
	bh=rMOOUFNn8ElC+MHoUq6IPchuYxisO0T6N2XlK3jRFLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MZBxtSRmui39o5mIyq5Oxjm760D+GsStxWUFGAu549C7F8XvlzKSc29RUloDB18Dd2P71gxgQTGuR6S4OBN146PT7bfM3I1J/qBbTPxRVtFcyL7Xmn9l65xYHxMGqh5dd1+v0fLWG7aX3eJrh3rximjfeD+iJiV30fGvpZLyyzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 835001515;
	Mon,  6 Oct 2025 02:54:46 -0700 (PDT)
Received: from [10.57.34.189] (unknown [10.57.34.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6E7A3F59E;
	Mon,  6 Oct 2025 02:54:50 -0700 (PDT)
Message-ID: <2e6141f9-be76-41a4-a851-7ac1c31c101e@arm.com>
Date: Mon, 6 Oct 2025 10:54:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/panthor: initial mt8196 support
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250913002155.1163908-1-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250913002155.1163908-1-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/09/2025 01:21, Chia-I Wu wrote:
> MediaTek MT8196 has Mali-G925-Immortalis, for which panthor gained
> support recently. But the soc also requires custom ASN hash to be
> enabled. This series introduces panthor_soc_data for per-soc data and
> uses it to enable custom ASN hash on MT8196.
> 
> The clk/regulator provider on MT8196 is GPUEB, whose driver[1] needs to
> be cleaned up and upstreamed separately.
> 
> This initial support also lacks support for some hw configs. On some
> configs, panthor is expected to query a mask from efuse to mask out
> unavailable shader cores from ptdev->gpu_info.shader_present. This
> requires extending panthor_soc_data with a callback to read the mask.
> 
> This is an RFC because the dependent drivers are not ready yet. But I
> would like to gather opinions on having panthor_soc_data for
> soc-specific data and having CONFIG_DRM_PANTHOR_SOC_MT8196 for
> soc-specific code.
> 
> [1] https://gitlab.freedesktop.org/olv/kernel/-/commit/170d5fc90f817dc90bde54b32872c59cf5c77779

Applied to drm-misc-next.

Thanks,
Steve

> 
> ---
> v2:
> 
> - drop RFC as this series works with the downstream GPUEB driver, and
>   should work with Nicolas's GPUEB driver posted to
>   https://lore.kernel.org/lkml/20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com/
>   with no change.
> - remove CONFIG_DRM_PANTHOR_SOC_MT8196 and panthor_soc*.[ch], as this
>   initial support is just about ASN hash.
> 
> Chia-I Wu (2):
>   dt-bindings: gpu: mali-valhall-csf: add MediaTek MT8196 compatible
>   drm/panthor: add custom ASN_HASH support for mt8196
> 
>  .../bindings/gpu/arm,mali-valhall-csf.yaml    |  1 +
>  drivers/gpu/drm/panthor/panthor_device.c      |  2 ++
>  drivers/gpu/drm/panthor/panthor_device.h      | 14 +++++++++++
>  drivers/gpu/drm/panthor/panthor_drv.c         |  6 +++++
>  drivers/gpu/drm/panthor/panthor_gpu.c         | 25 ++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_regs.h        |  4 +++
>  6 files changed, 51 insertions(+), 1 deletion(-)
> 


