Return-Path: <linux-kernel+bounces-897553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5E4C53144
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D11735575B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9221342525;
	Wed, 12 Nov 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="davH6+83"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892F2340273
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960960; cv=none; b=KFVFjZIwxulqLwZKeVYpIKOHSM27OCrzCShA0s1Tkc9BnGIXthgyKQtY6tqzm10zPY/BTTw8yLbDiJxic7pTJJsbFEB9JzzNqQYxAqKyCGx1mA68mqyg35MVigLSYx9VzGgBMkvPS99TDAOtTEGqbKW7MXyBpaPI0ruhiQohlN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960960; c=relaxed/simple;
	bh=0CjC3pWjpnIXqDjBQo2LfVTMocyJnFcjywCm1aRGX9c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sed3mfE6aDlpW2tvfp4LnTo3vv7MbNJR8vbo67TsqcduopltkW1Iyb0QnS8M/tqA658nAqq8D97L7XuPTlRyDjaGQwNZ0SBLwKw6HjoK3l4kcplYOhj/2TrCahl1OoXrfg6G4XuxdmM5VkReREJSO6hFnvHp9uBbGNx2DZS/6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=davH6+83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B605C113D0;
	Wed, 12 Nov 2025 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762960960;
	bh=0CjC3pWjpnIXqDjBQo2LfVTMocyJnFcjywCm1aRGX9c=;
	h=Date:From:To:Cc:Subject:References:From;
	b=davH6+83whF1yChTjONn5bTad4VtfzU66PzHIVkgZUhzj9ANdmekaxN4aAyoYK4hL
	 I/gR9SB4pHVqr+G0EOAz89Ml8gZD0YCfyX6qPxp6l58r73Nca2SoSDwhlmGUTY1FSZ
	 AZBtrAh483gEoxvChuaGc8u8t8PfCx+RSONDIrmmLbbUZc+RLFYH00jhxn7CPB5Hkn
	 PW4LzSp+gbhHiiOjKFXAUWC5jiLWdorSdJngPz7Yd0cHByGQFaZvsQTjZDrd/fp5vl
	 PpbdjurxCdCyCPuvy3oy3rbxSZanVYZtPQ9MmGxzuRdLuE5q0nOkB0D2tc6UNK3CmZ
	 /WGcQ+y5z2b+w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJCgO-000000018LX-2C9c;
	Wed, 12 Nov 2025 10:22:52 -0500
Message-ID: <20251112152252.371495653@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 12 Nov 2025 10:22:36 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 1/4] tracing: Report wrong dynamic event command
References: <20251112152235.655878322@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Report wrong dynamic event type in the command via error_log.
-----
 # echo "z hoge" > /sys/kernel/tracing/dynamic_events
 sh: write error: Invalid argument
 # cat /sys/kernel/tracing/error_log
 [   22.977022] dynevent: error: No matching dynamic event type
   Command: z hoge
            ^
-----

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/176278970056.343441.10528135217342926645.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_dynevent.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index d06854bd32b3..c4dfbc293bae 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -144,9 +144,16 @@ static int create_dyn_event(const char *raw_command)
 		if (!ret || ret != -ECANCELED)
 			break;
 	}
-	mutex_unlock(&dyn_event_ops_mutex);
-	if (ret == -ECANCELED)
+	if (ret == -ECANCELED) {
+		static const char *err_msg[] = {"No matching dynamic event type"};
+
+		/* Wrong dynamic event. Leave an error message. */
+		tracing_log_err(NULL, "dynevent", raw_command, err_msg,
+				0, 0);
 		ret = -EINVAL;
+	}
+
+	mutex_unlock(&dyn_event_ops_mutex);
 
 	return ret;
 }
-- 
2.51.0



