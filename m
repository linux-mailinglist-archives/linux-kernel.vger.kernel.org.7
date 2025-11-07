Return-Path: <linux-kernel+bounces-890276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F853C3FB01
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C32934BA65
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988E6320A14;
	Fri,  7 Nov 2025 11:16:47 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D42EB86C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514207; cv=none; b=i80raR/zoUIgXSc16DYSfttjJp9JQtItqszOF4cF4Nq5axBKsqa+Mp1R8seUQtgkC5YgpZwpmUpIvGtyqpXEdMPzlznOYcfAk/0dYDhEltNkxBWv+hwD6bWEbTgeBo0sbz5zyrTEYrVFS066PN8IWdVqFoWHfUBVjYDppuWyGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514207; c=relaxed/simple;
	bh=rFYyODptYBGlxeNOfs62v7K7dcPdudkdirdvr8ugkpM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a7ERS4CEEkaIiMMOxOv4pvjJuf/lR7O2/Bvwi3kJY06+H0oK7cmJcz6QjIAhAmnvo566WC0Qk30j3OpX+l/8h5BgyhUP/c2UNd9C7Of1YUio5zBlubG4K6GimVuOSg11l5/2+wytnvxatiygbP4ryjCNZjRtFKzHxUnfRWDH1h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-940e4cf730aso156461639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514205; x=1763119005;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBwTsfoyaOWJ2+3FG4KBkVoyPhpke1x/fWof+rbTJ/E=;
        b=SIuisCkM+bpixC2XZzneKk1xvaypPan0vhV6ZgFIPGJjh3rRFh5qbBDNHThExM3145
         FSlkYLSNs149gjrh1rIDj7xczgzPWd6F2sMYgmuX8aV4z/r/YlyQMW89XOSBiduHaiCR
         VCTM42nQ2ULjSn4cB3C/h7aNsUxIr2+I+apgqLatvzhXySs7Ikp8C7nW/cxrmJlK8ESJ
         mRGImfYPo2aEPp1MO9q/8yqFyyOVVWzabh0rPwkuaFe6kExXUQEYvY5L2pjEqMoec3+k
         /VJn4VEV+px6PerecczVfTujbT//aeBnCdRcut9Ni+hNfj03X6XgPjug6MpjmfOEMdO1
         pzbA==
X-Gm-Message-State: AOJu0YyJBTq48kUTJk4K3nxLmPYqLz/HzgBB0RaYV4lANk8MmR9lp9xv
	EJvr6fsxyU612rSHAluDzYhxxH0NAqBKNs/gKTxNCG9Pu9s9oW0uKFUfgixjAR203aoRiNPuSQG
	LWQMSNGXDqkQ3GKygCCtTcG6i6fFy8UZCAAIaram+Xef/vZJ0wokQEXPwt64=
X-Google-Smtp-Source: AGHT+IF704bY4Yy2j0gwbvNm2Q3epXdHPA5SgIrM1xdYhEghnzlu3vqvVN2Q3g4ra7oA0zKfi2DuRdiYoEgStcieadf+ZlrUz/q/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0b:b0:430:bfbf:4e4a with SMTP id
 e9e14a558f8ab-4335f45e1fdmr39631905ab.16.1762514204827; Fri, 07 Nov 2025
 03:16:44 -0800 (PST)
Date: Fri, 07 Nov 2025 03:16:44 -0800
In-Reply-To: <690bfb9e.050a0220.2e3c35.0013.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dd51c.a70a0220.22f260.003f.GAE@google.com>
Subject: Forwarded: [PATCH] ns: skip active reference management on initial namespaces
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ns: skip active reference management on initial namespaces
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

Initial namespaces (init_net, init_uts_ns, init_pid_ns, etc.) are
statically allocated and exist for the entire lifetime of the system.
They should not participate in active reference counting.

Currently, when operations like setns() or process creation involve
initial namespaces, active references are being taken and dropped on
them. This causes the active reference count to become imbalanced,
leading to warnings when the count goes negative or hits zero.

Fix by modifying the ns_ref_active_put macro to check if the namespace
is an initial namespace before dropping the active reference. This
ensures initial namespaces are completely excluded from active
reference management at all call sites.

Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 include/linux/ns_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index bd4492ef6ffc..6353120e60be 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -314,7 +314,7 @@ static __always_inline void __ns_ref_active_put(struct ns_common *ns)
 	}
 }
 #define ns_ref_active_put(__ns) \
-	do { if (__ns) __ns_ref_active_put(to_ns_common(__ns)); } while (0)
+	do { if ((__ns) &&  !is_initial_namespace(&(__ns)->ns)) __ns_ref_active_put(to_ns_common(__ns)); } while (0)
 
 static __always_inline struct ns_common *__must_check ns_get_unless_inactive(struct ns_common *ns)
 {
-- 
2.43.0


