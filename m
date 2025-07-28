Return-Path: <linux-kernel+bounces-748600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1F4B1437E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F3418C2BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5457B279DCC;
	Mon, 28 Jul 2025 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJgChVq1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F7722539E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735786; cv=none; b=FxJvXzHGyM4bCoEQveO1hjOSWGCOMnKXXLyv0sR45HUC4fCF8OxsumxYli4eXb5bY3dUQRz5s15+eauFypAiPcx4eVAyOP2XTK/elpVvca7WpkLnM/kHuG+9MpaMy11HjXlXKlZrSXe+eOKeijXUesBtzLRDfh+E16vb78C57Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735786; c=relaxed/simple;
	bh=2ZP0KPw+xXpyUaKWcjsbvXzDO+nB0WA5dPt/uWOQM/w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LHMjgjnClWS74WEx4vfResFcR0+VVOLX7HtvjcdqmEU8ZL97nIZUCRn4RVz9gETWQwwr4opRFFpQfAOHybqsRNFv9nIPGBsEU5oO/sgug+sVXxMeocTKU7+5ZHpwzhrQTPjYAYE3b36jVHjdGOVhR4nJRqaTwefyuNL9X3IOD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJgChVq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC933C4CEF9;
	Mon, 28 Jul 2025 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753735785;
	bh=2ZP0KPw+xXpyUaKWcjsbvXzDO+nB0WA5dPt/uWOQM/w=;
	h=Date:From:To:Cc:Subject:References:From;
	b=CJgChVq1ppz0UxpOkxdZXQnt12EvLOn1i9o0l+flUmnU8vlhcWUUDaoP2eHMQjxJR
	 eKkBJN5yY+x2Tbp7vBrh9mYeNExpjBK7LXxUMUxT5m2WsUT60PY+ZtRCZBYTIc/i5Y
	 3/QtXy5GU2UV+L9+P0CjetvSHBkX7Soo8wtDYoMjrXYxHjYcatmHvebU41lrN05w12
	 XG74RMDU1T5dJuSyN9yERpI5PUBGj60mmWtIPCSPLSwPHVg8mGcmy0FwT1iGzfMHWK
	 kQs0jPWx/N23g21zwtSCr7QEFSjUh7lXXi90TdUrQdvgSqb5Jhk5o3eUovCUFa4dOO
	 YrOjBHs7usjzA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugUnG-000000042vo-2NiZ;
	Mon, 28 Jul 2025 16:49:58 -0400
Message-ID: <20250728204958.425213297@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 28 Jul 2025 16:49:38 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <jlelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Nam Cao <namcao@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 04/11] rv: Remove trailing whitespace from tracepoint string
References: <20250728204934.281385756@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

RV event tracepoints print a line with the format:
    "event_xyz: S0 x event -> S1 "
    "event_xyz: S1 x event -> S0 (final)"

While printing an event leading to a non-final state, the line
has a trailing white space (visible above before the closing ").

Adapt the format string not to print the trailing whitespace if we are
not printing "(final)".

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Link: https://lore.kernel.org/20250728135022.255578-3-gmonaco@redhat.com
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/rv_trace.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index b6f310498466..17ba07329b67 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -29,11 +29,11 @@ DECLARE_EVENT_CLASS(event_da_monitor,
 		__entry->final_state		= final_state;
 	),
 
-	TP_printk("%s x %s -> %s %s",
+	TP_printk("%s x %s -> %s%s",
 		__entry->state,
 		__entry->event,
 		__entry->next_state,
-		__entry->final_state ? "(final)" : "")
+		__entry->final_state ? " (final)" : "")
 );
 
 DECLARE_EVENT_CLASS(error_da_monitor,
@@ -90,12 +90,12 @@ DECLARE_EVENT_CLASS(event_da_monitor_id,
 		__entry->final_state		= final_state;
 	),
 
-	TP_printk("%d: %s x %s -> %s %s",
+	TP_printk("%d: %s x %s -> %s%s",
 		__entry->id,
 		__entry->state,
 		__entry->event,
 		__entry->next_state,
-		__entry->final_state ? "(final)" : "")
+		__entry->final_state ? " (final)" : "")
 );
 
 DECLARE_EVENT_CLASS(error_da_monitor_id,
-- 
2.47.2



