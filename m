Return-Path: <linux-kernel+bounces-721213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF681AFC631
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7301AA1E31
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4442BEFFE;
	Tue,  8 Jul 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQVpBAOt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0A2BE7C0
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964740; cv=none; b=FLruf4xc/2Zs4/6Kd2GSjiF6jS+niGOjYZBPE1GZZOXcwnX9Y9wIP94Ap1Iil9BYzl+sX/46q08u1k/PxlNlAI5U6FccaQAU1KVlzrMBE9AiCX2Zgk00IrH2ZTGMxPPcqOERPXywrWa1AYxjO+IcAbrSN5AdqH1KROJN7i93i40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964740; c=relaxed/simple;
	bh=LKFf/zGyLqNzojJhAHw+kv8fYXSumZx4S7DH83BWnk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y3urg7K7EO7tYW+kEfOf+Zpjnpmvi0sYmFjYYKW1PqYv9raV0IEE5gveOtJKfjjd2D4dwXnMHIyVtn8PvUb7s81ztrUHwlT2vcYLhMi9U7oSD0DqTFx3helMAKeiovwMzu5MboVlyUka1a8F3RCgzjcw+4I3w1qUo3RJgoqjVrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQVpBAOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F71BC4AF09;
	Tue,  8 Jul 2025 08:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751964740;
	bh=LKFf/zGyLqNzojJhAHw+kv8fYXSumZx4S7DH83BWnk8=;
	h=From:To:Cc:Subject:Date:From;
	b=hQVpBAOtXe2Ftl4fyf22qUArzX/GT6xR4VDo2wX8IK++1rRkgFtg0+GQIG+YnlDgI
	 4d5SMPSsxqUIlbtVTD11TtMeNA3Y+TRY5c/b3JJTGN16U1GpGUO+fSBMUtx9bO6KUf
	 aUT735vo1iLyw0LYpdR5MjvMC8W1xfy8gh2x4Mf7t8cP8T6HMB87EozpZrXOy83s4s
	 FGm1BCoqhzEAA4IiTG32oWJ4HZ2MTFhGthqcsokcHxz8jNTw7cTDfH0E0YbLOl5+aS
	 1w0hw8u/vGUF+pkZbN9urer2IGQLbpwHr9Di/BjxLmAXXNm8kzsRIC354LiTmt8su4
	 0vEco7d2TxnmA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZ43g-0000000042E-1Ju7;
	Tue, 08 Jul 2025 10:52:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Douglas Anderson <dianders@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] drm/bridge: fix OF node leaks
Date: Tue,  8 Jul 2025 10:51:22 +0200
Message-ID: <20250708085124.15445-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the OF node references taken when creating bridge
device when the devices are later released.

Johan


Johan Hovold (2):
  drm/bridge: fix OF node leak
  drm/bridge: ti-sn65dsi86: fix OF node leak

 drivers/gpu/drm/bridge/aux-bridge.c   | 2 ++
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.49.0


