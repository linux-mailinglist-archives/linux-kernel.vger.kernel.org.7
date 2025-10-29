Return-Path: <linux-kernel+bounces-876110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD38C1AFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A851640A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438BD3271E3;
	Wed, 29 Oct 2025 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UnMPGlM+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CvwqBYPj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253033B6D2
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743343; cv=none; b=rvB1v+QdIilHKlljooTEENz0xFgB6IadcOyEKj6xHJYRsAqE/1hLHqusCK0AgTAcUGYOp4FQaF8auReRKuXwDVQt9caotrDRvI1ev4B4AlpvyjQYDBsRW0MaQCvQhAATv4dHbTi3Qu8RxTT2QcYB7lJCzAWZIritRQlAlJCEWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743343; c=relaxed/simple;
	bh=tAS/jFdleKntCdfZ4fDFe0Ru8lUvDl2di+Bd5ceHE8Q=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rYcD6yXgYlYq/QTzR3U7Niggatuw1FokmWOKW7Ea7CHLzEIho7HmFCeXQ5P3FgNpx48cRGHnA8QySSFrqtl/j00IQdoc6IVmDu8+3eYkqFnuVWSOrSEq10tV8YCNqvndp7tSNd1f5l275XhaXbDqzn7nJ8D+5tfQeswBFN8UgK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UnMPGlM+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CvwqBYPj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029124515.466070081@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761743340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=t2DhrCJI2qM1WXFN4uYMENxUwcTd/AJvvwXrw8JDNI8=;
	b=UnMPGlM++2VCmdclU/azssFzSUV/oBtT8KpdqavUDfKVEYg9k1muOPVfGvoQipMDpCa4Gz
	OlVjaC88/j++B3aqsNOvluiDAa2EFtTamLHzqBof/Zg0PzLdFsxzeP+9TSIpi2YpRBHsjG
	D6ma1XNA9MQbI6fAuUnrLfGJ/5NBTPTf1iZWbYXKa3UOVhow9VwFiRzu48XEFDXQrvwWQl
	Ziz05MW84hPKbG8ANlXtkhfMuTUdySDqKtA1cTEupTLPZqHs1XyBJi5Xchz3Z1VQ7VLwou
	G9VhmQ20diMLpKeiWnGohGGBvsHG0mvonpWAnie/aQ72Dsy9KMfU9Y8KmHtprw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761743340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=t2DhrCJI2qM1WXFN4uYMENxUwcTd/AJvvwXrw8JDNI8=;
	b=CvwqBYPjkoWDbN0syHAxSgcHD3/tiuXcSlcsZrrYaqsuspjVt7+k4AxJhNv1040NQiVy1H
	DTphCy+60uXEuwBw==
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
 Yury Norov <yury.norov@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [patch V3 03/20] sched/mmcid: Cacheline align MM CID storage
References: <20251029123717.886619142@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:08:59 +0100 (CET)

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
 struct mm_mm_cid { };
 struct sched_mm_cid { };


