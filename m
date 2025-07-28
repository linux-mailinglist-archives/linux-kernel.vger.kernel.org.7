Return-Path: <linux-kernel+bounces-747471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35872B13438
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52EC3AB263
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFA122127D;
	Mon, 28 Jul 2025 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkbJbE3c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E1F220F29
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753681071; cv=none; b=SQtVO1mCg/ZigZkm7gQnVqUwHzIinGg2R8k7QcGmrPfjNyN+KtfO4si56aGtEYIzrSFSD6s3Qi7srV11wqFzoKBB5gcmSycxS5VcydhXM+F5/KcaDW23OiBVwcKuLfaKWkhpZE0Aafpwm44AqS0rrj/nPZNekNExKLGywpfHwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753681071; c=relaxed/simple;
	bh=F6+QWuSBv4x0flC5kCOLgZCDZBDLrrJSNad59jJWIXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2gOy+eVefjY/q8WLzEcmFpci/1K1wObwUyVupkSLEziRBm3joDciQbf/BreMhvvG9kxo04U+xWbiJ262j/oImm0hQlZxX2AL9G8WpPnifh179NcWC+/1tjwAbfcMNePqUPDqsXPv/5qPFitiRanphCfL4OCUXchZsQ/QbUkrHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkbJbE3c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753681068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3ZcHukYN2mERp1bM6H5ADsDeN+lEekE5S6YNzRDaYg=;
	b=AkbJbE3c29U7fglk28WJpwF34hsrYQ7Rlv6+oiQFnY9nbf1aFOecoE6mstdm9kcicxusjw
	86cQMg6g8ij81PlOulY6QprQV68Y8ClSrNNdqcYZf5aDFhQ7lHI8P9teVlaMJWDqlIafsa
	BgFLP/F3MoGBiFrn+ePPMxo7rBy7uOI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-n7S0DHcyN_CFXiFTfKin-g-1; Mon, 28 Jul 2025 01:37:46 -0400
X-MC-Unique: n7S0DHcyN_CFXiFTfKin-g-1
X-Mimecast-MFC-AGG-ID: n7S0DHcyN_CFXiFTfKin-g_1753681065
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-553ea44a706so2206482e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 22:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753681065; x=1754285865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3ZcHukYN2mERp1bM6H5ADsDeN+lEekE5S6YNzRDaYg=;
        b=Xs2lFjZqgsS4/3CRzLubjQsk1R7wLV5G6AAuzOUY3Fitl2sBokOC/9FHWUIxzO73Z1
         FMk62DMJFU91DknJjeGQD9iS82jd8JgKePM6tJv9YjxOKRhCDWPTyDVtCCcncNonf1bC
         Oi6Wj6xLzncatoj0PLMlHzXYXV5k0FGDbA69WshMyjOIAPf0FiyxJz7l/nFjDg40tLDc
         dFqykUo586//Q9Un/fzn/YdzlU63Jc8CgAF8uUXNXo9/ebcTqGgz4yH4buMw6GZsSNM4
         hbaKhEehiDUUBv368AMNdzsUWClD/mv/vTm0X6Lxwf5ZZOPefw8+4T5bUBV7lSug6c3o
         yvQw==
X-Forwarded-Encrypted: i=1; AJvYcCUBZ2loXhPVBL0RS8bZE5z6C6w1GCRgzx+W376DwNWBt8nGXSN9FatJ5useUySGziZJGbBpLGtieSaoOy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Hm3GL0CN4JlB8l3TnJg1Y0YiV4EGvL6UZlenyzlSizvPO4y2
	6xDPTwzKIQ8yewxflL1+MKahgtevINWOim31YB8k+p5uEoYl3vKRs9ugj4dThPHOA4FJh5uWqVR
	6qYSdhOyBVhYfs9cqAv+r58i5WZ349IKeTScOYA5x/Ju2AlGb+8rQ2QRTU9Th3ew7XWhzztE7J+
	CYe/yGVt9SR2WvmmHswA+tqNfXun+h3/PHyAchho9J
X-Gm-Gg: ASbGncsD3a7AFAJ+A4mPFiU/tiPlYqYTgFTMk9Y9hXQyCYpdW1m+yMdP+6TrqkDg28x
	NAgrT3s9hzxSSr+6haA24dTmdzFRVo78BETkn365tAiKde2yAOH0PgSNVe/yTrHn9TReSnij/kf
	clTUFrFAJ/LUeRYRJem4hIjQ==
X-Received: by 2002:a05:6512:3b27:b0:553:2311:e1f6 with SMTP id 2adb3069b0e04-55b5f5108e1mr2258759e87.49.1753681065129;
        Sun, 27 Jul 2025 22:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI50RUEgVEsbUPURKdr+Af1xURU2ypwa5U8DXHcP3qcvjYhyT8ZEOIfYPgmUHjIs80WfcHSAg+EtTcDwffmoI=
X-Received: by 2002:a05:6512:3b27:b0:553:2311:e1f6 with SMTP id
 2adb3069b0e04-55b5f5108e1mr2258750e87.49.1753681064683; Sun, 27 Jul 2025
 22:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707012711.376844-1-yukuai1@huaweicloud.com>
In-Reply-To: <20250707012711.376844-1-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 28 Jul 2025 13:37:32 +0800
X-Gm-Features: Ac12FXySLN7PhCOHMXZw9NiWDQhg8QHeiGJTOKoWSPWjL40hTbHCR75P9KZGKo0
Message-ID: <CALTww2_nfqeoR+h6rLCtCvr3Gh-b-tqpDhg4QimaZcC9AbUsnA@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] md/md-bitmap: introduce CONFIG_MD_BITMAP
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, 
	yukuai3@huawei.com, dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	johnny.chenyi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 9:36=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v5:
>  - rebase on the top of md-6.17;
>  - fix compile problem if md-mod is build as module;
>  - fix two problems for lvm2 dm-raid tests, patch 5,13
>  - other cleanups;
> Changes in v4:
>  - rebase on the top of other patchset;
> Changes in v3:
>  - update commit message.
> Changes in v2:
>  - don't export apis, and don't support build md-bitmap as module
>
> Due to known performance issues with md-bitmap and the unreasonable
> implementations like following:
>
>  - self-managed pages, bitmap_storage->filemap;
>  - self-managed IO submitting like filemap_write_page();
>  - global spin_lock
>  ...
>
> I have decided not to continue optimizing based on the current bitmap
> implementation, and plan to invent a new lock-less bitmap. And a new
> kconfig option is a good way for isolation.
>
> However, we still encourage anyone who wants to continue optimizing the
> current implementation
>
> Yu Kuai (15):
>   md/raid1: change r1conf->r1bio_pool to a pointer type
>   md/raid1: remove struct pool_info and related code
>   md/md-bitmap: remove the parameter 'init' for bitmap_ops->resize()
>   md/md-bitmap: merge md_bitmap_group into bitmap_operations
>   md/md-bitmap: add a new parameter 'flush' to bitmap_ops->enabled
>   md/md-bitmap: add md_bitmap_registered/enabled() helper
>   md/md-bitmap: handle the case bitmap is not enabled before
>     start_sync()
>   md/md-bitmap: handle the case bitmap is not enabled before end_sync()
>   md/raid1: check bitmap before behind write
>   md/raid1: check before referencing mddev->bitmap_ops
>   md/raid10: check before referencing mddev->bitmap_ops
>   md/raid5: check before referencing mddev->bitmap_ops
>   md/dm-raid: check before referencing mddev->bitmap_ops
>   md: check before referencing mddev->bitmap_ops
>   md/md-bitmap: introduce CONFIG_MD_BITMAP
>
>  drivers/md/Kconfig      |  18 +++++
>  drivers/md/Makefile     |   3 +-
>  drivers/md/dm-raid.c    |  18 +++--
>  drivers/md/md-bitmap.c  |  74 +++++++++---------
>  drivers/md/md-bitmap.h  |  62 ++++++++++++++-
>  drivers/md/md-cluster.c |   2 +-
>  drivers/md/md.c         | 112 +++++++++++++++++++--------
>  drivers/md/md.h         |   4 +-
>  drivers/md/raid1-10.c   |   2 +-
>  drivers/md/raid1.c      | 163 +++++++++++++++++++---------------------
>  drivers/md/raid1.h      |  22 +-----
>  drivers/md/raid10.c     |  49 ++++++------
>  drivers/md/raid5.c      |  30 ++++----
>  13 files changed, 330 insertions(+), 229 deletions(-)
>
> --
> 2.39.2
>
>

The patch set looks good to me.
Reviewed-by: Xiao Ni <xni@redhat.com>


