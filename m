Return-Path: <linux-kernel+bounces-734889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD10B087BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A63C4A7687
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C0E274FF2;
	Thu, 17 Jul 2025 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dOC1rXOu"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1530527991C;
	Thu, 17 Jul 2025 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740106; cv=none; b=dxq8V7TOdBuz29FvFamsNfuoHNY4infNh73FN69bNDRD5whgdS5kKXd9naMfZaEckr0isShmOz3bLA727DdD7YXLAqU73XMtWQEnds1juOktzdatgp2MFKGqJrhlprEEJHP1wNRSc+iyKNyn4Ah4Zjpifg+XURAF7TgpBLu8mdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740106; c=relaxed/simple;
	bh=FiSOUoa9oVG0wCvlaU9rvK/JiuKXrCXVrXjEMYp2sxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ax5PMsTf0DF/CzTOasqEMISFkneCechf31OYKoEw9POHWEoaXvnzVttyFBK6EGlYjtsr+nT94sSdM6051cbGbfp2w+qrbJkRgJ9vzbBmTg89H12bNQXE1jvZHMB3vVNQS3K52wJ7OxgRN/GLLRh6PrkgJpia8bv1MPf7hAa46pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dOC1rXOu; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3F
	ZEPCuqg+j4PT7ny21iPN/qrpZr3fDoK5twCI5iDpE=; b=dOC1rXOu1U0D9+7e+e
	lzeBQSrZJq++NdbuV21sILbGHtcJNc5sQpNSokou6Gak95PKGE4SxIultwM/N646
	du53zl3+WZ3uEY1BjRWO2wzegiZDpcK3N6yf+eA+NGmyNznjimozulMhAKF3LP3Q
	MPevJqYUUvsNOzWFTSIjXS6Uc=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCHFbq9sHhoLS7XFQ--.22249S4;
	Thu, 17 Jul 2025 16:13:59 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de
Cc: conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	hjc@rock-chips.com,
	mripard@kernel.org,
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
Subject: [PATCH v6 2/2] MAINTAINERS: Add entry for Innosilicon hdmi bridge library
Date: Thu, 17 Jul 2025 16:13:37 +0800
Message-ID: <20250717081344.1355613-3-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717081344.1355613-1-andyshrk@163.com>
References: <20250717081344.1355613-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHFbq9sHhoLS7XFQ--.22249S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy8CryxZF1DZryfKr43trb_yoWfCrg_GF
	1xA3y8Zr4UKFWjy397Ca1fX39Ikay8JFyfXFs5tws7tas8Aryqqw1vgryIgw15CF1rGa9r
	Zay5Xa4akry3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnkWrtUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEhqNXmh4qEf5MQAAss

From: Andy Yan <andy.yan@rock-chips.com>

Add entry for Innosilicon hdmi bridge library

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

(no changes since v5)

Changes in v5:
- First included in this version

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d97e091b1742f..f944acf7923a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11945,6 +11945,14 @@ M:	Samuel Holland <samuel@sholland.org>
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


