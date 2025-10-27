Return-Path: <linux-kernel+bounces-871109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3713C0C75D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 604834F2675
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784F8312837;
	Mon, 27 Oct 2025 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xjQO/N/k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tpJcTG+I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D40F2E6CDA
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554707; cv=none; b=AE0vMF5V5vZqc8Nx8jdukYBMBWSzSez1j5GGtDBdfPsZZC/j5UczJwPs4Y04EQN2Cnuzmx3iM3f8rOyPP2l0WiPw68UYu9GBFtpKVULZr0pUHCTqrtrlZhkHKwL+WLyu59mtJi5NKkh4VxzAmHsktL+xh3SLOsTzw53IQISgjnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554707; c=relaxed/simple;
	bh=wxY4ImD5W6x3C9tGA0rcVshMwz4u/5PbLiTCRuNHt8k=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=IZEco99CiRdbZvQ9XKNdOt20X/WnShbfbD7xOQs1SUCbPsqPVFkUVQL7Mdpe33/UPR3zcCtIu5Z/3eAInq1E1j0GrOdUledVtcGUKYC3fGc0S/GemBPOozdQNiMVFfAeE263OyoFHVYruFedsezpxgz+6Akt/1EqDDUSS4WE4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xjQO/N/k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tpJcTG+I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084307.272660745@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YhF9cftFkrvHXR70/3Ri3JrRmZx0vcwHRd7bammTRVs=;
	b=xjQO/N/kvwikHCtoiAKLezYK//vEdAVhm9fVII8JXIIhzYBWQCbpr3zoESWcvI8mo6bbCd
	CTrMcV1egUd+FfMHPvw/x9lEkimn7uVtLXswi350c3ZaeUJY3Bd8Yk67pNGD7a/33CWopj
	SSTSibefdO4xSfYF93cYHnbz0ks1WtSPnAyfxVcVfeYmotOVICNHYt5EmTxN8SQ+YXFt9C
	EBEjXgnSF4/uCxY98MjHH5hozNsxa2twzqxYe4t8kn+64WmBXveCfkipzskqVTnGnpNnwa
	dDJuAcYfQMUMKqXChvovGiI8Jot3V7LdDmtE+s4EwBM9yQe4NAvR8MLhOd8zIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YhF9cftFkrvHXR70/3Ri3JrRmZx0vcwHRd7bammTRVs=;
	b=tpJcTG+IU+ZiJu8llUwQtBh07cIEY2jrda3VNZcIX6Of+VVrg3lf/TWZhREs17CePuXZa6
	1weFkjTCMkNM10AQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V6 21/31] rseq: Make exit debugging static branch based
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:45:02 +0100 (CET)

Disconnect it from the config switch and use the static debug branch. This
is a temporary measure for validating the rework. At the end this check
needs to be hidden behind lockdep as it has nothing to do with the other
debug infrastructure, which mainly aids user space debugging by enabling a
zoo of checks which terminate misbehaving tasks instead of letting them
keep the hard to diagnose pieces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/rseq_entry.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -285,7 +285,7 @@ static __always_inline void rseq_exit_to
 
 	rseq_stat_inc(rseq_stats.exit);
 
-	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
+	if (static_branch_unlikely(&rseq_debug_enabled))
 		WARN_ON_ONCE(ev->sched_switch);
 
 	/*


