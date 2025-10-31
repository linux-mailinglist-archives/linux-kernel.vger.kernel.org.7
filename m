Return-Path: <linux-kernel+bounces-879402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312ABC2307B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96BD1A25E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362652EFD92;
	Fri, 31 Oct 2025 02:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQtYOM3l"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30BD2E6CDC
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878036; cv=none; b=OlJOKBlGX7srb5e2N2qAi8hSIsjlCQfXbf56XNom725fFi2THCZ1Y0cXkdbD/0KdICOLhzv0RqFyThZ/CMS2NWefWIqBwAejpaZ5W1wOKFRVDIamkUj6WtEKAvNUcECV9kLsM621drZVXlkXfQgt8y6skufIKdREdvwKdSZKLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878036; c=relaxed/simple;
	bh=jCZVMpuSvfzZE8Sq5EH0GrUWN4cGJOLB4SPWdbmSC94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1lhZTulIpWxPRqmcryhgTRcDeQw3aEMsgPPl8yEi1VQe75Yu1cGbv3v/26NastO6xo1It/euqLEgJdxAdoyrTSFynKthd8nPd3/pW5hfMfKX9JBw1zbVReYES7uQyx1G+rlKzt7poyuDEjYp4/IF67/80tWvdTj2p5ONhSLMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQtYOM3l; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8801f0f46b6so11360036d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761878032; x=1762482832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZYYmFeIdKjQ+/rwBQkpsYTKGGR6aXz28qE1jRlz+sQ=;
        b=HQtYOM3luRDD3W8GXDWz+IV0j9pJnAvUTkXUPKiciu6CmFSIpNDhqdZkDZ8hmHcxdi
         k/NmY6af2hYOaulSozSsTlIB3Nw7OGPoqYPEZ7YhFkx6EqLzQ/U9T2tbOzYWRFcOFMhB
         pG5G+0OjjdtbzFI41e3SkRgI2MJZhrvNdUHnXZMwD5JtgbnwU4XPLkLMu4bUNiBU3uig
         L46+oBSEqfczBiM//aO9R4C3GlO9dCg5pIoBGUW5N1s85nZMpngTNqR2ymRyv0ECT5N5
         /6EGZTiGyNaD5q5RZOpmjaHiNNjpqb91msYDvP7xz5N7nfzUHrQ3tHOg10VZ6MShmgm3
         2D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878032; x=1762482832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZYYmFeIdKjQ+/rwBQkpsYTKGGR6aXz28qE1jRlz+sQ=;
        b=GAY6jH8qVEGN2XITBOFNPNR6m+Zu55MiuMxRu3Yr8cZsyxImt7uUjfr4jm1A1SR6Fb
         2KxXzPsUozFvyCt15t1hDzFxU+ucyCjFyFkkvDcqQBhiVINZPfLI4nugLK/BKa2JCBqo
         eUCE8yyAUDoIblSfHa5MQJ7Nu8JpcSyXH1A8Wm0OlUjuPoJiMoqqSZPx8CFob1VIbtY8
         QW/8lkfbQOdkEh2o9KUZV6VRxDbxh2zpYnFfbPSlWVHY45fWllUSfvfyMmD8loHTp6EJ
         vtCS+j4BcBODCoYBghhDiacPXQE+/svfkX0FeBe1MzJGGvRnf2KBie8gfzmUJ9Rdwy9x
         aEKw==
X-Forwarded-Encrypted: i=1; AJvYcCWASeeAwjN8t24QnK5MOKv+wuPLABxJIQuF2D/WByLq6LaLvAFna1KhxWjQVcKWc5BuwdEEro76Z9rPXEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+u/1s9oe7Dydsc2KxOXXPCQHPqAyoMaeDtfvb5wUCzIsuuHb
	SlZJ/TSzH8D73IZSR4k7coX35ONgcR5jioYrVN49n4qph35XCFu3jYEgteuIIqxsdkM6MRqKWsW
	ZKJPwzVdOjrWN3ilVaoG1OiAtE3gnXTM=
X-Gm-Gg: ASbGncuf4HfSdFcnJLzdLplcVCkCz/ZheP6KnsCdvDf+wFZd1+omqYCKoIX7FzRdg7x
	Q0gPax/gbzLWW/TzabAtGFl7Cvl4nOHuqy0GfG/neGhdPnoiuFoZ1EMEkUruN6ZfsB1cbmgilq8
	Hn8SbsExlpyxdgbZ6v74xCa42eLtS1CSnRM3BrVB0hXs1j75jQZ13i3pmiNb2OqKgQGtvvk8LjS
	Qacbn9Y/jPsT6/iT7uvncXwHbB9g9a1+XBi3QRRfSEQQNT6nlOFJ2dlcl1cRokBhZWCzcg17ct7
	WcE/T9+FlxU0nlLBjh2qJHroZes6Zd9Q0QPPH9Kfp6pXWIj9mehHpKnVejX/NpLH2jGqgWbU+FA
	uSLzDKI30/foScFByeFYmu2UHqVPoL20Fy/0vCzuIX5frrwtJpH1oe4heIL9lccaJP4INu8sQNj
	w=
X-Google-Smtp-Source: AGHT+IF6nxVrfPwv+AiV4li/d1NDoAttcBj14XoL0BKgK+gjHFUVpz16sul+DM5dMnmJkoecOCBRxUU3BB9mL4bodBE=
X-Received: by 2002:a05:6214:f62:b0:87c:a721:42ea with SMTP id
 6a1803df08f44-8802f48d7f2mr24076386d6.32.1761878031899; Thu, 30 Oct 2025
 19:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027071316.3468472-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251027072206.3468578-1-chenxiaosong.chenxiaosong@linux.dev>
 <a0d97e2d-91f5-448c-883c-4d0930375f82@linux.dev> <CAH2r5mtHXDuKUSvZ5TZU1f6WnQaH5Dz59=z29ABJsOYmric+1Q@mail.gmail.com>
 <CAH2r5muwP4uyELKDNrRGU+8YgwNurb1+jQb+5CYOcU74LZhj3w@mail.gmail.com> <d1835c8a-f354-498f-a8c3-f43d7bb62548@linux.dev>
In-Reply-To: <d1835c8a-f354-498f-a8c3-f43d7bb62548@linux.dev>
From: Steve French <smfrench@gmail.com>
Date: Thu, 30 Oct 2025 21:33:38 -0500
X-Gm-Features: AWmQ_bl7uQePSmynHAHTP_qkGgjDjrYM3EBURWhpYbmKTa5RWcQLl4EAx2PK1Qc
Message-ID: <CAH2r5mvyGVXgY4AhW0kRymz241+=-PkhcKNi5NoGwn8N_juDfQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/24] smb: move FILE_SYSTEM_POSIX_INFO to common/smb1pdu.h
To: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
Cc: =?UTF-8?B?UmFscGggQsO2aG1l?= <slow@samba.org>, sfrench@samba.org, 
	linkinjeon@kernel.org, linkinjeon@samba.org, christophe.jaillet@wanadoo.fr, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes - agreed. Ralph could give more details on that

On Thu, Oct 30, 2025 at 9:32=E2=80=AFPM ChenXiaoSong
<chenxiaosong.chenxiaosong@linux.dev> wrote:
>
> This GitLab repository seems to be more up to date than the one on
> samba.org: https://git.samba.org/?p=3Dslow/smb3_posix_spec.git;a=3Dshortl=
og
>
> Thanks,
> ChenXiaoSong.
>
> =E5=9C=A8 2025/10/31 09:53, Steve French =E5=86=99=E9=81=93:
> > Sorry forgot to attach the link
> >
> > https://gitlab.com/samba-team/smb3-posix-spec
> >
> > On Thu, Oct 30, 2025 at 8:53=E2=80=AFPM Steve French <smfrench@gmail.co=
m> wrote:
> >>
> >> Ralph,
> >> Is this link current? or do you have the link to a more current
> >> version of the POSIX extensions documentation?
> >>
> >> On Thu, Oct 30, 2025 at 8:42=E2=80=AFPM ChenXiaoSong
> >> <chenxiaosong.chenxiaosong@linux.dev> wrote:
> >>>
> >>> Hi Namjae and Steve,
> >>>
> >>> I couldn=E2=80=99t find the definition of FILE_SYSTEM_POSIX_INFO in a=
ny of the
> >>> following MS documents:
> >>>
> >>>     - MS-FSCC:
> >>> https://learn.microsoft.com/pdf?url=3Dhttps%3A%2F%2Flearn.microsoft.c=
om%2Fen-us%2Fopenspecs%2Fwindows_protocols%2Fms-fscc%2Ftoc.json
> >>>     - MS-CIFS:
> >>> https://learn.microsoft.com/pdf?url=3Dhttps%3A%2F%2Flearn.microsoft.c=
om%2Fen-us%2Fopenspecs%2Fwindows_protocols%2Fms-cifs%2Ftoc.json
> >>>     - MS-SMB:
> >>> https://learn.microsoft.com/pdf?url=3Dhttps%3A%2F%2Flearn.microsoft.c=
om%2Fen-us%2Fopenspecs%2Fwindows_protocols%2Fms-smb%2Ftoc.json
> >>>     - MS-SMB2:
> >>> https://learn.microsoft.com/pdf?url=3Dhttps%3A%2F%2Flearn.microsoft.c=
om%2Fen-us%2Fopenspecs%2Fwindows_protocols%2Fms-smb2%2Ftoc.json
> >>>
> >>> Is this structure defined in other MS document?
> >>>
> >>> On 10/27/25 3:21 PM, chenxiaosong.chenxiaosong@linux.dev wrote:
> >>>> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> >>>>
> >>>> Rename "struct filesystem_posix_info" to "FILE_SYSTEM_POSIX_INFO",
> >>>> then move duplicate definitions to common header file.
> >>>>
> >>>> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> >>>> ---
> >>>>    fs/smb/client/cifspdu.h    | 22 ----------------------
> >>>>    fs/smb/common/smb1pdu.h    | 23 +++++++++++++++++++++++
> >>>>    fs/smb/server/smb2pdu.c    |  4 ++--
> >>>>    fs/smb/server/smb_common.h | 23 -----------------------
> >>>>    4 files changed, 25 insertions(+), 47 deletions(-)
> >>>>
> >>>> diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
> >>>> index d106c6850807..55aaae6dbc86 100644
> >>>> --- a/fs/smb/client/cifspdu.h
> >>>> +++ b/fs/smb/client/cifspdu.h
> >>>> @@ -1875,28 +1875,6 @@ typedef struct {
> >>>>
> >>>>    #define CIFS_POSIX_EXTENSIONS           0x00000010 /* support for=
 new QFSInfo */
> >>>>
> >>>> -typedef struct {
> >>>> -     /* For undefined recommended transfer size return -1 in that f=
ield */
> >>>> -     __le32 OptimalTransferSize;  /* bsize on some os, iosize on ot=
her os */
> >>>> -     __le32 BlockSize;
> >>>> -    /* The next three fields are in terms of the block size.
> >>>> -     (above). If block size is unknown, 4096 would be a
> >>>> -     reasonable block size for a server to report.
> >>>> -     Note that returning the blocks/blocksavail removes need
> >>>> -     to make a second call (to QFSInfo level 0x103 to get this info=
.
> >>>> -     UserBlockAvail is typically less than or equal to BlocksAvail,
> >>>> -     if no distinction is made return the same value in each */
> >>>> -     __le64 TotalBlocks;
> >>>> -     __le64 BlocksAvail;       /* bfree */
> >>>> -     __le64 UserBlocksAvail;   /* bavail */
> >>>> -    /* For undefined Node fields or FSID return -1 */
> >>>> -     __le64 TotalFileNodes;
> >>>> -     __le64 FreeFileNodes;
> >>>> -     __le64 FileSysIdentifier;   /* fsid */
> >>>> -     /* NB Namelen comes from FILE_SYSTEM_ATTRIBUTE_INFO call */
> >>>> -     /* NB flags can come from FILE_SYSTEM_DEVICE_INFO call   */
> >>>> -} __attribute__((packed)) FILE_SYSTEM_POSIX_INFO;
> >>>> -
> >>>>    /* DeviceType Flags */
> >>>>    #define FILE_DEVICE_CD_ROM              0x00000002
> >>>>    #define FILE_DEVICE_CD_ROM_FILE_SYSTEM  0x00000003
> >>>> diff --git a/fs/smb/common/smb1pdu.h b/fs/smb/common/smb1pdu.h
> >>>> index 82331a8f70e8..38b9c091baab 100644
> >>>> --- a/fs/smb/common/smb1pdu.h
> >>>> +++ b/fs/smb/common/smb1pdu.h
> >>>> @@ -327,6 +327,29 @@ typedef struct {
> >>>>        __le32 BytesPerSector;
> >>>>    } __packed FILE_SYSTEM_INFO;        /* size info, level 0x103 */
> >>>>
> >>>> +typedef struct {
> >>>> +     /* For undefined recommended transfer size return -1 in that f=
ield */
> >>>> +     __le32 OptimalTransferSize;  /* bsize on some os, iosize on ot=
her os */
> >>>> +     __le32 BlockSize;
> >>>> +     /* The next three fields are in terms of the block size.
> >>>> +      * (above). If block size is unknown, 4096 would be a
> >>>> +      * reasonable block size for a server to report.
> >>>> +      * Note that returning the blocks/blocksavail removes need
> >>>> +      * to make a second call (to QFSInfo level 0x103 to get this i=
nfo.
> >>>> +      * UserBlockAvail is typically less than or equal to BlocksAva=
il,
> >>>> +      * if no distinction is made return the same value in each
> >>>> +      */
> >>>> +     __le64 TotalBlocks;
> >>>> +     __le64 BlocksAvail;       /* bfree */
> >>>> +     __le64 UserBlocksAvail;   /* bavail */
> >>>> +     /* For undefined Node fields or FSID return -1 */
> >>>> +     __le64 TotalFileNodes;
> >>>> +     __le64 FreeFileNodes;
> >>>> +     __le64 FileSysIdentifier;   /* fsid */
> >>>> +     /* NB Namelen comes from FILE_SYSTEM_ATTRIBUTE_INFO call */
> >>>> +     /* NB flags can come from FILE_SYSTEM_DEVICE_INFO call   */
> >>>> +} __packed FILE_SYSTEM_POSIX_INFO;
> >>>> +
> >>>>    /* See MS-CIFS 2.2.8.2.5 */
> >>>>    typedef struct {
> >>>>        __le32 DeviceType;
> >>>> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
> >>>> index 47fab72a3588..dc0f0ed4ccb6 100644
> >>>> --- a/fs/smb/server/smb2pdu.c
> >>>> +++ b/fs/smb/server/smb2pdu.c
> >>>> @@ -5633,14 +5633,14 @@ static int smb2_get_info_filesystem(struct k=
smbd_work *work,
> >>>>        }
> >>>>        case FS_POSIX_INFORMATION:
> >>>>        {
> >>>> -             struct filesystem_posix_info *info;
> >>>> +             FILE_SYSTEM_POSIX_INFO *info;
> >>>>
> >>>>                if (!work->tcon->posix_extensions) {
> >>>>                        pr_err("client doesn't negotiate with SMB3.1.=
1 POSIX Extensions\n");
> >>>>                        path_put(&path);
> >>>>                        return -EOPNOTSUPP;
> >>>>                } else {
> >>>> -                     info =3D (struct filesystem_posix_info *)(rsp-=
>Buffer);
> >>>> +                     info =3D (FILE_SYSTEM_POSIX_INFO *)(rsp->Buffe=
r);
> >>>>                        info->OptimalTransferSize =3D cpu_to_le32(stf=
s.f_bsize);
> >>>>                        info->BlockSize =3D cpu_to_le32(stfs.f_bsize)=
;
> >>>>                        info->TotalBlocks =3D cpu_to_le64(stfs.f_bloc=
ks);
> >>>> diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
> >>>> index 6141ca8f7e1c..61048568f4c7 100644
> >>>> --- a/fs/smb/server/smb_common.h
> >>>> +++ b/fs/smb/server/smb_common.h
> >>>> @@ -108,29 +108,6 @@ struct file_id_both_directory_info {
> >>>>        char FileName[];
> >>>>    } __packed;
> >>>>
> >>>> -struct filesystem_posix_info {
> >>>> -     /* For undefined recommended transfer size return -1 in that f=
ield */
> >>>> -     __le32 OptimalTransferSize;  /* bsize on some os, iosize on ot=
her os */
> >>>> -     __le32 BlockSize;
> >>>> -     /* The next three fields are in terms of the block size.
> >>>> -      * (above). If block size is unknown, 4096 would be a
> >>>> -      * reasonable block size for a server to report.
> >>>> -      * Note that returning the blocks/blocksavail removes need
> >>>> -      * to make a second call (to QFSInfo level 0x103 to get this i=
nfo.
> >>>> -      * UserBlockAvail is typically less than or equal to BlocksAva=
il,
> >>>> -      * if no distinction is made return the same value in each
> >>>> -      */
> >>>> -     __le64 TotalBlocks;
> >>>> -     __le64 BlocksAvail;       /* bfree */
> >>>> -     __le64 UserBlocksAvail;   /* bavail */
> >>>> -     /* For undefined Node fields or FSID return -1 */
> >>>> -     __le64 TotalFileNodes;
> >>>> -     __le64 FreeFileNodes;
> >>>> -     __le64 FileSysIdentifier;   /* fsid */
> >>>> -     /* NB Namelen comes from FILE_SYSTEM_ATTRIBUTE_INFO call */
> >>>> -     /* NB flags can come from FILE_SYSTEM_DEVICE_INFO call   */
> >>>> -} __packed;
> >>>> -
> >>>>    struct smb_version_ops {
> >>>>        u16 (*get_cmd_val)(struct ksmbd_work *swork);
> >>>>        int (*init_rsp_hdr)(struct ksmbd_work *swork);
> >>>
> >>
> >>
> >> --
> >> Thanks,
> >>
> >> Steve
> >
> >
> >
>


--=20
Thanks,

Steve

