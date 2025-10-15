Return-Path: <linux-kernel+bounces-855252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5E6BE0A38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E201C19A77C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704A2302CBD;
	Wed, 15 Oct 2025 20:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Yfz7vK+9"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8D41C71
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560358; cv=none; b=tlk9fy/okFHM8ah5dUZt+Yc652PrJZFuN/kLvtRvhhOyaLfOkPHLb8tC2E6zWVpr5ZZ5bB9/UDRFGSJEyz93GBYUYUdjdZcGXhxblPZrYaSY8Viu33E/dryjHk4kGwshikPrvc0++je/8N3OGvhTJgvR9HI+5iVoan2aMjhMVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560358; c=relaxed/simple;
	bh=MkfoROK3dfKdOkIEAD4mNrDDOXrtTV7V8qhM5BkHtBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcxSPQk6m5wTuuB047iWdeGr4qs7IGFA8yk8u7ZeSkESaDqcWNmsC7oIwPGgzOtZRlim6CPhVVtaG9tPtSoFR8PZmL9SW1YMtdQm4Cq0HYNduLw+X3AzQ9/pDoOlBwq4wQ5guC2nHNX1pAG65tKDOPljcpQ0SMUat9uEMHz0YCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Yfz7vK+9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=fLl6q1Y+72vHxOIMF4slDKrUf5187PWqHxWI44dG6yE=; b=Yfz7vK+9g3WW7BmyFBFji3dkMU
	UevXDzFQ4ydupk++uQA9CA0Kni3han+FwzAvwR1aU2BFfJ6pKsTFz8BXw/B4dY28bnusWTOcilWIq
	c5tT3UCH41N0TqRuXgZYdT1jnvonWs1mYI7vkq0kQ53SMjy0hakUfxwHDXc6KMNHe2sdPT8guKzGV
	SLDjaMJm2Ce7EM6fEw9FapvU2XaIlLVoyFSK+kWCiYyyJ1aWdU2lTKwtizn8jxC/H2TXSuQkufMLK
	JS0q3ff+QkqkfAJCiLHiCrCMGVMhAJ6y5nElRZXCJt86E9KkViyTeu9wmkejJwNgyfRqhE2eDurvE
	8f/4GNWA==;
Received: from i53875a40.versanet.de ([83.135.90.64] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v98AD-0002OA-JH; Wed, 15 Oct 2025 22:32:01 +0200
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
Date: Wed, 15 Oct 2025 22:31:51 +0200
Message-ID: <176056029579.2036456.8048983695806935631.b4-ty@sntech.de>
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

[1/6] drm/bridge: dw-hdmi-qp: Add CEC support
      commit: e4a2d54a2f1a9c9a1971651832c8f0ad9d3782c4
[2/6] drm/bridge: dw-hdmi-qp: Fixup timer base setup
      commit: f7a1de0d86221000dc0699a8b48ad3a848e766d9
[3/6] drm/rockchip: dw_hdmi_qp: Improve error handling with dev_err_probe()
      commit: b6736a4ea3fa68524074a18334f344a34a05bee8
[4/6] drm/rockchip: dw_hdmi_qp: Provide CEC IRQ in dw_hdmi_qp_plat_data
      commit: 9baa02327adf2b1e919e95af23036102cfd0133f
[5/6] drm/rockchip: dw_hdmi_qp: Provide ref clock rate in dw_hdmi_qp_plat_data
      commit: 33ea4d520fbda505e2cfe5b36ebf522de1f3f5e9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

