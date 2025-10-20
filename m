Return-Path: <linux-kernel+bounces-860616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC43BF083A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B853C188E9D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2618290DBB;
	Mon, 20 Oct 2025 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="fPxtP3eO"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33021D618C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955796; cv=none; b=BpytXyQe2mj1FtgkTN2jr2w+EH7UZQO2SuBiyoyy/m8QB4Z6O9ntUcfmjlCimZjRlNNAjJo7Y9/RuPNKKHccGIZfU17nE8RJwMgRxiOhuECX+i7TUv6WuVGaX3LWoHK0RYoMLb+xLYxJMlEwV+KArDeXFOKVqojgvYwvliUeAkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955796; c=relaxed/simple;
	bh=K75g2RiZpjGAiv+bkw19SHxJ4SYE80ZQqGKo8nrczi8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eRNrJGDmxjIB+CNJyK3UJHKJqqxo1efZGVaJjka+xkrv8kK91w0H18u6UR7Qbyz/7pkt9qr793l8o0496Kmnm3gqAbvJNQieREUehzTbCXrYNO0hry2/nPa7PgQCEmIlmpsiMlrFrDEnA4CgZ+3i95ckBaLtCXSui1oI93ZhG3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=fPxtP3eO; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1760955788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNNEOzlbJ+EpRHTDYCWfkhalXUCCgphJIuOM79MU4aM=;
	b=fPxtP3eO4pIybGviOxSGTBl0MzU+7o4PDjmokTLpHHAGISxHzP3X1744e25ke7RiLL+005
	+92q7wEhleYQLj92B/f/Hv1drToatKE7qObN8+gxArTQsEtNRdOuRwtYYPeCnCl97MkN0a
	PrQw3mkZQ3osWueSrcBbh3wikCfWbztfJ17se1Qe/diZ1kAXhfmgh4MqIIURB8ixiggQ5s
	epnzhTpAgC8Nt8dxLs/9rs4do8CKdIYSwHaocGbxhwxpgY5dmMqWx9AbXMTQitoMbVFCgs
	4652qbHH4N68+P/4gWEUUNgzDyLcMm/FI/vH4GsFoJIL4ypQw+8KfmmQebKcfQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 12:23:05 +0200
Message-Id: <DDN2Q7RZKYZR.E49OGFZL7BIW@cknow-tech.com>
Cc: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <quentin.schulz@cherry.de>,
 <andy.yan@rock-chips.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <cn.liweihao@gmail.com>
Subject: Re: [PATCH 0/9] Gernal RK3368 HDMI support and 2 outputs for
 RK3368-Lion
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Heiko Stuebner" <heiko@sntech.de>
References: <20251020082508.3636511-1-heiko@sntech.de>
In-Reply-To: <20251020082508.3636511-1-heiko@sntech.de>
X-Migadu-Flow: FLOW_OUT

Hi Heiko,

On Mon Oct 20, 2025 at 10:24 AM CEST, Heiko Stuebner wrote:
> This series adds the necessary bits for HDMI output on RK3368 and enables
> this on RK3368-Lion. At the same time, use the recently added DSI support
> to enable the generic Video-Demo-adapter as an overlay on Lion as well.

I noticed several 'spelling' issues in various patches, therefor
reporting it against the series:

- s/Gernal/General/ ? (series Subject)
- s/internal in the controller/internal to the controller/ (patch 1)

Incorrect/inconsistent casing (not sure about these though):
- s/phy/PHY/ (patch 2)
- s/soc/SoC/ (patch 3 + 7)
- s/hdmi/HDMI/ (patch 7)
- s/vop/VOP/ (patch 7)

- s/the newer one that/the newer ones that/ ? (correct if there is only
  1 newer) (patch 3)
- s/devicetree already is set up/devicetree is already set up/ (patch 3)
- s/definitly/definitely/ (patch 4 + 5)
- s/to no cause/to not cause/ (patch 4 + 5)
- s/power-domain property/power-domains property/ (patch 4 + 5)
- s/hirarchy/hierarchy/ (patch 6)
- s/is change at/is changed at/ (patch 6)

Sorry ;-P

Diederik

>
> The reason I'm shaving this Yak is that the recently added DSI support
> created DTC warnings about a single endpoint with an address.
>
> So it was either removing the @0 from the endpoint, or adding a second
> output option :-) .
>
>
> Heiko Stuebner (9):
>   dt-bindings: display: rockchip: dw-hdmi: Add compatible for RK3368
>     HDMI
>   drm/rockchip: hdmi: add RK3368 controller variant
>   soc: rockchip: grf: Add select correct PWM implementation on RK3368
>   arm64: dts: rockchip: Add power-domain to RK3368 DSI controller
>   arm64: dts: rockchip: Add power-domain to RK3368 VOP controller
>   arm64: dts: rockchip: Use phandle for i2c_lvds_blc on rk3368-lion
>     haikou
>   arm64: dts: rockchip: Add HDMI node to RK3368
>   arm64: dts: rockchip: Enable HDMI output on RK3368-Lion-Haikou
>   arm64: dts: rockchip: Add the Video-Demo overlay for Lion Haikou
>
>  .../display/rockchip/rockchip,dw-hdmi.yaml    |   1 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   5 +
>  .../rk3368-lion-haikou-video-demo.dtso        | 174 ++++++++++++++++++
>  .../boot/dts/rockchip/rk3368-lion-haikou.dts  |  36 +++-
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi      |  45 +++++
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  16 ++
>  drivers/soc/rockchip/grf.c                    |   1 +
>  7 files changed, 268 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lion-haikou-video=
-demo.dtso


