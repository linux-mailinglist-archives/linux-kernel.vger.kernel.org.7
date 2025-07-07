Return-Path: <linux-kernel+bounces-720493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B33AFBC84
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481FE16ABE9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A71321D3FB;
	Mon,  7 Jul 2025 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IApY3rLd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E147D219EAD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920091; cv=none; b=t6av0Oda42IAAFURrI5BBSI5fscMmdpk5YViyUDcl3oHcbgG1U7nlvfdETc/SXXwpRs2YZP/Oq8ccugdlQ4vDQFRiJCJ7qwG0EW5Se0QayHNsyZrS86PWrhKe12qSHx8R+JuyDguwIJHl0cJXDusw1Uyl9UZBWxo+R5sAuyu/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920091; c=relaxed/simple;
	bh=wJm5XL2AN/wtuQtnqoX2xDDrfg6p7+O/hteMlYFyOVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R3yU7PLNpaeZO4l9lKur51YSkSmnw1DpoZrncgssPyb3SQKAg6saPxCJMa/C7zCZn5LX5tYFg//6i6Sf0l8w1kd5VuAhXJxp9GzhjXm9yVWRhhXMBPfE1JWu0Gv28vjMOpgmfMXmUBC9Rm5UJYlvryuZ6yUKBfKvhUg+pniNO7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IApY3rLd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751920087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LaAJBS5fCT5n2JFH0DqlZCq3hm+0Tj15kQ07VPmExLQ=;
	b=IApY3rLdqVE3Sgi+X9JqDs8be/HkKT5FE5E2TUspIq/x2JTTwA1AT1By5BokQoDpYenjtw
	yl1q1+3HsP/Ft6xLi9uJoo7HfDeUHcF00tB7FKU40e5vg60ihIy7pGCMqpKpq767Fer/EF
	UyIIWvY6n4if5FxT2Rn+ZU6XbDQOyhU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-DDFT33OpOcKZTOCUcGptSw-1; Mon, 07 Jul 2025 16:28:06 -0400
X-MC-Unique: DDFT33OpOcKZTOCUcGptSw-1
X-Mimecast-MFC-AGG-ID: DDFT33OpOcKZTOCUcGptSw_1751920086
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-710ed75c7efso52996507b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751920086; x=1752524886;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LaAJBS5fCT5n2JFH0DqlZCq3hm+0Tj15kQ07VPmExLQ=;
        b=YsVUzd81amxSS3cRtGOIVaJd28EW344i7Kkpiy/a1FmQ6NkQsQl6XMQG2fg86xd8g+
         nt2HtmpDiL756UsSv+ymRAkvtfkdlbHsEjMTMjdoV+o/txfSQVt/9q+m3JTEl4Jb65fs
         AUiR3ajHRcLyNfLWA3WTslG9PfskU9MkCi9r8Tp/jZ0XOaahPJlIOmffSzaKd1frrmX1
         0cr7XV0WmtWtABc03JnMS6Q+7zgxM5h5zTOdD5JO1eA6oSRYKntpOJ0rTlTaZNWVOa1m
         9J+LbYqhz7NNevNx3zW/tETnJU4rJDdPM7oMregO4D6vc19ZOLUJJUML/fqtyBgzEb4B
         tZBg==
X-Forwarded-Encrypted: i=1; AJvYcCWBj7eD1RPwxoX+w/TJdqspiaDeJXWVSn9FoUhxcOTNmpI/ncwCwm0u5re8ILBxSMKxOCXRDNfaItSw9hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNaaZBMiROgQGqDzS5Mm+1kDjY6JOAS7mKWE1g5XmQy+wdrCX
	dPEhxVcJROEFeHBeMAjfheE7YqDvt17BupNrVQ/nKYAEDfhTYdJxgusqIAic+k91JHafhumzb+F
	zCMdgSMlP6CVLkwmvBL3obj3uJGuE4mBTYAqX96CkajqcAUB4A5Q2+iLTGGZ1zvhj0g==
X-Gm-Gg: ASbGncvmFRVWnifQk5rn1k2KPsTEI/sxGf0DEn/5UXsrAAuvArFDzsMoW/+2XtZWJ5U
	5gAoko5tjlpmrEguJC1pm6jv8ZCIrG/p01q2fFOMGvt0lt85fWllczlmgBdvBJsCENlQggDBcCv
	3bFZU7sMfBYjxLrh8cLSV9MuZ20aaiu0hgLVKFdnaDSPuuOWSChJauetJiSjFyV4n+2//aiPLO/
	bmaLiYcQw+mPtsCEntFk5B8ROX1r6nsxxdW42kRuCbD8+BdT7AtFCeA7SorV+AtipSbRsk4kd2M
	nh2f5xu+oTwTe7ATPadlgxtbw4uE/vTby9ytKPvM/IrWOaFvND671NEqlMqF7RpbmQ1MzpJH
X-Received: by 2002:a05:690c:b11:b0:710:f1a9:1ba0 with SMTP id 00721157ae682-717a0265489mr2181827b3.3.1751920085918;
        Mon, 07 Jul 2025 13:28:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLpnBuyF0C0XXuT2Yb8x9jJDj3FWPZSJtfybwB9i+zuijNdj4VLYsumfdINkEE2Z8lg/ugbA==
X-Received: by 2002:a05:690c:b11:b0:710:f1a9:1ba0 with SMTP id 00721157ae682-717a0265489mr2181437b3.3.1751920085513;
        Mon, 07 Jul 2025 13:28:05 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71665adffb8sm17818367b3.59.2025.07.07.13.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 13:28:04 -0700 (PDT)
Message-ID: <59530cbe001f5d02fa007ce642a860a7bade4422.camel@redhat.com>
Subject: Re: [PATCH 2/2] NFS: Improve nfsiod workqueue detection for
 allocation flags
From: Laurence Oberman <loberman@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>, Benjamin Coddington	
 <bcodding@redhat.com>, Anna Schumaker <anna@kernel.org>, Tejun Heo
 <tj@kernel.org>,  Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	djeffery@redhat.com
Date: Mon, 07 Jul 2025 16:28:03 -0400
In-Reply-To: <a7621e726227260396291e82363d2b82e5f2ad73.camel@kernel.org>
References: <cover.1751913604.git.bcodding@redhat.com>
		 <a4548815532fb7ad71a4e7c45b3783651c86c51f.1751913604.git.bcodding@redhat.com>
	 <a7621e726227260396291e82363d2b82e5f2ad73.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-07 at 12:25 -0700, Trond Myklebust wrote:
> On Mon, 2025-07-07 at 14:46 -0400, Benjamin Coddington wrote:
> > The NFS client writeback paths change which flags are passed to
> > their
> > memory allocation calls based on whether the current task is
> > running
> > from
> > within a workqueue or not.=C2=A0 More specifically, it appears that
> > during
> > writeback allocations with PF_WQ_WORKER set on current->flags will
> > add
> > __GFP_NORETRY | __GFP_NOWARN.=C2=A0 Presumably this is because nfsiod
> > can
> > simply fail quickly and later retry to write back that specific
> > page
> > should
> > the allocation fail.
> >=20
> > However, the check for PF_WQ_WORKER is too general because tasks
> > can
> > enter NFS
> > writeback paths from other workqueues.=C2=A0 Specifically, the loopback
> > driver
> > tends to perform writeback into backing files on NFS with
> > PF_WQ_WORKER set,
> > and additionally sets PF_MEMALLOC_NOIO.=C2=A0 The combination of
> > PF_MEMALLOC_NOIO with __GFP_NORETRY can easily result in allocation
> > failures and the loopback driver has no retry functionality.=C2=A0 As a
> > result,
> > after commit 0bae835b63c5 ("NFS: Avoid writeback threads getting
> > stuck in
> > mempool_alloc()") users are seeing corrupted loop-mounted
> > filesystems
> > backed
> > by image files on NFS.
> >=20
> > In a preceding patch, we introduced a function to allow NFS to
> > detect
> > if
> > the task is executing within a specific workqueue.=C2=A0 Here we use
> > that
> > helper
> > to set __GFP_NORETRY | __GFP_NOWARN only if the workqueue is
> > nfsiod.
> >=20
> > Fixes: 0bae835b63c5 ("NFS: Avoid writeback threads getting stuck in
> > mempool_alloc()")
> > Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> > ---
> > =C2=A0fs/nfs/internal.h | 12 +++++++++++-
> > =C2=A01 file changed, 11 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> > index 69c2c10ee658..173172afa3f5 100644
> > --- a/fs/nfs/internal.h
> > +++ b/fs/nfs/internal.h
> > @@ -12,6 +12,7 @@
> > =C2=A0#include <linux/nfs_page.h>
> > =C2=A0#include <linux/nfslocalio.h>
> > =C2=A0#include <linux/wait_bit.h>
> > +#include <linux/workqueue.h>
> > =C2=A0
> > =C2=A0#define NFS_SB_MASK (SB_NOSUID|SB_NODEV|SB_NOEXEC|SB_SYNCHRONOUS)
> > =C2=A0
> > @@ -669,9 +670,18 @@ nfs_write_match_verf(const struct
> > nfs_writeverf
> > *verf,
> > =C2=A0		!nfs_write_verifier_cmp(&req->wb_verf, &verf-
> > > verifier);
> > =C2=A0}
> > =C2=A0
> > +static inline bool is_nfsiod(void)
> > +{
> > +	struct workqueue_struct *current_wq =3D current_workqueue();
> > +
> > +	if (current_wq)
> > +		return current_wq =3D=3D nfsiod_workqueue;
> > +	return false;
> > +}
> > +
> > =C2=A0static inline gfp_t nfs_io_gfp_mask(void)
> > =C2=A0{
> > -	if (current->flags & PF_WQ_WORKER)
> > +	if (is_nfsiod())
> > =C2=A0		return GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
> > =C2=A0	return GFP_KERNEL;
> > =C2=A0}
>=20
>=20
> Instead of trying to identify the nfsiod_workqueue, why not apply
> current_gfp_context() in order to weed out callers that set
> PF_MEMALLOC_NOIO and PF_MEMALLOC_NOFS?
>=20
> i.e.
>=20
>=20
> static inline gfp_t nfs_io_gfp_mask(void)
> {
> 	gfp_t ret =3D current_gfp_context(GFP_KERNEL);
>=20
> 	if ((current->flags & PF_WQ_WORKER) && ret =3D=3D GFP_KERNEL)
> 		ret |=3D __GFP_NORETRY | __GFP_NOWARN;
> 	return ret;
> }
>=20
>=20

I am testing both patch options to see if both prevent the failed write
with no other impact and will report back.

The test is confined to the use case of an XFS file system served by an
image that is located on NFS. as that is where the failed writes were
seen.




