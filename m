Return-Path: <linux-kernel+bounces-761913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C90EB1FFE1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6513B1B91
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E275029C32F;
	Mon, 11 Aug 2025 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2lr18vxh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lh7hasWX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD96813AC1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895997; cv=none; b=neTQlE4/b6A3Dt4NXoY6fwbeq9kBGVLEfFeQ8ucT5EMRw7nPDhujIh0EJ9SQE2HWfwTbAXoQd6BmkTKxDOL+m+aImXMDiY1qLxZ4cN3+sOC0q3AGUssXrLqY8E/gJ4Ryy7H5drFg+Ykgm+K2WDuJu7STBcg218nKnf/QceEC/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895997; c=relaxed/simple;
	bh=EGWwMBEULt6QUjiM5RZT8ITe4UEROROzzS6IIV5m4h8=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Wd2Cy2uoKlFN8fxyw4LOtsvnZz+saKVJd+tUIJOvgdA8QZkAFB7RPqs/hta20qSChDvEm3h3ttwuJwTuhmfQNO/Zsd0ThFJPCwZaDN3J6jeN5Aig1veI1nR0FKTbd1or2mEuff2HiR1x5UowOZsHbd+YkWxELkN/TXlUXHsLxsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2lr18vxh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lh7hasWX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250811065859.660930338@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754895993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=/Z2R8yfEZbsNe21gylpfd7k87iCAWP5GsOA5rJXXrws=;
	b=2lr18vxheeNjuAcUVigVv9/VX5zvnCvrMGN1bdPRQ0y3HOoF0Q05ztGmfnUMIj27XdiUjT
	cBu2DhNvK2V3/g7L9iFI9js0rsrcIM7vp+2PD9xtArJVbd05l9WwgWykRQ1q/UGkvF2P34
	xuNhvvHndCwy511WhCBFtNpDcaRXYAVTiL2H9+dJ8IlMGUlEdkknpKhm+CfzwGqu22Iop0
	JYUYbgZQwlNopnzA4w331CjbOIMZ+Re8ay8DCQvpwNBw6bu4K68Q3CbM9FY/vy7VtENRpW
	+GA8uV4BU8uOFzcdHBQybOcQAhHO/pXMnWGCtw2qa/DpfJX8TvBp0DgaJCO98w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754895993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=/Z2R8yfEZbsNe21gylpfd7k87iCAWP5GsOA5rJXXrws=;
	b=lh7hasWXaXu/1Kivw574YA6vqCyt4Vi42d2vPiKmFhvrj3v+AXCP6+7fs21vlakbp+D1j0
	v07PgDxXN0IjYwCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch V2 m@/6] perf: Convert mmap() related reference counts to
 refcount_t
Date: Mon, 11 Aug 2025 09:06:32 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is an update to V1 of this conversion series, which can be found here:

  https://lore.kernel.org/all/20250806195624.880096284@linutronix.de

The recently fixed reference count leaks could have been detected by using
refcount_t and refcount_t would have mitigated the potential overflow at
least.

It turned out that converting the code as is does not work as the
allocation code ends up doing a refcount_inc() for the first allocation,
which causes refcount_t sanity checks to emit a UAF warning.

The reason is that the code is sharing functionality at the wrong level and
ends up being overly complicated for no reason. That's what inevitable led
to the refcount leak problems.

Address this by splitting the ringbuffer and the AUX buffer mapping and
allocation parts out into seperate functions, which handle the reference
counts in a sane way.

That not only simplifies the code and makes it halfways comprehensible, but
also allows to convert the mmap() related reference counts to refcount_t.

It survives lightweight testing with perf and passes the perf/mmap
selftest.

Changes vs. V1:

  - Fix the invers condition in the temporary workaround for the AUX buffer
    split out - Lorenzo

  - Apply writable flags in the AUX buffer allocation - Lorenzo

  - Fix the bogus subject line of the AUX buffer allocation splitout

  - Add a comment about size matching

  - Rebased on v16.17-rc1

  - Picked up Reviewed tags as far as applicable

Delta patch below

The series applies on top of Linus tree and is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git perf/refcounts

Thanks,

	tglx
---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2f061d392cd9..d2de721a7614 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6987,6 +6987,7 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
        WARN_ON_ONCE(event->ctx->parent_ctx);
 
        if (rb) {
+               /* Must have the same size */
                if (data_page_nr(rb) != nr_pages)
                        return -EINVAL;
 
@@ -7084,6 +7085,9 @@ static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
                return -EPERM;
        }
 
+       if (vma->vm_flags & VM_WRITE)
+               rb_flags |= RING_BUFFER_WRITABLE;
+
        ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
                           event->attr.aux_watermark, rb_flags);
        if (ret) {

---
 include/linux/perf_event.h  |    2 
 kernel/events/core.c        |  365 ++++++++++++++++++++++----------------------
 kernel/events/internal.h    |    4 
 kernel/events/ring_buffer.c |    2 
 4 files changed, 189 insertions(+), 184 deletions(-)

