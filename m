Return-Path: <linux-kernel+bounces-736010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13272B0969E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239C016C1BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD3F2376F7;
	Thu, 17 Jul 2025 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OphxI+Ei"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA52C18A;
	Thu, 17 Jul 2025 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752789496; cv=none; b=chYJkSbq8DDpBfYcCnWK/7a707tL2AqEdp2zGAYQIXiqXuK5ferqcTVBlV/hhMu5E20Pp/kIHQIr8bInKiBIn8V5d4QqPqqWaf8dWkd9F61U/2expWwl0TmqX/LtgNXIT20fkIc9nEXy3V13VG0kZp0HCxWAmHgohBQXBfyanTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752789496; c=relaxed/simple;
	bh=O/kg8t7MbHfNbrdP/cpMCUGufZfwNutHBitrbX/Jpvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ij/H5SiP1MrSvLaUPBMOzhppHEn1KS+Cvly+84NB7h5a5fWryiI1vSOfCLJbvCVSLv5nIExJGb61/29bTtd/wXpyzP4IJfJ/TC2abskVJ9t6umsUPY/pSS+PmFXcqN3IxcEnxbM0C2QU8qiLCOBHnwy2Xkvu86fRWNKMZ44HHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OphxI+Ei; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752789487;
	bh=O/kg8t7MbHfNbrdP/cpMCUGufZfwNutHBitrbX/Jpvw=;
	h=From:To:Cc:Subject:Date:From;
	b=OphxI+EiEn+9nNY0msGSfG6PqqLFEHg5J7zuWeL+r4TD2cnc1/PEu3GpskO+iYEVK
	 dx0jMfMQnMGfXCW9OTXooWn0GnfFz/CB+CE3n3ajW6zgW/Xx4RfgG3fKYSJkAbAj9r
	 cuZfKrYhSeuVQ18ZVMcvMVYmrJvlJRPLOTsj9o3jEiCkiXToIZ9ssoelcjtWnSsoHy
	 u8wC1vxpmMzPSpMroNiHmB3N2ib9pZWsUq6Y2ffVguvhoZl1g8R0HqWQIRtnx2AZEh
	 iiJPgCLdHUZK4eGvGsQEaQmqMtSSdv9vYlwmMBItJFPgEuXQRGBwdMVdgrhVpyJVoF
	 ozgo5u1LhXRhw==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D495D17E1324;
	Thu, 17 Jul 2025 23:58:03 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Douglas Anderson <dianders@chromium.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Raag Jadav <raag.jadav@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-sound@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 0/3] Clean some logs on rockchip hdmi audio
Date: Thu, 17 Jul 2025 17:56:17 -0400
Message-ID: <20250717215620.288651-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HDMI audio is showing lots of logs, particularly when HDMI is
disconnected.

It doubled on RK3588 with the addition of the second HDMI TX port, so
clean it up to avoid missing important log lines.

Detlev Casanova (3):
  drm/bridge: dw-hdmi-qp: Return 0 in audio prepare when disconnected
  ASoC: hdac_hdmi: Use dev_info on invalid ELD version
  drm/bridge: synopsys: Do not warn about audio params computation

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 5 ++---
 sound/soc/codecs/hdac_hdmi.c                 | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.50.1


