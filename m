Return-Path: <linux-kernel+bounces-768481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14ADB26180
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2621899A77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5742F39B4;
	Thu, 14 Aug 2025 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2hq+WBiG"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202742ECEB1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164795; cv=none; b=n6eHgMxZ9rIhBx2r6EMww63YKvdWUpJKp47jtgF5sV+0ygMx8Wazk0sILigzKx1xOJ+OnLwcdWP1UGx1v9/8GDa9UvkOFzdiEjPoWvtKo9dry6izHMejZfkvU5UPDNFGGo7slDfe0PJAWA/PGyRHDJr1j1+dJSCdk3hK6fQeSdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164795; c=relaxed/simple;
	bh=B1EQJQ2J3+ivEehEsPDuzHa2+Kkul2waxNFWvkreYwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPhW3gbaHaZceJ3xXSMRze4J1ntqWeYEdYKTmsv6oFH1/UHecMyNbyz/9TBwnjipKinHN5vatcn0uGvwQ969xiASKL9FWRzSfxBnSNIuKM/LTw1j7Qx+n0HmIEjMCdgjA84vyTpVK79HlDcFKvAVhYS6ebxswBSQbTLDAAg3Qxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2hq+WBiG; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=MkAu2hEhQvHxgjZYFuwTW+sucst3RzoiJMIBnTxCCXM=; b=2hq+WBiGzJRNWbHX2D4SNxAvs1
	YFzjD7xdAIlSVhNZ3bx9ylupMIduDRYZGshhX5klrcWHHag6H/jZtDuTfwRjFfZc6nzExlCBrU/XL
	1ViCJn5/J/dFRSPn/twVDu2TYzQXB3S2Oi1OZ+I/TkcjHIQ4qdXL8fACBkcbIQ+oMd9rXNhEAK8jO
	HwdmunTZe7b1mNplyzReTVWmTf/u2H1YBlW7BDKUntr6+k0nk/YLmp+Luksr2DSDtCzhMa3MwApQ5
	vUmAu3wgq1xUvWcDlcpmOkZIXSMrNB/pF3DidjXmNRCFckNKldVUKKHn5NARbA1rJewKUNoRL+FNt
	REXA2h0Q==;
Received: from i53875b38.versanet.de ([83.135.91.56] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1umUXC-0002c8-M5; Thu, 14 Aug 2025 11:46:10 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Piotr Zalewski <pZ010001011111@proton.me>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH v2] rockchip/drm: vop2: make vp registers nonvolatile
Date: Thu, 14 Aug 2025 11:46:06 +0200
Message-ID: <175516475520.1500001.17369279178987813949.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250706083629.140332-2-pZ010001011111@proton.me>
References: <20250706083629.140332-2-pZ010001011111@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 06 Jul 2025 08:36:58 +0000, Piotr Zalewski wrote:
> Make video port registers nonvolatile. As DSP_CTRL register is written
> to twice due to gamma LUT enable bit which is set outside of the main
> DSP_CTRL initialization within atomic_enable (for rk356x case it is also
> necesarry to always disable gamma LUT before writing a new LUT) there is
> a chance that DSP_CTRL value read-out in gamma LUT init/update code is
> not the one which was written by the preceding DSP_CTRL initialization
> code within atomic_enable. This might result in misconfigured DSP_CTRL
> which leads to no visual output[1]. Since DSP_CTRL write takes effect
> after VSYNC[1] the issue is not always present. When tested on Pinetab2
> with kernel 6.14 it happenes only when DRM is compiled as a module[1].
> In order to confirm that it is a timing issue I inserted 18ms udelay
> before vop2_crtc_atomic_try_set_gamma in atomic enable and compiled DRM
> as module - this has also fixed the issue.
> 
> [...]

Applied, thanks!

[1/1] rockchip/drm: vop2: make vp registers nonvolatile
      commit: a52dffaa46c2c5ff0b311c4dc1288581f7b9109e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

