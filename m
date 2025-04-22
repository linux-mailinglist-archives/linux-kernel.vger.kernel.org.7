Return-Path: <linux-kernel+bounces-613294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27517A95AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 03:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21899189617A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 01:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83371917CD;
	Tue, 22 Apr 2025 01:52:05 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EA6FC645;
	Tue, 22 Apr 2025 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286725; cv=none; b=n8CQxVComo654F8fHuFPn5SkaR+zOBWzjfqQt6Zf4Vz2fwtLkb0oy23P++X0zKAOWDEZYdN95tvgyNqhh+Dv1Mpimn6k5woCWnmEVnLJyd+5yFOlJVDBMB2nsb5BONdDgPzaumPjxrLGp1g8Kr0OTsK3YLasdmkTh3ANvG7OHlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286725; c=relaxed/simple;
	bh=KkThogJ+xvK6ts7tnABOf/eyMBVU9iiJvxDuYDFFNV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=RwPXqPDKneLRJGVqWfUS9xtbNxR846H2m/rECQ1R/JUW61aea1kMOhMU4RKOcnupLypqrPYFecAWmkx4lOv5SmyqJ1PZU3lxYZCiALCJh5a8Ph44rhUoO8XWZySDQTlcIYTE8/EMkjsljBQ21u+Lwgf8BwTGH43Is4aFHTf0vaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id B84836018789F;
	Tue, 22 Apr 2025 09:51:57 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com
Cc: Su Hui <suhui@nfschina.com>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] rcuscale: using kcalloc() to relpace kmalloc()
Date: Tue, 22 Apr 2025 09:51:45 +0800
Message-Id: <20250422015144.2012708-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250421061508.718752-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's safer to using kcalloc() because it can prevent overflow
problem.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
v2: 
 - using kcalloc rather than kmalloc_array().
v1:
 - https://lore.kernel.org/all/20250421061508.718752-1-suhui@nfschina.com/

 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 0f3059b1b80d..b521d0455992 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -762,7 +762,7 @@ kfree_scale_thread(void *arg)
 		}
 
 		for (i = 0; i < kfree_alloc_num; i++) {
-			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
+			alloc_ptr = kcalloc(kfree_mult, sizeof(struct kfree_obj), GFP_KERNEL);
 			if (!alloc_ptr)
 				return -ENOMEM;
 
-- 
2.30.2


