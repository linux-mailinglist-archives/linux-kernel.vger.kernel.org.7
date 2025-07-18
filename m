Return-Path: <linux-kernel+bounces-736555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2673B09E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818BC1C461F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515C72951BA;
	Fri, 18 Jul 2025 08:57:27 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD04293C71;
	Fri, 18 Jul 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829047; cv=none; b=QIH7dsRjBCNT2U8ebYrmIkHMBzJc83mG4YS7vLULS1Rcta3yS0fPJfOcYBimliMoASrM2GG9oWEW3pzsikUvTIA5HNYDjDgnSZoTNvBmAKhBwpYpDp0lm3vWMLgfLJTg/6wbORX4l2C2Wj95BZUnA2a5rzxzPTkBNAdT/Kws6as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829047; c=relaxed/simple;
	bh=BFY+IxRuBFr/iFz/G4FLwSrMJiiq+y6V9xbm3Y51T3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgAnA/FGzr/2TgTEsj8QprD7h8dW45fYQNp9NoHS5/wABDag0JFZ9eYGdFVS8gyozTIemvIgFkkehUSrJD6Magvl0TPyFpclCpAx9eUOfCpcUL93K5HzlAJiJCgvWODtbhInfkBz3Q02k5g1jxh/lO5DMOlpOtkzi6UzFHjBFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C9436340EF5;
	Fri, 18 Jul 2025 08:57:23 +0000 (UTC)
Date: Fri, 18 Jul 2025 16:57:18 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	palmer@dabbelt.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] riscv: dts: spacemit: Add initial support for
 OrangePi RV2
Message-ID: <20250718085718-GYA695709@gentoo>
References: <20250718084339.471449-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718084339.471449-1-hendrik.hamerlinck@hammernet.be>

Hi Hendrik,

On 10:43 Fri 18 Jul     , Hendrik Hamerlinck wrote:
> This patchset adds initial device tree support for the OrangePi RV2 board.
> 
> The OrangePi RV2 [1] is marketed as using the Ky X1 SoC.
> However, after research and testing, it is in fact identical to the 
> SpacemiT K1 [2]. This is supported by the following:
> 
> - Similar integration in the Banana Pi kernel tree [3], which uses the 
>   OrangePi RV2 and identifies it as the SpacemiT K1.
> - Comparison of the device tree code showing a match to the OrangePi RV2 
>   Linux tree [4].
> - Locally tested the OrangePi RV2 with the SpacemiT K1 device tree, 
>   confirming it boots and operates correctly.
> 
> Patch #1 documents the compatible string for the OrangePi RV2, and 
> patch #2 adds its minimal device tree. This enables booting to a serial
> console with UART output and blinking a LED, similar to other K1-based 
> boards such as the Banana Pi BPI-F3 or the Milk-V Jupiter.
> 
> Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-RV2.html [1]
> Link: https://www.spacemit.com/en/key-stone-k1 [2]
> Link: https://github.com/BPI-SINOVOIP/pi-linux/blob/linux-6.6.63-k1/arch/riscv/boot/dts/spacemit/k1-x_orangepi-rv2.dts [3]
> Link: https://github.com/orangepi-xunlong/linux-orangepi/tree/orange-pi-6.6-ky [4]
> 
> Changes in v2:
> Patch 1: no changes.
> Patch 2:
> - Added aliases section to the device tree.
> - Removed the memory section, as it is populated by the bootloader.
> - Updated copyright header.
> 
Looks good

Reviewed-by: Yixun Lan <dlan@gentoo.org>

-- 
Yixun Lan (dlan)

