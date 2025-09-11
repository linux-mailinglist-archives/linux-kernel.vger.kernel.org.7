Return-Path: <linux-kernel+bounces-812237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F25B534D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4750B7B34C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3495A338F30;
	Thu, 11 Sep 2025 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="IUOCQuQN"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A78335BAC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599659; cv=pass; b=Lp9jvnRJrmLDFKUYboCAZy8K2fVQP5hFgO/gBL2zcs3oZexVgfcUrtiISMzGMvj6W71Jb7jlfSvtCagU3oPpW2nbCycaQKmSekedQ9f1a7ek2JvBY2/aVtld2ca2ueJ6ucbxhZBq1EuFXBK9mFbcm+eWT04p74A/qDzDt01XGcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599659; c=relaxed/simple;
	bh=cIkV7AkIFz+EB8sehB84jMlaU/ssUx+ypzwXlejkCl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOu0Vk9ISCSDoj1b51yVf0P4O9RJ9cqTtqfS3M7v9kJPzlHTA4F/IFrLXMJ8iQYfsQL7DaCZOxtoD4wrM3vaUEAfqGpJFpyB/pjwxLsaKxsOC+AEzz4y/nAGaesAQI1AWYP2ujs1haNtVEawv6PKpvwGbHyQQC5rW202lKuUb4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=IUOCQuQN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757599634; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S04N+GkCJ1MHG20sbm/3ruuj5bbE1dYDgAvuScXITqVIqi/I9qoDW1Dlv3RGpnxRWJCx3kQ1DLtNFuxOKf8GfCvrrH97AZWdTA7IDIZhJ95aYLN/SNEY38yjINkOl6bF7SKJmX0RIBDG/BJhZmjbinFvoYC2Y0OIlOfRhAUclCs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757599634; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=maQDhni1KuOzHozNIUlJWn4AVUDYhTZ9mYfJ6K46ZKM=; 
	b=Y30vzkFsSITll5YcHoq3PyH8Ak6HFRx7aqR4VLPkF6tD6C45IqzB8TB6NipUWXtb8lDJZDCVA2gsbuhpGBBVDiX1pSeFtdODUJu5b4asq7Yy57SlwceOxwdfyMbBO43AK5yR4kIDaSaOh0QY8H8Vb2EKBPYC+YgjhXP3nX9Cbck=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757599634;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=maQDhni1KuOzHozNIUlJWn4AVUDYhTZ9mYfJ6K46ZKM=;
	b=IUOCQuQN5S2n93moiJDqHSih0iXU2QiWgtb8F9UPba90HEd6E6suqy+hrqbGKjJ1
	xfElXUZm6JHWyCoIn8a7F2TlDDIFQswTQVPwClHEuKNfz6gYAbr4n7HQajpkXACjbQa
	J4KSM/DlMsc1g6etOjW6w1nuDXODoUO3dWW0ynA8=
Received: by mx.zohomail.com with SMTPS id 1757599632046725.3637611709158;
	Thu, 11 Sep 2025 07:07:12 -0700 (PDT)
Date: Thu, 11 Sep 2025 15:07:07 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com, Rob Herring <robh@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2 4/4] drm/panfrost: Display list of device JM contexts
 over debugfs
Message-ID: <ocdqnyqu2xgkc4fcnjbpb4gzcoaqlzp532id22p6lqsyyewaz5@hsa7bnwgirri>
References: <20250904001054.147465-1-adrian.larumbe@collabora.com>
 <20250904001054.147465-5-adrian.larumbe@collabora.com>
 <5a6d3ffe-1edd-4082-ad7a-85256ececa86@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a6d3ffe-1edd-4082-ad7a-85256ececa86@arm.com>

On 10.09.2025 16:42, Steven Price wrote:
> On 04/09/2025 01:08, Adrián Larumbe wrote:
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> >
> > For DebugFS builds, create a filesystem knob that, for every single open
> > file of the Panfrost DRM device, shows its command name information and
> > PID (when applicable), and all of its existing JM contexts.
> >
> > For every context, show its priority and job config.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_drv.c | 97 +++++++++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 02f704ec4961..b3d14b887da4 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -712,6 +712,48 @@ static int panthor_gems_show(struct seq_file *m, void *data)
> >  	return 0;
> >  }
> >
> > +static void show_panfrost_jm_ctx(struct panfrost_jm_ctx *jm_ctx, u32 handle,
> > +				 struct seq_file *m)
> > +{
> > +	struct drm_device *ddev = ((struct drm_info_node *)m->private)->minor->dev;
> > +	const char *prio = NULL;
> > +
> > +	static const char * const prios[] = {
> > +		[DRM_SCHED_PRIORITY_HIGH] = "HIGH",
> > +		[DRM_SCHED_PRIORITY_NORMAL] = "NORMAL",
> > +		[DRM_SCHED_PRIORITY_LOW] = "LOW",
> > +	};
> > +
> > +	if (jm_ctx->slots[0].sched_entity.priority !=
> > +	    jm_ctx->slots[1].sched_entity.priority)
> > +		drm_warn(ddev, "Slot priorities should be the same in a single context");
> > +
> > +	if (jm_ctx->slots[0].sched_entity.priority < ARRAY_SIZE(prios))
> > +		prio = prios[jm_ctx->slots[0].sched_entity.priority];
> > +
> > +	seq_printf(m, " JM context %u: priority %s config %x\n",
> > +		   handle, prio ? prio : "UNKNOWN", jm_ctx->config);
>
> NIT: If you assign prio to "UNKNOWN" to begin with (rather than NULL)
> you can avoid this ?: operator.

Acked.

> > +}
> > +
> > +static int show_file_jm_ctxs(struct panfrost_file_priv *pfile,
> > +			     struct seq_file *m)
> > +{
> > +	struct panfrost_jm_ctx *jm_ctx;
> > +	unsigned long i;
> > +
> > +	xa_lock(&pfile->jm_ctxs);
> > +	xa_for_each(&pfile->jm_ctxs, i, jm_ctx) {
> > +		jm_ctx = panfrost_jm_ctx_get(jm_ctx);
> > +		xa_unlock(&pfile->jm_ctxs);
> > +		show_panfrost_jm_ctx(jm_ctx, i, m);
> > +		panfrost_jm_ctx_put(jm_ctx);
> > +		xa_lock(&pfile->jm_ctxs);
> > +	}
> > +	xa_unlock(&pfile->jm_ctxs);
>
> Is it so bad if we just held the xa lock for the whole loop? It just
> seems unnecessarily complex.

xa_unlock() is defined as a spinlock which are fast. I'm often of the view that the
critical region should be as narrow as possible, especially when debug code is clashing
with the normal operation of the driver.

> Thanks,
> Steve
>
> > +
> > +	return 0;
> > +}
> > +
> >  static struct drm_info_list panthor_debugfs_list[] = {
> >  	{"gems", panthor_gems_show, 0, NULL},
> >  };
> > @@ -725,9 +767,64 @@ static int panthor_gems_debugfs_init(struct drm_minor *minor)
> >  	return 0;
> >  }
> >
> > +static int show_each_file(struct seq_file *m, void *arg)
> > +{
> > +	struct drm_info_node *node = (struct drm_info_node *)m->private;
> > +	struct drm_device *ddev = node->minor->dev;
> > +	int (*show)(struct panfrost_file_priv *, struct seq_file *) =
> > +		node->info_ent->data;
> > +	struct drm_file *file;
> > +	int ret;
> > +
> > +	ret = mutex_lock_interruptible(&ddev->filelist_mutex);
> > +	if (ret)
> > +		return ret;
> > +
> > +	list_for_each_entry(file, &ddev->filelist, lhead) {
> > +		struct task_struct *task;
> > +		struct panfrost_file_priv *pfile = file->driver_priv;
> > +		struct pid *pid;
> > +
> > +		/*
> > +		 * Although we have a valid reference on file->pid, that does
> > +		 * not guarantee that the task_struct who called get_pid() is
> > +		 * still alive (e.g. get_pid(current) => fork() => exit()).
> > +		 * Therefore, we need to protect this ->comm access using RCU.
> > +		 */
> > +		rcu_read_lock();
> > +		pid = rcu_dereference(file->pid);
> > +		task = pid_task(pid, PIDTYPE_TGID);
> > +		seq_printf(m, "client_id %8llu pid %8d command %s:\n",
> > +			   file->client_id, pid_nr(pid),
> > +			   task ? task->comm : "<unknown>");
> > +		rcu_read_unlock();
> > +
> > +		ret = show(pfile, m);
> > +		if (ret < 0)
> > +			break;
> > +
> > +		seq_puts(m, "\n");
> > +	}
> > +
> > +	mutex_unlock(&ddev->filelist_mutex);
> > +	return ret;
> > +}
> > +
> > +static struct drm_info_list panfrost_sched_debugfs_list[] = {
> > +	{ "sched_ctxs", show_each_file, 0, show_file_jm_ctxs },
> > +};
> > +
> > +static void panfrost_sched_debugfs_init(struct drm_minor *minor)
> > +{
> > +	drm_debugfs_create_files(panfrost_sched_debugfs_list,
> > +				 ARRAY_SIZE(panfrost_sched_debugfs_list),
> > +				 minor->debugfs_root, minor);
> > +}
> > +
> >  static void panfrost_debugfs_init(struct drm_minor *minor)
> >  {
> >  	panthor_gems_debugfs_init(minor);
> > +	panfrost_sched_debugfs_init(minor);
> >  }
> >  #endif
> >

Adrian Larumbe

