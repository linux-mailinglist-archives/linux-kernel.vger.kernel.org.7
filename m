Return-Path: <linux-kernel+bounces-837315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 492AEBABF40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D840E1925EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BD92E9751;
	Tue, 30 Sep 2025 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOAl8zD7"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177412BE7DC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219672; cv=none; b=kIbOiBf06vT7HGNjzBeSZYmt+G+0BLvAMC+FeqvLosIoQjGtSMTLISWjGivHOL9jHL4E45ptlYg5BaFtjPR4Xj0wCyvk02iYcCVT2ZqAHa3Xr1wU2qJtPisqMCmpJHIdqxsNXkuPXkFLvpOoDqIbZWkVmnV9nFSswuURJm94V0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219672; c=relaxed/simple;
	bh=PWs7M59Es2rZ4FXsA+5Z26LxlDdw1VpL1LwRGzjE5oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fjDQlCtAD/XEI0SCJUfH7Vcsx4VyCke1uwuh2tawsW61dmSyVKyMGHRCy9JyEDq9dOryuCGkeKM/XdqwTBzPYLv3mW18asxBylU81RqmJumTiGg6JH/1zPiVhYUh/5tQnvTPXQKRHDDJwyPPKg1lpqlHoYE++2S49vIG+PfqV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOAl8zD7; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33255011eafso5623738a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759219670; x=1759824470; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQDNm8paGpHHR4jYrlNM7FvwAeM4XRqMkqNZ15rKEQ8=;
        b=EOAl8zD7Wfu9ALKUGeufbS7nswIZ5vfI2+ePzIRrzcq3VRjMt4eSEjqrVTYdJzlRTK
         i2xUqBBTC5CbMeYcHW/rmZgppFfUJsVm9KQ6qEN9nWDe8ZaBsKZ+8cQOKg0cMQ16zVgm
         YgS3v22iyqZhy9DujfohPnerkTodTN/Wt3Jp38JPKaYqc0AqszzZe+zpKquHBSachSkz
         ySDQeDxNRAMPxgljniEORVxS8VZp/UMPbza196VSEKReFj3Zx6RCg554Lwu32hfvPzAl
         ReCrw3SsrpDEUDlN4tc8NASk+m7JVLU8/HIPi6Xbyldb9Hlh+g6uDJRSkWbMxDoXl0zb
         aDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759219670; x=1759824470;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQDNm8paGpHHR4jYrlNM7FvwAeM4XRqMkqNZ15rKEQ8=;
        b=UfZAAwPGwEtbmkaNfvBR+Bv7YJviUFFOyFl1+8nMVe735GjnT+aswb1mWsbVgkQuPe
         9F04AI/1YP6yWzO1+7VmkJMeba07uIPSm2W14TRk/IU1IHincwRh6DnBqigeUQb9Xcf2
         HnbHKuMDev2hieJ68ki6MdgwRvoI0tXok7Gv+gOpt3K+sKYakzhPaYXRVy1Vk4q0C7qS
         vptq1zYqUG6KR/1PK3bbtlpMrbo/L02mHEvxNMnCneu8mhNwvR4A9oaBiri2Gc3UDo5I
         A7wk4iG8grf4KgBT4oJqZZLkLVAaCWALnlRJf/MLvXBhXJcClXQ+FoD6BT4+JM27aeM3
         WBQw==
X-Forwarded-Encrypted: i=1; AJvYcCU6v3l59pfUmvoEPRslN/mulNGlSrIvEL/tRQZ7z/AX5C8YdGRFbf/09iSIj3XbPFtbLTwry3CVcAKLuFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8SLMp3fJ6gJqhzRWW3KG5pQFRrJ1IWPtk0E44qfIc6J+Lw8Z8
	5ZTsJppiQr9SZuwhiXm7KY7/XYlEJdXOkO7p4kEH3+l8AJA7RKZQpVM6pu1FpT+bF0P9jkF+Phw
	+FgGW9hKtgwmizPyHYOOuoP/z3HBFbPs=
X-Gm-Gg: ASbGncsgCcUNT1EnUD9HIbFwAwZjEWt8mMs5nTelSFs/Pkg4iS7ZsUvgCePDAJStei0
	0jW2f7v5S8D3DSa0hM9X1V0w3v5Vn5HH4ksHPj1JZEteddd4L5n3zSOvItSFx27FzQh0UsfiHIy
	njvGZ/BFojBczdVIObaEB18FjM6T6HsVebCWIOSN7ecm456sEN0JC/hMLYyRa2f5OQRwGe35Arr
	Lk6iH4fExFjwdMV7dTbHqU1UC8PWj+uoSmIemtJPPbAX9AGYMCXRjY=
X-Google-Smtp-Source: AGHT+IFW5uhh8ogQ/5ZGKIOcOWJsstfba1OMM2SuFHBijwtnpTExwKNNiOZ/1k17A2PSp+uTO8M1od/haIk+PPqHgyw=
X-Received: by 2002:a17:90b:3e86:b0:32e:5646:d43f with SMTP id
 98e67ed59e1d1-3342a2976f5mr20676820a91.19.1759219670328; Tue, 30 Sep 2025
 01:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910084235.2630-1-lirongqing@baidu.com>
In-Reply-To: <20250910084235.2630-1-lirongqing@baidu.com>
From: Li RongQing <roy.qing.li@gmail.com>
Date: Tue, 30 Sep 2025 16:07:39 +0800
X-Gm-Features: AS18NWB3sRA6Fl4zyNYwr5jk90hs2LruLuBEVfuMCRl26thqLjaYDC-rtyQX2iM
Message-ID: <CAJFZqHxgCcxZL1W8-NtiQjrpvfxmzZ-EdyzCAD6QALqv12LguQ@mail.gmail.com>
Subject: Re: [PATCH][v3] afs: Remove erroneous seq |= 1 in volume lookup loop
To: dhowells@redhat.com, marc.dionne@auristor.com, 
	linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, oleg@redhat.com, 
	Li RongQing <lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 4:42=E2=80=AFPM lirongqing <roy.qing.li@gmail.com> =
wrote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> The `seq |=3D 1` operation in the volume lookup loop is incorrect because=
:
> seq is already incremented at start, making it odd in next iteration
> which triggers lock, but The `|=3D 1` operation causes seq to be even
> and unintended lockless operation
>
> Remove this erroneous operation to maintain proper lock sequencing.
>


ping

thanks

-Li


> Fixes: 32222f09782f ("afs: Apply server breaks to mmap'd files in the cal=
l processor")
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v2: add Reviewed-by, and Fixes tag
> Diff with v1: rewrite the changelog
>
>  fs/afs/callback.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/afs/callback.c b/fs/afs/callback.c
> index 69e1dd5..2c0d274 100644
> --- a/fs/afs/callback.c
> +++ b/fs/afs/callback.c
> @@ -140,7 +140,6 @@ static struct afs_volume *afs_lookup_volume_rcu(struc=
t afs_cell *cell,
>                         break;
>                 if (!need_seqretry(&cell->volume_lock, seq))
>                         break;
> -               seq |=3D 1; /* Want a lock next time */
>         }
>
>         done_seqretry(&cell->volume_lock, seq);
> --
> 2.9.4
>

