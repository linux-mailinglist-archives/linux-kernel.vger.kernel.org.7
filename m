Return-Path: <linux-kernel+bounces-855751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C65EBBE22FB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E59519A6088
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D9D3090E6;
	Thu, 16 Oct 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E/GsQi+B"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF8305E19;
	Thu, 16 Oct 2025 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604013; cv=none; b=FXOdulSlWLSOozX+RjzTakaKvPfuyEyNQG1Om/oTOJIRmDMxFEENoiCjANK8YsHQ8xXkxhvQBvZ8+sU3wtbHc3qsIbz/BC1gqK9OEj1AO9WAtLVKwX+6+dhUOtUPrxFJsfJ4k98a9+yRJAdiqaYy8VVzeow3Sc5WReWWfVCHzhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604013; c=relaxed/simple;
	bh=kpaJoKLIAtoXE7a7bKFOuUcUHMSwAR24u2lEz3S3qk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHtVE0vQ/LXOB5gCaDTx9IDHFlsMvEIEfqPwgxG/S1co1YsoJpxPOlOGeNW/fWorQTfAS/mVLdJ8TMtTq7AV6vdTbgDCTfxiB3Wus1SPSKholhYkDqjQfVLRXtkuQWGGFxAETsqK+nVlIB8STl7YQnKMAdI9L3855j2SbuAXWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E/GsQi+B; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ix
	Gc5ZdTT14v81WPC3wXsCZyyieCXulxCvLgUe5Hq3g=; b=E/GsQi+BzG53MLkk6s
	Mcv08ad341bMn17yB1n9gsZFLBeCSfwZfw4GEDkFte5MOhrd6jcYBQxFlvZQ7xbO
	5CLFakkeuQfQij9KzUkj1610gyc77m1nJxcRrIUTAmQeyH47S5ahzwi4mCH6LHee
	Ork+XLvz/V7nQ3Oij5mxP2iIw=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3f_8Ur_BoSVKcAg--.8978S4;
	Thu, 16 Oct 2025 16:38:53 +0800 (CST)
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
Subject: [PATCH v8 2/2] MAINTAINERS: Add entry for Innosilicon hdmi bridge library
Date: Thu, 16 Oct 2025 16:38:32 +0800
Message-ID: <20251016083843.76675-3-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016083843.76675-1-andyshrk@163.com>
References: <20251016083843.76675-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3f_8Ur_BoSVKcAg--.8978S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy8uFyxCFy5Kr17WF4rXwb_yoWfGrX_GF
	18JrW8Xr4UKFWjy3ykC3Z3G3s0k3yxJF1fX3Z5twsrJas8AryDJw1vgry0gr15CF1xGa9r
	Way5XFyakr13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnkWrtUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEBboXmjwquCKXAABs1

From: Andy Yan <andy.yan@rock-chips.com>

Add entry for Innosilicon hdmi bridge library

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f9f985c7d7479..0adcfb1c264a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12299,6 +12299,14 @@ M:	Samuel Holland <samuel@sholland.org>
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


