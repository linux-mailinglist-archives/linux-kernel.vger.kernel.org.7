Return-Path: <linux-kernel+bounces-738541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85DAB0B9D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC833B9E43
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372581862BB;
	Mon, 21 Jul 2025 01:41:24 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470788460
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753062083; cv=none; b=k9qEtyy4e37LRFrl49lkpM8HR6mZxkqhd3HD+3mZFc7H1ITN4mxs47Pm6WHS6yb+2MgjATsFLKs2EZtIzHjhc0yeh09MDW+slj1Ha78deEp/8LpWD7mj0pSf3obf6MZe3QMZucvptgKSga2sPXsT1l89diUu8J8YBZ2qt5k10LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753062083; c=relaxed/simple;
	bh=gqZaiYwhwnUTOLilMn+ZD61sJ8dFCC6LNa18Nx1PEsA=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=B/913dzuxI61f5NPHT14P+NkiUAEHLLaLvvNxWqYMEphVAg/by/Kvl5yMR7KTm8ptLKzScoNkJeIecifxACV9Xc8k+ZN79GOIb/GWUbYjJnu/xmRNL3hgWE4c72oKa2ritrWu2gV+ANLtGSTexAS5u/Bvf7Qpe4rVuQCfJ1aFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bljm63dQdz6FyBs;
	Mon, 21 Jul 2025 09:41:10 +0800 (CST)
Received: from njy2app03.zte.com.cn ([10.40.13.14])
	by mse-fl2.zte.com.cn with SMTP id 56L1enVX004140;
	Mon, 21 Jul 2025 09:40:49 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njy2app01[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 21 Jul 2025 09:40:49 +0800 (CST)
Date: Mon, 21 Jul 2025 09:40:49 +0800 (CST)
X-Zmail-TransId: 2af9687d9aa1fffffffffcc-ad826
X-Mailer: Zmail v1.0
Message-ID: <20250721094049958ImB8XG_imntcPqpQn1KfG@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <yang.yang29@zte.com.cn>, <akpm@linux-foundation.org>,
        <xu.xin16@zte.com.cn>
Cc: <bbonev@devuan.org>, <linux-kernel@vger.kernel.org>,
        <bsingharora@gmail.com>, <wang.yaxin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4IG5leHRdIE1BSU5UQUlORVJTOiBhZGQgbWFpbnRhaW5lcnMgZm9yIGRlbGF5dG9w?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56L1enVX004140
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: jiang.kun2@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 21 Jul 2025 09:41:10 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 687D9AB6.001/4bljm63dQdz6FyBs

From: Wang Yaxin <wang.yaxin@zte.com.cn>

The delaytop tool supports showing system delays and task-level delays,
effectively identifying the top-n tasks with high latency in the system,
which is highly beneficial for improving system performance. Wang Yaxin
and her colleague Fan Yu focus on locating system delay issues. To promote
the thriving development of delaytop, we hope to serve as maintainers to
continuously improve it, aiming to provide a more effective solution for
system latency issues in the future.

Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d635369a4f6c..e6fec6b0055d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19524,6 +19524,16 @@ S:	Maintained
 F:	include/linux/delayacct.h
 F:	kernel/delayacct.c

+TASK DELAY MONITORING TOOLS
+M:	Andrew Morton <akpm@linux-foundation.org>
+M:	Wang Yaxin <wang.yaxin@zte.com.cn>
+M:	Fan Yu <fan.yu9@zte.com.cn>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/accounting/delay-accounting.rst
+F:	tools/accounting/delaytop.c
+F:	tools/accounting/getdelays.c
+
 PERFORMANCE EVENTS SUBSYSTEM
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
-- 
2.25.1

