Return-Path: <linux-kernel+bounces-879356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE3C22EBC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E193A5FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B09126B77B;
	Fri, 31 Oct 2025 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvoeAXsx"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7120262815
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875599; cv=none; b=jVFDDarnAKJsij80WaqUzalK0p/4e1Q7G0+Bg0W+SmYoGBzS3MgYh2ZL7p7ca/vgj7RXsn2R1FgtkmBy8bkD6OsKOrWk9v6tcgu+Pi6A5iTuI9/iAuMsogvcSk7YPGZXcuPjj4NxJEhRjVOCYK4dcubz60CGwEQGQBQk32Qaj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875599; c=relaxed/simple;
	bh=BndDZ3lGhVxrBWvZR+9y4LHlu8s5nq9Xy22dfRdzcqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vx46ts2WL2KzpQgQOfL3uF2hYhAGf4wqQN8F7DbGhBuOvvv8aUWpmV0wLSzkZShfTGoiWAjFOiFDFxfYooiKTNYYh2gt0AQEtEnFcDRIpwZc1eIrInQDQrK47muTc4qG4BDEVSYpAUTKNnu+Gd1jYsVf0uOUuAkxuqDG5uQ8t+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvoeAXsx; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88021e1abc4so11953576d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761875596; x=1762480396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/USK4xlMFa4PneuHe9GpeYbrj+vpPqmzgo0m1/JhnSs=;
        b=bvoeAXsxLUJkkqrNK8+dXWCCPk3KX7b7BdTlJLusDylo/CP/dAwV4n2x2CMUKJYZnI
         2Gl3WKZQcFQq+mA9Ez2MKnJbT6OaA5MJLTrQeq3Ueb+FnUXt548LLe5pgmk0sOZNVIr/
         b64/C7F9TvJHoJP/vsRUWRXb5RpUaxzIOS5I1F2+Sg1CBqAYOumrUGw0pcQH7nLcSPhA
         QN828VGelOYgwnu0jjyxh5LXYvMQbL56encs3D628xrQS92aNtDlC20PMoVoqsHL2ZWK
         kTVcfeb//NJRTATOgxbTISt8h9SBJ4WNM4wNA1C5JRHexp2N1neP7miIgeKvSAwqGoSz
         997Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761875596; x=1762480396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/USK4xlMFa4PneuHe9GpeYbrj+vpPqmzgo0m1/JhnSs=;
        b=kQoQsfdM5Fm1NYsuE4Qw5T9aKcTs4OqL3CwJwJazLrjy4nl+y8ooI2rI4A3Bs7szx3
         HInPCDj9q+7fDrw0fbMtfcoChKV3RhHrwG2r3XV27DyFGidIcnY7v4W2+BcVFW+u+7Cw
         ES7OoBMQ+f7N6tDfJbD8dCb9rmXE9IXiPNLPGN2zo/+XtKEO3cz+JsfXTR1FLpZQ1BP+
         d6SISlf2BAfvvTxThb46wyMyb47eHAtCJC7pRmC5754ciUS7oaHWoibNfD2MMhFCFkjJ
         UNbWTFZ9xLyIJAPiQInwkDX70Wo4YZYufy8ZCHSy+ysuQl4PruivGOleR4NjW41KY+jb
         Rksw==
X-Forwarded-Encrypted: i=1; AJvYcCXNzOgecTIh1T6BkC/wRXvvAzdfbL2Vojlk5BXQk8KoK6jPeL4MqcSZYcQVhklOEo/NqY2zoam/QSXo7Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ2H3VghGuLRvVfbrr8hkwtGvKJ1XDKnlKWdux2GccGVmVbFEg
	CGMQa7porRroDJPswW6AjPRjiH3ctNN7F+UnRrGU60r6951qW3b7Dw4eWiTpvvxgE3pooPYmpV5
	beFLY+c0HDYgxbPie5tPrrcSGbAQp6D4=
X-Gm-Gg: ASbGncvE7zCAy6HKoAeBEpalTSLmgYt2NYpN5YXceksXb6JPyDPIp3XmtuiOgzwaciL
	8B08wURevgRjEUMF7n4rujilU/n64sLi3ir2bEdRfyS6BVtLne2g1F1zJdWBq3v4Y0s01+9k0Zu
	KoOHKQXtf/8A2H51EjVVyztIUcjYWrD6u/9mvb0vgzSu0NvfZsdYnkiIk8E7wgKKSgmEQ1jUWmV
	F0FprGjMNwD91O2DRED1ATByqW1cSJVyBSB9C8EwZFT5ghzJWM8zP5T62TtN4ohq1D0rEP+JLEe
	3Se/dFWB8JqP4fXOKRnbN+0v3j4UxwpCMDsYDO4/wuSk1epNf1tAgbEKv5kXkLrTnq1Pdrx8S5m
	cpi5SsxLiPsDjdaxO09fE7ElacNrzdqE0pQaRVrfqjKW8dQIheg/wgz/BigB7Fcw9lm7PGt+yp5
	Y=
X-Google-Smtp-Source: AGHT+IGUPbJlT6n9OcI1T7MVl1PO5uZWN6cMli+VC4XHgHUJAoY3hcSblNlspvhem/YCCbO6HP7qRmcFqDzP3q6QHoQ=
X-Received: by 2002:ad4:5c85:0:b0:87d:cb55:823b with SMTP id
 6a1803df08f44-8802f4cd30bmr22996256d6.51.1761875596361; Thu, 30 Oct 2025
 18:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251027072206.3468578-1-chenxiaosong.chenxiaosong@linux.dev> <a0d97e2d-91f5-448c-883c-4d0930375f82@linux.dev>
In-Reply-To: <a0d97e2d-91f5-448c-883c-4d0930375f82@linux.dev>
From: Steve French <smfrench@gmail.com>
Date: Thu, 30 Oct 2025 20:53:04 -0500
X-Gm-Features: AWmQ_bnf7-vHG0UtdbX-KJXa4BIuLJy6jQyI41kPToOgTKwSd6ZWi6fOCIZCYs0
Message-ID: <CAH2r5mtHXDuKUSvZ5TZU1f6WnQaH5Dz59=z29ABJsOYmric+1Q@mail.gmail.com>
Subject: Re: [PATCH v4 15/24] smb: move FILE_SYSTEM_POSIX_INFO to common/smb1pdu.h
To: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>, =?UTF-8?B?UmFscGggQsO2aG1l?= <slow@samba.org>
Cc: sfrench@samba.org, linkinjeon@kernel.org, linkinjeon@samba.org, 
	christophe.jaillet@wanadoo.fr, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ralph,
Is this link current? or do you have the link to a more current
version of the POSIX extensions documentation?

On Thu, Oct 30, 2025 at 8:42=E2=80=AFPM ChenXiaoSong
<chenxiaosong.chenxiaosong@linux.dev> wrote:
>
> Hi Namjae and Steve,
>
> I couldn=E2=80=99t find the definition of FILE_SYSTEM_POSIX_INFO in any o=
f the
> following MS documents:
>
>    - MS-FSCC:
> https://learn.microsoft.com/pdf?url=3Dhttps%3A%2F%2Flearn.microsoft.com%2=
Fen-us%2Fopenspecs%2Fwindows_protocols%2Fms-fscc%2Ftoc.json
>    - MS-CIFS:
> https://learn.microsoft.com/pdf?url=3Dhttps%3A%2F%2Flearn.microsoft.com%2=
Fen-us%2Fopenspecs%2Fwindows_protocols%2Fms-cifs%2Ftoc.json
>    - MS-SMB:
> https://learn.microsoft.com/pdf?url=3Dhttps%3A%2F%2Flearn.microsoft.com%2=
Fen-us%2Fopenspecs%2Fwindows_protocols%2Fms-smb%2Ftoc.json
>    - MS-SMB2:
> https://learn.microsoft.com/pdf?url=3Dhttps%3A%2F%2Flearn.microsoft.com%2=
Fen-us%2Fopenspecs%2Fwindows_protocols%2Fms-smb2%2Ftoc.json
>
> Is this structure defined in other MS document?
>
> On 10/27/25 3:21 PM, chenxiaosong.chenxiaosong@linux.dev wrote:
> > From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> >
> > Rename "struct filesystem_posix_info" to "FILE_SYSTEM_POSIX_INFO",
> > then move duplicate definitions to common header file.
> >
> > Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> > ---
> >   fs/smb/client/cifspdu.h    | 22 ----------------------
> >   fs/smb/common/smb1pdu.h    | 23 +++++++++++++++++++++++
> >   fs/smb/server/smb2pdu.c    |  4 ++--
> >   fs/smb/server/smb_common.h | 23 -----------------------
> >   4 files changed, 25 insertions(+), 47 deletions(-)
> >
> > diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
> > index d106c6850807..55aaae6dbc86 100644
> > --- a/fs/smb/client/cifspdu.h
> > +++ b/fs/smb/client/cifspdu.h
> > @@ -1875,28 +1875,6 @@ typedef struct {
> >
> >   #define CIFS_POSIX_EXTENSIONS           0x00000010 /* support for new=
 QFSInfo */
> >
> > -typedef struct {
> > -     /* For undefined recommended transfer size return -1 in that fiel=
d */
> > -     __le32 OptimalTransferSize;  /* bsize on some os, iosize on other=
 os */
> > -     __le32 BlockSize;
> > -    /* The next three fields are in terms of the block size.
> > -     (above). If block size is unknown, 4096 would be a
> > -     reasonable block size for a server to report.
> > -     Note that returning the blocks/blocksavail removes need
> > -     to make a second call (to QFSInfo level 0x103 to get this info.
> > -     UserBlockAvail is typically less than or equal to BlocksAvail,
> > -     if no distinction is made return the same value in each */
> > -     __le64 TotalBlocks;
> > -     __le64 BlocksAvail;       /* bfree */
> > -     __le64 UserBlocksAvail;   /* bavail */
> > -    /* For undefined Node fields or FSID return -1 */
> > -     __le64 TotalFileNodes;
> > -     __le64 FreeFileNodes;
> > -     __le64 FileSysIdentifier;   /* fsid */
> > -     /* NB Namelen comes from FILE_SYSTEM_ATTRIBUTE_INFO call */
> > -     /* NB flags can come from FILE_SYSTEM_DEVICE_INFO call   */
> > -} __attribute__((packed)) FILE_SYSTEM_POSIX_INFO;
> > -
> >   /* DeviceType Flags */
> >   #define FILE_DEVICE_CD_ROM              0x00000002
> >   #define FILE_DEVICE_CD_ROM_FILE_SYSTEM  0x00000003
> > diff --git a/fs/smb/common/smb1pdu.h b/fs/smb/common/smb1pdu.h
> > index 82331a8f70e8..38b9c091baab 100644
> > --- a/fs/smb/common/smb1pdu.h
> > +++ b/fs/smb/common/smb1pdu.h
> > @@ -327,6 +327,29 @@ typedef struct {
> >       __le32 BytesPerSector;
> >   } __packed FILE_SYSTEM_INFO;        /* size info, level 0x103 */
> >
> > +typedef struct {
> > +     /* For undefined recommended transfer size return -1 in that fiel=
d */
> > +     __le32 OptimalTransferSize;  /* bsize on some os, iosize on other=
 os */
> > +     __le32 BlockSize;
> > +     /* The next three fields are in terms of the block size.
> > +      * (above). If block size is unknown, 4096 would be a
> > +      * reasonable block size for a server to report.
> > +      * Note that returning the blocks/blocksavail removes need
> > +      * to make a second call (to QFSInfo level 0x103 to get this info=
.
> > +      * UserBlockAvail is typically less than or equal to BlocksAvail,
> > +      * if no distinction is made return the same value in each
> > +      */
> > +     __le64 TotalBlocks;
> > +     __le64 BlocksAvail;       /* bfree */
> > +     __le64 UserBlocksAvail;   /* bavail */
> > +     /* For undefined Node fields or FSID return -1 */
> > +     __le64 TotalFileNodes;
> > +     __le64 FreeFileNodes;
> > +     __le64 FileSysIdentifier;   /* fsid */
> > +     /* NB Namelen comes from FILE_SYSTEM_ATTRIBUTE_INFO call */
> > +     /* NB flags can come from FILE_SYSTEM_DEVICE_INFO call   */
> > +} __packed FILE_SYSTEM_POSIX_INFO;
> > +
> >   /* See MS-CIFS 2.2.8.2.5 */
> >   typedef struct {
> >       __le32 DeviceType;
> > diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
> > index 47fab72a3588..dc0f0ed4ccb6 100644
> > --- a/fs/smb/server/smb2pdu.c
> > +++ b/fs/smb/server/smb2pdu.c
> > @@ -5633,14 +5633,14 @@ static int smb2_get_info_filesystem(struct ksmb=
d_work *work,
> >       }
> >       case FS_POSIX_INFORMATION:
> >       {
> > -             struct filesystem_posix_info *info;
> > +             FILE_SYSTEM_POSIX_INFO *info;
> >
> >               if (!work->tcon->posix_extensions) {
> >                       pr_err("client doesn't negotiate with SMB3.1.1 PO=
SIX Extensions\n");
> >                       path_put(&path);
> >                       return -EOPNOTSUPP;
> >               } else {
> > -                     info =3D (struct filesystem_posix_info *)(rsp->Bu=
ffer);
> > +                     info =3D (FILE_SYSTEM_POSIX_INFO *)(rsp->Buffer);
> >                       info->OptimalTransferSize =3D cpu_to_le32(stfs.f_=
bsize);
> >                       info->BlockSize =3D cpu_to_le32(stfs.f_bsize);
> >                       info->TotalBlocks =3D cpu_to_le64(stfs.f_blocks);
> > diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
> > index 6141ca8f7e1c..61048568f4c7 100644
> > --- a/fs/smb/server/smb_common.h
> > +++ b/fs/smb/server/smb_common.h
> > @@ -108,29 +108,6 @@ struct file_id_both_directory_info {
> >       char FileName[];
> >   } __packed;
> >
> > -struct filesystem_posix_info {
> > -     /* For undefined recommended transfer size return -1 in that fiel=
d */
> > -     __le32 OptimalTransferSize;  /* bsize on some os, iosize on other=
 os */
> > -     __le32 BlockSize;
> > -     /* The next three fields are in terms of the block size.
> > -      * (above). If block size is unknown, 4096 would be a
> > -      * reasonable block size for a server to report.
> > -      * Note that returning the blocks/blocksavail removes need
> > -      * to make a second call (to QFSInfo level 0x103 to get this info=
.
> > -      * UserBlockAvail is typically less than or equal to BlocksAvail,
> > -      * if no distinction is made return the same value in each
> > -      */
> > -     __le64 TotalBlocks;
> > -     __le64 BlocksAvail;       /* bfree */
> > -     __le64 UserBlocksAvail;   /* bavail */
> > -     /* For undefined Node fields or FSID return -1 */
> > -     __le64 TotalFileNodes;
> > -     __le64 FreeFileNodes;
> > -     __le64 FileSysIdentifier;   /* fsid */
> > -     /* NB Namelen comes from FILE_SYSTEM_ATTRIBUTE_INFO call */
> > -     /* NB flags can come from FILE_SYSTEM_DEVICE_INFO call   */
> > -} __packed;
> > -
> >   struct smb_version_ops {
> >       u16 (*get_cmd_val)(struct ksmbd_work *swork);
> >       int (*init_rsp_hdr)(struct ksmbd_work *swork);
>


--=20
Thanks,

Steve

