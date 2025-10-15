Return-Path: <linux-kernel+bounces-855255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E969ABE0A50
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A993C5458EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E005630DEA4;
	Wed, 15 Oct 2025 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rzJavV87"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C75230C630
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560472; cv=none; b=oKiIo2HgOC6Z4DCCI++Hvjj74ipCtvJMICHnwde58ndJP36Fj9swNOqjMWTPPBkySfTTzgu8M5ocCxSH/2Yd0zhZms6+uqCjZu3hdj0LK9tyWFGSbRzV/t7JnXMOlCkq9x0bn+V3yIBw88fOVZTj10ftZg4XJ9delS/QlMOOAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560472; c=relaxed/simple;
	bh=twaOO7Ts19BCrlvmmKNF8rvn5V3mcq3kNdeiCWjeMUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSIaCmTHb4dIBx+p8SF7MGZpcHuqTihaxH4lY9Laik17z4AWz1/sMiwBTW4YJQ9UIsRf2kHNBzin8ZZApQcvVXvUnXvp3Oh/MBCk/5JtK09Laa5qIrSUE2c6aAC/C5t9Q32y6qIzctMf/2CZaWKUR7RCqc2PXUkoTWmK8h6L8uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rzJavV87; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=oLA31juQGoiGMUFqFzO9vTxSXS7E8CLrzp7upb7S4y4=; b=rzJavV87hAgCX95iHRI8ObRfv3
	wEp+Pc0pnwzuAcaIiVvZGyZXJuiKY5TIr0dvGQsZ55qp1R0ec/kDZMhUoiCYl3Ddk3YRCukg1tIXk
	zjfH50xfAm98qHeof2rRjjna6bPfZPlEmUQ0D843Lm9jdubu/3lN7Mx1krASzz/75FztfB0DrtIXA
	gdo338yTXvbipLWJZslBzbEN3hTKnmE9h6rs94OoKUvIJKfLBbVosU+CGe8pn7rMreD62EIE5OZIa
	JLBcqXCcw3i53sP+GIEZ57MjjAXVL9VC55b3ZK5+aSFfJVntsR42Ttet1+vztxHTzRiI+DgFlpDh9
	OkHOY6qQ==;
Received: from i53875a40.versanet.de ([83.135.90.64] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v98C8-0002Qp-Oa; Wed, 15 Oct 2025 22:34:00 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	kernel@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Algea Cao <algea.cao@rock-chips.com>,
	Derek Foreman <derek.foreman@collabora.com>,
	Daniel Stone <daniels@collabora.com>
Subject: Re: (subset) [PATCH v4 0/6] Add HDMI CEC support to Rockchip RK3588/RK3576 SoCs
Date: Wed, 15 Oct 2025 22:33:50 +0200
Message-ID: <176056042470.2037566.16932540958621144492.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
References: <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 03 Sep 2025 21:50:58 +0300, Cristian Ciocaltea wrote:
> The first patch in the series implements the CEC capability of the
> Synopsys DesignWare HDMI QP TX controller found in RK3588 & RK3576 Socs.
> This is based on the downstream code, but rewritten on top of the CEC
> helpers added recently to the DRM HDMI connector framework.
> 
> The second patch is needed for RK3576 in order to fixup the timer base
> setup according to the actual reference clock rate, which differs
> slightly from RK3588.
> 
> [...]

Applied, thanks!

[6/6] arm64: defconfig: Enable DW HDMI QP CEC support
      commit: ae753d769a5f63cddd483ec50067ec61eef5489d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

