Return-Path: <linux-kernel+bounces-825814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A44B8CDE9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5AD1B23757
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E151030F7F5;
	Sat, 20 Sep 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIbXuR9J"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E2934BA36
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758389634; cv=none; b=Oq22pbmS/DsousHDQy+u2iniAncRHe5CpaplNFRs86akp1nVD7wxfa5X+uGEeZvIZcc0OPg1W1j7c1IeGWVWqJViqf3wd/g5uNpHDgNVmzfnUnW90VnUlwuBIxKlaHhgnXg8vk97UHMzvV5781ctmvatlQRFr016JNcM1ws3Udo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758389634; c=relaxed/simple;
	bh=axUg6ozbUEIEMe72bEm/AXSWRoT52B1CCWou4q0Sn+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtv5NE3Z0lBT59Cn86MfXJ0Bo1a/X6Q1r3Q53DL363EcJWxMIX0fWzA0w/dOtIk/sHvZXnlDMdYilXrrsyS4iEZKE8JVUYODB4LQVGegS2u8nue2lN+lupWW3u7I1FILkuZHPResybPk479V/RUbEWXRW41vLSiZuyyiYdNzZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIbXuR9J; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-796fe71deecso23817996d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758389631; x=1758994431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTxrZ6RUVsJ9ZObmKgt0fNbpsdhV3OAVQk54/OZ4DRg=;
        b=GIbXuR9JO7zNRNttqqigPsOmLzXryMOlUhMw4ZPn/R9nPa/pF1JV9SGymgl2U2X5If
         LzUa6ij3gtJtYhG1DW75/bB/6yYjF3/FXvUbcHRkUvvZC8n+q0tD9qcvhiM6mxLNVzKs
         SlqRej34bYU2ih/Kbg1fqiRdeth+UF8E3uzjFqgS4OMjFoKetsTV3UPhJtVMaAa2w360
         wncTXyzj8U0aZ3Wn9GspCG/HQIDUwZzrxBb+8awLOLgEFu3Oxu66QVp5HWEcRF+M5AhR
         8AA+uMrJpV8ZLjU9PUbjbnYIyjJn0mDkq5rph/T/T8PxGUdAqDj/mAe0wXJRphE+HtlT
         +I0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758389631; x=1758994431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTxrZ6RUVsJ9ZObmKgt0fNbpsdhV3OAVQk54/OZ4DRg=;
        b=gdaDbSz70mjC3jzC7bLTxWzrc6xUe6fRp8iJKV+yDE/tyI9MoqnSh2mcSk3Ydr8IBM
         CTizODvdg9oRvX55WohVLimAcX5WqYIcoPMJ1Da/OboI8RG4pMA9rLUu6DM96WLNPiy7
         h8SdgYBVC4rw7CJjP4a0hz/2B+pzdvcpV7yq4zi08hGY8n6TZrYd8IYCfNE8GtsGLXTv
         MoZgDgmu88iX+CixT4hRCoU04nhyoAT7NSASYw5J2fLPPDHYbhPP5u/Ix5kZh77i1eRB
         L/Tbfqoo5WGGpBtA38DQ6EpcV9nlmNdNUaxhLMR07TOLhGJYIql0hF1Zqq0aRu4lyiV1
         zHUw==
X-Forwarded-Encrypted: i=1; AJvYcCUuNsufF0jAdlvLfsPgCBSQxq2QvMUhV6AUWr1UV+w2FrF4p3R3DhXxrWZKRJgxVd2qrNM+ECkbr4kkZS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL1OnTCYuGJc+5pa4RevbRMIHOeaSCcVlMBrmaB5bU2opwmwFQ
	qT/cbUWv45WODp69Ia0W2TQ3oIUkGrkWtOqlyDjTwc4NtAVBDMpDpG98gEFl9Hwn9p8WmVWenlJ
	u5gO3eD958pTm1StEpM8GCNFA8CUz+zaWfQ==
X-Gm-Gg: ASbGncuNKRVd4VcjVVI7+G9DA93ZqhcUfjzOD8pklQVbrXlG8OkyjIBfTfmiew9nm0Q
	HqoqTlorkVRjHmNF5LpFniph8G9VJF5Ua0mB88VZ3jO298DGCUZXZBbUHbYdPUVVILHcWKoINKi
	YsiUxsDMwvp2O16vuESRUvoF3FvtAO93OiB+b3AU/9MlrHyAypRFp0oHiH3Z0uWMMP97hMz+38e
	6TwEefO/4q5zMQOK488Mq0QGGeSls4ypGkKXZSY5Ck8dJztbKnYrTrtK6ozevcKmTllYZiY4MDp
	sj2APWWGl/cgFoodDyFrkbVXIt48gaTyEG8PximD53LdAEpvJLZMpcGNnqTDUZ1W1JMo4tIcGFw
	KJJmalDjsrutYlAFCuI7V
X-Google-Smtp-Source: AGHT+IGw0LN8Ye25fHIKSO16jQgLUq+l9DfzB0UQcy3MWlSIptMJfl7DU8+o/Q07Xmrj3YBqBcF25mpIDZ+3LpHIkfw=
X-Received: by 2002:a05:6214:c68:b0:781:d761:5468 with SMTP id
 6a1803df08f44-7991a7430bdmr96518186d6.39.1758389631456; Sat, 20 Sep 2025
 10:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831123602.14037-1-pali@kernel.org> <20250831123602.14037-28-pali@kernel.org>
In-Reply-To: <20250831123602.14037-28-pali@kernel.org>
From: Steve French <smfrench@gmail.com>
Date: Sat, 20 Sep 2025 12:33:39 -0500
X-Gm-Features: AS18NWBiX16bf_9o6AX1NyV10rRA9QvcHW1qyR6ISSA8C6LIPXhf4HwqmXS4XCQ
Message-ID: <CAH2r5mtvP34-Da12BNjgjpQ9pNjrEfXc3HPGgrsZBowPwdW0zw@mail.gmail.com>
Subject: Re: [PATCH 27/35] cifs: Move SMB1 usage of CIFSPOSIXDelFile() from
 inode.c to cifssmb.c
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	ronnie sahlberg <ronniesahlberg@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This did not apply to current mainline

On Sun, Aug 31, 2025 at 7:37=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> Special case of unlinking file via SMB1 UNIX extension is currently in th=
e
> dialect agnostic function cifs_unlink() and hidden under the #ifdef
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY.
>
> Cleanup the code and move this functionality into the SMB1 ->unlink()
> callback, which removes one #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
> code block from inode.c
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  fs/smb/client/cifssmb.c | 12 ++++++++++++
>  fs/smb/client/inode.c   | 20 +++-----------------
>  2 files changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> index c09713ebdc7c..3a0452479a69 100644
> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@ -768,6 +768,18 @@ CIFSSMBDelFile(const unsigned int xid, struct cifs_t=
con *tcon, const char *name,
>         int name_len;
>         int remap =3D cifs_remap(cifs_sb);
>
> +       /* If UNIX extensions are available then use UNIX UNLINK call. */
> +       if (cap_unix(tcon->ses) &&
> +           (le64_to_cpu(tcon->fsUnixInfo.Capability) & CIFS_UNIX_POSIX_P=
ATH_OPS_CAP)) {
> +               rc =3D CIFSPOSIXDelFile(xid, tcon, name,
> +                                     SMB_POSIX_UNLINK_FILE_TARGET,
> +                                     cifs_sb->local_nls,
> +                                     cifs_remap(cifs_sb));
> +               cifs_dbg(FYI, "posix del rc %d\n", rc);
> +               if (rc =3D=3D 0 || rc =3D=3D -ENOENT)
> +                       return rc;
> +       }
> +
>  DelFileRetry:
>         rc =3D smb_init(SMB_COM_DELETE, 1, tcon, (void **) &pSMB,
>                       (void **) &pSMBr);
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index c3f101d10488..545964cac9cd 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -1947,27 +1947,13 @@ int cifs_unlink(struct inode *dir, struct dentry =
*dentry)
>
>         netfs_wait_for_outstanding_io(inode);
>         cifs_close_deferred_file_under_dentry(tcon, full_path);
> -#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
> -       if (cap_unix(tcon->ses) && (CIFS_UNIX_POSIX_PATH_OPS_CAP &
> -                               le64_to_cpu(tcon->fsUnixInfo.Capability))=
) {
> -               rc =3D CIFSPOSIXDelFile(xid, tcon, full_path,
> -                       SMB_POSIX_UNLINK_FILE_TARGET, cifs_sb->local_nls,
> -                       cifs_remap(cifs_sb));
> -               cifs_dbg(FYI, "posix del rc %d\n", rc);
> -               if ((rc =3D=3D 0) || (rc =3D=3D -ENOENT))
> -                       goto psx_del_no_retry;
> -       }
> -#endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
>
>  retry_std_delete:
> -       if (!server->ops->unlink) {
> +       if (!server->ops->unlink)
>                 rc =3D -ENOSYS;
> -               goto psx_del_no_retry;
> -       }
> -
> -       rc =3D server->ops->unlink(xid, tcon, full_path, cifs_sb, dentry)=
;
> +       else
> +               rc =3D server->ops->unlink(xid, tcon, full_path, cifs_sb,=
 dentry);
>
> -psx_del_no_retry:
>         if (!rc) {
>                 if (inode) {
>                         cifs_mark_open_handles_for_deleted_file(inode, fu=
ll_path);
> --
> 2.20.1
>
>


--=20
Thanks,

Steve

