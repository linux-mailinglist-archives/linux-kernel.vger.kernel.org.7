Return-Path: <linux-kernel+bounces-817001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BD3B57C33
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C87188EBFE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DFC30CDA3;
	Mon, 15 Sep 2025 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTOIrfAO"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6C2D595F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941288; cv=none; b=QI1+6+ReUugruaK9rBbBcxTZ6OMwwMmJGsMWtjAabDgd7/1/AYKuquEaVfuHKRV3OcnoVplZ9Ss2NuvUf3AHr6a/s8A7Y+XTjhed80BPh13O6xeppRdTA5lNkNPHPfRqqPjYekBFWgCVgT8qznjJKCh8ViYGFRxNeMkC9KiPzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941288; c=relaxed/simple;
	bh=Ezck4rxHmKWprPtVv6zuENk42dYeOqTjH8/o6r/ii4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mcx8M6HAa3LZsgNnMn0aqztp0nYASDLewksTOsH+749GkdZMIniliwmNeA+y1KgLUzdS4d6MOmt0qWHBBqCq1Fo8AFEXLFxwfGWR2U4q39tx2YhSsSUQHUwD5IQg6inECen5+PwUJTlTIg2HUT0HQGD9bq8sz2ZUunTV6EyT0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTOIrfAO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0473327e70so63853066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757941284; x=1758546084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45EkO46Qi4HHLwvj2lt+pH5doVvI2GU4+2jW47Bc4qI=;
        b=JTOIrfAOOE5kGV849J2cav3nPNeYiAtEddxNMQ0BsIUqUFc7DTTeC8r2j3369n0mJr
         0ZO1yYJOjNi4/bCSRa/BoI12aiT3mzsz/MHqbbvBmXZj/6+gmGs79hLtQIDyU73GPHUS
         PtSXnO8jgRFnxpfP84HaCU4t780goZhwxCqNlq3m9hNRFSsABg+zfUr7ZiKbOeKu/f0o
         uYh91dXUY+P7PrijOs9x666JxKGWPD2yralG9rHZLE8uzjRpLnTKZ1JSUj0R3KPhuksn
         P8kFccLw+O/mj9rJAQZ08wLJg7YzpFAYR2EwtlGbfOcCMI1I4XexQHXIJEmb9VUWhefD
         y7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757941284; x=1758546084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45EkO46Qi4HHLwvj2lt+pH5doVvI2GU4+2jW47Bc4qI=;
        b=WhMO/GrJP+9BpAY0jN43PpFAf+5kowZiIq+idR1w0BS7Z3Tioc2xfbMUD4phAsYqY/
         xljCFsfQ07yYxw+vK0MFDqyQRWs/hpKSD1iHAGm3XP9hVXz2OPzF2FUd8VABn6tQK+h1
         U6QGbdh65ow1HnH2P9Nl9ObAMJHw9PO7895DfFscA1zg+4P9XRQA+FAca3EdV9XyIxRd
         u2UhZrkR+Rx1MrbjiTBOw0yJB9+Y28NN8dHYOUk3yex2MFv8IWriIGde6tEGUMJoNu0J
         cS+XgFr3gktQlg2HL0HA2zq6/yiM3MP/WP1E90dQPO4g9VqMJVjp2ZYi5Ll+IPsUTpzC
         DXww==
X-Forwarded-Encrypted: i=1; AJvYcCXV3Xh7dS5MckcuhdSekjWFsIt68qVf9lDalQqMNy99znEBQ1yv+F4rZ0Z1Tv6jRROrzcz93inmxVM+k0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+vxuU+wUVHNsNhjvM1EClEv19eDBvPkOjTDxxIR1AHgbDHtY
	SA9bvU9aJylxM2NsD5xQkUCfolVf6bm5vvurkJSIRVOtv3tDLyrRheK5TC9MMXiUzsUTn/InVUx
	99PEOSimli9JeRSuFwPYodwpthPcg3X0=
X-Gm-Gg: ASbGncsxd6ykv1CqL3hXxJaN/kWULj5Qpq9+lJKFuX7+NxZG57EQGhupUY7AcGMQcYK
	ZjwIpRKZfQW8svtFu3bp/XtXcFbv928Eb5B7ImIj5n+0oVDMFVy7lrzyJ5+ze3cGnT4At6AP4zn
	V7AkbFAjvJlluHgCi3sF0txGpZD42lqu87IKdIlBHoLTyCIIk4Ui6KKnREfILWjzzpPNECddAoH
	eUp6y1VzXIiEt9bneK2MfFgOiDP5SWzP+ErKRobDA==
X-Google-Smtp-Source: AGHT+IE0pshEQPchml3qLxCQRHDuqtH5L0cKDhGMqDazan4WSLspsvjhpC/hBVR8LmkWJPiNu+ARl65uKQLFDi+LdeQ=
X-Received: by 2002:a17:907:3e1e:b0:afe:9777:ed0e with SMTP id
 a640c23a62f3a-b07c3356e47mr1254804766b.0.1757941284123; Mon, 15 Sep 2025
 06:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915101510.7994-1-acsjakub@amazon.de>
In-Reply-To: <20250915101510.7994-1-acsjakub@amazon.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Sep 2025 15:01:13 +0200
X-Gm-Features: Ac12FXzOnPQ5wHS4xu7aVNWoFlUIY1GgVl-UQpmig0p0kiDTzt7kJQ5EB_XHWw8
Message-ID: <CAOQ4uxgXvwumYvJm3cLDFfx-TsU3g5-yVsTiG=6i8KS48dn0mQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: check before dereferencing s_root field
To: Jakub Acs <acsjakub@amazon.de>, Jan Kara <jack@suse.cz>
Cc: linux-unionfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 12:15=E2=80=AFPM Jakub Acs <acsjakub@amazon.de> wro=
te:
>
> Calling intotify_show_fdinfo() on fd watching an overlayfs inode, while
> the overlayfs is being unmounted, can lead to dereferencing NULL ptr.
>
> This issue was found by syzkaller.
>
> Race Condition Diagram:
>
> Thread 1                           Thread 2
> --------                           --------
>
> generic_shutdown_super()
>  shrink_dcache_for_umount
>   sb->s_root =3D NULL
>
>                     |
>                     |             vfs_read()
>                     |              inotify_fdinfo()
>                     |               * inode get from mark *
>                     |               show_mark_fhandle(m, inode)
>                     |                exportfs_encode_fid(inode, ..)
>                     |                 ovl_encode_fh(inode, ..)
>                     |                  ovl_check_encode_origin(inode)
>                     |                   * deref i_sb->s_root *
>                     |
>                     |
>                     v
>  fsnotify_sb_delete(sb)
>
> Which then leads to:
>
> [   32.133461] Oops: general protection fault, probably for non-canonical=
 address 0xdffffc0000000006: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> [   32.134438] KASAN: null-ptr-deref in range [0x0000000000000030-0x00000=
00000000037]
> [   32.135032] CPU: 1 UID: 0 PID: 4468 Comm: systemd-coredum Not tainted =
6.17.0-rc6 #22 PREEMPT(none)
>
> <snip registers, unreliable trace>
>
> [   32.143353] Call Trace:
> [   32.143732]  ovl_encode_fh+0xd5/0x170
> [   32.144031]  exportfs_encode_inode_fh+0x12f/0x300
> [   32.144425]  show_mark_fhandle+0xbe/0x1f0
> [   32.145805]  inotify_fdinfo+0x226/0x2d0
> [   32.146442]  inotify_show_fdinfo+0x1c5/0x350
> [   32.147168]  seq_show+0x530/0x6f0
> [   32.147449]  seq_read_iter+0x503/0x12a0
> [   32.148419]  seq_read+0x31f/0x410
> [   32.150714]  vfs_read+0x1f0/0x9e0
> [   32.152297]  ksys_read+0x125/0x240
>
> IOW ovl_check_encode_origin derefs inode->i_sb->s_root, after it was set
> to NULL in the unmount path.
>
> Minimize the window of opportunity by adding explicit check.
>
> Fixes: c45beebfde34 ("ovl: support encoding fid from inode with no alias"=
)
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-unionfs@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>
> I'm happy to take suggestions for a better fix - I looked at taking
> s_umount for reading, but it wasn't clear to me for how long would the
> fdinfo path need to hold it. Hence the most primitive suggestion in this
> v1.
>
> I'm also not sure if ENOENT or EBUSY is better?.. or even something else?
>
>  fs/overlayfs/export.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb1567..424c73188e06 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -195,6 +195,8 @@ static int ovl_check_encode_origin(struct inode *inod=
e)
>         if (!ovl_inode_lower(inode))
>                 return 0;
>
> +       if (!inode->i_sb->s_root)
> +               return -ENOENT;

For a filesystem method to have to check that its own root is still alive s=
ounds
like the wrong way to me.
That's one of the things that should be taken for granted by fs code.

I don't think this is an overlayfs specific issue, because other fs would b=
e
happy if encode_fh() would be called with NULL sb->s_root.

Jan,

Can we change the order of generic_shutdown_super() so that
fsnotify_sb_delete(sb) is called before setting s_root to NULL?

Or is there a better solution for this race?

Thanks,
Amir.

