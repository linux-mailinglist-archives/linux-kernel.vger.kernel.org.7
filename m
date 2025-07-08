Return-Path: <linux-kernel+bounces-722120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF7AFD588
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6A256802B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112032E888D;
	Tue,  8 Jul 2025 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="G/qoFhT9"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4B2E7BAB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996151; cv=none; b=kqvljYa1+aG61E2rw8k1F/yUPdVr772QqAH92Uh6BMEqUhlGcSeBhsJreTvbQXWYvEaAQ9I8IGrqPzEcpg3rZTaox0cI7XBXOPq9aUKhslX/xNZQ1y+almToiJwK69Ymdc4j6bS0Wqu3TeQ9X5goKrG0naY1m8GQSybOdZecohQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996151; c=relaxed/simple;
	bh=eIwDhuGuPOLqdZpxtC0145A1DHEP0dylYU9EsVGJwXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjJl5Pz74W+1daFYI+AwXLILi5MfuMnCk7zUjCRoOg1UO6eE4eVrNAlf9pPc+aPzOmzKugsYe2fkaKoiZqrfKN6nkEU2t+mG6xZ1Me9jL0vIXPnj5U76O6ypOsfM5YrNt/8DQShMQCFcBDH39P5kUpjFo+wvO4m9C3/f/OqQD+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=G/qoFhT9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=UQuPrMl4qmbsQGIYF0VFRtd+Ry1sum32/xnLjEzzRFg=; b=G/qoFhT9pYQEzuVrsyhoFiGJwq
	wxsivWG0AwDsw7VnOYFtSvVLThLZ+54dF99VqMaA5cxZFSQDShF4Tgt7bNG6B0dQohOo+0jOvV0rB
	i1o0ZSor4GIR7PEElnBAYtOS5QERcnwm50OTJP95OBEeCYIhJwp8OeIIGJtDPBlDK6tO4Q7qzdyAV
	rUVZWVovUFOLl4JgAEAWRVDizxGpY8odH2Ef4k+PA165yno0Nq0ko3BC3xWZ1ktvnOjWfZx3djLFU
	XQsUK6k6/c/+eDldJR3BtCDmknjwHfxmsDHy0Qa+l+9tx3mPRzikfhIr4IDuwTCD1XaLs7Hz06Tjd
	OR+cY02g==;
Received: from i53875a8d.versanet.de ([83.135.90.141] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZCE7-0005cC-SZ; Tue, 08 Jul 2025 19:35:31 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: hjc@rock-chips.com,
	long.yunjian@zte.com.cn
Cc: Heiko Stuebner <heiko@sntech.de>,
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
	fang.yumeng@zte.com.cn,
	mou.yi@zte.com.cn,
	xu.lifeng1@zte.com.cn,
	ouyang.maochun@zte.com.cn
Subject: Re: [PATCH] drm/rockchip: Use dev_err_probe() to simplify code
Date: Tue,  8 Jul 2025 19:35:17 +0200
Message-ID: <175199006059.1731917.11035979004712647883.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515203554564-j1jBXUXR6bdiN6zARicC@zte.com.cn>
References: <20250515203554564-j1jBXUXR6bdiN6zARicC@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 15 May 2025 20:35:54 +0800, long.yunjian@zte.com.cn wrote:
> In the probe path, dev_err() can be replaced with dev_err_probe()
> which will check if error code is -EPROBE_DEFER and prints the
> error name. It also sets the defer probe reason which can be
> checked later through debugfs.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: Use dev_err_probe() to simplify code
      commit: 52008d6fe7fa84ecf23864c5cc373beb085f30b9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

