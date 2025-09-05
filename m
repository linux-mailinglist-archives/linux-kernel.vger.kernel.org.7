Return-Path: <linux-kernel+bounces-803496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B41B46090
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC6D5C267E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ECE37C0FE;
	Fri,  5 Sep 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugt0Gko+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4F37C0FA;
	Fri,  5 Sep 2025 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094307; cv=none; b=tf9/UullWtvii4nabmC+c5p84TR3vuKJ/pHs6pJa5P9sz+LhjqMQzzraKycKr/ft6VoD6jKR+S6Pm3pFMjAYgkTIcNv2uTp1byhD0B91bh24xDy+se+8k3FU3tgLsvWfeip8LOcMguaTfKBo/QLxNd8kFkQgUkKljjfAp8OtIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094307; c=relaxed/simple;
	bh=qTi3deyURA+o4yjmNVEYbTqALgAHIt7cNmW+V7nDrPQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=LatVf+pQ6UF1blrVzcEKq35MqS4S1cgJWM606GIUIczB6BjebVCNCxf2CH0O0jOvDxwW7A6+XgAv7TIFLLYFuuzO3rs5m260+pFQ9ynEzPsgx1oFj2XU5jUBqLZuGvyOxGZR5lU3kYRrn4aKuIwCMF27GYyWaMZN5JaBXOdA/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugt0Gko+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E92DC4CEF1;
	Fri,  5 Sep 2025 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757094306;
	bh=qTi3deyURA+o4yjmNVEYbTqALgAHIt7cNmW+V7nDrPQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Ugt0Gko+03jwdaV6Miq6KVIAwzYFR6iqsRO9o5y9GQYZfyAiaNQcZs1/cX1yj3d11
	 iJ2l0iqV1qLbzMpFceBhP9G8pMRUpUeSHvNdlyf62QZP9Cq0BhWeI79lGZHLpgg/pX
	 mKmBQFapHk/enEo1HFX3G9z10MfRIv7vvmZW4ff4NyihaNM6KvWvvhAjnKqdvENbdT
	 UV1eHVeUx9Xk9W7QmNDndZ61rYa09P21sVd5c7KRNuVBI3GpFBnQw3/4uuCRLHIpqj
	 qFfr2j+d6tY7rYEUfgs2v0FVbkPxgI9WY5+0uEJVvrzcPvh52ScV5gM9fVftVoOccw
	 j2ZLmGPN/QHeg==
Date: Fri, 05 Sep 2025 12:45:06 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
In-Reply-To: <de71cbe5db3347756d3173245d01e091d3ad1b50.1757062843.git.marcin@juszkiewicz.com.pl>
References: <de71cbe5db3347756d3173245d01e091d3ad1b50.1757062843.git.marcin@juszkiewicz.com.pl>
Message-Id: <175709416351.988787.3563603110895477506.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Add vcc supply for SPI Flash on
 NanoPC-T6


On Fri, 05 Sep 2025 11:18:59 +0200, Marcin Juszkiewicz wrote:
> FriendlyELEC NanoPC-T6 LTS schematics shows VCC_1V8_S3 being used to
> power SPI NOR chip.
> 
> This fixes the following kernel message:
> 
> spi-nor spi5.0: supply vcc not found, using dummy regulator
> 
> Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250904 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for de71cbe5db3347756d3173245d01e091d3ad1b50.1757062843.git.marcin@juszkiewicz.com.pl:

vcc-supply: size (14) error for type phandle
vcc-supply: size (14) error for type phandle
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dtb: flash@0 (jedec,spi-nor): vcc-supply: 'oneOf' conditional failed, one must be fixed:
	b'<&vcc_1v8_s3>\x00' is not of type 'object'
	b'<&vcc_1v8_s3>\x00' is not of type 'array'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-lts.dtb: flash@0 (jedec,spi-nor): vcc-supply: b'<&vcc_1v8_s3>\x00' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtb: flash@0 (jedec,spi-nor): vcc-supply: 'oneOf' conditional failed, one must be fixed:
	b'<&vcc_1v8_s3>\x00' is not of type 'object'
	b'<&vcc_1v8_s3>\x00' is not of type 'array'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtb: flash@0 (jedec,spi-nor): vcc-supply: b'<&vcc_1v8_s3>\x00' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#






