Return-Path: <linux-kernel+bounces-890311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357A0C3FC40
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA403B7F85
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DD8320A31;
	Fri,  7 Nov 2025 11:43:46 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FD931D732
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515826; cv=none; b=HWTuNOdQmwxcAw8YsD4pimHsMjaQYcloLe2qLNfIDRe0dUubSPniP8PWhRfy13ImXJ2OaR8O/w3ZKZ7kLFLY9qDdQ1uX5UDgL4R5D6Ug7IwY1564MeMEwTC4+yL2me0DiWZntSZ9NguITV6QkcY9HLwFxyZgZz2gZCM6YsjLS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515826; c=relaxed/simple;
	bh=7XjYNgUx6rZaXD1kxM8Bcq/1XssSIsXFqwOfPkeINoM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PA1MfH6BkugE7OaAgyVWOCnwWZ3EuFYwo5oVbvIEbXGZtiBiCTEkLP+j6LKUwfanIrLgDt3FwTMcTAGpiIsH7uYqpzATrQGLKN1iPA59veKlA1mx4qXiamoPI+pbVzCBTJoxrNz+rhAq/LISsENMsnIux8la8B0O6kuQgHWQSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4335b48ad16so7260595ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515823; x=1763120623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjTc2u1Lbv7yBpUV5/+qs7EROnDaI/ku1EfRStKnaFk=;
        b=hrNOUZ14Y+75/HKkMC/Yf8vq/dO3vnydeQTqI7LVNVjRYNrN6JVfB3EOIw3IjazOXD
         Chx5Ead6PiAeCvuu/aAz7h9dN6khsnwB1IWjfmCb1ZMF1J/qKc3d5jkjuuiNgC+8DoG3
         lWxpFDXPJWym6pjJ58aIR7Zzxk6u0ktbxIv89uFp10UbYnwOUW1oubaNKCIfm1i10yDU
         d57iZfJyHt+YsllJPMic2lfVUXSxmJMy9fyvYYwkJyr157xhwTsaOXgxESnVWRELGOzW
         U7t1liJ/GfqalzcQnfDiuPrymf9S4b4dch52xjuQGRQNZVSxP+Zv580XnFMstCAuP8i5
         Euhw==
X-Gm-Message-State: AOJu0YxwbBvcye3vn3VUaVcLBeJuKviuSp8DoLm6oymY4EopnATJReCs
	i+rtLw3l2Bu43vUczxmbvjpGQ+KYjnr0s3hwDVvxsVy0K2if0SEmHEs2vjJBKoa0ySP0NJ18v3B
	htMd9antU6KK2YmJ631RtW/tMhfoRwTMK029nwSlWUaNYfOyI97nn6Qk28xI=
X-Google-Smtp-Source: AGHT+IFPN5VKzB5iHQXIqgApTqvZ8Za/zs/gA8XysCKRk8t6N6smheQWMRw0xUvbJbFnWeoeILPB5oCB3qTFnBdBJQDRYGCnmjAO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:8a:b0:433:4fc9:7b38 with SMTP id
 e9e14a558f8ab-4335f4a0057mr34042075ab.28.1762515823617; Fri, 07 Nov 2025
 03:43:43 -0800 (PST)
Date: Fri, 07 Nov 2025 03:43:43 -0800
In-Reply-To: <690bfb9e.050a0220.2e3c35.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ddb6f.a70a0220.22f260.0045.GAE@google.com>
Subject: Forwarded: [PATCH] nsfs: skip active reference management on initial namespaces
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
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

Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
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


