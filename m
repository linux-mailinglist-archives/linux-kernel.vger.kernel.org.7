Return-Path: <linux-kernel+bounces-816335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D437B57287
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87F13AACC1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455F22EA46F;
	Mon, 15 Sep 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FiDH9kw5"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D492EB5BA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923622; cv=none; b=kX6gtJiAKgy6/CO/OTz6lwWDo1SmF+cGKy42Xqrm7pGAiZkYiuoNMMp8fSHGVWmafQ6wmmRxM/gxP/46ykdiZUxijJz+VS+6u36mg0+mvw/JkOC6Z/elTpSTWday2VKRLupZUuMv+XRbPsCT58FrvXKVNelVh+6g1way3n1MaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923622; c=relaxed/simple;
	bh=WMg3J6+uob+ho+HeRPzHU/3qcOJSyZ3+tNsjirttqWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bF2+RCQkP3HRvkHSzw3/mfmq3UY2HZBSzC77PwpD2pakvJlZ/jz7Y/2e/ko6/HrqkFDlGCbYOVvLtBt6K1y+DucNnxbKWqIY7pmGxNGV9NajkqgWZbRUr370JXiifeGjKC6VXKqY83s+6ZMiIBWB2ADipu9iaqto8QXfcGJtfsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FiDH9kw5; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757923611; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yDRofLuwR36Gwj6fKDMsFxxdwxwoKd4LieQPKmSPy18=;
	b=FiDH9kw53qGunGqztfXKj4MBmrnncmh1s5UdmoSvUdprxAjuGcz52F7EIcNmKR0KWtAdtjUZ88FGjC2c16ecMyLk0z0sX0vegoz/xDu6wviYwp6npyQ5ELFpynd6OudFYJF/T4v4nxAy7S4FuhDDMerQQXyiADdDC1U4ZM+0+30=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WnzwkG1_1757923610 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 15 Sep 2025 16:06:50 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2] drm/xe: Remove duplicated include in xe_tlb_inval.c
Date: Mon, 15 Sep 2025 16:06:47 +0800
Message-ID: <20250915080647.669569-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20250915080647.669569-1-yang.lee@linux.alibaba.com>
References: <20250915080647.669569-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files xe_tlb_inval.h is included twice in xe_tlb_inval.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=24706
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/xe/xe_tlb_inval.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
index e6e97b5a7b5c..41e80d609815 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
@@ -17,7 +17,6 @@
 #include "xe_tlb_inval.h"
 #include "xe_mmio.h"
 #include "xe_pm.h"
-#include "xe_tlb_inval.h"
 #include "xe_trace.h"
 
 /**
-- 
2.43.7


