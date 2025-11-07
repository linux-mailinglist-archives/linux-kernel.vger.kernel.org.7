Return-Path: <linux-kernel+bounces-890310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDD9C3FC3D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BD0634BD47
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D5931D748;
	Fri,  7 Nov 2025 11:43:46 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A03168FD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515825; cv=none; b=HQx38+NMR/xc16kijSlpH9szXqPExAcSeupjiTOzSSILqSdhJWDPeIYYxsvER7Xu7itoN7GcWz4m/0Q9kz2qTF1FQE3ost8/qDARbTPBw4aEfaeov/WJr68dOSg5oWr3Ag7G+jg/nZd6QcH0c0nRJR/iEEZqHuNPBXBUUdowNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515825; c=relaxed/simple;
	bh=7XjYNgUx6rZaXD1kxM8Bcq/1XssSIsXFqwOfPkeINoM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F3mpADH2xdDCoa6ybsv/My0lxbJAnH7a8yOrWDoXmKIIVu0GR+0594Fy8cbOlVlXlX+IP+YNZ0vfvdZlyne7Tjy7R29ElH1e9Bs5+ARgkipacB+BhHhoClJpGKkQrj3/NFIHkfP/MDewoojSEe2rIh9gcTB2R19fpvuMjK44LL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4331d49b5b3so19799095ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515823; x=1763120623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KjTc2u1Lbv7yBpUV5/+qs7EROnDaI/ku1EfRStKnaFk=;
        b=jaqcHfl2UvajhNlVjAFtB1mncgpi65NOkJHbn6n4YGFSaY1m+spjefVmR1hA6mX+XQ
         edf/itTOtzCLcpWBCRRUhWKr2LV15KH371VmWqslfqlf+koTaQKDAWPtOp0y/IFB07pY
         VuKnYlyAxClh2eFoqhILWTzG5558gZGnkXbW1BS25NuExkQCKNz7vhr0UnZim4xslIpq
         sX/mEd+JqKexVDpUuPL0fD20dqB6bPDPgzUpFGoaXmDo1SiAYw6GVpeiVdedXpRNdyFZ
         oj1Snmn1wsfo8IcfRNwc4kXX2mnzS6Y0e6BcNQLic8Yre6BtEgDXNCE+Rnbu5HCykzrI
         0eYw==
X-Gm-Message-State: AOJu0YwaugRQ+H063g7nbOWqB7t9HOWfkFinu7bFYWzJMA6XX+te2wO0
	URl195tUzub+3HL5Mq2sXAx9qRJazpG+kwrzSR/AilltwpYxMosfg7+nRg+QgwENJX2zDBsCm8r
	Hu9MVEP/AdEEX/dItxIyZ6Ic8QVAPQ+129T01CijllFk3PXabg4LZ1AIrZ8s=
X-Google-Smtp-Source: AGHT+IGzf2hrsRLc5hY1wVbQxORKQu0HZJjjyRJnGn8N9Hyt+GoOoYuOclSUl5KT+u4yT+up9kQgDE+YlAPx3td/o6lmQC23T9oI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:433:5736:968f with SMTP id
 e9e14a558f8ab-4335f40b525mr49593945ab.13.1762515823406; Fri, 07 Nov 2025
 03:43:43 -0800 (PST)
Date: Fri, 07 Nov 2025 03:43:43 -0800
In-Reply-To: <690bfb9e.050a0220.2e3c35.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690ddb6f.a70a0220.22f260.0044.GAE@google.com>
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


