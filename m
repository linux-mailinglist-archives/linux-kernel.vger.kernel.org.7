Return-Path: <linux-kernel+bounces-734887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687AB087BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3B53B2400
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD33F27A103;
	Thu, 17 Jul 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TvgTb5T2"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D9713B58A;
	Thu, 17 Jul 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740100; cv=none; b=Ly2INW/sOkTDHEA3wf1SJcT7P9HLEFvD48GAa1pYkEWjECaR7yF+iuP8SrWM/Riw7MaBE7Rlyrpmn+0pD3SuBOEvDiriyhWAw9I+TWEoY0LMgeFelnrwivGVaj6yLTt7FVaIirU6qbpgMsZCpqLjmjtD0tKbGEuuZWdw7jXOHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740100; c=relaxed/simple;
	bh=uiMRUzhgcmKn2y2ImzVb3qCJgjq0lXgmyfLyccOwAUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+opGRk/w6Fq2zOMA1iaJzhJm2A3noRRBpNekhy2c06LSn/eIbv5w3FO/OwohzujxosFXyhjpLB0JjsTkRbGlDIYd668rfRP8fh3RYKHqnI834MD/3uOyBNVoOjHhIIk9Dt3rhZypXm/FBXsZ/ddpQbSz38vCtjP/Ka+NB1ypRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TvgTb5T2; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PM
	uQNuZHynTbdVNIIMfLYsoElWxgT4IgmjP+PUnkAhE=; b=TvgTb5T26kOQQME21A
	rSt6O9iaTj5y0O98gp0B8BCR09PO2g5iG5DoWNqqyWGNf4uFFaC0W5u4mUM3xXow
	HJ9/XRYo8bxTfL9mKBh+P06smcWimkZKt9zgWgRCuR/3C/5+GqzGZH6LTY1MsgSu
	yrg28+uPBPWYBDEcdekX5iGhE=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCHFbq9sHhoLS7XFQ--.22249S2;
	Thu, 17 Jul 2025 16:13:55 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	hjc@rock-chips.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	andrzej.hajda@intel.com,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	Laurent.pinchart@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	rfoss@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	knaerzche@gmail.com,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v6 0/2] Convert inno hdmi to drm bridge
Date: Thu, 17 Jul 2025 16:13:35 +0800
Message-ID: <20250717081344.1355613-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHFbq9sHhoLS7XFQ--.22249S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4fZw1rGr45tr45KF4Durg_yoW8Ar43pa
	17Cry5CF47CF42grs7CF4fAr1Syan8Jw4S9ry7X34SvFW29F1UArna9F4Fqr9rZr47CF42
	yrZ7Ja47KFy7ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jv_M3UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMxyNXmh4rblpeQAAso

From: Andy Yan <andy.yan@rock-chips.com>


Convert it to drm bridge driver, it will be convenient for us to
migrate the connector part to the display driver later.

Patches that have already been merged in drm-misc-next are dropped.


Changes in v6:
- Rebase on latest drm-misc-next
- Link to V5: https://lore.kernel.org/linux-rockchip/20250512124615.2848731-1-andyshrk@163.com/

Changes in v5:
- Split cleanup code to seperate patch
- Switch to devm_drm_bridge_alloc() API
- Link to V4: https://lore.kernel.org/linux-rockchip/20250422070455.432666-1-andyshrk@163.com/
- First included in this version

Changes in v4:
- Do not store colorimetry within inno_hdmi struct
- Link to V3: https://lore.kernel.org/linux-rockchip/20250402123150.238234-1-andyshrk@163.com/

Changes in v3:
- First included in v3
- Link to V2: https://lore.kernel.org/dri-devel/20250325132944.171111-1-andyshrk@163.com/

Andy Yan (2):
  drm/rockchip: inno-hdmi: Convert to drm bridge
  MAINTAINERS: Add entry for Innosilicon hdmi bridge library

 MAINTAINERS                                   |   8 +
 drivers/gpu/drm/bridge/Kconfig                |   7 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 .../inno_hdmi.c => bridge/inno-hdmi.c}        | 502 +++++-------------
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 drivers/gpu/drm/rockchip/Makefile             |   2 +-
 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c | 188 +++++++
 include/drm/bridge/inno_hdmi.h                |  33 ++
 8 files changed, 374 insertions(+), 368 deletions(-)
 rename drivers/gpu/drm/{rockchip/inno_hdmi.c => bridge/inno-hdmi.c} (69%)
 create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
 create mode 100644 include/drm/bridge/inno_hdmi.h

-- 
2.43.0


