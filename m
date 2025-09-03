Return-Path: <linux-kernel+bounces-798350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B3EB41CC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F59E3A2DC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C022F7449;
	Wed,  3 Sep 2025 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pzmGJUW5"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41D52F6180;
	Wed,  3 Sep 2025 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897787; cv=none; b=Sp4Z6sXCfT4RVEWFfvpC/7m/W74D3Vonz4/GQc8R9S//fOqJfxBHkXcOMdQygXjC+BpQA/KHemB5CJRnm4R5iBoLRFajjOfYvFrBH0JGYa7EmICUxz4Ff5CP6MDjKtTQdLrnE1Hv0M2ZOIQuQwuuvPVxV9ml8EAjEhNNj4XIKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897787; c=relaxed/simple;
	bh=5JuM+zVZonADMosGAewf0MPciwlPQvws9ZO+aeqWtgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oi3nw0dMGl0NGE4yUn3btwrLdLO3q9p46yfQJS72Z5yj74yZAUYZN0wd9338BmadMBGGduPSvhdNEp0aoRjVxhMviZFFspoTJGPhoWjQUgZ3EMdv42BUZ6yQgFEM5+7FnMnvD+SeqOrzER3difTjUyOKxNPSWZxRrzOmvcknZFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pzmGJUW5; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=c0
	/SBiSXOOl6HFr+JmOjCWEmu3pstjSyRziH55Av6WA=; b=pzmGJUW5GsUD0zajgM
	1dLJ5xfepWw+5r6dKHs8FqtSnbSrW6yE4YGJJgieet+W9uNB1cCZPLY2cMlHAziF
	CeAW/sq3nKyZtSTjyQ6nN4BdM4UVJOfciEZrD2to83lqxyMEtbXujEgp3CHn79sV
	nTWuDvNnkqHafHOXA5tRWUOXE=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC3ZLuqIbhoXAZsFw--.3268S4;
	Wed, 03 Sep 2025 19:08:34 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de
Cc: mripard@kernel.org,
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
Subject: [PATCH v7 2/2] MAINTAINERS: Add entry for Innosilicon hdmi bridge library
Date: Wed,  3 Sep 2025 19:07:39 +0800
Message-ID: <20250903110825.776807-3-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903110825.776807-1-andyshrk@163.com>
References: <20250903110825.776807-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3ZLuqIbhoXAZsFw--.3268S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy8uFyxCFy5Kr17Zr48tFb_yoWfGrX_GF
	18JrW8Zr4jkFWjy397Ca1fX3sIkw4xtF1fXFn5tws7Jwn8AryDJwn2gryIgr15CF1xGayq
	qayUXF9Ikr13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0iqXJUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEAO9Xmi4H7lLfwAAsy

From: Andy Yan <andy.yan@rock-chips.com>

Add entry for Innosilicon hdmi bridge library

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 88851907b6725..d4b5eea84cb9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12085,6 +12085,14 @@ M:	Samuel Holland <samuel@sholland.org>
 S:	Maintained
 F:	drivers/power/supply/ip5xxx_power.c
 
+INNOSILICON HDMI BRIDGE DRIVER
+M:	Andy Yan <andy.yan@rock-chips.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/gpu/drm/bridge/inno-hdmi.c
+F:	include/drm/bridge/inno_hdmi.h
+
 INOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
-- 
2.43.0


