Return-Path: <linux-kernel+bounces-882578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E51DEC2ACDB
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0C204F37A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926DC2ED870;
	Mon,  3 Nov 2025 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lCnKP+uq"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A56D2ED87C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162674; cv=none; b=RkfaQPIgPq4jyVHSQk9OsdRtU1APZ8hp04vuh5ptQF4uJmt7AxhLYBQbOnPa7pdvFdW6y51Yz6GcTsjj8WYXYl1kxOx5CK4d25yFWneVD7YmxTVUfckSDj+zj1Squnv2iJcS3IQ7l35Q8318Onu7mZ4pI1+VbVrrSBa9GTMdMj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162674; c=relaxed/simple;
	bh=d7AJpNDK+zGWk/tW2/q+dSp4+6DKWIoXMzHbUc7Msk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7POyiWipUBhulL+2pWJtjVx/ggJFR89ihoYaee36YNMJnZKm3wD9pjADbl5OEup/KcuoHXkfNVztk89j+Pp/xETZAfAxgB93CcwbjQEWyh0tbedCqQURieYiXTdAosrhb0yGMF8YVpsjtl3ZaJU+8ku+BOhNS2EpC5QEiuTDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lCnKP+uq; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762162670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iwufg+Q99M7av1aeDiq92CAIAQYLr11Y8lBCgnCUUP8=;
	b=lCnKP+uq1lHTbsoF3FNyxHmMv8gg7NJMPZ4qZVwUlZr5cLl10EAyXLigNCPn3qTr5ibiRT
	HrJRNU1heA6JBtT8XcQLZlTlZOHVjzu2iudkbKfZ/5OUs/6dGHqMKtY8kfGDSDVhGhKgWa
	rRgT7eF+quw4P+FAK2+yDDPq0byeHCM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] x86/fpu: Replace vmalloc + copy_from_user with vmemdup_user in xstateregs_set
Date: Mon,  3 Nov 2025 10:37:19 +0100
Message-ID: <20251103093721.3142-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace vmalloc() followed by copy_from_user() with vmemdup_user() to
improve and simplify xstateregs_set(). Use kvfree() to free.

Return early if an error occurs and remove the obsolete 'out' label.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/kernel/fpu/regset.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 0986c2200adc..00cc009918e6 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -3,6 +3,7 @@
  * FPU register's regset abstraction, for ptrace, core dumps, etc.
  */
 #include <linux/sched/task_stack.h>
+#include <linux/string.h>
 #include <linux/vmalloc.h>
 
 #include <asm/fpu/api.h>
@@ -157,21 +158,15 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 		return -EFAULT;
 
 	if (!kbuf) {
-		tmpbuf = vmalloc(count);
-		if (!tmpbuf)
-			return -ENOMEM;
-
-		if (copy_from_user(tmpbuf, ubuf, count)) {
-			ret = -EFAULT;
-			goto out;
-		}
+		tmpbuf = vmemdup_user(ubuf, count);
+		if (IS_ERR(tmpbuf))
+			return PTR_ERR(tmpbuf);
 	}
 
 	fpu_force_restore(fpu);
 	ret = copy_uabi_from_kernel_to_xstate(fpu->fpstate, kbuf ?: tmpbuf, &target->thread.pkru);
 
-out:
-	vfree(tmpbuf);
+	kvfree(tmpbuf);
 	return ret;
 }
 
-- 
2.51.1


