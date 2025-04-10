Return-Path: <linux-kernel+bounces-598790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AC1A84B18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 19:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFC99A051E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66F1EF397;
	Thu, 10 Apr 2025 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="uOqlv+hf"
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE6E1A5BA9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306522; cv=none; b=bvB3av0o0FOjEd4mP+Jebrrs7RsGuD9DNXeX/i6lkNlkX0yMRnlGyVaEBDBL+6w3to/c1vIwM7c4Bx68BTX3DZnUyPg9R9EiIZpimg39UZksiwVXKHkIscX3EnmH7PKjjS3WVaY2p+bOy51dvaCcyINZ0wNWuKE9iZJ4WBu8K0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306522; c=relaxed/simple;
	bh=wcQi8W9LX8nVrhQ53b+wMd3oZKIKnIgl+yqFjkr3x6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MPwD2Wr7+6IoiVJSTJ0n9BLozcYh/jf7ekNoFL1IDnuSW6CcItxkExvyzcG8bNhwgcIA13shKn6UA/mg/ANUlGQHgwQBIcOYQYc88NewM+MVuM06DRccq8GoqhzyhsM7FLxBehGBeSMryAsyQzGjBksJUYgOWTUZI5QGkO5QhpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=uOqlv+hf; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZYRMh5N41zTbp;
	Thu, 10 Apr 2025 19:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1744305456;
	bh=L7tUzc1W6d7egGwzo3TXqk29mI9VO/9b9vzhaLvrMDs=;
	h=From:To:Cc:Subject:Date:From;
	b=uOqlv+hfp8FBKWY5iFXLxCDA/8wEIVmFHJADEXXydHTxyFNgLAPh3+tPCXhxe8gY8
	 qVwJtNpW4utJmJ6JJbkGvWG2N8R6QkQ4q34lA4xz0BxUGklzkzBNyYP1rwQHf07jEy
	 HGcPt3NQ5sBgTmCAo2nxWD3yDyMsWfOTx5jnW7Mw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZYRMh2J1dzGQ6;
	Thu, 10 Apr 2025 19:17:36 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH v1 1/3] landlock: Log the TGID of the domain creator
Date: Thu, 10 Apr 2025 19:17:21 +0200
Message-ID: <20250410171725.1265860-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

As for other Audit's "pid" fields, Landlock should use the task's TGID
instead of its TID.  Fix this issue by keeping a reference to the TGID
of the domain creator.

Existing tests already check for the PID but only with the thread group
leader, so always the TGID.  A following patch adds dedicated tests for
non-leader thread.

Remove the current_real_cred() check which does not make sense because
we only reference a struct pid, whereas a previous version did reference
a struct cred instead.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index bae2e9909013..a647b68e8d06 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -16,6 +16,7 @@
 #include <linux/path.h>
 #include <linux/pid.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/uidgid.h>
 
 #include "access.h"
@@ -99,8 +100,7 @@ static struct landlock_details *get_current_details(void)
 		return ERR_PTR(-ENOMEM);
 
 	memcpy(details->exe_path, path_str, path_size);
-	WARN_ON_ONCE(current_cred() != current_real_cred());
-	details->pid = get_pid(task_pid(current));
+	details->pid = get_pid(task_tgid(current));
 	details->uid = from_kuid(&init_user_ns, current_uid());
 	get_task_comm(details->comm, current);
 	return details;
-- 
2.49.0


