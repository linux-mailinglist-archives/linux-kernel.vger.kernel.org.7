Return-Path: <linux-kernel+bounces-757430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2251AB1C205
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630EA1898502
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8576E22173F;
	Wed,  6 Aug 2025 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QWJHUWIg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pgHLrFBr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C7722156C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468380; cv=none; b=Rdbdg/0YFwlwvvubq4224/HuOZTva/YD6/qE38RBz13WjR3iiHNFcYSlPFbqhv+zj7UIRL7QxsCuRXuzr0iZchUCoYgXC46Jtr+EuhdGGEuSh3nKOf0AcBHfNTBvGATxnokU6KQXY9Yw3U2sro5xqGh9Vl7h4OPHOuXz44cT1g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468380; c=relaxed/simple;
	bh=IVjr//uof7qqewl634ccGIDdOxr2Aqk5JWUUy1OOZzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EqYPfQAHcFKjM79cBG8HpFRHmZ4O7kQ2p5hsmqOidSNYABeQTrvWyo1S7Kqcwzc3GAQxJN/qiIXfe489CzKn4pu2TurI0YJIOh+HRbg+tcxAd5Qhb5DmyJRs3Kjipxp+LTr55rDJrSjmU413xh1/k7c6VwWEexGamJremo5Rjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QWJHUWIg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pgHLrFBr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754468376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oVdy8Z7vxFzMcZIpJyuv2XRd6gG/b+uZsIufJIRyPeI=;
	b=QWJHUWIgKOkWwT5562fAfhJ9uJLrMtrpaQzMifCtJqLDgfMH1u0XdXvTrh/CIOCabQaqBQ
	cgVIVQfi+KbJuFCT91ih48QWuiIbiuqxQQmVYbL3MRkooSCRWlld82qxYukk0KBouUC5+s
	sPwO3i1DSbY3/HMlf8cjedZHjTcl/yRhtB5QQuBMhj230CXdpEdwdGa8YSrmsyzG/UgyQA
	1demA3314+qD7tnrtLuzDi6J/CxsthtD+prE43pUGT3U9AhOUyD3mk5ufQ0H9YTqW4LlPs
	mdwNnmjuYXMtUK623HiF/mOvnsFKhx2u2NXrL3mRP/ARU+mAj9214FAQMtPV0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754468376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oVdy8Z7vxFzMcZIpJyuv2XRd6gG/b+uZsIufJIRyPeI=;
	b=pgHLrFBriDWLVZhnxPV/QBPg3icmRlb1PYdcBqzrGiZnZXZRxauEBmaFZGqJidZmTuwGyC
	YjtRtX5quqfdPWBA==
To: Oliver Sang <oliver.sang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 ltp@lists.linux.it, oliver.sang@intel.com
Subject: Re: [tip:locking/futex] [futex]  56180dd20c:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/nsproxy.c
In-Reply-To: <aJML8dcu4vu4rbMR@xsang-OptiPlex-9020>
References: <202507231021.dcf24373-lkp@intel.com> <87a54usty4.ffs@tglx>
 <aINKAQt3qcj2s38N@xsang-OptiPlex-9020> <87seikp94v.ffs@tglx>
 <aIgUUhKWesDpM0BJ@xsang-OptiPlex-9020> <87wm7ro3r7.ffs@tglx>
 <aIrJipeLsGUM92+R@xsang-OptiPlex-9020> <87cy9gilo8.ffs@tglx>
 <874iusihka.ffs@tglx> <aJML8dcu4vu4rbMR@xsang-OptiPlex-9020>
Date: Wed, 06 Aug 2025 10:19:36 +0200
Message-ID: <87qzxoeuav.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oliver!

On Wed, Aug 06 2025 at 16:01, Oliver Sang wrote:
> On Thu, Jul 31, 2025 at 04:03:01PM +0200, Thomas Gleixner wrote:
>> On Thu, Jul 31 2025 at 14:34, Thomas Gleixner wrote:
>> > Either you make the timeout longer or try the following on the kernel
>> > command line instead of 'ftrace_dump_on_cpu':
>> 
>>   instead of 'ftrace_dump_ooops'
>
> sorry for late, I just took several-day off.

I hope you had a good time!

> attached dmesg FYI.

Thanks for doing this. Now the buffer is too short and as nothing stops
the tracer the interesting stuff goes out of sight.

Can you please apply the patch below and try again?

Thanks,

        tglx
---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5850,6 +5850,8 @@ void preempt_count_sub(int val)
 	/*
 	 * Underflow?
 	 */
+	if (val > preempt_count())
+		tracing_off();
 	if (DEBUG_LOCKS_WARN_ON(val > preempt_count()))
 		return;
 	/*

