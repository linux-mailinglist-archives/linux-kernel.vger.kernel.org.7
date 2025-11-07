Return-Path: <linux-kernel+bounces-890161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFC1C3F5BF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA2674EA065
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE88302162;
	Fri,  7 Nov 2025 10:14:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BE296BB6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510469; cv=none; b=qPIaJVa4/i/WvqATWnnZxzaLVJ5Dwcag6+QCYlR9gdxPAVq4cv9Nbx1146HCcGXrr6pp0VOFJA3jefoRv9D1YvRNYeNwyJXrEyROeVBHArxDC5nYnobn3sKZS0NYQy1Fn4p80Oez5SnqUi+hhZpLACi8tiRZWJSe4KzreBxKvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510469; c=relaxed/simple;
	bh=O0k57WKpoyc/voIhjDpGN3DLysiWRPtpy6MGP+6aWMU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Mj8C6H2tB8cbKyHaIXJ5H9ic2N325qEbc+FDz56RUiZYoGiniYTgSWz7USjWwwRf+D/pBZdDSwLvj4UpsBlkKp6U5WZfdlemprigbKHBKfZxI9tfIn+eTAewOqg1TLimpuEFqyFU0UsA8IN4zY28OQZQd12+VSW0RceYTGE8SlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43331ea8ed8so4761435ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762510467; x=1763115267;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Skg6GLFJukp7cNA9tZTnddLtBhYwg/QPo3fiMPOAILk=;
        b=gUdg0Wf+lJQYliZR7RK6Qs/eswxeGRWUTJK4pz6TTtjAIRcW5t+TmGlZnMMEMzIxF5
         EXu9MciRwc1befsZWmB8rrIUu1AIBruVPq8CKmRz6nOv7YNL86Z3VLBgiakhnkqqikr3
         1BahR0nYdzgFocpKokVPVyssFMvZrZ9UUXGr/64nvJkxQXcYS9K77ZmUBpUmvkuUzPI4
         dVYXhGPj9yfo0XQWJTn5eSDu7mFAa8+RDw6shwy9edg/yUFwSC0dyaOTUc+ngQyJdASS
         6bbLU6ENF+afRBsN8Q9ZZX7PLDYcuLMZ0MSm76wbNC3R2SDL0s6vhAnBGX7fMAu8aJ9g
         7wHQ==
X-Gm-Message-State: AOJu0Yz0Ogv+1KTovqrnJqx3VIylV2Sur8om9SquXlWiZOZ6g0Lqkm8P
	hfIm4B2B6R504zOeERk4GbU3x4fNjbUQr1Ggp7Nri2th+4CJpZ6y5SNx9q07mL66rGoz0b6cdaR
	XQDyKAtpqBJJBr69plOtovp2LE482WKRfYg6wnHNu3y8xQz55CQzA7vaYv2I=
X-Google-Smtp-Source: AGHT+IEa9P03NvFaH8u+x8BSmFS2cm/yWfH3IImC0IVyhvh4gM3ptuBDIY8t5Kxt8Ay1PN8p+W+ZQ3QOvGhIzPeeuRh0QSbFE7kD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a64:b0:433:290f:c201 with SMTP id
 e9e14a558f8ab-4335f3d0389mr36862375ab.11.1762510467404; Fri, 07 Nov 2025
 02:14:27 -0800 (PST)
Date: Fri, 07 Nov 2025 02:14:27 -0800
In-Reply-To: <690bfb9e.050a0220.2e3c35.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dc683.a70a0220.22f260.0033.GAE@google.com>
Subject: Forwarded: [PATCH] fs/nsfs: skip dropping active refs on initial namespaces
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] fs/nsfs: skip dropping active refs on initial namespaces
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Initial namespaces (init_net, init_uts_ns, init_ipc_ns, etc.) are
statically allocated and exist for the entire lifetime of the system.
They should never go through the normal namespace cleanup and release
paths.

When setns() is called with a file descriptor pointing to an initial
namespace, the kernel creates a temporary nsproxy structure during the
operation. In the cleanup path, nsproxy_ns_active_put() was blindly
dropping active references on all namespaces in the nsproxy, including
initial namespaces. This caused the active reference count on initial
namespaces to hit zero, triggering a WARNING in __ns_ref_active_put().

The WARNING fired because when an active reference count reaches zero,
the code path assumes the namespace is being released, which should
never happen for initial namespaces.

Fix this by checking if each namespace is an initial namespace before
dropping its active reference in nsproxy_ns_active_put(). Initial
namespaces are skipped, preventing their active reference counts from
incorrectly reaching zero.

Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/nsfs.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index ba6c8975c82e..ffe31c66d1d8 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -19,6 +19,7 @@
 #include <linux/exportfs.h>
 #include <linux/nstree.h>
 #include <net/net_namespace.h>
+#include <linux/ns_common.h>
 
 #include "mount.h"
 #include "internal.h"
@@ -698,12 +699,20 @@ void nsproxy_ns_active_get(struct nsproxy *ns)
 
 void nsproxy_ns_active_put(struct nsproxy *ns)
 {
-	ns_ref_active_put(ns->mnt_ns);
-	ns_ref_active_put(ns->uts_ns);
-	ns_ref_active_put(ns->ipc_ns);
-	ns_ref_active_put(ns->pid_ns_for_children);
-	ns_ref_active_put(ns->cgroup_ns);
-	ns_ref_active_put(ns->net_ns);
-	ns_ref_active_put(ns->time_ns);
-	ns_ref_active_put(ns->time_ns_for_children);
+	if (ns->mnt_ns && !is_initial_namespace(&ns->mnt_ns->ns))
+		ns_ref_active_put(ns->mnt_ns);
+	if (ns->uts_ns && !is_initial_namespace(&ns->uts_ns->ns))
+		ns_ref_active_put(ns->uts_ns);
+	if (ns->ipc_ns && !is_initial_namespace(&ns->ipc_ns->ns))
+		ns_ref_active_put(ns->ipc_ns);
+	if (ns->pid_ns_for_children && !is_initial_namespace(&ns->pid_ns_for_children->ns))
+		ns_ref_active_put(ns->pid_ns_for_children);
+	if (ns->cgroup_ns && !is_initial_namespace(&ns->cgroup_ns->ns))
+		ns_ref_active_put(ns->cgroup_ns);
+	if (ns->net_ns && !is_initial_namespace(&ns->net_ns->ns))
+		ns_ref_active_put(ns->net_ns);
+	if (ns->time_ns && !is_initial_namespace(&ns->time_ns->ns))
+		ns_ref_active_put(ns->time_ns);
+	if (ns->time_ns_for_children && !is_initial_namespace(&ns->time_ns_for_children->ns))
+		ns_ref_active_put(ns->time_ns_for_children);
 }
-- 
2.43.0


