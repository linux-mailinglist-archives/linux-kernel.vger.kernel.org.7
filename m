Return-Path: <linux-kernel+bounces-867087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EB0C018C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B12C2504783
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BB031A072;
	Thu, 23 Oct 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezmCck8H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF65315D5B;
	Thu, 23 Oct 2025 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227516; cv=none; b=Et6K6rAcNUrKy5l4ZavkvWKhn6QRzNthNcv2cbgyl/xzW4PGiwIlq5iu6Su8vG6q0o1nko2v2GojiUeG9BkMOpiweYnFoxwCh6DcNTc9Kde6mWos4fvJTK6KQmQy7dclH90gOLH+JHO989Iw5HsdSJrlfeFFbyx92eI+SOBXnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227516; c=relaxed/simple;
	bh=DXeHBjKEeneTJZlQx6fpzgXCOREPFNRGyyrxXvEZiNk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=tN9nvcUDddolaUsVdm6ysmY90Dqrm6mZbrioPWlq/J8L7w0F2Uo82dvRuimK92JA/zdMbxJLWtn9dtSKhGLX8iWc7mhv+iON+bEz+qSQu/eXYsRKywLY98rCkInjQIWpfQmm1a22Q3hfH6lDOYy8ZThJqFY6f4nJLoXfYK76ZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezmCck8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323C2C4CEE7;
	Thu, 23 Oct 2025 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761227516;
	bh=DXeHBjKEeneTJZlQx6fpzgXCOREPFNRGyyrxXvEZiNk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ezmCck8HjERzYtIbyeAk8k8JFFC7WAL+MzMBmlQHocwoefe7nXgZFuSEJV7oHoNys
	 IJyxU4mnGm/kkFZMoj96m3/Cs8Z5GbcPhGHaqOBBgHWoSPpnHnqyNyFFDB68QmZttj
	 I2fN+FSPIb4Zy/ld+mJyvpcCRiDJm+P67+lzeFGuqopXhAs5Jn7jPmCumUZMzViHnJ
	 +CcYunoaVNrcd6BqZ+ajONsql5vxd3s8Y2G/gv5YDWXNU9ZJFEXoJ667oLAiiZn2Nm
	 i1XYz/fp29FGwj+xFwLisKahgfuRoM454NpgEs0ef+fYwq/FozPmLCX7eBlMb9WUEd
	 DFM6RI3YbNDzw==
Date: Thu, 23 Oct 2025 08:51:54 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20251022133616.74492-2-krzysztof.kozlowski@linaro.org>
References: <20251022133616.74492-2-krzysztof.kozlowski@linaro.org>
Message-Id: <176122700613.2723214.10060174362415881339.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: toshiba: tmpv7708: Align node names with
 DT bindings


On Wed, 22 Oct 2025 15:36:17 +0200, Krzysztof Kozlowski wrote:
> DT bindings expect node names to follow certain pattern, dtbs_check
> warnings:
> 
>   tmpv7708-rm-mbrc.dtb: pmux@24190000 (toshiba,tmpv7708-pinctrl):
>     'pwm_mux' does not match any of the regexes: '-pins$', '^pinctrl-[0-9]+$'
>   tmpv7708-rm-mbrc.dtb pmux@24190000 (toshiba,tmpv7708-pinctrl):
>     $nodename:0: 'pmux@24190000' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
>   tmpv7708-rm-mbrc.dtb: wdt@28330000 (toshiba,visconti-wdt):
>     $nodename:0: 'wdt@28330000' does not match '^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/toshiba/tmpv7708.dtsi      | 4 ++--
>  arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
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
 Base: tags/v6.18-rc1-10-gc35cf4fe4b85 (exact match)
 Base: tags/v6.18-rc1-10-gc35cf4fe4b85 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/toshiba/' for 20251022133616.74492-2-krzysztof.kozlowski@linaro.org:

arch/arm64/boot/dts/toshiba/tmpv7708-visrobo-vrb.dtb: pinctrl@24190000 (toshiba,tmpv7708-pinctrl): spi0-pins:groups: ['spi0_grp', 'spi0_cs0_grp'] is too long
	from schema $id: http://devicetree.org/schemas/pinctrl/toshiba,visconti-pinctrl.yaml
arch/arm64/boot/dts/toshiba/tmpv7708-visrobo-vrb.dtb: pinctrl@24190000 (toshiba,tmpv7708-pinctrl): spi0-pins:groups: ['spi0_grp', 'spi0_cs0_grp'] is too long
	from schema $id: http://devicetree.org/schemas/pinctrl/toshiba,visconti-pinctrl.yaml
arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dtb: pinctrl@24190000 (toshiba,tmpv7708-pinctrl): pwm-pins:groups: ['pwm0_gpio16_grp', 'pwm1_gpio17_grp', 'pwm2_gpio18_grp', 'pwm3_gpio19_grp'] is too long
	from schema $id: http://devicetree.org/schemas/pinctrl/toshiba,visconti-pinctrl.yaml
arch/arm64/boot/dts/toshiba/tmpv7708-rm-mbrc.dtb: pinctrl@24190000 (toshiba,tmpv7708-pinctrl): pwm-pins:groups: ['pwm0_gpio16_grp', 'pwm1_gpio17_grp', 'pwm2_gpio18_grp', 'pwm3_gpio19_grp'] is too long
	from schema $id: http://devicetree.org/schemas/pinctrl/toshiba,visconti-pinctrl.yaml






