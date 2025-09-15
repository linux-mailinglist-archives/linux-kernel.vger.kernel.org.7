Return-Path: <linux-kernel+bounces-816334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8ECB5728A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E1017BF75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C773F2E54BB;
	Mon, 15 Sep 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J1Q0IV1n"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37911D63F7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923616; cv=none; b=NTHjVYWFqv77jIUCyqRd397anP0P2wERispS3bgHOKUHHEmDQKTFlJuUn2+3y6JWPqnKwoOOKJGHuIqKJ40YPZsgPiUkeemCUZs3lL9QV4b4riBy4DWoRaKz65py8ggeyIU0ZGl6eB5JzJhL6q/D0JFIqsMRSCcn3AYbaJOk4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923616; c=relaxed/simple;
	bh=fxTpMF3xr6Q1r364/amthVYUB47cyYDo/MKAQYsKaFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eqGvGNMiPlAYxDTg4B1CBE6YgSJgR0Mkf+At0E9/uSmJWf0RYCY/oMyowHgkJ9nXUA+wz0UFiny9EVYwcfykCMrfgx15rMh7dFHoogGPi5yqFCnyKBCSE1om15mrRMo+b3uZNqHbhU64TNxwB2ZYHBPT8PaItz3tRj3Hb4+r5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J1Q0IV1n; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757923609; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bH4bmRFC6mfdBg3cFxo4HyAhTqlu4zYCWpK8buVrQX8=;
	b=J1Q0IV1nbgfDwApFF3/wVZovfrqcaCtiurIPpV843lGruRCD5xSolg8ZuEN78+ZSARMnQYbJNxqqaSJzR4wG2dr3dGMK5JJdETPMKDNhJCT/zhwa4A0Q87a3TjdAssQgse0yiJWS8cvbJDvAKgdAavWH0OFVm43OCv1DspZHaNU=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WnzmTq6_1757923608 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 15 Sep 2025 16:06:49 +0800
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
Subject: [PATCH -next 1/2] drm/xe: Remove duplicated include in xe_pt.c
Date: Mon, 15 Sep 2025 16:06:46 +0800
Message-ID: <20250915080647.669569-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files xe_tlb_inval_job.h is included twice in xe_pt.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=24705
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/xe/xe_pt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 01eea8eb1779..3e33b10e7ba9 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -21,7 +21,6 @@
 #include "xe_sched_job.h"
 #include "xe_sync.h"
 #include "xe_svm.h"
-#include "xe_tlb_inval_job.h"
 #include "xe_trace.h"
 #include "xe_ttm_stolen_mgr.h"
 #include "xe_userptr.h"
-- 
2.43.7


