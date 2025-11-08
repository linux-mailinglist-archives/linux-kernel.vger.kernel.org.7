Return-Path: <linux-kernel+bounces-891194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB698C4220B
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A263A598C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D782620FAB2;
	Sat,  8 Nov 2025 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auW3HRp7"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804620102B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762561631; cv=none; b=qCuJJFkK5P+nvIoIBakV97RfFXmTAWfMhEmr0HP5s2Yu6/yWLkrFDkSdL5IgUhC9xVjptorQrGWhNnDXhtyvNCNb5AMAHGFYj/iOSV8wbYgiunRzt+YCkSR4lgcEB7r0hVIQkFoXZwN6SQHBvgt7NMxnPlff0+GC+4gawzL41pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762561631; c=relaxed/simple;
	bh=pgHR7IWBR/a09RYbkgIU5CRVwV7NDCYpieLHFaAKZvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SnyDRr+5zdnkbsv5oNggZs4dLEOQ9KlpAkf3+FTP22M2aLaIyLwlYm7bN4cCKLuQAKIfQPVhlM41FwjY/koRB5a9rZvsNr0QEFu8ETiCAVEZyfeJofteFqw2Kdnhu/+8sDPI5EAJbdyKKTi5vooBRry9tMnEBtWdQm9cpk8fWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auW3HRp7; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3408c9a8147so1030142a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 16:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762561629; x=1763166429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kG5miPSuw5Rs6CB8PWEc2IqA42ar44NKQD4I2/IIqWk=;
        b=auW3HRp7cku/teb+fno69S4M1Nj7gUgoTZLXeI9mkcYN+9P/U9lUob16wGbIYzYU9v
         QG1whj17Ds0khf9htiqUNsAtpxAuNSDQfQFOWhfIaKDc5RpZQdsv7av2BblOR9NADXHK
         caLWRbUMSDa2VtlssnVB9NP/HUiC77+iJgBskjuz7eP3u4BQO96rjt94GMLJaorNi3OX
         uf18WkGNa0TRWxv0YlVJcAKLUeLyO2+6/ovi9VyvjyDAd8xtJoA0oKor4fKE//gA+47z
         QAfNBpd7T7loucyuniUKOYL+/YwqEvMguUauIvSA8SJwvopse+oNAMm8eu70s/JEVLEO
         Ps1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762561629; x=1763166429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG5miPSuw5Rs6CB8PWEc2IqA42ar44NKQD4I2/IIqWk=;
        b=LDQb67CtfBwJf3HzmKgR+JqPLG7miPa96QmqR8f+sZ0u/B+xkJHD8PK27ROs3WsytM
         ZZMtpzvWFPzoXRVnlklUnVYXqPnrpdMtR1c5K/S7F+CTmJ6tmpFmEb/0QjlDFQMeByxO
         39u2VU6Yz/gw5lNk1nMmv4MrCjkyAAHORUzWprP2y56E9qTCRPgVT50zcXMEWV4AbhnG
         hkoEnN0k9syfRJ5joTfsjSNSMGM6c9yiPImdnE6WS3OInkdmjZ1I6NcjN/zgoGZ4Ri+F
         ItdeZqbQJ49dd/j0TyOe8Vw5+zTkEp3Dv+yLW6m5OKY/j/BmsX84lLua4i/obL8RYC28
         KRuw==
X-Forwarded-Encrypted: i=1; AJvYcCVMZt/0qH/lJ1nz5z7ojKOx78GFKJfVi5ONF5o+lJqJIP2vPeDZpHQOQdEqIOZ2MXUsU7HuPAho1qgMlK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YS87x0GRz5K67c+mKv8fcaR9bhrWYTmBgioPlYnDntwFZgeV
	iw3UaVmo4F+JFG1YUqW5kJCUMKJAmUhjSIAEbDwKqfw0kgQM9EGp+Rj1
X-Gm-Gg: ASbGncstXzUzGb9M9OZkiYhD1bK/OKRNhpE79NLK4TcKdhEhwJaENA0M07rCELjrkgn
	wi1WOu57b/p2mHXJF6pnPPVfYnFkvxpSb30uPxc0pYZ95PzgrDfmkVHXn3zkYb6qOdDPxMqOQRl
	JHxwuUxG5di3Zp32S0Z/WEGLAZvePWwLgHu9BNGeUMnRu+ynrSO6uRHy/DoEyx7FCltgieOzySH
	azG1iNBZYeVSQFzli4BPEz2PaaFe2E8AVsv+349krcRdyKLAr0aFVNEDyDUpaQQYh1mnPmoyf+o
	+FZWnzd41vfrdjFyOpWYbqTQ3YSRSiroS+LYHHRSsY3pyMSjhRK4HmMA+5SxOlDHUvVuJVdIaFZ
	MudMH5GWXaKe7+db5u212ss3Re25vOAKUHcXDtiI61aMrB6AeeueugE2RnaJsofAGxDmXb5oWKy
	eV5iEE9RupaX+X8+YpyCCIt6y0
X-Google-Smtp-Source: AGHT+IFYh6Icg0EsDUkk0iv9+UX1uahfIBAE45SWjta9kQQGahHqJkoX07VOkXJhC6aD8UWJ+UueaA==
X-Received: by 2002:a17:90b:3a92:b0:340:5b6a:5ba9 with SMTP id 98e67ed59e1d1-34353674a9amr4628492a91.11.1762561628964;
        Fri, 07 Nov 2025 16:27:08 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:1876:baf8:5e3a:d95b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68ce9e9sm10243237a91.9.2025.11.07.16.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 16:27:08 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
Subject: [PATCH] fs/nsfs: skip dropping active refs on initial namespaces
Date: Sat,  8 Nov 2025 05:56:58 +0530
Message-ID: <20251108002658.44272-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initial namespaces are statically allocated and exist for the entire
lifetime of the system. They should not participate in active
reference counting.

When setns() is called with a file descriptor pointing to an initial
namespace, nsproxy_ns_active_put() was dropping active references on
them, causing the active count to hit zero and trigger a warning.

Fix by checking is_initial_namespace() before dropping the active
reference in nsproxy_ns_active_put().

Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
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


