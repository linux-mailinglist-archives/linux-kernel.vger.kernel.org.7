Return-Path: <linux-kernel+bounces-771462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E238EB2879F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969511D02E22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A5A25F7B5;
	Fri, 15 Aug 2025 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsEt8QSy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DC4257431;
	Fri, 15 Aug 2025 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755292750; cv=none; b=Lg8IJfnAnIekl8bVII9dgq4Ig8ju9LKuelehnW47wfm1xq77/Q8sbyGEfZqS4QGrvqg34V8FOpyh+A9bhkPf8R8m5JdC2LqzmsS//czMjTLOThPMLWVnXkFys9um4CweEwdAJRNgTN+9o0uPUJmmJzjx8eJvffbvSttkJRetclc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755292750; c=relaxed/simple;
	bh=K+r06jLu5/QfCZbN9piqdk/fiyOGa1TyF6QkY5xklXQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=mNtbjFMmWENcuWdvzu2E6y0ijkRQrl73EBxuJuGBTNNelGdJtQiII50ubUpWLd3+H73K3Z19XAuspp6nI8FXbw39cOpd/ug4DU6OlzmxbehEHvIP1LFQGV2R3DglIGi4Xz4yBsdrwxl+r0YcqnQ3EwXQ6qrIlyoBUUyzcdAUIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsEt8QSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C7EC4CEF8;
	Fri, 15 Aug 2025 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755292750;
	bh=K+r06jLu5/QfCZbN9piqdk/fiyOGa1TyF6QkY5xklXQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=IsEt8QSynFtXD1ppIMy6AyN46/r047g46cJcO6Fnm0A0yh+84FoNWyizkrNntmYrF
	 ATInUU6ByuKliIMsIlocgSgfhe3f9NlYYwlHwfqu2l38TqT3oNT5wjjLvFz+ZXFzC2
	 2fCGv0bWrWRoWzkMr4mrdHq2+Zt0OWylWuHhgrAgWXxSyQGGz1ijTdIV92JC3bm4oL
	 GEokvA1QfeE6WIhntjac/k65bxdohAqh+eu6Dl1yGHAsfueEViFyG4JeH4OgelV5Pf
	 A+rmN0XB4RvY314InNBPak8WyZCgfHH0D7XfYVfoT8jdVlGDAWvmrOXO4gEFKfMC0a
	 yu7t2cPtj11Ew==
Date: Fri, 15 Aug 2025 16:19:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-aspeed@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, Joel Stanley <joel@jms.id.au>
To: Fred Chen <fredchen.openbmc@gmail.com>
In-Reply-To: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
References: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
Message-Id: <175529259974.3212367.16366822597087067588.robh@kernel.org>
Subject: Re: [PATCH v2 0/4] Revise Meta Santabarbara devicetree


On Thu, 14 Aug 2025 21:16:56 +0800, Fred Chen wrote:
> Summary:
> Revise linux device tree entry related to Meta (Facebook) Santabarbara.
> 
> Change log
> v1 -> v2:
>   - add 'bmc_ready_noled' LED and update commit message
>   - add sgpio line name for leak detection
> v1:
>   - add sensor nodes for extension board
>   - add mctp node for NIC
>   - adjust LED configuration
> 
> Fred Chen (4):
>   ARM: dts: aspeed: santabarbara: add sensor support for extension
>     boards
>   ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
>   ARM: dts: aspeed: santabarbara: Adjust LED configuration
>   ARM: dts: aspeed: santabarbara: add sgpio line name for leak detection
> 
>  .../aspeed-bmc-facebook-santabarbara.dts      | 857 +++++++++++++++++-
>  1 file changed, 853 insertions(+), 4 deletions(-)
> 
> --
> 2.49.0
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
 Base: attempting to guess base-commit...
 Base: tags/v6.17-rc1-9-g8e4021078863 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250814131706.1567067-1-fredchen.openbmc@gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dtb: mctp@10 (mctp-i2c-controller): 'label' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/net/mctp-i2c-controller.yaml#






