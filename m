Return-Path: <linux-kernel+bounces-722866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E446FAFE00C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6B85802A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3EA26B759;
	Wed,  9 Jul 2025 06:40:16 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662226B747;
	Wed,  9 Jul 2025 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043216; cv=none; b=DLrRwU2zblsgH+xHBsy2T4KWicEumFRKoDdTuqzRcn3r3hpEjFq9HwoXM+qZ4eoAJ8SWhwRZgzfxN7On2lv5Es4KCm/vwN4GxAhzqwTRmyF5G+rZqXHEm5tp6etk39pQAAtKb08x/ovv7uBdfX2qhSUYt0szeemzIlIqJQ6SeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043216; c=relaxed/simple;
	bh=suDFXnHHjhzMT+/dWYw8Trmg7iQUUvL+tJ/Qy5arM1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pra5g2J0escna4WpNpRTs4Ke8Zmy6Y//haBQq59aAEY3dfsN3YyvxXb9LkbS/lYJvK1aVGDgUjeF7qqiKttLScKKxnZvZCnJ5eNWuViM/MD5Ay88Z8V9pLYgDTGAVYCTar3OiJa8AtSoFmzrlywxHfr65elb/9XvtEldHO83g/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id D336D341FF2;
	Wed, 09 Jul 2025 06:40:13 +0000 (UTC)
Date: Wed, 9 Jul 2025 06:40:09 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Guodong Xu <guodong@riscstar.com>, Ze Huang <huangze@whut.edu.cn>,
	Alex Elder <elder@riscstar.com>, spacemit@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <uwu@dram.page>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] riscv: dts: spacemit: Add DMA translation buses for
 K1
Message-ID: <20250709064009-GYB487904@gentoo>
References: <20250623-k1-dma-buses-rfc-wip-v1-0-c0144082061f@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623-k1-dma-buses-rfc-wip-v1-0-c0144082061f@iscas.ac.cn>


On 18:04 Mon 23 Jun     , Vivian Wang wrote:
> The SpacemiT K1 has various static translations of DMA accesses. This
> series adds all the DMA translation bus nodes and also moves existing
> nodes as necessary.
> 
> According to SpacemiT DT maintainer Yixun Lan [1], it's preferable from
> a SoC DT maintainer's perspective to have this done at once instead of
> spreading these changes into various driver series. Once this is merged,
> life will be easier for future users of the buses.
> 
> This series contains no bindings changes.
> 
> Patch 3 moves the eMMC node added in [1].
> 
> These patches can also be pulled from:
> 
> https://github.com/dramforever/linux/tree/k1/dma-ranges/v1
> 
> [1]: https://lore.kernel.org/r/20250623070147-GYA193822@gentoo
> [2]: https://lore.kernel.org/r/20250523-22-k1-sdhci-v1-1-6e0adddf7494@gentoo.org
> 

Hi Krzysztof,

  Just want to clarify, I believe you previous concern about the
"children of simple-bus are supposed to have unit addresses" [3] isn't
really an issue any more.. but, please let me know if I'm wrong..


Hi Vivian,

  We'd like to push this series for v6.17, so I've queued it at
k1/dt-for-next branch of SpacemiT SoC tree [4] for now, FYI.

Link: https://lore.kernel.org/all/2dc8ab35-4f58-49d3-8e8b-3e463fa592ae@kernel.org/ [3]
Link: https://github.com/spacemit-com/linux/tree/k1/dt-for-next [4]

Thanks all
-- 
Yixun Lan (dlan)

