Return-Path: <linux-kernel+bounces-722122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B95FAFD58B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A29163E78
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766072E8DF1;
	Tue,  8 Jul 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="lIWxiG+l"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF432E7F35
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996152; cv=none; b=ez0YVGUS2J899pCMrIQu7g8Q91YMNerPO1lPm39IuQv3xYJYHE8kCUUd+uSETS8Ltsn+QqIL8YtvUfzvJiExKL+Gd/nXPxWmHdoHmXdDODYWb/6FOBhUVVmjlSXjEq2YSSugphBvcxAjh3KOX0pwDMor59Sw0aSEa2YmYXAsLmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996152; c=relaxed/simple;
	bh=6jQJJGQ1jQNV78CakqDO0SVn8FVsY+4iwYoZlqH0rXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDTiSNeSqOE30TMZ7LrKOXlK9ZhGX23n6ivZGvX7LlTol2IYDq3bE9sAA/G/ENVXxjOpUq/7PhjSCWRiUMSggYpaizYGy9/G74Ap/yYlkB71mUokWF/kWIHlCCDsppzl0rWI2I4O45JiKFuLgIup4X+GndRzbTbHs8x0xfH7888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=lIWxiG+l; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=3+KIGxp1CkEgq5QeOKsG0ykxm/nmLGoH7zIoPCk6sho=; b=lIWxiG+lxhv+WZLVxW7jiYFUAX
	BI0smJ10GR33zPSRs+M8CwtohW+p/5bvlhyEi2BtFT7t0/DSVFqFCixuTcu7YanJw2KatF88VxQgt
	Ypi04+CHzte8m0OTtzx8ELO8GER2LTTAlqvHnAj1viMh68gTbEmbBoy4srQnTjIO02qhf9qRlcKXW
	zNTZIRf0keZ3AA1a5qf6vKo/kEB4Zdwq+u/ryo8X+D9wtjhg8atw9IkjqxF7LnA+DdvpVAqEWOQTD
	UmlaUhhEcKloAH9FiOKs6Vymn5hPygrWopXG0FZfqn9+gE53r64cUeim7EcRhrbmGA26CxOWhbsPO
	GDfnDcVw==;
Received: from i53875a8d.versanet.de ([83.135.90.141] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZCE6-0005cC-0X; Tue, 08 Jul 2025 19:35:30 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	Heiko Stuebner <heiko@sntech.de>
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: vop2: fail cleanly if missing a primary plane for a video-port
Date: Tue,  8 Jul 2025 19:35:14 +0200
Message-ID: <175199006057.1731917.1862299195201447039.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610212748.1062375-1-heiko@sntech.de>
References: <20250610212748.1062375-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 10 Jun 2025 23:27:48 +0200, Heiko Stuebner wrote:
> Each window of a vop2 is usable by a specific set of video ports, so while
> binding the vop2, we look through the list of available windows trying to
> find one designated as primary-plane and usable by that specific port.
> 
> The code later wants to use drm_crtc_init_with_planes with that found
> primary plane, but nothing has checked so far if a primary plane was
> actually found.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: vop2: fail cleanly if missing a primary plane for a video-port
      commit: f9f68bf1d0efeadb6c427c9dbb30f307a7def19b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

