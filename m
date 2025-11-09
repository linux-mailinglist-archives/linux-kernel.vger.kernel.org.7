Return-Path: <linux-kernel+bounces-891855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9BDC43A92
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 10:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3718A3B08EA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 09:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CBA2874FA;
	Sun,  9 Nov 2025 09:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTYuFzoG"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900E71A23AC
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762680223; cv=none; b=LQKil+BWb6dfCAVy2AIuKY/1uOGEJlYWTb6u937rC+/sqz4NBXmWGCV2DdlQ9iB/N7uhwDqxzq5ILDdZ2zuBXqmngRT4HczI5RPGyun6o9mPitxgKM9YsxIcsrG8DhOKIvbDQUCCxIcoRgQzvEYp51o5F/UNkNPyXswlVr5u90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762680223; c=relaxed/simple;
	bh=Nf9OJSzoFBzab9JdOVbXZXjzMx9QxngeU5jtC9dex+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q7EAeEW+zRPf0C/TlrTk1hktLIuGuQz2jgy6ATjL/KzPAAz/zS8M04mY8AgMt6rF6ivixM2pmC+G946LJoTK8V98i4fUzOY4mWKdnTN3/UPpCtQFMZ6Kb4ltQ1D/z/VO5VbQLxMtGYcNpMNpuTfqhZYvnqFjKUqNorWRFlKxe/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTYuFzoG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-794e300e20dso1387730b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 01:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762680221; x=1763285021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LzYIhSHQpjHTkNq1VjxolrqMRNff7igGvAKQEk3L/ds=;
        b=KTYuFzoGd6GOpIMIyuwYvVbcKYFa0xz4am1+6iUaq4GQSo6ZxSvqN++qCTMcin0SKJ
         mE1mou7EjnFjXwGW4Xrq5scU0m9H4kUJdemsu+2opu51/BjbXXWi5DMRojYAleyxSg2x
         kmvHRT1sTedS+miPI2j1bvu7YqIgsHHD7+dS4q4vZCxysspPzid7bXpZ3DO0017ML2kz
         6PiHxG8rL5JvpXQGK8eStCR6vcduWzogdQxSy7oPfGGUx/Z/x05Y+2R0QUeW5fvA05f3
         MXjdh6DpdNKCs6kkg6/A+/VuoK9AimGyggWU4vmJYUtXDazLqnAGqg19U8zRQtEKc7wu
         cS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762680221; x=1763285021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzYIhSHQpjHTkNq1VjxolrqMRNff7igGvAKQEk3L/ds=;
        b=BgYXqMvahq85UUcsOBcfdPOlYaBIBqTlFQDqfl5k5UeKB4yDu6BpLFbYLocgLynMde
         xCBwkkMnY+jwEiVDszcTAV6wKkR13nvUiwQkYWPL6bM9c2Q68DePRq0/+xjEC2ZikiWs
         FuMa1+hljCBNENORGn5sICa1724eX7yl8t9x3uor6Y0Mvk/0aHhfV/ybxnVi3wpC7bfu
         +tUVNY1DCBmmETZQu5LFxqAbyqn/onDK7RATzZUBPUSR/cQWHE7osZg0hoi8P1ve2xKP
         GWsw67CO7pzNlR0n7EjN6Sfw1vDr9g+JxEln1oykeorH9btDfKBzF7Gq8z8cIQMn1ZXz
         zrPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGDynLzJbBVW+SGieMMuWHW9LldZxIA5/VS/wXsw5/otFDCRQ32scpn8ZSW28kxVkPTmbSlnd2U56rGp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycfS1jFsmSHOLCfAH7lbvbYWkKDeI1cRe1rR4Nmv5AZZnpy7g6
	FXbGGiQutjo2Ivx5tXbhs1xqHTi5G21nUB70av7UIEBdGnD6TarOQiMT
X-Gm-Gg: ASbGncuZWg8Xged6vpJZnc8sSzVaxKKd/RPfpWc4RpB3vzDiNr+vk6nIZzYOL5qu0gx
	4LI5qdbYZZNiPJPBV3/A0AxwZud/+KANNLQe0uLm0QRIQ8wdSTyJ5HkZcxDdg4y59hQRkF56M95
	LGxSKVXaovgFq3zjmp2q8paGHCBQV+P2faLoeoB5vmtyy+bP4dASvVzocHyMGHHji+PkW4OUQ3x
	x97Z3fpt4UR1LNNmYcQUENEexrJ2X/tLIbu25bEI25ZYOjY902BpjbVEXxtlIvic8yJJDQFXlrU
	NyunfcQIg4vxQA0P3G+2ZEvABBb1tnwqTBJHtCX1h8iis/wF1KUcDnZlDcyqxSCeP8IiQopA9Ne
	ydwZLdx1ilwNBFCuKXPe4KgTkUk0sS0nFJVgECjPm8ocgtVGMGHrKxeRhHPOt2az1+FdFreURTp
	p7LEqeEmmlQcOB2fIYD9iNwPAsNjvi+iIZz4Q=
X-Google-Smtp-Source: AGHT+IGtEeSBCmQP1LD2GIbFZ40n6KeskrCS2G73TAIdxAD4Z0jA/rva/Ef0D9rdSHX2OuCvjt7hMg==
X-Received: by 2002:a17:90b:5101:b0:341:1a50:2ea9 with SMTP id 98e67ed59e1d1-343537849b3mr8539845a91.16.1762680220779;
        Sun, 09 Nov 2025 01:23:40 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:bc21:2aab:1b8c:f21a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902c9d0d4sm9221184a12.36.2025.11.09.01.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 01:23:40 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
Subject: [PATCH v2] fs/nsfs: skip active ref counting for initial namespaces
Date: Sun,  9 Nov 2025 14:53:33 +0530
Message-ID: <20251109092333.844185-1-kartikey406@gmail.com>
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

The recent introduction of active reference counting in commit
3a18f809184b ("ns: add active reference count") added functions that
unconditionally take/drop active references on all namespaces,
including initial ones.

This causes a WARN_ON_ONCE() to trigger when a namespace file for an
initial namespace is evicted:

  WARNING: ./include/linux/ns_common.h:314 at nsfs_evict+0x18e/0x200

The same pattern exists in nsproxy_ns_active_get() and
nsproxy_ns_active_put() which could trigger similar warnings when
operating on initial namespaces.

Fix by checking is_initial_namespace() before taking or dropping
active references in:
- nsfs_evict()
- nsproxy_ns_active_get()
- nsproxy_ns_active_put()

Reported-by: syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=0b2e79f91ff6579bfa5b
Fixes: 3a18f809184b ("ns: add active reference count")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/nsfs.c | 53 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index ba6c8975c82e..eb14f29dc8d3 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -19,6 +19,7 @@
 #include <linux/exportfs.h>
 #include <linux/nstree.h>
 #include <net/net_namespace.h>
+#include <linux/ns_common.h>
 
 #include "mount.h"
 #include "internal.h"
@@ -58,8 +59,8 @@ const struct dentry_operations ns_dentry_operations = {
 static void nsfs_evict(struct inode *inode)
 {
 	struct ns_common *ns = inode->i_private;
-
-	__ns_ref_active_put(ns);
+	if (!is_initial_namespace(ns))
+		__ns_ref_active_put(ns);
 	clear_inode(inode);
 	ns->ops->put(ns);
 }
@@ -686,24 +687,40 @@ void __init nsfs_init(void)
 
 void nsproxy_ns_active_get(struct nsproxy *ns)
 {
-	ns_ref_active_get(ns->mnt_ns);
-	ns_ref_active_get(ns->uts_ns);
-	ns_ref_active_get(ns->ipc_ns);
-	ns_ref_active_get(ns->pid_ns_for_children);
-	ns_ref_active_get(ns->cgroup_ns);
-	ns_ref_active_get(ns->net_ns);
-	ns_ref_active_get(ns->time_ns);
-	ns_ref_active_get(ns->time_ns_for_children);
+	if (ns->mnt_ns && !is_initial_namespace(&ns->mnt_ns->ns))
+		ns_ref_active_get(ns->mnt_ns);
+	if (ns->uts_ns && !is_initial_namespace(&ns->uts_ns->ns))
+		ns_ref_active_get(ns->uts_ns);
+	if (ns->ipc_ns && !is_initial_namespace(&ns->ipc_ns->ns))
+		ns_ref_active_get(ns->ipc_ns);
+	if (ns->pid_ns_for_children && !is_initial_namespace(&ns->pid_ns_for_children->ns))
+		ns_ref_active_get(ns->pid_ns_for_children);
+	if (ns->cgroup_ns && !is_initial_namespace(&ns->cgroup_ns->ns))
+		ns_ref_active_get(ns->cgroup_ns);
+	if (ns->net_ns && !is_initial_namespace(&ns->net_ns->ns))
+		ns_ref_active_get(ns->net_ns);
+	if (ns->time_ns && !is_initial_namespace(&ns->time_ns->ns))
+		ns_ref_active_get(ns->time_ns);
+	if (ns->time_ns_for_children && !is_initial_namespace(&ns->time_ns_for_children->ns))
+		ns_ref_active_get(ns->time_ns_for_children);
 }
 
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


