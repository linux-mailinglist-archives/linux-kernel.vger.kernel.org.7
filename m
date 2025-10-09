Return-Path: <linux-kernel+bounces-846419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E77BC7F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374433B0F01
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D241226B97E;
	Thu,  9 Oct 2025 08:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Mhz3p0ZV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5F2AD16;
	Thu,  9 Oct 2025 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997485; cv=none; b=a5Hv7MkzgKQrxwTyFSku9uZO8IpE7XeIoqwmdd40P5+zUHWBv7Gzxle4UIOY/50m1CjxQmOXVlvkzXHuKasdtIcMnJS8FRij4cy9mhOgBpg26dmODMdyJ5ngl5EKHB3UmOV7dSdmViZCwfvSWfG5SQs9ia5puYuiqUaHQQZv0to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997485; c=relaxed/simple;
	bh=RonmEpmFdrB09Svc53FAuCpnvVaVT54HD6tdAJ0cFQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHzZEZUksGAFcZW07o6694PW6SiySInJ1yWoVWqAmOABUM0rpJHMogXkLVT+spACGtVhRKso9CVbRO9fvy15BsggoVHjsxAH4EYqkHK7HnCZt+ETtUMMYnTvkfI+d1xP8yrjfGBMDv45LVyy46XM8gOG7PgMXMVkyg76dGVnsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Mhz3p0ZV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759997480;
	bh=RonmEpmFdrB09Svc53FAuCpnvVaVT54HD6tdAJ0cFQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mhz3p0ZVX9O1CutU7zlEGA4ra5OMgPtDCSibRrTWwyneiKTQ9BBB10pKUWY/fXpFm
	 o3HGNDyCUMrmYHKi7aC9pYwdthz3daiGHrO0ED59aBVLmxXqPMFrJmWgl9teFtRGji
	 x8NBrOidn9zdAvTyiKJlb4lb8eUhHWeuxn55yO4e+vP/m5p837GthVUiUbwvxACBtQ
	 uuMBT0+VKw/57PGMq5CchHbhKoAGE7FHu8rokYi3j+KKChxYYH/ZXq69xbHMif1i1Y
	 38JB52fg3urkBU3Ou06rMSVNnSizpAL2bgpxgaXDfBYSN9W8/hV3yXCavuLA8+Gwqw
	 byj/jLn0pwL2g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 10FA617E04DA;
	Thu,  9 Oct 2025 10:11:20 +0200 (CEST)
Message-ID: <8e733d4c-c982-4edb-98f9-c6a24fa24aec@collabora.com>
Date: Thu, 9 Oct 2025 10:11:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] clk: mediatek: Pass device to clk_hw_register for
 PLLs
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Laura Nao <laura.nao@collabora.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>
References: <20251008-mtk-pll-rpm-v2-0-170ed0698560@collabora.com>
 <20251008-mtk-pll-rpm-v2-3-170ed0698560@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251008-mtk-pll-rpm-v2-3-170ed0698560@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/10/25 18:05, Nicolas Frattaroli ha scritto:
> Passing the struct device pointer to clk_hw_register allows for runtime
> power management to work for the registered clock controllers. However,
> the mediatek PLL clocks do not do this.
> 
> Change this by adding a struct device pointer argument to
> mtk_clk_register_pll, and fix up the only other user of it. Also add a
> new member to the struct mtk_clk_pll for the struct device pointer,
> which is set by mtk_clk_register_pll and is used by
> mtk_clk_register_pll_ops.
> 
> If mtk_clk_register_pll is called with a NULL struct device pointer,
> then everything still works as expected; the clock core will simply
> treat them as previously, i.e. without runtime power management.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



