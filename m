Return-Path: <linux-kernel+bounces-735521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBF3B09077
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19E9565D51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A782F85C8;
	Thu, 17 Jul 2025 15:24:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355C32E54B0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765859; cv=none; b=ZHB0SdEQv926+mKG2n/Ai8KLaVZJ4ZMwvjOowSl8QnIi33DuNTh2Xjj25v+ZSRxWns1nkGu0G0RwRpzwLIApppq0D0YzfQRaisCILbhF98lFQ8MoDocswgTDqwDRHALs6sVLqhUxZPbY+n4ZEg/EDtGSV2C6CS2vqR28feotN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765859; c=relaxed/simple;
	bh=h4AmLH1kSUoa4yF+cOEbNjcKh0ywmflw8HfVm6nVG6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LqBjQTpphh6zJ66UA7lARpaa1MV61fKXgogrKhDtPvWDCTxhTyMwBTrEoTGjft6ubMHL3VrzYG3dzwA6vUAG39g794/WXRTeVPdSMqnyVuloEcb/xhk8SAhRR1YZ0P+XMbgPTC7lh8l9IgiDOxTcXxCDkoVmcn0iWMlN0VGbVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8B201596;
	Thu, 17 Jul 2025 08:24:08 -0700 (PDT)
Received: from [10.1.28.24] (e122027.cambridge.arm.com [10.1.28.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42F383F694;
	Thu, 17 Jul 2025 08:24:14 -0700 (PDT)
Message-ID: <2aee25e2-b9cd-4f86-80dd-9d9881c036c8@arm.com>
Date: Thu, 17 Jul 2025 16:24:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] panthor: save task pid and comm in panthor_group
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250713030831.3227607-1-olvaffe@gmail.com>
 <20250713030831.3227607-3-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250713030831.3227607-3-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/07/2025 04:08, Chia-I Wu wrote:
> We would like to report them on gpu errors.
> 
> We choose to save the info on panthor_group_create rather than on
> panthor_open because, when the two differ, we are more interested in the
> task that created the group.
> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

One nit below, but with that fixed:

Reviewed-by: Steven Price <steven.price@arm.com>

> 
> ---
> v2: save to panthor_group on panthor_group_create rather than to
>     panthor_file on panthor_open
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index a2248f692a030..823b0fe678ba6 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -641,6 +641,15 @@ struct panthor_group {
>  		size_t kbo_sizes;
>  	} fdinfo;
>  
> +	/** @task_info: Info of current->group_leader that created the group. */
> +	struct {
> +		/** @pid: pid of current->group_leader */
> +		pid_t pid;
> +
> +		/** @comm: comm of current->group_leader */
> +		char comm[TASK_COMM_LEN];

As the kernel test robot reports, this kerneldoc isn't quite right.
We've got other issues in this file but you need to specify the struct
name as well, i.e.:

		/** @task_info.pid: pid of current->group_leader */
		pid_t pid;

		/** @task_info.comm: comm of current->group_leader */
		char comm[TASK_COMM_LEN];

It's been on my TODO list for a while to fix the rest of the file...

Thanks,
Steve

> +	} task_info;
> +
>  	/** @state: Group state. */
>  	enum panthor_group_state state;
>  
> @@ -3389,6 +3398,14 @@ group_create_queue(struct panthor_group *group,
>  	return ERR_PTR(ret);
>  }
>  
> +static void group_init_task_info(struct panthor_group *group)
> +{
> +	struct task_struct *task = current->group_leader;
> +
> +	group->task_info.pid = task->pid;
> +	get_task_comm(group->task_info.comm, task);
> +}
> +
>  static void add_group_kbo_sizes(struct panthor_device *ptdev,
>  				struct panthor_group *group)
>  {
> @@ -3540,6 +3557,8 @@ int panthor_group_create(struct panthor_file *pfile,
>  	add_group_kbo_sizes(group->ptdev, group);
>  	spin_lock_init(&group->fdinfo.lock);
>  
> +	group_init_task_info(group);
> +
>  	return gid;
>  
>  err_put_group:


