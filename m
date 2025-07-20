Return-Path: <linux-kernel+bounces-738062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69258B0B3C6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 08:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8453A174DAA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 06:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC661C84A0;
	Sun, 20 Jul 2025 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4ieRLN2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4261C4A17;
	Sun, 20 Jul 2025 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752992562; cv=none; b=WELlxb+zhT8Rek/WoIDUgH0r/fW9vRamKZbtV93fkq+Yc2WORNB7NcKdjy9/ZbwWQb5feqYIeGNW9HECPIPvo7DaDAw0p5qKH9H2tty+7Z5WCCc4OO3AoPxgD3krAWzBoHcKi0k3X61XUiRzLT+vcKSKV6/gucBR0brT3NZci0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752992562; c=relaxed/simple;
	bh=hpsFt4kAWZBfDMi50YQCwG8A9W+7Ajj8ewsnZeWqOFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9h+c+MrEFBYKnOe778MU0mPKeKQzxh4NT4B+E2hFrvsubV6S24poXrWCnQF0fUIBbAgJKrE1jqqrkM6yK3O29r6l9vlBgs5DcV8IHMraQGe9OWLmvn1yykF7m/O5rsL49OTKik1Dlu5P0D7o15XwSTvZJ6GyX+SQY7lMOUR1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4ieRLN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6FFC4CEE7;
	Sun, 20 Jul 2025 06:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752992560;
	bh=hpsFt4kAWZBfDMi50YQCwG8A9W+7Ajj8ewsnZeWqOFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4ieRLN2s9ZFB/85pCxisLwz5mm/Xuhs34F6EbOr1kW0RPjos1Nwm0dSfjphPku+j
	 0f6Vsgk/VRMJW5FuR+SEPiaExFkHsPgyrcLa6+FnafYh1w970dpwNyOIexzfwr/jtx
	 Ftscbsh9sSPE5Wb9b44OAJMH1fZeKcS+FTsAI+Ef/mKORbnQH1dR//GjwVB5R11Zj4
	 jXqvfM72xO6p3g1MQT14wGAKpixiY+Vxn529XhMPm1drXDKds052sX5liWrtmsbicF
	 Qt8LCYsjRsl/RgMseqIDsfJRMTDuEM3hTSyixQk4WSv9qHke0NtwcSFGhFbQFmXYeo
	 d820YuIRhne1g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] tracing: probes: Add a kerneldoc for traceprobe_parse_event_name()
Date: Sun, 20 Jul 2025 15:22:36 +0900
Message-ID: <175299255609.418723.7661338110074622016.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175299249728.418723.17799706394466693180.stgit@devnote2>
References: <175299249728.418723.17799706394466693180.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since traceprobe_parse_event_name() is a bit complicated, add a
kerneldoc for explaining the behavior.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index abfab8957a6c..72bf430a3804 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -247,7 +247,22 @@ int traceprobe_split_symbol_offset(char *symbol, long *offset)
 	return 0;
 }
 
-/* @buf must has MAX_EVENT_NAME_LEN size */
+/**
+ * traceprobe_parse_event_name - Parse a string into group and event names
+ * @pevent: A pointer to the string to be parsed. On return, this is updated
+ *          to point to the event name part of the string.
+ * @pgroup: A pointer to the group name. This is updated to point to the parsed
+ *          group name, which is stored in @buf.
+ * @buf:    A buffer to store the parsed group name.
+ * @offset: The offset of the string in the original user command, for logging.
+ *
+ * Description: This parses a string with the format `[GROUP/][EVENT]` or
+ *          `[GROUP.][EVENT]` (either GROUP or EVENT or both must be specified).
+ *          The parsed group name is stored in @buf.
+ *          The caller must ensure @buf is at least MAX_EVENT_NAME_LEN bytes.
+ *
+ * Return: 0 on success, or -EINVAL on failure.
+ */
 int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 				char *buf, int offset)
 {


