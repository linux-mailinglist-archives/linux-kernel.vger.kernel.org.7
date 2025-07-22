Return-Path: <linux-kernel+bounces-741464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E91B0E473
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B60163A93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7323227CB04;
	Tue, 22 Jul 2025 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OTkSwdlZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0C1E377F;
	Tue, 22 Jul 2025 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753214088; cv=none; b=lydY4RhOEKIbWJMK6ruyM5x0iCh4XK4E3XZU2KPdEHEbFLuh/4/Fy+TkrBD9Nns28VvT7SRms3rz2x6Dfpu1X2tpIPHFiglY8fMg9ua2ozfAclQDswu5/A+hQwOM0LR7Wea5Njwmledl7D3aCcP7hFzHvEFJGdblvW9rdk/IOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753214088; c=relaxed/simple;
	bh=yE8FP2dB5XJGvL/8C5raEX/QIQT7yEmjwtR6o2JvdoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGU9aV4vy/Ze+BprCWGmwQaBnEBS4gJnhJoHm22CgEkSMoID97EycmgYRFdfQ2vwNZ9PDJGH/kpbdSJanWvPfajM+ThnX9zpxbxy9YQV2DDZOn50YdqkBxHatzf66KrqE0m/a7ryaOdR8NKdPsj2FkUYOSrBA3jT/KPbSTR5Vuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OTkSwdlZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753214084;
	bh=yE8FP2dB5XJGvL/8C5raEX/QIQT7yEmjwtR6o2JvdoQ=;
	h=From:To:Cc:Subject:Date:From;
	b=OTkSwdlZMtfFENnUxJx3F2UDbuMZFafwndv5GqGePHeD7MraPK7g8dw3pvqFdQFFr
	 pZbmKpoZnUe0qE51afm4imeM2c1+nIpHl+B0GUKuZE2SCqtcFXpRJLTDv1QGpfof/7
	 pV/ouUvkkf8mgAns6DrGf+yv51JGr5acLRSYE9ptym7h2rdw/vaNdIK6Pr2M0Khglg
	 2ZEszpyDWZV1nZHyyYHqxe+9sY09AaFkx6UWSthhATE39L8BOSGPto1ADLTW/QeJut
	 +LvN8Jm2vUuMvhr3hzb6tmYkqZWxEEVC9HdZghmntdiIdqgJ6Vm8VlenzG8SpqaEqn
	 lyq0H/2pF42gQ==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4A3BF17E0497;
	Tue, 22 Jul 2025 21:54:41 +0200 (CEST)
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
Subject: [PATCH v2 0/3] Clean some logs on rockchip hdmi audio
Date: Tue, 22 Jul 2025 15:54:34 -0400
Message-ID: <20250722195437.1347865-1-detlev.casanova@collabora.com>
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

Changes since v1:
 - Add comment about clock requirements
 - Add Fixes tags to the drm/bridge commits
 - Link to v1: https://lore.kernel.org/all/20250717215620.288651-1-detlev.casanova@collabora.com/

Detlev Casanova (3):
  drm/bridge: dw-hdmi-qp: Return 0 in audio prepare when disconnected
  ASoC: hdac_hdmi: Use dev_info on invalid ELD version
  drm/bridge: synopsys: Do not warn about audio params computation

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 13 ++++++++++---
 sound/soc/codecs/hdac_hdmi.c                 |  2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.50.1


