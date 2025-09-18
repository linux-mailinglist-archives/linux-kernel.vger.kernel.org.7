Return-Path: <linux-kernel+bounces-822278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13C6B8370A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531313B079E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924672F3601;
	Thu, 18 Sep 2025 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OS3odTvI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ABB2EB5C4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182818; cv=none; b=cZqW9V3xrBCAh7xRdg+38SYaNuP6sdOQVuG4/QzhJBmRp6dw2CnuXT2C8+0mjyBS3FOFHbMFXn3wqgR3YPlmqLJq/v9UrGKjo6nTXhkymeJu3mqR329GBXyNCB70w73eGR7tV5+wtSeudTX2fqHDuTXZM2ACNZpKSzeIYR2jOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182818; c=relaxed/simple;
	bh=AeCzUiyAR/I0Tvdv/NWhP4mvqDzurjDvXBES4hJ84S4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=po6xCeB7YOVRd7KllvGSFb5tCOTi8XTxYjCsxYJoQb1gp/HL/C8zbFCtwcCvkdeqk/TmOSvBa2QZXACnke6oTzuiEhytJLZyTc5eCDX2ZuWvHkGQ+u9Jln6C3U0hxdYWNO3xkmHfMNNutY0ebuRNAc3b0buiSYINjD5SNTnVqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OS3odTvI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=6CHdliF5fkO251zOWaCUfJIHKwCAxY5qzq5kGxF+XF4=; b=OS3odTvIBGetwlwqPSQkZb4nX2
	pJWeuQ56oENcq8ZCLOQ1ultdGY0zTbBJjhHAIUOekIFruMF64BobXdpbpdIA9JfR4OF6mZA83mFv7
	t7HPSbe97V97q9UGd9ERncykm/vS27CAYV98Odbo+9I0mMmKLAHW9QFHokq3nut6rEjJ7CntQIEHV
	z7sKlynQdNY1VXdZvGJfNRWlV0gB2LWsZ53Y0tTIQ7DxULBr6C8EmgSoby7l33jETZyYkf/CAwpdn
	gJpLWoUcif70ooWYGe/1jIF0u9lqgOm5Vrmu1cb8VPvgQV+suvTuAp/+zqZCZyZC69uTzCPH+r+HZ
	sMFMpjxg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9fC-0000000FbrQ-2B0q;
	Thu, 18 Sep 2025 08:06:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 23AF5302E5F; Thu, 18 Sep 2025 10:06:46 +0200 (CEST)
Message-ID: <20250918080205.835307230@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 18 Sep 2025 09:52:23 +0200
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
Subject: [PATCH 4/8] hrtimer: Optimize __hrtimer_start_range_ns()
References: <20250918075219.091828500@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Much like hrtimer_reprogram(), skip programming is the cpu_base is
running the hrtimer interrupt.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/hrtimer.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1261,6 +1261,14 @@ static int __hrtimer_start_range_ns(stru
 	}
 
 	first = enqueue_hrtimer(timer, new_base, mode);
+
+	/*
+	 * If the hrtimer interrupt is running, then it will reevaluate the
+	 * clock bases and reprogram the clock event device.
+	 */
+	if (new_base->cpu_base->in_hrtirq)
+		return 0;
+
 	if (!force_local) {
 		/*
 		 * If the current CPU base is online, then the timer is



