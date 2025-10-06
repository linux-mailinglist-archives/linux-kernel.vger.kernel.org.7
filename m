Return-Path: <linux-kernel+bounces-843259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C3FBBEC70
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D57B189B078
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FEE225415;
	Mon,  6 Oct 2025 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM2ba2ZQ"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F23221543
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770452; cv=none; b=XI2d2IorLGcje8UKdUOqm/5rJ5mhUt7zku9//1K05ajiSY65h1w/6WibXXSAaJ7R1EbYYld85cdjbEQG/OJZhJGwAffo9jVilxeHNyn6ySTEQqiiX10q0g/bqZxWKewQadSTGDV0FnaLlAPfWKgEyMCUJ6aK4h2cnu9Itndd1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770452; c=relaxed/simple;
	bh=rlFixZbJvnpPw6lVlYW5Kt3QbvdLM3zAzGBrPPHtZ1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnqivnPY5l56nWn8+UIIwR4znj0775iHctKWJLOtC6PTss67rVJOAzrVzKTsC8i3gaUHFjqL848Wo+qNfGlhKdchlAh4YW4OR/OySrXionMg6xl9AZSKYgODOD7ZIH0OB1davY4L4yfL7sldjNTMuNFPNnmDDdeN+76fjttVOls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LM2ba2ZQ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7ea50f94045so64534736d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759770450; x=1760375250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKKNkmcBQxnFeZkKNYdKplHNGJ08onMcowwhJIAvhnQ=;
        b=LM2ba2ZQs/uZ2xGopms6MOc8QJQ6lP48Wc7WS393kjHNQR5SPLGB27f/xBrdAzi4GU
         Mp7TMTcLynLGdanXOorYaBQS/lvuP44tuTkd8JFZizHJ1hfMIuswz8eqCO1blWh/fNe+
         1VI/Aq35OhvEK/9knf5qPUQ9DXwdG4aYxbh9chGJ42NH5WGyZ6Pa4+NFmm5VHGhZzR72
         tueeYbJN4vHOhMXN9s+ddvw0kTL8HOkNq7Ojk6tuL4GXPgTVXvopBgH5nOq8WzU4getL
         skrgIm6Zykhianx3zDQi55vfEomsVX7Qrxgcmn++7UWLwSo2/tIYw/LuGSH1LTc921qx
         tR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759770450; x=1760375250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKKNkmcBQxnFeZkKNYdKplHNGJ08onMcowwhJIAvhnQ=;
        b=JJUmXCrKhi/kQ/hvlw6nz++c7w7yokWVajKMzeyDrhpC9OGZuH8TgVtLWJqJW+X/52
         IuXcceSeoxESx+K7bjulNknRpfLxt4HQSgTO79cDwxk0Ul1l283VHfbgWP/jnrsEsE2T
         RbXkLTJ1XoB0d7qv/zzB7cakXJYbMcv2QwI5w6u49uN3zCTFsr55+5SYKwCgLdiFy6PD
         vXMKfDuj3dYYgVQaktgeeZOr4frm8elSdptYj9OY5cK9Wtx+1umTFxgUXzfvenVFj5BH
         QUwqRPnigx0gObSa996Y8hCF47YMEtdUAIV7p26LJU4EzRe9rigZDVzNb3iqBD6Onijw
         cyUg==
X-Forwarded-Encrypted: i=1; AJvYcCW21N2ch0L7J2vR+INyVhR6o3euW0pjFtP/IXuJ7VlVhkMf4ScXvC8naw2M9pnWcRBRYax4W8NKpmiV0rU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfs//hUmjzh9u9bpFHQVVnPRBAItjZFnBl2+XLtIRYligmLuuW
	6GZj4hzErmoRAgltarI8ExAxjIZ4Nxp93wCwS0J30uUdJh9UqY4GQ+5kLTtubPGvy2yj+4NZyf+
	yJi4tSYzt6LBI/eQlZLGdpKEIwsMOzyc=
X-Gm-Gg: ASbGncsTepP4LzAKPq4R894tbOYHd30/sPOU+VNlWxmuJDL3BQ8MKYKSJzDLw5gGpOs
	Dwzy6eH1gg+sq8Cyg0atJW9RLGSwdKtt0TwRPjYnZM7MHQ5pWpL1qfJP5dGrNwWHyZzjyUmxcnM
	vTp017FofMy4CV4E3YXwbHVimIDi2wPHjt7wiFXrDpThR90E83d15BCH5mqmagSmJh0EvfzuVMt
	PFRZZxhMsij0jIVT2EQcNh6Ox2mjEN1XflmBMvYvSk4o/gjzLJqDu1v0ZhmWjKCd3LfNnZrySTJ
	Y0TVkHX8Tt1vWQPJS6vERwe0f94wG1m2PsyZJBN8aJmhXMnq8mP2lzWot79SdTSy9rpeNN6BFsF
	LjDNjn/wEKnSbnZx7+zIZ6uovDkzJ68QgfwmuDnBvfOOnDA==
X-Google-Smtp-Source: AGHT+IEPISwSCtFAAyFwofIFOPnmbMbF4JyOJ066gMSsxLm13Rxv+HKDa92QBeQD2yMdtcQya1taGWfxC/jbAWm/jgE=
X-Received: by 2002:a05:6214:d02:b0:875:2636:4bd5 with SMTP id
 6a1803df08f44-87a052412damr4657666d6.20.1759770450151; Mon, 06 Oct 2025
 10:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <468cf96a-5dd9-4aa5-a8ce-930cf16952b3@web.de> <8e79516d-ad82-46bd-af00-3a8594a0baee@suse.com>
In-Reply-To: <8e79516d-ad82-46bd-af00-3a8594a0baee@suse.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 6 Oct 2025 12:07:18 -0500
X-Gm-Features: AS18NWCiMwnwOYL0R_azJWeM_ATvaFnKnhpK_Wr3r0REf2iO_ANzlxxIqrNli6g
Message-ID: <CAH2r5mvNM+z6re5toyNOJXewE0=9u2f+xxPXO5xTsMCj5nUWTw@mail.gmail.com>
Subject: Re: [PATCH] smb: client: Reduce the scopes for a few variables in two functions
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-cifs@vger.kernel.org, 
	Bharath SM <bharathsm@microsoft.com>, Paulo Alcantara <pc@manguebit.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Mon, Oct 6, 2025 at 9:11=E2=80=AFAM Henrique Carvalho
<henrique.carvalho@suse.com> wrote:
>
> Acked-by: Henrique Carvalho <henrique.carvalho@suse.com>
>
> On 10/5/25 2:10 PM, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sun, 5 Oct 2025 19:01:48 +0200
> >
> > * cifs_lookup():
> >   Move the definition for the local variable =E2=80=9Ccfid=E2=80=9D int=
o an else branch
> >   so that the corresponding setting will only be performed if a NULL in=
ode
> >   was detected during lookup by this function.
> >
> > * cifs_d_revalidate():
> >   Move the definition for the local variables =E2=80=9Cinode=E2=80=9D a=
nd =E2=80=9Crc=E2=80=9D into
> >   an if branch so that the corresponding setting will only be performed
> >   after a d_really_is_positive() call.
> >
> >   Move the definition for the local variable =E2=80=9Ccfid=E2=80=9D int=
o an else branch
> >   so that the corresponding setting will only be performed if further d=
ata
> >   processing will be needed for an open_cached_dir_by_dentry() call.
> >
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  fs/smb/client/dir.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> > index fc67a6441c96..7472fddadd4f 100644
> > --- a/fs/smb/client/dir.c
> > +++ b/fs/smb/client/dir.c
> > @@ -678,7 +678,6 @@ cifs_lookup(struct inode *parent_dir_inode, struct =
dentry *direntry,
> >       const char *full_path;
> >       void *page;
> >       int retry_count =3D 0;
> > -     struct cached_fid *cfid =3D NULL;
> >
> >       xid =3D get_xid();
> >
> > @@ -717,6 +716,8 @@ cifs_lookup(struct inode *parent_dir_inode, struct =
dentry *direntry,
> >       if (d_really_is_positive(direntry)) {
> >               cifs_dbg(FYI, "non-NULL inode in lookup\n");
> >       } else {
> > +             struct cached_fid *cfid =3D NULL;
> > +
> >               cifs_dbg(FYI, "NULL inode in lookup\n");
> >
> >               /*
> > @@ -785,15 +786,13 @@ static int
> >  cifs_d_revalidate(struct inode *dir, const struct qstr *name,
> >                 struct dentry *direntry, unsigned int flags)
> >  {
> > -     struct inode *inode =3D NULL;
> > -     struct cached_fid *cfid;
> > -     int rc;
> > -
> >       if (flags & LOOKUP_RCU)
> >               return -ECHILD;
> >
> >       if (d_really_is_positive(direntry)) {
> > -             inode =3D d_inode(direntry);
> > +             int rc;
> > +             struct inode *inode =3D d_inode(direntry);
> > +
> >               if ((flags & LOOKUP_REVAL) && !CIFS_CACHE_READ(CIFS_I(ino=
de)))
> >                       CIFS_I(inode)->time =3D 0; /* force reval */
> >
> > @@ -836,6 +835,7 @@ cifs_d_revalidate(struct inode *dir, const struct q=
str *name,
> >       } else {
> >               struct cifs_sb_info *cifs_sb =3D CIFS_SB(dir->i_sb);
> >               struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
> > +             struct cached_fid *cfid;
> >
> >               if (!open_cached_dir_by_dentry(tcon, direntry->d_parent, =
&cfid)) {
> >                       /*
>
> --
> Henrique
> SUSE Labs
>


--=20
Thanks,

Steve

