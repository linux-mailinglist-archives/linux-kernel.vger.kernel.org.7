Return-Path: <linux-kernel+bounces-764594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04429B224D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21D57AC156
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E10C2ED844;
	Tue, 12 Aug 2025 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mMMzi/Xn"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF12ECD30
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995578; cv=none; b=DlUdWZBc7TUbOb8muH1+9757l5Yqrq0lFt0+3KEQxqSsNefm/k14Ya42hBQR2W9N/HCwToZEJXOKhxr9OoUbtKDlGHEBHbfGwhpnaLxjCYpRs42wYC1DlGV4zy6bO0lfBTMDysiyTL7pbi/TYdBXikmGCFQe7wQWbwiQ/FgWqmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995578; c=relaxed/simple;
	bh=qPsyvgyVam1olZvZ1Um4MzvtbSbI8iOofWKD0HLFGao=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rwSrcOyIR2xTYP6Ls5uZykutKYurGh/uG9nV4PD9Y7xRQlt1v0vyKiAgx1sPk+WWMadH1hC3DQuLhqMjFxaGnVWdQynMZTTEchOHaGxrBkM7IU95NkxWZDt+0sgCqrE6QBIVun9mo5hDf2pGddIwN1Ff6dP3ArUjpECEQMsKaAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mMMzi/Xn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=ZY0s9fAhs5DDwQyDEeSs26F4GltZYgjOXs4uAdzONUA=; b=mMMzi/XnaLjETYpNeGG/KKAEUn
	HFA+fmO3VVBdchc/9gbEB6S2V90xYCjGmr0L+17dYL41yba4rO6zp7D0IRhrLB5gH78FORb2pJlDq
	FHrCkw7IqtU2GKtF7EX0SeJulC8bPe5jx2qNA4nwNVrlyANTcG72fVL+jsPrReBx5nTlJRrpEyICY
	hvZr8q0orSeR9j3yAiSPApGwtTrTeHggDiDFfKm7eXHQD58YqCtmAj8VzdnDR3U/Z5pDvjRMHSX7B
	O8Laf8/d46El77C0S0/qNRhuUU8Edl7+B4I2NToOKye4751L7RWNZK3s4GxrJAl6rcO8E9SOWsOnv
	WVPsSNfw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWA-0000000Fmjy-1lhz;
	Tue, 12 Aug 2025 10:46:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 927F230050D; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104018.541975109@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v3 02/15] perf: Split out mlock limit handling
References: <20250812103858.234850285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thomas Gleixner <tglx@linutronix.de>

To prepare for splitting the buffer allocation out into seperate functions
for the ring buffer and the AUX buffer, split out mlock limit handling into
a helper function, which can be called from both.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lkml.kernel.org/r/20250811070620.463634790@linutronix.de
---
 kernel/events/core.c |   77 +++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 39 deletions(-)

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
 
@@ -7063,38 +7093,7 @@ static int perf_mmap(struct file *file,
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



