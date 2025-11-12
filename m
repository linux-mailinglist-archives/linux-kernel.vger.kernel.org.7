Return-Path: <linux-kernel+bounces-898259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B61B0C54B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 111454E5CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368272F5311;
	Wed, 12 Nov 2025 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOW56R3O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD662EA498
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985993; cv=none; b=AjqtyIM7U9HttHQ6RKe8zkF21FzH5RqqWT2x+WH5jtvRBOZBguHE2yYKVBqEHmzKfQ7xGDFyTVzHsi0oy59x2Udexdkx+XoYEseTMUc4Ibjk9rqi1TZh9fwtQhp82+hcpxOxiyp9/xb5ghNOF3tYg4188SDiec2bmyKrH4PxKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985993; c=relaxed/simple;
	bh=dW7Y5ku/4jvaiMSFZjxle0SPJcMrxQH3HmYjz1L2a70=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=icQ4a59cs7dR0TOFxOBFEduV+c+mI9VuFSl7nQBIsts5cnfddqoHgckUa9EYRTYIo4N7CavOxP+6JsYp99lkoYS9aCtAdo6jn3T+4gBiFkP+EHYusTvL1Q1JE/gq659z2OW3Gf11DezzWT/G4ZMEYSJecI7PYCnsWmfBcFHcK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOW56R3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C97C2BCB1;
	Wed, 12 Nov 2025 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762985993;
	bh=dW7Y5ku/4jvaiMSFZjxle0SPJcMrxQH3HmYjz1L2a70=;
	h=Date:From:To:Cc:Subject:References:From;
	b=GOW56R3OW8o8rp1k5xD2HyLg1ZKRXOlaKihWNdJgin7YX7B+0s/gPjTMfNKZcm1PE
	 WDbXulZWx3142M4W7yXLz82DCdHG5w3iJbki86xbpLQfFIOioH3LhuzElG2FvFo7q8
	 zDNosMpptjB5rqqOTigdKQCUFLm2M4xzN1mtzAKzuofOthB2Icy1J5dlAF8bnJoZ6H
	 Zzx/fq3MPLhbvdPv1B2EzCqVLX8Bhpj+nRyVqpF5aUrDLjphGpqWAT34N4BsTGvNyo
	 T6mbtl4iocW3ETUeotx+TuUKBQu/aTR5XGfWSfeMJlAchoONC7Ep/2+egDu+Q9TRBU
	 /Cu8L90X4XsDA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJJCB-00000001EXp-1lME;
	Wed, 12 Nov 2025 17:20:07 -0500
Message-ID: <20251112222007.272818255@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 12 Nov 2025 17:19:51 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [for-next][PATCH 5/5] rv: Add explicit lockdep context for reactors
References: <20251112221946.389142361@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>

Reactors can be called from any context through tracepoints.
When developing reactors care needs to be taken to only call APIs which
are safe. As the tracepoints used during testing may not actually be
called from restrictive contexts lockdep may not be helpful.

Add explicit overrides to help lockdep find invalid code patterns.

The usage of LD_WAIT_FREE will trigger lockdep warnings in the panic
reactor. These are indeed valid warnings but they are out of scope for
RV and will instead be fixed by the printk subsystem.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Nam Cao <namcao@linutronix.de>
Link: https://lore.kernel.org/r/20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/rv_reactors.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 8c02426bc3bd..d9d335ae9bad 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -61,6 +61,7 @@
  *      printk
  */
 
+#include <linux/lockdep.h>
 #include <linux/slab.h>
 
 #include "rv.h"
@@ -480,6 +481,7 @@ int init_rv_reactors(struct dentry *root_dir)
 
 void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 {
+	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
 	va_list args;
 
 	if (!rv_reacting_on() || !monitor->react)
@@ -487,7 +489,9 @@ void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 
 	va_start(args, msg);
 
+	lock_map_acquire_try(&rv_react_map);
 	monitor->react(msg, args);
+	lock_map_release(&rv_react_map);
 
 	va_end(args);
 }
-- 
2.51.0



