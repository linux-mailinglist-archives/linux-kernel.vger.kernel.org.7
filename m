Return-Path: <linux-kernel+bounces-847021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A188ABC9ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 263633537A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C308C2EA175;
	Thu,  9 Oct 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GxxxQNA6"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7DE2EBBBF
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022125; cv=none; b=NXEr3Aw7+SNm1vCK/9DkZuNob6A18lpnJKjvNp9qJmG9sGowfr0y/yCOFJaDpentsOwi8y8OchK/ZBtQQlR9QRaZtS/Ad9dup5BN7xziNmBzw90hHivb192ZJiZnfTONl7Ub9ECJx8HbikuFmpG+isHCYw8APdd5PDqIH0St128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022125; c=relaxed/simple;
	bh=+l8kANI6NVQS4JvPTTxgTvsC3X0f9vOyz8apIAlSRuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHRigAy1DqXI+4t8D6T77QCsdSHs4nc905T22JsvWOCDlIxI/OvUqjqcTRqOwhZHqJGXbCehOrlhnlH2VWzSUIXAwcID0F8PD+ZcbD5yPBm10ZYqX/CyGWZBY/KzVvH2CzaczR384VuOh3TZfPteUz9Kv3V1AFTSUHWKRxWKJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=GxxxQNA6; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-85b94fe19e2so106832185a.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760022122; x=1760626922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/z8khJoxVLHmPK7qoZGvzrF4DQgT26xSoUBDnCmifo=;
        b=GxxxQNA6TPCrcMz1+KQms/z4RoDqtIABDdD3qv/z2qoJ8NfQ8gDlNChost2MJ+9nAF
         g3BVysUbY6ycJZpE1uJS5mVu6npdMDaHulao3cb6mNIo5zwPS7jtTzr4Fx8xIIlOKXAN
         g0RlGOX0MPu6FdPZ/czHDHAJOnqVgSaUO5z6TMjyohZ8Q/Jfik1Z74MDfDp7EImu8lUr
         e5fx0VE67AoaRXvG2CBiXPypSL68JQEqeOAi06yM1c241/bpEueVtwiNOr724XaCmG+Z
         NFbnm4sTvr6/5UVZnmM5ueR07RfP6h9uQ/NHkx1K8vfkN5oRjxNaOflCtSs93HyAglUc
         4Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760022122; x=1760626922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/z8khJoxVLHmPK7qoZGvzrF4DQgT26xSoUBDnCmifo=;
        b=Bz7G9sXuxmlymzGpfQIJFQIYMdY+t1IRulVI62cBsNgQo+BvO1MllwxU/TUspUDP1B
         kByyS6/5ix7STV3QNnCKZfAYp708WxuQsiXuOHQ8psz00vgVqPb6oM71rd0RXnANmC29
         khCFH4UbmKrdlicpeXBnLh99UEOZJmY5YvzUqXBW4jGfw829/goDBMo4oqryhAlv6FqI
         eHYFmL15ZbRzB/hMjsCgp/E1srDQKDY/I4CEijsazaljTf4xrpdoXLYvTdgbZo95dbu4
         boin0vxqSQ4o4CNl4fmO5hdmjC8N8kEXBafXnh8u+wrY+eP+wlRriUWVAYp9u0dlnH5l
         CbMg==
X-Forwarded-Encrypted: i=1; AJvYcCWvUkr85D6b8RfiNEoitKgk/xqfTcVdFPlMCEeE3l370rP0TB9Z8yiffo2DqT+KteMaVs/jfPIDrSXaXL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfuuXtybuaEZCbjkqxISjMXycuCZ8yJ/z9zfvh0XhqZjMsbvoS
	DeUifoXCXy4B0ZXwwphELsxeATCfGp88MBdd/HV7A4a3lFD6AfC0GRgG2qB0lq63btnZZfNuj0L
	bgNSOrIQvTMg5jydbKZnhLGcZZD9E9aG7Q56FKvlcsQ==
X-Gm-Gg: ASbGncuJ7lyMRJ7n3B71VBXRiIistZ43c5YnmAY74vCtzCLAzADO71oGsRJglG+ybTr
	q8nFITIn2RvS04VO5m2XiWFrG1LCbUQ/l0r5GuCgPlqgIksTPMKRWlnhWpH4M8k8WOAwHCgJWI7
	2tA8eHkRrS66wYd+f2c5+S8Utb33lx4neynebtLilv1V4WQlLqjyYlrTL+SBN7TvvvxY7brQ0Du
	cvgSn62YztwZhfMrjqtrizGkciEucisotlEFXM=
X-Google-Smtp-Source: AGHT+IHWZrsWQBVDgH/jOLg85ut9tpsAvs6Ay6dPPKxRl0eGWT6ufzfd4YGMNHN9dJa9p/uV9JGeofl8lrekOiPxgXc=
X-Received: by 2002:a05:620a:1922:b0:80a:beb4:7761 with SMTP id
 af79cd13be357-88352d96abfmr1122356985a.76.1760022121721; Thu, 09 Oct 2025
 08:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
 <CAAywjhSP=ugnSJOHPGmTUPGh82wt+qnaqZAqo99EfhF-XHD5Sg@mail.gmail.com>
 <CA+CK2bAG+YAS7oSpdrZYDK0LU2mhfRuj2qTJtT-Hn8FLUbt=Dw@mail.gmail.com>
 <20251008193551.GA3839422@nvidia.com> <CA+CK2bDs1JsRCNFXkdUhdu5V-KMJXVTgETSHPvCtXKjkpD79Sw@mail.gmail.com>
 <20251009144822.GD3839422@nvidia.com>
In-Reply-To: <20251009144822.GD3839422@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 9 Oct 2025 11:01:25 -0400
X-Gm-Features: AS18NWCA3qNWmPQQ-Sno75dRV8wzDfExqmWutOxV0lNaAa2GJDqhBEemNsPTudQ
Message-ID: <CA+CK2bC_m5GRxCa1szw1v24Ssq8EnCWp4e985RJ5RRCdhztQWg@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, pratyush@kernel.org, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 10:48=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Oct 08, 2025 at 04:26:39PM -0400, Pasha Tatashin wrote:
> > On Wed, Oct 8, 2025 at 3:36=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com>=
 wrote:
> > >
> > > On Wed, Oct 08, 2025 at 12:40:34PM -0400, Pasha Tatashin wrote:
> > > > 1. Ordered Un-preservation
> > > > The un-preservation of file descriptors must also be ordered and mu=
st
> > > > occur in the reverse order of preservation. For example, if a user
> > > > preserves a memfd first and then an iommufd that depends on it, the
> > > > iommufd must be un-preserved before the memfd when the session is
> > > > closed or the FDs are explicitly un-preserved.
> > >
> > > Why?
> > >
> > > I imagined the first to unpreserve would restore the struct file * -
> > > that would satisfy the order.
> >
> > In my description, "un-preserve" refers to the action of canceling a
> > preservation request in the outgoing kernel, before kexec ever
> > happens. It's the pre-reboot counterpart to the PRESERVE_FD ioctl,
> > used when a user decides not to go through with the live update for a
> > specific FD.
> >
> > The terminology I am using:
> > preserve: Put FD into LUO in the outgoing kernel
> > unpreserve: Remove FD from LUO from the outgoing kernel
> > retrieve: Restore FD and return it to user in the next kernel
>
> Ok
>
> > For the retrieval part, we are going to be using FIFO order, the same
> > as preserve.
>
> This won't work. retrieval is driven by early boot discovery ordering
> and then by userspace. It will be in whatever order it wants. We need
> to be able to do things like make the struct file * at the moment
> something requests it..

I thought we wanted only the user to do "struct file" creation when
the user retrieves FD back. In this case we can enforce strict
ordering during retrieval. If "struct file" can be retrieved by
anything within the kernel, then that could be any kernel process
during boot, meaning that charging is not going to be properly applied
when kernel allocations are performed.

We specifically decided that while "struct file"s are going to be
created only by the user, the other subsystems can have early access
to the preserved file data, if they know how to parse it.

> > > This doesn't seem right, the API should be more like 'luo get
> > > serialization handle for this file *'
> >
> > How about:
> >
> > int liveupdate_find_token(struct liveupdate_session *session,
> >                           struct file *file, u64 *token);
>
> This sort of thing should not be used on the preserve side..
>
> > And if needed:
> > int liveupdate_find_file(struct liveupdate_session *session,
> >                          u64 token, struct file **file);
> >
> > Return: 0 on success, or -ENOENT if the file is not preserved.
>
> I would argue it should always cause a preservation...
>
> But this is still backwards, what we need is something like
>
> liveupdate_preserve_file(session, file, &token);
> my_preserve_blob.file_token =3D token

We cannot do that, the user should have already preserved that file
and provided us with a token to use, if that file was not preserved by
the user it is a bug. With this proposal, we would have to generate a
token, and it was argued that the kernel should not do that.

> file =3D liveupdate_retrieve_file(session, my_preserve_blob.file_token);
>
> And these can run in any order, and be called multiple times.
>
> Jason

