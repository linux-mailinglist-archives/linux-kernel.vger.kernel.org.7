Return-Path: <linux-kernel+bounces-859950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B723BEF072
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2743E034A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2E81A9FB5;
	Mon, 20 Oct 2025 01:41:39 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374F17C21C;
	Mon, 20 Oct 2025 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760924499; cv=none; b=Mdkt9xQlzSGOQWG8SEimTAKUKFh3PRv2g6TdtyoAIPtim3vdW1W468TgNi9PX5hcjI/2ZT33KUqJBj1V776aFNuBJI+vVvmRNX7uWtK/cPOzdRg2MglBxDR/kOBO4Y8ASft203h4WE5IMw7SvWTWY2AHSZvoqbLIHV9FCkwSD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760924499; c=relaxed/simple;
	bh=Vx7blcGcPvvTXHnvBqe21Ki1yTcXHROvXp1gnli/n2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKiEk6zLfMMtM6oPnJKKMhFzCxTiBzKxwbcrzHUeioEtw0sZjk3d8OoEO9PK5NVAzKT+TD7NXYP/I/evz33n2Ge0ZvH0OLgGKmS3+78fto9a0FmGepBAyAg5cHbhb/GC7l6dj7tmeyBV9n3hkcjGcAC0N7luNbat79/2y94t2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 664F0341540;
	Mon, 20 Oct 2025 01:41:36 +0000 (UTC)
Date: Mon, 20 Oct 2025 09:41:32 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: riscv: spacemit: add MusePi Pro board
Message-ID: <20251020014132-GYE1506524@gentoo.org>
References: <20251017-k1-musepi-pro-dts-v3-0-40b05491699f@linux.spacemit.com>
 <20251017-k1-musepi-pro-dts-v3-1-40b05491699f@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-k1-musepi-pro-dts-v3-1-40b05491699f@linux.spacemit.com>

Hi Troy,

On 13:52 Fri 17 Oct     , Troy Mitchell wrote:
> Document the compatible string for the MusePi Pro [1]. It is a 1.8-inch
> single board computer based on the SpacemiT K1/M1 RISC-V SoC [2].
> 
> Here's a refined list of its core features for consideration:
>   - SoC: SpacemiT M1/K1, 8-core 64-bit RISC-V with 2.0 TOPS AI power.
..
>          This suggests potential for light AI/ML workloads on-device.
drop these additional marketing info, just give neutral technical description
>   - Memory: LPDDR4X @ 2400MT/s, available in 8GB & 16GB options.

..
>             Sufficient for various workloads.
ditto
>   - Storage: Onboard eMMC 5.1 (64GB/128GB options). M.2 M-Key for NVMe
>              SSD (2230 size), and a microSD slot (UHS-II) for expansion.
..
>              Good variety for boot and data.
ditto
>   - Display: HDMI 1.4 (1080P@60Hz) and 2-lane MIPI DSI FPC (1080P@60Hz).
..
>              Standard display options.
ditto, please check more bellow yourself..

>   - Connectivity: Onboard Wi-Fi 6 & Bluetooth 5.2. A single Gigabit
>                   Ethernet port (RJ45). Given the stated markets,
>                   this should cover basic networking.
>   - USB: 4x USB 3.0 Type-A (host) and 1x USB 2.0 Type-C (device/OTG).
>          Decent host capabilities.
>   - Expansion: Full-size miniPCIe slot for assorted modules
>                (4G/5G, wireless etc.). A second M.2 M-Key (2230) for more
>                general PCIe devices (SSD, PCIe-to-SATA, comm boards).
>   - GPIO: Standard 40-pin GPIO interface, as expected for an SBC.
>   - MIPI: Includes 1x 4-lane MIPI CSI FPC and 2x MIPI DSI FPC interfaces
>           for cameras and displays.
>   - Clock: Onboard RTC with battery support.
> 
> Link: https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
> Link: https://www.spacemit.com/en/key-stone-k1 [2]
> 
no blank line here
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
> Changelog in v3:
> - nothing
> - Link to v2: https://lore.kernel.org/all/20251010-k1-musepi-pro-dts-v2-1-6e1b491f6f3e@linux.spacemit.com/
> 
> Changelog in v2:
> - modify commit message
> - Link to v1: https://lore.kernel.org/all/20250928-k1-musepi-pro-dts-v1-1-5efcca0ce3ae@linux.spacemit.com/
> ---
>  Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> index c56b62a6299ac24d3cdef7edcdfc407dc62a1846..52fe39296031f21d1c28c4f1ea5ca9fe28caf45a 100644
> --- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
> +++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
> @@ -22,6 +22,7 @@ properties:
>            - enum:
>                - bananapi,bpi-f3
>                - milkv,jupiter
> +              - spacemit,musepi-pro
>                - xunlong,orangepi-rv2
>            - const: spacemit,k1
>  
> 
> -- 
> 2.51.0
> 

-- 
Yixun Lan (dlan)

