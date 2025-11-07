Return-Path: <linux-kernel+bounces-890313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94408C3FC4F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DAA1892BB9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0A631A541;
	Fri,  7 Nov 2025 11:44:44 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F12831BCBD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515884; cv=none; b=CRHboP1ae0Ozp+yVm2fmMU6hldvx23xv2gKCaujOLzXJvIKVWoa0dD19/PYjtQLDyTNHoE6olFMwRgyhxS1zGubEZkykXROQ7hc2W/SDP0hiSkp2tbQEDiVnrz/ZxoymONbMZ8bs4GW+njh6jeRqmCfuHPtMybkM9nww93sgaCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515884; c=relaxed/simple;
	bh=fOjTAFgaRoLFZBEx7uop3DC8z/6P27Uvzz3sKeyhoHM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QU+dzdvNf/w8hBMCTFZabxj8QIAixqPYVS1gj+hntky1AiTN3BFVYvrGX/MVO2DWLx4KFoqZ0yhp/ry7rHmTiiPPvXhCCgviN2ZxJEZ0UzD5Sa0DzDXYyp1RvlVSvwQNJabuFEvUc5YZWdj1jwMAPegUtyDrMO51lUKGLW76+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43300f41682so5760035ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515882; x=1763120682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wUvyCsWfUhFZJBw4TmK99vr8qtZu1kmNjDvReeLlcI=;
        b=gZSYZWo+EqqomvL0sTCikxvbC9MBwiIDJmjfOED5DfS1+fuqXblq/jpmVFBz9Go4qr
         kI27C2q1QOTB+qd86wLS5kFPNOakTEvN6YX8L6Lf4TVdKixDx0mT2Ng2pGmnmqS4l7tW
         DvdPyFeqpr0A0jEeT9aJGApJKM2oSsPFcpvF6ryqWjf4S/GRYMCqlIXvplZSfnZcWxzp
         UaLxvrta048NSimGHKlF5VvSSxWyNrQuJoaaZIChT2XVdiAm+r37YWSyqguSLAjuGefc
         pZUGa8BGCaREZleE8y7rFTey5R5x1o9eyQPQRVcwVYVepJEfAyXlAF9ZpbXpvPGANZdU
         Lz4g==
X-Gm-Message-State: AOJu0YzD3RbQXFhBnOoeGk4OV5IoaLAzMo85XLJX+GzpMI5O+eaSAofZ
	CZhgCUH0LW9ZznpHmY1t+8IvEtsAbDsBd0LuPOPvwZ7Q2mlsG36R15JPi9ox8JtX49P3dYojjgg
	G+ecQhr1cf4SdenxCYIrbalJYlf6VIehfyqZec0wHupdk/Aooocp6D+VgSVo=
X-Google-Smtp-Source: AGHT+IEw3+GHkmgsCEI7YtpQf13GK7lamBk3t2H2unhyBmwFvTxyOyIWrIxrNdLf0yqNpMW7nZBwilRFzv68nHDXFyWdmPaA4g+a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcc:b0:433:1d3e:e53b with SMTP id
 e9e14a558f8ab-4335f440ab5mr35491005ab.22.1762515881745; Fri, 07 Nov 2025
 03:44:41 -0800 (PST)
Date: Fri, 07 Nov 2025 03:44:41 -0800
In-Reply-To: <690bfb60.050a0220.2e3c35.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ddba9.a70a0220.22f260.0046.GAE@google.com>
Subject: Forwarded: [PATCH] nsfs: skip active reference management on initial namespaces
From: syzbot <syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] nsfs: skip active reference management on initial namespaces
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Initial namespaces (init_net, init_uts_ns, init_pid_ns, etc.) are
statically allocated and exist for the entire lifetime of the system.
They should not participate in active reference counting.

When operations involve initial namespaces, both ns_ref_active_get()
and ns_ref_active_put() were managing active references on them.
This caused the active reference count to become imbalanced, leading
to warnings in __ns_ref_active_get() and __ns_ref_active_put().

Fix by adding is_initial_namespace() checks in both the
ns_ref_active_get and ns_ref_active_put macros. Initial namespaces
are now completely excluded from active reference management,
treating them as permanent kernel resources.

Reported-by: syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 include/linux/ns_common.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index bd4492ef6ffc..b22c692b5f38 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -289,7 +289,10 @@ static __always_inline void __ns_ref_active_get(struct ns_common *ns)
 	VFS_WARN_ON_ONCE(is_initial_namespace(ns) && __ns_ref_active_read(ns) <= 0);
 }
 #define ns_ref_active_get(__ns) \
-	do { if (__ns) __ns_ref_active_get(to_ns_common(__ns)); } while (0)
+	do { \
+		if ((__ns) && !is_initial_namespace(&(__ns)->ns)) \
+			__ns_ref_active_get(to_ns_common(__ns)); \
+	} while (0)
 
 static __always_inline bool __ns_ref_active_get_not_zero(struct ns_common *ns)
 {
@@ -314,7 +317,10 @@ static __always_inline void __ns_ref_active_put(struct ns_common *ns)
 	}
 }
 #define ns_ref_active_put(__ns) \
-	do { if (__ns) __ns_ref_active_put(to_ns_common(__ns)); } while (0)
+	do { \
+		if ((__ns) && !is_initial_namespace(&(__ns)->ns)) \
+			__ns_ref_active_put(to_ns_common(__ns)); \
+	} while (0)
 
 static __always_inline struct ns_common *__must_check ns_get_unless_inactive(struct ns_common *ns)
 {
-- 
2.43.0


