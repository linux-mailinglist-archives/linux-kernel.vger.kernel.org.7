Return-Path: <linux-kernel+bounces-761331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C11EDB1F882
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9991189A8BF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 05:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F320A5F5;
	Sun, 10 Aug 2025 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LlMZFI0Z"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7280F204588
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805144; cv=none; b=FbYhzLrP3H17u/A0BBMysClPDYwLLrKSKO1WP5xruyk/k+GyrfdwdzDapt1c3BWYG1pfsB4EQGa2BmLasfUxC1QVxUxdIRSsPwLkzpHwlzAPDLVthle/m0GLrk97hcpvdVS7A0OAQp1dj18S1YgvuNcC/qntqyxImtGcAHSHScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805144; c=relaxed/simple;
	bh=YO+G15ePEO8pdM1lEQrx+0lg1jAdwwvHsxC4yMKArus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c0SG64mnvluUlXDu8K9oMPz/VAaVBbyC4PF6VNib/POhXqzpvx2RAbPTyZOwi3tysAk2dDVVXiAOzIxnptlz67j/amrJspPKMAo06lCEECV5fvA3LAeEa6n+6TA6yoi8R36qXYgIkHFZDzYLUTQvwMYIC+ElRFR9104n/p23rv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LlMZFI0Z; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uC/Em+drc44+RiAYfSg4CRc+O+H2NViY9r1XJ+GqBZE=;
	b=LlMZFI0ZvE6sSNtQjC92itwyk9TD/Qv+YhRp0iYn93pIZMnEz3cyTjWAOJfSLXpuNl3ENE
	eL5rbJSbMstBqdsrAU3hNNwW2n2AjfOs2GzMHUznFOB0vwdFBFZ44Hue9eFTT7zaWfIuHJ
	rarJrIoIz/eFGCGhL7mywg7D6rRtzDo=
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
Subject: [PATCH v2 07/10] um: Remove unused ipi_pipe field from cpuinfo_um
Date: Sun, 10 Aug 2025 13:51:33 +0800
Message-Id: <20250810055136.897712-8-tiwei.bie@linux.dev>
In-Reply-To: <20250810055136.897712-1-tiwei.bie@linux.dev>
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tiwei Bie <tiwei.btw@antgroup.com>

It's no longer used after the removal of the SMP implementation in
TT mode by commit 28fa468f5316 ("um: Remove broken SMP support").

While at it, remove the outdated comment.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/processor-generic.h | 1 -
 arch/um/kernel/um_arch.c                | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 236fdfd7cdbe..7854d51b6639 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -71,7 +71,6 @@ extern void start_thread(struct pt_regs *regs, unsigned long entry,
 
 struct cpuinfo_um {
 	unsigned long loops_per_jiffy;
-	int ipi_pipe[2];
 	int cache_alignment;
 	union {
 		__u32		x86_capability[NCAPINTS + NBUGINTS];
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 2f5ee045bc7a..e46718b3c711 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -54,12 +54,9 @@ static void __init add_arg(char *arg)
 
 /*
  * These fields are initialized at boot time and not changed.
- * XXX This structure is used only in the non-SMP case.  Maybe this
- * should be moved to smp.c.
  */
 struct cpuinfo_um boot_cpu_data = {
 	.loops_per_jiffy	= 0,
-	.ipi_pipe		= { -1, -1 },
 	.cache_alignment	= L1_CACHE_BYTES,
 	.x86_capability		= { 0 }
 };
-- 
2.34.1


