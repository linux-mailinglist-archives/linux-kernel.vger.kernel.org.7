Return-Path: <linux-kernel+bounces-758292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E078CB1CD4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B6E18C1921
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2345C2BF3CF;
	Wed,  6 Aug 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zJcYxnG0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E+dj7hFD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636DC217704
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511180; cv=none; b=JX4r6RJid/BY071O1sAYR8yoL/6HhAT9NU2WUhnKQK3e0SNLIe1pQexT9r2Rx3HRoyfyISkRDI9PX+FR/+vSXNoLuR/K0brCWyumDReslF2sUdRF2rCXWD8H5zpxfMhDUTjIGMePr1t+5pueqlDGRbZeIzYY4TzcoWWhXY++6Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511180; c=relaxed/simple;
	bh=72vMnJvciZSPM/VhGoT+SeCzUW0TeuZSkTad6DQiHv0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=iBTrEbsptMipsWFdtLS6bbYztBDqtq66YOG46udiGlqBru0zA4Ind0/CxS52i3it78bSjXlUkK7MV6Ra+SSN6sUeMFHwB5t1gn2qTw/ldvQ7RQESAM8hdx/qfUruZR4XeonifrXjZ3/ky+rH1/SGg736BH2Q6DNemdX1eWPPb8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zJcYxnG0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E+dj7hFD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250806200617.323157553@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754511176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mpYOPyyu2yqbbjhSAYsp7OV9dua6EsvwR+28yq/NgKY=;
	b=zJcYxnG043EexAcCCW1s3hQHDqCUZLaMP74Tp7wL5C0WGczMLgm//qNQMwcuczBuKbcort
	gyCWVYuWCJ+QENouB7OKqQUsu7Gi1X/GMrBlTOcRWZuw5foywwmdEC90CkLax05xWfyw5y
	JKUgmnlgVsFQsFqG+M9+x/7HiBF+8eVkSa39sNGvht4V7QNikpiJL6CoSqcyRCFDTEvb1c
	3RWRu1abE/GSRHIRIgEESCM8KcZoRhjZN1WNFX01taqI7fSU+bs1A/wnkJqT/pqnb9FkLA
	dOVyBEmaBCyZQGXOitddQG60Vn1stgoUf6jmgGr5qhbnivmRh2bDpeKKG5c5cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754511176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mpYOPyyu2yqbbjhSAYsp7OV9dua6EsvwR+28yq/NgKY=;
	b=E+dj7hFDiNOWLiDFheUf87NFwW1qwLrhgcB5dGyV15Fh3INUgHuHWc6MI6qqHTM02RK+TY
	YbVXJjH89TC7h+AQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch 2/6] perf/core: Split out mlock limit handling
References: <20250806195624.880096284@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed,  6 Aug 2025 22:12:55 +0200 (CEST)

To prepare for splitting the buffer allocation out into seperate functions
for the ring buffer and the AUX buffer, split out mlock limit handling into
a helper function, which can be called from both.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/events/core.c |   75 +++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6927,17 +6927,49 @@ static int map_range(struct perf_buffer
 	return err;
 }
 
+static bool perf_mmap_calc_limits(struct vm_area_struct *vma, long *user_extra, long *extra)
+{
+	unsigned long user_locked, user_lock_limit, locked, lock_limit;
+	struct user_struct *user = current_user();
+
+	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
+	/* Increase the limit linearly with more CPUs */
+	user_lock_limit *= num_online_cpus();
+
+	user_locked = atomic_long_read(&user->locked_vm);
+
+	/*
+	 * sysctl_perf_event_mlock may have changed, so that
+	 *     user->locked_vm > user_lock_limit
+	 */
+	if (user_locked > user_lock_limit)
+		user_locked = user_lock_limit;
+	user_locked += *user_extra;
+
+	if (user_locked > user_lock_limit) {
+		/*
+		 * charge locked_vm until it hits user_lock_limit;
+		 * charge the rest from pinned_vm
+		 */
+		*extra = user_locked - user_lock_limit;
+		*user_extra -= *extra;
+	}
+
+	lock_limit = rlimit(RLIMIT_MEMLOCK);
+	lock_limit >>= PAGE_SHIFT;
+	locked = atomic64_read(&vma->vm_mm->pinned_vm) + *extra;
+
+	return locked <= lock_limit || !perf_is_paranoid() || capable(CAP_IPC_LOCK);
+}
+
 static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct perf_event *event = file->private_data;
-	unsigned long user_locked, user_lock_limit;
 	struct user_struct *user = current_user();
+	unsigned long vma_size, nr_pages;
+	long user_extra = 0, extra = 0;
 	struct mutex *aux_mutex = NULL;
 	struct perf_buffer *rb = NULL;
-	unsigned long locked, lock_limit;
-	unsigned long vma_size;
-	unsigned long nr_pages;
-	long user_extra = 0, extra = 0;
 	int ret, flags = 0;
 	mapped_f mapped;
 
@@ -7063,38 +7095,7 @@ static int perf_mmap(struct file *file,
 		}
 	}
 
-	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
-
-	/*
-	 * Increase the limit linearly with more CPUs:
-	 */
-	user_lock_limit *= num_online_cpus();
-
-	user_locked = atomic_long_read(&user->locked_vm);
-
-	/*
-	 * sysctl_perf_event_mlock may have changed, so that
-	 *     user->locked_vm > user_lock_limit
-	 */
-	if (user_locked > user_lock_limit)
-		user_locked = user_lock_limit;
-	user_locked += user_extra;
-
-	if (user_locked > user_lock_limit) {
-		/*
-		 * charge locked_vm until it hits user_lock_limit;
-		 * charge the rest from pinned_vm
-		 */
-		extra = user_locked - user_lock_limit;
-		user_extra -= extra;
-	}
-
-	lock_limit = rlimit(RLIMIT_MEMLOCK);
-	lock_limit >>= PAGE_SHIFT;
-	locked = atomic64_read(&vma->vm_mm->pinned_vm) + extra;
-
-	if ((locked > lock_limit) && perf_is_paranoid() &&
-		!capable(CAP_IPC_LOCK)) {
+	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
 		ret = -EPERM;
 		goto unlock;
 	}


