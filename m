Return-Path: <linux-kernel+bounces-745794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 519F6B11EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FBC5A42B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5482ECD0A;
	Fri, 25 Jul 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QquobEAr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2392EBBB8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447325; cv=none; b=Y4FRCIjmQKuITBbZR0q9P3LQQSILVb6cZi21D41j8i5FNMZahKnD0YJkyq25loRM0ImfBGZ2ELBX7jRJGCFDRUCKn/Hgg7bVyyvl5Ec7lQxb8JVaOQdbfAdFhzPlcZWILroVjegeGp9Rk8haO8X+yLlRc17NivXzkAWVzBtcMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447325; c=relaxed/simple;
	bh=mNUerDeWMDwuhNTWsVCTdRAnuIxvoe1URQ/NvdL0ibM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=cSBVWL+VBf45L8REsfdN5xF3BmPIPZDfhVwSFJq/3ftwIYzV/ABqJYv0bsL+/l31PVDmYbY+siJJ/Xn+mOqtU0lg+FZpQsStqD5lCTGcJqQJagtEmVbqN0wJ+1ErL1krSk0lZtyZSApCTCtCkTk7ev1rPvcrxJT+GbiW/wD100w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QquobEAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9C7C4CEF6;
	Fri, 25 Jul 2025 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753447325;
	bh=mNUerDeWMDwuhNTWsVCTdRAnuIxvoe1URQ/NvdL0ibM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=QquobEArlq7Hg6aWcmobTEsqeLMD9GiqB3Ppuna/p/MNzJEaLcyX+Oc4+uuM8JGQ9
	 oXPWLPBWF+nCQEQsbvLmSc3/daR6Wp+nsZGZZKXMCUBf22n9LMcLnXwUAO3DrwFNm9
	 H+FjKuDXrxSll0LaIGKvpye1tq0uAVu0jl+lNdEJ6CfO/MtQkb1s/p8up8wKDYSGmU
	 osFTRn0T7db2CWtgrhKFCv+/++vO32XgUZECCibf424IQwVgyyQ62oCz5vatZpJzUi
	 tAu6zphQC9r+8vBfLK4dnBIijonvAN2vsHskiOex6so4IQqU5P93xUiwBxH2qbDlcn
	 75ZkPd91pvxKQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufHkY-00000001CtR-38WD;
	Fri, 25 Jul 2025 08:42:10 -0400
Message-ID: <20250725124210.604811699@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 08:41:47 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [for-next][PATCH 2/9] alarmtimer: Hide alarmtimer_suspend event when RTC_CLASS is not
 configured
References: <20250725124145.391996103@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The trace event alarmtimer_suspend is only called when RTC_CLASS is
defined. As every event created can create up to 5K of text and meta data
regardless if it is called or not it should not be created and waste
memory. Hide the event when CONFIG_RTC_CLASS is not defined.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/20250612095828.6d75dfa3@batman.local.home
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/alarmtimer.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/alarmtimer.h b/include/trace/events/alarmtimer.h
index 13483c7ca70b..8e9c76a7f21b 100644
--- a/include/trace/events/alarmtimer.h
+++ b/include/trace/events/alarmtimer.h
@@ -20,6 +20,7 @@ TRACE_DEFINE_ENUM(ALARM_BOOTTIME_FREEZER);
 	{ 1 << ALARM_REALTIME_FREEZER, "REALTIME Freezer" },	\
 	{ 1 << ALARM_BOOTTIME_FREEZER, "BOOTTIME Freezer" })
 
+#ifdef CONFIG_RTC_CLASS
 TRACE_EVENT(alarmtimer_suspend,
 
 	TP_PROTO(ktime_t expires, int flag),
@@ -41,6 +42,7 @@ TRACE_EVENT(alarmtimer_suspend,
 		  __entry->expires
 	)
 );
+#endif /* CONFIG_RTC_CLASS */
 
 DECLARE_EVENT_CLASS(alarm_class,
 
-- 
2.47.2



