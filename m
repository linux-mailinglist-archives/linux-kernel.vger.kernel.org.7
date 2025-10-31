Return-Path: <linux-kernel+bounces-879358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DE1C22EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 662754EE2BF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0A535958;
	Fri, 31 Oct 2025 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr05KAS4"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8862690D9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875630; cv=none; b=uKCgzbsTPJPejKl3W+eSdo4UKvusxccoH0a9AhOyT+2TaWcPoZhUmH7mLNgfbUWnhqNtmKz78FAggaGqJSJjT4hmxlGq7nfxtFbYuooEnGnsYaMo04cX135yad+yXQD0++cLtSFmkPT8iVKSyBpeL2aObVQKVNhWbTsBEixgPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875630; c=relaxed/simple;
	bh=TkEQdgncQmkZUdZTHYsv8Q32LmvRLVsL4ht2RzwEteA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1MnW9dma9MkgkVDRnI189srNGyEtpHPJmjcKi39FizHcU3MX0KqM8k9f1oJVBFBqaL3E27oZqj3Jd3t1aLQbfezKUYlA+f94qw3xZubhbCmbn902GFKavw7jD0DOD7XjNqJjLjWcMbsf5YTWoCz69RSzhYlRv553iHDVuucu6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr05KAS4; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88021e1abc4so11957306d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761875627; x=1762480427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iu/I3TTkFlE7Ln/q4osrgcC6+jKW4F1NfjqmlswaX70=;
        b=Dr05KAS4yU69+ks94w38f3MDAFKy2GufNt81TISftPKDg3yRetqO20raMNPRxG0FeW
         sj7JdLrnTyhIUBHz1av0sae05/+VPSLveCujwwR83vs6nGuDYMtWAmgvrvTxuQml9Mqd
         iqsDT4JWsM3WxUi+8+Khu0Rvh1TuIgIRnBue1bayWvsnBbTz4DyehXNX3PpoQW54sX14
         VFm6lZ3OW5U8+rQQelbVmPzTM5cffYkrGih/mmb7ZdIyLYL9yQDBqw7wKpsOVFBN9eYE
         7/lmnerJpxw2HXQZrkxKRBABXyEc0/xTjma1HXVsBYsqyChmOhFlBD5iP5n5XK0IaI0w
         BjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761875627; x=1762480427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iu/I3TTkFlE7Ln/q4osrgcC6+jKW4F1NfjqmlswaX70=;
        b=RM5SYw2u9KX9SxWq997AZXS/JwvXc+1a2FvD2EFpsbHuycEbIqoKxTG+6EyCvByVad
         tsLdOa0eprkxaofOUtzcUSynNTlmI1ih4bkPJ/k1sPvTLBVx+325bfTzcrPC4Zp45dOY
         /C0gcGXrLfG8As7IZn9AY8BlXireQYNSBtHmdpySTEjdfzHH9oyKEtYyVAgC6M0Xme+u
         KEky97EhIaT8VPGdMjzlwOcFJNzM0RwZE94RsJo5wXpp58rCdIxXoubRGchanav39lkb
         2VE+KhRNiNl9IdLEF/BOus3P16AiU1tlaOHwJZ1UvVr01up9uOzUMc6tmbuqnp2rWvtG
         +a4A==
X-Forwarded-Encrypted: i=1; AJvYcCVUWbLjK67rPpy3yoK7jPkL69tsIRJqBOmQhNUKAyK2hFpgRWvbMHzHklB95+3iM/FSAa+rR2AHZrJe10I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRNSyeaQOtdtzsaI/od/h0epKgzY6T6s5jC4nZIo1M0StMzh7m
	1kXPhfRu3MPLIZsZfO9t0Y+7kRIUQW37OSfwBaJqh/U23XGa1UUiiVUoPwB8rfK8U6jpzUHL4h5
	w3jMUhuQAlmCHKt+bkaM/zoWpH3k6aKk=
X-Gm-Gg: ASbGncvxqi/TS/YD6qSrIBMRc/ozefCl+ZEaL4u6KmAse96xBdPvObFWVZOwBE6AMqm
	O3Jm2MSxrSfEInYhtlVkSTXDkmXMQxgoMbZ8zNf+JaXyUwdVbF0lxsFT3zUj32ygQ9ggBPTRVlZ
	txxcOnPbWfDZsQ6chOD4PZqZFX8AivsZvkBLoJWh2wN9USSPUWA9tBSuO3bu/APDxWj7soFc+hY
	fQUTvEpkw6KNWU0RyKb8G3iMDU9NRqunxo3SLuNxrrpI3cqSAM/8c2f5MNMm1IRgs7uqo1zR92k
	Od1yHzQTCUZ1hkA820xS+Surjtaf8OJgwQJe8kxffTdA7xCJz+si63xooq/2tUWMQQiPmY72lTr
	K0p11m1v/+2zUtngi3DtJXRTFRspZ0sL9yHbBN8tMuYAr7eRV4BZqelXAzWxhnkvO0g8fNuNEK6
	M=
X-Google-Smtp-Source: AGHT+IG5pz3OzOV3AfykrpxWJkruh3Ti/8oCPc/nhWC4s4ja6Tx8ik9tDtB3p4StJ521sZet60OOtjsBY5QWeHuk8AY=
X-Received: by 2002:a05:6214:19e7:b0:880:2248:3a09 with SMTP id
 6a1803df08f44-8802f2f6ae0mr21289276d6.22.1761875627264; Thu, 30 Oct 2025
 18:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251027072206.3468578-1-chenxiaosong.chenxiaosong@linux.dev>
 <a0d97e2d-91f5-448c-883c-4d0930375f82@linux.dev> <CAH2r5mtHXDuKUSvZ5TZU1f6WnQaH5Dz59=z29ABJsOYmric+1Q@mail.gmail.com>
In-Reply-To: <CAH2r5mtHXDuKUSvZ5TZU1f6WnQaH5Dz59=z29ABJsOYmric+1Q@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 30 Oct 2025 20:53:34 -0500
X-Gm-Features: AWmQ_bn8ZtwkKQDRKtPaCIoFD8q7imAFDtOKuBdMxk4l8Sbiu0PLwLreE1eYthU
Message-ID: <CAH2r5muwP4uyELKDNrRGU+8YgwNurb1+jQb+5CYOcU74LZhj3w@mail.gmail.com>
Subject: Re: [PATCH v4 15/24] smb: move FILE_SYSTEM_POSIX_INFO to common/smb1pdu.h
To: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>, =?UTF-8?B?UmFscGggQsO2aG1l?= <slow@samba.org>
Cc: sfrench@samba.org, linkinjeon@kernel.org, linkinjeon@samba.org, 
	christophe.jaillet@wanadoo.fr, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry forgot to attach the link

https://gitlab.com/samba-team/smb3-posix-spec

On Thu, Oct 30, 2025 at 8:53=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> Ralph,
> Is this link current? or do you have the link to a more current
> version of the POSIX extensions documentation?
>
> On Thu, Oct 30, 2025 at 8:42=E2=80=AFPM ChenXiaoSong
> <chenxiaosong.chenxiaosong@linux.dev> wrote:
> >
> > Hi Namjae and Steve,
> >
> > I couldn=E2=80=99t find the definition of FILE_SYSTEM_POSIX_INFO in any=
 of the
> > following MS documents:
> >
> >    - MS-FSCC:
> > https://learn.microsoft.com/pdf?url=3Dhttps%3A%2F%2Flearn.microsoft.com=
%2Fen-us%2Fopenspecs%2Fwindows_protocols%2Fms-fscc%2Ftoc.json
> >    - MS-CIFS:
> > https://learn.microsoft.com/pdf?url=3Dhttps%3A%2F%2Flearn.microsoft.com=
%2Fen-us%2Fopenspecs%2Fwindows_protocols%2Fms-cifs%2Ftoc.json
> >    - MS-SMB:
> > https://learn.microsoft.com/pdf?url=3Dhttps%3A%2F%2Flearn.microsoft.com=
%2Fen-us%2Fopenspecs%2Fwindows_protocols%2Fms-smb%2Ftoc.json
> >    - MS-SMB2:
> > https://learn.microsoft.com/pdf?url=3Dhttps%3A%2F%2Flearn.microsoft.com=
%2Fen-us%2Fopenspecs%2Fwindows_protocols%2Fms-smb2%2Ftoc.json
> >
> > Is this structure defined in other MS document?
> >
> > On 10/27/25 3:21 PM, chenxiaosong.chenxiaosong@linux.dev wrote:
> > > From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> > >
> > > Rename "struct filesystem_posix_info" to "FILE_SYSTEM_POSIX_INFO",
> > > then move duplicate definitions to common header file.
> > >
> > > Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> > > ---
> > >   fs/smb/client/cifspdu.h    | 22 ----------------------
> > >   fs/smb/common/smb1pdu.h    | 23 +++++++++++++++++++++++
> > >   fs/smb/server/smb2pdu.c    |  4 ++--
> > >   fs/smb/server/smb_common.h | 23 -----------------------
> > >   4 files changed, 25 insertions(+), 47 deletions(-)
> > >
> > > diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
> > > index d106c6850807..55aaae6dbc86 100644
> > > --- a/fs/smb/client/cifspdu.h
> > > +++ b/fs/smb/client/cifspdu.h
> > > @@ -1875,28 +1875,6 @@ typedef struct {
> > >
> > >   #define CIFS_POSIX_EXTENSIONS           0x00000010 /* support for n=
ew QFSInfo */
> > >
> > > -typedef struct {
> > > -     /* For undefined recommended transfer size return -1 in that fi=
eld */
> > > -     __le32 OptimalTransferSize;  /* bsize on some os, iosize on oth=
er os */
> > > -     __le32 BlockSize;
> > > -    /* The next three fields are in terms of the block size.
> > > -     (above). If block size is unknown, 4096 would be a
> > > -     reasonable block size for a server to report.
> > > -     Note that returning the blocks/blocksavail removes need
> > > -     to make a second call (to QFSInfo level 0x103 to get this info.
> > > -     UserBlockAvail is typically less than or equal to BlocksAvail,
> > > -     if no distinction is made return the same value in each */
> > > -     __le64 TotalBlocks;
> > > -     __le64 BlocksAvail;       /* bfree */
> > > -     __le64 UserBlocksAvail;   /* bavail */
> > > -    /* For undefined Node fields or FSID return -1 */
> > > -     __le64 TotalFileNodes;
> > > -     __le64 FreeFileNodes;
> > > -     __le64 FileSysIdentifier;   /* fsid */
> > > -     /* NB Namelen comes from FILE_SYSTEM_ATTRIBUTE_INFO call */
> > > -     /* NB flags can come from FILE_SYSTEM_DEVICE_INFO call   */
> > > -} __attribute__((packed)) FILE_SYSTEM_POSIX_INFO;
> > > -
> > >   /* DeviceType Flags */
> > >   #define FILE_DEVICE_CD_ROM              0x00000002
> > >   #define FILE_DEVICE_CD_ROM_FILE_SYSTEM  0x00000003
> > > diff --git a/fs/smb/common/smb1pdu.h b/fs/smb/common/smb1pdu.h
> > > index 82331a8f70e8..38b9c091baab 100644
> > > --- a/fs/smb/common/smb1pdu.h
> > > +++ b/fs/smb/common/smb1pdu.h
> > > @@ -327,6 +327,29 @@ typedef struct {
> > >       __le32 BytesPerSector;
> > >   } __packed FILE_SYSTEM_INFO;        /* size info, level 0x103 */
> > >
> > > +typedef struct {
> > > +     /* For undefined recommended transfer size return -1 in that fi=
eld */
> > > +     __le32 OptimalTransferSize;  /* bsize on some os, iosize on oth=
er os */
> > > +     __le32 BlockSize;
> > > +     /* The next three fields are in terms of the block size.
> > > +      * (above). If block size is unknown, 4096 would be a
> > > +      * reasonable block size for a server to report.
> > > +      * Note that returning the blocks/blocksavail removes need
> > > +      * to make a second call (to QFSInfo level 0x103 to get this in=
fo.
> > > +      * UserBlockAvail is typically less than or equal to BlocksAvai=
l,
> > > +      * if no distinction is made return the same value in each
> > > +      */
> > > +     __le64 TotalBlocks;
> > > +     __le64 BlocksAvail;       /* bfree */
> > > +     __le64 UserBlocksAvail;   /* bavail */
> > > +     /* For undefined Node fields or FSID return -1 */
> > > +     __le64 TotalFileNodes;
> > > +     __le64 FreeFileNodes;
> > > +     __le64 FileSysIdentifier;   /* fsid */
> > > +     /* NB Namelen comes from FILE_SYSTEM_ATTRIBUTE_INFO call */
> > > +     /* NB flags can come from FILE_SYSTEM_DEVICE_INFO call   */
> > > +} __packed FILE_SYSTEM_POSIX_INFO;
> > > +
> > >   /* See MS-CIFS 2.2.8.2.5 */
> > >   typedef struct {
> > >       __le32 DeviceType;
> > > diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
> > > index 47fab72a3588..dc0f0ed4ccb6 100644
> > > --- a/fs/smb/server/smb2pdu.c
> > > +++ b/fs/smb/server/smb2pdu.c
> > > @@ -5633,14 +5633,14 @@ static int smb2_get_info_filesystem(struct ks=
mbd_work *work,
> > >       }
> > >       case FS_POSIX_INFORMATION:
> > >       {
> > > -             struct filesystem_posix_info *info;
> > > +             FILE_SYSTEM_POSIX_INFO *info;
> > >
> > >               if (!work->tcon->posix_extensions) {
> > >                       pr_err("client doesn't negotiate with SMB3.1.1 =
POSIX Extensions\n");
> > >                       path_put(&path);
> > >                       return -EOPNOTSUPP;
> > >               } else {
> > > -                     info =3D (struct filesystem_posix_info *)(rsp->=
Buffer);
> > > +                     info =3D (FILE_SYSTEM_POSIX_INFO *)(rsp->Buffer=
);
> > >                       info->OptimalTransferSize =3D cpu_to_le32(stfs.=
f_bsize);
> > >                       info->BlockSize =3D cpu_to_le32(stfs.f_bsize);
> > >                       info->TotalBlocks =3D cpu_to_le64(stfs.f_blocks=
);
> > > diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
> > > index 6141ca8f7e1c..61048568f4c7 100644
> > > --- a/fs/smb/server/smb_common.h
> > > +++ b/fs/smb/server/smb_common.h
> > > @@ -108,29 +108,6 @@ struct file_id_both_directory_info {
> > >       char FileName[];
> > >   } __packed;
> > >
> > > -struct filesystem_posix_info {
> > > -     /* For undefined recommended transfer size return -1 in that fi=
eld */
> > > -     __le32 OptimalTransferSize;  /* bsize on some os, iosize on oth=
er os */
> > > -     __le32 BlockSize;
> > > -     /* The next three fields are in terms of the block size.
> > > -      * (above). If block size is unknown, 4096 would be a
> > > -      * reasonable block size for a server to report.
> > > -      * Note that returning the blocks/blocksavail removes need
> > > -      * to make a second call (to QFSInfo level 0x103 to get this in=
fo.
> > > -      * UserBlockAvail is typically less than or equal to BlocksAvai=
l,
> > > -      * if no distinction is made return the same value in each
> > > -      */
> > > -     __le64 TotalBlocks;
> > > -     __le64 BlocksAvail;       /* bfree */
> > > -     __le64 UserBlocksAvail;   /* bavail */
> > > -     /* For undefined Node fields or FSID return -1 */
> > > -     __le64 TotalFileNodes;
> > > -     __le64 FreeFileNodes;
> > > -     __le64 FileSysIdentifier;   /* fsid */
> > > -     /* NB Namelen comes from FILE_SYSTEM_ATTRIBUTE_INFO call */
> > > -     /* NB flags can come from FILE_SYSTEM_DEVICE_INFO call   */
> > > -} __packed;
> > > -
> > >   struct smb_version_ops {
> > >       u16 (*get_cmd_val)(struct ksmbd_work *swork);
> > >       int (*init_rsp_hdr)(struct ksmbd_work *swork);
> >
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

