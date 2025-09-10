Return-Path: <linux-kernel+bounces-809329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFF9B50C17
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7861B2460F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCFF4315F;
	Wed, 10 Sep 2025 03:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K79SWdg5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ADF8F4A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473457; cv=none; b=WAXfm47qTbYF14b8W1fFhpB/GfK+av5TEWW+yEnRlAng8nJLFDGuBuBjLAi+WkgzwhV1Ivfq9Yy78mUw8HU+8QaSGRd1B9bhh7tyXAN6k/aT10XFUrpJ3nTKZjuaNBJlmkcUOG1Mkq31wFmTX9VstjKffzxqNv2U+eY/agfHDTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473457; c=relaxed/simple;
	bh=nhEfURgijinZhjIeDXDnCpQKyzGClfm2rB5uSbE2bUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaJ2/J7/dMEfa+psEB87iZNxoOYMp30l9NcxRxJOhESXQkOD+aO3/cwMpleRvi1nCNr1iSSt8nU2ZMnHyLYvfebHaZloFGyO1trxs93nq96NINYv4UqIf9OBtaCN0N7CWc353jsuoQIJwcC8mZm+QeJ5wrAXd3PObOMQaZBUMkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K79SWdg5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757473453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FXW/+HBhYk2zr4fhYSXPPsYBARrLzDG/6qntZFMVpo=;
	b=K79SWdg5+fz0ziSA8VLNqXoDAcTQ8dt2EJDfB8Mw4FVPUN01tte/MaebDQMPhEGzld+Ruf
	kCYFu0lDvxEJ3aEdM2MXM0d+IHuD0hiWrjxaVLiUSty3Gtj4+laAaBhhx79pmIzrMhKC+2
	2JAadEfPViwy1WxGbQG3+8pDwUZqziA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-yIcGU-LqPJ6DnUyGbzTmvg-1; Tue, 09 Sep 2025 23:04:12 -0400
X-MC-Unique: yIcGU-LqPJ6DnUyGbzTmvg-1
X-Mimecast-MFC-AGG-ID: yIcGU-LqPJ6DnUyGbzTmvg_1757473451
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b522e289a39so4567187a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 20:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757473451; x=1758078251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FXW/+HBhYk2zr4fhYSXPPsYBARrLzDG/6qntZFMVpo=;
        b=OMOGnGgZi0KliLOsNjWOQPv5CdKkOOAmKugJQz4ZfFlMgsrfMEJmY677rXDKGeI101
         hROAbwlbTQy3TuNoHHpA865zjnYHFvLO1b1Drggsuqbwp1DyLle9v4SXdHm9NafpcMIu
         qqTLJ+BAbEqiEfwPH2fMsBzvQoBHN0Kp3qgrSYdq2jvIZa9U6v9bO8EVYEzahyp5+pP9
         IksV1NcjiSyll4eQDlZ2EHuU82yLpnge0gH5K1wEI6owECnsqsYrttAKFHgmLVLEwlde
         wYmbj5iBkWjjN9uFrNrE9Z/Ndi3MEKoOerDbTXgCJnw+OfIg68zVv+XCdE01nEBd0dut
         scfg==
X-Forwarded-Encrypted: i=1; AJvYcCWWQwoL4DM9hahVYYbpf85Oj25HXLJ6/+TbPm3iGp0/7BhqbSCB+3xehdG+4Uz1/MFWWiQZ87Ry3XhMvuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW6hvb80kFUHC1XE2EzWS4j4ENS2mA8tT0TAJZ4Dsx3eObXXfl
	m1riolshgI02gdvf0nyV1Ga6s2MgvDBDM6cHjUhde0NlpxQIxZ7wdTHEJ+J3YQlZJce8SIXN2gZ
	M/LZDlRf9AHRz4MmSjbEFsQAgGJmURjUXuU2SQ0Pfr8+kTuFvLXRMVq73XvBK1y0UDia/bUo9wG
	4fe/OHg+q9Oeu81Dfz9z+avhcw6oqjTNbOLwx1EGzE
X-Gm-Gg: ASbGncuD3KHKpNl9NzHQvJQFlaJefiI1RDxJufzo6cdN22JFuw9u1B2ZIlioNPWQKxz
	HuYZ2Rm2cFPDhZXITj+20GQZry+a4ACIhbsRcVXJx/2wHUgEa8bKKYBy6uLbdF3xmG3jwi0GJf6
	hkH+AWBTIOLKrH9yBNyTK26w==
X-Received: by 2002:a17:902:d2c7:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-25174379a44mr156803585ad.61.1757473451286;
        Tue, 09 Sep 2025 20:04:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoONmeblID+bbqEAMuFoJ5+Ea8yfSh04sJMH6nD19i7912llMFc2WtXUtmsm3rCCJweVbSCHScx/GFYeunpuc=
X-Received: by 2002:a17:902:d2c7:b0:24e:3cf2:2453 with SMTP id
 d9443c01a7336-25174379a44mr156803275ad.61.1757473450771; Tue, 09 Sep 2025
 20:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909045150.635345-1-senozhatsky@chromium.org>
In-Reply-To: <20250909045150.635345-1-senozhatsky@chromium.org>
From: Changhui Zhong <czhong@redhat.com>
Date: Wed, 10 Sep 2025 11:03:59 +0800
X-Gm-Features: AS18NWB6rxPU7nJp7LtkjRqh_fDdk-M3Q2gkXOetkwTl8ftzFeeehDhcc74570w
Message-ID: <CAGVVp+VMHxz2OAooS_t=H0tiNM9_C0zm6kn-d0DP_U14km8a8g@mail.gmail.com>
Subject: Re: [PATCHv2] zram: fix slot write race condition
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:52=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Parallel concurrent writes to the same zram index result in
> leaked zsmalloc handles.  Schematically we can have something
> like this:
>
> CPU0                              CPU1
> zram_slot_lock()
> zs_free(handle)
> zram_slot_lock()
>                                 zram_slot_lock()
>                                 zs_free(handle)
>                                 zram_slot_lock()
>
> compress                        compress
> handle =3D zs_malloc()            handle =3D zs_malloc()
> zram_slot_lock
> zram_set_handle(handle)
> zram_slot_lock
>                                 zram_slot_lock
>                                 zram_set_handle(handle)
>                                 zram_slot_lock
>
> Either CPU0 or CPU1 zsmalloc handle will leak because zs_free()
> is done too early.  In fact, we need to reset zram entry right
> before we set its new handle, all under the same slot lock scope.
>
> Cc: stable@vger.kernel.org
> Reported-by: Changhui Zhong <czhong@redhat.com>
> Closes: https://lore.kernel.org/all/CAGVVp+UtpGoW5WEdEU7uVTtsSCjPN=3DksN6=
EcvyypAtFDOUf30A@mail.gmail.com/
> Fixes: 71268035f5d73 ("zram: free slot memory early during write")
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 9ac271b82780..78b56cd7698e 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1788,6 +1788,7 @@ static int write_same_filled_page(struct zram *zram=
, unsigned long fill,
>                                   u32 index)
>  {
>         zram_slot_lock(zram, index);
> +       zram_free_page(zram, index);
>         zram_set_flag(zram, index, ZRAM_SAME);
>         zram_set_handle(zram, index, fill);
>         zram_slot_unlock(zram, index);
> @@ -1825,6 +1826,7 @@ static int write_incompressible_page(struct zram *z=
ram, struct page *page,
>         kunmap_local(src);
>
>         zram_slot_lock(zram, index);
> +       zram_free_page(zram, index);
>         zram_set_flag(zram, index, ZRAM_HUGE);
>         zram_set_handle(zram, index, handle);
>         zram_set_obj_size(zram, index, PAGE_SIZE);
> @@ -1848,11 +1850,6 @@ static int zram_write_page(struct zram *zram, stru=
ct page *page, u32 index)
>         unsigned long element;
>         bool same_filled;
>
> -       /* First, free memory allocated to this slot (if any) */
> -       zram_slot_lock(zram, index);
> -       zram_free_page(zram, index);
> -       zram_slot_unlock(zram, index);
> -
>         mem =3D kmap_local_page(page);
>         same_filled =3D page_same_filled(mem, &element);
>         kunmap_local(mem);
> @@ -1894,6 +1891,7 @@ static int zram_write_page(struct zram *zram, struc=
t page *page, u32 index)
>         zcomp_stream_put(zstrm);
>
>         zram_slot_lock(zram, index);
> +       zram_free_page(zram, index);
>         zram_set_handle(zram, index, handle);
>         zram_set_obj_size(zram, index, comp_len);
>         zram_slot_unlock(zram, index);
> --
> 2.51.0.384.g4c02a37b29-goog
>

Hi, Sergey

Thanks for the patch, I re-ran my test with your patch and confirmed
that your patch fixed this issue.

Tested-by: Changhui Zhong <czhong@redhat.com>

Thanks,


