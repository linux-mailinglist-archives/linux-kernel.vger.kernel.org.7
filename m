Return-Path: <linux-kernel+bounces-750748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E80B16092
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2313BBC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689C529AAF7;
	Wed, 30 Jul 2025 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ou3HBEIO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A11D29617F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879554; cv=none; b=X3OApm2fpDUzRRDfoce8gBbCgHE0q8vyXplwAupZrl2BtqMF/LxEXa8EnGl7LVIbRLjw7HdcaIj9XSwrhgeCkSmwgVJWdzaXbq9y/fh0MVQzbacluk/JUOIYptmuc89FIV1QeQ4gjfdMxQq0lfTJTnzc2zHIFVNeDOHyr0rF+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879554; c=relaxed/simple;
	bh=KPRBhbNXQ89y7yXlekzpEo0FStffZkGkv/wQedV7F2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlGk+NdvsFY5rFfH33WlM43ENo6tWW4ItkFznMaXmHgu5Xhu5QzfnuRWzZIxYl4N/5dK/NzT12DrFnDgzNDiOkRmq/XHcMc0tZwYsZvNGThOR1E+xEr25AMtBUfiTdT0bYGSUayy7TC6yzzsE4eGidM5rPbr33SaT6JrDwnM+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ou3HBEIO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753879550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ls5YKJSWQL/3PEDIAsSwQYfpjHHq/k5BprG1NH0FL4M=;
	b=Ou3HBEIOjYtesbvNvjOZOFmOr/dcs736eFtCcK8GvTct/onjbrYO5TROMaQEtxG7PcXDxQ
	SVEqnOm4o6BnqBbjoRxpBdTY8srWqW31BiAL0jph3LHDzdm3/NwGEheggEEqBcB2Ly2F6r
	NaTZFqa1kyQ9g069KoIhz6izdKo7i9M=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-BtPvIh1uPwiXZdYJDl-2Hg-1; Wed, 30 Jul 2025 08:45:49 -0400
X-MC-Unique: BtPvIh1uPwiXZdYJDl-2Hg-1
X-Mimecast-MFC-AGG-ID: BtPvIh1uPwiXZdYJDl-2Hg_1753879549
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5314c884472so3717993e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753879549; x=1754484349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ls5YKJSWQL/3PEDIAsSwQYfpjHHq/k5BprG1NH0FL4M=;
        b=MdBxfgaD/hFeocKzXy02avBk4SbsbXW7+ErCmIoKiRj3qNOQuf0d6FXbeAze4UUv95
         fBAMxwI3JF3HQuWkuIh+Fdch34BJVAUtdExjRD6YlCnYSbzAUk8ALiUtMrUgxrEFZNIR
         HLrd5+DT/9cJHwmEt6mDusHAybzJd7/ygQ8KUVaACtPjed+fPPk4s2+XIYKhI+kuScIE
         8dEf8Oe1aQfivemrzIL4FjsiQvxW3DnxJEJqo7xuasxKF+GlpV54UyOAIBgcI+JQiBfy
         bbwvIKcRJ56sURU4AEINXnThE7MiNmE902fvGeOYm3rHVc6iG7JgcP7dKgWPxB7TF3OV
         H8lw==
X-Forwarded-Encrypted: i=1; AJvYcCWTaRwRb8hwyMsItNlaHrsAwzjND6uu3oZlcirST2gQY4Tcd3xKoWVTcO4N9Fojb1hbPuQMPC0tNT1H5gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeaLlNaH9eMUmeTgKlLosCNqtx4+RIUCntUbziDtsoFeU6fw3p
	mSb3u8IH1NLs05kAywXDbp2aGvaNsf88yUnmDnfCJFt2Ou/RwOSibcBQ5YM6GGPX9PydC7uYUgd
	m008NswyskVtSmWmDFs6HbicdsuUGLl6ZzBaPZDQXB3jkzZdKqyLHNg79rSzQsfojRRvroS5jdZ
	wXVoHz2QMJfqnWMf8oaIa/PikFUKLjfVjTFWTSqhXO
X-Gm-Gg: ASbGncu/Z4BpoOT3obbEXsHa0RQ4TYu44iPOV9cAW7BcHRq9jk20DlkEX8fJJJIRzL9
	iFQ9VMIEUGXkCQKx0t/kIT0mv1czsor8GMh+lX3At6E/mLS7sHx+UvpfcS6C7nrVOo0XAzDvtZf
	4ZI1Oo8MVCd5K/9pz/V84K53Hc6sUghL0VD4dtgec=
X-Received: by 2002:a05:6122:d9e:b0:538:dd8b:666b with SMTP id 71dfb90a1353d-5391c9d0a70mr1938026e0c.0.1753879548780;
        Wed, 30 Jul 2025 05:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlV9czO85QBaH+CJ0V1yAlUHCS8sU2qrXa9VW76z50NN05NpSoe1UP7Adv/fB8QpsqZk0XPlb9QcBhdTuZeas=
X-Received: by 2002:a05:6122:d9e:b0:538:dd8b:666b with SMTP id
 71dfb90a1353d-5391c9d0a70mr1938009e0c.0.1753879548399; Wed, 30 Jul 2025
 05:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730094123.30540-1-sunzhao03@kuaishou.com>
In-Reply-To: <20250730094123.30540-1-sunzhao03@kuaishou.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 30 Jul 2025 16:45:36 +0400
X-Gm-Features: Ac12FXywzIlYztZ5XlbWSWOP0IpJEIr__JCtCeSGIwy1Qq1Yk9d4yvmIvIKIZUU
Message-ID: <CAO8a2SioQ+iUgoC8+NiMkWS6Wj=2YwV7k9LWp5bfx2ZxpWJU+w@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock in ceph_readdir_prepopulate
To: Zhao Sun <sunzhao03@kuaishou.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The patch correctly identifies and addresses the deadlock by releasing
snap_rwsem before the blocking ceph_get_inode call.

My Recommendation:

Use down_read_killable: The current patch uses
down_read(&mdsc->snap_rwsem) after calling ceph_get_inode.
This is problematic because down_read is uninterruptible. If a signal
(like SIGKILL or Ctrl+C) is sent to the process while it's waiting to
re-acquire the snap_rwsem read lock (e.g., if another thread holds the
write lock), the process will hang indefinitely and cannot be killed.
Using down_read_killable(&mdsc->snap_rwsem) instead allows the lock
acquisition to be interrupted by signals. If it fails (returns
-EINTR), the error must be handled properly (e.g., release the inode
reference obtained from ceph_get_inode and propagate the error) to
ensure the process remains killable and doesn't hang.

This change is essential to prevent potential system hangs.

Best regards,

On Wed, Jul 30, 2025 at 1:49=E2=80=AFPM Zhao Sun <sunzhao03@kuaishou.com> w=
rote:
>
> When ceph_readdir_prepopulate calls ceph_get_inode while holding
> mdsc->snap_rwsem, a deadlock may occur, blocking all subsequent
> requests of the current session.
>
> Fix by release the mds->snap_rwsem read lock before calling the
> ceph_get_inode function.
>
> Link: https://tracker.ceph.com/issues/72307
> Signed-off-by: Zhao Sun <sunzhao03@kuaishou.com>
> ---
>  fs/ceph/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 06cd2963e41e..3d7fb045ba76 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -1900,6 +1900,7 @@ static int fill_readdir_cache(struct inode *dir, st=
ruct dentry *dn,
>  int ceph_readdir_prepopulate(struct ceph_mds_request *req,
>                              struct ceph_mds_session *session)
>  {
> +       struct ceph_mds_client *mdsc =3D session->s_mdsc;
>         struct dentry *parent =3D req->r_dentry;
>         struct inode *inode =3D d_inode(parent);
>         struct ceph_inode_info *ci =3D ceph_inode(inode);
> @@ -2029,7 +2030,10 @@ int ceph_readdir_prepopulate(struct ceph_mds_reque=
st *req,
>                 if (d_really_is_positive(dn)) {
>                         in =3D d_inode(dn);
>                 } else {
> +                       /* Release mdsc->snap_rwsem in advance to avoid d=
eadlock */
> +                       up_read(&mdsc->snap_rwsem);
>                         in =3D ceph_get_inode(parent->d_sb, tvino, NULL);
> +                       down_read(&mdsc->snap_rwsem);
>                         if (IS_ERR(in)) {
>                                 doutc(cl, "new_inode badness\n");
>                                 d_drop(dn);
> --
> 2.39.2 (Apple Git-143)
>
>


