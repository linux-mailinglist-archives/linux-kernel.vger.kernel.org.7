Return-Path: <linux-kernel+bounces-764585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B7BB224D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7E61A287B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61562ED156;
	Tue, 12 Aug 2025 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s2wpy52W"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196F2EBDC8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995575; cv=none; b=isGSALzIv5SchgzCQANkzfwxf3t6COuYURVofmMPaxEz2GtADs9XmHmlsi9Wu6RDpcsRCeuKl7c6o6DJWQ8ghCLH4TbOgnKly/Lzeb5rwD4dh4c1xOIaLP7wVWj5vDDX9JlXL9pceTZ2/ND1DhxP0iS8kTX7M9Ec3smlgJNeL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995575; c=relaxed/simple;
	bh=eRGEL7znStyvargRyOLTDHsdch5WLgEi3BY22hs1CZU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EKznou9lA9lhKp+HMwe/BmBCrKa3K8QcTQYEMITjS1OaIhmlLtwTw01kdlW3wLVdn0QAQoZoyLEy6nFO3IFTeTyxVXKsOSZBurMx4j1+UISFMzF4lyJ9W/KbwHigcKSgDy6TWIhO4v2ZxDgxe97zeYlTydTPAl54LACwNEn3IP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s2wpy52W; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=jEGbx+FK1IDMeSzqEno3xQ+nwzX57brmTQ8dOvKmm0I=; b=s2wpy52WXBGKfcygA2ksOZYXl1
	ZtorkhYK5ka4rCvR8/Mi06Z8zrJNtUdqn87aWb9CEc1XdSAECW28ssDfvsmY7MdBil3ahViogQJI7
	VcNrIyZ176e8ahDv2qVeeQBABE46hv/IUpxoab9sSC8aNtFUWPXUfFZEDZl8t1+LVSH+owgC1YtJq
	H45znyIVj9pRDEcNWRm6HCbSSHqUHvAYXHHG4BMKz0/vJnQZTn5rO7knrTHfxhakpFhOpjnjN1vmf
	3E5KfCZkeUj/ZA1yKYnjpCHwqao9L9EZGU9HzrsqwK4wRgGc7TUzcR8YKsOXLJaMofwFG1IjbhM+n
	MWf0VzqQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmW9-0000000FQYf-3Rys;
	Tue, 12 Aug 2025 10:46:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 96729300578; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104018.660347811@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:01 +0200
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
Subject: [PATCH v3 03/15] perf: Split out VM accounting
References: <20250812103858.234850285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thomas Gleixner <tglx@linutronix.de>

Similary to the mlock limit calculation the VM accounting is required for
both the ringbuffer and the AUX buffer allocations.

To prepare for splitting them out into seperate functions, move the
accounting into a helper function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lkml.kernel.org/r/20250811070620.527392167@linutronix.de
---
 kernel/events/core.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6962,10 +6962,17 @@ static bool perf_mmap_calc_limits(struct
 	return locked <= lock_limit || !perf_is_paranoid() || capable(CAP_IPC_LOCK);
 }
 
+static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, long extra)
+{
+	struct user_struct *user = current_user();
+
+	atomic_long_add(user_extra, &user->locked_vm);
+	atomic64_add(extra, &vma->vm_mm->pinned_vm);
+}
+
 static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct perf_event *event = file->private_data;
-	struct user_struct *user = current_user();
 	unsigned long vma_size, nr_pages;
 	long user_extra = 0, extra = 0;
 	struct mutex *aux_mutex = NULL;
@@ -7136,9 +7143,7 @@ static int perf_mmap(struct file *file,
 
 unlock:
 	if (!ret) {
-		atomic_long_add(user_extra, &user->locked_vm);
-		atomic64_add(extra, &vma->vm_mm->pinned_vm);
-
+		perf_mmap_account(vma, user_extra, extra);
 		atomic_inc(&event->mmap_count);
 	} else if (rb) {
 		/* AUX allocation failed */



