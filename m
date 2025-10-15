Return-Path: <linux-kernel+bounces-854969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A515BDFDCF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064171A22788
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A6333EB10;
	Wed, 15 Oct 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VVWBeUG2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kuaQLNSs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4DD33CE8B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549373; cv=none; b=uVd0Wp+41awHhnoTfeqjnv2S8xZeLhfejdZSqpMkpGkQMQ/fg+zibVU024+JoLGLa3Q8XbDJqkxbgtptK85kCYRsgk54GTjC7QR5uJWbPS+xrMSk8N9lmBNvjtt0U41F3klKEplST9fguAd8ZrV/6R3t1Myliyc/LCB/FcdWaDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549373; c=relaxed/simple;
	bh=WtdlZTEAm/qo378Vyp88v4Zz0OrT231u5G47EVKWV8U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KegCSCwMSC50Hgq8gHmWucGXcIrPGPu+mOd1PJI3So+f9KDx/y5fgoapuErPWYpheHFUq1erqmidzztimNs5vHfoOZj+RbYB2YonRcstS47mqww4Tv1CH78tjBZhmKwSwkMcJV+EFRDykX6RkDJw/H+Ve06fvQ31T+SkeX0MT8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VVWBeUG2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kuaQLNSs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015172834.504490216@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6NYtpKGSbQFI9f0vnFaHT+ApHPfnQIXwG205RTbsJ5g=;
	b=VVWBeUG29pdYL3NFpVUGD1jPXY+BN+qXf1j/1YaQIVGwvnhOaWxEG3/QCpB5kb545D/b2n
	2Nq4qRAse3nQQFbenxv7a2m8z/cXHeopt3ysKtVxJrYZAadfNIJJFbF8jty43nckjv3YS5
	h+ypW0PxnWT3KiM53vZ6yY/ECCZrgSBeHRqDpKZypx1b0alFlJsT5gcmqss7mfKflsg3sU
	2cbRjq1XdoXKLm3N9sws/2xPzj+FOetOK+/0WC5Tg/0xnEzOk8JdNKKqPgOARzHEIjlvxG
	uREOaSTQwNsyzRzsLeQZ4E0OGU0Y/ZMSFWX4KqlW1nb4WD+E8XwzocIwvkKNIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6NYtpKGSbQFI9f0vnFaHT+ApHPfnQIXwG205RTbsJ5g=;
	b=kuaQLNSs46QZF/FnCorNs9AdSn7rFfCija+QcOH2TVAHUFr3GydWBB4c9VDTv/upcgqupf
	o1xWN680CEZq7gCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>,
 TCMalloc Team <tcmalloc-eng@google.com>
Subject: [patch 03/19] sched/mmcid: Cacheline align MM CID storage
References: <20251015164952.694882104@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 19:29:29 +0200 (CEST)

Both the per CPU storage and the data in mm_struct are heavily used in
context switch. As they can end up next to other frequently modified data,
they are subject to false sharing.

Make them cache line aligned.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rseq_types.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -112,7 +112,7 @@ struct sched_mm_cid {
  */
 struct mm_cid_pcpu {
 	unsigned int	cid;
-};
+}____cacheline_aligned_in_smp;
 
 /**
  * struct mm_mm_cid - Storage for per MM CID data
@@ -126,7 +126,7 @@ struct mm_mm_cid {
 	struct mm_cid_pcpu	__percpu *pcpu;
 	unsigned int		nr_cpus_allowed;
 	raw_spinlock_t		lock;
-};
+}____cacheline_aligned_in_smp;
 #else /* CONFIG_SCHED_MM_CID */
 struct mm_cid { };
 struct sched_mm_cid { };


