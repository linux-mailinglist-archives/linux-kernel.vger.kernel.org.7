Return-Path: <linux-kernel+bounces-721632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEBFAFCBD8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDFB483708
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B852DCF68;
	Tue,  8 Jul 2025 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dvey3kkV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FFF2DCBF7;
	Tue,  8 Jul 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981016; cv=none; b=fn+2M6QI8nYSLfsB6GObWNQvP32T25mm796eZdpADl98u7R6ml5W3zuPZ7wNFaT1KbO+ZEum+sMiBV8i7xc/+do73BgyKr3VkBzlU5tegvaHX7LMgagl8EkkidO1MxYf94eWBPefkIh/3uZxfal0ptkfaOIsTyr8R1QHAbikVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981016; c=relaxed/simple;
	bh=kG5yQ4Z0omO38H0cx6vA3VUsN+la842ikKfx/Pkvzds=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ai4dPuEJxf6pWEdckvMu5UuNY4AbE7NZGlFrgkSJkuwL/wED36Kv+EFLQZF4XuBBHjXXcbU1EU4ko0Kc0oMUkg1mQy512jX1w3XjOXTbXlfUeMio2QFxPrG5e6maulj0GBulxSqFArGno1PlBsV50rI7hhirbrx61ErB3JjEcZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dvey3kkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23DAC4CEED;
	Tue,  8 Jul 2025 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751981015;
	bh=kG5yQ4Z0omO38H0cx6vA3VUsN+la842ikKfx/Pkvzds=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Dvey3kkVvoDRgilLqHRQwtysdmaJHNksaZZaxZOz/Q0SrLBbH7QEMmvl8le3jMbsY
	 DL6R4AapbMHL3yjiiz6WDE6N9QHZbgGA0AQZtBPrda6zWn5w6fqQ2AAL2Od7B/7FIa
	 Pt4Xcta8PVEBtEDyCuQ3MV8R3c8ZsgeWXlyVQ5VfXt7fLJ5hzdxMKm6H0Sl6LvIDS6
	 1KAmOX4zMdaiLHdZGxEUwBpRp5LkmUTaKkZeCI1fVchf7VyG+DpwYMeW3AC0gZ7ryO
	 NveFnIAk7fJQXg8eefGXjFpXQwBGXmM59SA6jvezMlP63kGJIWs//srLaEk6i3n6JA
	 nbKu8iKZI1uNQ==
Date: Tue, 08 Jul 2025 08:23:34 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: s-vadapalli@ti.com, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 linux-arm-kernel@lists.infradead.org, Tero Kristo <kristo@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20250708084252.1028191-1-c-vankar@ti.com>
References: <20250708084252.1028191-1-c-vankar@ti.com>
Message-Id: <175198090755.436953.6586253094300469079.robh@kernel.org>
Subject: Re: [PATCH v5 0/4] Add bootph-all property to enable Ethernet boot


On Tue, 08 Jul 2025 14:12:48 +0530, Chintan Vankar wrote:
> This series adds bootph-all property to necessary nodes to enable
> ethernet boot support for SK-AM68, AM62P5-SK, J722S, and SK-AM69.
> 
> This series is based on commit '8d6c58332c7a' of linux-next tagged
> next-20250703.
> 
> Link to v4:
> https://lore.kernel.org/r/20250429072644.2400295-1-c-vankar@ti.com/
> 
> Changes from v4 to v5:
> - Updated [PATCH v4 2/2] by adding properties to the respective board
>   files and split [PATCH v4 2/2] for AM62P5-SK and J722S-EVM.
> - Added a new patch to enable Ethernet boot on SK-AM69.
> 
> This series is based on linux-next tagged next-20250428.
> 
> Chintan Vankar (4):
>   arm64: dts: ti: k3-am68-sk-base-board: Add bootph-all property to
>     enable Ethernet boot
>   arm64: dts: ti: k3-am62p5-sk: Add bootph-all property to enable
>     Ethernet boot
>   arm64: dts: ti: k3-j722s-evm: Add bootph-all property to enable
>     Ethernet boot
>   arm64: dts: ti: k3-am69-sk: Add bootph-all property to enable Ethernet
>     boot
> 
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts          |  7 +++++++
>  arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 12 ++++++++++++
>  arch/arm64/boot/dts/ti/k3-am69-sk.dts            | 12 ++++++++++++
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts          |  8 ++++++++
>  4 files changed, 39 insertions(+)
> 
> --
> 2.34.1
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
 Base: tags/next-20250704 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/ti/' for 20250708084252.1028191-1-c-vankar@ti.com:

arch/arm64/boot/dts/ti/k3-am69-sk.dtb: pinctrl@4301c068 (ti,j7200-padconf): mcu-cpsw-default-pins: 'booph-all' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#






