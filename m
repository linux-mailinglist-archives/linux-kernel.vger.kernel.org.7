Return-Path: <linux-kernel+bounces-885097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7979C31FD7
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E943B2718
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B1D324B0A;
	Tue,  4 Nov 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJGRP0pg"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4B5313538
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272747; cv=none; b=RDp9BoFjOzF08zmWpRXxMjj5s3IBxuq2XA+OUrMFN51HjPu2CgxjvyIWw7Ro+IYY6YgXXSeWkHXVuPODQ8ZNRUdGo8sUgikEJWIlS4DJNh+OhSf3sJL+Tnr7JBFYqH0YUyBBtVOT32lvo+ItZNT6/h93UxyxwCXT6UxG62G13uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272747; c=relaxed/simple;
	bh=4kgZK9PEsWHNk3PqlA9LLgsQrG06zbKbx2metOUutm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vvd99bJPu5p/jGepu/+/XovXnnTGdgHA6SsCvDWvk0zKHCl6IGMLqj0zpez+Ylm22V/ZsBeX9Ww2bmp3MGzCxFUYry2maaBVb7ID+0mJ674lfce1u4PDHIuAL/IUBmBP6kNC8NZ/XXxg4n1iyqVzc4fT2tyo177Z3QNa6TGK5F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJGRP0pg; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8802b66c811so54969426d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762272745; x=1762877545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gn2hwuUiPC8/Q2G266HcOJ5nNM1p+pgOQFA8M+yNExQ=;
        b=VJGRP0pgYy+/Z0UptJz1aN1gwHkKHBTBNX0NmVYA6zq0Rww8DpYBUjuOVF0Q3LJKLj
         Zb0OAzCugbpP/hU3q9uH7VXhq65R1TjJsKNSc9HErbn9geGD2RTQvp4w8iO+TQhYQFqt
         zND7ECaGfDUICPJVPmhEwXhkVg92J3RLvlWeBz0I4lyButkuvg2NK4sKDfNTUzSxhGAC
         s50mDobzRaeRPPDeaJ3+laqUtShPTQpr7u8flAt6xJIBIUpikhMtdihGSVqEH7C8T0kG
         P0L0Doo9jamDUzYEckJ7yOvpi64FnolBu6alTIBQbPCIQtVlWBtRRaCYA7Zl5hvjQ4EI
         4U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762272745; x=1762877545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gn2hwuUiPC8/Q2G266HcOJ5nNM1p+pgOQFA8M+yNExQ=;
        b=ivZ8alRsiwL6Q+0/6Dgu/q5BGkGqjQgw0U0r2pILQXTCHNa7Pjx0hGfTBmIRNsqXZb
         qjVKp8hDQctteLk77A10wgB1CvsSrCiRU5B/m0k6lA8X7LX87ugXzG+ccVSDvjeW6IKW
         fpPyWQrRT+qk1F7vRsJwL44qYltZHqZzMtZPI6doZuou8PaeXd90Y811grgJoyBc1Gfi
         ThBDIoyKBn8Vmf7S8YNncEIiBGcxL715bxgrNmfcT4PGdIN/KiYZnYOqN84o2eONak6d
         P0N3yptm1DbKwXDRUxPLRCGPrP8Dwc6hcQzY2pTMfgsI8PRs+XW7hgr2a+4nCBzJ4DIK
         GFIw==
X-Forwarded-Encrypted: i=1; AJvYcCUNKz2tnQte4SONG63At29uWblu57sZVcHXXWY2ix/1ccCV0VG4G8NZavvnoT7AsZqsLtglAhfjIoPgnPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ImEG11zefud38E2DQXBJ15g6dv8tv2nQjviW6xzggrtoIDNd
	Q+92ZDta+nGfDV47JzTPnNVzfkkk3CLvK81WCYcnK2Jg3N+tCLo9iZdxeJPPrhEV8joJw/zqUaX
	tR7mFMs36JWuk2/aC8yBeG5bvSAXdOVg=
X-Gm-Gg: ASbGnctIyQv7D4p7VUUdVkB7/1D9d8FTbsa1Bdn88fMiktY3bpQHnlz1sqqAmCXXMVJ
	hlNlyEXQ8kjsdZaSxYjHqS+gliIk4ZaQG1lSwKrEaGkjeQwoQarpjoFk9IK9sXME/Tjx1gMOEtU
	yh16f8X67IhG2dtygPs5xkd8US8EQDNLwIzWqIoqRJHKE1bOBE5WDJwkiutCaXmlonCYV0kRKCS
	IsyW7VpTiScW6a8dD3X9EcT5tqrOrF/4S74Yg/Rrgvkc6mLGekkN1WFCDH1v0hqmLneXeSEygAe
	nJPPoqyGomELDxfdlkjxbRHTvX97qWtNguwYrgkiPaklfUIakVL+5Awvzn67ph6oeY0HnIiKwjs
	DTxeD0kE6WfE1pKTl5zFteOppsZmFklYMg0kRS4A=
X-Google-Smtp-Source: AGHT+IED+GjqaBe66KWozlF5qlUX46+UXTDSGyStL4Ec1xFghQ8tKmJeoeUM3fbVkK6cckiH8C39lCagfXCl3ojuYgM=
X-Received: by 2002:a05:6214:d63:b0:880:5365:46f3 with SMTP id
 6a1803df08f44-88071190af1mr1980246d6.48.1762272745039; Tue, 04 Nov 2025
 08:12:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQoYCxKqMHwH4sOK@osx.local>
In-Reply-To: <aQoYCxKqMHwH4sOK@osx.local>
From: Steve French <smfrench@gmail.com>
Date: Tue, 4 Nov 2025 10:12:13 -0600
X-Gm-Features: AWmQ_bnENIVd9iuIwtt-CFvdgGVQlHaSwLipDA4bB04baKUxG5zWSRWEKYEzUVY
Message-ID: <CAH2r5mu7s4p88RhUbCm5mqUvEVM60OOTTJOZ+rz09nFfc+t3mQ@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix refcount leak in smb2_set_path_attr
To: Shuhao Fu <sfual@cse.ust.hk>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There are multiple callers - are there callers that don't call
"set_writeable_path()" ?    And so could cause the reverse refcount
issue?

On Tue, Nov 4, 2025 at 9:21=E2=80=AFAM Shuhao Fu <sfual@cse.ust.hk> wrote:
>
> Fix refcount leak in `smb2_set_path_attr` when path conversion fails.
>
> Function `cifs_get_writable_path` returns `cfile` with its reference
> counter `cfile->count` increased on success. Function `smb2_compound_op`
> would decrease the reference counter for `cfile`, as stated in its
> comment. By calling `smb2_rename_path`, the reference counter of `cfile`
> would leak if `cifs_convert_path_to_utf16` fails in `smb2_set_path_attr`.
>
> Fixes: 8de9e86c67ba ("cifs: create a helper to find a writeable handle by=
 path name")
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
> ---
>  fs/smb/client/smb2inode.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 09e3fc81d..69cb81fa0 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -1294,6 +1294,8 @@ static int smb2_set_path_attr(const unsigned int xi=
d, struct cifs_tcon *tcon,
>         smb2_to_name =3D cifs_convert_path_to_utf16(to_name, cifs_sb);
>         if (smb2_to_name =3D=3D NULL) {
>                 rc =3D -ENOMEM;
> +               if (cfile)
> +                       cifsFileInfo_put(cfile);
>                 goto smb2_rename_path;
>         }
>         in_iov.iov_base =3D smb2_to_name;
> --
> 2.39.5 (Apple Git-154)
>
>


--=20
Thanks,

Steve

