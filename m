Return-Path: <linux-kernel+bounces-893499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CB1C47983
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CBE3A92D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B7C25A340;
	Mon, 10 Nov 2025 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="EU27gWJm"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885C1DDC37
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788724; cv=none; b=ZIAEekwQnWC209ryff1dgOOZu2PeuczFg+UpF+lSjq+aKz5A4IUqNpwadLbDqkQNQ4EgbECHLLAh0A6G81NR27hYEL2an18spdZkxHZLlqAw4p6Z2qXRwims5JG9gRu0sBIsVYTryjAu8HXcxjK0qZ2rEXYRyFqTfhGH0w6TMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788724; c=relaxed/simple;
	bh=9h+ZKAhSsqgldYZEpyKXHMieyzaB7ycGyDH+cOcDlpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usBQp6X2iuaeDZ1EbQho+4Lt0YDsRg4mCFmX70VwN3ngmdHguZGG+NLGhSrJQqEizhQH+k9nZ6MKSMQU3NCxo+ocqhY9GdUWzFtKBb6m8NWItjujQRM5IetdM1Z/b9XZCr/szPgpwT29i5/Ya6Fzfgv7KAQdvPdyGFcuxppRhRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=EU27gWJm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso2498352a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762788720; x=1763393520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvyB1b8oEOYU6YUvXYl67lC2NdpCRz0gUoF3IKmaXbs=;
        b=EU27gWJmq9JMelxQDi91PUccxgQEgBJt2PC/4+W9A4/gHw0peAFW15LiEK4TPsKvBo
         pVQeWBusfBajc+LtnW3SssKIsXnO2vYY3l3HG0t4HZUns37MbBaAr23rMcPlzyizQoit
         RXXgr+RsqtarA6PWSrsktGuX89tEJgR/XBUab5cSnWl0FYBk804f3DTAANJbMbeEEH+a
         VXOJIiMC2GskgXImXbKqPAs7v4Iz895nfsBByO0xuHQ1SWYaoUm/IYbMSKSjjTXBoD0y
         nBoO7Jfyh+yFLCY7Cx7/o4NUzgN4ReN7mSDzzMAYikRWoUL58o2kxL7Pk+Irpwvm0zMf
         bGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788720; x=1763393520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yvyB1b8oEOYU6YUvXYl67lC2NdpCRz0gUoF3IKmaXbs=;
        b=urdMFf1gyhW93iyOz7Hr9kldVEBI68c9B/mT0sGTKGxp6akkj4zBXUxgmgzUXFYOKJ
         IBhR0oJTav5t7bo/QwfmViego7g3d6/cHkwKe8tZ2jL8cQKSCgzwjPegcOebKAqlE1D7
         mlM/w5NXJTgttssY2O40zzyc2FpLrGDn3ctMnV5IRJQ0/OT1TVF8wEY4+Xf71aZXeu1x
         ZHP8tZQDmkwms6V1NRqJb+6oEjGegvpd9lK49VAud8J+NtRq91TbEDFiTGDq+q8Ea/dI
         V3QI0ILZllqZ3ssCbhq1hoTI8whSldUudMP0DzdrdUH5nJUuv+o3n7SUiQa6ivyxHqWH
         fKrA==
X-Forwarded-Encrypted: i=1; AJvYcCVnVkEcybqA5CgkKeztbYBs0QW4Z8BjuQEaoyq8QCe3FBT4xkHZEmA2qAg+6kGJNtLptWjlKDCLn9LSK2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXx1gy+V9wQBwPvvmvHjL1U7MseJq9DRsbifJ5zapISYaFQXF
	OLmxNkev8C1jmLzMDAYo/vW0MiUJaQyfOycNnFpscVb2vsUe2qXuqmKSHQehzpd7wCVKmxEWTZ0
	HMYQ+jOsVu7okelYanjBAoYF7DHZ2kcddAvSmuEelZQ==
X-Gm-Gg: ASbGncvamENm3WRp+uMuXxoYsEVDXusywf0mprMFuS6iG5jAMKgpBr49emPi8H7kQrB
	V+1Fe22eMC4w75G8t/B3jDAIS7kguEGmTgdE9OhhtDaGdqF9pw2PQ6dmIRhSbLvLxR+nVIm4Gv/
	rbpbzXQFPNCitqNx6CHbA8zsBGV4z0e2b5vpcs8AKzT0AjIO4AZCweTOw1E4jKvyy9F9cmJvYTq
	cQUI07cIJzLuQIrkhyhGmcLdDdFgpe/HdpmDqGq6fTeReMME6f7aqbzIg==
X-Google-Smtp-Source: AGHT+IEWEmCpMEiE/sigVWI2wEcl1lVXHLXnEbH4KM274tOZXUBy76PsgNh+OSo+pFw8/8SS+R3xNlWxCqdsS2OcqhQ=
X-Received: by 2002:a05:6402:51cd:b0:63c:4d42:992b with SMTP id
 4fb4d7f45d1cf-6415dc1304emr7523926a12.13.1762788719813; Mon, 10 Nov 2025
 07:31:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-6-pasha.tatashin@soleen.com> <aRHe3syRvOrCYC9u@kernel.org>
In-Reply-To: <aRHe3syRvOrCYC9u@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 10 Nov 2025 10:31:23 -0500
X-Gm-Features: AWmQ_bnDFpVyCmvtk4rzMsE7lIBuj-Os5t1X5u5kjgkokRKpm2UiGZaOTcTCYY0
Message-ID: <CA+CK2bA=cQkibx4dSxJQTVxVxqkAsZPfFoPJip6rx8DqX62aEA@mail.gmail.com>
Subject: Re: [PATCH v5 05/22] liveupdate: kho: when live update add KHO image
 during kexec load
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 7:47=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, Nov 07, 2025 at 04:03:03PM -0500, Pasha Tatashin wrote:
> > In case KHO is driven from within kernel via live update, finalize will
> > always happen during reboot, so add the KHO image unconditionally.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kex=
ec_handover.c
> > index 9f0913e101be..b54ca665e005 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/kexec_handover.h>
> >  #include <linux/libfdt.h>
> >  #include <linux/list.h>
> > +#include <linux/liveupdate.h>
> >  #include <linux/memblock.h>
> >  #include <linux/page-isolation.h>
> >  #include <linux/vmalloc.h>
> > @@ -1489,7 +1490,7 @@ int kho_fill_kimage(struct kimage *image)
> >       int err =3D 0;
> >       struct kexec_buf scratch;
> >
> > -     if (!kho_out.finalized)
> > +     if (!kho_out.finalized && !liveupdate_enabled())
> >               return 0;
>
> This feels backwards, I don't think KHO should call liveupdate methods.

It is backward, but it is a requirement until KHO becomes stateless.
LUO does not have dependencies on userspace state of when kexec is
loaded. In fact the next kernel must be loaded before the brownout as
it is an expensive operation. The sequence of events should:

1. Load the next kernel in memory
2. Preserve resources via LUO
3. Do Kexec reboot

Pasha

