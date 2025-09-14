Return-Path: <linux-kernel+bounces-815524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBEBB567B6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1422F18982ED
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 10:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E65242D78;
	Sun, 14 Sep 2025 10:17:43 +0000 (UTC)
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E004437A
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757845063; cv=none; b=kf7VT55UH3WAoJabobPXIPiCK/Iq6p0CmxW9l1IOgdaTeAh9J6fO7P8PjZDqWiv6BfqIZ2JcMvEM0VlrXmPUHesXnJbhLTrJ2fXeGbKPPuubHLo9k0VTkg2jtPUwtUC2s5pHdiraqh0bGB7A4F0rcjOv6NdaNqMP1inC4PaJAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757845063; c=relaxed/simple;
	bh=Kjyiu+C/pshv9Zc/PrD3pmROSJeIT65fDrhn4VwO2/U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qlqM77aV1Qex37EDjr77bEGl2GagQ318HG9S4z3PDvpZKViBzJTyt0W/FmbkXFouiP6QvtgFsTcb+oIG5niJRvzdV7a4KD2mN41A9PV4kgWSgIbv1Jgh1d33+YlbCxSJsbeObN3oifMD0ubrssZGgzJ8aVOqXCFMn284Zs1UtLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <lucas.demarchi@intel.com>, <thomas.hellstrom@linux.intel.com>,
	<rodrigo.vivi@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] drm/xe: Use ERR_CAST instead of ERR_PTR(PTR_ERR(...))
Date: Sun, 14 Sep 2025 18:16:30 +0800
Message-ID: <20250914101630.17719-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc2.internal.baidu.com (172.31.3.12) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

Use ERR_CAST inline function instead of ERR_PTR(PTR_ERR(...)).

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/gpu/drm/xe/xe_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index a7ff5975873f..5808f7870fc6 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -967,7 +967,7 @@ struct xe_svm_range *xe_svm_range_find_or_insert(struct xe_vm *vm, u64 addr,
 	r = drm_gpusvm_range_find_or_insert(&vm->svm.gpusvm, max(addr, xe_vma_start(vma)),
 					    xe_vma_start(vma), xe_vma_end(vma), ctx);
 	if (IS_ERR(r))
-		return ERR_PTR(PTR_ERR(r));
+		return ERR_CAST(r);
 
 	return to_xe_range(r);
 }
-- 
2.36.1


