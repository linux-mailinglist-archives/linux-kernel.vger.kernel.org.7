Return-Path: <linux-kernel+bounces-827690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDB6B926B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A143A1905F87
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222A9314A78;
	Mon, 22 Sep 2025 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDon3sXr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7471B314A60;
	Mon, 22 Sep 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562064; cv=none; b=VzO6k0a/c9qtSfjR3eW60N2KmddaFAkHk8k187Y91yMDJWwO+Ftt7ijJRjLMgSk3o4E0I3L28sFdE0RpcTcyb1zmTsWYIFpCvVTj4eKVYodtWAPQkLGNNYMc8nG8xiMoQBp3UvfbgY2MH8OFwuN44FMktkJjGP+AvgdK6v380Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562064; c=relaxed/simple;
	bh=BDCPXPreQOfMcdNe+4A3EBtLPkqJE0qMq/BEKJDhsOY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=FmCzu1GQ33RRrghAj7SxRiSKfF4GmTwL5ncAv7NrxwhrdHTlYF0dUUMc98wtN1vwmUXr4BfOTVvr4WEBRFT+oEV6Mf/YooIxW0ZkFRjk2lK1UrVW65QwBZJfhh/5ZgyTkuVvbK0WtPa+OIbpvVOueaSIfe/ciHyidyVYnkBR174=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDon3sXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764F6C4CEF0;
	Mon, 22 Sep 2025 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758562064;
	bh=BDCPXPreQOfMcdNe+4A3EBtLPkqJE0qMq/BEKJDhsOY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=RDon3sXrQR1K8LiNK6YafFzN2j9uW5OyeycyOszICqej/mHBaWxmkjK386W8Gfhsq
	 rrAu3/QTPk/mNmuBDgel/kqOI38N/CQ27sOcKkMBYVhA/a48t9NZ4un7Jots2+7BSw
	 glhpi5DyfbDk9Eb685uecglmDJNLsL31AViTqEV61l9lGDOlGC7vyZPz2e0fJUYqy1
	 WPNfXjQzkgiGbp7mfPagbRYtP4Vr1Q96+qNH1CMerR81b1iCx0RKsgfJR69fvCP/9M
	 HlpwvIfiwdu+FJ/A/YWYPJEc2Mh2CiM5KxNN1rXdILM0rGKfra52QLtoCcz2pZVoPM
	 R5GaNHec/lgXA==
Date: Mon, 22 Sep 2025 12:27:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Heiko Stuebner <heiko@sntech.de>, 
 "Leonardo G. Trombetta" <lgtrombetta@gmx.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Ondrej Jirman <megi@xff.cz>
To: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
References: <20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com>
Message-Id: <175856183851.499898.2147562889507523573.robh@kernel.org>
Subject: Re: [PATCH v3 0/5] Upstreaming Pinephone Pro Patches


On Sun, 21 Sep 2025 14:05:53 -0700, Rudraksha Gupta wrote:
> Throughout the years, many have contributed to the Pinephone Pro (ppp)
> development. Unfortunately, these patches are scattered around various
> repositories in different states.
> 
> I will be attempting to upstream these patches. I will start off with the
> following small series:
> - Add light/proximity sensor support
>   - https://codeberg.org/megi/linux/commit/f171bc7013bc7ad3de9af817bfbcbfa548ebe01c
> - Add accelerometer sensor support
>   - https://codeberg.org/megi/linux/commit/b0bb7633e073a6760fa213b8c4a78ea2e73c7bf1
> - Add magnetometer sensor support
>   - https://codeberg.org/megi/linux/commit/2f7e67f451f16eaf15b81aa1dbdf126d54927d35
> - Add mount-matrix for magnetometer
>   - https://codeberg.org/megi/linux/commit/d7cd2eab931e32fa94408a96d73b4e6c0616107a
> - Fix voltage threshold for volume down key
>   - https://codeberg.org/megi/linux/commit/7c496a5cc27ed4e38b740f36c2d8b2c62f80ae54
> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
> Changes in v3:
> - change magnetometer mount matrix
> - update volume button threshold
> - Link to v2: https://lore.kernel.org/r/20250921-ppp_light_accel_mag_vol-down-v2-0-e6bcc6ca74ae@gmail.com
> 
> Changes in v2:
> - remove usb-typec node in dts from light/proximity sensor patch
> - Link to v1: https://lore.kernel.org/r/20250920-ppp_light_accel_mag_vol-down-v1-0-c8bbcd3e2e94@gmail.com
> 
> ---
> Leonardo G. Trombetta (1):
>       arm64: dts: rk3399-pinephone-pro: Add mount-matrix for magnetometer
> 
> Ondrej Jirman (4):
>       arm64: dts: rk3399-pinephone-pro: Add light/proximity sensor support
>       arm64: dts: rk3399-pinephone-pro: Add accelerometer sensor support
>       arm64: dts: rk3399-pinephone-pro: Add magnetometer sensor support
>       arm64: dts: rk3399-pinephone-pro: Fix voltage threshold for volume keys
> 
>  .../boot/dts/rockchip/rk3399-pinephone-pro.dts     | 42 ++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> ---
> base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
> change-id: 20250920-ppp_light_accel_mag_vol-down-817c84fdae8d
> 
> Best regards,
> --
> Rudraksha Gupta <guptarud@gmail.com>
> 
> 
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
 Base: using specified base-commit f83ec76bf285bea5727f478a68b894f5543ca76e

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250921-ppp_light_accel_mag_vol-down-v3-0-7af6651f77e4@gmail.com:

arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dtb: light-sensor@48 (sensortek,stk3311): 'leda-supply', 'vdd-supply' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/light/stk33xx.yaml#






