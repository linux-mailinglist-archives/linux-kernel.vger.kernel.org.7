Return-Path: <linux-kernel+bounces-739545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5EDB0C7A0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9F37AC59C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94122E041E;
	Mon, 21 Jul 2025 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="VlqOWZSi"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0E2D94B9
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111733; cv=none; b=efPdt6JEGbmzbRkyeDNY3jo5nUeoLf45xrUlbON+9jtI0rk0vZvxLzvmGJnuHNvNqhTNN88ePlS7y4twvKbmVm0DHZOgOU6SDJL+Tht3i1P5trTcIu7/QPTfg/3RVvaX7SXnANpsR4myCVHwtALLv3MdkcOmlMDx7tI/B6aQHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111733; c=relaxed/simple;
	bh=Ra1Zfq4NN8pr6UgfYgPY6bPL0/H9o2RP9ys2ZgAjE5I=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=QgkccyeRxxSh70hq+9LM+GQXMQnmzm2CGZSrie9JoCGrX0RB/yH0FpFtqRHRiqg/i8D/s/XsJ3m0Tt901g+BDwVwsuebKtjXWJfdWFVzR3UFwSKdbKi1Z4si1YZaZukgZpcIarxCzL/q9e+JzqcZDCUlT2nDOYbHr5nIYvFNTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=VlqOWZSi; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=Ey3xOTKqI0BLXWienDIPPsKiuMwbEHrDRNd0N6CIGRs=; b=VlqOWZSi26qY3yJ0sB/48LmVEy
	RJmLIbHbXngyMD3xkYHPnOm7TwIWkPTwGyO7sbpLthc+8MqMMrJUMK1JJeq2E1w4ovuUB/BUkgFTZ
	ncyv3GNSy6Sc3VFFkJd70UplaYxkkFLdK2VFvQM85X5J0lNoKrwe9LWiIQAvP9/rT/N4=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:45616 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1udsRI-0001Ys-SG; Mon, 21 Jul 2025 11:28:29 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
	Purism Kernel Team <kernel@puri.sm>,
	Ondrej Jirman <megi@xff.cz>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 11:28:15 -0400
Message-Id: <20250721152818.1891212-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH] drm/panel: sitronix-st7703: fix typo in comments
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fix typo in comments:
    souch -> such.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 1a007a244d84..6c348fe28955 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Driver for panels based on Sitronix ST7703 controller, souch as:
+ * Driver for panels based on Sitronix ST7703 controller, such as:
  *
  * - Rocktech jh057n00900 5.5" MIPI-DSI panel
  *

base-commit: ba0f4c4c0f9d0f90300578fc8d081f43be281a71
-- 
2.39.5


