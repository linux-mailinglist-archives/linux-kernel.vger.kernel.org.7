Return-Path: <linux-kernel+bounces-852558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26A9BD952D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFE11925EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5667A313548;
	Tue, 14 Oct 2025 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="k8DUbYZQ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A3313E1A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444628; cv=none; b=ZGh55nXwNknXXaBM5wZaNoams1vM+iQCuE9bJsmGgOd8xK8VG7DhOqqo3+2ZTcxO022Yz2csz+r/R1Hwh3NFu9ouYKFFw8NwQFJoDDOEbBhTdGfQ2+c2uLq6Q2McC6YEP7OWmjg0vac5mxu+qWCFKWQE4ZzDUMkQZ3Qmk1CaRGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444628; c=relaxed/simple;
	bh=N3IgEccc6Dc52F0Lp2dcsQ5IEqaV5yDA38MK5yUk5Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJz9oxAb2BPyJqh9LKVfFjK6cjomnRD8SLGHJ7OAGciFr2GGRLXMVPL0QrrWk+/Lv0EOUHOOyvIEefMV8L6B/QVQHYQsBZm+fxjsJkmT0rojH2c64naupxpOrb9uTsSMIPWQP0A+6pHVSfJO/ukaym7fh0LOqld0a7g+u9UQzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=k8DUbYZQ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=KrD15lH7IUb1YniDYdLmkUnzg/+PCDE4bFnXHniYJUY=; b=k8DUbYZQER5zJacQEJZcChExiJ
	vhPUeZ/Zv2fV5lYzYR7IW+20M6hSqq83JjRMMrdU8xD2M7uo6GSDBwFtbwR7dPyOWBgEcLQOZPe8q
	VG9rnq397wQkFIaTpDA1CXF85u+HpmIEtiszRnJYuclchiLDT8Lh98oeSBlFQcPIn3dD/uDHMk9qk
	uGk3Z7s3dSb7PukDAhu23N6xrSiXJwONj2QVhnfx7FhvFt12Og4RjcwMNFEMBLa7BEDFAuBWN1xih
	IUXpLgrinQP7f85hy+nghNIpbdYXB6I9665GL2NiMUSfj7VMtR8kEFbHrPfQadCVbwmLfPraZH/nL
	7R0uH3CQ==;
Received: from i53875b75.versanet.de ([83.135.91.117] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v8e3t-0007Hl-3y; Tue, 14 Oct 2025 14:23:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	Damon Ding <damon.ding@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v3] drm/rockchip: analogix_dp: Apply devm_clk_get_optional() for &rockchip_dp_device.grfclk
Date: Tue, 14 Oct 2025 14:23:19 +0200
Message-ID: <176044455976.1550590.2860570275886738546.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250928103734.4007257-1-damon.ding@rock-chips.com>
References: <20250928103734.4007257-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 28 Sep 2025 18:37:34 +0800, Damon Ding wrote:
> The "grf" clock is optional for Rockchip eDP controller(RK3399 needs
> while RK3288 and RK3588 do not).
> 
> It can make the code more concise to use devm_clk_get_optional()
> instead of devm_clk_get() with extra checks.
> 
> In addtion, DRM_DEV_ERROR() is replaced by dev_err_probe().
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: analogix_dp: Apply devm_clk_get_optional() for &rockchip_dp_device.grfclk
      commit: 0dc25a11b8936bb752d6217f9db9857641c3d266

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

