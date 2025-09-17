Return-Path: <linux-kernel+bounces-820461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F405AB7E5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCDC523436
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3076A362089;
	Wed, 17 Sep 2025 10:17:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C54B35FC0C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104270; cv=none; b=Kql/3ROwPImd24TrIRssiHwprbsOrZpp6f01FCoveqjmE61MxRYXY4bQcb9d9l8tTP+qMzoP6x+cqF7CBMZX0s9hL7GpuodoiqlEDTeZ0qPU2wr/UWlLUI06AfQmi9NrTp2MFyn5t1RacT85Ys8L8FUNFXGcUPPV+w3kSp15yLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104270; c=relaxed/simple;
	bh=tyr03bBVg+b/i2kanomA+83S7sxETsprQa/C9KU1mqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwSsohURs8rDazhJoeAMwdY57nkDqdW9o4VVLI6ykgxWOei5leiTNNgpLMpjUBE4qi6jIr54aJcJu/piVm+t9eUZtXRyi1RZ6Sul7BvzywYBNZASZVOev5U+/qPVRrCRizBTwg2hdE1ZcBqIMlnQRmFFVWL3bQYGBfxypcgj0jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7300425DC;
	Wed, 17 Sep 2025 03:17:40 -0700 (PDT)
Received: from [10.1.26.46] (e122027.cambridge.arm.com [10.1.26.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 742723F673;
	Wed, 17 Sep 2025 03:17:46 -0700 (PDT)
Message-ID: <b96c0c8d-579c-4b86-938f-fe0870d4b7ad@arm.com>
Date: Wed, 17 Sep 2025 11:17:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] drm/panfrost: Display list of device JM contexts
 over debugfs
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250912132002.304187-1-adrian.larumbe@collabora.com>
 <20250912132002.304187-5-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250912132002.304187-5-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/09/2025 14:19, Adrián Larumbe wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> For DebugFS builds, create a filesystem knob that, for every single open
> file of the Panfrost DRM device, shows its command name information and
> PID (when applicable), and all of its existing JM contexts.
> 
> For every context, show the DRM scheduler priority value of all of its
> scheduling entities.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 96 +++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 69e72a800cd1..3af4b4753ca4 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -716,6 +716,47 @@ static int panthor_gems_show(struct seq_file *m, void *data)
>  	return 0;
>  }
>  
> +static void show_panfrost_jm_ctx(struct panfrost_jm_ctx *jm_ctx, u32 handle,
> +				 struct seq_file *m)
> +{
> +	struct drm_device *ddev = ((struct drm_info_node *)m->private)->minor->dev;
> +	const char *prio = "UNKNOWN";
> +
> +	static const char * const prios[] = {
> +		[DRM_SCHED_PRIORITY_HIGH] = "HIGH",
> +		[DRM_SCHED_PRIORITY_NORMAL] = "NORMAL",
> +		[DRM_SCHED_PRIORITY_LOW] = "LOW",
> +	};
> +
> +	if (jm_ctx->slot_entity[0].priority !=
> +	    jm_ctx->slot_entity[1].priority)
> +		drm_warn(ddev, "Slot priorities should be the same in a single context");
> +
> +	if (jm_ctx->slot_entity[0].priority < ARRAY_SIZE(prios))
> +		prio = prios[jm_ctx->slot_entity[0].priority];
> +
> +	seq_printf(m, " JM context %u: priority %s\n", handle, prio);
> +}
> +
> +static int show_file_jm_ctxs(struct panfrost_file_priv *pfile,
> +			     struct seq_file *m)
> +{
> +	struct panfrost_jm_ctx *jm_ctx;
> +	unsigned long i;
> +
> +	xa_lock(&pfile->jm_ctxs);
> +	xa_for_each(&pfile->jm_ctxs, i, jm_ctx) {
> +		jm_ctx = panfrost_jm_ctx_get(jm_ctx);
> +		xa_unlock(&pfile->jm_ctxs);
> +		show_panfrost_jm_ctx(jm_ctx, i, m);
> +		panfrost_jm_ctx_put(jm_ctx);
> +		xa_lock(&pfile->jm_ctxs);
> +	}
> +	xa_unlock(&pfile->jm_ctxs);
> +
> +	return 0;
> +}
> +
>  static struct drm_info_list panthor_debugfs_list[] = {
>  	{"gems", panthor_gems_show, 0, NULL},
>  };
> @@ -729,9 +770,64 @@ static int panthor_gems_debugfs_init(struct drm_minor *minor)
>  	return 0;
>  }
>  
> +static int show_each_file(struct seq_file *m, void *arg)
> +{
> +	struct drm_info_node *node = (struct drm_info_node *)m->private;
> +	struct drm_device *ddev = node->minor->dev;
> +	int (*show)(struct panfrost_file_priv *, struct seq_file *) =
> +		node->info_ent->data;
> +	struct drm_file *file;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ddev->filelist_mutex);
> +	if (ret)
> +		return ret;
> +
> +	list_for_each_entry(file, &ddev->filelist, lhead) {
> +		struct task_struct *task;
> +		struct panfrost_file_priv *pfile = file->driver_priv;
> +		struct pid *pid;
> +
> +		/*
> +		 * Although we have a valid reference on file->pid, that does
> +		 * not guarantee that the task_struct who called get_pid() is
> +		 * still alive (e.g. get_pid(current) => fork() => exit()).
> +		 * Therefore, we need to protect this ->comm access using RCU.
> +		 */
> +		rcu_read_lock();
> +		pid = rcu_dereference(file->pid);
> +		task = pid_task(pid, PIDTYPE_TGID);
> +		seq_printf(m, "client_id %8llu pid %8d command %s:\n",
> +			   file->client_id, pid_nr(pid),
> +			   task ? task->comm : "<unknown>");
> +		rcu_read_unlock();
> +
> +		ret = show(pfile, m);
> +		if (ret < 0)
> +			break;
> +
> +		seq_puts(m, "\n");
> +	}
> +
> +	mutex_unlock(&ddev->filelist_mutex);
> +	return ret;
> +}
> +
> +static struct drm_info_list panfrost_sched_debugfs_list[] = {
> +	{ "sched_ctxs", show_each_file, 0, show_file_jm_ctxs },
> +};
> +
> +static void panfrost_sched_debugfs_init(struct drm_minor *minor)
> +{
> +	drm_debugfs_create_files(panfrost_sched_debugfs_list,
> +				 ARRAY_SIZE(panfrost_sched_debugfs_list),
> +				 minor->debugfs_root, minor);
> +}
> +
>  static void panfrost_debugfs_init(struct drm_minor *minor)
>  {
>  	panthor_gems_debugfs_init(minor);
> +	panfrost_sched_debugfs_init(minor);
>  }
>  #endif
>  


