Return-Path: <linux-kernel+bounces-890304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D31C3FC16
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A82DA4E3B7E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D1531A04F;
	Fri,  7 Nov 2025 11:41:11 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774430F7E0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515671; cv=none; b=HC3OKeNHVw06TgWQwqpmrDWsY1LLfPcTIQz9yIxGlZsYev96wBQwapxYpBpVCMe9gAMTjZuG8zr1bjl0Mfs5YxhJmqFbRHtEf0BbeLCWDEK11ycfj7NsIH4nxM/y81Wc7Osg4Pe586OVnzu4P/K4/nkIMmp/Z1cD6yh94Ad66Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515671; c=relaxed/simple;
	bh=7XjYNgUx6rZaXD1kxM8Bcq/1XssSIsXFqwOfPkeINoM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=geBPso6RqMtSMlfKmScFMpSUM3qiYGMuvMTfF+4rlemVKVBVap+lSUMe2KGRv8XQrwD6nO4ICTG4OxMQ9/EatttTQmSiSSzyf/o+LomivH3FnY1/cygTrcaFBAaOm3s7YQsxXEzWimUHwifiuHoqoNBwAOawAPkI9mNxB9D1VTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940d88b8c15so49743139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:41:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515669; x=1763120469;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjTc2u1Lbv7yBpUV5/+qs7EROnDaI/ku1EfRStKnaFk=;
        b=WXuPOPo7ni/DoIl6wNcVmHpw81tVd/1HsFfxaKrCGuiZfU3U9i6f3NQ7dihTySDRt+
         GmxkKleKqI9RpGwqLxN1tfTv60zAvbYU6XfunPfkH4QSAATSAdaatUmMO2nqWKtvbzh4
         dZZWqwwyVWndjrJFWGbZa6RjuI32ogUdIbfH3wl9w4qU3kJg1i4O8vk6HwosIt8cttoU
         BbHSI+L/4vxSX/UmN1bP722xYD/xlSg5WUO8TV9TBOPuYR1J0SxUA1JrtCuAtUgQz5iG
         65pNBzD555vni3EtmYELyrhzNUpQY3GJZxlxgfkntBATGDtZ/UxmJsFTSQ4et9+0ZDgI
         ExZA==
X-Gm-Message-State: AOJu0Yz4sOqBO3CZanVJZVTu9+n71ajKwERTGF/omFZdNVrQxxFQAq8y
	3r7U1N30Vi9G8QSRTra/l/vmmWbdPdp61QBnNvSlwiD+VRlbMBbplf1Gtz9/5qsJ4OCdFmI4z0e
	9aJ3zBLG5dLzLIzavNnhdn0DF9keom3ToP/Wz0NbzbwaOG0y+k1bzJUSyOTk=
X-Google-Smtp-Source: AGHT+IGMn6RNHV2as+sdJiwi6Pk2zqw3SmLsqPCO+NMOklgdKEXQjE21ID5nNMwyrFUEDldN3YFi5edExg1B3oSrHVdcvInwmVoh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1685:b0:433:2812:8067 with SMTP id
 e9e14a558f8ab-4335f49d934mr40975005ab.27.1762515669123; Fri, 07 Nov 2025
 03:41:09 -0800 (PST)
Date: Fri, 07 Nov 2025 03:41:09 -0800
In-Reply-To: <690bfb9e.050a0220.2e3c35.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ddad5.a70a0220.22f260.0043.GAE@google.com>
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


