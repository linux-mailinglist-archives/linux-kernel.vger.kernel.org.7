Return-Path: <linux-kernel+bounces-812823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D244BB53D26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38C344E15C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E9A2C0F97;
	Thu, 11 Sep 2025 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="EVroO2MF"
Received: from mail-m15588.qiye.163.com (mail-m15588.qiye.163.com [101.71.155.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268922DC786
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757622676; cv=none; b=MFH2+x/aA8Hr1gzP2fIXsQX8WNuLPMPPIpkF/kn1VSVs57H3kHpkWvwKynb21zHv21rEJplm9j1nvL4i+t1WI6hX4yXF65LvlQ6yKRlHROJixfajM6nCd5SltD15x0A//AP2/VPOPXtcnY2z/fgfrrFfpVrJROu/eNmtOzxw1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757622676; c=relaxed/simple;
	bh=3TYIVr2xV/c4oaEz+VRXeSKNP2901s6Gd/Z/GNwQ3WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MMi+QskZdKhKsG8mo1UrvGFq8XyC6Tk45kA0P5R0FH/gcWduYlcOSm0+yFjG+fJzQIJCmBk0Bs1ZKv7m5csSLjW0DARVIlKA3u8jhnkucjbbGHmtiKR6LMAVIwtylC6EZpZ27e0p6dBrX9UIzYLL6Gt9gmK3U3rnfyW9WF209Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=EVroO2MF; arc=none smtp.client-ip=101.71.155.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 227a3f1d8;
	Thu, 11 Sep 2025 19:27:59 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dmitry.baryshkov@linaro.org,
	l.stach@pengutronix.de,
	dianders@chromium.org,
	m.szyprowski@samsung.com,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v2 0/4] Apply DP helper APIs to do link train
Date: Thu, 11 Sep 2025 19:27:52 +0800
Message-Id: <20250911112756.4008435-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a993888476f03a3kunmb42177f792e2d9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhgfGlZCTR1IHk1MSRhLQ01WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=EVroO2MF3GnFuw9hJfohQ1fmLW1XOYM3YebZjt2OFUuZlpGO70vt4DcyHY9f4Wnm+X6mZ4ftsNAgztk50h7YQOu0NL5sEi6ZjGoJacbD5ViE52kDNQ+AOhihOYVse7MwpdClHCng27N4TFxItbMaHsEo4/709b+W+yutle8Y2Ow=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Hk7Ki6Si6z3USDwD3fN4IHJ3bHgwqmzOwTM8IT8h4M4=;
	h=date:mime-version:subject:message-id:from;

Use the existing DP helper APIs instead of repeated self-defined
interfaces with the same functions. It can help make codes more
concise.

Damon Ding (4):
  drm/bridge: analogix_dp: Apply DP helper API
    drm_dp_dpcd_read_link_status()
  drm/bridge: analogix_dp: Apply DP helper API
    drm_dp_clock_recovery_ok()
  drm/bridge: analogix_dp: Apply DP helper API drm_dp_channel_eq_ok()
  drm/bridge: analogix_dp: Apply DP helper APIs to get adjusted voltages
    and pre-emphasises

 .../drm/bridge/analogix/analogix_dp_core.c    | 123 +++---------------
 1 file changed, 18 insertions(+), 105 deletions(-)

---

Changes in v2:
- Update Tested-by tag.

-- 
2.34.1


