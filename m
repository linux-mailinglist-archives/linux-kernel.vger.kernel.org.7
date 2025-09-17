Return-Path: <linux-kernel+bounces-820987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0524B7FF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3AD23B2F81
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4992D3EFC;
	Wed, 17 Sep 2025 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWqjDtYK"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C46522F757
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118363; cv=none; b=K47yt6b0c1xgBbelh4fTQwkZqQPehaI7NYQqiCemXqliWiAzGp6HSetcm0khbfPUmtKQeoUAfvfQP+QV1HQTUWg3O8VODTWTTbPT6ew2joUGUFygIRWxL/a8S3S7fpp2KKTL6jgXDSQrlrJdJA8AnQXluEL2d0vb1QFITEoXzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118363; c=relaxed/simple;
	bh=vAYyAJ+N5WTUxHpW/2g+4xRdn898OyOEJIqpwPj9b/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQXw95PXm13OId1/mgOZe0ghfp0npuEvrKXevKESJUe70yePZU1COpyIG9bwB4LScUU4EVDhgrONDnmTwwi3yq92NKORlijzL0971t+2SnkI0PAoYDBD7CXGcQZw/SlGTG/I8SAxZQS4WmQuqdJQoYy6WCpOt6Z5ups+uCdLFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWqjDtYK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62598fcf41aso9458724a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758118360; x=1758723160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvQvK494s3Wti/cOQyypkRIXGy03yU4MOudBoB5xafc=;
        b=gWqjDtYKZECXpoL15ydkDavMXNNUrgcroJ92oeqmnJahgeou3sqTIMw/IR4Ol69Gws
         Xe0nQgydGx1c4lN9VwCVJYWLjUSRUeQpV9UAqcAV6JF/QNSpwe+NC6OkyrOS6kYBE9Js
         7qeqZCLVidgNsx+l65NWdctxNpFII+qNR8T2a75KIak9Os8bPLfy2WAkFl6hjDgSIKNh
         AwQodrsyY67qeRvHv0hewe370P/v0/KN9KewGy/YVGKIlJmHolIPjpZwr+5ewL6H3+pl
         wxun/kUooymxpzTUGwf/2VtPX1m+jrYI2mmo/ptkYWpfymsCKvfsriWpgsWNxyPdJ8kl
         3QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118360; x=1758723160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvQvK494s3Wti/cOQyypkRIXGy03yU4MOudBoB5xafc=;
        b=qAMnV2sYPxzO5QhbQT/+NfHswr88v9JKPA2WNhWTN3tZL1LpqnPaihRWXibDufPvyJ
         sQATdPLXqV+DWNrMPSzit/YWEYPsBqUz9kvKZpthwRdoJhhKPaVQ+8UgOn88Kh9ZnFaN
         WVIE75lkS2EZbGRKbPQDaXhI9fzbfcng75lG0LIj2jjqtIFFmPYx+GFblflMTBVgjEvH
         x1DVooJG3dO2GjmsenqdglTBwmomk63/N6HyGM83STAiyDDK8Zr0u6JynJkbDf/BgvH3
         GSfXpiqenlohNPKKtp/tbjE8juMSuQgrkh9LCWP2NC7xqQIX9v21MDfWTRMuU2E7/AMM
         Q7YA==
X-Forwarded-Encrypted: i=1; AJvYcCWfvTVfrxOxUWHE0tYyY9Zru/5fxNPU8UgVSUxc7tcHmn1WIVaMywOU0OQIq8d2FOYeb8TmAmnc5G1FeOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdTg/Mh+CKj/KPxzuBwxu+K/VyKCxbwkxb71ElyTFCyI4aJ3V8
	wqfGIpCMJfMqv46DZsHv0Nr6dlBWqDHA80a3/USyBFqd45AtdUOIB/ujC3v/YoDu0DwMmAQaMb0
	b/K57UTLLeJaN+9ikebzNpAY/bYvgGDI=
X-Gm-Gg: ASbGncuTcHwDIIB7xMnOtaBHV+yqPVm31JJpyvMpoSOzwflMyQjfXfSKXsE056prIgJ
	BnhcZvec3g8oFoXXdw+RqQvxVTrX8QTajNaY5kmc9kIU2MC31gCV0rvAzbiYXZcwFY229HXw3Ct
	na8eZzYRZKw3eg+OnVG/xhvmwpunLye20ioHiMdoAhJ6D2nwpLEYofjypIvZGmlf4W+AO2r5KuG
	0T3v4kFvJ5MAV78Uz6WZPPHCRivFcqOxKXfu0k=
X-Google-Smtp-Source: AGHT+IE9tr65JazvM/P627oMjCH4lIxKxEXEjsbR4TaPhmEPiMyOp6W2xKFTSemRXPP2tElpIwdULTqBUJpCrnwZP+8=
X-Received: by 2002:a05:6402:280a:b0:629:949c:a653 with SMTP id
 4fb4d7f45d1cf-62f8422dd27mr2681936a12.24.1758118359355; Wed, 17 Sep 2025
 07:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917135907.2218073-1-max.kellermann@ionos.com>
In-Reply-To: <20250917135907.2218073-1-max.kellermann@ionos.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 16:12:26 +0200
X-Gm-Features: AS18NWBVEzgWJelbyAZl8OravcOrQ3fPpZBJDvJxRNN-yXIAsbshHF34p8BX9gc
Message-ID: <CAGudoHF0+JfqxB_fQxeo7Pbadjq7UA1JFH4QmfFS1hDHunNmtw@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:59=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> +/**
> + * Queue an asynchronous iput() call in a worker thread.  Use this
> + * instead of iput() in contexts where evicting the inode is unsafe.
> + * For example, inode eviction may cause deadlocks in
> + * inode_wait_for_writeback() (when called from within writeback) or
> + * in netfs_wait_for_outstanding_io() (when called from within the
> + * Ceph messenger).
> + */
> +void ceph_iput_async(struct inode *inode)
> +{
> +       if (unlikely(!inode))
> +               return;
> +
> +       if (likely(atomic_add_unless(&inode->i_count, -1, 1)))
> +               /* somebody else is holding another reference -
> +                * nothing left to do for us
> +                */
> +               return;
> +

LGTM, I see the queue thing ends up issuing iput() so it's all good, thanks=
.

No idea about the other stuff it is doing concerning ceph flags so no comme=
nt.

> +       doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n", i=
node, ceph_vinop(inode));
> +
> +       /* simply queue a ceph_inode_work() (donating the remaining
> +        * reference) without setting i_work_mask bit; other than
> +        * putting the reference, there is nothing to do
> +        */
> +       WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_wq=
,
> +                                &ceph_inode(inode)->i_work));
> +
> +       /* note: queue_work() cannot fail; it i_work were already
> +        * queued, then it would be holding another reference, but no
> +        * such reference exists
> +        */
> +}
> +

