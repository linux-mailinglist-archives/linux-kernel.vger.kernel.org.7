Return-Path: <linux-kernel+bounces-891562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C73C42F02
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3978345D5A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D081E3DE5;
	Sat,  8 Nov 2025 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is+gnpXv"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B31FDA89
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617616; cv=none; b=D5A0c+imbMdouBd17jBv5x7oB+d+Ih9EFtUwRy+fjs2d6ijcmcxu+/C3naSxpx8sLK14hPu2UWrLs53vuYqbpK4lBI2D0LDsm9yHPa72WbLXVXP/mwGmhbRq6lZ/lCyLumwA5weyf96llGpkpcMEBppA3a//sMDAye1T9X7RsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617616; c=relaxed/simple;
	bh=bFsXLkOC7htAcCK4FnqqlbRFpr/P4o9KOYs3YriLlAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bW9YAu9pxFizklbe7dhMcMxCDulIntB9+KrM0iu09g0JlLcE2q30wUgz/KWLBXBol30KLTQwg5UWCHdJ291sWRq9CMxHq1KUyNd5+M5cYU4VCgM+a/Dv5ftC6n70896g9SYhUvKpi9mti6sQ5fgQXllT/pCNIwIFP+JTewG75GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is+gnpXv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7128683174so31376966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617613; x=1763222413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5gIjwY0VIkQOLBhqDqw7K5il1qhHJd5j+7PMJ2a3+Q=;
        b=Is+gnpXvIL2ogHXDKkF/jx3CednBJYPcv22ZtpKCpu0J6ktH08cYqOTIDJlImVwAR7
         dyadKr9LlZTSsCgGBjtMsgIKKq9aBsGeW8+r5IzXjSAjWBYZ3OVTgo6uYrq9icO6IlOF
         IVkGhwAyMxV7ikbVVNRnmjC8mDX8vCy/GKp46scZ16Ci2LnVjKSnHNFvDEX9zuMxH2+Z
         YVkYRdQKFphGrNMbRY2Oy4qk2av87Up9LwptxDxLnmJjZsF8Xe6/aUsnO15QPNvZ1Pkq
         2lqsTfK94VflzWP5umoJw2LHLCqXN+zFDwGMXILfP1TShNrwOVjV7rzZcievbF7ENZ5V
         S8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617613; x=1763222413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5gIjwY0VIkQOLBhqDqw7K5il1qhHJd5j+7PMJ2a3+Q=;
        b=twuzzYYrnek1XlQqnYv5fGpvyOvRQH1nLUPOTIoVPW0nOa0OG74vpf3OzxUMUOApN3
         VYLJ9emkHg04sIb0ce7Z6t7w/1noOg4+Xs0RpCCKMrwkpLP8DtdE8xLSWSJmcKmdy4xX
         dXGObibm/YEyv44MREiaq5OqjjaGRd11TrS2remlXH6D6y2j1TZ1C4H/3fPZx9FGgXZj
         40SL4LRnJYO2/KsHApDxZngZvYBk9UmQq17aaWYQQHpuqAfbClkDRcLKJDdc1WbWqPUc
         A/IODBi5OFV+onRatucCpjUnUqyxmDFH3TUPxXnClEAioCLJAzxSAZ/IQ6tK2Tqmg16j
         XqAw==
X-Forwarded-Encrypted: i=1; AJvYcCVxynF9otS4nFf8d46s4LU3XjjOWuLcI6dQj9k+Kj+JtAyhl26+jnM72Fe4631OMFKbqK5J0MU0neDNhxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+6L+PdoGwxnKlmYvAwrjPLgyWLwOzQD+AyZjjnt/xawrqWx2W
	1VxiVwMsqcmQfJYLvwJf5b2AjNRU1HBBpG9a951jx6fPHcFtEwvtyMAk3zQM5/njTkPiAHynKWl
	UvMmw6sG2Wnqfl+bntb5bGfo6skOfscc=
X-Gm-Gg: ASbGncsWuytgF0wLtQ0svXN3ytQt7qGfGPrwC19rQaMlUCCAEHjL6l//7+Bsz4OWNJD
	5ghqzRrEKK9UhdWRRNYcEnNQWNQ1mntNj5HqNaFguDwR/rZsO1ZzT0Nvw+eBqfr48K5TrhD1NUR
	Gd1PfBjv960PoYkzU+gMhio5ga0rE+8aNJCqp5iJVjZUqffvS8YSRd+MVfE2fD7y+xBfKmvsaR+
	28x5E+ir9nORvJI+YbKbl+11ISImuZBkJ7NjtzkuY96EjQ95FXUwWRh2PtIF+Emp7g+YfTU
X-Google-Smtp-Source: AGHT+IE36q81ytbzipjRNhSYqb9l6GAh21i2Japqe13b7xIwmws0+g4DATqa0W/viEjZnbKMLzVT0GmZGyYO3yq7+qg=
X-Received: by 2002:a17:907:d29:b0:b46:6718:3f1f with SMTP id
 a640c23a62f3a-b72e0572c96mr159995566b.7.1762617612482; Sat, 08 Nov 2025
 08:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025110803-retrace-unnatural-127f@gregkh> <20251108123609.382365-1-pioooooooooip@gmail.com>
 <CAKYAXd-R8NGDzQ-GTM67QbCxwJTCMGNhxKBo1a0sm0XBDqftLw@mail.gmail.com>
In-Reply-To: <CAKYAXd-R8NGDzQ-GTM67QbCxwJTCMGNhxKBo1a0sm0XBDqftLw@mail.gmail.com>
From: =?UTF-8?B?44GP44GV44GC44GV?= <pioooooooooip@gmail.com>
Date: Sun, 9 Nov 2025 01:00:01 +0900
X-Gm-Features: AWmQ_blPS5r1nNyxxhsinZ2QngiwVO-KEXZe6F6Hp_3GEfSqaWpGWONKMCdT6F4
Message-ID: <CAFgAp7hG8k7Qrtor0O_CKb8tH3yNso-m2AjWDmvOtbRE4056JA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: vfs: fix truncate lock-range check for shrink/grow
 and avoid size==0 underflow
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhitong Liu <liuzhitong1993@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the guidance =E2=80=94 I=E2=80=99ve sent v2 patch.
Best regards,
Qianchang

On Sat, Nov 8, 2025 at 11:46=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> On Sat, Nov 8, 2025 at 9:36=E2=80=AFPM Qianchang Zhao <pioooooooooip@gmai=
l.com> wrote:
> >
> > ksmbd_vfs_truncate() uses check_lock_range() with arguments that are
> > incorrect for shrink, and can underflow when size=3D=3D0:
> >
> > - For shrink, the code passed [inode->i_size, size-1], which is reverse=
d.
> > - When size=3D=3D0, "size-1" underflows to -1, so the range becomes
> >   [old_size, -1], effectively skipping the intended [0, old_size-1].
> >
> > Fix by:
> > - Rejecting negative size with -EINVAL.
> > - For shrink (size < old): check [size, old-1].
> > - For grow   (size > old): check [old, size-1].
> > - Skip lock check when size =3D=3D old.
> > - Keep the return value on conflict as -EAGAIN (no noisy pr_err()).
> >
> > This avoids the size=3D=3D0 underflow and uses the correct range order,
> > preserving byte-range lock semantics.
> >
> > Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
> > Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
> > ---
> >  fs/smb/server/vfs.c | 28 +++++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> > index 891ed2dc2..e7843ec9b 100644
> > --- a/fs/smb/server/vfs.c
> > +++ b/fs/smb/server/vfs.c
> > @@ -825,17 +825,27 @@ int ksmbd_vfs_truncate(struct ksmbd_work *work,
> >         if (!work->tcon->posix_extensions) {
> >                 struct inode *inode =3D file_inode(filp);
> >
> > -               if (size < inode->i_size) {
> > -                       err =3D check_lock_range(filp, size,
> > -                                              inode->i_size - 1, WRITE=
);
> > -               } else {
> > -                       err =3D check_lock_range(filp, inode->i_size,
> > -                                              size - 1, WRITE);
> > +               loff_t old =3D i_size_read(inode);
> > +               loff_t start =3D 0, end =3D -1;
> > +               bool need_check =3D false;
> > +
> > +               if (size < 0)
> > +                       return -EINVAL;
> There is no case where size variable is negative.
>
> > +
> > +               if (size < old) {
> > +                       start =3D size;
> > +                       end   =3D old - 1;
> > +                       need_check =3D true;
> > +               } else if (size > old) {
> > +                       start =3D old;
> > +                       end   =3D size - 1;
> > +                       need_check =3D true;
> >                 }
> >
> > -               if (err) {
> > -                       pr_err("failed due to lock\n");
> > -                       return -EAGAIN;
> > +               if (need_check) {
> > +                       err =3D check_lock_range(filp, start, end, WRIT=
E);
> > +                       if (err)
> > +                               return -EAGAIN;
> >                 }
> >         }
> Can't you just change it like this?
>
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index 891ed2dc2b73..f96f27c60301 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -828,7 +828,7 @@ int ksmbd_vfs_truncate(struct ksmbd_work *work,
>                 if (size < inode->i_size) {
>                         err =3D check_lock_range(filp, size,
>                                                inode->i_size - 1, WRITE);
> -               } else {
> +               } else if (size > inode->i_size) {
>                         err =3D check_lock_range(filp, inode->i_size,
>                                                size - 1, WRITE);
>                 }
>
> Thanks.
> > --
> > 2.34.1
> >

