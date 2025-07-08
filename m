Return-Path: <linux-kernel+bounces-722119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F72AFD58D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36078486703
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290502E7F34;
	Tue,  8 Jul 2025 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="PwuF4QA9"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1C51F4190
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996150; cv=none; b=DnrIMVVVkeU8WeTXUkSGoeFjBUB40h9hMh4g4sKlydehVz6OZNfM/B/n6TPe78sfgDDbDLsuUsTGzBmxszLaiD/HSwVPkSblplR9C+vDaxthNQc0sKpHmrXSjL95FnGfbK0uEWQLPfnwss2MwufDGh9P7uK/hqlnI3PSuv2ulAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996150; c=relaxed/simple;
	bh=VMMOhCDKNN6q/ZMIOJreCQLzNvXFHDUu1ZjVjVoSaQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTaduSWzNJGbj/rWDnKiKwo99OgkSRUvVwEnkPYSj8LuWDWqWqM/cURqnOIWFVXyEmLX3PSmjRUOypccEGyYDqt2vzCvMkYSG4/Jt5p80C0arok4CVNz92VptZ/REKJvhx2nsoMxqKZFPrSilFbMfq32/wBLF9ZJEEQe1CTHOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=PwuF4QA9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=yQS8VbuYYVS614FlKxzbsWxX6m7fPV/cmPrhGKnwTY0=; b=PwuF4QA9yJ09dovOrDVvtn1+cm
	+DlPfjtIKVaNx0fq39O8q7Dhx9kiqZPa41AwkGPEmJ+WK6px2HB+o9w+uFfBkzl6uJaS752Q2G0cw
	wfAMdv/YJnGRlqmIVFPs2L06qRQ4YFYh+L6pasZgfW85WJt4pWK/XJBOS3S4elU5exdpwNjS/dRH0
	7jAIC49DaRGcS7l7AacuflnedPYjZ/TmOOsV80kCfIR6SyFSltAwuek22kazm75g2+u2izyRA91KF
	+WhtcMeg9NwfJfku3PuQBvcZX51Xq16OSlWR9SXM90izajUzKYoN/ITtyFJ2+RBavvVYyiRm9VpP2
	6hckBmqQ==;
Received: from i53875a8d.versanet.de ([83.135.90.141] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZCE6-0005cC-Jd; Tue, 08 Jul 2025 19:35:30 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Chaoyi Chen <kernel@airkyi.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH] drm/rockchip: lvds: Convert to drm bridge
Date: Tue,  8 Jul 2025 19:35:15 +0200
Message-ID: <175199006056.1731917.11933930833923830101.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250526015834.102-1-kernel@airkyi.com>
References: <20250526015834.102-1-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 26 May 2025 09:58:34 +0800, Chaoyi Chen wrote:
> Convert it to drm bridge driver, it will be convenient for us to
> migrate the connector part to the display driver later.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: lvds: Convert to drm bridge
      commit: 40a382aae1d4a4ca07fe19b0d16b4fbc1eeace9f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

