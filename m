Return-Path: <linux-kernel+bounces-887493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C91C385C2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B43834F6ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182862F60D6;
	Wed,  5 Nov 2025 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="z6DV5tbd"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEE82F5A34;
	Wed,  5 Nov 2025 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385202; cv=none; b=CwBPNoZY2YSxHxT/g525LLpETDLPezokxvILu4B/bC1VtItWHuGq/+iaDQeMuM/u9fUpDTPpOK6TkLWCFSY3dW0c9gr9frjMzyZDf6IhwXCJ+LPrElVv/XrlwqgWJ5RXB13CHohchXjMGOnugRgvodKPJK0Yqwysr9ugjswL1SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385202; c=relaxed/simple;
	bh=8Y8zXnhTAD7Fw9x7SklREnVNca5N1r1NY3A4jE2jDTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8UBVxLaCPzJE3OGVu13eD/BOU/gUpEFOPJ9asqkaElXHSoHCQOCiQgNYIYluusivS5d1tkrb4rXWejkynsjlq9ZnOjoJ5VeL733ZCVh0mVo6egwA8ts+e6+H60tusajQNB4vz8QD3aGV0F0CLS4Ri91idNX6/qJ+sQvyVlZxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=z6DV5tbd; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=hvqWhgq6E9yIB8u3zsh04lPjz8o3zonnYZU1K7EJUgc=; b=z6DV5tbdOsfeSMjMAfXbHs/8My
	NXwEqvACRlFCms94Wu6NvxfSPC1rd2g5ahqikshqIpgsylZreaZ3onosBto0Moe7LnDMplW39kwC4
	OFwTDnHb37ks2Y1oeJV4q3rCANfyzqa/4yewEqIiX+kYc7NL8VtRxjov05bD0nB+vYevyFfVefNNa
	TnYonKLAyLyFonw790VLuLDGxG6zL1wtfLwBiw6fbFYoZn5iZ8HT+rZ8nSlUnx6t74gleKdOI2t8Y
	PsS4aDwFS2vb4PmJLmS0nXPeMt2m081CZ1dDibd/Xd2rM9OitiUxQLcQIf8wisIPExFcR+dLBQDLF
	3ehSkZYw==;
Received: from i53875bde.versanet.de ([83.135.91.222] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vGmtf-0001FA-Qo; Thu, 06 Nov 2025 00:26:35 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	michael.riesch@collabora.com
Subject: Re: [PATCH 0/3] SCMI clocks on RK356x
Date: Thu,  6 Nov 2025 00:26:33 +0100
Message-ID: <176238518187.156498.15783284183828303705.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251103234926.416137-1-heiko@sntech.de>
References: <20251103234926.416137-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 04 Nov 2025 00:49:23 +0100, Heiko Stuebner wrote:
> This cleans up the existing use of SCMI clocks on the RK356x SoCs.
> 
> 
> Heiko Stuebner (3):
>   dt-bindings: clock: rk3568: Add SCMI clock ids
>   arm64: dts: rockchip: use SCMI clock id for cpu clock on rk356x
>   arm64: dts: rockchip: add missing clocks for cpu cores on rk356
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: rk3568: Add SCMI clock ids
      commit: 88b6a93af4345e901206d0576bdb4e88ea3eaeb8
[2/3] arm64: dts: rockchip: use SCMI clock id for cpu clock on rk356x
      commit: ff8912700f31782021ec28c530de1482fa99eab3
[3/3] arm64: dts: rockchip: add missing clocks for cpu cores on rk356x
      commit: e06a419eaab9cee7cd5bbb0cfcfbe49e443a9d75

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

