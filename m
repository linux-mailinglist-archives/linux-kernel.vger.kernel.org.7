Return-Path: <linux-kernel+bounces-825812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E6EB8CDDA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C5316EF67
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E03D30F554;
	Sat, 20 Sep 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqd3wRUO"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB87302152
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758389217; cv=none; b=lWpQJ0BvXloczdxJ26/yuihmV7R48Sm7mXlhc9cWDISQyIQeqb5qwPuVogaKGOyXEYn3H2jIxwgTnIcj1K4zAHVDWxOOpSMDTs8esHhb9PMxGqEA+4+JZsrRiDeTzde5WXOxGXvd1kldOKO7/OwFVsmyu21fAs4Y7RnnS0C0r5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758389217; c=relaxed/simple;
	bh=3adxvJs0qVcgPPD06SkMcewHodlqT6s33+654bxADu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlwHcPMEVfBBS8P4s5i1JDeTG9M+rtabnao3eh0/hwv/oaJAczpNdf4fJHiJ4/1+BVsu7psrxZrzM8A9pkWZviIXcp13F+29irnhdWhPnDr534icp/VqMiqCTP5obzty1VrqOllLaPti8T6feGgoeirYeWYg3xL8un5e3DErTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqd3wRUO; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-791875a9071so30872696d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 10:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758389214; x=1758994014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6paYclhXyeZwz/sSU7beJl+BgRVTSOJzpS7hqwmJ600=;
        b=eqd3wRUOKjnpYlI5sHuciJkr+uwktsz1qYrSA2Qtatn9oOy7i0ALuqaSmASAJ37Ac8
         zvxGKnlYnPUNWAuJNiBStpcadSPa+vwmFIqSxpEzQSbNeKnS8d8R9wRZsENK1LBgiFue
         wBGeQbU7e1XRxLpM/Db7ZLT+NLY9iE++DlODL9uTTBYpQ8NKu9Yzhmm665YkCGYqxWUx
         9cbmhSf0IAL9VvlPK/i826ogrI3th775iuDxP27CbR0C2Y9QcYBstiiIHwo/ta2KnHly
         WdCvzUciJidMsqTPGKjICccBkP+3OAA+I6PiEAScWEeAuGMocRSC8tv1X2Eib+4WRNZe
         TaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758389214; x=1758994014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6paYclhXyeZwz/sSU7beJl+BgRVTSOJzpS7hqwmJ600=;
        b=HChOPW8JO9wIME+rtP4wVrhATzUGYRP2vWtTpqFGHApeas/pbHYIBwF0rXyltuXv5z
         ORVyyN9Ya36Lw4Wa5amZBYAfiA+JNqUB8/vWCnM2xizqTpzIWQW1nN6S8nXATwU2hDEk
         RabYDNZjxCxJKKbJyb9PTIrZTZR8mawA+CRryiG/wcVQnKzEMAUKuEz8w33aGNc2g9oH
         CyXpbPDDeaJMWQUhhD+fYBB0TxOg32B++YGF4rvFk8NnhOaTmUm86gx7yvtAoLOHU9lv
         FVf7bl/P/3qSHOAvdoeWz3ayzX6CBum8gfdXqaCaJYgWLa5egtcZmoLRoj8GzDzb2rEX
         kV6A==
X-Forwarded-Encrypted: i=1; AJvYcCUVm8s8IFFbYBmJpqxwDIrSHjGtIpFVHf728ZJsPz88JuXR5dehyfQXUiVWklrUCTGeNYCygbK3CFVUQD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2svuNiD5AfnxtmVbc+baMu+lkzRbu4Xp7cxUEQWeoTNQnbdJc
	H47Ud7RmXNJNx89qBWxJMD5dFrS7j8ixjcNOaHbi9Duhz3ev22nDg+2VajyuGSpg1V7tuM+m07V
	io3+VBGMUJe/2H0ks9vkfy8x6mEL75Vc=
X-Gm-Gg: ASbGnctKJhfxVK8tre+h9bxFHPZ1uQsuhKOWSYckIK657M5sm5fMr4P+ZCpDOCTybCv
	LGebZupUONjTpl6wVsah9+6OuPtlCrlnC/O1uSfEWcfc5H0CoLZ3NC86RJrlJz29eui1xUq4+R7
	jDEDDHLMWgai+nbiAKpxP/uyYuH5faC/xrBXT4CjDhBrhG9kPy93OcGHIy3eaV3P4o9VioDovX1
	nl0jYFGxTfCrK5dN8nSSsjN+e2wPPa6mO1/9mrVfUoa6E8NZwqVBcyFPQIg6ysGeWN4D0jV3xbh
	bElKop9gtp0Wxsj0TfrU50pkWh+QyHwIbOjXM5HtJca7gzIoa2rJeS+7dMkk7TOu2pM8EQA4gYS
	JbR/dSL3fQ29/xjoVfn9j
X-Google-Smtp-Source: AGHT+IEqHNqLonyZNlJeX+bM903DwjTNtSMOEozdz6cuMeNWKWmi2rOQ9p9SLt+4zpug+/lMZNqYRZ2cd5gRmjaQCU0=
X-Received: by 2002:a05:6214:21cb:b0:782:18f3:366f with SMTP id
 6a1803df08f44-79919dae89cmr84424826d6.38.1758389214102; Sat, 20 Sep 2025
 10:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831123602.14037-1-pali@kernel.org> <20250831123602.14037-9-pali@kernel.org>
In-Reply-To: <20250831123602.14037-9-pali@kernel.org>
From: Steve French <smfrench@gmail.com>
Date: Sat, 20 Sep 2025 12:26:40 -0500
X-Gm-Features: AS18NWD6a7R-Jh_7dbMrr6OaHrMzD-i32UGSSr7OqsN6XlPGXriSRBCKXSYRKsg
Message-ID: <CAH2r5muVP5NuZFfsCWDYhCKATDyeaD2cpXgC3=zNh+3T_zO1Mg@mail.gmail.com>
Subject: Re: [PATCH 08/35] cifs: Improve SMB2+ stat() to work also for paths
 in DELETE_PENDING state
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	ronnie sahlberg <ronniesahlberg@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch doesn't apply to current mainline - can you update it?

On Sun, Aug 31, 2025 at 7:36=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> Paths in DELETE_PENDING state cannot be opened at all. So standard way of
> querying path attributes for this case is not possible.
>
> There is an alternative way how to query limited information about file
> over SMB2+ dialects without opening file itself. It is by opening the
> parent directory, querying specific child with filled search filter and
> asking for attributes for that child.
>
> Implement this fallback when standard case in smb2_query_path_info fails
> with STATUS_DELETE_PENDING error and stat was asked for path which is not
> top level one (because top level does not have parent directory at all).
>
> Depends on "cifs: Change translation of STATUS_DELETE_PENDING to -EBUSY".
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  fs/smb/client/cifsglob.h  |   1 +
>  fs/smb/client/smb2glob.h  |   1 +
>  fs/smb/client/smb2inode.c | 177 +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 176 insertions(+), 3 deletions(-)
>
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index e6830ab3a546..0ecf4988664e 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -2337,6 +2337,7 @@ struct smb2_compound_vars {
>         struct smb_rqst rqst[MAX_COMPOUND];
>         struct kvec open_iov[SMB2_CREATE_IOV_SIZE];
>         struct kvec qi_iov;
> +       struct kvec qd_iov[SMB2_QUERY_DIRECTORY_IOV_SIZE];
>         struct kvec io_iov[SMB2_IOCTL_IOV_SIZE];
>         struct kvec si_iov[SMB2_SET_INFO_IOV_SIZE];
>         struct kvec close_iov;
> diff --git a/fs/smb/client/smb2glob.h b/fs/smb/client/smb2glob.h
> index 224495322a05..1cb219605e75 100644
> --- a/fs/smb/client/smb2glob.h
> +++ b/fs/smb/client/smb2glob.h
> @@ -39,6 +39,7 @@ enum smb2_compound_ops {
>         SMB2_OP_GET_REPARSE,
>         SMB2_OP_QUERY_WSL_EA,
>         SMB2_OP_OPEN_QUERY,
> +       SMB2_OP_QUERY_DIRECTORY,
>  };
>
>  /* Used when constructing chained read requests. */
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 2a0316c514e4..460e75614ef1 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -176,6 +176,9 @@ static int smb2_compound_op(const unsigned int xid, s=
truct cifs_tcon *tcon,
>                             struct kvec *out_iov, int *out_buftype, struc=
t dentry *dentry)
>  {
>
> +       bool has_cifs_mount_server_inum =3D cifs_sb->mnt_cifs_flags & CIF=
S_MOUNT_SERVER_INUM;
> +       struct smb2_query_directory_req *qd_rqst =3D NULL;
> +       struct smb2_query_directory_rsp *qd_rsp =3D NULL;
>         struct smb2_create_rsp *create_rsp =3D NULL;
>         struct smb2_query_info_rsp *qi_rsp =3D NULL;
>         struct smb2_compound_vars *vars =3D NULL;
> @@ -344,6 +347,41 @@ static int smb2_compound_op(const unsigned int xid, =
struct cifs_tcon *tcon,
>                         trace_smb3_posix_query_info_compound_enter(xid, t=
con->tid,
>                                                                    ses->S=
uid, full_path);
>                         break;
> +               case SMB2_OP_QUERY_DIRECTORY:
> +                       rqst[num_rqst].rq_iov =3D &vars->qd_iov[0];
> +                       rqst[num_rqst].rq_nvec =3D SMB2_QUERY_DIRECTORY_I=
OV_SIZE;
> +
> +                       rc =3D SMB2_query_directory_init(xid,
> +                                                      tcon,
> +                                                      server,
> +                                                      &rqst[num_rqst],
> +                                                      cfile ?
> +                                                       cfile->fid.persis=
tent_fid : COMPOUND_FID,
> +                                                      cfile ?
> +                                                       cfile->fid.volati=
le_fid : COMPOUND_FID,
> +                                                      0,
> +                                                      has_cifs_mount_ser=
ver_inum ?
> +                                                       SMB_FIND_FILE_ID_=
FULL_DIR_INFO :
> +                                                       SMB_FIND_FILE_FUL=
L_DIRECTORY_INFO);
> +                       if (!rc) {
> +                               /*
> +                                * Change the default search wildcard pat=
tern '*'
> +                                * to the requested file name stored in i=
n_iov[i]
> +                                * and request for only one single entry.
> +                                */
> +                               qd_rqst =3D rqst[num_rqst].rq_iov[0].iov_=
base;
> +                               qd_rqst->Flags |=3D SMB2_RETURN_SINGLE_EN=
TRY;
> +                               qd_rqst->FileNameLength =3D cpu_to_le16(i=
n_iov[i].iov_len);
> +                               rqst[num_rqst].rq_iov[1] =3D in_iov[i];
> +                       }
> +                       if (!rc && (!cfile || num_rqst > 1)) {
> +                               smb2_set_next_command(tcon, &rqst[num_rqs=
t]);
> +                               smb2_set_related(&rqst[num_rqst]);
> +                       } else if (rc) {
> +                               goto finished;
> +                       }
> +                       num_rqst++;
> +                       break;
>                 case SMB2_OP_DELETE:
>                         trace_smb3_delete_enter(xid, tcon->tid, ses->Suid=
, full_path);
>                         break;
> @@ -730,6 +768,64 @@ static int smb2_compound_op(const unsigned int xid, =
struct cifs_tcon *tcon,
>                                 trace_smb3_posix_query_info_compound_done=
(xid, tcon->tid,
>                                                                          =
 ses->Suid);
>                         break;
> +               case SMB2_OP_QUERY_DIRECTORY:
> +                       if (rc =3D=3D 0) {
> +                               qd_rsp =3D (struct smb2_query_directory_r=
sp *)
> +                                       rsp_iov[i + 1].iov_base;
> +                               rc =3D smb2_validate_iov(le16_to_cpu(qd_r=
sp->OutputBufferOffset),
> +                                                      le32_to_cpu(qd_rsp=
->OutputBufferLength),
> +                                                      &rsp_iov[i + 1],
> +                                                      has_cifs_mount_ser=
ver_inum ?
> +                                                       sizeof(SEARCH_ID_=
FULL_DIR_INFO) :
> +                                                       sizeof(FILE_FULL_=
DIRECTORY_INFO));
> +                       }
> +                       if (rc =3D=3D 0) {
> +                               /*
> +                                * Both SEARCH_ID_FULL_DIR_INFO and FILE_=
FULL_DIRECTORY_INFO
> +                                * have same member offsets except the Un=
iqueId and FileName.
> +                                */
> +                               SEARCH_ID_FULL_DIR_INFO *si =3D
> +                                       (SEARCH_ID_FULL_DIR_INFO *)qd_rsp=
->Buffer;
> +
> +                               idata =3D in_iov[i + 1].iov_base;
> +                               idata->fi.CreationTime =3D si->CreationTi=
me;
> +                               idata->fi.LastAccessTime =3D si->LastAcce=
ssTime;
> +                               idata->fi.LastWriteTime =3D si->LastWrite=
Time;
> +                               idata->fi.ChangeTime =3D si->ChangeTime;
> +                               idata->fi.Attributes =3D si->ExtFileAttri=
butes;
> +                               idata->fi.AllocationSize =3D si->Allocati=
onSize;
> +                               idata->fi.EndOfFile =3D si->EndOfFile;
> +                               idata->fi.EASize =3D si->EaSize;
> +                               idata->fi.Directory =3D
> +                                       !!(le32_to_cpu(si->ExtFileAttribu=
tes) & ATTR_DIRECTORY);
> +                               /*
> +                                * UniqueId is present only in struct SEA=
RCH_ID_FULL_DIR_INFO.
> +                                * It is not present in struct FILE_FULL_=
DIRECTORY_INFO.
> +                                * struct SEARCH_ID_FULL_DIR_INFO was req=
uested only when
> +                                * CIFS_MOUNT_SERVER_INUM is set.
> +                                */
> +                               if (has_cifs_mount_server_inum)
> +                                       idata->fi.IndexNumber =3D si->Uni=
queId;
> +                               /*
> +                                * Do not change idata->fi.NumberOfLinks =
to correctly
> +                                * trigger the CIFS_FATTR_UNKNOWN_NLINK f=
lag.
> +                                */
> +                               /*
> +                                * Do not change idata->fi.DeletePending =
as we do not know if
> +                                * the entry is in the delete pending sta=
te. SMB2 QUERY_DIRECTORY
> +                                * at any level does not provide this inf=
ormation.
> +                                */
> +                       }
> +                       SMB2_query_directory_free(&rqst[num_rqst++]);
> +                       if (rc)
> +                               trace_smb3_query_dir_err(xid,
> +                                       cfile ? cfile->fid.persistent_fid=
 : COMPOUND_FID,
> +                                       tcon->tid, ses->Suid, 0, 0, rc);
> +                       else
> +                               trace_smb3_query_dir_done(xid,
> +                                       cfile ? cfile->fid.persistent_fid=
 : COMPOUND_FID,
> +                                       tcon->tid, ses->Suid, 0, 0);
> +                       break;
>                 case SMB2_OP_DELETE:
>                         if (rc)
>                                 trace_smb3_delete_err(xid, tcon->tid, ses=
->Suid, rc);
> @@ -1090,9 +1186,9 @@ int smb2_query_path_info(const unsigned int xid,
>                 break;
>         case -EREMOTE:
>                 break;
> -       default:
> -               if (hdr->Status !=3D STATUS_OBJECT_NAME_INVALID)
> -                       break;
> +       }
> +
> +       if (hdr->Status =3D=3D STATUS_OBJECT_NAME_INVALID) {
>                 rc2 =3D cifs_inval_name_dfs_link_error(xid, tcon, cifs_sb=
,
>                                                      full_path, &islink);
>                 if (rc2) {
> @@ -1101,6 +1197,81 @@ int smb2_query_path_info(const unsigned int xid,
>                 }
>                 if (islink)
>                         rc =3D -EREMOTE;
> +       } else if (hdr->Status =3D=3D STATUS_DELETE_PENDING && full_path[=
0]) {
> +               /*
> +                * If SMB2 OPEN/CREATE fails with STATUS_DELETE_PENDING e=
rror,
> +                * it means that the path is in delete pending state and =
it is
> +                * not possible to open it until some other client clears=
 delete
> +                * pending state or all other clients close all opened ha=
ndles
> +                * to that path.
> +                *
> +                * There is an alternative way how to query limited infor=
mation
> +                * about path which is in delete pending state still suit=
able
> +                * for the stat() syscall. It is by opening the parent di=
rectory,
> +                * querying specific child with filled search filer and a=
sking
> +                * for attributes for that child.
> +                */
> +
> +               char *parent_path;
> +               const char *basename;
> +               __le16 *basename_utf16;
> +               int basename_utf16_len;
> +               struct cifsFileInfo *parent_cfile;
> +
> +               basename =3D strrchr(full_path, CIFS_DIR_SEP(cifs_sb));
> +               if (basename) {
> +                       parent_path =3D kstrndup(full_path, basename - fu=
ll_path, GFP_KERNEL);
> +                       basename++;
> +               } else {
> +                       parent_path =3D kstrdup("", GFP_KERNEL);
> +                       basename =3D full_path;
> +               }
> +
> +               if (!parent_path) {
> +                       rc =3D -ENOMEM;
> +                       goto out;
> +               }
> +
> +               basename_utf16 =3D cifs_convert_path_to_utf16(basename, c=
ifs_sb);
> +               if (!basename_utf16) {
> +                       kfree(parent_path);
> +                       rc =3D -ENOMEM;
> +                       goto out;
> +               }
> +
> +               basename_utf16_len =3D 2 * UniStrnlen((wchar_t *)basename=
_utf16, PATH_MAX);
> +
> +retry_query_directory:
> +               num_cmds =3D 1;
> +               cmds[0] =3D SMB2_OP_QUERY_DIRECTORY;
> +               in_iov[0].iov_base =3D basename_utf16;
> +               in_iov[0].iov_len =3D basename_utf16_len;
> +               in_iov[1].iov_base =3D data;
> +               in_iov[1].iov_len =3D sizeof(*data);
> +               oparms =3D CIFS_OPARMS(cifs_sb, tcon, parent_path, FILE_R=
EAD_DATA,
> +                                    FILE_OPEN, CREATE_NOT_FILE, ACL_NO_M=
ODE);
> +               cifs_get_readable_path(tcon, parent_path, &parent_cfile);
> +               free_rsp_iov(out_iov, out_buftype, ARRAY_SIZE(out_iov));
> +               rc =3D smb2_compound_op(xid, tcon, cifs_sb, parent_path,
> +                                     &oparms, in_iov, cmds, num_cmds,
> +                                     parent_cfile, out_iov, out_buftype,=
 NULL);
> +               if (rc =3D=3D -EOPNOTSUPP && (cifs_sb->mnt_cifs_flags & C=
IFS_MOUNT_SERVER_INUM)) {
> +                       /*
> +                        * If querying of server inode numbers is not sup=
ported
> +                        * but is enabled, then disable it and try again.
> +                        */
> +                       cifs_autodisable_serverino(cifs_sb);
> +                       goto retry_query_directory;
> +               }
> +
> +               kfree(parent_path);
> +               kfree(basename_utf16);
> +
> +               hdr =3D out_iov[0].iov_base;
> +               if (!hdr || out_buftype[0] =3D=3D CIFS_NO_BUFFER)
> +                       goto out;
> +
> +               data->fi.DeletePending =3D 1; /* This is code path for ST=
ATUS_DELETE_PENDING. */
>         }
>
>  out:
> --
> 2.20.1
>
>


--=20
Thanks,

Steve

