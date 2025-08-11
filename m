Return-Path: <linux-kernel+bounces-761916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0817CB1FFE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA433A9A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9517A26E179;
	Mon, 11 Aug 2025 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YFmmDJL3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jj1khDgU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B90E2D94AB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754896004; cv=none; b=fGRRpOS2fNP/YgiejtyOR0auklHL324hHiNGfFB5jAH1xlfrP3Omzea7nitjgp+4DFbFLM3Q7hxhc0EVpI05UfwUFharyiPD9W7bK2WwwDYZHbGP/5EMFm4WZ/Y8up+WrXeUS/MEj6is6pTYPrt0I5EXO2aku9YwjYsVGr01jnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754896004; c=relaxed/simple;
	bh=CNINg3c29ijOm+fbCFBkRG/KqA/A7WMCUN94UViE5ZU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=AH8CxIELb49mE9XjcNn1YeNsyjquWlOVy0bnKL0k0wA2Bmep64603P8RvRTxFQjmmUWOedDKrqMdsQbzYA3vuvP3ucd10wKRyHeiawmOWeT+Ber8W17hJB9gF1hMUOalDTmOJxaPwfCeaa/svK2BWEJXPfKbEWZGs943U2d8M44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YFmmDJL3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jj1khDgU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250811070620.527392167@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754896000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1hdExkcu4aa/6BKs9/Rjxr5zf9LnzdBTYi+X0crprfQ=;
	b=YFmmDJL3Z8rX9jHpMurz3DtsKXbRgPg7K2aPbUj55y58cRabdlIjhRJrlhHD25w2ZTQ//Z
	x1DL703VWdIMxCLuPdqeRs/kI0453zdRwIVw08XaERYybMaS/feUrHSpJ9VyHq5b2C6JEX
	KlPLVVzzNWtzspgVoKf5i6ayfdMUqQpe48BG0gE6xTZIis/XvZT2qPb5hXt4oxQ3qqLVJv
	0wQ1+MSDAT0bqAZIwTDVn0HLiwsZ9WxV0z+l5j7QYNQ20q7HWUBMktyFDCN78NDw8T+Y0C
	GhAC1jBbeV5NiFTxFGXO9nvXPC+IjsbWRUOWqbc5hJpCsB4YcQhtZBHLqvBLEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754896000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1hdExkcu4aa/6BKs9/Rjxr5zf9LnzdBTYi+X0crprfQ=;
	b=Jj1khDgUN5PqVnhDK8fJNFRZ8PYbHgiNtAyRrL0RFnIkf+vqFfxQaeLCyt95dNGQTe9snZ
	FuVgLsYQO8X2+UDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch V2 m@/6] perf/core: Split out VM accounting
References: <20250811065859.660930338@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Aug 2025 09:06:39 +0200 (CEST)

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




