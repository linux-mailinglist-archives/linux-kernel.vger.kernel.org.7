Return-Path: <linux-kernel+bounces-732211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C349B0637C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200D25810A2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F3424729A;
	Tue, 15 Jul 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqwdHfpY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6D225792
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594776; cv=none; b=AMEW07q+KajEXgQ4G+Q5sVgT5N5SnMGTU2n8vNGgik6P4vclf5+jQFiSwwJN0U0gi+K3mi4d559bGMVFxQL/jGSxjhnr6MgxCCegqn0JnioV58gMkzePcOBPFqZM1RAVTd9mG4iLWCQeC6Ehd8BOYCXcdkfyl894nPW7t7oEOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594776; c=relaxed/simple;
	bh=uDfrJF/drcy35q3gMp74bx+UGibPNfQDLes/+Jl9AVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBxCdG7cYhwLfz8qHv8AAC12kWM+npup5/PmLnit7TWmEiMEXHGlDH8DNnbqAlZmAnck4h98tPGKCfut5Vjup11KMT0a9gFTHTvxz6HGbehckwVnIP4IiscTKRYEGEGbGLnm22vTWVZpzGhLfcMXGmczs7KU/iE0w51edfCOm80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqwdHfpY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752594773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGVgaXIwZocM9TTdAix5oncCbiNFuNiHnVvJ4UMFQXE=;
	b=DqwdHfpYMXM07dUV6WZm9xxGbpR61jYlYtOLLreyisGapECC/CvTX09YFZc5/sJM3ktxrg
	DJLkiajmJstRNoOY8YZm5vOC6PgtHiXxY9JtB7rr9CcUGu7UCQauu5p7SLRplV3UYCyGhy
	q84kUPlwEAJinnZjFaWmRlTo2RS03u0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-FiVvo9b0PVi-K9HWF5Frog-1; Tue, 15 Jul 2025 11:52:52 -0400
X-MC-Unique: FiVvo9b0PVi-K9HWF5Frog-1
X-Mimecast-MFC-AGG-ID: FiVvo9b0PVi-K9HWF5Frog_1752594771
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-606ee65164fso6187241a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594771; x=1753199571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGVgaXIwZocM9TTdAix5oncCbiNFuNiHnVvJ4UMFQXE=;
        b=phBN/J/lS3uL8/LBwKn3YFg3Z5jwmqR98JTlaOLehYN+4lAAik+ytBxvFlsU5UXCps
         nKlfPwehu1LqoPs0iEweZb5aDYYboiSYKT99sNa0jpSAmQ1yrjFenqPXuJxz/acfXPd4
         KYljY5qsNlwbLD5U6ex5fJyIYcHlh/TaoiGKyERx85ACsNEiM24PvanfF+wUccTD7wxg
         2K6RDff7AaB4Y6N01GAzsQW/2ZnP98qQoSxz2JqBoYOgUnfYo6EcOFh9lFksgdnaWwvd
         pF3C/jjCgRrVROqelbejNOlnum1L1C0FVCGlgDB9DntrKNQ3qqQNVM6NeTi3y1tXvwZn
         ceaw==
X-Forwarded-Encrypted: i=1; AJvYcCUP7ed5b7LYoAPtmyhIC4D3/ADUNXx4i3mONR4VOVZ7CUPIunOkvYhVDg03hUoMoFl/CzkIzmiSZDhu+Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzknULFH6gZ6Ex5XU5Yygg/d3rVMJZ5IyheR+6IGesRtNujaPy+
	IDn5r/o/bLD9jQoG65eT4sazn/xKU+BtGh5Cvh+gh8Zua8c8G+PVfWgR4m9/hZJ16Lme1fYkzsL
	5s5PSd/d7CkVlCIpExSZ1IWWrVmi6rnQviWSyFi/RZRT9ZIZZdZAFHBYuBjlspPCtX89OuuV/O7
	2ApsMEvT1+Sr6MQEdDHACq+S7Tgb0RwPNlkFDQ0N0q
X-Gm-Gg: ASbGncv8Nzqx0ej62S8ZOOSTkBy4x7LK/dkUDpHy7nbfY9jieWriEWNwg6OzIyf1W9L
	dQzD4xHPBdCuDG2lxJ9+AF9kAmIi4eCOE4P7HDVAJF7ogP02PqtVQAp87Jr5pl8+rbhnJx5dRCM
	OP/z35p+29PE4ImlhjTN2f6A==
X-Received: by 2002:a17:906:c115:b0:ad5:2e5b:d16b with SMTP id a640c23a62f3a-ae6fbe3d07emr2002470766b.27.1752594771118;
        Tue, 15 Jul 2025 08:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUS6HiH3OZ7t7wywPZ+i8XtYq8L6TxhaGYbPlDaYTLcxgd1/uZaFKuIjLPtsvr7tm1eM8MCwXkgLfvRdsAGGY=
X-Received: by 2002:a17:906:c115:b0:ad5:2e5b:d16b with SMTP id
 a640c23a62f3a-ae6fbe3d07emr2002466666b.27.1752594770666; Tue, 15 Jul 2025
 08:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714071333.59794-1-lulu@redhat.com>
In-Reply-To: <20250714071333.59794-1-lulu@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 15 Jul 2025 23:52:12 +0800
X-Gm-Features: Ac12FXwfXi0jx38BKdlRwU2IFKU-jNFpCJwwxM4OKirTaJ-ZKXvGTV-e0aBSlEs
Message-ID: <CAPpAL=w8GQypO4gFv6vgO0YDNPLLQ-4JuEKyp9oHP8WiATWOmQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/1]vhost: Add support of kthread API
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	sgarzare@redhat.com, nicolas.dichtel@6wind.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Mon, Jul 14, 2025 at 3:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> In commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads"),
> the vhost now uses vhost_task and operates as a child of the
> owner thread. This aligns with containerization principles.
> However, this change has caused confusion for some legacy
> userspace applications. Therefore, we are reintroducing
> support for the kthread API.
>
> In this series, a new UAPI is implemented to allow
> userspace applications to configure their thread mode.
>
> Changelog v2:
>  1. Change the module_param's name to enforce_inherit_owner, and the defa=
ult value is true.
>  2. Change the UAPI's name to VHOST_SET_INHERIT_FROM_OWNER.
>
> Changelog v3:
>  1. Change the module_param's name to inherit_owner_default, and the defa=
ult value is true.
>  2. Add a structure for task function; the worker will select a different=
 mode based on the value inherit_owner.
>  3. device will have their own inherit_owner in struct vhost_dev
>  4. Address other comments
>
> Changelog v4:
>  1. remove the module_param, only keep the UAPI
>  2. remove the structure for task function; change to use the function po=
inter in vhost_worker
>  3. fix the issue in vhost_worker_create and vhost_dev_ioctl
>  4. Address other comments
>
> Changelog v5:
>  1. Change wakeup and stop function pointers in struct vhost_worker to vo=
id.
>  2. merging patches 4, 5, 6 in a single patch
>  3. Fix spelling issues and address other comments.
>
> Changelog v6:
>  1. move the check of VHOST_NEW_WORKER from vhost_scsi to vhost
>  2. Change the ioctl name VHOST_SET_INHERIT_FROM_OWNER to VHOST_FORK_FROM=
_OWNER
>  3. reuse the function __vhost_worker_flush
>  4. use a ops sturct to support worker relates function
>  5. reset the value of inherit_owner in vhost_dev_reset_owner.
>
> Changelog v7:
>  1. add a KConfig knob to disable legacy app support
>  2. Split the changes into two patches to separately introduce the ops an=
d add kthread support.
>  3. Utilized INX_MAX to avoid modifications in __vhost_worker_flush
>  4. Rebased on the latest kernel
>  5. Address other comments
>
> Changelog v8:
>  1. Rebased on the latest kernel
>  2. Address some other comments
>
> Changelog v9:
>  1. Rebased on the latest kernel.
>  2. Squashed patches 6=E2=80=917.
>  3. Squashed patches 2=E2=80=914.
>  4. Minor fixes in commit log
>
>
> Changelog v10:
>  1.Add support for the module_param.
>  2.Squash patches 3 and 4.
>  3.Make minor fixes in the commit log.
>  4.Fix the mismatched tabs in Kconfig.
>  5.Rebase on the latest kernel.
>
> Changelog v11:
>  1.make the module_param under Kconfig
>  2.Make minor fixes in the commit log.
>  3.change the name inherit_owner to fork_owner
>  4.add NEW ioctl VHOST_GET_FORK_FROM_OWNER
>  5.Rebase on the latest kernel
>
> Changelog v12:
> 1.Squash all patches to 1.
> 2.Add define for task mode and kthread mode
> 3.Address some other comments
> 4.Rebase on the latest kernel
>
> Changelog v13:
>  1.enable the kconfig by default
>  2.Rebase on the latest kernel
>
> Tested with QEMU with kthread mode/task mode/kthread+task mode
>
> Cindy Lu (1):
>   vhost: Reintroduces support of kthread API and adds mode selection
>
>  drivers/vhost/Kconfig      |  18 +++
>  drivers/vhost/vhost.c      | 244 ++++++++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h      |  22 ++++
>  include/uapi/linux/vhost.h |  29 +++++
>  4 files changed, 295 insertions(+), 18 deletions(-)
>
> --
> 2.45.0
>
>


