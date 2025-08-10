Return-Path: <linux-kernel+bounces-761325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE45B1F87D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D021E175ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 05:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7881EC018;
	Sun, 10 Aug 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NuvDoYpV"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E15374EA
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805127; cv=none; b=mGMqt4gDvOlqg/O1CLSbAwKe5tzWUHgO1xwcL/ajloYI4LcM6MA/k/2ClfKofZnfC2moqVBNfjs907NXXeosWPMPBN9amlvpwODZHEG1oC9OlukLw8R4KFyGrBK5V5SJAyzkN0SkyT6K1urcD3Xl6zN/X2kcnASbr36xbEcl53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805127; c=relaxed/simple;
	bh=wJ182Qw1xd8ZswC+N4pXiVS6SptAukiW65zImMaYIJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lMQ/3EkConm1bUt6LyIk38TupyPwH2TJPLM5vWaxk9X2VavA2fHfCRKHPc6dhxmIsh89cIwZMNO0hrkBitjHO53SrPQJhOHrEc4fI/WD1bdXw5/y2Vwl5+VrPqN+BM5MK1Domlw/xAiBtMmwSaoSIR5ew6YpsUqFpAa8U7gppRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NuvDoYpV; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLSAZKc65C9rkSXpEwQXimN17KS5t738kD/ThmzTdvw=;
	b=NuvDoYpVC6GiDVJH2FqPfYWx3LWJQCHjcjBKhZIRwf6v6xEwfN7JDyYVA0IUEC3mNtFCE5
	siSXP95bweGMREdGX3FduJTx+dyJzaRJ++unYefCSFmslFTTkcU9SrsXVoewchqNUALOLy
	f4eo3zPBNaDB6vBDJfsJ4H/u8Tt1u64=
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
Subject: [PATCH v2 01/10] um: Stop tracking virtual CPUs via mm_cpumask()
Date: Sun, 10 Aug 2025 13:51:27 +0800
Message-Id: <20250810055136.897712-2-tiwei.bie@linux.dev>
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

In UML, each user address space is represented as a separate stub
process on the host. Therefore, user address spaces do not require
TLB management on UML virtual CPUs, and it's unnecessary to track
which virtual CPUs they have executed on.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/mmu_context.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 0bbb24868557..c727e56ba116 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -13,20 +13,9 @@
 #include <asm/mm_hooks.h>
 #include <asm/mmu.h>
 
-#define activate_mm activate_mm
-static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
-{
-}
-
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
 			     struct task_struct *tsk)
 {
-	unsigned cpu = smp_processor_id();
-
-	if (prev != next) {
-		cpumask_clear_cpu(cpu, mm_cpumask(prev));
-		cpumask_set_cpu(cpu, mm_cpumask(next));
-	}
 }
 
 #define init_new_context init_new_context
-- 
2.34.1


