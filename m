Return-Path: <linux-kernel+bounces-865003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06132BFC038
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2830F1882BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010E347BA7;
	Wed, 22 Oct 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tg9PPcu0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qWuHmSZM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160B346E7B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137726; cv=none; b=Kqewzliy9YmefQFL2VQgH4OfnDEHUmFP2iqPLbKJZbVVUHXiYhQ2IaXdiwGLXWIcw/3jpSSJyVBZxaOhM3ZAUZyDmcoVG11eg1k4nrbV4zS7U9xetjo6kBxqSLzxpNZUJV469vqQiYmGp3qUBs9DRYR+F1821Hipz3JM7vCCXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137726; c=relaxed/simple;
	bh=tAS/jFdleKntCdfZ4fDFe0Ru8lUvDl2di+Bd5ceHE8Q=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=g+USmsjH/gz/d4DuHhOqThAQOjmH4cahqgBnRq54A+wSb0Of/8R1twRl6YPQZbEpm3JBjkX9TIOjYguNXiIvMc/NiD4taC4Mc4e8zZf6FnCUE/0WjZKihF0aM1VGDiR0etGKsatESU/jbLx7T+EvglvDtiyXo3B2kVyPXKw0hU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tg9PPcu0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qWuHmSZM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022110555.585961779@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=t2DhrCJI2qM1WXFN4uYMENxUwcTd/AJvvwXrw8JDNI8=;
	b=Tg9PPcu0pnTUaU0VUkioWbMAKrqtpkHMNHalr39VdeHOBHM2Rd178oW1qdVutRXLxTp0bQ
	/aSzmtI+K8bdPMKSspjZN2JQVp/wo98zQ7QGBn8Z/JI2Q0vVD73Rk9otRQ5tsRftDpdKZD
	yUTn/Sf0ZE9mwaczY2hnCdcYH9ndAMcuec8FDRYyNSgmJWLcy6+NSCJBdpYhacXYkenhOt
	N6FMvTqO5PVq+fymZLD0DLpmCkBl0zyLir2K64C1Em6zCmabMTKSxznjyK5sy1g3BP+qI8
	bgassfejE8lSG4xaNJKgYqwdS+wPsTou9HV87Td9cgaB4Ms4vQKTEqz8bc/2AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=t2DhrCJI2qM1WXFN4uYMENxUwcTd/AJvvwXrw8JDNI8=;
	b=qWuHmSZMAwMHeWWpT/Qa5OIHMas2JlDRYtg16BVASpO7wymGdHzCWpBvvznc2dhJqLrbMN
	TchEiTwN2aGhhnBQ==
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
 Yury Norov <yury.norov@gmail.com>
Subject: [patch V2 03/20] sched/mmcid: Cacheline align MM CID storage
References: <20251022104005.907410538@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:55:23 +0200 (CEST)

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


