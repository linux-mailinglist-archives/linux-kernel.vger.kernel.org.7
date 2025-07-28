Return-Path: <linux-kernel+bounces-748595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 511D5B14379
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5A57A4ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5E42253FE;
	Mon, 28 Jul 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN+udngU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5B180B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735785; cv=none; b=Jb/c8dM697gZIOX1p7gNXE9FhPugDBLErSGG29GjpD/1yzaLllkjj3PJNWEUGjCDPBg8wNbW9rblib1gY58k3q5lyFHTiSw1QyiiQf3VuzBLIawuPjHWn6MROabDtqY+etYPzAiX6zGc7jaUilVVR6ftt1RpQ1WgrDsHPFqjne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735785; c=relaxed/simple;
	bh=1h/ccd7mYSdeiigRgNASidHz3AmZ4bQvdOjtLEyasG4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DbbhCo8CcsNPZsZeFSW8Qi7EXWJnQc//RKJhRzP0hVhwGVieJTOqSKoGQgIV8UfB1kQd1u3na+g24aHOPO4phQlIRwoJ2LQsLfk5kxhVVnJ8Wbmjxk6xuuwg4T+qKxDy0OG62G3WKt+GkdbfdIzq7MUksmma65p2f0ZoDvmnDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN+udngU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C6CC4CEE7;
	Mon, 28 Jul 2025 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753735785;
	bh=1h/ccd7mYSdeiigRgNASidHz3AmZ4bQvdOjtLEyasG4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=KN+udngUojK25D3ptPKH3/MdgUtOU4sQt0W21bBzkrYw0BQ8V6RMesxtGQJN4u8r3
	 041NDvyh7PiFqflI/Jnbjubkasy1buu8sikTI3fJmPkdb91OovAap/Ip0988oWG2UT
	 bfnARZC4IZqZV+do6WdyNuJ3GvxguRRkAPpIZJWxj826BiB6rIl6ZIVv7FfCrpVU7U
	 iEmXy9AHHO6ZkJZhzpnjD8BdE6Hxubxbkt/R/kJ26UWUrCZrsQgv/zFJOW6nqguuan
	 wGe4Ggr1g6zxd2t2Bi/+iqfRlVrmA7lrXA1Rb79bplLAM6dIF+UN8Stdjkcg1XT+si
	 Xok4aOXdyvs/Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugUnG-000000042uJ-0KKb;
	Mon, 28 Jul 2025 16:49:58 -0400
Message-ID: <20250728204957.930076277@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 28 Jul 2025 16:49:35 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nam Cao <namcao@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 01/11] rv: Fix wrong type cast in monitors_show()
References: <20250728204934.281385756@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Argument 'p' of monitors_show() is not a pointer to struct rv_monitor, it
is actually a pointer to the list_head inside struct rv_monitor. Therefore
it is wrong to cast 'p' to struct rv_monitor *.

This wrong type cast has been there since the beginning. But it still
worked because the list_head was the first field in struct rv_monitor_def.
This is no longer true since commit 24cbfe18d55a ("rv: Merge struct
rv_monitor_def into struct rv_monitor") moved the list_head, and this wrong
type cast became a functional problem.

Properly use container_of() instead.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/35e49e97696007919ceacf73796487a2e15a3d02.1753625621.git.namcao@linutronix.de
Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monitor")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 6c8498743b98..bd7d56dbf6c2 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -458,7 +458,7 @@ static int create_monitor_dir(struct rv_monitor *mon, struct rv_monitor *parent)
  */
 static int monitors_show(struct seq_file *m, void *p)
 {
-	struct rv_monitor *mon = p;
+	struct rv_monitor *mon = container_of(p, struct rv_monitor, list);
 
 	if (mon->parent)
 		seq_printf(m, "%s:%s\n", mon->parent->name, mon->name);
-- 
2.47.2



