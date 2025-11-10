Return-Path: <linux-kernel+bounces-892807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48699C45E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9244D4EFACA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3BC2F6932;
	Mon, 10 Nov 2025 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FJ2z7qVZ"
Received: from mail-m19731101.qiye.163.com (mail-m19731101.qiye.163.com [220.197.31.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764773074A2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769667; cv=none; b=d6HA4MDhOKB/nmxmZpBH9xabtydCITrgOEXohUZgsr7rg1c5f9C3ynABd9qaKpDZ4wqBFJYbKWFKSKOrM0hdf6ZYjvSiPE7aCr4k+Zo2dR6BZIFVVek5mAfywfor69I7vxdVjLoK0PhFZ5tKGSSQ6axlWdxPKHmjaQuN7oYY3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769667; c=relaxed/simple;
	bh=hgwSacJiQcT3xs3gutDuQY+OMfwPAnD2MmyTzQPd0Lo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PM90UeGhYvhBI6Pfh/MEJNqgWYGpHP7Xcr/VX+WqYwJH59Eo6Ys2dziQoXhJtZmiDCdtLr/5erXEAYTfp/ydHzJjGhk1uFhTanjM7ToIJ20uusgHcr+j8S/PR7CWNwE9iegEMOD8hWsrwuspwmJIwJm4JuC2luWQzhNvHMbm/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FJ2z7qVZ; arc=none smtp.client-ip=220.197.31.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29068b4ed;
	Mon, 10 Nov 2025 16:58:38 +0800 (GMT+08:00)
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
	dmitry.baryshkov@oss.qualcomm.com,
	dianders@chromium.org,
	m.szyprowski@samsung.com,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v3 0/4] Apply DP helper APIs to do link train
Date: Mon, 10 Nov 2025 16:58:19 +0800
Message-Id: <20251110085823.1197472-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a6cfd1b4c03a3kunm91e8d29910ac4c4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlLS1YdT0xLH0IfQh4ZThpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FJ2z7qVZQ6/QYQQCRDzK6uzMBmlGV21oODl2EJdezVVkhkwdpWgr+9Xj+kORtROwhis/0OKAtkZFHQiVt8F9iOMEhOS5/ycxnc1wLmd4jAfFQlTdg1PRs6wEHyD21xvS1DZDbj6PuyfLv3+AwSgaVaeA6Fypl1Pw3OfI0MrgNzI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=GgicSIGu0ctvY+ZmjY4F6uew1MDwxU5622xODKbenHQ=;
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

Changes in v3:
- Update Reviewed-by tag.

-- 
2.34.1


