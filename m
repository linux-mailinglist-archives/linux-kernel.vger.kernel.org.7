Return-Path: <linux-kernel+bounces-597537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6398CA83B41
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 09:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6218A5BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 07:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA872080F0;
	Thu, 10 Apr 2025 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JnFbDt/j"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25A204582;
	Thu, 10 Apr 2025 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269906; cv=none; b=hXU08o/lji70QaplBSfiUjrrq3taQpuXep/MKj7hajkouWKYfzK+gNWv7O/GOcPK5ghXEfM7ZMFaTWGrqy3xzpjXaTDtBwIPLESaSKM4rFvdg+HXEF2RY+GlWTTp7/u1hF4rxv5ICk8kiiXLgn1kh9Vl4ssuVJLGcwQcc4BpWvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269906; c=relaxed/simple;
	bh=ludwYxxWykd3UNm6vqdS8Bi+2xysSxn73pk/rCoOekI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGHi4nQBWM0Y9RUozcqaB9bNHqXNE0SstNhLRRvzsT67zyUpzSoS55QGMiTpjNpykT2dVdUOKTsNTQThU0jvk5iW5YKi/IRPjAFqOrv69yxT2TgF8Uh73wtWUGJM8mbocyOMb7jVyqHvJkXx9pd8cNrDZjVnUe/y0tBubTRxlBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JnFbDt/j; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744269902;
	bh=ludwYxxWykd3UNm6vqdS8Bi+2xysSxn73pk/rCoOekI=;
	h=From:To:Cc:Subject:Date:From;
	b=JnFbDt/jdh7jMbTLxSVzRhZpair1+C7GwSLwQGTLSlXk8jHtIZ6kFYluSfQk7mccz
	 uKCKGA/O0uaS5d1Nem/eW8WLJCmaEO5wTgZ+XFI2ChiGCZ/xRECBnapqsWB/awJLYv
	 RHEavzpISLGyQikscgpyzi4P27AoG2ZEUX0ro5DeIZ2ti8fICjyKPB2sY/jHNZP6Pt
	 wNzJ3uIagr3PY8FsG0+Ghdrlv+siRLKKAJNPbFe1ZKumakpgN3s2TmJ8FlHOMvFswp
	 Qv83FZFnXUdbU8Pz5Xy1NCV6flMrBKJgV1mGI9NXa+kXAEiAsJhn08LhPOgytKtbbd
	 NC3A/UFD9eUOw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 461A617E0D69;
	Thu, 10 Apr 2025 09:25:01 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: neil.armstrong@linaro.org
Cc: quic_jesszhan@quicinc.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	angelogioacchino.delregno@collabora.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v3 0/3] Add driver for Himax HX8279 DriverIC panels
Date: Thu, 10 Apr 2025 09:24:53 +0200
Message-ID: <20250410072456.387562-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
 - Added support for setting digital gamma parameters and validity check
 - Added support for setting analog gamma parameters
 - Changed gout_{l,r} to a structure and added a description
 - Fixed DSI LPM/HS setting in prepare/unprepare callbacks
 - Remove forced panel off in probe function as that was simply
   useless
 - Renamed function hx8279_check_config to hx8279_check_params
   as that is actually checking multiple parameters and not just
   basic DDIC configuration
 - Moved the GMUX and GOA validation to their own functions to
   improve readability

Changes in v2:
 - Removed unneeded mipi_dsi_device_unregister() call for secondary
   DSI: as the driver is using devm, that's not necessary (CJ)
 - Removed superfluous if branch as pointed out by CJ

This series adds a driver for DSI panels using the Himax HX8279 and
HX8279-D DriverICs, and introduces two panels using such a configuration,
the Startek KX070FHFID078, found on some MediaTek Genio Evaluation Kits,
and the Aoly SL101PM1794FOG-v15 usually found on some I.MX8MM boards.

This panel is found on the latest hardware revisions of some MediaTek
Genio Evaluation Kits, and specifically, at least:
 - Genio 510 EVK
 - Genio 700 EVK
 - Genio 1200 EVK

This driver was tested on all of the aforementioned boards.

AngeloGioacchino Del Regno (3):
  dt-bindings: vendor-prefixes: Add Shenzhen Aoly Technology Co., Ltd.
  dt-bindings: display: panel: Add Himax HX8279/HX8279-D DDIC panels
  drm: panel: Add driver for Himax HX8279 DDIC panels

 .../bindings/display/panel/himax,hx8279.yaml  |   75 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/gpu/drm/panel/Kconfig                 |   11 +
 drivers/gpu/drm/panel/Makefile                |    1 +
 drivers/gpu/drm/panel/panel-himax-hx8279.c    | 1365 +++++++++++++++++
 5 files changed, 1454 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx8279.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx8279.c

-- 
2.49.0


