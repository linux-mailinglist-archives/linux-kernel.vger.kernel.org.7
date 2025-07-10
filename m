Return-Path: <linux-kernel+bounces-724684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31371AFF5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196841BC89D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B7F51022;
	Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leZPM5MG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4A79EA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107551; cv=none; b=XV+3P6fc4S4PpxMXQMDrKjgctpwBZVoPaFiG2wobH3bd9InaSWR3u1pZVs4rDNZO5387EQ+mq48SMQXG3Vs3WQtqlUpqBYupKYrqTwENEcYq7W+UUl0oNlRbbbNpzrXvArQtEIgkX2XBuVEi7qnYk9zrPouhV+IgdBC48MmskMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107551; c=relaxed/simple;
	bh=VMkehqEglV0PNHoEULj2WvYVKtMA6UZI68rGYcKAX+A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=J50cUpzEsRb1JrlgGAM5960vh0QNs9Q6F5h/n2fp2BpptPiQFWkx23U2VjiLYu8VsIZ9TFE6OV8sMxyA29i2FzGa+Fzn8OVF7YT1g8i3WaDAyxdx+oz9o60HXANzqPGyF8MjURd/N+iWghnscu8/4dTYL5tKIPThJy//5S4u230=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leZPM5MG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E8CC4CEEF;
	Thu, 10 Jul 2025 00:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107551;
	bh=VMkehqEglV0PNHoEULj2WvYVKtMA6UZI68rGYcKAX+A=;
	h=Date:From:To:Cc:Subject:References:From;
	b=leZPM5MGY2kbpwsEIkx6XllrRhNnasguIygCDOB5qPLct32/UcPQw5ndJwajRm2RA
	 4iY1aznkwI/lLtEuH/9cKs9sjq6d8a5H4nRojO4/jfxrDLz+2Va52CJ3yYrsaneFqV
	 TcZ+xtYKlkPEBiJ1Vd/Uktfq+oFFYLK817T1txqIBPEb97cyK+/YldJZipVeg1E/Iw
	 haqyov3jGNOSKmXEf+rvdQoXZSMU4m05DDMCPw0WYRjP8dit4XnTx7JuBTvqcQRolV
	 Z9NkaHXYvVDLMrQ1CXjk5Ual/XJx3lrIRvsWVmK0cp36jwY7LlkcYQRuPeQwJuY0q+
	 auWYEciCjttBA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfDH-00000001WNo-2rTi;
	Wed, 09 Jul 2025 20:32:35 -0400
Message-ID: <20250710003235.532464704@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:31:57 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Ogness <john.ogness@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 01/12] rv: Add #undef TRACE_INCLUDE_FILE
References: <20250710003156.209859354@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Without "#undef TRACE_INCLUDE_FILE", there could be a build error due to
TRACE_INCLUDE_FILE being redefined. Therefore add it.

Also fix a typo while at it.

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/f805e074581e927bb176c742c981fa7675b6ebe5.1752088709.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/rv_trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 422b75f58891..99c3801616d4 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -129,8 +129,9 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 #endif /* CONFIG_DA_MON_EVENTS_ID */
 #endif /* _TRACE_RV_H */
 
-/* This part ust be outside protection */
+/* This part must be outside protection */
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE rv_trace
 #include <trace/define_trace.h>
-- 
2.47.2



