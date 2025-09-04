Return-Path: <linux-kernel+bounces-799587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AA5B42E01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098611BC858B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A722BCFB;
	Thu,  4 Sep 2025 00:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="WiXJaQ/K"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8BA7E105
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944710; cv=pass; b=TkLiFtuuFb/1NDvLJ5v5oPL2SUfKHPpXO5n2KFIHUUANagTGig8Bl3ckFZMC2aTK/fgqvmcne6O7opq05mQxAuzYZ//DxnkmXDJ80uztiBVvY8Lra80z8evozrFxc915WlMeDUyWAoGLIbnoXBxDMQ5FuQfUoEf+ZitgjkFewx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944710; c=relaxed/simple;
	bh=LYR5niPplHHZT4F8XIWGK0PekeLINkXESDzLuv2EahE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoEWAePqL2xLJcyNFn2eXSc7Wb3giyDRl+bCvCZ6SksqUxrpFHuwD5QiMl94pvTiIw5JAKjXQWTO9SeJuL984qaGzIHR5Iol3Z0eUW6g7uduMDWGFMrFcJ4AcC5FZB9v818hmoCg9urMHNepgJ3J8Gg0HxOLJwe2NStb2Xaa5kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=WiXJaQ/K; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756944691; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dV4AUTGyvRinAkdFuXGwymkMINGDBUlW2I27Qs7QLbeHO+4I2iqPD8p0zgGFGOI9tgJNXvXQnaX6DBBNA3Qj/UZlEF0ZTzZ/mWJNbv5jVZ8Ax7HMCgs7pDRs9cp6OfeOYE597RXnB/9xZXhzJn3T7yBWe77Pq+zsjh2JvWKzEEA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756944691; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5wZ1ENmfjHXSQxn+q8xC1jThTBGhlczGmoVc1ZzZpEQ=; 
	b=RfAkSEtv/l1eFaUiWSj/XG4eHkhTZdxB8T+q8kdD9JkaBiFpl2XB27Ck+Negm8gY/OTNjcfOWGy8NE+65l/SZ0qH+Vvw6gn66psyDB8ERbUjPB4OBKUM/FmglJOfaqfc6T1UWUgxOCToMH2wGN9HgV8EoEw/fIBKNbLq1QVQ9u4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756944691;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5wZ1ENmfjHXSQxn+q8xC1jThTBGhlczGmoVc1ZzZpEQ=;
	b=WiXJaQ/KHgHA45hdDilduYBZ6q21dSv4o62xU84Ir6xELF7BhwgZBtZpL2U+Uaq/
	akc6Ckz8uaHyecCURmJM//QFeo2seL+gRY6DecOSUPGcXQyVcrBzaa0Z5QDpJons4KU
	OdpT0n1lRbFzgCUvoqZgeDF14cKkaVibD22+yLJc=
Received: by mx.zohomail.com with SMTPS id 1756944687766290.4116830590775;
	Wed, 3 Sep 2025 17:11:27 -0700 (PDT)
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
Subject: [PATCH v2 4/4] drm/panfrost: Display list of device JM contexts over debugfs
Date: Thu,  4 Sep 2025 01:08:02 +0100
Message-ID: <20250904001054.147465-5-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250904001054.147465-1-adrian.larumbe@collabora.com>
References: <20250904001054.147465-1-adrian.larumbe@collabora.com>
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

For every context, show its priority and job config.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 97 +++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 02f704ec4961..b3d14b887da4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -712,6 +712,48 @@ static int panthor_gems_show(struct seq_file *m, void *data)
 	return 0;
 }
 
+static void show_panfrost_jm_ctx(struct panfrost_jm_ctx *jm_ctx, u32 handle,
+				 struct seq_file *m)
+{
+	struct drm_device *ddev = ((struct drm_info_node *)m->private)->minor->dev;
+	const char *prio = NULL;
+
+	static const char * const prios[] = {
+		[DRM_SCHED_PRIORITY_HIGH] = "HIGH",
+		[DRM_SCHED_PRIORITY_NORMAL] = "NORMAL",
+		[DRM_SCHED_PRIORITY_LOW] = "LOW",
+	};
+
+	if (jm_ctx->slots[0].sched_entity.priority !=
+	    jm_ctx->slots[1].sched_entity.priority)
+		drm_warn(ddev, "Slot priorities should be the same in a single context");
+
+	if (jm_ctx->slots[0].sched_entity.priority < ARRAY_SIZE(prios))
+		prio = prios[jm_ctx->slots[0].sched_entity.priority];
+
+	seq_printf(m, " JM context %u: priority %s config %x\n",
+		   handle, prio ? prio : "UNKNOWN", jm_ctx->config);
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
@@ -725,9 +767,64 @@ static int panthor_gems_debugfs_init(struct drm_minor *minor)
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
2.50.0


