Return-Path: <linux-kernel+bounces-870714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C1AC0B85B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BC13B635B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7708D1EF363;
	Mon, 27 Oct 2025 00:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d4RhZ0g+"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E69313D8B1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761524319; cv=none; b=XUPV/PaV5Y9f/H/2/8yKw0xAhCCdTHrYDIR1t8X7WH5Ol/ZdtvDjrq/2jOSJ1xD5FRmyrkLgezFC2zDu1y7FL52UGHa0fmuhaD5f8fuBxnXCzUwLHKKCft/OT8RrYTCNjFOJHgo7nOjRZnzS2FmNXHORvTn7nXMrI45+YkezxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761524319; c=relaxed/simple;
	bh=GFZt+8mLxgQwtLF02GYQcib0/QKzquioMxG4/Vag5To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXEedEF8O2tESTyyP3yGXfuFll6Ptb0ZD4jqgCpJ3Pk2nkTlm9Ga1Q9cxpgxibbsE5rRTKpTLlLJLQ78NvTebxoSbKZMUmiNYCvD8cw01jIpzTbvw+1P+u6k+v7c4gey7EGVw7rQd2s77pVIy8eHiwiuE+uldKPKuPMoYRaDMxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d4RhZ0g+; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761524315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjFrwlF759x9QExSvPBA2TAaIUv0ml3JmoT2DaGEPdo=;
	b=d4RhZ0g+0hgDpoTkj5KARfRZ8GwC9ZHCDLUPcoTGJFnec/pe5+kdAyECOlFdqSV2NWE5hn
	bVBRqkXxkyGrHiCCXfO2nM5yqnLaLktAN8+avRk+O+9QeBEOh4UBndt259lQRt3lMfZscd
	4ozKS3wrPZAsspc0QNPyG32pcoyPd7I=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v4 1/8] um: Do not disable kmalloc in initial_thread_cb()
Date: Mon, 27 Oct 2025 08:18:08 +0800
Message-Id: <20251027001815.1666872-2-tiwei.bie@linux.dev>
In-Reply-To: <20251027001815.1666872-1-tiwei.bie@linux.dev>
References: <20251027001815.1666872-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tiwei Bie <tiwei.btw@antgroup.com>

Currently, initial_thread_cb() temporarily disables kmalloc when
it invokes the callback, allowing the callback to bypass kmalloc.
This is unnecessary for the current users of initial_thread_cb(),
and we should avoid memory allocations that are not under the
control of the UML kernel. Therefore, let's stop temporarily
disabling kmalloc in initial_thread_cb().

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/process.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 9c9c66dc45f0..757e21185a0e 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -185,11 +185,7 @@ int copy_thread(struct task_struct * p, const struct kernel_clone_args *args)
 
 void initial_thread_cb(void (*proc)(void *), void *arg)
 {
-	int save_kmalloc_ok = kmalloc_ok;
-
-	kmalloc_ok = 0;
 	initial_thread_cb_skas(proc, arg);
-	kmalloc_ok = save_kmalloc_ok;
 }
 
 int arch_dup_task_struct(struct task_struct *dst,
-- 
2.34.1


