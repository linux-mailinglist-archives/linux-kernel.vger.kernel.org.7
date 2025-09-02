Return-Path: <linux-kernel+bounces-796563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BC8B4027A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE0C7AFA3A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD7D304BDE;
	Tue,  2 Sep 2025 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz/OlBga"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836E0302777;
	Tue,  2 Sep 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819064; cv=none; b=SuBXyhiVZEZoZotc+Ks94TqBSzFwwXoyJWoJEw6KhHCWFj2dbP6cN1hvUgHf1YKbxJ/iLloGGu/q9/yK4Yy75HOfFTWgXWJV84XItHpClYDDmGueCHq7CYZpISMrGRZZ86mLoVVpX2X7FuOitB7xy3SnkixFqIU87bI9fymxYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819064; c=relaxed/simple;
	bh=apcyxtU2BfTEuwGJmPoxK78BUoU73MBDkSB83mC20sg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=C14RpXzpk17SdYrwCO0shmwtWfRJMmAWDJ2aU8f+cOu40OAI6tK8e91OMzegUrQSsZIg8cpg8wtBXHsBgmh7626j8fhY0PzZnep4OPeI936C7w45cQBrKwG4EyWRgUg+FbBz78UuJyQuerS26hTdqWxf5XETo2yZE1U3Z6jhkRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz/OlBga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C79C4CEED;
	Tue,  2 Sep 2025 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756819064;
	bh=apcyxtU2BfTEuwGJmPoxK78BUoU73MBDkSB83mC20sg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Uz/OlBgaC+w8NLJANKHBevuL6qZ7J/gpSGqFeotyS0j8p+uDqeRN4BsE9mlCitLgG
	 Xntog9q3fPpgv6iRy4weq0Vrm+NnPlyUGLZNptlMXkCSnVhKo2G4X20HgM52juBxIt
	 ZSUhuBTReMUoYMVDVbk20iealcBE654OjiGMnuWnEFIiM/qQ6DupXP9/3z79RMQezA
	 L7+eWIhTg8MfKFl9zNNRzjsgwur1UtZh2zG+yZJDGUzg0pyXSTKjvDM5oBCW7BZ83P
	 UwxrLfzzVTVCWLbsRG7iZrjtFVrREIIZgC0zSyeMR8H3tXA+XADufJGkDm0j8tVBeA
	 4MZ80CAzs2RCw==
Date: Tue, 02 Sep 2025 08:17:40 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Alex Bee <knaerzche@gmail.com>, linux-kernel@vger.kernel.org, 
 Rob Herring <robh+dt@kernel.org>, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
To: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20250830115135.3549305-1-christianshewitt@gmail.com>
References: <20250830115135.3549305-1-christianshewitt@gmail.com>
Message-Id: <175678730682.877806.14001841198578934927.robh@kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: add GPU powerdomain, opps,
 and cooling to rk3328


On Sat, 30 Aug 2025 11:51:34 +0000, Christian Hewitt wrote:
> From: Alex Bee <knaerzche@gmail.com>
> 
> Add GPU powerdomain, opp-table, and cooling map nodes for the Mali
> GPU on the RK3328 SoC. Opp-table frequencies are sourced from the
> Rockchip Linux v4.4 vendor kernel while voltages have been derived
> from practical use and support work: keeping voltage above 1075mV
> and disabling the 500MHz opp-point avoids instability and crashes.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
> These changes have been in-use with Armbian and LibreELEC for many
> years without issue. Investigations into crashing (esp. with rkvdec
> running) have led to voltage tweaks and dropping 500MHz. Changes
> cannot be justified in technical detail, but are field proven over
> a large number of users, boards, and cheap power supplies.
> 
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 39 +++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
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
 Base: tags/next-20250829 (best guess, 2/4 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250830115135.3549305-1-christianshewitt@gmail.com:

arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dtb: gpu-opp-table (operating-points-v2): $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dtb: gpu-opp-table (operating-points-v2): Unevaluated properties are not allowed ('opp-200000000', 'opp-300000000', 'opp-400000000', 'opp-500000000' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-rock64.dtb: gpu-opp-table (operating-points-v2): $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtb: gpu-opp-table (operating-points-v2): $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-rock64.dtb: gpu-opp-table (operating-points-v2): Unevaluated properties are not allowed ('opp-200000000', 'opp-300000000', 'opp-400000000', 'opp-500000000' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dtb: gpu-opp-table (operating-points-v2): Unevaluated properties are not allowed ('opp-200000000', 'opp-300000000', 'opp-400000000', 'opp-500000000' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtb: gpu-opp-table (operating-points-v2): $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtb: gpu-opp-table (operating-points-v2): Unevaluated properties are not allowed ('opp-200000000', 'opp-300000000', 'opp-400000000', 'opp-500000000' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtb: gpu-opp-table (operating-points-v2): $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c.dtb: gpu-opp-table (operating-points-v2): Unevaluated properties are not allowed ('opp-200000000', 'opp-300000000', 'opp-400000000', 'opp-500000000' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dtb: gpu-opp-table (operating-points-v2): $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dtb: gpu-opp-table (operating-points-v2): Unevaluated properties are not allowed ('opp-200000000', 'opp-300000000', 'opp-400000000', 'opp-500000000' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dtb: gpu-opp-table (operating-points-v2): $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dtb: gpu-opp-table (operating-points-v2): Unevaluated properties are not allowed ('opp-200000000', 'opp-300000000', 'opp-400000000', 'opp-500000000' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dtb: gpu-opp-table (operating-points-v2): $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2c-plus.dtb: gpu-opp-table (operating-points-v2): Unevaluated properties are not allowed ('opp-200000000', 'opp-300000000', 'opp-400000000', 'opp-500000000' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-evb.dtb: gpu-opp-table (operating-points-v2): $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-evb.dtb: gpu-opp-table (operating-points-v2): Unevaluated properties are not allowed ('opp-200000000', 'opp-300000000', 'opp-400000000', 'opp-500000000' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dtb: gpu-opp-table (operating-points-v2): $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dtb: gpu-opp-table (operating-points-v2): Unevaluated properties are not allowed ('opp-200000000', 'opp-300000000', 'opp-400000000', 'opp-500000000' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dtb: gpu-opp-table (operating-points-v2): $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dtb: gpu-opp-table (operating-points-v2): Unevaluated properties are not allowed ('opp-200000000', 'opp-300000000', 'opp-400000000', 'opp-500000000' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-a1.dtb: gpu-opp-table (operating-points-v2): $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-a1.dtb: gpu-opp-table (operating-points-v2): Unevaluated properties are not allowed ('opp-200000000', 'opp-300000000', 'opp-400000000', 'opp-500000000' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dtb: gpu-opp-table (operating-points-v2): $nodename:0: 'gpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dtb: gpu-opp-table (operating-points-v2): Unevaluated properties are not allowed ('opp-200000000', 'opp-300000000', 'opp-400000000', 'opp-500000000' were unexpected)
	from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#






