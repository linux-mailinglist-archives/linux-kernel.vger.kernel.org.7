Return-Path: <linux-kernel+bounces-857414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116FABE6BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD973AD20C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E430FC09;
	Fri, 17 Oct 2025 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="aTCnUjXR"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF63346A8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683365; cv=none; b=hO/dNdRwUNgoa26MGL7eL+xsjSmTg9rm0DfRIl2W2qGZH1npO0dYs52ESjiLa2W9Jx0KCcMBYxQ22xEvWFtyw/KgdL4ANqNkk55Dd6iCchHIE/9v8yetFKOdqIlIig6aaq1x3KV3yaSfHUR+aVBZVJHgO727tqcUcoKu6dbgtYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683365; c=relaxed/simple;
	bh=xRtfAmX20aiX4beMCCu+r34Hspakpboq5kRwzWGF0/g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AQm+OaLssLktbGpKSMz/DAABlyHnH1N5abERSu0fqxkTkPQUw8UB/l9VcbUkb3KOnCLwHtQvUmdlA+c0AVa1FeTv3yvoHWYracu2DAXV7Y6uezCePvzC5ZGX8oPqq98l6A+31nC/uHVlt0ViV9B4gnv9Lncg/9WGovjNW3Zxp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=aTCnUjXR; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=cfCIjIN4H2yvka2
	0hn1Z3fG8ety6EzBPcK/+y13JGkI=; b=aTCnUjXRRs4PUdk3MC6U2lK3LNYIyT9
	KIhRvGCCSNZB2tAXQefZlHb65uGtGfnEA3rimq2oBC4VT8rwxrhavyvjdF1j89r6
	uqxrfycStQkie5wn7jzjPZ0JoIDpCPFAn11NGLWJL5EMx4euu5s03m/UxAS7xfNO
	4dM3Bwp/fnXU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnF8ky5fFo0JGVAA--.30843S2;
	Fri, 17 Oct 2025 14:41:54 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] sched: Fix code indentation at line 10371
Date: Fri, 17 Oct 2025 14:41:52 +0800
Message-Id: <20251017064152.48490-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDnF8ky5fFo0JGVAA--.30843S2
X-Coremail-Antispam: 1Uf129KBjvdXoW5KF4xtrWkWry8tw4DJry5Arb_yoWxWFX_uw
	1fCr18KrsYqw13Ar9xCayxXw1Fqa10qF95Cw4SkFWUA340y3yDGrZ8AF93urn8Wwn2vF97
	JanagFnrtrsxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRuXdjDUUUUU==
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiWAvpxWjx3iZu5QAAsV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix checkpatch.pl indentation warning by replacing spaces with tab.

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 198d2dd45..24fd78d42 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10368,7 +10368,7 @@ const u32 sched_prio_to_wmult[40] = {
 
 void call_trace_sched_update_nr_running(struct rq *rq, int count)
 {
-        trace_sched_update_nr_running_tp(rq, count);
+	trace_sched_update_nr_running_tp(rq, count);
 }
 
 #ifdef CONFIG_SCHED_MM_CID
-- 
2.17.1


