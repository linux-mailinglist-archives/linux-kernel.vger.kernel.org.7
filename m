Return-Path: <linux-kernel+bounces-797896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06CEB416E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8ED56230B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D772DC336;
	Wed,  3 Sep 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T3zh0VnF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CB52DAFDB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885123; cv=none; b=mfS7XkE9ZZNVwTClfC5FLwSe/zomIXHkUTAvtqf664dpjgTOpx3WGPdw5OSBBXo5a0Mij7HlHmQQT7DCakwaMRxbCRr655JXMi1giYWxDpfaEmY/E3sjd9bZ8mKt3zM1KrN1uIn2sVmai0n2A+q8Vup8tRLCJQcbftbThPf9L54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885123; c=relaxed/simple;
	bh=tZTXQxWwKhwN7jw5tzK0Ue7qocHvPKjlnWGYpV0Me8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpwTjD1WWUxHghdHLH5rmFr96PNo2wUMqVZvecRDwFv9sRVk1+A0wpZ9r9n0KeSEXr5B7lyeh9tq1cWdokmXRTP22FgI5MZd6C0qsMBcwODmPXx+TY7oWDbp0qDWpS17mcKR10wpet8DLUnQLZUJce2hjSP7/e5bfzYXN3J2RrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T3zh0VnF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756885119;
	bh=tZTXQxWwKhwN7jw5tzK0Ue7qocHvPKjlnWGYpV0Me8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T3zh0VnFyxUt5qDeWtB3yrsh6og81xQSURljjfiNhPwKFC6WvpyNtL55Qm9CHAzl8
	 6PXXQLrCOVQpWFx7D5v9gGQx/t62+vdEecSCvD8vOHP8kRfAXnPmZ3WdMab/QoZuza
	 mOXU0NFgq7l3Fw2R9/PMSprmXxkEkrVrJVliLP0v4j6OoLtKhWStCme+XOiloQsFCu
	 TNEGoqnFxuTLj581hz2UczTllJHScJN0b2/V4ntabMGtn0bogXrA2yXfLtRx735AgX
	 zj9wdpBo5dBoJxM5AllvtfuVgD6/LK2QkonwLlK4nBiYWpBPoQE8lfpnecX1MkV7zM
	 qbYApZN4SZEDw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4A28E17E0FAD;
	Wed,  3 Sep 2025 09:38:39 +0200 (CEST)
Date: Wed, 3 Sep 2025 09:38:35 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: validate group queue count
Message-ID: <20250903093835.69763656@fedora>
In-Reply-To: <20250902192001.409738-1-olvaffe@gmail.com>
References: <20250902192001.409738-1-olvaffe@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Sep 2025 12:20:01 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> A panthor group can have at most MAX_CS_PER_CSG panthor queues.
> 
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>

With a proper Fixes tag, this is

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index ba5dc3e443d9c..249ab889ca91f 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3473,6 +3473,9 @@ int panthor_group_create(struct panthor_file *pfile,
>  	    hweight64(group_args->tiler_core_mask) < group_args->max_tiler_cores)
>  		return -EINVAL;
>  
> +	if (group_args->queues.count > MAX_CS_PER_CSG)
> +		return -EINVAL;
> +
>  	group = kzalloc(sizeof(*group), GFP_KERNEL);
>  	if (!group)
>  		return -ENOMEM;


