Return-Path: <linux-kernel+bounces-762604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79641B208DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BB02A0628
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5062BE63F;
	Mon, 11 Aug 2025 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fbqJEo2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ds6T5HWJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B63C38
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915800; cv=none; b=kx15XFexc/bgO637ZROE8T3UTbrzp9ticGOWXPVWkRf+2zJ+ZqG45nGm/ezXI8A/tY1R3YSvsTC1WGLerUfRdzYDR8sI7cPZMYjFo/zotwGrPAq4p6dqVn5LYw6hN0+jItpY/JfhTdKCCl0cUEdSY0NU9ugetzqmfNkVICNq1jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915800; c=relaxed/simple;
	bh=CNINg3c29ijOm+fbCFBkRG/KqA/A7WMCUN94UViE5ZU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SGsEvUs+qnV6Wd4mCHh/z5fEfJCa+HzOvvuEzOXLe/v3kE8sXZda/E3c0+HwFukDJ1mGVKQyl2BGIkpXGQToRhSKvro9422opSoxui2FLtmGtqnL/rNgvnPbxcIrGTy8TCpOQy7d6WN27Y3wOuO7W3GLeSH4mXH6s4YrCK7UDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fbqJEo2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ds6T5HWJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250811123609.603671567@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754915794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1hdExkcu4aa/6BKs9/Rjxr5zf9LnzdBTYi+X0crprfQ=;
	b=1fbqJEo2nYc++Nh+kvJrjSd2sd6tGlk0sgkhKiIscwaKLTEQe+tLSzcsD0ts8X61Ua0aA2
	v12tRo3lDg5If9VMY0AQHUh9hNWumiiRlUQgyBDq8FwfoqY3nSvVVz7AJcQUTFIhrvYOSW
	GLfJgtSCxzagp9v00ARcR/JSnNL+7sET5wyTkNbQx7iJHoqYivwEg6QKSBZpDoowU9IsEC
	6HPwnwm7M06eVkSA8NJCTF7otvYCKboBhwvf1K9bOEHKUh/X13jUZ1ZnO+ODZnoxC9q0rZ
	ewL+nLmc4FgE8MU9qOkWuM1/aPt8fjGvjCUugeAXu6TKlmbVqGpkV6c1Cn51uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754915794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1hdExkcu4aa/6BKs9/Rjxr5zf9LnzdBTYi+X0crprfQ=;
	b=Ds6T5HWJfbnys/k72dv6Y8eBooW8/qSxAfwSVQPlSmRyoddhLIIKp8exOtX7u8q7eOmb+C
	SBV23yYzxMcAkxDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch V2 RESEND 3/6] perf/core: Split out VM accounting
References: <20250811123458.050061356@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Aug 2025 14:36:33 +0200 (CEST)

Similary to the mlock limit calculation the VM accounting is required for
both the ringbuffer and the AUX buffer allocations.

To prepare for splitting them out into seperate functions, move the
accounting into a helper function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

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




