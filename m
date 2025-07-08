Return-Path: <linux-kernel+bounces-722118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B3AAFD589
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC27484569
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30196FB9;
	Tue,  8 Jul 2025 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="K+fXiJeg"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752C1F4190
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996145; cv=none; b=QvnFCwdH7R8a9VAr2Au0DwDnLPyd1Y+cGmU7MKDLWDNoyY+pCbZZ9dLBL7G6KpwPWH+mFrlGvRJnpB9iSOyeI9+ld82h4glUGl4b86JrFBlzlxiJRT9zuHbvRyFP4eIqzBDn8OZ9kh185exvOvGWVQYgYX9KmpoCd0g9Af++1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996145; c=relaxed/simple;
	bh=sbJBWwXGtRZViWUgGn0fSx+GNIIYxDkv00B06tcRNRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCEOdrZA69INvR+VA2956z/eDgh+t5TunFSqiuptyupi9QdYNbC9Q66Wdq4FGIf+EfNBBjrg8v2o2Da9kGBpHsoJU6FzrM9AI4ZpSmnkvLsigr3zTKtRZMhtTqavExxSoAOwhWf7x4hU5GV1NzYOCUo3VIP2A3AXSkdM2JdlYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=K+fXiJeg; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=97sopF4YX8DzwzP4nGmiVk6JsICCBAIUEmsCTEqAsyE=; b=K+fXiJegfbH6kmmryc/nvRZ32h
	2f5QyP6HwtLFc5dTntmsHLxgJLrij4Qt4/gJ/3TroxssEYXqNNbn06FkJjexbGh5hTClQhsJjEHSx
	2ycwocXh5XQENybGOw2UcGAtgOxI5apVYQR86a4wjzR9bMiS8iNSDqmoP5Ud0tK2yoCpgaKCMvt9S
	DfbyC9t5pwrjTgZS/sRPH7Ik9oIpdl9hSq5i/SM7Cke0/01WbpoE9FLVPzVabI6loaCsUA4lnUX9y
	m7JmHwKzhC5yDs6YjNMFZqB3m95P55K9W5zSGKuFDe12adgGGfZDGWVgWatRE9d3CDC05BDubJW4p
	KcOTePnQ==;
Received: from i53875a8d.versanet.de ([83.135.90.141] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZCE5-0005cC-HY; Tue, 08 Jul 2025 19:35:29 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: dmitry.baryshkov@oss.qualcomm.com,
	Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	jonas@kwiboo.se,
	Laurent.pinchart@ideasonboard.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	hjc@rock-chips.com,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: (subset) [PATCH v5 00/10] Convert inno hdmi to drm bridge
Date: Tue,  8 Jul 2025 19:35:13 +0200
Message-ID: <175199006060.1731917.17930590258834910843.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512124615.2848731-1-andyshrk@163.com>
References: <20250512124615.2848731-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 12 May 2025 20:46:01 +0800, Andy Yan wrote:
> Convert it to drm bridge driver, it will be convenient for us to
> migrate the connector part to the display driver later.
> 
> Patches that have already been merged in drm-misc-next are dropped.
> 
> PATCH 1~8 are some cleanup and refactor.
> PATCH 9 converts the curren driver to drm bridge mode.
> PATCH 10 add Add entry in MAINTAINERS file.
> 
> [...]

Applied, thanks!

[01/10] drm/rockchip: inno_hdmi: Merge register definition to c file
        commit: 9c3111df6a681f7b0057f05e7211a98d240237eb
[02/10] drm/rockchip: inno_hdmi: Refactor register macros to make checkpatch happy
        commit: 372a927f93fe0477dd1a5f15f11888391f8ef33f
[03/10] drm/rockchip: inno_hdmi: Remove unnecessary parentheses to make checkpatch happy
        commit: 7431c5462c7f20b7f111c9957a007b8de5b8a76a
[04/10] drm/rockchip: inno_hdmi: Rename function inno_hdmi_reset to inno_hdmi_init_hw
        commit: 55137487bdee89189873e437452a077bb591f33a
[05/10] drm/rockchip: inno_hdmi: Move ddc/i2c configuration and HOTPLUG unmute to inno_hdmi_init_hw
        commit: 52ac749b4505339a321b9695fe9d2977294c98da
[06/10] drm/rockchip: inno_hdmi: Use sleep_range instead of udelay
        commit: 1749267beee76bfd8108f5071afb870903c83dab
[07/10] drm/rockchip: inno_hdmi: switch i2c registration to devm functions
        commit: 078bb17c7bbfe5bb119943fb7a9ef4f9a8c8c543
[08/10] drm/rockchip: inno_hdmi: Simpify clk get/enable by devm_clk_get_enabled api
        commit: 6a1b9229ecf11f409edd9392c96bded1672ea5f3


I've picked up the rockchip-specific cleanup, but the actual bridge-
conversion needs additional eyes.

Also comparing the recipients of this thread, I think your missing some
bridge maintainers/reviewers.

scripts/get_maintainer.pl drivers/gpu/drm/bridge lists:

Andrzej Hajda <andrzej.hajda@intel.com> (maintainer:DRM DRIVERS FOR BRIDGE CHIPS)
Neil Armstrong <neil.armstrong@linaro.org> (maintainer:DRM DRIVERS FOR BRIDGE CHIPS)
Robert Foss <rfoss@kernel.org> (maintainer:DRM DRIVERS FOR BRIDGE CHIPS)
Laurent Pinchart <Laurent.pinchart@ideasonboard.com> (reviewer:DRM DRIVERS FOR BRIDGE CHIPS)
Jonas Karlman <jonas@kwiboo.se> (reviewer:DRM DRIVERS FOR BRIDGE CHIPS)
Jernej Skrabec <jernej.skrabec@gmail.com> (reviewer:DRM DRIVERS FOR BRIDGE CHIPS)

and not all of them are in the recipient list.

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

