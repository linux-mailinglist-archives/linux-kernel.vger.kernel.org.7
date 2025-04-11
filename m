Return-Path: <linux-kernel+bounces-600146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231B6A85C64
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 14:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE03B7B29FC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 11:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D007E221269;
	Fri, 11 Apr 2025 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cwaBQPxu"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AF2278E5E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744372858; cv=none; b=D/S8PTg/dFhqopgxbajal3t66ahLekCw7iEfco41I8QxtxoGDxTAnFbW7xmynNKLNjKthkFxxZdADGeotgEUeKefl/pWEZ7CwK46TVlNiI6UDYTzco1LLfDaTP7oBN2TPwHY5i0sZJy//MYGIwzZkfV1Ws1lZtLzCKySK9MbKXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744372858; c=relaxed/simple;
	bh=p+KBJg/q0VC4AxurC0CaLJgxb/Q+KI0fay4d3RSnrro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYbTJbfYUcTO1rEttnqn7P4+FqFmwtQdlDfqHoPYMkwBr4YXq+wP9BkF3yc0+CBWLhHGy8YERUpN8NUgz0TqQ9Pa9Ffd8+3Jue3mGGD+WzDJP2IRZ8PYY2+9xWH2yz+zLCIxtpiw4JNQUDoCsEKTnjL4+6NdMRQLHdFlLlgbny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cwaBQPxu; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Ai6KO
	rDYRhXJ9lvg8B6jho/hJgKPY3oes6sm6uHCIVQ=; b=cwaBQPxugXqPHMuN975Hd
	UFQNFOVGGuJZ/NgXaZ3/WIGz95Z4k5nKjTV5hGLeSjYUjHyPufr2Rwr44+3EQcEa
	NniugkIkdMqlMREKpKmfxsig58eLbcW48Mq6Mv3iSR+8k55tMWYKRAvHDyDWPJ0O
	zFbkzzGAhUciPngSeO79Vg=
Received: from ProDesk.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXnwMuBPlnWR0nAA--.27850S2;
	Fri, 11 Apr 2025 19:59:46 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: lumag@kernel.org
Cc: cristian.ciocaltea@collabora.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	andrzej.hajda@intel.com,
	dianders@chromium.org,
	jernej.skrabec@gmail.com,
	Laurent.pinchart@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	rfoss@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2] drm/bridge: dw-hdmi: Avoid including uapi headers
Date: Fri, 11 Apr 2025 19:59:37 +0800
Message-ID: <20250411115941.318558-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXnwMuBPlnWR0nAA--.27850S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr15ZFy8WF1rur1xZF48Xrb_yoWftwb_C3
	WSvrW5JrWUCr1qyF17ZrsxZ3sF9a1UuFWxWFn5tr9xAF4kZr4YgwnrZFyUJwn8uF15KFZr
	Wa45WFW2vrnxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1_Ma5UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkAosXmf5AzIMjwACsG

From: Andy Yan <andy.yan@rock-chips.com>

It is not recommended for drivers to include UAPI header
directly.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

---

Changes in v2:
- Collect R-b from Heiko.

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index b1cdf806b3c40..deaba3b6f9978 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -22,8 +22,8 @@
 
 #include <media/cec-notifier.h>
 
-#include <uapi/linux/media-bus-format.h>
-#include <uapi/linux/videodev2.h>
+#include <linux/media-bus-format.h>
+#include <linux/videodev2.h>
 
 #include <drm/bridge/dw_hdmi.h>
 #include <drm/display/drm_hdmi_helper.h>
-- 
2.43.0


