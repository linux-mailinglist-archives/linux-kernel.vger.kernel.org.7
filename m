Return-Path: <linux-kernel+bounces-758293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B96B1CD4B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819CF3B9C21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3512C08BE;
	Wed,  6 Aug 2025 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lUrzqdhv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ygD5uaA7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6D321ABD5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511182; cv=none; b=Vt4B2NdmlnxpMnZzFSDiCXxuJbOpTLGAQkxdNkYj9Y8DD+VI7NSay9PBJXyoGe0Iz+A/7a5MhKNYI19TdnxWng3VrXMifEB4nyaV7gOhQdZcsbcVUijbwafEtfMHnGevxU6qwe5gBHZpmB8KF5gbHvMfd7m9F6GfdTlmdBODj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511182; c=relaxed/simple;
	bh=Nc2kKlgpRkhpPpvOyx8gG4nYfydMc4CeOuhggFgi5JM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=gRsdw+NdmkWqkQmWoYd9R5JfWIWIkm/eSix3a9SYJzll5Vtl+VikBnMRaEu+miJmHku413x4I/I/1y29Z5gPOjxbs1mzCBkjrTRnFB8tpqRP058mfRTOJCuZPVMHbp0wLrd3rA0BPNJQeKxY/n243c0IGjHPtck0Can9PyaNBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lUrzqdhv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ygD5uaA7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250806200617.386748791@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754511178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=u9lmEu5NM3cZYehFdtl8Oe0xuOKsLEY0QXX8YtLCDZs=;
	b=lUrzqdhvW1zZxOSlghhPU4xXSDUmLre8fJnifoiR+YztFeZmWmMigOU1HezWcNOdwfmUG/
	+dH/+dOq51w6Y3HpMyE1vr/DOMjVZspVRsOxbWSfrs+G0GshG2TLm4B9Sr36rIcWtjuyqB
	IpPNpLlJ4b58fNOIui4tmbSe5Lzyc4lzS1y2BKv1vOt91WWpXtuDk9rN24SHiPFoDxfeqR
	p8md3Ra5dMvfnIslJJEw7vYl2V5QQMdzBHHDhwLMFVS1fU4danIVGtF8gLCInyM42wTfSe
	NA2Z1oEBJ6b5b7jTU+l7V71uqcHA+aP+RBsd/id/TiKY6iAKrSnKTwz6lq9TQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754511178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=u9lmEu5NM3cZYehFdtl8Oe0xuOKsLEY0QXX8YtLCDZs=;
	b=ygD5uaA7tI08yA3vL2ssM1J+hZ/5JP1GbDWkRKYN4VrswB7top/1Y994Dp0rCWDohiBMS/
	LNnYVk8zfUtz8/Dw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch 3/6] perf/core: Split out VM accounting
References: <20250806195624.880096284@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed,  6 Aug 2025 22:12:57 +0200 (CEST)

Similary to the mlock limit calculation the VM accounting is required for
both the ringbuffer and the AUX buffer allocations.

To prepare for splitting them out into seperate functions, move the
accounting into a helper function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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


