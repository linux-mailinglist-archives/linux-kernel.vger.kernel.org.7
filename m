Return-Path: <linux-kernel+bounces-745208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E00EB116A1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293A65A44F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13143236A73;
	Fri, 25 Jul 2025 02:44:51 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C43A8F7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753411490; cv=none; b=uE3Z3O6DRYzikoWDRqzfY9tW9Khy8MigbfbZ8gJyQjjzB7E2hPM6TE+KbCJPS0m5/h9GUqeg7E3V7x128iDSOJxofxxOa3SnRDlFfZojRiBzt/+5mwSm3joZ0HNmTST/X+Jv8HrDjqAPEmhkJbPCdDguF7bP6f4uMdtXvqrb8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753411490; c=relaxed/simple;
	bh=fEqmD9G4PRRs8KOXdul3mT+1dRcEHO7xOeY0+oL+4OQ=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=Q5Ct9WhyTEoK/BmVporNfiLYoMoAcuvb17ogTER7o9Ef9XHyIyYVHpNHjj1Nrj6heQ2W8qEzKcxBcShiWMgPS3C3W2BGmeYhpWCoyHQs5jNIYAh1wjVztDyf/+PrCLkLkuNWSu92idALe8mubrPnqKkp2exUsExTgkvPs9OCgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bpBzT2rZZz8Xs6y;
	Fri, 25 Jul 2025 10:44:37 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 56P2iOXW045879;
	Fri, 25 Jul 2025 10:44:24 +0800 (+08)
	(envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 25 Jul 2025 10:44:25 +0800 (CST)
Date: Fri, 25 Jul 2025 10:44:25 +0800 (CST)
X-Zmail-TransId: 2afa6882ef89ffffffff99d-eb6b4
X-Mailer: Zmail v1.0
Message-ID: <20250725104425229ArF_W-F7CmscLJKs0yoiQ@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <paul.walmsley@sifive.com>
Cc: <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <spersvold@gmail.com>, <sudeep.holla@arm.com>, <mikisabate@gmail.com>,
        <robh@kernel.org>, <liu.xuemei1@zte.com.cn>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?wqBbUEFUQ0hdIHJpc2N2OiBjYWNoZWluZm86IGluaXQgY2FjaGUgbGV2ZWxzIHZpYSBmZXRjaF9jYWNoZV9pbmZvIHdoZW4KCiBTTVAgZGlzYWJsZWQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 56P2iOXW045879
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Fri, 25 Jul 2025 10:44:37 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6882EF95.000/4bpBzT2rZZz8Xs6y

From: Jessica Liu <liu.xuemei1@zte.com.cn>

As described in commit 1845d381f280 ("riscv: cacheinfo: Add back
init_cache_level() function"), when CONFIG_SMP is undefined, the cache
hierarchy detection needs to be performed through the init_cache_level(),
whereas when CONFIG_SMP is defined, this detection is handled during the
init_cpu_topology() process.

Furthermore, while commit 66381d36771e ("RISC-V: Select ACPI PPTT drivers")
enables cache information retrieval through the ACPI PPTT table, the
init_of_cache_level() called within init_cache_level() cannot support cache
hierarchy detection through ACPI PPTT. Therefore, when CONFIG_SMP is
undefined, we directly invoke the fetch_cache_info function to initialize
the cache levels.

Signed-off-by: Jessica Liu <liu.xuemei1@zte.com.cn>
---
 arch/riscv/kernel/cacheinfo.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 26b085dbdd07..f81ca963d177 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -73,7 +73,11 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,

 int init_cache_level(unsigned int cpu)
 {
-	return init_of_cache_level(cpu);
+#ifdef CONFIG_SMP
+	return 0;
+#endif
+
+	return fetch_cache_info(cpu);
 }

 int populate_cache_leaves(unsigned int cpu)
-- 
2.25.1

