Return-Path: <linux-kernel+bounces-820426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AC9B7DAB0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400532A73C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C69D32D5C2;
	Wed, 17 Sep 2025 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SvG3QvK2"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E2343D92
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103549; cv=none; b=CLo6Oc5W5rp1zNS/icQWHsx6LDSnQ5LYdOYOvQnWmMS+zUaAybfVpvAAz8l9U4fMaNmLFUwJwKSjtz7jwjCtDOYaIXieZoC1xkBQqyXZxxcs2kxS4XXK2CMeBGt1yBJbsC1NZUt2e3he9Hz1vGFcIvOb1FBNHziN1ZL5Zyjw7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103549; c=relaxed/simple;
	bh=08dcM3t0K7njHeLwqWoyWzDhpVwYoxc0lkgT3Ub3rmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPqBrpJ6IXr++lHcytUtpsJNqnTeK74KaVJUKDvdvqMvResDGwwmguwdGv06ktAEijOgaB+e5ut12JhM1/o+mGyDJ3yL0FuyrwR58SQ+QU2aL4FqfF06lH8xmebnD6aACMlsQrD/TvGj3U1XpSZL0VXXWq5eyN5Mc3OepF3M6oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SvG3QvK2; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758103543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RTtNQO1U90KHrl0xw19CnYSeIKFOzZ2ON7jzsbKynBc=;
	b=SvG3QvK2Lc5But0wzvm8iL/Vc79/5g8v08vUBCDL8d0XbTZLt8uqynaNPzLcZR/i1Oewex
	mlu5NzCVpW+pFXJ3Wr1xH/FVdvyxcmWixCweiyYH/uiowzXUj5RskugxvoJWaZHQdsjrTb
	4F5ULSt//W7SZzrCIh8WSyuhnVjDJD4=
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
Subject: [PATCH] x86/fpu: Replace vmalloc + copy_from_user with vmemdup_user in xstateregs_set
Date: Wed, 17 Sep 2025 12:05:34 +0200
Message-ID: <20250917100536.57810-1-thorsten.blum@linux.dev>
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
2.51.0


