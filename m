Return-Path: <linux-kernel+bounces-797885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A8FB416B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEBB7C0CC7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05442DA779;
	Wed,  3 Sep 2025 07:34:21 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024EF2D6E63;
	Wed,  3 Sep 2025 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884861; cv=none; b=nJE9SiHWvVGdpXQ8EMnehty2EV47CTnbLPzCTuVJjCgmyn6POZPbhx7YoFnZh8WswLb1kxyLd1uwKK0l6G8cBv2GJighmXje7mZib3Hr9S8sMvzFrK+GRrrcw8y5PafUQgNGX/SXt+EDp8oCW2bWT/ejfp53728NnGv0Q37be2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884861; c=relaxed/simple;
	bh=EISrl3sgWFaiw0aaV654CkdwhXJy6T2edHGYNz1nbUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=se54eVWiSGVirlLCzsyuMJxbCSSDExbJtf0V3anXFJGne3vMPN3ag/VjukOhvbkABL2pXHl/W9amZBOvVONjNe4hGLxCqy02rYwP78WmNHppi+5pJhh02t0p4i+WBxi2zUOR/nQHOtoZNTNAUR9PBJ154iycy8zb2finPUqkTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee768b7eebb702-807b9;
	Wed, 03 Sep 2025 15:31:08 +0800 (CST)
X-RM-TRANSID:2ee768b7eebb702-807b9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181454368174 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee168b7eeb90cf-63bd3;
	Wed, 03 Sep 2025 15:31:08 +0800 (CST)
X-RM-TRANSID:2ee168b7eeb90cf-63bd3
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: hannes@cmpxchg.org
Cc: mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] samples/cgroup: rm unused MEMCG_EVENTS macro
Date: Wed,  3 Sep 2025 15:30:59 +0800
Message-ID: <20250903073100.2477-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

MEMCG_EVENTS is never referenced in the code. Just remove it.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 samples/cgroup/memcg_event_listener.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/samples/cgroup/memcg_event_listener.c b/samples/cgroup/memcg_event_listener.c
index a1667fe2489a..41425edbd88a 100644
--- a/samples/cgroup/memcg_event_listener.c
+++ b/samples/cgroup/memcg_event_listener.c
@@ -18,8 +18,6 @@
 #include <sys/inotify.h>
 #include <unistd.h>
 
-#define MEMCG_EVENTS "memory.events"
-
 /* Size of buffer to use when reading inotify events */
 #define INOTIFY_BUFFER_SIZE 8192
 
-- 
2.33.0




