Return-Path: <linux-kernel+bounces-725364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B877AFFE16
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1792617CF0E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D472BEC2F;
	Thu, 10 Jul 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="VCHMzfkl"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1D296165;
	Thu, 10 Jul 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139650; cv=none; b=CSvD7jnhrKY2fHGlEEC7uF54ZAzAE5hsk0sU2/EBBeQ/IimHQuEkGDffh6gLnelPCpK2qy93doCP1wej1pDtW9FZK5cUZ5ke8BPnoBqvbKcG/cpXNtim8YFy9VK2zwe2132jk5e1zzzIRsTXACBRKIuonaAsJwVeySGPF1Nq7mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139650; c=relaxed/simple;
	bh=bBnL62zRbnP7/GZBWnvMd62iPxbIsZcVeUtFwIb7SXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PylyaGpkk9kF68SywnQDJMqyEa42SR/lIxehqxiC50PO82gCgNmQGwxWc9T5E4vWcc4bcEYHfyCbC5i0TIjUhNVgpQqjsRq4qeNLR+D20c2w773fRfpPhDRB5a/UY6hTn+8nmN1ZWUBI0+3UzsyNqrmjcP17QJHd/Ws6n8nDCVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=VCHMzfkl; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=5vSGc0XS20ndRTI136paKCdzFVWpVDVpMzjDJYUp3xw=; b=VCHMzfklKqVGO6A6kccHu7JSQ+
	RQkNJ1UP43TDfj82KC1v2hjnQ6E0zxf6DTunKCMLgAbENddhAtIl/hxeeKO4eLwPXqgyC7eA70BME
	IT/d/NH8jugKdUDPWYBcvXh0RY+cgwxBNcz9z2OCYrmN+EcEtUzOeTgWGVdH67jWsMimzrDnMP7tY
	sDFNoCNejJWDIemrKAWxQ22+5GtKHxCeom/WwmN+HO6erpoyNK0kBh5uSlzSuEcjJzLAMQp552w/5
	aIsGQIoUsQgzrY1T8IZKYWwoCDV4Tuc91BW6HvwrSiliD4jI+oKIdsHczBF5Gc6+XTl+UwLngyb0i
	8+PlI63w==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZnYp-0003fo-33; Thu, 10 Jul 2025 11:27:23 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix PHY handling for ROCK 4D
Date: Thu, 10 Jul 2025 11:27:18 +0200
Message-ID: <175213962000.1887379.7289714383827183619.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250704-rk3576-rock4d-phy-handling-fixes-v1-1-1d64130c4139@kernel.org>
References: <20250704-rk3576-rock4d-phy-handling-fixes-v1-1-1d64130c4139@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 04 Jul 2025 19:31:59 +0200, Sebastian Reichel wrote:
> Old revisions of the ROCK 4D board have a dedicated crystal to
> supply the RTL8211F PHY's 25MHz clock input. At least some newer
> revisions instead use REFCLKO25M_GMAC0_OUT. The DT already has
> this half-prepared, but there are some issues:
> 
> 1. The DT relies on auto-selecting the right PHY driver, which
>    requires that it works good enough to read the ID registers.
>    This does not work without the clock, which is handled by
>    the PHY driver. By updating the compatible to contain the
>    RTL8211F IDs, so that the operating system can choose the
>    right PHY driver without relying on a pre-powered PHY.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix PHY handling for ROCK 4D
      commit: cd803da7c033e376a66793a43ee98e136bc6cc25

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

