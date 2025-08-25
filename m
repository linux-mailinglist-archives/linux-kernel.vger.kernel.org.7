Return-Path: <linux-kernel+bounces-784585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCF3B33DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32D8188D109
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240442E8DE9;
	Mon, 25 Aug 2025 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/nhsFnY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68AB2E7BDD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121234; cv=none; b=YpNkH8dBc5JQ4xpm3XmuW28zFPqW94dqPTVW9IAW6S+0TtnVZbHhGe1+q1hIJ+XlaM3ftOeIbzDaor6QLs4/ucPUKBDa3NIZoFntZrmBUdUVhtfuZzSJ/Grl/ryZ0HEbzl238IIk5XpPY/LiI570ykhr6t1av5cXWD96VITHJ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121234; c=relaxed/simple;
	bh=pTHQElAElWmtrbZTXpxQVTHBHqc05mvh3lFsp+T4NEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hvmf5vPb4swQPtx1z8/YXfKxeblqKhHYysUYTTVu67KXWkkdcnONBeORz/o6IrMmd12WIQcETeBz8iqkLFfOYIgmZW3D6LVj8PFZwXy9MQTI7rn9VdYTPXLhAfx/qSGFgjEURRejWpKR9FKf6p+TfNWgVBZ1b0MVcGtIRVwsaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/nhsFnY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756121231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qDMukmH0FQggYXKvzUec4QBhOgYrZ5QeyS3SsGzawf0=;
	b=b/nhsFnY1YUvlDSJY4N776UUSQ74qxwgOlWUsYlX20jiMR3PQwEV4FAs0JlDTQSO0rQ1Vr
	eXV+xzy4S58s+xSQmnQPurs27lG2eHzvDKQEJIE0dyzk6YhPV4oM0z2NGrNDnAgwJ3s+Zt
	/R/JtTBvUJAAft2Fk2bGmrXSxu4lbto=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-ksy9xTMvNpKErS50_flMMQ-1; Mon, 25 Aug 2025 07:27:10 -0400
X-MC-Unique: ksy9xTMvNpKErS50_flMMQ-1
X-Mimecast-MFC-AGG-ID: ksy9xTMvNpKErS50_flMMQ_1756121230
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5233781cee7so185810137.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756121230; x=1756726030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDMukmH0FQggYXKvzUec4QBhOgYrZ5QeyS3SsGzawf0=;
        b=nlCAjIGADpX7alyvSE2/RGkJvYVQuSlTJJSVM7KlxDaLFotj2x5+Bix3qjD6J57gKI
         YAcoHnGJNYojuxiF1qSXXl+aDEU5xrGezQVKAoAkbo1TzyvM+j9l1ws7oDYi20mkClXC
         hFUiObVm/i+CICjthpEsytmuCn4zfd8m7SCt89hIqpqRpRsshMMOc9WNPgha1y2U2d15
         4DklRJokS5NV1LP0tiDPeQ9jlBdK6xOe2eySZUbmoRkNDNVwG33alx4XgvdGtmMIBxeT
         T7WFsPoWBOoqEG4L0KNVH2xTCtxV89oYwfngcK8jtN9xTs1ymn660SYMHl6843p+xbu1
         2owQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmTuj+il5w3zxiHP8+i/CZ8wRQS/3NPfrYu21yLXRYTxzCw9EFz/K/i4Ng3x4cZpL1ae82ja7gtyXMNY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5wNCieareDJJoQlDOneyZR3q/x0itWNTVjRxRUxuo5cQaGhZx
	cb7QobgrHHWbHAP5AAaf/FQ1hP/WmtR1XzSblWQNvsMdlm1i2uunA8RPNQvpvlN71o+n46XeNwe
	mqnVWYRZ16+4xI4LY2UJ8kEvbhwt6MJk+GuKYbknvE7S0jgMzwZcv0lTpG3jWN/m2rDRXVM10Oo
	XQ5hXYVSDCPxYxh/JQf53E47zhzKY714LoBK6ZE84w
X-Gm-Gg: ASbGncspjLkyF9U/NntfTLCeUk/MSD6P2k0UXlHBNw2yD4c/s3suGi0syYPGFzrlcF7
	NNkFcJ2xtP8apbxCibjm7THLHbwGzy+DZFQ673rnqz/qcAXREf4Rgvwp49yLc8dogoDg5SPL/MX
	+5JpsRdBltEMgmwiyuwbW0Vw==
X-Received: by 2002:a05:6102:a4e:b0:4fb:b78a:6cd1 with SMTP id ada2fe7eead31-51d0edd3396mr2320030137.19.1756121230055;
        Mon, 25 Aug 2025 04:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPYvkopN7UqDChOYSkUj5QzTSAZ7Hijf4D6K12CDHkzfHjzTz0n9WJqHj87a0m2x1X1OvuE+9z3muxtjNHvs4=
X-Received: by 2002:a05:6102:a4e:b0:4fb:b78a:6cd1 with SMTP id
 ada2fe7eead31-51d0edd3396mr2320024137.19.1756121229688; Mon, 25 Aug 2025
 04:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
In-Reply-To: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 25 Aug 2025 19:26:58 +0800
X-Gm-Features: Ac12FXyUr3hWAroe70N31cD1VLoq7XqtMeU0YdR_bS7U3-G764sUu_8sjIHgAtE
Message-ID: <CAFj5m9KTdHdQrrwBdUF=2xK9uDqnv6Zt6j7gLXRzr7CYy_cW+A@mail.gmail.com>
Subject: Re: [PATCH v2] loop: fix zero sized loop for block special file
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, axboe@kernel.dk, yukuai3@huawei.com, rajeevm@hpe.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 5:40=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> By default, /dev/sda is block specail file from devtmpfs, getattr will
> return file size as zero, causing loop failed for raw block device.
>
> We can add bdev_statx() to return device size, however this may introduce
> changes that are not acknowledged by user. Fix this problem by reverting
> changes for block special file, file mapping host is set to bdev inode
> while opening, and use i_size_read() directly to get device size.
>
> Fixes: 47b71abd5846 ("loop: use vfs_getattr_nosec for accurate file size"=
)
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508200409.b2459c02-lkp@intel.co=
m
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
> Changes in v2:
>  - don't call vfs_getattr_nosec() for block special file path, by Ming

Reviewed-by: Ming Lei <ming.lei@redhat.com>


