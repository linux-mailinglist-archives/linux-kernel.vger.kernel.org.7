Return-Path: <linux-kernel+bounces-762608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8717B208E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2699A3B3A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4F2DA74C;
	Mon, 11 Aug 2025 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zWWNY7xR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gHemz0Qp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAEE2D77FE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915806; cv=none; b=JRz6vfnA7Jsh1kXeMtDYL6A9WmUAZDL2uz8iCU3TZolp1N63lSew8/y0eTSXjL3CEu+Qc6PIg6fxWrMCzWbtfAuJCYbJJWMvYI3vcCNYKBezKjEYMaJreBS3CTmL46zQ5817BKm0MF3bxN0utmywaZWBZ7/VoUBc4wR65NDVDD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915806; c=relaxed/simple;
	bh=3AcxPLZQplgJgziQ02GBRX2p6HLFSjyB/D9Xr8mTWOE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bcuAqDvLE9QpY/6d22ebxVmcerC9FrOMit0eSzCpLHWXK6RZkTs5GEIsseNRa5hRMlr5VatCgej89k3jHuy2HDkbCswLk1s0w4xgfrxsdmGUQ6fD84vV8tyKURDBbVNj9i3/BX8iUNlOS8obZ2aE2o5z73k3FUfmQcU8Huqj3mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zWWNY7xR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gHemz0Qp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250811123609.540223161@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754915803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=eKfJrRw0NuduFScoQsDr6Ib06o+Vf/h5Ce0scSwAW9I=;
	b=zWWNY7xRMdVb5jvlPkLbvt/eDc2sR/CxmbPzeryG0pKPsVm38kX/2Qo8iMYfbribpIuCNM
	cMot97qS+M06uiKZIunzKQnYn4rjmoCBFRgry5/VJKSlIcqKe8LsrxNQyeT0joVKr5Va4L
	qsq5/laz+bWXB6QTMpegAzkPt9F2dSDJwmZTmktMbMDT0OgKBXDem3PInRb3r0RV33jlnr
	JezsSyzSG1L4W2hrme9vNaGDJca1RXIGZ3+fw10Cf3C3JUJPcqgedOE8aeZQkb4HYp+pnB
	urYkdk0bXckNwF4pHZlnUcVif0Oe40WCBzzLinszmTXJvDFDeVpOLECl7Xmfvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754915803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=eKfJrRw0NuduFScoQsDr6Ib06o+Vf/h5Ce0scSwAW9I=;
	b=gHemz0QpG7ogq5LlSfsDlKuBufJ/m4NGNpKyrOamq8k4qSZOry3S7fXKbc6u0wiOuo7wuJ
	lPum3+IwnE/1BYDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch V2 RESEND 2/6] perf/core: Split out mlock limit handling
References: <20250811123458.050061356@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Aug 2025 14:36:30 +0200 (CEST)

To prepare for splitting the buffer allocation out into seperate functions
for the ring buffer and the AUX buffer, split out mlock limit handling into
a helper function, which can be called from both.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

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




