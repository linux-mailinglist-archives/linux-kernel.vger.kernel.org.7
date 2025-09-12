Return-Path: <linux-kernel+bounces-814106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453A0B54F51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90498A03272
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0DD30DD2F;
	Fri, 12 Sep 2025 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="SmcFqHkj"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6730E830
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683274; cv=pass; b=qD4raaoX18b3/gVL6KGmkNdmIa2b5kx3/E/T+5Mx2Gsqt1ICS4Yi6uU5EpTYxaf3sJZH4M5oyGZJOHcwhWq2Xytvnl23GppRMtLrzT6Q5z7LM+gvpzToGO61ZrE8W19BWAG4ooUF1UGvEEeeAMafSYOrqlFqQmN7PDXqMcRUAOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683274; c=relaxed/simple;
	bh=vANVE3yEo/9J2Ey6SepBrkgp5W/9CHBa1mCPShTcGvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBh6JrFtxBKBUfadIZhtyCYrOVd707Eb++2lcDQ+/m/4JvVB1c/93HEINEP/uepuV6yxnEmySSt2NZX76+4GJvuosZt4bGCYNWJeMWpKVuaPIIzrU1mo0wl5eBZTyaTV/LHGca4+QAsyVwjPOyohSc2f3pRIQovCBwKwdv23504=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=SmcFqHkj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757683254; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Vupd7knCn63PGIIHUgXKCjJlDIiYN89yDUiUh2tmMCMQibCi5CWUlntOLvtpnhQOeCR/giFnca1tER7YZQSMy3tNwRHVLvAjYBJvPsd4i5IYm7HYG6RiCU6Qt8fkHgF95HGXTeL6x8iGY8eQTnZNzdlFlcxTgl/FTrvozbphJlo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757683254; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h217uFWDE0/F/zg4UcKuO8ozv8PHMLfmxNZacXWPJis=; 
	b=NZdzgBX75lIrkFGfu6TXIc5hop2Nm7FwgnjCsGNGNFyVLnXVlFPnGWTNWdecrfaOBoQed5she+y+8kFHmSieVkiAUNbhdTYSkAwH7mGCPyZdHg1NtopasD35Zrp2TkJg3lIy+utpExcjLGGjDAP8v/jupEnqngfy+nq+ofMESiE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757683254;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=h217uFWDE0/F/zg4UcKuO8ozv8PHMLfmxNZacXWPJis=;
	b=SmcFqHkjDahVW06UlAHZi4FWcWxiQOEYZJosk9SJlK6WRstuQgmYOTm70q1ufkAQ
	ImE+mm4p5SgsOpF16w0GfsKgMwz2kQlMEFL8PmMZRZ0arwAuCMGPk0ElvF662hXmgXM
	9TBxK3Jt3xeYt0D9YY8eUyZpqBKLQVCSU9gYNkBo=
Received: by mx.zohomail.com with SMTPS id 1757683252196687.443307080734;
	Fri, 12 Sep 2025 06:20:52 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v3 4/4] drm/panfrost: Display list of device JM contexts over debugfs
Date: Fri, 12 Sep 2025 14:19:15 +0100
Message-ID: <20250912132002.304187-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912132002.304187-1-adrian.larumbe@collabora.com>
References: <20250912132002.304187-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Boris Brezillon <boris.brezillon@collabora.com>

For DebugFS builds, create a filesystem knob that, for every single open
file of the Panfrost DRM device, shows its command name information and
PID (when applicable), and all of its existing JM contexts.

For every context, show the DRM scheduler priority value of all of its
scheduling entities.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 96 +++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 69e72a800cd1..3af4b4753ca4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -716,6 +716,47 @@ static int panthor_gems_show(struct seq_file *m, void *data)
 	return 0;
 }
 
+static void show_panfrost_jm_ctx(struct panfrost_jm_ctx *jm_ctx, u32 handle,
+				 struct seq_file *m)
+{
+	struct drm_device *ddev = ((struct drm_info_node *)m->private)->minor->dev;
+	const char *prio = "UNKNOWN";
+
+	static const char * const prios[] = {
+		[DRM_SCHED_PRIORITY_HIGH] = "HIGH",
+		[DRM_SCHED_PRIORITY_NORMAL] = "NORMAL",
+		[DRM_SCHED_PRIORITY_LOW] = "LOW",
+	};
+
+	if (jm_ctx->slot_entity[0].priority !=
+	    jm_ctx->slot_entity[1].priority)
+		drm_warn(ddev, "Slot priorities should be the same in a single context");
+
+	if (jm_ctx->slot_entity[0].priority < ARRAY_SIZE(prios))
+		prio = prios[jm_ctx->slot_entity[0].priority];
+
+	seq_printf(m, " JM context %u: priority %s\n", handle, prio);
+}
+
+static int show_file_jm_ctxs(struct panfrost_file_priv *pfile,
+			     struct seq_file *m)
+{
+	struct panfrost_jm_ctx *jm_ctx;
+	unsigned long i;
+
+	xa_lock(&pfile->jm_ctxs);
+	xa_for_each(&pfile->jm_ctxs, i, jm_ctx) {
+		jm_ctx = panfrost_jm_ctx_get(jm_ctx);
+		xa_unlock(&pfile->jm_ctxs);
+		show_panfrost_jm_ctx(jm_ctx, i, m);
+		panfrost_jm_ctx_put(jm_ctx);
+		xa_lock(&pfile->jm_ctxs);
+	}
+	xa_unlock(&pfile->jm_ctxs);
+
+	return 0;
+}
+
 static struct drm_info_list panthor_debugfs_list[] = {
 	{"gems", panthor_gems_show, 0, NULL},
 };
@@ -729,9 +770,64 @@ static int panthor_gems_debugfs_init(struct drm_minor *minor)
 	return 0;
 }
 
+static int show_each_file(struct seq_file *m, void *arg)
+{
+	struct drm_info_node *node = (struct drm_info_node *)m->private;
+	struct drm_device *ddev = node->minor->dev;
+	int (*show)(struct panfrost_file_priv *, struct seq_file *) =
+		node->info_ent->data;
+	struct drm_file *file;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ddev->filelist_mutex);
+	if (ret)
+		return ret;
+
+	list_for_each_entry(file, &ddev->filelist, lhead) {
+		struct task_struct *task;
+		struct panfrost_file_priv *pfile = file->driver_priv;
+		struct pid *pid;
+
+		/*
+		 * Although we have a valid reference on file->pid, that does
+		 * not guarantee that the task_struct who called get_pid() is
+		 * still alive (e.g. get_pid(current) => fork() => exit()).
+		 * Therefore, we need to protect this ->comm access using RCU.
+		 */
+		rcu_read_lock();
+		pid = rcu_dereference(file->pid);
+		task = pid_task(pid, PIDTYPE_TGID);
+		seq_printf(m, "client_id %8llu pid %8d command %s:\n",
+			   file->client_id, pid_nr(pid),
+			   task ? task->comm : "<unknown>");
+		rcu_read_unlock();
+
+		ret = show(pfile, m);
+		if (ret < 0)
+			break;
+
+		seq_puts(m, "\n");
+	}
+
+	mutex_unlock(&ddev->filelist_mutex);
+	return ret;
+}
+
+static struct drm_info_list panfrost_sched_debugfs_list[] = {
+	{ "sched_ctxs", show_each_file, 0, show_file_jm_ctxs },
+};
+
+static void panfrost_sched_debugfs_init(struct drm_minor *minor)
+{
+	drm_debugfs_create_files(panfrost_sched_debugfs_list,
+				 ARRAY_SIZE(panfrost_sched_debugfs_list),
+				 minor->debugfs_root, minor);
+}
+
 static void panfrost_debugfs_init(struct drm_minor *minor)
 {
 	panthor_gems_debugfs_init(minor);
+	panfrost_sched_debugfs_init(minor);
 }
 #endif
 
-- 
2.51.0


