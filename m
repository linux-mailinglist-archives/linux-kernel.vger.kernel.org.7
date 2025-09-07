Return-Path: <linux-kernel+bounces-804755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7058B47C95
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 19:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2747B188F83F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 17:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9006285C9E;
	Sun,  7 Sep 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Ncuse2Aq"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C46E24A046;
	Sun,  7 Sep 2025 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757266234; cv=none; b=eXIokl0hMjT4NTnqevz8FQRmrXp+WMCBCAqDQ/2ASYJ0aBwLpYrsjc5uXd8z/Ya9gF5io2QmxFCin9e6SqiPecNTJ5IA5Voxculm+Uphj2YxLkUwSmeV5ICG0cGz6Gx1naoqHOLL9oRHOU3/T9pLBSPXGGhFHPDt0O2c2gWZuiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757266234; c=relaxed/simple;
	bh=JSfcvMFZ0ICMAl2MnGtEq2cF+XZ9xrcL7FQmdYi5o6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uA1J23HlHSugZW6vAR+CEtOzeWSVFK4ZFMeW71iQm1vymImcpD9Z5FCYb1DtCwzUNeAGaQMfA4QxVNpqkQihAzs5qDw37XtHuqsOfOfxXbWmI0CdoAapIlmCIh7kEi4d+qkv4GDD60wQJCT3T/V3pFvO+mSCAfHYJfR+T/MFAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Ncuse2Aq; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=pi+FScEH8RwdrVr7Oxt2JXPrqf9PvwEaZcz5KpMAXv4=; b=Ncuse2Aq6Ws3pS01vd6bMpmNKO
	9X1gXYkWHoA2zfZ9sWbIkMm71fQL5byYIFX1Udb2oWF8MEpueSwWeHsZgLylnrdha2XShRR0WdXDA
	EaaHU2aWrUxAoI+0+4Iny8175g8uJlYIeArkRuFHYuda/Ds4nkpKegPP6TBQeVfTa4s/g8Qx1J1fn
	dSQIrMcn0UyMH1shBUBL+4UYhNNFouBrkm0VrXSyt0uzXgz9LWwfCQ/mDWGM5D9W8c3u5f1nFmTRG
	DwuzWvPPfU0z/Wwc8OmDiiHSov4a2A5/6+ixzuViOS2sABiZXeu2wLCDlG4szuEQDkCnWyhdIg5Wz
	oomgQSsA==;
Received: from [61.8.147.163] (helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uvJDc-0004Ii-Hm; Sun, 07 Sep 2025 19:30:24 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] Enable HDMI Receiver on NanoPC-T6
Date: Sun,  7 Sep 2025 19:30:11 +0200
Message-ID: <175726620391.195224.16245258032470336933.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757068166.git.marcin@juszkiewicz.com.pl>
References: <cover.1757068166.git.marcin@juszkiewicz.com.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 05 Sep 2025 13:02:29 +0200, Marcin Juszkiewicz wrote:
> For quite a while I had this patch in my local tree but never made it
> work. Kernel generates the following messages all the time:
> 
> fdee0000.hdmi_receiver: hdmirx_wait_signal_lock: signal not lock, tmds_clk_ratio:0
> fdee0000.hdmi_receiver: hdmirx_wait_signal_lock: mu_st:0x2, scdc_st:0x0, dma_st10:0x10
> 
> "v4l2-ctrl --all" reports that HDMI In is detected, /dev/video[0-4]
> exist.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: enable HDMI Receiver on NanoPC T6
      commit: fdab01864390db7ef0bea28804c7a3147dc0a386

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

