Return-Path: <linux-kernel+bounces-764587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFB6B224D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 309781A28831
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9CF2ED161;
	Tue, 12 Aug 2025 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ioGtXGnO"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A9C2EBDD2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995576; cv=none; b=RBqpJTXsXOx4o7foDgO9nJtstCWvwMSxgt+J9OhVgFeKYRBL2cLNeK0NyhDy5rm/abbUY9TMlSaHoWfsOSi95ifVqbQBxq+qBLCH0Vp1rb9HjFFsi0dlgCPLwfQ7xGgnwVBzwmrv61qxnPGcFAZYcsf3StYZbfbVWt+z3rnAOpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995576; c=relaxed/simple;
	bh=1tsQSdG3yZOrZGZhMvetPvkheLSWSMiaRFMeyD+344g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oQU8BphDvVaocWObRs9YRTegKkvkqR27dUa7IH9FuIYKI+/j8wDWhoOTtTXEYHB3c2wROhCNP2YZ49RIRCuLZ8Byv9UA4HdSj1z5cyDbsTGCXPV/M4IdRWOQHJ4TEZCBW3w6q+bs/IH846v4Ila9kzFUJXvqF3lrrKKtOVYWT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ioGtXGnO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=p++m+D3TzbqZgFFa4l1hUbPQS1hbYRMWFqRcL82KSek=; b=ioGtXGnORxciG9LHA+ZahVlm93
	lsapz6RaQ/xuHK73D0pU54NwGdMvHALWFKWujYviuZ8UslqtR+zePiAgPuKQBCRo2ZKWt5na6M+I6
	FrOg0xSFcbViSJhqbCDzqBTJvCQO6mw1hmFX4lHC6At8oK/tc2TsjZ3guniw2vrHZvpspZDdP2TNG
	Lqvs475kGLNvbgMLFdJjtLQUYdAyUllN+x7WhEjX+iu8BOc+Io17+jYP27Gz2bOrfltBwXGVryCRj
	V4LMYTtKRW2BdNMVvb26QOG4+iQ+z1Au3QtOOWhAzRRqaj58lrthp1ytbrlJ/n/ktSpAGcxajkPak
	yjF70r9w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWB-0000000FmkC-25jQ;
	Tue, 12 Aug 2025 10:46:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id C4E85302EC2; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104019.956479989@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org
Subject: [PATCH v3 14/15] perf: Identify the 0->1 transition for event::mmap_count
References: <20250812103858.234850285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Needed because refcount_inc() doesn't allow the 0->1 transition.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7033,7 +7033,7 @@ static int perf_mmap_rb(struct vm_area_s
 	perf_event_update_userpage(event);
 
 	perf_mmap_account(vma, user_extra, extra);
-	atomic_inc(&event->mmap_count);
+	atomic_set(&event->mmap_count, 1);
 
 	return 0;
 }



