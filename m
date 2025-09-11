Return-Path: <linux-kernel+bounces-811852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0F6B52EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61359483934
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168D5314B90;
	Thu, 11 Sep 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y6Y1WTGU"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBC7313543
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586693; cv=none; b=bFFUFzmTUJl+ysR9PW9KMNV/ic9Iqyskv0Tt0SbEBpRockWVVS+1sd53mndDODwVHe3BCklf7W3OIbjNNKU+bHupAyVz+/EdexBDIDk94fl3JKzxtV+tkqUoTpjXf/WknmsOLoeHWhqDdbIv+KBt+E9oiKMmJnv8zBmek6zh57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586693; c=relaxed/simple;
	bh=lfBUtU4iM2RJHdeJnReG8H2A3ekirusk3Dc18yqJUto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jiCMD99JfjXQZgHhxODqXet+vgTc+9DmJZkCgDeEJhB6qpRWqdmtKLSzAYww6V7z2glthSLPxK4UeUaIgod49NKWtDJJdXwPJ++vLcfdE1hnHaOYVCta43/lSE/4CvH/PBKiT99oECAufVllygJHHN/uNj7J+HoLcfi/b7oewhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y6Y1WTGU; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757586688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1HaKN9EHGGkH+qeMdMIV0aPN9YFfC1ADL32ArNEpz84=;
	b=Y6Y1WTGULyh17HWxZJwEz4PVT2yRYIy7Ieua9FbrjRBP2wKpPao3DBHnjcDvwgPBoM7meU
	WkQqfJw7U+rLOIUrseDY2E8mPv1vPob0gMeiP6mybGHQ3ko5u9mc3DG9Iy9CxYqKmc+Gmt
	6BBNHGeI5hv1bUfxr2Eho2ubGqvTDPo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] completion: Use designated initializers for struct completion
Date: Thu, 11 Sep 2025 12:30:03 +0200
Message-ID: <20250911103005.1341545-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Switch COMPLETION_INITIALIZER to the more modern and flexible designated
initializers. This improves readability and allows struct fields to be
reordered.  No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/completion.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index fb2915676574..36291cb3c0df 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -33,7 +33,7 @@ static inline void complete_acquire(struct completion *x) {}
 static inline void complete_release(struct completion *x) {}
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ .done = 0, .wait = __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
-- 
2.51.0


