Return-Path: <linux-kernel+bounces-822276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA321B83709
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99E31C81F20
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E322F0C67;
	Thu, 18 Sep 2025 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HoKt1pLQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E562C0263
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182817; cv=none; b=nBbabbzYOhb4zR4QzuE5JACiQjUznweuiMJiNAJcsJ3q8PsWxpEAiac+vZSEJTOvxGAsmXkGg8xpCcmYrWCuzDGROmUdWlVtt1pqBvxJ9SVrmpE6gXfrm/HNBcC+eg5/b8qWqWMtOB19iL27IiDZnvJ2FV2zQWrnJvMi92e0omU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182817; c=relaxed/simple;
	bh=1e2zakSUqeLToQoAPVml6fhi/XriNjG58yMRZpByB7A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QC5Ap5qg8c8Q25W5IzKCiq9c73l3KARk4gadzZ1NYHMtK9KU3XS9ec1AYSAJIzU7yN4+ZnO5MY1Xh+cLxWrKcihBGODX1USpbx47xqdkldgXJvEJgFrBDFQtsHesfNKwn7qBDFwnbpUsJXu3DYkp7NfQ0OEfrKFkbIfpr8xPmpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HoKt1pLQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=NBKWbQzjQqnxgf5mh4ZofQjDAlswEiWQQO80U3lRI7I=; b=HoKt1pLQ/dEMvYt4waSSFdl3Hi
	RIp3I1XOVNHbT6Aa7ecgMsisljHGCRHOrWZC7Wnoz65vqDjFDoGRiaHwHDca5SualV6RWCiWflmeY
	To5l1Kd9Jk8GcelsVdicYKHpw/ljzxsOeTzni0xvfrnv8UOc7au8qlkZtnxC7KhSM/RLbFR8r0lQJ
	pA7dshUv5fenD1r21aFPMdCvtUaJbuS4C8kUueh49iCDDINaWJKpQNuKBdktz9WEKYnbjTS8/aSBL
	15eDVzEztQzDGr726Ypk8VQcZolFLR39n6/27vun+7rpGOoi0bCb1m0lOxYZ1LcheRfJ4B95l02Ty
	I//8hUQQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9fD-0000000Fbs4-0nJG;
	Thu, 18 Sep 2025 08:06:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 34615303003; Thu, 18 Sep 2025 10:06:46 +0200 (CEST)
Message-ID: <20250918080206.295040075@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 18 Sep 2025 09:52:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: arnd@arndb.de,
 anna-maria@linutronix.de,
 frederic@kernel.org,
 peterz@infradead.org,
 luto@kernel.org,
 mingo@redhat.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 oliver.sang@intel.com
Subject: [RFC][PATCH 8/8] sched: Default enable HRTICK
References: <20250918075219.091828500@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

For the robots.. let us find regressions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/features.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -63,8 +63,8 @@ SCHED_FEAT(DELAY_ZERO, true)
  */
 SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
-SCHED_FEAT(HRTICK, false)
-SCHED_FEAT(HRTICK_DL, false)
+SCHED_FEAT(HRTICK, true)
+SCHED_FEAT(HRTICK_DL, true)
 
 /*
  * Decrement CPU capacity based on time not spent running tasks



