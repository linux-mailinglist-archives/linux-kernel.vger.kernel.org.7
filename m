Return-Path: <linux-kernel+bounces-825823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7F3B8CE24
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D293E1BC0CE7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFA43101D2;
	Sat, 20 Sep 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjJrdMI0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7471FF7B3;
	Sat, 20 Sep 2025 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758390143; cv=none; b=JrWEEhYkIYoEGDQfjz8LI6HOgjtEoQtE4bH0LpchqgLIHn6+BaMIdlDrMYYUONr9HOQxc1h962+Ny5pUvpqeO51rHuowlWL8bge5ypIm9TX8F53EVkO9JzUhNZRz0gxO+MqQrKPYsrAA59woG8/V8Zq/cjQCahfLbvztMYVf07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758390143; c=relaxed/simple;
	bh=IQx9fdaWsISGEA7YRsGEk9eQNEJEVTMGWS5xnZarQOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFMAhi7CNis38E3OajcFf4yB9Uahox4fTA7vgfxtIyBijxTAOZeqzggTAORqog851hk5N3UAKbM8QEEpym18zUjH6laAHybMKX8fkiZLRBrh3YKay18OggAiEJnk4nL+d7AlvAxIpDJlMV7MhhHTflhtfBW+rKWkp1qQqAzdSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjJrdMI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16721C4CEEB;
	Sat, 20 Sep 2025 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758390141;
	bh=IQx9fdaWsISGEA7YRsGEk9eQNEJEVTMGWS5xnZarQOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjJrdMI0y49ociSSwYREkVh+CTVlNdF86Mv1u5ePlSvuJPlOmsXL3SueaQ9gBIDN5
	 6KAMgKqWPHG3DTc65wbTinq1vWEP9AgLe2iETwFB5R/ZFMfZoqQMr70stbzPuGuqIo
	 ZS7aF4sKR7UHGr8TL8CPSaf41H/+JKsy2IZmKY+QbKshWQnYi7bBDaioJ07J3HpQh2
	 9u0rruRPqyNrFlxEBEWPQlpN9nH7n5p31EUhjq5sDdsBeInx2+mL0KRlgcdKePTOR7
	 kH33LeaFY0PLB3gIGWiDXFrzMbBS/43GSBJaZeE+eW7VSq6qx1KkARJkWLQe3FwjGQ
	 qE4EQsWOReA0Q==
Received: by pali.im (Postfix)
	id 53B885DA; Sat, 20 Sep 2025 19:42:17 +0200 (CEST)
Date: Sat, 20 Sep 2025 19:42:17 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Steve French <smfrench@gmail.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/35] cifs: Improve SMB2+ stat() to work also for paths
 in DELETE_PENDING state
Message-ID: <20250920174217.h5neq5yllnbvgn5a@pali>
References: <20250831123602.14037-1-pali@kernel.org>
 <20250831123602.14037-9-pali@kernel.org>
 <CAH2r5muVP5NuZFfsCWDYhCKATDyeaD2cpXgC3=zNh+3T_zO1Mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5muVP5NuZFfsCWDYhCKATDyeaD2cpXgC3=zNh+3T_zO1Mg@mail.gmail.com>
User-Agent: NeoMutt/20180716

Commits in this patch series needs to be applied in the order.
So this patch does not apply without the previous dependent. It would
not apply alone.

I sent this patch series about month ago, so maybe the patch series
needs to be rebased, I can look at it in next days.

On Saturday 20 September 2025 12:26:40 Steve French wrote:
> This patch doesn't apply to current mainline - can you update it?
> 
> On Sun, Aug 31, 2025 at 7:36 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > Paths in DELETE_PENDING state cannot be opened at all. So standard way of
> > querying path attributes for this case is not possible.
> >
> > There is an alternative way how to query limited information about file
> > over SMB2+ dialects without opening file itself. It is by opening the
> > parent directory, querying specific child with filled search filter and
> > asking for attributes for that child.
> >
> > Implement this fallback when standard case in smb2_query_path_info fails
> > with STATUS_DELETE_PENDING error and stat was asked for path which is not
> > top level one (because top level does not have parent directory at all).
> >
> > Depends on "cifs: Change translation of STATUS_DELETE_PENDING to -EBUSY".
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  fs/smb/client/cifsglob.h  |   1 +
> >  fs/smb/client/smb2glob.h  |   1 +
> >  fs/smb/client/smb2inode.c | 177 +++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 176 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> > index e6830ab3a546..0ecf4988664e 100644
> > --- a/fs/smb/client/cifsglob.h
> > +++ b/fs/smb/client/cifsglob.h
> > @@ -2337,6 +2337,7 @@ struct smb2_compound_vars {
> >         struct smb_rqst rqst[MAX_COMPOUND];
> >         struct kvec open_iov[SMB2_CREATE_IOV_SIZE];
> >         struct kvec qi_iov;
> > +       struct kvec qd_iov[SMB2_QUERY_DIRECTORY_IOV_SIZE];
> >         struct kvec io_iov[SMB2_IOCTL_IOV_SIZE];
> >         struct kvec si_iov[SMB2_SET_INFO_IOV_SIZE];
> >         struct kvec close_iov;
> > diff --git a/fs/smb/client/smb2glob.h b/fs/smb/client/smb2glob.h
> > index 224495322a05..1cb219605e75 100644
> > --- a/fs/smb/client/smb2glob.h
> > +++ b/fs/smb/client/smb2glob.h
> > @@ -39,6 +39,7 @@ enum smb2_compound_ops {
> >         SMB2_OP_GET_REPARSE,
> >         SMB2_OP_QUERY_WSL_EA,
> >         SMB2_OP_OPEN_QUERY,
> > +       SMB2_OP_QUERY_DIRECTORY,
> >  };
> >
> >  /* Used when constructing chained read requests. */
> > diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> > index 2a0316c514e4..460e75614ef1 100644
> > --- a/fs/smb/client/smb2inode.c
> > +++ b/fs/smb/client/smb2inode.c
> > @@ -176,6 +176,9 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
> >                             struct kvec *out_iov, int *out_buftype, struct dentry *dentry)
> >  {
> >
> > +       bool has_cifs_mount_server_inum = cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM;
> > +       struct smb2_query_directory_req *qd_rqst = NULL;
> > +       struct smb2_query_directory_rsp *qd_rsp = NULL;
> >         struct smb2_create_rsp *create_rsp = NULL;
> >         struct smb2_query_info_rsp *qi_rsp = NULL;
> >         struct smb2_compound_vars *vars = NULL;
> > @@ -344,6 +347,41 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
> >                         trace_smb3_posix_query_info_compound_enter(xid, tcon->tid,
> >                                                                    ses->Suid, full_path);
> >                         break;
> > +               case SMB2_OP_QUERY_DIRECTORY:
> > +                       rqst[num_rqst].rq_iov = &vars->qd_iov[0];
> > +                       rqst[num_rqst].rq_nvec = SMB2_QUERY_DIRECTORY_IOV_SIZE;
> > +
> > +                       rc = SMB2_query_directory_init(xid,
> > +                                                      tcon,
> > +                                                      server,
> > +                                                      &rqst[num_rqst],
> > +                                                      cfile ?
> > +                                                       cfile->fid.persistent_fid : COMPOUND_FID,
> > +                                                      cfile ?
> > +                                                       cfile->fid.volatile_fid : COMPOUND_FID,
> > +                                                      0,
> > +                                                      has_cifs_mount_server_inum ?
> > +                                                       SMB_FIND_FILE_ID_FULL_DIR_INFO :
> > +                                                       SMB_FIND_FILE_FULL_DIRECTORY_INFO);
> > +                       if (!rc) {
> > +                               /*
> > +                                * Change the default search wildcard pattern '*'
> > +                                * to the requested file name stored in in_iov[i]
> > +                                * and request for only one single entry.
> > +                                */
> > +                               qd_rqst = rqst[num_rqst].rq_iov[0].iov_base;
> > +                               qd_rqst->Flags |= SMB2_RETURN_SINGLE_ENTRY;
> > +                               qd_rqst->FileNameLength = cpu_to_le16(in_iov[i].iov_len);
> > +                               rqst[num_rqst].rq_iov[1] = in_iov[i];
> > +                       }
> > +                       if (!rc && (!cfile || num_rqst > 1)) {
> > +                               smb2_set_next_command(tcon, &rqst[num_rqst]);
> > +                               smb2_set_related(&rqst[num_rqst]);
> > +                       } else if (rc) {
> > +                               goto finished;
> > +                       }
> > +                       num_rqst++;
> > +                       break;
> >                 case SMB2_OP_DELETE:
> >                         trace_smb3_delete_enter(xid, tcon->tid, ses->Suid, full_path);
> >                         break;
> > @@ -730,6 +768,64 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
> >                                 trace_smb3_posix_query_info_compound_done(xid, tcon->tid,
> >                                                                           ses->Suid);
> >                         break;
> > +               case SMB2_OP_QUERY_DIRECTORY:
> > +                       if (rc == 0) {
> > +                               qd_rsp = (struct smb2_query_directory_rsp *)
> > +                                       rsp_iov[i + 1].iov_base;
> > +                               rc = smb2_validate_iov(le16_to_cpu(qd_rsp->OutputBufferOffset),
> > +                                                      le32_to_cpu(qd_rsp->OutputBufferLength),
> > +                                                      &rsp_iov[i + 1],
> > +                                                      has_cifs_mount_server_inum ?
> > +                                                       sizeof(SEARCH_ID_FULL_DIR_INFO) :
> > +                                                       sizeof(FILE_FULL_DIRECTORY_INFO));
> > +                       }
> > +                       if (rc == 0) {
> > +                               /*
> > +                                * Both SEARCH_ID_FULL_DIR_INFO and FILE_FULL_DIRECTORY_INFO
> > +                                * have same member offsets except the UniqueId and FileName.
> > +                                */
> > +                               SEARCH_ID_FULL_DIR_INFO *si =
> > +                                       (SEARCH_ID_FULL_DIR_INFO *)qd_rsp->Buffer;
> > +
> > +                               idata = in_iov[i + 1].iov_base;
> > +                               idata->fi.CreationTime = si->CreationTime;
> > +                               idata->fi.LastAccessTime = si->LastAccessTime;
> > +                               idata->fi.LastWriteTime = si->LastWriteTime;
> > +                               idata->fi.ChangeTime = si->ChangeTime;
> > +                               idata->fi.Attributes = si->ExtFileAttributes;
> > +                               idata->fi.AllocationSize = si->AllocationSize;
> > +                               idata->fi.EndOfFile = si->EndOfFile;
> > +                               idata->fi.EASize = si->EaSize;
> > +                               idata->fi.Directory =
> > +                                       !!(le32_to_cpu(si->ExtFileAttributes) & ATTR_DIRECTORY);
> > +                               /*
> > +                                * UniqueId is present only in struct SEARCH_ID_FULL_DIR_INFO.
> > +                                * It is not present in struct FILE_FULL_DIRECTORY_INFO.
> > +                                * struct SEARCH_ID_FULL_DIR_INFO was requested only when
> > +                                * CIFS_MOUNT_SERVER_INUM is set.
> > +                                */
> > +                               if (has_cifs_mount_server_inum)
> > +                                       idata->fi.IndexNumber = si->UniqueId;
> > +                               /*
> > +                                * Do not change idata->fi.NumberOfLinks to correctly
> > +                                * trigger the CIFS_FATTR_UNKNOWN_NLINK flag.
> > +                                */
> > +                               /*
> > +                                * Do not change idata->fi.DeletePending as we do not know if
> > +                                * the entry is in the delete pending state. SMB2 QUERY_DIRECTORY
> > +                                * at any level does not provide this information.
> > +                                */
> > +                       }
> > +                       SMB2_query_directory_free(&rqst[num_rqst++]);
> > +                       if (rc)
> > +                               trace_smb3_query_dir_err(xid,
> > +                                       cfile ? cfile->fid.persistent_fid : COMPOUND_FID,
> > +                                       tcon->tid, ses->Suid, 0, 0, rc);
> > +                       else
> > +                               trace_smb3_query_dir_done(xid,
> > +                                       cfile ? cfile->fid.persistent_fid : COMPOUND_FID,
> > +                                       tcon->tid, ses->Suid, 0, 0);
> > +                       break;
> >                 case SMB2_OP_DELETE:
> >                         if (rc)
> >                                 trace_smb3_delete_err(xid, tcon->tid, ses->Suid, rc);
> > @@ -1090,9 +1186,9 @@ int smb2_query_path_info(const unsigned int xid,
> >                 break;
> >         case -EREMOTE:
> >                 break;
> > -       default:
> > -               if (hdr->Status != STATUS_OBJECT_NAME_INVALID)
> > -                       break;
> > +       }
> > +
> > +       if (hdr->Status == STATUS_OBJECT_NAME_INVALID) {
> >                 rc2 = cifs_inval_name_dfs_link_error(xid, tcon, cifs_sb,
> >                                                      full_path, &islink);
> >                 if (rc2) {
> > @@ -1101,6 +1197,81 @@ int smb2_query_path_info(const unsigned int xid,
> >                 }
> >                 if (islink)
> >                         rc = -EREMOTE;
> > +       } else if (hdr->Status == STATUS_DELETE_PENDING && full_path[0]) {
> > +               /*
> > +                * If SMB2 OPEN/CREATE fails with STATUS_DELETE_PENDING error,
> > +                * it means that the path is in delete pending state and it is
> > +                * not possible to open it until some other client clears delete
> > +                * pending state or all other clients close all opened handles
> > +                * to that path.
> > +                *
> > +                * There is an alternative way how to query limited information
> > +                * about path which is in delete pending state still suitable
> > +                * for the stat() syscall. It is by opening the parent directory,
> > +                * querying specific child with filled search filer and asking
> > +                * for attributes for that child.
> > +                */
> > +
> > +               char *parent_path;
> > +               const char *basename;
> > +               __le16 *basename_utf16;
> > +               int basename_utf16_len;
> > +               struct cifsFileInfo *parent_cfile;
> > +
> > +               basename = strrchr(full_path, CIFS_DIR_SEP(cifs_sb));
> > +               if (basename) {
> > +                       parent_path = kstrndup(full_path, basename - full_path, GFP_KERNEL);
> > +                       basename++;
> > +               } else {
> > +                       parent_path = kstrdup("", GFP_KERNEL);
> > +                       basename = full_path;
> > +               }
> > +
> > +               if (!parent_path) {
> > +                       rc = -ENOMEM;
> > +                       goto out;
> > +               }
> > +
> > +               basename_utf16 = cifs_convert_path_to_utf16(basename, cifs_sb);
> > +               if (!basename_utf16) {
> > +                       kfree(parent_path);
> > +                       rc = -ENOMEM;
> > +                       goto out;
> > +               }
> > +
> > +               basename_utf16_len = 2 * UniStrnlen((wchar_t *)basename_utf16, PATH_MAX);
> > +
> > +retry_query_directory:
> > +               num_cmds = 1;
> > +               cmds[0] = SMB2_OP_QUERY_DIRECTORY;
> > +               in_iov[0].iov_base = basename_utf16;
> > +               in_iov[0].iov_len = basename_utf16_len;
> > +               in_iov[1].iov_base = data;
> > +               in_iov[1].iov_len = sizeof(*data);
> > +               oparms = CIFS_OPARMS(cifs_sb, tcon, parent_path, FILE_READ_DATA,
> > +                                    FILE_OPEN, CREATE_NOT_FILE, ACL_NO_MODE);
> > +               cifs_get_readable_path(tcon, parent_path, &parent_cfile);
> > +               free_rsp_iov(out_iov, out_buftype, ARRAY_SIZE(out_iov));
> > +               rc = smb2_compound_op(xid, tcon, cifs_sb, parent_path,
> > +                                     &oparms, in_iov, cmds, num_cmds,
> > +                                     parent_cfile, out_iov, out_buftype, NULL);
> > +               if (rc == -EOPNOTSUPP && (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM)) {
> > +                       /*
> > +                        * If querying of server inode numbers is not supported
> > +                        * but is enabled, then disable it and try again.
> > +                        */
> > +                       cifs_autodisable_serverino(cifs_sb);
> > +                       goto retry_query_directory;
> > +               }
> > +
> > +               kfree(parent_path);
> > +               kfree(basename_utf16);
> > +
> > +               hdr = out_iov[0].iov_base;
> > +               if (!hdr || out_buftype[0] == CIFS_NO_BUFFER)
> > +                       goto out;
> > +
> > +               data->fi.DeletePending = 1; /* This is code path for STATUS_DELETE_PENDING. */
> >         }
> >
> >  out:
> > --
> > 2.20.1
> >
> >
> 
> 
> -- 
> Thanks,
> 
> Steve

