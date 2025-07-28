Return-Path: <linux-kernel+bounces-748598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDE6B1437C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2E04E2EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D394D22F77E;
	Mon, 28 Jul 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbXcRV+w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3539322156C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735786; cv=none; b=gy+5qPf9XUBeD/wW9ZNJZcfE6WFuIgtrNHZuPbBQ+G54b2kczBX6y5o6XadBk6UO1EKDs+99vZYyTeWbDNlHxyZiFqDI4MLudZgtyUQ51q9X/e99e7TxzQkm8MXqERbxuAo9kNLRxZpUa2VXd3oGIowmDLeaARswLa389gz14pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735786; c=relaxed/simple;
	bh=xA9EdT2HycZIor0fvG3GFQWsXgKP+tp2pwkHaU1rJq8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EUnJB+BPEl8EPCGQ+WGDnANjPXPsB+vG1rXGshxGRme7tVv/jWZNb+FN3fgUF9vuNRujm0xkZzsfskejJqTgY+bX0fmPVYh2qjSOMguFNMiIblY9Qmg1z3otpRfILtK3urRG9sY2iDIDmKV2nws1hRj6uyacK0nl9cp9Yte8LDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbXcRV+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742CBC4CEF7;
	Mon, 28 Jul 2025 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753735785;
	bh=xA9EdT2HycZIor0fvG3GFQWsXgKP+tp2pwkHaU1rJq8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=SbXcRV+w+ge8BFYBMXzAE52LvU1iAdz6wmURnebMTGoJLJtOnNUbrtKhIHS15eVIf
	 qwI25zzAvU2Kmx8SUsUBp9WhAmWDWxIY43eTyTXWgV6lOjLiE1xCk+U0kTSKgoOOHW
	 polqiTGPcn3W0MAlpuyzTBELlkK+OkF7frQ5djI8FReV+GyBnlTWKuO8/3zSXF14xW
	 IG9a4jOJ8MWHBhCGDAvahyyJh2TmfeEy5A39z9sPTHs808K4NbpKadbjVbdqiTfWH7
	 uuQDXTyhdz/PC2b9/2HyY+rSwle0/eTQon8yVZzpVEQ4gTYT7AsP01mnT2KWoi/8Ui
	 3grON71lSGl6Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugUnG-000000042up-12As;
	Mon, 28 Jul 2025 16:49:58 -0400
Message-ID: <20250728204958.099222690@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 28 Jul 2025 16:49:36 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 02/11] rv: Fix wrong type cast in reactors_show() and monitor_reactor_show()
References: <20250728204934.281385756@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Argument 'p' of reactors_show() and monitor_reactor_show() is not a pointer
to struct rv_reactor, it is actually a pointer to the list_head inside
struct rv_reactor. Therefore it's wrong to cast 'p' to struct rv_reactor *.

This wrong type cast has been there since the beginning. But it still
worked because the list_head was the first field in struct rv_reactor_def.
This is no longer true since commit 3d3c376118b5 ("rv: Merge struct
rv_reactor_def into struct rv_reactor") moved the list_head, and this wrong
type cast became a functional problem.

Properly use container_of() instead.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/b4febbd6844311209e4c8768b65d508b81bd8c9b.1753625621.git.namcao@linutronix.de
Fixes: 3d3c376118b5 ("rv: Merge struct rv_reactor_def into struct rv_reactor")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/rv_reactors.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 106f2c4740f2..d32859fec238 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -86,7 +86,7 @@ static struct rv_reactor *get_reactor_rdef_by_name(char *name)
  */
 static int reactors_show(struct seq_file *m, void *p)
 {
-	struct rv_reactor *reactor = p;
+	struct rv_reactor *reactor = container_of(p, struct rv_reactor, list);
 
 	seq_printf(m, "%s\n", reactor->name);
 	return 0;
@@ -139,7 +139,7 @@ static const struct file_operations available_reactors_ops = {
 static int monitor_reactor_show(struct seq_file *m, void *p)
 {
 	struct rv_monitor *mon = m->private;
-	struct rv_reactor *reactor = p;
+	struct rv_reactor *reactor = container_of(p, struct rv_reactor, list);
 
 	if (mon->reactor == reactor)
 		seq_printf(m, "[%s]\n", reactor->name);
-- 
2.47.2



