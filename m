Return-Path: <linux-kernel+bounces-798639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7050B420A2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AEE1729A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6BE306D53;
	Wed,  3 Sep 2025 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lontium.com header.i=@lontium.com header.b="FWD4XBeo"
Received: from out198-7.us.a.mail.aliyun.com (out198-7.us.a.mail.aliyun.com [47.90.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E02F7449;
	Wed,  3 Sep 2025 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904988; cv=none; b=piymV6x2Vnap6b+eHyR+K2VfKZkNbyzfO9u+jcvabVOs2CWJ4ZCkPbhJlF/4Gau/2FYtoCK4oQhONqyJDxtouzFpDJCvS5/zBYGmFSE5YFqQGtDQL1+f1ssWzdSud8CJ+Z2sRfot24PzfRvNyqnQEPqvYsUcyAUJVjlJL1HJPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904988; c=relaxed/simple;
	bh=Ti7ENNTkZLGPK0zfgI1wNpONvBQRJE4kmOpoG6UiD1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G3w9sGKTfpiFYpPV7g4S+UF8HBgdZhH9/u/6KPOSGpqbhsFzQ6aoSd7mdcEMqk+4kin6/WYB0uYnXzuZOemIt7Doi05LJgwSLPvJkIalaLepWREEpKLf1oV010R55I7nLY5xwYw5U3Nb9K733vcqb7kll27A3d6kl+OCqeaaYMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lontium.com; spf=pass smtp.mailfrom=lontium.com; dkim=pass (2048-bit key) header.d=lontium.com header.i=@lontium.com header.b=FWD4XBeo; arc=none smtp.client-ip=47.90.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lontium.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lontium.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lontium.com; s=default;
	t=1756904973; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=R1mBpxZzOBmr4OvrwC6DRVSFnViYnXsa+gksnGmLJCM=;
	b=FWD4XBeomQ/FjtL0Vpm/iqMRnCe2fgnJqUKK9Hzho0UnmfTL9PpugJuo99bjVb0uI/Pjw5WPxCSYUUMH7j714N33ygEnlIsuhrWKHM4R8fu7g5CbHtjbnClYanYsVkKvMELZicJaPUg3ct2pWFLBZPunnu9adIiNeNhDLXNdnQ5n56XYvB3IWkBbxNREpL+I4mf6j0XCXZv1678Owju+cTIFDJ+gZzsV3yRdxXZQBcfmUaa+7RTK+euaEehPBf3sYBpAgfCdhXT2DAE/mXDHgmL0yE3AzpnHoSrKkTKATaU9DtaKsQk6m2ikrOqLangJZ4k3IksLFoKJTzmkqkKUfg==
Received: from ubuntu.localdomain(mailfrom:syyang@lontium.com fp:SMTPD_---.eWhncYY_1756903112 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 20:38:33 +0800
From: syyang <syyang@lontium.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	yangsunyun1993@gmail.com,
	syyang <syyang@lontium.com>
Subject: [PATCH v1  0/2] Add LT9611C DRM bridge driver and device tree binding
Date: Wed,  3 Sep 2025 05:38:23 -0700
Message-Id: <20250903123825.1721443-1-syyang@lontium.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the Lontium LT9611C chip:

- Adds a new device tree binding documentation for the LT9611C bridge.
- Adds a new DRM bridge driver for the LT9611C chip.

syyang (2):
  This patch adds a new device tree binding documentation.
  This patch adds a new DRM bridge driver for the Lontium LT9611C chip.

 .../display/bridge/lontium,lt9611c.yaml       |  123 ++
 drivers/gpu/drm/bridge/Kconfig                |   16 +
 drivers/gpu/drm/bridge/Makefile               |    1 +
 drivers/gpu/drm/bridge/lontium-lt9611c.c      | 1496 +++++++++++++++++
 4 files changed, 1636 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt9611c.yaml
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt9611c.c

-- 
2.25.1


