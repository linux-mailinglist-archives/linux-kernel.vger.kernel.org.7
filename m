Return-Path: <linux-kernel+bounces-873779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E4C14ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE48F346358
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7B530B514;
	Tue, 28 Oct 2025 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="StBeXySm"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D47C2DE1E2
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655380; cv=none; b=oulmbvapMco+rhFjYdM0MCsn23mn7/iBeNR5+DL0GQMr4btSOMlDr69Vaqcn8ZrerRjT4mRK6hoevXDv+/+j3/Mow0hdBR+Fz27HrOqoSvTnCRVxOwHEJp/6CFHkpmaHmo2sjl3TJxEXKW8b1u6GD5+KPph4tKiQRrcMT7KcWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655380; c=relaxed/simple;
	bh=u0Rc6uddmvyN6A9OgBxIwz2e4v43ymsLxM3TDcEIbKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZ8tck6rjeKp5LyxvWWxYniZUevK3lKHNEzli3ZZBiBZJoLnNJE8ufoa6mvtmbfE4k4jHM/LgGnWC3kYzLTZ+cOYWaiTKkg3vR9v3B81fpW8AEy1prXnu0pmo6AkwqfiOGgAZs14rsfuuqSXjAjzZWkhhVvCh0652GObRPkIQTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=StBeXySm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761655370;
	bh=u0Rc6uddmvyN6A9OgBxIwz2e4v43ymsLxM3TDcEIbKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=StBeXySmJjGSd1xFRKwCwHY5JXlO8LMuQ6NNDIDliO3nbsaTrwe2GjQ4nC3M5HEi6
	 jF2qtHilep9UT1TEXah25dWzbBVN4RNLz6baHmPXj/PulKUSmgZLkg7TL8d9UXo15P
	 MEd9IThinC+GxvZR9t7QmQ4PrI47cVgmV/7GjQtR8tkgTWacQR3neGIxFzH5Vp6fEu
	 92lf964rtDYc9RFWH+P2lzGUmMfdNUsB3ECMMwqlBe+s2lpG6mt1ikFkBSW7ifizAl
	 bcJk8WFoCc34avz+tVuY9xhY0SsU0jGAftWx4JPZXGp0TP7CnrdutiZ2JCE3XLSdy8
	 SDuHL1eaO3uvw==
Received: from [192.168.1.90] (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C49D917E12BA;
	Tue, 28 Oct 2025 13:42:49 +0100 (CET)
Message-ID: <410fa913-e86b-4ffd-9d79-ce804f0271ff@collabora.com>
Date: Tue, 28 Oct 2025 14:42:49 +0200
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
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <6f3f126d-72c1-48cb-a9c8-8d354af2a3d5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

On 10/28/25 2:38 PM, Mark Brown wrote:
> On Wed, Sep 03, 2025 at 09:50:58PM +0300, Cristian Ciocaltea wrote:
>> The first patch in the series implements the CEC capability of the
>> Synopsys DesignWare HDMI QP TX controller found in RK3588 & RK3576 Socs.
>> This is based on the downstream code, but rewritten on top of the CEC
>> helpers added recently to the DRM HDMI connector framework.
> 
> For the past couple of weeks we've been seeing various instability with
> the graphics drivers on the Rock 5B in -next, the most common system is
> that we get faults in code that looks suspiciously relevant to this
> series:
> 
> <6>[   17.353368] rockchip-drm display-subsystem: bound fdd90000.vop (ops vop2_component_ops [rockchipdrm])
> <6>[   17.355237] dwhdmiqp-rockchip fde80000.hdmi: registered DesignWare HDMI QP I2C bus driver
> / # <1>[   17.357803] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000098
> 
> ...
> 
> <4>[   17.372390] Hardware name: Radxa ROCK 5B (DT)
> 
> ...
> 
> <4>[   17.382082] Call trace:
> <4>[   17.382317]  drm_bridge_connector_hdmi_cec_init+0x8/0x38 [drm_display_helper] (P)
> <4>[   17.383003]  drm_bridge_connector_init+0x658/0x678 [drm_display_helper]
> <4>[   17.383612]  dw_hdmi_qp_rockchip_bind+0x35c/0x4d8 [rockchipdrm]
> <4>[   17.384159]  component_bind_all+0x118/0x248
> <4>[   17.384550]  rockchip_drm_bind+0xb4/0x20c [rockchipdrm]
> <4>[   17.385034]  try_to_bring_up_aggregate_device+0x164/0x1d0
> <4>[   17.385528]  component_master_add_with_match+0xc4/0x104
> <4>[   17.386008]  rockchip_drm_platform_probe+0x1f8/0x31c [rockchipdrm]
> 
> (from today's -next, 
> 
> Unfortunately we haven't managed to point at a specific commit, it looks
> like this might be triggered by multiple serieses interacting with each
> other.  I'm not sure what other information might be useful here?

Thanks for reporting, I will investigate.

Regards,
Cristian

