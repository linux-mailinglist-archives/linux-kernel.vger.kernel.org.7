Return-Path: <linux-kernel+bounces-853196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA797BDAE5D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E853E74FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E3530B52B;
	Tue, 14 Oct 2025 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xz+L5VWQ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1C9301702;
	Tue, 14 Oct 2025 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465219; cv=none; b=Xps+Fge01gVbDrevWhz1QCd4oBlXim3mrUX5RdxedKbUTmdK2fXhYXsKn62jJK1JJd7FJAg63c28FdQAU1j8nsumeXRBKqpY4OnqiUopYosdA7PAatRe2OS8gNBLIdw26EQaZ9uS6UDI7hhMtq2e/Hg4mvWSTUWibK/ZUEVbNZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465219; c=relaxed/simple;
	bh=Di9XNbuO8aSg9eUC1XdwocObMdp/BwDGpocmH6hK7Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLiGqerIVwZurWh2CCDjG80v7kiS2ksW32w1+ZAsyVKP5wlGgC5g5cClKRBF7B8UeVMGz14VCxiC/8RwzXxnObf4LPaLKIBeBqN4w5g85T78p4hKmro0vZ0JXUatxx3kd8gqIW0Z/Z3TNX6l0S44CG9QxnGdUukYW79GYDdupOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xz+L5VWQ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=XiHv/yOnY6WMqqBbAcq4r+gLICsRKMAlOgwF00S/n44=; b=xz+L5VWQ/4abOx3kcyXefrbnf4
	ktFF/bDAFfxrlD+4dSTkjIDX4YQoYxfcNEiizSh2rEJKxjcWnpnMfPWNlah9LqG0QWbMN1wY7/shh
	tUETy5O6cleDIZHXf9WvLeISNChFn2Blg+U1sHVEsfGEuXkzNYTLiCTcpnO4UHGREKXWCKIqudVl7
	SwoYb/DJ62SX54uQ7SM6L2+BbwHNLkqZMQbsooaUoei7NPeq+Vdewg14yo/lRnzLI0UjodANxYcwp
	wKUvRR2Xi5RFeLeJycmKkfBJzXY/Q1JcaSmhlprKRjtqOa84BvsmT8jMKht1ZyQEAMzuHbvGDy/pu
	Xl3H8bVg==;
Received: from i53875b75.versanet.de ([83.135.91.117] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v8jQB-0001Gj-J3; Tue, 14 Oct 2025 20:06:51 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Make RK3588 GPU OPP table naming uniform
Date: Tue, 14 Oct 2025 20:06:36 +0200
Message-ID: <176046473180.1662867.16010204377467165654.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <355c16ab070688fc6285e0d4419eb54a3f699eee.1757152740.git.dsimic@manjaro.org>
References: <355c16ab070688fc6285e0d4419eb54a3f699eee.1757152740.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 06 Sep 2025 12:01:22 +0200, Dragan Simic wrote:
> Unify the naming of the existing GPU OPP table nodes found in the RK3588
> and RK3588J SoC dtsi files with the other SoC's GPU OPP nodes, following
> the more "modern" node naming scheme.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Make RK3588 GPU OPP table naming uniform
      commit: b3fd04e23f6e4496f5a2279466a33fbdc83500f0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

