Return-Path: <linux-kernel+bounces-729677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33CBB03A33
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84AA1892982
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8BA1E5B63;
	Mon, 14 Jul 2025 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYWi1OzG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572102E36FA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483652; cv=none; b=STybiTD/2laX0LKbouxrajMDwuUM8cw/f0yrTAlyojflCJWXCEbGs4YaQ8FYQX6s221897fJJ1IzLxcHOWs/cgcnrQPsis4mdYowcAGTLw8sHS4H3yoSL1Y7PkXuvt5lkMy1Zaqj7XdmBMBweR/ZzGUUy1FMnxu+5xue9oxQ27U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483652; c=relaxed/simple;
	bh=mgUDPjZfKZa4G5TIciK9/J9/wH6rVN2rBsxLUWKBevY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONiZ7T7BomJ67Jpg0wOkq923GRcxgAu62nnUQ53Ngg5v63g2jTx4Zlx31yRFeDqvvBv8WwxmlaJ9lftXvrdQhxQvJlRr+gS9sjCBuEk25UOcRk8/lKmj/+eB25RwAhhOdszr4FN9g7BYF1gVVAcDsWaC4s5puRgMBX96jQIIDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYWi1OzG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752483649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1hfYx9ZwZj4hBpAy8/cg2qpm4pcvgWdnVuUSnuOWl4=;
	b=YYWi1OzGUpGWhMfm2ij5wm7DfKYL0AitIeLbiOR47WfKAaBUqAYbjcgm0MQgbOH1scCE5w
	Guil95oKt9gkweI0NGHX+DE1eG+4AoBAhqRuO9BeB3lq5XF84GKX1k/FkWkEMS4HULH5JF
	U1DRwMGV23GjYU3RqJqp+itJIDfmxW8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-ae7aF5KHO2CLUqYH7osQAg-1; Mon, 14 Jul 2025 05:00:47 -0400
X-MC-Unique: ae7aF5KHO2CLUqYH7osQAg-1
X-Mimecast-MFC-AGG-ID: ae7aF5KHO2CLUqYH7osQAg_1752483646
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so3964227a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752483646; x=1753088446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1hfYx9ZwZj4hBpAy8/cg2qpm4pcvgWdnVuUSnuOWl4=;
        b=IcKnGzv33wdMjoIZ+QPIFJsZE3SPXwkScg3yY9D1eIgOHuBU9NrBIa+d8ykWJw2h/o
         DvlTpE6zaNaR+HjiUqqogXvl9Q3DQ34CXo+JodXGe7y3tDtad+I3+VIWaVxUF6GY68MO
         DdtKBSDCTymWKUOWLJKaBLVWBPZcjZnScFfQWgUf/rNvzmx/Y1IefDSK2OHLlB66ErVV
         pg1ApFwUPsCq5vxjV4oDu6eYZIZMp5+pDdl9gDPOuyRvBmOXYye7pwq5zsrDtZ7n4Cy4
         HU6ZK/3GhiLiRgE3JGDcyH9xdTetGOjyBDo8fEp8XMzoUBSHEXJ/b/He8aJot3vwAJzO
         1jnw==
X-Forwarded-Encrypted: i=1; AJvYcCXJGhP6FVizqj5of2olSCOLGFO2kAFRZZY75fWEpc5JtB3su86/HDFr8RW0/St0yOER5uTjykzy0ABkGu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6LACfxlljP0eRBd7l1Nnxu/AJOUBcY5Cw6jMUCaPeIWIB/13g
	ZJL5PMdy+9tDZhydk7e18OMuWZ5zJ8mET8H0DiCHtwqCcZPyZsT5RTVscBVgYglhIZl5D88p4Db
	oTVeVfxuy1ZOoUKm6YeJQIOB0I6EtVIaqcWUfBg7zeshxtn+LYepVOrtIcNbVOQHqUs+DWz/v0U
	Fz8GkuwL9FR/MdPZ0XxeRRSlaF43vsFfjcyoU3IFlD
X-Gm-Gg: ASbGnctoe4m2jseNvnWq6lAKLkToYSjxSXR4zSVVy6KagmWpt9ql+sZ2MCGezSHfhpm
	peMlxHivgqR8UyP/ydC4rEfThSR/WaxfDEN4GAc7Jo/zTmQWKbu7+gNYF9m3y8BVJWku8036vZ2
	DjQ1EUHbnNZ81Nr0HXJvKs
X-Received: by 2002:a17:90b:53cf:b0:316:d69d:49fb with SMTP id 98e67ed59e1d1-31c50d7d8f1mr18861236a91.14.1752483646103;
        Mon, 14 Jul 2025 02:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGmwObCrw3ZPJj5iTr+8ypnXO+J2rzWfd0zziuhsozvF6QIIc7otsdISgHmrMpxbdLho7DGBk9swnY1mKvrb0=
X-Received: by 2002:a17:90b:53cf:b0:316:d69d:49fb with SMTP id
 98e67ed59e1d1-31c50d7d8f1mr18861150a91.14.1752483645431; Mon, 14 Jul 2025
 02:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708120424.2363354-2-dtatulea@nvidia.com>
In-Reply-To: <20250708120424.2363354-2-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Jul 2025 17:00:34 +0800
X-Gm-Features: Ac12FXwl-ocfICA8zhC134L0X2ymLv9PbV5b5AvM1WXy9lL495bG-qYY-il049g
Message-ID: <CACGkMEufuXdLKXx9GuEOnBnREz622f=FVt-0r3UBNUKWz_Q78g@mail.gmail.com>
Subject: Re: [PATCH vhost] vdpa/mlx5: Fix release of uninitialized resources
 on error path
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Wenli Quan <wquan@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 8:05=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> The commit in the fixes tag made sure that mlx5_vdpa_free()
> is the single entrypoint for removing the vdpa device resources
> added in mlx5_vdpa_dev_add(), even in the cleanup path of
> mlx5_vdpa_dev_add().
>
> This means that all functions from mlx5_vdpa_free() should be able to
> handle uninitialized resources. This was not the case though:
> mlx5_vdpa_destroy_mr_resources() and mlx5_cmd_cleanup_async_ctx()
> were not able to do so. This caused the splat below when adding
> a vdpa device without a MAC address.
>
> This patch fixes these remaining issues:
>
> - Makes mlx5_vdpa_destroy_mr_resources() return early if called on
>   uninitialized resources.
>
> - Moves mlx5_cmd_init_async_ctx() early on during device addition
>   because it can't fail. This means that mlx5_cmd_cleanup_async_ctx()
>   also can't fail. To mirror this, move the call site of
>   mlx5_cmd_cleanup_async_ctx() in mlx5_vdpa_free().
>
> An additional comment was added in mlx5_vdpa_free() to document
> the expectations of functions called from this context.
>
> Splat:
>
>   mlx5_core 0000:b5:03.2: mlx5_vdpa_dev_add:3950:(pid 2306) warning: No m=
ac address provisioned?
>   ------------[ cut here ]------------
>   WARNING: CPU: 13 PID: 2306 at kernel/workqueue.c:4207 __flush_work+0x9a=
/0xb0
>   [...]
>   Call Trace:
>    <TASK>
>    ? __try_to_del_timer_sync+0x61/0x90
>    ? __timer_delete_sync+0x2b/0x40
>    mlx5_vdpa_destroy_mr_resources+0x1c/0x40 [mlx5_vdpa]
>    mlx5_vdpa_free+0x45/0x160 [mlx5_vdpa]
>    vdpa_release_dev+0x1e/0x50 [vdpa]
>    device_release+0x31/0x90
>    kobject_cleanup+0x37/0x130
>    mlx5_vdpa_dev_add+0x327/0x890 [mlx5_vdpa]
>    vdpa_nl_cmd_dev_add_set_doit+0x2c1/0x4d0 [vdpa]
>    genl_family_rcv_msg_doit+0xd8/0x130
>    genl_family_rcv_msg+0x14b/0x220
>    ? __pfx_vdpa_nl_cmd_dev_add_set_doit+0x10/0x10 [vdpa]
>    genl_rcv_msg+0x47/0xa0
>    ? __pfx_genl_rcv_msg+0x10/0x10
>    netlink_rcv_skb+0x53/0x100
>    genl_rcv+0x24/0x40
>    netlink_unicast+0x27b/0x3b0
>    netlink_sendmsg+0x1f7/0x430
>    __sys_sendto+0x1fa/0x210
>    ? ___pte_offset_map+0x17/0x160
>    ? next_uptodate_folio+0x85/0x2b0
>    ? percpu_counter_add_batch+0x51/0x90
>    ? filemap_map_pages+0x515/0x660
>    __x64_sys_sendto+0x20/0x30
>    do_syscall_64+0x7b/0x2c0
>    ? do_read_fault+0x108/0x220
>    ? do_pte_missing+0x14a/0x3e0
>    ? __handle_mm_fault+0x321/0x730
>    ? count_memcg_events+0x13f/0x180
>    ? handle_mm_fault+0x1fb/0x2d0
>    ? do_user_addr_fault+0x20c/0x700
>    ? syscall_exit_work+0x104/0x140
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   RIP: 0033:0x7f0c25b0feca
>   [...]
>   ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Fixes: 83e445e64f48 ("vdpa/mlx5: Fix error path during device add")
> Reported-by: Wenli Quan <wquan@redhat.com>
> Closes: https://lore.kernel.org/virtualization/CADZSLS0r78HhZAStBaN1evCSo=
PqRJU95Lt8AqZNJ6+wwYQ6vPQ@mail.gmail.com/
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


