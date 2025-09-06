Return-Path: <linux-kernel+bounces-804498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF92B477F6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 00:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5B834E0536
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 22:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB2C2D8760;
	Sat,  6 Sep 2025 22:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZpFh4+e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960172D7387
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757197051; cv=none; b=tJ7TY10ClRunZMNHw080PgaUPSqtm85Q/OtWxTRZt+E7Bs7M9QdPFUhpY1UKoiKQpBQ/T+X63/gqn4SbxheSvFIJbJ/cko8Mge9H2i2Hzl5cGJx8ozlghK+5QKk8nb5XnA2Ev70Pmxf/g+Ze/M5+Xf5rcIfMO0lJp+v6Rf/O9GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757197051; c=relaxed/simple;
	bh=kCxjaRhQrulgH7THzNL87X3yTbI95vE/7f4gxrgb9pg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=o6rJWMZ9PDHczEFkywM130hVg8hpknapqgDUDzkfSt1HXx4kXfKs6roqMjmgod6aJ+j1eN6toE8Obu5cV2LXVecOTrNoaA/66mXegytr6iuzIHKTMvl+DyRmzw+XwY5JVETQbkjXrfD939LiuEzObo+95KEFL9zg6aH9HE9Ps+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZpFh4+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7EEC4CEFE;
	Sat,  6 Sep 2025 22:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757197051;
	bh=kCxjaRhQrulgH7THzNL87X3yTbI95vE/7f4gxrgb9pg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=sZpFh4+elYlIttji3Nl6IEkM+YrxRAao/rAjbkmyMvsOhANwXM8WwgCu/wV8pZhyw
	 G8cJugFP7vXsDpjFxKraFwZy0YqxS98IHGzYC9GxELiAcAW0LpG1cK93WrPqFJi+EW
	 OkdY01DB9kHJP0w2glybniOITd1RQCAM9oMlkCVKP4Dz8IluNyeuj7uztBIOrkrSTr
	 E4/qkGh3R/sXpMR1fNeVvpHs+qJXgdgtdUSTLrgjmJQWimrRvYZoc+y7fBvpkicF5A
	 kGzflhaYZBW0cn4tfet1+nRY+CsuTxLpMAWuA1kdPQRhXH2jEi6m8xZ+pa0RM5XeG0
	 rrUTfcCMpdPuQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uv1Eb-00000006Uif-0Zdw;
	Sat, 06 Sep 2025 18:18:13 -0400
Message-ID: <20250906221812.990978223@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 06 Sep 2025 18:17:55 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ye Weihua <yeweihua4@huawei.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: [for-linus][PATCH 4/5] trace/fgraph: Fix error handling
References: <20250906221751.054623340@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Guenter Roeck <linux@roeck-us.net>

Commit edede7a6dcd7 ("trace/fgraph: Fix the warning caused by missing
unregister notifier") added a call to unregister the PM notifier if
register_ftrace_graph() failed. It does so unconditionally. However,
the PM notifier is only registered with the first call to
register_ftrace_graph(). If the first registration was successful and
a subsequent registration failed, the notifier is now unregistered even
if ftrace graphs are still registered.

Fix the problem by only unregistering the PM notifier during error handling
if there are no active fgraph registrations.

Fixes: edede7a6dcd7 ("trace/fgraph: Fix the warning caused by missing unregister notifier")
Closes: https://lore.kernel.org/all/63b0ba5a-a928-438e-84f9-93028dd72e54@roeck-us.net/
Cc: Ye Weihua <yeweihua4@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250906050618.2634078-1-linux@roeck-us.net
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 2a42c1036ea8..1e3b32b1e82c 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1397,7 +1397,8 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_active--;
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
-		unregister_pm_notifier(&ftrace_suspend_notifier);
+		if (!ftrace_graph_active)
+			unregister_pm_notifier(&ftrace_suspend_notifier);
 	}
 	return ret;
 }
-- 
2.50.1



