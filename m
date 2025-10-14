Return-Path: <linux-kernel+bounces-852557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD8CBD952A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4319A4ED8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F67F313E06;
	Tue, 14 Oct 2025 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="DaOYctO2"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DDC31353D;
	Tue, 14 Oct 2025 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444624; cv=none; b=Ml9A0oiLkZnUevKHmvnc38olKn6xUsemW/MCvzNNb8ryzRNCSCc2Cp3YR48K0hrvbVjLhOr8F0xfxqDYOI0cWFnUv2A9gCRjEy1aOOLQ98Dhj9pw5oHxj+7MtBvN2RJJ5QETg59FYGNkNwOvFRgre8Y2B02dODCcavRboz/hi/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444624; c=relaxed/simple;
	bh=CafyeVLIYPhJPVMUhLBEGd8+CQQAGixD0ZmUS6mVJSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vENAQoRtGBbYrh4+1K0aH2MTj9cJtDAzyQfyJ9rIJIRb8CHCUIXpMYV7/A09iZKTf+unULd56uW/cgLDHcQ2afVeslgwVECf4TAZxDC8pulBEpg1xoJ1QkSrxG2X0VwvxaolLFZ1Tpn3NfS7BtnaXQIJ2lupKhxU67aTKp/QXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=DaOYctO2; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=A2wa4K0qWIFLcAnfmzypd+kDyosnJxyDAY3/uLjy03g=; b=DaOYctO2Ib9IIYYgqETAyF2zIt
	0+gdutChlJDPIJbn0lIc0SwMbpflnjgYWoOc7FgRiawhAQkz3x9py/RpPBWx2KjwC06eTD7fneq09
	bJp8jk4J3cRK3O0DZ32q6J+QQnBtn7Yuch+Q5V6lLihMBGmKAPfrwfQwJwNJSINqraC9zCmT40rC0
	AdvyMhuGPULRwEJ7U7cWltvUNxOa67xECIx+3RpFdtsy+6jYWsUbO04FuEhB+0FBHrauAfDjxX6Az
	8eX0hhGCHsZm3ry0U70sKnfyLUXe2QZoTMr6f0tpaMuvj2+vMOCYW47xmewnSGd8YFn+YzsGaDYuT
	cy3bAg7A==;
Received: from i53875b75.versanet.de ([83.135.91.117] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v8e3s-0007Hl-IL; Tue, 14 Oct 2025 14:23:28 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: robh@kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/8] drm/rockchip: Add MIPI DSI support for RK3368
Date: Tue, 14 Oct 2025 14:23:18 +0200
Message-ID: <176044455977.1550590.10827811203766869968.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905025632.222422-1-cn.liweihao@gmail.com>
References: <20250905025632.222422-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 05 Sep 2025 10:56:24 +0800, WeiHao Li wrote:
> This series adds MIPI DSI support for the Rockchip RK3368 SoC, enabling
> native display connectivity through the MIPI DSI host controller and
> PHY. The changes span multiple subsystems, including clock control,
> DRM/VOP integration, DSI controller binding.
> 
> Key changes:
>  - Update dw-mipi-dsi-rockchip driver to preperly handle RK3368 dsi
>    initialization.
>  - Add missing lut_size of vop_data for RK3368.
>  - Add missing clock ID SCLK_MIPIDSI_24M to the RK3368 CRU driver,
>    which is required for enabling the 24MHz reference clock.
>  - Add MIPI DSI node to rk3368.dtsi with correct clocks, resets,
>    and register mappings.
>  - Add dt-bindings document.
> 
> [...]

Applied, thanks!

[1/8] drm/rockchip: dsi: Add support for RK3368
      commit: 6dd6949c76afbec037a66e6b9bcb6e2c5dee933e
[2/8] drm/rockchip: vop: add lut_size for RK3368 vop_data
      commit: 8e944ab8196e421f20386f51c5ffc43baa145932
[8/8] dt-bindings: display: rockchip,dw-mipi-dsi: Document RK3368 DSI
      commit: 2b756d321bf9f4e93437198d212c6ccec137b295


Moved patch8 (dt-binding) in front of patch1 (driver addition)


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

