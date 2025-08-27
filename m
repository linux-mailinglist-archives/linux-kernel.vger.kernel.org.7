Return-Path: <linux-kernel+bounces-787603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D6DB3787E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0226F7AC572
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F3725C81B;
	Wed, 27 Aug 2025 03:15:10 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58D274670;
	Wed, 27 Aug 2025 03:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756264510; cv=none; b=g3RRliEK7bQK94cAA/DyOYQDM8g8CTL9XPUh6BQwH3n1ynHkZyWaxIi739X/OMztTmSqjNmBu3LNez+YM5L+G/Y9wn40E5tKj5z4soBS9DWYcNH5u+CKoo7CL70s3mtU1t8uPXuHDg5WqBuChPzeqE0teEbVqqv/LjSFPQ9XY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756264510; c=relaxed/simple;
	bh=AMscygHaTq9Yh0da+ginJppGuM08l6XSihXFLuahwBY=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=HhB3s7zuhve17EZna78VspEImf8BLAQdrdHeSrIE4+cXlXmTY4vBFgVYO6wTquXtvlnxZh6fdnx4g4wHKi+e7cx77/G8e3hxnQUraLWMtSB1rQ5zf1H86Bh3Ct0mGIQourHx6TnfkGfpOAZxLEwA0Meso1FKIpqKYWCnKSUCrQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cBV5L2MKpz7VGTQ;
	Wed, 27 Aug 2025 11:15:02 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 57R3EhcV048710;
	Wed, 27 Aug 2025 11:14:43 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 27 Aug 2025 11:14:44 +0800 (CST)
Date: Wed, 27 Aug 2025 11:14:44 +0800 (CST)
X-Zmail-TransId: 2afc68ae7824b1e-667ca
X-Mailer: Zmail v1.0
Message-ID: <20250827111444659yr8tENNnk9xU2ZFnz94FO@zte.com.cn>
In-Reply-To: <20250820081908.GA1249@didi-ThinkCentre-M930t-N000>
References: 20250820081908.GA1249@didi-ThinkCentre-M930t-N000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <tiozhang@didiglobal.com>
Cc: <akpm@linux-foundation.org>, <fan.yu9@zte.com.cn>, <corbet@lwn.net>,
        <bsingharora@gmail.com>, <yang.yang29@zte.com.cn>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <jiang.kun2@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <tiozhang@didiglobal.com>, <zyhtheonly@gmail.com>,
        <zyhtheonly@yeah.net>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Ml0gZGVsYXlhY2N5L3NjaGVkOiBhZGQgU09GVElSUSBkZWxheQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 57R3EhcV048710
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 27 Aug 2025 11:15:02 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68AE7836.001/4cBV5L2MKpz7VGTQ

> Taking the difference of two successive readings of a given
> counter (say cpu_delay_total) for a task will give the delay
>@@ -123,6 +124,8 @@ Get sum and peak of delays, since system boot, for all pids with tgid 242::
>                   156       11215873          0.072ms     0.207403ms     0.033913ms
>     IRQ         count    delay total  delay average      delay max      delay min
>                     0              0          0.000ms     0.000000ms     0.000000ms
>+    SOFTIRQ     count    delay total  delay average      delay max      delay min
>+                    0              0          0.000ms     0.000000ms     0.000000ms
>
> Get IO accounting for pid 1, it works only with -p::

If possible, you can construct some abnormal scenarios to assign values to IRQ and SOFTIRQ,
highlighting the differences between them. Additionally, this should cover the testing of
new features. If the delay info is entirely zero, it may fail to demonstrate such differences.

>+    /*
>+     * We only account softirq time when we are called by
>+     * account_softirq_enter{,exit}
>+     * and we do not account ksoftirqd here.
>+     */
>+    if (curr != this_cpu_ksoftirqd() &&
>+        ((offset & SOFTIRQ_OFFSET) || (pc & SOFTIRQ_OFFSET))) {
>+        delta_soft = cpu_clock - irqtime->soft_start_time;
>+        irqtime->soft_start_time += delta_soft;
>+    }
>+
>     /*
>      * We do not account for softirq time from ksoftirqd here.
>      * We want to continue accounting softirq time to ksoftirqd thread
>@@ -75,9 +88,9 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
>      * that do not consume any time, but still wants to run.
>      */
>     if (pc & HARDIRQ_MASK)
>-        irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
>+        irqtime_account_delta(irqtime, delta, delta_soft, CPUTIME_IRQ);
>     else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
>-        irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
>+        irqtime_account_delta(irqtime, delta, delta_soft, CPUTIME_SOFTIRQ);
> }
>
> static u64 irqtime_tick_accounted(u64 maxtime)

As you mentioned, delta_soft represents SOFTIRQ, but it appears to have been accumulated once
under the condition of (pc & HARDIRQ_MASK). Is there a potential double-counting issue?
replacing delta_soft with 0 when in HARDIRQ might make it more intuitive.

Thanks,
Yaxin

