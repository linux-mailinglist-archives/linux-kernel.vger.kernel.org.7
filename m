Return-Path: <linux-kernel+bounces-789160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A6EB391C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CFE161C26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216042690C0;
	Thu, 28 Aug 2025 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="e5wKqVPi"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEFF25D1EE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756348542; cv=pass; b=djPW5D/WGv9Q7PJplIyJm8DXxt3Dy43J+3IWaKA4BKtLfYP95Ao2dzOf0F4iFcTPbpbY1ugmW3Kg08ay0dfMpxamYzMy7NlmxXMdWuxhsu+ihapQz4mgznMvhtjHPe68flE0+qywH1IbnEZEdSGBro9m37XHUAXAUg2un4JQOFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756348542; c=relaxed/simple;
	bh=tYltz7helLksfswpqxgC4xZJWWPlD8KezNZ8jFQaIPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCQLBCHVbNdJnwKfefDpXAXPPxvJKvevSxRTviZwaFzDKAXe94laRf/VaP+bzCYeppswdSlFQ1NxCnXmCBlL4eTd1QRwqJ+AuDxWJD36r3rzWF1pAT8J/us1RnAZqwLEC/EegJVPMxfx2PbSwasS1AcCvvn0k0pS9Uu6ZryhTUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=e5wKqVPi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756348521; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DA4N4aH5+wWrP1LP3Sif2/kVsTYDQSSvvojqVC86fVK9a04jv+5tfToFYB+ffWoRMDRYiQ49vCWeHX0JjNUCh+V4smqEmb2or0BAAh3+ADTaNPTxAUbXLQFa5uh80lcmELhLXJCbWrdX9fEH6v8Uakb5ZKJ/aEJH9NFY8taHxFI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756348521; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V1Uvfctiz0Q3YCABen6cOD/xIWF8r6drJ7x0TI0+0eA=; 
	b=S3FZxUVoZDTFqDYWBPw2CJGd4N+MbxYYRRsHmdOwjWKhjnqOsB13SCmn229+IDz9xr1f39JBmjlUEkKvbUX7GdIIGeo2wt8OTIVbDc+Xf9UbOiC3vOyR3pO0gHMBiFTuX8TF9qc0jKB6U3uTjeXE5R7up6wQqogLxFQagl6qg7Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756348521;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=V1Uvfctiz0Q3YCABen6cOD/xIWF8r6drJ7x0TI0+0eA=;
	b=e5wKqVPiGOL9qx/mvTMxmh/x1KqDz9tkR9F5adZB9Kmu4VnMtBflfIK47DsTGJRC
	KeryRSEJHSaUbCcnxdH6fikEElOpLUR69tmmDglxVdfgYZuSPxoWMMOolEyoXhgSnKd
	TU3pdGiqg1ELi5lbcjVU2AK8YHEeernREV1uoQSo=
Received: by mx.zohomail.com with SMTPS id 1756348518972966.8106728089455;
	Wed, 27 Aug 2025 19:35:18 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 5/5] drm/panfrost: Display list of device JM contexts over debugfs
Date: Thu, 28 Aug 2025 03:34:08 +0100
Message-ID: <20250828023422.2404784-6-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250828023422.2404784-1-adrian.larumbe@collabora.com>
References: <20250828023422.2404784-1-adrian.larumbe@collabora.com>
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

For every context, show also register values that a UM tool could decode
back into a mask of L2 caches, tiling units and shader cores which jobs
submitted under that context can use.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 101 ++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index b54cdd589ec4..3ba43180ca8d 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -713,6 +713,52 @@ static int panthor_gems_show(struct seq_file *m, void *data)
 	return 0;
 }
 
+static void show_panfrost_jm_ctx(struct panfrost_jm_ctx *jm_ctx, u32 handle,
+				 struct seq_file *m)
+{
+	static const char * const prios[] = {
+		[DRM_SCHED_PRIORITY_HIGH] = "HIGH",
+		[DRM_SCHED_PRIORITY_NORMAL] = "NORMAL",
+		[DRM_SCHED_PRIORITY_LOW] = "LOW",
+	};
+
+	seq_printf(m, " JM context %u:\n", handle);
+
+	for (u32 i = 0; i < ARRAY_SIZE(jm_ctx->slots); i++) {
+		const struct panfrost_js_ctx *slot = &jm_ctx->slots[i];
+		const char *prio = NULL;
+
+		if (!slot->enabled)
+			continue;
+
+		if (slot->sched_entity.priority < ARRAY_SIZE(prios))
+			prio = prios[slot->sched_entity.priority];
+
+		seq_printf(m, "  slot %u: priority %s config %x affinity %llx xaffinity %x\n",
+			   i, prio ? prio : "UNKNOWN", slot->config,
+			   slot->affinity, slot->xaffinity);
+	}
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
@@ -726,9 +772,64 @@ static int panthor_gems_debugfs_init(struct drm_minor *minor)
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


