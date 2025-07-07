Return-Path: <linux-kernel+bounces-720646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E20AFBEBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF53189F36B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0258128A1EA;
	Mon,  7 Jul 2025 23:46:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3007B3594C;
	Mon,  7 Jul 2025 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751931995; cv=none; b=eWJ4X49kzxEC4T+FeGGR/XcKqSakxceVsob4E7Q+LyYc/pyEe7qBzhFsSgIRiioGpc7luaI99v1a7MhL9U1SjUkDRRg+LJkGK+1/y8/eokVf85idqNrfn1heuU3Ghah+r7Lb09zHK75yapK0b3npWS87nTWRnJ97mnnLlPbSuA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751931995; c=relaxed/simple;
	bh=F2m+LN/rIkd7W1JLaA1OGRDZsJ1afAU5vhV4X22gK1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daMGabkb24Ivwej2vdEmzb5OQvi3xA75Skh9tKIRvNChD+PtNXldEzDd8kVORcJ+fpalvhdhmz8HgMs3crKR6Wnq5U8cCflbR00DGGLb5DOidK0QPhEJ65mehUBT1HO9DtJo3wqC4Hc/Ls29q0FwgQNvgv+QyJ3WVDnbRNmDONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E51BA1595;
	Mon,  7 Jul 2025 16:46:20 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E53B3F66E;
	Mon,  7 Jul 2025 16:46:31 -0700 (PDT)
Date: Tue, 8 Jul 2025 00:44:58 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: iuncuim <iuncuim@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: sunxi: a523: Enable Mali GPU
Message-ID: <20250708004458.15a2feae@minigeek.lan>
In-Reply-To: <20250706025625.2707073-1-iuncuim@gmail.com>
References: <20250706025625.2707073-1-iuncuim@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Jul 2025 10:56:21 +0800
iuncuim <iuncuim@gmail.com> wrote:

> From: Mikhail Kalashnikov <iuncuim@gmail.com>
> 
> This patch adds gpu support on devices with a523 processor. Since there is
> no support for image output yet, the gpu is disabled after boot up.
> 
> $ dmesg | grep panfrost
> [    3.826968] panfrost 1800000.gpu: clock rate = 432000000
> [    3.832305] panfrost 1800000.gpu: bus_clock rate = 200000000
> [    3.838353] panfrost 1800000.gpu: mali-g57 id 0x9091 major 0x0 minor 0x1
>                status 0x0
> [    3.846050] panfrost 1800000.gpu: features: 00000000,000019f7, issues:
>                00000001,80000400
> [    3.854134] panfrost 1800000.gpu: Features: L2:0x07110206 Shader:0x00000000
>                Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
> [    3.866011] panfrost 1800000.gpu: shader_present=0x1 l2_present=0x1
> [    3.874108] [drm] Initialized panfrost 1.3.0 for 1800000.gpu on minor 0

So what confidence do we have that this really works, apart from these
successful initialisation messages? Has this been shown to work with
some (yet-out-of-tree) DRM patches, to produce 3D rendered output? I
wonder if we should wait with upstreaming until we can really test this
on some kind of screen.

Cheers,
Andre

> 
> Tested on x96qproplus and walnutpi 2b devices.
> 
> Based on v6.16-rc4 with patches:
> https://lore.kernel.org/all/20250628054438.2864220-1-wens@kernel.org
> https://lore.kernel.org/linux-sunxi/20250628161608.3072968-1-wens@kernel.org
> https://lore.kernel.org/linux-sunxi/20250627152918.2606728-1-wens@kernel.org/
> 
> 
> iuncuim (2):
>   arm64: dts: allwinner: a523: add Mali GPU node
>   arm64: dts: allwinner: a523: enable Mali GPU for all boards
> 
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi    | 15 +++++++++++++++
>  .../boot/dts/allwinner/sun55i-a527-cubie-a5e.dts  |  5 +++++
>  .../boot/dts/allwinner/sun55i-h728-x96qpro+.dts   |  5 +++++
>  .../boot/dts/allwinner/sun55i-t527-avaota-a1.dts  |  5 +++++
>  .../dts/allwinner/sun55i-t527-orangepi-4a.dts     |  5 +++++
>  5 files changed, 35 insertions(+)
> 


