Return-Path: <linux-kernel+bounces-819143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3F5B59C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAFBE3BAC50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27500342C81;
	Tue, 16 Sep 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VnJ0vCRi"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1F30C357
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036414; cv=none; b=JeAz/WZWHvHGx6quXPBLsqpk4DrK+MtkRuP8jgXk6is/46HBvSS3bpeehjl/FFJZL4UTYhj/d4uIeHkextRoOA1Bl4zurpcws1lrvJ9ztW9WeZj8h2ytR8rqNj6oOD/G+5ewW5ETda1tktz1H+B8j983IXOrDtUcZkb7zXnxpUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036414; c=relaxed/simple;
	bh=Noq6g2x6GF3ios5lNzKv7l1qQ14O4NrJfERhAA5BjKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LL3xZcivtDVHDYZ3aGNeQ2ByAyzhgw/d8cAsTdN61iTN1tLep0M2eK3d9sSGSqDVXbir0Tp2fH2OmkygbTeLRrsCpMew3gd75bd0yz+4F84yivdj6d1GIcyYVp1+QCUyRaSyIvzdpaSdlB8xoiOQmAaVa/1DymdxhZREfd4ObBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VnJ0vCRi; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-30cceb3be82so3970118fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758036412; x=1758641212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCQn1+qgmwmQoE79zxmLidjuTy26gWnilkFHndViNWU=;
        b=VnJ0vCRicTn3JgwZupH1IF0F5j+ZDy1FosuYOaWdUPj0E3Qg7bHCiXxWklf7XIVCrN
         AdiabKRXMBHBPwpBB5x5vdl2IbluezYrTGF5YfJ9YrEMdbErGe5EvorwDFHtxMFHZvkG
         VzagQ/fQLvblcS3BrybCDM8M+VKqgBRqAiAzAmT0ExXmMpPaM9oK82nIFIEsQrmjEyx5
         HfgZbqM0MKWhRWJRV8oX9FS0aWeDCU/drrIbtdf974ZIsXyB4d5b4+z2DJywTAafnWzZ
         T98uRhHrous5sp7XfQLLcwnIdhNIpicir7zE5LUMPpEjViO2SKdbaoUeidscdyBYq/Ah
         ioBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036412; x=1758641212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCQn1+qgmwmQoE79zxmLidjuTy26gWnilkFHndViNWU=;
        b=PW8ZFuXGs5ueT2e/P2Ihsustud3GllRYN7Tv1x7nxDaXpAx/Pn6HTPf2Mnbj+mELjA
         bxVrVA1CjiEbCGpLDgpTF1bXdN3KOEw+tmm229t0yvFdUizrbQk0n2VdnfBInFhMargE
         /rWRSwu5kJADQoC36hww8ZknsKgnXSoJ7XUbJD3BLo8OaKRyslYlAW4tMSZAMCy7z4Ee
         n0fy8HxgCOTJ6YoCPt4LPu0tlV3dhliVU8k2L4Ev65bHdOx6IV6xuDxmKJDOg1ktDcCq
         GtL5WGdmziblswem/HaLV/jbkR+hr9CebQaK7PpwYaKH1ExPHVclYeroZI6X+WC1nxPO
         6tpw==
X-Forwarded-Encrypted: i=1; AJvYcCW5N8IVhhC+cV05osdbaDwX3XiO/li6UOsVrR+Rs6DaBtrwzB0kQ9NBiVmNt3r20rQE6rzPGRnibQPSszI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7PUN5aBInvfU/U4ddnyL2Qbd5fAzcAuj9K4L+S5MR9Q8FtkPl
	8hMRVXgaDtlLbtelYGgi0UZuUTeqk8xQAcDNtErR1r0Z5e+GTMNrIeiW6mFaJ8SxFagWwUgwyM3
	3McP+fpna9m2RgFqaerk8sFmYm7QN9RJX6lowHPio
X-Gm-Gg: ASbGncvY4cz+wmea+tltbY75MUSQfAXmUAuTl9fbIJ/SXB+M66n7X9YHeiSbETJNGYU
	TLxpX/MX/Bl3zPpNzu+AzNHtkToTqMTK/KFSR3nUO6EYX5DNJlJcdKdWXCOyc5bOP6HdNj9Xs0R
	ivcR93toCN/fr4syy262kLAS5uOQ3EN5qaDpF2Ai3mNa0bQJRUurE/81RC9ba4z1OgnLv+fR2PE
	YGgE3Q=
X-Google-Smtp-Source: AGHT+IEHQRX/QKtURM3ZBFKblim/ENLeZ5c+QD7UiDxNTE8WpHlGzNMOx/Q1hdBXqdyzU+cMTKCcGQ1RSf0ttX8oRA8=
X-Received: by 2002:a05:6870:70a7:b0:31d:8b26:f600 with SMTP id
 586e51a60fabf-32e54a8475emr6916168fac.20.1758036411638; Tue, 16 Sep 2025
 08:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826031824.1227551-1-tweek@google.com> <6afc91a9f5caef96b2ca335b6d143670@paul-moore.com>
 <92255d5e-7e0a-6ca3-3169-114ae7f6247f@google.com>
In-Reply-To: <92255d5e-7e0a-6ca3-3169-114ae7f6247f@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 Sep 2025 11:26:38 -0400
X-Gm-Features: AS18NWCuUiv9oyKOG1eHUS0O1Z1zJo100aKng26KHQ-sy3cd16UuRWkNtSHwhJw
Message-ID: <CAHC9VhQejS05C8AExkh32GidBdzXjauKPP6T_3eSGZDEwfwDuA@mail.gmail.com>
Subject: Re: [PATCH] memfd,selinux: call security_inode_init_security_anon
To: Hugh Dickins <hughd@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: James Morris <jmorris@namei.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 1:07=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
> On Wed, 3 Sep 2025, Paul Moore wrote:
> > On Aug 25, 2025 "=3D?UTF-8?q?Thi=3DC3=3DA9baud=3D20Weksteen?=3D" <tweek=
@google.com> wrote:
> > >
> > > Prior to this change, no security hooks were called at the creation o=
f a
> > > memfd file. It means that, for SELinux as an example, it will receive
> > > the default type of the filesystem that backs the in-memory inode. In
> > > most cases, that would be tmpfs, but if MFD_HUGETLB is passed, it wil=
l
> > > be hugetlbfs. Both can be considered implementation details of memfd.
> > >
> > > It also means that it is not possible to differentiate between a file
> > > coming from memfd_create and a file coming from a standard tmpfs moun=
t
> > > point.
> > >
> > > Additionally, no permission is validated at creation, which differs f=
rom
> > > the similar memfd_secret syscall.
> > >
> > > Call security_inode_init_security_anon during creation. This ensures
> > > that the file is setup similarly to other anonymous inodes. On SELinu=
x,
> > > it means that the file will receive the security context of its task.
> > >
> > > The ability to limit fexecve on memfd has been of interest to avoid
> > > potential pitfalls where /proc/self/exe or similar would be executed
> > > [1][2]. Reuse the "execute_no_trans" and "entrypoint" access vectors,
> > > similarly to the file class. These access vectors may not make sense =
for
> > > the existing "anon_inode" class. Therefore, define and assign a new
> > > class "memfd_file" to support such access vectors.
> > >
> > > Guard these changes behind a new policy capability named "memfd_class=
".
> > >
> > > [1] https://crbug.com/1305267
> > > [2] https://lore.kernel.org/lkml/20221215001205.51969-1-jeffxu@google=
.com/
> > >
> > > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

...

> > Hugh, Baolin, and shmem/mm folks, are you okay with the changes above? =
If
> > so it would be nice to get an ACK from one of you.
>
> So far as I can tell, seems okay to me:
> Acked-by: Hugh Dickins <hughd@google.com>
>
> If I'd responded earlier (sorry), I would have asked for it just to use
> &QSTR("[memfd]") directly in the call, rather than indirecting through
> unnecessary #define MEMFD_ANON_NAME "[memfd]"; never mind, that's all.
>
> Please do take this, along with the rest, through your security tree:
> mm.git contains no conflicting change to mm/memfd.c at present.

Thanks Hugh, it turns out we ended up having a discussion on the
SELinux side (proper return values for error conditions) and I'm going
to hold off on this until after the upcoming merge window to give time
for that discussion to run its course.  The good news is that gives
Thi=C3=A9baud an opportunity to do the qstr fixup you wanted.

Thi=C3=A9baud, are you okay with making the change Hugh has requested?

--=20
paul-moore.com

