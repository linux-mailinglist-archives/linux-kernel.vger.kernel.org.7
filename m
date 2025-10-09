Return-Path: <linux-kernel+bounces-847047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F096BC9BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5739420525
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DC11E260D;
	Thu,  9 Oct 2025 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr25ctU9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C01DE89A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023460; cv=none; b=BTVDHZGxqdaGfn5k0hWHD5MsLBgcU78ijcVpSg3gxloGNeZDFPbRhDiAFA5XimJq6Tlr7XHF8O3ZTSWOjsYRHHXcUVviM5PUnQB0Wn5xRYQH27hh3kbxNbLDM3vqpG12nq32Mx/57hCzwJVsAhMHEziMc7o9BjI9mLiUxuONfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023460; c=relaxed/simple;
	bh=CEtGqqcITVTrUmu5n1Px/b8IT2fO/W9sS2iAC9PxAX4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aN2DSYH+Deo74Yqs1wtddbjC3rfFyeDURc8Z2gtXXfR69KY+ZNx1ryHBqC0e3hHuN7VAcFcojpMVepyORBBOAwddTH2au0EYmc4QITTvZ8OrK14xfVh6xgFUW3Nj6N/d+p9aqGQIeKKmTE2qDeV+5qQYTitEE+4L8nYjKJFV7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr25ctU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2C9C4CEE7;
	Thu,  9 Oct 2025 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760023460;
	bh=CEtGqqcITVTrUmu5n1Px/b8IT2fO/W9sS2iAC9PxAX4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Nr25ctU9Wxd8Z9qTVYFelUJo2Hkw/fNmWZnfIw9jokhnD3bFYHQg/zgC5NBHXMu3J
	 7Y5hRxFQFM04ndSWj86W03eETYEQoWJCRIVNUSClh+jB+OpZGDtErHEa+QtVgnAOnF
	 ovWcGNBDXO2DChjYRAC/uMD5eeRFs/iCCCivbXbMLHA87bocdwqF+dPiwRIwf3ePYQ
	 qLVM5ZCL0kskZDfMu1DfTthw3XEzoSJqUrQCczyp0Xs0asEQeGCDlY50Sf9sjdWDeL
	 sagb06OLue4jRXxaf2bwnobtm6iLDKRC0j0DxDLWjTZQckeWk4xDMKmHywyfheOhU0
	 YyKH9Ct+DQ8mQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v6sVA-00000000BcV-34Cn;
	Thu, 09 Oct 2025 11:24:20 -0400
Message-ID: <20251009152420.583914074@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 09 Oct 2025 11:24:00 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thorsten Blum <thorsten.blum@linux.dev>
Subject: [for-linus][PATCH 1/5] tracing/osnoise: Replace kmalloc + copy_from_user with
 memdup_user_nul
References: <20251009152359.604267051@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thorsten Blum <thorsten.blum@linux.dev>

Replace kmalloc() followed by copy_from_user() with memdup_user_nul() to
simplify and improve osnoise_cpus_write(). Remove the manual
NUL-termination.

No functional changes intended.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20251001130907.364673-2-thorsten.blum@linux.dev
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index dc734867f0fc..26d0c99125f5 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -24,6 +24,7 @@
 #include <linux/sched/clock.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/sched.h>
+#include <linux/string.h>
 #include "trace.h"
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -2325,13 +2326,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	if (count < 1)
 		return 0;
 
-	buf = kmalloc(count + 1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (copy_from_user(buf, ubuf, count))
-		return -EFAULT;
-	buf[count] = '\0';
+	buf = memdup_user_nul(ubuf, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
-- 
2.51.0



