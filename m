Return-Path: <linux-kernel+bounces-745801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AF7B11EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B22E1CE483D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F142EE5E3;
	Fri, 25 Jul 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeHDQz55"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652582ED171
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447327; cv=none; b=bcxajLzSH5J8mp4e0kRgyT379yoOBwSDLdJxAqEpHLlmgtHzqmMlLqeUaSGUNFD2L4FOEJvmuzXWSC3CK7DKIL+e8BeX80q2F2sB0wKXy3aDv5sKJTMck6XCsYeK/fT4VUhThNHsOjTRyUCo46lSA4oW2BXYY+P34odfRIi1174=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447327; c=relaxed/simple;
	bh=ls3B46j2JflVkBk9DwvxOwQkXpB1wVMy8TeLXZLUHwE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ghW6ncxXs3RxdNZDYF8Vq8slWrzsVeQOVvPWQJko5oDwEvtBgwayCDP9iXNQ+4E/+65A1QUst1RIdrNatdETTXxMxnipbtyZyXHkUdfWQmfa5xaTDbg+XVuM/bAT1o+j37FFHmJdkod7qkE2fSLjWFlcAFe0GNDJ0CzwoZ006SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeHDQz55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF87CC4CEFC;
	Fri, 25 Jul 2025 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753447325;
	bh=ls3B46j2JflVkBk9DwvxOwQkXpB1wVMy8TeLXZLUHwE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=KeHDQz55JOOwd1loFO+PEgLq67urE7+H/430NCyaCS9a8VDABAzF+T2isdpPpc1WT
	 8qzkZqnmNxCTKt2dmtnqhXXfBcHM3LpCMtQ4z77X+TFAJAXkIaDNFbDyU6brGrRGTK
	 sJcI/14VzppJQ9ykbVRgBBTgwRdhwUJvJY/6AcYLvcCNS/LbOPm/FiXZpwqWPH0kug
	 FqAM+IQxnKNUzjXVeMOi3miAZzDedR+9n91d0/Q4DN3wJ9a/4rI2g9Vvq6aiykW2KB
	 oJC86XuwkDNMweq54fnhGZgw7bbQhL/POPmitgUcoaOBrmCPfLuBDmzQKJxl1Ej7lf
	 vKiFSdJBFEwWQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufHkZ-00000001Cut-13WB;
	Fri, 25 Jul 2025 08:42:11 -0400
Message-ID: <20250725124211.106711710@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 08:41:50 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [for-next][PATCH 5/9] PM: tracing: Hide device_pm_callback events under PM_SLEEP
References: <20250725124145.391996103@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The events device_pm_callback_start and device_pm_callback_end events are
only called when CONFIG_PM_SLEEP is defined. As each event can take up to
5K regardless if they are used or not, it's best not to define them when
they are not used. Add #ifdef around these events when they are not used.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/20250612145408.246703478@goodmis.org
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/power.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index a10ad300d660..5b1df5e1e092 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -212,6 +212,7 @@ TRACE_EVENT(cpu_frequency_limits,
 		  (unsigned long)__entry->cpu_id)
 );
 
+#ifdef CONFIG_PM_SLEEP
 TRACE_EVENT(device_pm_callback_start,
 
 	TP_PROTO(struct device *dev, const char *pm_ops, int event),
@@ -260,6 +261,7 @@ TRACE_EVENT(device_pm_callback_end,
 	TP_printk("%s %s, err=%d",
 		__get_str(driver), __get_str(device), __entry->error)
 );
+#endif
 
 TRACE_EVENT(suspend_resume,
 
-- 
2.47.2



