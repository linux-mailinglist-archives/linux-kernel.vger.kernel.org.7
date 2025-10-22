Return-Path: <linux-kernel+bounces-864986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDC5BFBFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32198341051
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C9034C822;
	Wed, 22 Oct 2025 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TDemvaex";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GibMdYx4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E31348460
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137554; cv=none; b=XLirdEtaiZ+mxiUT0gKs80ixiCUd/2BbZ6wDH4zL09ZRO4RJdttnB05YcPCfszxP3c5aiLz/HLICH+6sti60Ho9MhnyQtSYXSY1wWdop8hXeDleMT0oYnE1gciXSWTVus6qbkij1YvDa4m3uHgGIleP1GF2o9FgRDHstHvPOkL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137554; c=relaxed/simple;
	bh=wxY4ImD5W6x3C9tGA0rcVshMwz4u/5PbLiTCRuNHt8k=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=LB1fyXGEPMQ+bitCEchw+169kUROeIkzwkw+e361Fc9Ed6YEYCf/Gk67lyTvZRdavT5TXwnyZxsiYJJdZWiywKD1/PJIxLyAQ5Wh/0+MwwnqVLvKqcz/jMrwyLnr706IDbQW1lZhIFrDVQr9WqQ7d7jZPXxllf6fPEcHzk21qcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TDemvaex; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GibMdYx4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121942.726211282@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YhF9cftFkrvHXR70/3Ri3JrRmZx0vcwHRd7bammTRVs=;
	b=TDemvaexAsTUZw0BhTeO2jW8wwBsYfUAo+kpbYQhFz8ciF0oBFYaXhT4OsyOqyMUJ3xwiW
	fRV9CGNKC7A72kRGiCMvg4kqcDztmNINdj4HRsYe9HlYt/dCfxc+6cUIAgA/vCctKIgETk
	KJzzPeDb/ShJFpHoHWBIwTKNTYTzCFcDhYN5n6uantWSW3MDc6WQbm+6+bqMC9SW6kSeX5
	z53sXS4omIviTexUWA8oeBMKPm8TLZ4dZZEYG+mJOt+Iow9PH651qceGoA9m6kc4yAV/HE
	Vr79h08kpJ/1ittlQMbaaaDecXCPok7PzdEfzhxU1+XOLzLDZdMFM1yM1tvNzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=YhF9cftFkrvHXR70/3Ri3JrRmZx0vcwHRd7bammTRVs=;
	b=GibMdYx4Asz4YsTwSsTXnaEwolxRXXWtgQK606BlByNQYoaw34AQ+Qv3c/TyQzOKrnk0gc
	am/oun0H8ZegApCg==
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
Subject: [patch V5 21/31] rseq: Make exit debugging static branch based
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:26 +0200 (CEST)

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


