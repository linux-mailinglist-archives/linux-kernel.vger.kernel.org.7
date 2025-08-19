Return-Path: <linux-kernel+bounces-775792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C23B2C4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165631960455
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A38333EB0F;
	Tue, 19 Aug 2025 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HULyFZFo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D433EAED;
	Tue, 19 Aug 2025 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609000; cv=none; b=Dk3kU9zrz865r02mL7y+sV+sA3KpV9UwWG2yPmVI+MAu5Sg6yhrPwSzTolwwok/Rqc2DsrmGLs1c96DoJoa5a4hYliKE4ZI93ue6RBgQNg6NXLVphFSbDmv4eKnlE4k3BOrXpDBsk+NS9CAJVzX9LDhIflAAtK9MbPs8iKzH5RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609000; c=relaxed/simple;
	bh=hD9tklixCimPO7j0d38+GrqpKU9DTflGHV5ucMi/2rs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=SmFm6Lr76Yg3Xd6VzjEeSAjg81F9LQ/DgOLvT7PCvRMbYe5oSVGO95mKYMXkFmaBH8kXtP1dHqqcZ+LQTqPpCO0AQWD08NE75cvtiItvbnvdlsPP3apE+nHf2N/g72SrG35PLJZbQYViasBB9+R2TEIFrW0hwJuop3ApynOLja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HULyFZFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9997FC4CEF1;
	Tue, 19 Aug 2025 13:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755609000;
	bh=hD9tklixCimPO7j0d38+GrqpKU9DTflGHV5ucMi/2rs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=HULyFZFoPK2W5GWcnJ3grCjr5a/JJDnhvW76IKKsUMfq47E10kHpXoz9KbxUnWmL/
	 Iik8wL0rd7DJ5N4TSoObFEIwTn/MvKYzfnna6ztqZjdGkM5o1VBSlimIWUAL71MkDL
	 Dz3hEG7lRJVm5UL1tLGGJbq6DrLifVZvHcXDStQg+JHDahpxZ1+JwLvYrUpVc84WSc
	 JQnChPr6TefUtfPcFMHgv3gGdodpnWZOfxylw9cmOtW8PifF3PnZcoVxQ/jSmav26t
	 TnvB8bjdtO+PddVCeFJH4EQLCP+SyQp4Qa6Ae0psxjZV5LI5CAjEzuDSymH4ZydlwW
	 rZnx+ugfwI7ng==
Date: Tue, 19 Aug 2025 08:09:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Heiko Stuebner <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
In-Reply-To: <20250818-rock5bp-for-upstream-v3-1-d13f3cdec86c@kernel.org>
References: <20250818-rock5bp-for-upstream-v3-1-d13f3cdec86c@kernel.org>
Message-Id: <175560761722.43635.9593798407318901845.robh@kernel.org>
Subject: Re: [PATCH v3] arm64: dts: rockchip: add USB-C support for ROCK
 5B/5B+/5T


On Mon, 18 Aug 2025 20:13:44 +0200, Sebastian Reichel wrote:
> Add hardware description for the USB-C port in the Radxa ROCK 5 Model B
> family. This describes the OHCI, EHCI and XHCI USB parts. The DisplayPort
> AltMode is only partially described, as bindings for the necessary
> DisplayPort controller are still being reviewed.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> This series adds USB-C support for the ROCK 5B, ROCK 5B+ and ROCK 5T.
> 
> Now that [0] has been merged, this should finally work reasonably
> stable. Note, that there is a regression in 6.17-rc1, which breaks
> stable operation again. I've send a revert of that in [1]. I think
> it's time to enable the USB-C interface, so that we can claim further
> breaks as proper regressions :)
> 
> [0] https://lore.kernel.org/all/20250704-fusb302-race-condition-fix-v1-1-239012c0e27a@kernel.org/
> [1] https://lore.kernel.org/linux-usb/20250818-fusb302-unthreaded-irq-v1-1-3a9a11a9f56f@kernel.org/
> 
> Changes in PATCHv3:
>  - Link to v2: https://lore.kernel.org/r/20250508-rock5bp-for-upstream-v2-0-677033cc1ac2@kernel.org
>  - Rebased to latest for-next branch from Heiko
>    - Dropped merged patches for initial ROCK 5B+ support
>  - Renamed series, since it just adds USB-C support now
>  - Fix pinctrl for Rock 5B SBU DC pins
>  - Also handle ROCK 5T
> 
> Changes in PATCHv2:
>  - Link to v1: https://lore.kernel.org/r/20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org
>  - Replaced DT binding patch with the version from NAOKI
>  - Dropped unused pinctrl for vcc5v0_host_en from the shared DT
>  - Moved USB-C SBU DC pins to board specific files, since they differ
>    between Rock 5B and Rock 5B+
>  - Added pinmux for SBU DC pins
>  - Rebased to latest version of Heiko's for-next branch
>  - Disable USB-C on Rock 5B for now
> ---
>  .../boot/dts/rockchip/rk3588-rock-5b-5bp-5t.dtsi   | 136 +++++++++++++++++++++
>  .../boot/dts/rockchip/rk3588-rock-5b-plus.dts      |  12 ++
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  12 ++
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts    |  12 ++
>  4 files changed, 172 insertions(+)
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
 Base: using specified base-commit 7f0817eee7ba40b48e956955d6fd8ba14750168c

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/rockchip/' for 20250818-rock5bp-for-upstream-v3-1-d13f3cdec86c@kernel.org:

arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dtb: pinctrl (rockchip,rk3588-pinctrl): usbc-sbu-dc:rockchip,pins: [[0, 20, 0, 268], [0, 21, 0, 268]] is not of type 'object'
	from schema $id: http://devicetree.org/schemas/pinctrl/rockchip,pinctrl.yaml#






