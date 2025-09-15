Return-Path: <linux-kernel+bounces-816620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9231B5765B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B5A1A22439
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829692FC867;
	Mon, 15 Sep 2025 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fv5zLu5D"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069862FB63B;
	Mon, 15 Sep 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932284; cv=none; b=rkTTEt2Wc08ia6h+KedhvZR5YJz6PoZhPfXuMmZBn1AsBhvVE9DPjvGad+ARPXE9XAX6XH3EkA0B87s3qAwcpxdAIz2gFjh7Fok0fScqTBO9up5woe4LhLiA7hCUVYyhEThjpiumzgHHEbgOmQCyOb1f/hFR7YxvJQXUyvyChXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932284; c=relaxed/simple;
	bh=aew4ADXH0mryTgiraNHSkot0HAUTrj7/IBT+K1xKTio=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VCWnmjwswlVFXS+BYyRQqwgRJFqxpi5lvuH4KDolwmX2e4G31UvHeX3sPZ0sZGNNKTz6kgOnxSUcKNi39nzgyAETd0/NXjprrKTmyvEL6P22UwJYFLvNfEWXr9tM0cV/J6w6kAKanocI/pefIiuJ9Omub57auFlLgzDNI0Ot0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fv5zLu5D; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58FAUpuR1475186;
	Mon, 15 Sep 2025 05:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757932251;
	bh=TxCEGkPcqU0f/GCFbh3VHVF++0uz4F0w16GZ6D91CRo=;
	h=From:To:CC:Subject:Date;
	b=fv5zLu5DtLlgvtJC1SrHCnvX1LXAB/p3OQZY9ACrtWl210dJfsjvRT1T+Bozq952m
	 0TjgDMmpJylYFbddgYTpQFJmvieZM+BjkNC2fLUts807gzA6hFdM0dUMRt93ndEDWW
	 VjjfpdxwlrXjYlZq3TQ+UF0lVVCez2J9Uxmc0+bY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58FAUo333894146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 15 Sep 2025 05:30:50 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 15
 Sep 2025 05:30:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Sep 2025 05:30:50 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58FAUfRd3600864;
	Mon, 15 Sep 2025 05:30:42 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <sjakhade@cadence.com>, <yamonkar@cadence.com>,
        <lumag@kernel.org>, <dianders@chromium.org>, <jani.nikula@intel.com>,
        <luca.ceresoli@bootlin.com>, <andy.yan@rock-chips.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devarsht@ti.com>, <u-kumar1@ti.com>,
        <s-jain1@ti.com>, <tomi.valkeinen@ideasonboard.com>
CC: <h-shenoy@ti.com>
Subject: [PATCH v5 0/2] Add support for DSC and FEC for cadence MHDP8546 bridge
Date: Mon, 15 Sep 2025 16:00:39 +0530
Message-ID: <20250915103041.3891448-1-h-shenoy@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi all,

This patch series extends the Cadence MHDP8546 DisplayPort bridge
driver to support Display Stream Compression (DSC) and Forward Error
Correction (FEC).

DSC acts as an encoder block: when the sink reports DSC capability,
the DPI input stream to the MHDP8546 TX is compressed, and the sink
decodes the stream for display.

The first patch updates the DT binding to add register-space for DSC.
The second patch implements the corresponding driver changes to enable
DSC and FEC when advertised by the sink and configured via DT.

Link: https://www.ti.com/lit/zip/spruil1
TRM File: SPRUIL_DRA829_TDA4VM_Technical Reference Manual.pdf 
(Figure 12-1115 and DSC related sections) 


Changelog v4 -> v5:
-Defining reg-names item list in iF conditional, added 
description for reg-names.
-Verified the bindings with cdns,mhdp8546 compatible.
-Add code for enabling DSC in bridge driver.
Log link-
<https://gist.github.com/h-shenoy/0318e2c6e7df539e6bdd39b77e5a8f05> 
Link to v4: 
<https://lore.kernel.org/all/20250909054622.1439487-1-h-shenoy@ti.com>


Swapnil Jakhade (2):
  dt-bindings: drm/bridge: MHDP8546 bridge binding changes for DSC
  drm: bridge: cdns-mhdp8546: Add support for DSC and FEC

 .../display/bridge/cdns,mhdp8546.yaml         |  24 +-
 drivers/gpu/drm/bridge/cadence/Makefile       |   2 +-
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 367 ++++++++-
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  68 ++
 .../drm/bridge/cadence/cdns-mhdp8546-dsc.c    | 695 ++++++++++++++++++
 .../drm/bridge/cadence/cdns-mhdp8546-dsc.h    | 285 +++++++
 6 files changed, 1406 insertions(+), 35 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-dsc.c
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-dsc.h

-- 
2.34.1


