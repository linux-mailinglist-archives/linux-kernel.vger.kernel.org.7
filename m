Return-Path: <linux-kernel+bounces-783520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E8DB32E90
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3756218965F6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7883D1FF7C7;
	Sun, 24 Aug 2025 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jfCDf3gJ"
Received: from mail-m15592.qiye.163.com (mail-m15592.qiye.163.com [101.71.155.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753F1422DD
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756026068; cv=none; b=Ws3E6bl/LecF08JCC8+XPch19LakzRMpIcDKIIR4TW9Ma9+T9hwsYyKVduLEnLMYSdpwmoPf4AlwuKRUdT9L7rzRm/0aeg8BdruJkpsMBxe8zqFfr94SwpvhtenlRRzn98409VpHZjLyHldiiKDgW424EAawKyObhHnM/gcrkyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756026068; c=relaxed/simple;
	bh=CH7+99MaZ+g1y8+5/w46hf9fnzrZ94NSNetPlWBkStw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pi9IvM5/W3JHLvPr3AJ95HMF1leqYgUjTIdMy9SQvG3EV5nNVJaKWf+E/LctPdP3e++AGKjv5Ft7RWHC6jWpopULzDjGZP6PDSWbeWb44Y7ZpEqzoUY+mezGV0uoyfgrz4Q51bvNrlPiXYWyu6WsFvGLpsqTH/rA9YeRd5e5Alo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jfCDf3gJ; arc=none smtp.client-ip=101.71.155.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 20643f359;
	Sun, 24 Aug 2025 16:45:39 +0800 (GMT+08:00)
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
Subject: [PATCH v1 0/4] Apply DP helper APIs to do link train
Date: Sun, 24 Aug 2025 16:45:25 +0800
Message-Id: <20250824084529.3317985-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98db4131a703a3kunm71d2620e2ad651
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkgdSlZLTB9IHxgaH0NKTk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jfCDf3gJFNQnNKRDRrCkjZFo3iI7qjsyHCLLSoVH2YbZvF1R/96WspKN24qieilIsaJawYACGdU3qf+BcBaWBVg5ccccyW+AgMslolxUb/uPmlgtFa2Wab7UV9tquZ11cSTN2FPWubYUiVXrXWnwHetzut3wNzYfuFiHsc+2xSM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=hr2nkaude4kTGAK7pbS2GmFXrT9k46D/c2wtl2Xnp+4=;
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

-- 
2.34.1


