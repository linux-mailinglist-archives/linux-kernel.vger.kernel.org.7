Return-Path: <linux-kernel+bounces-856362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C34BE3FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D80B1A6472E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E113451A0;
	Thu, 16 Oct 2025 14:47:05 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EE3161AB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626025; cv=none; b=pQbGkOM1LU6hMmpOyziY43l14TYiXfbGpPcvztdIJjqRRU8gaPiN8+eGJN5reUg68GuINu4Bz7y/jStbW5djgPPnRdCBVPEr9GPGpTuxmEiIy1wMKlNa+nFxuRODGmJm5ZY867rNe8OtOqDiBWWI4KrS1RL1sO9HSrXsBBZd1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626025; c=relaxed/simple;
	bh=udG4u+C2ZRYoWfcR0oorTmw5eUGfOQlVhzCX6e7sXHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akKqfefMZrse/Fz+fCFTBpxZKAZFHONu3nBgiGZYUyj54ojECxjo/1Bh5lkoBGU4y5HVTDXd7UDp+oas2Wsn4cZcvqqyGJDRGHmZUw3+fBmLZnbhp3KWh7DZrVetV5cH7ATjTsjS+iGf7qu1rexTFdbUOO2EmFD9W5h2kY+pajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7b00927607eso585793a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626022; x=1761230822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBHn6CsGRDAUCK2Z49Yacln3ofSUz8trsXQy6V4TvmY=;
        b=I7oBaMcKnWAm3Y6W4V7rMex9RbR9Rr/BxCxCILzGlrZ/AF4CVytz5TV2uGqmXkUJG3
         IWIU4FD7XTMBAdFP8uKxCHKtQRKk/8L+gPTEFq4EmTzfR4cRBagPIxj+/rZMVUr+DTbp
         XDsLZmZHMpEb0g4hponQeANWjQ7H/G5rBfUchdCXTLx5UgbWjUOjbgW9Vh4pD7G/8lWC
         2w8XgS3fx1dlxK99wQmDCvFe+URgze9EtXMxl+jkLvMEiuW2PLZnG+syO2D/YZSOjS83
         dPkXpr9uMZYp7M+sZhZT0DCuZz8nV7y6069C1GGqjlnxvfFZEzB6NKXzjKXbiRY0VFf7
         D4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVuGlaWTq9jfZTu9bnreJYcJYVTCG2TQXuYT914e80l1qmH8Dzak7ilJwiV1ClJgO4/WimFMT0Sh+ySmWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7IuwKrYcGt8AMAhxxS7E7DkDD5rfRjQqqpU+1xMBt92/tdHV
	MSZ8dpYd4uIiNb00dsM5fEBc6V9oQPHifGN0joNmZy1w7QL596F2lxvG
X-Gm-Gg: ASbGncuYsLLSZxAB4jSO95tY/DTbMPzKGD3B4eXsraI6EmtcyiaWasAy0A8G8GdY359
	V8JlAT5HOwSrcYokqZYqypaoZqjxRoeKNuKvzTFwPlv16eld6wksJx6o9SQhYFiBEVjvEaICcas
	4oHocVY+NpWd0n/EmF6xT3t4wNzqpJPBdrcN2ONdgh400+HnoE5B9zpvEFrDUodQHDtdYQPs73p
	3KOA8iXbN3lvwmYCmIiBCwB34bmxKsQL6H0OlPjbOzNX260VZjdWLxbscpuUwn9FRM386S6QFtl
	V0aWukEteP/Zxp3C1CUFCTXt9v5/521hS75a4VsJGobt7GdLaIrxz5FsQHpgxnRiBH6uQ2wlUx7
	7TX4lXDRYBZBPKLZ4QhwWwpBEb36f9GZXKbKgtz9ab4rt2w/YhcbqrVKNL+HCyTl7thCmMbVTrj
	sIsU3LIY+YpeW9EL/B5DijpzAnfp6wkB1pnOciMp3PzEAPQdxgL2mKCpywqjaXD5IeVh0=
X-Google-Smtp-Source: AGHT+IFDXse00m2TWPZi7Thsyfiz1q30tLZZikOylS+Gewam/P4dv7Cstc52U+FEl+CdZhH12tCOWg==
X-Received: by 2002:a05:6808:1514:b0:43f:6f82:e16f with SMTP id 5614622812f47-443a2dd8597mr136457b6e.12.1760626022395;
        Thu, 16 Oct 2025 07:47:02 -0700 (PDT)
Received: from localhost.localdomain (syn-067-079-108-173.biz.spectrum.com. [67.79.108.173])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441cc812f24sm3678018b6e.12.2025.10.16.07.47.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 07:47:02 -0700 (PDT)
From: Jonathan Perry <yonch@yonch.com>
To: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	James Morse <james.morse@arm.com>,
	Roman Storozhenko <romeusmeister@gmail.com>,
	Jonathan Perry <yonch@yonch.com>
Subject: [PATCH 1/8] resctrl: Pin rdtgroup for mon_data file lifetime
Date: Thu, 16 Oct 2025 09:46:49 -0500
Message-ID: <20251016144656.74928-2-yonch@yonch.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251016144656.74928-1-yonch@yonch.com>
References: <20251016144656.74928-1-yonch@yonch.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add .open and .release handlers to mon_data kernfs files so a
monitoring file holds a reference to its rdtgroup for the file's
lifetime. Store the rdtgroup in of->priv on open and drop it on
release. Provide rdtgroup_get()/rdtgroup_put() helpers.

This lets code that only has an open monitoring fd (e.g. the resctrl
PMU event_init path) safely resolve the rdtgroup without having a
kernfs active reference.

No functional change intended.

Signed-off-by: Jonathan Perry <yonch@yonch.com>
---
 fs/resctrl/internal.h |  2 ++
 fs/resctrl/rdtgroup.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index cf1fd82dc5a9..63fb4d6c21a7 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -360,6 +360,8 @@ void resctrl_mon_resource_exit(void);
 void mon_event_count(void *info);
 
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
+int rdtgroup_mondata_open(struct kernfs_open_file *of);
+void rdtgroup_mondata_release(struct kernfs_open_file *of);
 
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 0320360cd7a6..17b61dcfad07 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -332,6 +332,8 @@ static const struct kernfs_ops rdtgroup_kf_single_ops = {
 static const struct kernfs_ops kf_mondata_ops = {
 	.atomic_write_len	= PAGE_SIZE,
 	.seq_show		= rdtgroup_mondata_show,
+	.open			= rdtgroup_mondata_open,
+	.release		= rdtgroup_mondata_release,
 };
 
 static bool is_cpu_list(struct kernfs_open_file *of)
@@ -2512,12 +2514,26 @@ static struct rdtgroup *kernfs_to_rdtgroup(struct kernfs_node *kn)
 	}
 }
 
+/*
+ * Convert an kernfs active reference to an rdtgroup reference.
+ */
 static void rdtgroup_kn_get(struct rdtgroup *rdtgrp, struct kernfs_node *kn)
 {
 	atomic_inc(&rdtgrp->waitcount);
 	kernfs_break_active_protection(kn);
 }
 
+/*
+ * Get rdtgroup reference count from existing reference
+ */
+void rdtgroup_get(struct rdtgroup *rdtgrp)
+{
+	atomic_inc(&rdtgrp->waitcount);
+}
+
+/*
+ * Decrement rdtgroup reference count, when converted from kernfs active ref
+ */
 static void rdtgroup_kn_put(struct rdtgroup *rdtgrp, struct kernfs_node *kn)
 {
 	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
@@ -2532,6 +2548,20 @@ static void rdtgroup_kn_put(struct rdtgroup *rdtgrp, struct kernfs_node *kn)
 	}
 }
 
+/*
+ * Decrement rdtgroup reference count
+ */
+void rdtgroup_put(struct rdtgroup *rdtgrp)
+{
+	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
+	    (rdtgrp->flags & RDT_DELETED)) {
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
+			rdtgroup_pseudo_lock_remove(rdtgrp);
+		rdtgroup_remove(rdtgrp);
+	}
+}
+
 struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn)
 {
 	struct rdtgroup *rdtgrp = kernfs_to_rdtgroup(kn);
@@ -3364,6 +3394,38 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 	return ret;
 }
 
+int rdtgroup_mondata_open(struct kernfs_open_file *of)
+{
+	struct rdtgroup *rdtgrp;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+
+	/*
+	 * resctrl relies an kernfs active references to guard access to struct
+	 * rdtgroup from kernfs_open_file. Hold a reference in the file
+	 * descriptor so perf_event_open() can retrieve the rdtgroup.
+	 */
+	rdtgroup_get(rdtgrp);
+	of->priv = rdtgrp;
+
+	rdtgroup_kn_unlock(of->kn);
+	return 0;
+}
+
+void rdtgroup_mondata_release(struct kernfs_open_file *of)
+{
+	struct rdtgroup *rdtgrp = of->priv;
+
+	if (rdtgrp) {
+		rdtgroup_put(rdtgrp);
+		of->priv = NULL;
+	}
+}
+
 /**
  * cbm_ensure_valid - Enforce validity on provided CBM
  * @_val:	Candidate CBM

