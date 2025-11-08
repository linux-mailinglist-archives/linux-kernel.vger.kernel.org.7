Return-Path: <linux-kernel+bounces-891698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA9DC4345B
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 21:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13EFA188DAB7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 20:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C13723C4E9;
	Sat,  8 Nov 2025 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OB5msYz4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+17/Ylx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1C1FDA
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762632057; cv=none; b=SUT5OAJbeSB7tyDwmUhF0JNejEAI+05TlhUWR6rlDyOJ2ItgcsfDmTVrvM9Kw7xdK3mwLgQFNcmqZVOi8psz2vbbVRIIQl1NBqM8FeEOAsut1O0SZWbaFNW0a/Vwt7D7d5PVCCv0PrJHN+Tz6yYP8sFS9irgOlojUNokB+7RuP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762632057; c=relaxed/simple;
	bh=iwfcLfOtghbM9DC+PCDtTd3U3hVhPKz8QzyeDC8NeK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnHuJiAsVxnIPq6BQEQT4o4mwOGVTE7RKGdfyg1t0cghsMRcaFIT9TMLlfn802j3Qmsw3RYpZmOPEPFLm49ZATbcct2ZRWwJXGOtoXzUK7xKLnM7Ur1rkj9K6AV1XsH/4ju5kGOZSfcV4VbqcihXN/cBlyw4hYnvKBf48qhO4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OB5msYz4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+17/Ylx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762632053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vzuz0iSweWV07TK0XrRN6GhbSFKG/GySOsZ2Z667jzg=;
	b=OB5msYz4z5D1baNHfObsnD9haNYWbUYEjE3YwLuA5mEThbbbygYlRtxV9CHlm04gCRCaJK
	8W94Nm95S5H7SoHpBejEsmmWhuRxVzzebS7Lzyfew6d+tw4shhbS1o7wwDfNVrHj5jZtGT
	wLYEJp9BMA/bWVzcrukryReGoAkWk8o=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-RVQ3LeWFOKemISLFYz3jkA-1; Sat, 08 Nov 2025 15:00:48 -0500
X-MC-Unique: RVQ3LeWFOKemISLFYz3jkA-1
X-Mimecast-MFC-AGG-ID: RVQ3LeWFOKemISLFYz3jkA_1762632047
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-63e35e48a1aso2552434d50.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 12:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762632047; x=1763236847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vzuz0iSweWV07TK0XrRN6GhbSFKG/GySOsZ2Z667jzg=;
        b=N+17/Ylx98sU4ah12gWpp3HCsj64SDS1KFGOeSrGdDVMTV/A+LpjvOo90uXJiLtx5s
         VMl1xcHD7HLBYPTGlS6CRgO2RpmWNr+3aVjIRG2lvD+iroC0mn04e6dumt+yVHZFwS8c
         59rGxA88qZOwr1jTDmrRZX4WYULawTnFPX+6vd+1t3HI86lTbBrVG1Sw+zjo3GAi4/jc
         6FyLL3Fk4qKMScJWD8nInQHsIui06nJJYN8JkzhavInBiCMvGw6INcIam4YWgcqU2WcK
         OjFnb/RsXActzXwrhxZHvndm0symdqNF45hQpNm+n8+W38RduI4N7bhSpFQ1mi7VQMf/
         53bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632047; x=1763236847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vzuz0iSweWV07TK0XrRN6GhbSFKG/GySOsZ2Z667jzg=;
        b=KuB/93CzekF5sgL8eptZZovs+zdhj1v4wv+RHNjxtD/f/5dMV2Eah5xIvKMWDeHqFD
         0PxClmUfT5x3c43YtY3rARJxuyZvtbqc9szr7lu57PjSH+tbyQz8DQkQc5RB5wAtpj52
         5v1oKDbm3lF7EDA2AX0ovn4/xQN11zuDyGN2+M5HPOyxKr0nj7EqdwYYHO6idkEEbX/i
         9Jk1MtW0iGF3Ypx5f+c5P86ApMtGokhX9kafQYWRaG/FsTk1zhaNfQLYAEhM7rh3oc0B
         FJBeWxyCsE9RGkiuGdYb9vY7SYTFoSrkbDMvZPqxizNUeo0aVS0lSOv+iHJHRv1dOe4R
         +0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV5DuIrVZwylWBLmt+Mpv/MOtZTCZggQWJpsx2wpT001zvJ+DlO2fwAlucbNdPcXbo6nZ54nZ0WR7Osogs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdsxzXMDale7C1U+DLr6VwUWkJ6Dk15XEkfEE7KwstX/AeawmQ
	Sh5PKFWlVM2e2LuvWTXK+ypdsEYlWVCfROb1Z8N6gnuI8XFdHnY1RzHCDNh7JdHYjgFXHZc47iA
	yp+L/mwndxsOyXnAH4WlY4ekJnVsJ+dWZ2E75UJn6GblKcM3tA44o1XmVMMVE7JFh9Y0gifW91g
	3LicY+K6l4ns+sjkAaB8dQEJc4BQhCRJhKN1YklYl+
X-Gm-Gg: ASbGnctE3q7tGFpLoE64ntTgnSshSh9+DWLi4M2b00iE8uVjXQilVvSA/uGkjinn/XN
	yk/4r+Dozis4quk2kzXSWXXebdV4P8w757uJPaqe/9taqMcVDMNdO5w6T07eRZF+6sUWcKpJJ60
	+iL7ZXc+InvJbsxCtxuMNY6MTfeahVuuySRYTHuqIPoiEIPbmsqmVBpg==
X-Received: by 2002:a05:690e:2504:20b0:63f:ac1c:a375 with SMTP id 956f58d0204a3-640d4555979mr2313637d50.25.1762632047561;
        Sat, 08 Nov 2025 12:00:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSl+/IrDM1uqujfQ1tjlfbIwCNMT3s9OQgLH06kPlb0kAkNv2LeOZz+5jqoQhoqi1RXtRyDtIc+3ETlTDrhEk=
X-Received: by 2002:a05:690e:2504:20b0:63f:ac1c:a375 with SMTP id
 956f58d0204a3-640d4555979mr2313610d50.25.1762632047093; Sat, 08 Nov 2025
 12:00:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <690da013.a70a0220.22f260.0025.GAE@google.com> <tencent_522CB56DC89514EA26EF8ACCAC784A6F540A@qq.com>
In-Reply-To: <tencent_522CB56DC89514EA26EF8ACCAC784A6F540A@qq.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sat, 8 Nov 2025 21:00:36 +0100
X-Gm-Features: AWmQ_blhcl_epfqlOQgyduWglj8EMc0vOT14tfe4JakxuJMK4J4sXVnwFDlUlaA
Message-ID: <CAHc6FU5E2UNyhLuwJVdv3xnHEcM_Si2oX06S+5mz_3uz3-QqnA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix memory leak in gfs2_trans_begin
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Nov 8, 2025 at 10:13=E2=80=AFAM Edward Adam Davis <eadavis@qq.com> =
wrote:
> According to log [1], a "bad magic number" was found when checking the
> metatype, which caused gfs2 withdraw.
>
> The root cause of the problem is: log flush treats non-delayed withdraw
> as withdraw, resulting in no one reclaiming the memory of transaction.
> See the call stack below for details.
>
>         CPU1                                    CPU2
>         =3D=3D=3D=3D                                    =3D=3D=3D=3D
> gfs2_meta_buffer()
> gfs2_metatype_check()
> gfs2_metatype_check_i()
> gfs2_metatype_check_ii()                gfs2_log_flush()
> gfs2_withdraw()                         tr =3D sdp->sd_log_tr
> signal_our_withdraw()                   sdp->sd_log_tr =3D NULL
> gfs2_ail_drain()                        goto out_withdraw
> spin_unlock(&sdp->sd_ail_lock)          trans_drain()
>                                         spin_lock(&sdp->sd_ail_lock)
>                                         list_add(&tr->tr_list, &sdp->sd_a=
il1_list)
>                                         tr =3D NULL
>                                         goto out_end
>

this bug report is against upstream commit c2c2ccfd4ba7, which
precedes the withdraw rework on gfs2's for-next branch. With those
patches, the race you are describing is no longer possible because
do_withdraw() now uses sdp->sd_log_flush_lock and the SDF_JOURNAL_LIVE
flag to synchronize with gfs2_log_flush().

I don't know why Bob chose to push the transaction onto the ail1 list
instead of freeing it in gfs2_log_flush(); that's something to clean
up. I've pushed an untested patch doing that to for-later.

Related commits:
58e08e8d83ab ("gfs2: fix trans slab error when withdraw occurs inside
log_flush")
f5456b5d67cf ("gfs2: Clean up revokes on normal withdraws")

Thanks,
Andreas

> The original text suggests adding a delayed withdraw check to handle
> transaction cases to avoid similar memory leaks.
>
> syzbot reported:
> [1]
> gfs2: fsid=3Dsyz:syz.0: fatal: invalid metadata block - bh =3D 9381 (bad =
magic number), function =3D gfs2_meta_buffer, file =3D fs/gfs2/meta_io.c, l=
ine =3D 499
>
> [2]
> BUG: memory leak
> unreferenced object 0xffff888126cf1000 (size 144):
>   backtrace (crc f56b339f):
>     gfs2_trans_begin+0x29/0xa0 fs/gfs2/trans.c:115
>     alloc_dinode fs/gfs2/inode.c:418 [inline]
>     gfs2_create_inode+0xca0/0x1890 fs/gfs2/inode.c:807
>
>
> Fixes: f5456b5d67cf ("gfs2: Clean up revokes on normal withdraws")
> Reported-by: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D63ba84f14f62e61a5fd0
> Tested-by: syzbot+63ba84f14f62e61a5fd0@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/gfs2/log.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
> index 115c4ac457e9..7bba7951dbdb 100644
> --- a/fs/gfs2/log.c
> +++ b/fs/gfs2/log.c
> @@ -1169,11 +1169,13 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct =
gfs2_glock *gl, u32 flags)
>          * never queued onto any of the ail lists. Here we add it to
>          * ail1 just so that ail_drain() will find and free it.
>          */
> -       spin_lock(&sdp->sd_ail_lock);
> -       if (tr && list_empty(&tr->tr_list))
> -               list_add(&tr->tr_list, &sdp->sd_ail1_list);
> -       spin_unlock(&sdp->sd_ail_lock);
> -       tr =3D NULL;
> +       if (gfs2_withdrawing(sdp)) {
> +               spin_lock(&sdp->sd_ail_lock);
> +               if (tr && list_empty(&tr->tr_list))
> +                       list_add(&tr->tr_list, &sdp->sd_ail1_list);
> +               spin_unlock(&sdp->sd_ail_lock);
> +               tr =3D NULL;
> +       }
>         goto out_end;
>  }
>
> --
> 2.43.0
>


