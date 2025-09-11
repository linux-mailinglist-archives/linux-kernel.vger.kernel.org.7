Return-Path: <linux-kernel+bounces-811357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE3EB52806
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58F94676C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752E523A9AE;
	Thu, 11 Sep 2025 05:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUXiklMO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794E329F29;
	Thu, 11 Sep 2025 05:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757567394; cv=none; b=rbzv9J2RlLsWkx6uP21YDfklfPHdC5Da+nzlrpDRx1hJW/yHdLSpYswMx5jtlbsKug/37kSz27JYttShvb0X5gtHYmOK5u5ZPyhQp8Y8vZIO2eDxfw2EiOtfoulNCxduD6DSbwHuJMVsKUp4S3tZG9Au0LmYbyGqvC/7Qdx/Tcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757567394; c=relaxed/simple;
	bh=Ey9contA2Kpz3RtT5dMWiuizXGWkDz6xohXX0manX30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IHZgSPMxHherBbo/CpuMJP7Cr5lozi6b4SHQBGu/qCBvdl05D3wb/IiQbVkFcSvGL4a2osD4V7f6wPw1d/I37bZ3CXXQYyFU4wdrhEcNAa90t5+jhNcYKKNifovvpPODTsxNTe9hKBK1lhCp4eAzeVS1bPX7sUL3WJTNCF0snK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUXiklMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4831BC4CEF1;
	Thu, 11 Sep 2025 05:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757567394;
	bh=Ey9contA2Kpz3RtT5dMWiuizXGWkDz6xohXX0manX30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gUXiklMOCFFLqDMJowfdrtdEt/usyskqJmqZqq1K0C4Kl5idjkrLxyPR8sYlFC9Op
	 Y5oxZBWTksq2X6ZCVT/efzhvY8w7PZOIQfsJ+/CPBHFFtKuihdqVpIIhaSPODJOvCs
	 WUubcF60siSGM0KTuy0iDB5TGc7MwI021j+lIxVca1QYqKdftxIoHh6Ec8vBjsS6Sn
	 Dnf0RVVpAJIWVHCXKrg3w9ikTKcp3MgehAhHzZF7Oj4mqXxATzBDQGhpA1W8+/5bHK
	 ZkxJoI/Vb6tIhCafS+mDDaKcg24lcmZfGq+zYYv3M8ozOySukWREvTKqTQC4RLFZvL
	 ybhC39jgVUGMA==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Diederik de Haas <didi.debian@cknow.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Collabora Kernel Team <kernel@collabora.com>, 
 Michael Riesch <michael.riesch@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, stable@kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
References: <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
Subject: Re: (subset) [PATCH v4 0/7] phy: rockchip:
 phy-rockchip-inno-csidphy: add support for rk3588 variant
Message-Id: <175756738898.509621.6509696151657981708.b4-ty@kernel.org>
Date: Thu, 11 Sep 2025 10:39:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 03 Sep 2025 19:04:48 +0200, Michael Riesch wrote:
> Habidere,
> 
> The Rockchip RK3588 features two MIPI CSI-2 DPHYs (not to be confused with
> the two combo MIPI DSI/CSI CPHY/DPHY blocks). The CSI-2 DPHYs can be
> supported using the existing phy-rockchip-inno-csidphy driver, the notable
> differences being
>  - the control bits in the GRF
>  - the additional reset line
> This patch series adds support for this variant.
> 
> [...]

Applied, thanks!

[6/7] phy: rockchip: phy-rockchip-inno-csidphy: add support for rk3588 variant
      commit: bdb978979ed133c47e19099ff2a4ae51e515452b

Best regards,
-- 
~Vinod



