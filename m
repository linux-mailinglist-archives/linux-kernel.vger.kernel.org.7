Return-Path: <linux-kernel+bounces-761564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28812B1FBEB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 21:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC5B174CA9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 19:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD931E8320;
	Sun, 10 Aug 2025 19:30:31 +0000 (UTC)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485DE1388;
	Sun, 10 Aug 2025 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754854230; cv=none; b=EnHLIvLj4jqiUW64yXsYEf1tHfK+mDpF6aAVtF6aHjyrVzYVTZqRXwlfYwk9AUSmp9TAQyBOfCgAvG1Nv5/TDnfeiqrz59HdNVSEWf/6t0GJheWVXUd2Y8oewLBWOLu5+wsUmhSbMXX1+GH0gxyWh/naCJvrgBg7+gFmN4KfTls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754854230; c=relaxed/simple;
	bh=bAhpJhaPv6V4Pq/zY3xiNp+/8EUYDtVDuv5AVjZxVTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKVqAqRiS+4S8TEYNTx5BfHF8PD7ZTAhtY81StkulZ0c69lR5WixEatfLACWKhJyp3ViZWg16eFcpGbnCUMGGxfhigCEbpPvUfw5b8RXDa1IP4cGzEFtjtN6O/hDiEfpjAqU/YeIwUUoa2pk6ICVibCqXcAGLA3O08XkChW0rL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 019474955FE8; Sun, 10 Aug 2025 21:22:54 +0200 (CEST)
Date: Sun, 10 Aug 2025 21:22:54 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Niklas Cassel <cassel@kernel.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Alexey Charkov <alchark@gmail.com>,
	Patrick Wildt <patrick@blueri.se>, Chukun Pan <amadeus@jmu.edu.cn>,
	Diederik de Haas <didi.debian@cknow.org>,
	Chris Morgan <macromorgan@hotmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: Add the vdpu381 Video
 Decoders on RK3588
Message-ID: <aJjxjgG1gEaKBVwE@desktop>
References: <20250808193602.142527-1-detlev.casanova@collabora.com>
 <20250808193602.142527-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808193602.142527-2-detlev.casanova@collabora.com>
Jabber-ID: linkmauve@linkmauve.fr

Hi,

On Fri, Aug 08, 2025 at 03:36:01PM -0400, Detlev Casanova wrote:
> Add the vdpu381 Video Decoders to the rk3588-base devicetree.
> 
> The RK3588 based SoCs all embed 2 vdpu381 decoders.
> This also adds the dedicated IOMMU controllers.

Back in the VEPU121 enablement series[1] it had been decided to not
expose multiple identical cores yet, because there is no infrastructure
yet in the kernel to schedule multiple userland processes on multiple
cores, or (more relevant for your usecase) to even combine two cores to
reach 8K support.

> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 

[snip]

Thanks,

[1] https://lore.kernel.org/all/20240618183816.77597-1-sebastian.reichel@collabora.com/

-- 
Link Mauve

