Return-Path: <linux-kernel+bounces-762609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B29F5B208E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6514B18A30A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8552DA779;
	Mon, 11 Aug 2025 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PCjArNnS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mtdhe/Lx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3892D780A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915806; cv=none; b=oBLh7BWIE7r6ZQbQ43lx/0j7bUyQmuwGZAC9YepkJs5nmiuHHolVQ5PDoAndUowDgGYZuooJKSsqg9Umo6MJgiIlTNxNTahQsJG5Tg1LdGF8uqGf89CbxhD0RIjFaTQ4yJORf6tDH+bmh05hujd+MY0PIDiZW7MAe5zWgq78BoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915806; c=relaxed/simple;
	bh=cXit19cF18OBnT8e8Ai2t+57L82G9Ne38u6yX/0bofE=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Wd4UiMcHUoQPz2QsMap4u+J6RKrpTI6ypwouxpQQwcr+cDxKXkPTphzx0xNiALmAKl5BjdMWOFcbRcLiPogVD+JfhUdzpD5D1LyD06U0kE+5Wek0pkufBu6ENUXxK2M/TY5M2hFPakZyKvr+LmrJbYJbYVlQqZTTScDF1bFZClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PCjArNnS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mtdhe/Lx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250811123458.050061356@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754915803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=93E0xTyW7mkL/9D7F4xMlVDx0vKd//W/H86fAJwEpYQ=;
	b=PCjArNnSYyMj5zbFBrhj+rmZbD6FK0dcrf+gFkR1w2mIW0PCeShDhVkqORUuzkjrXUdHlg
	h2RMj5q1HtwIHXGwkd1KxhUrsSZukEw3iUziyz0y4tihz0ZPoXKiC9j26TM/Ay5KS+04Kg
	b9i7Fzh2JcbX/O5Rb13RPCIHTbi8LmEEyrr8V84UqRnriefhxMdt8CqxdSAEEwMoSrH/ye
	ZU2TXzyHDZk5UmhA0i5eIiBZDKNE9eZgWds9QZk/H3aLoTxnbIWd7QUVpqZ8PuyuTZiVgB
	N/d0pKPxlYn44wrv5qfggftc28ELDp0SmqVtd4jLg6OuBfmwe0JjdMl0dOCBuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754915803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=93E0xTyW7mkL/9D7F4xMlVDx0vKd//W/H86fAJwEpYQ=;
	b=mtdhe/LxiWudAdO0IrvVfQatJNFslsgep0voZu8yXjEtnevTyt9MqvPH7OSnV9EkQZZ+PU
	sX/ljQ4wdbOTI3Ag==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch V2 RESEND 0/6] perf: Convert mmap() related reference counts
 to refcount_t
Date: Mon, 11 Aug 2025 14:36:26 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

[ Resend because I fat-fingered the template. Sorry for the noise ]

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




