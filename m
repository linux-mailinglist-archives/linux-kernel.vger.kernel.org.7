Return-Path: <linux-kernel+bounces-843270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BE2BBECE6
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C7C3BF4F2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9772417E0;
	Mon,  6 Oct 2025 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OJrCUT8j"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5823A9B3
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771434; cv=none; b=aaEo21PicZb/JB56J/kAhtKNSMb/E0V7kR+fHL/RPY/YcHozL0DkBtcvL5bCuIcWYJMNfunsBzXuB1EIN7VlHo4+VF+WysFrerPEZ7l/RKw3QjyyDwvGThWtoCZsrq6FM6KsRwyAj2yn/vMu2LEer6+40U+zPvyk1eBwNvAVAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771434; c=relaxed/simple;
	bh=VCA8jFwiTolL3cm7GWMVLR0c56Cedh5z95+OPkLnavM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k41wF8dy7HAQ2uexwmYqbpm+P9hQ7Z9kn6ZvEkd1aS7mkuBOxKuC0PbxV/ZLVLkIsABcWF0ayFOzveoPKcr0xoUDEmE4l1uCOGXJb8xGhE5p+3a71YBjOCjd8rDlSpqy84aC/l6QBD4BTZFwaQU9Yp5SEpxbjpdXVSZw+xNi1f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=OJrCUT8j; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-87808473c3bso683963885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759771430; x=1760376230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiMWaxwcwGco8r+FHYAdZ8/rgwTBKI1DQmsAsIjVEPg=;
        b=OJrCUT8jQ1mNcnSR1NLmBIfqGdxpgHINYtabLRdjkMxkXPT6sGB7gIwQr1H9xNEona
         DiC5wbz9mf1rauL19afcY+exwSjOTA36/uAwUq7iW7rNU1KqrG4P86xc/I59vVvmrTkZ
         d14QO1XAbxvrlU2XyT2aPqmir6tqASQEM563cJAjxlwJifzUgk4dDxzXQmxd5N7AR+YR
         Ml0FipJxTKlKwnCRMppOupicEfx6Hr5Z8I9lNpxrRfz8bw1r3HC/vaXnR+1QW0k3Na1V
         MTeQkG7PrCLcQoD8JEPM9bkOWnkMoYom/DpuH+/VH8mYfgUxfx/CMPecfex4Tzcl9kRA
         8V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759771430; x=1760376230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiMWaxwcwGco8r+FHYAdZ8/rgwTBKI1DQmsAsIjVEPg=;
        b=CLQYZ9dBk39w6IKp+8Pffa6EglQXqiiWcZFscRHhrPIBK2Y6lt0M+TnoEIENpFEgyo
         2CQjDLqN9GKJVVHwleL+bJoah1BMmMHjQ4lYCDh+Mrt+rs/BadtloR6L6KOSH/rJ/OZL
         4HqcEEoKaevU8fEZ+Mcur88251qPnx+begTrv9PX1vGXyklgO3Y4lywu/7D4KFsPgtZ/
         6dUkoJWHheBN8HCxMBiMpCNdTyojo9Q/HXOPsTdm0LUpre9hww6xGv8AC6wUOSFke4Hj
         bue7TQ/xTFPxo7KsXyIE5s2IxtH+fNz1dg67snJR1tm/OCSsC2dd4zZDmdsleZs/cKv+
         kCzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFV1/ZFb3hEor+5ogddWoTQIwHtWBQAhIPi1zxLeip3unCxunm27Ir+w9K6sl54hLFAtUnyfUpU68ZNss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1VgqtSk07rpOfM3AFGxLDbkQpFxoJA4V0ld0G8GPiBZbbUOpo
	rAFiHpNXCK7clR4ZLuCHoiay9T9KNxthmFygVtZoFnw6Fi8XeSUNAEBUw3MSKGb0UCe/iUGPdna
	xf+GNBszwjyd5ClKDkFT54TXsZQGtYTDol8PhgxOMGg==
X-Gm-Gg: ASbGnctoKZSuQoTuoDyxK8BXfAbF6EohAAQy4fA9SJynl3IAWYMQFcWYvO5fw1MlckQ
	pZm9FoSaEEMgGML9/RA1/hrcc8n5LSN1qW/C1EXbgDjGgJQ+qmO3Gla+5rF/rzabXTHglWyCMcZ
	7110KdvE9fgLAN0r4i/JjNtFWVI6jly/Y8LOkPJiduuSYXAZzcAUZ/7MBmpwJRfhDJMwTy6BinS
	IZcQHKCVIkB/7m5UxGSppQ+W2mTXFY+VdK5ecQ=
X-Google-Smtp-Source: AGHT+IFv/eQIGSPIMF5AtEJ9/NjM4NT3tDLx/ni0W3avlG1qBmkP6qV6SoLJbkqgHaLD5t7vOoviSBII4unw5QD/72E=
X-Received: by 2002:a05:620a:469e:b0:85e:5022:33a2 with SMTP id
 af79cd13be357-87a3a34d387mr1695495985a.39.1759771429425; Mon, 06 Oct 2025
 10:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-3-pasha.tatashin@soleen.com> <mafs0y0ponf6b.fsf@kernel.org>
In-Reply-To: <mafs0y0ponf6b.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 6 Oct 2025 13:23:11 -0400
X-Gm-Features: AS18NWCYmyLqK5As63FctOGJiEPF3B80wEZqrPZ_K5x_kzJeySLPd8Ta4rPXhIg
Message-ID: <CA+CK2bC0j=CbTNo=V-dceZEz9mji0yTWkE7QyUzvR1SRCiAJ=A@mail.gmail.com>
Subject: Re: [PATCH v4 02/30] kho: make debugfs interface optional
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, changyuanl@google.com, 
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
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
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 12:55=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Hi Pasha,
>
> On Mon, Sep 29 2025, Pasha Tatashin wrote:
>
> > Currently, KHO is controlled via debugfs interface, but once LUO is
> > introduced, it can control KHO, and the debug interface becomes
> > optional.
> >
> > Add a separate config CONFIG_KEXEC_HANDOVER_DEBUG that enables
> > the debugfs interface, and allows to inspect the tree.
> >
> > Move all debugfs related code to a new file to keep the .c files
> > clear of ifdefs.
> >
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> [...]
> > @@ -662,36 +660,24 @@ static void __init kho_reserve_scratch(void)
> >       kho_enable =3D false;
> >  }
> >
> > -struct fdt_debugfs {
> > -     struct list_head list;
> > -     struct debugfs_blob_wrapper wrapper;
> > -     struct dentry *file;
> > +struct kho_out {
> > +     struct blocking_notifier_head chain_head;
> > +     struct mutex lock; /* protects KHO FDT finalization */
> > +     struct kho_serialization ser;
> > +     bool finalized;
> > +     struct kho_debugfs dbg;
> >  };
> >
> > -static int kho_debugfs_fdt_add(struct list_head *list, struct dentry *=
dir,
> > -                            const char *name, const void *fdt)
> > -{
> > -     struct fdt_debugfs *f;
> > -     struct dentry *file;
> > -
> > -     f =3D kmalloc(sizeof(*f), GFP_KERNEL);
> > -     if (!f)
> > -             return -ENOMEM;
> > -
> > -     f->wrapper.data =3D (void *)fdt;
> > -     f->wrapper.size =3D fdt_totalsize(fdt);
> > -
> > -     file =3D debugfs_create_blob(name, 0400, dir, &f->wrapper);
> > -     if (IS_ERR(file)) {
> > -             kfree(f);
> > -             return PTR_ERR(file);
> > -     }
> > -
> > -     f->file =3D file;
> > -     list_add(&f->list, list);
> > -
> > -     return 0;
> > -}
> > +static struct kho_out kho_out =3D {
> > +     .chain_head =3D BLOCKING_NOTIFIER_INIT(kho_out.chain_head),
> > +     .lock =3D __MUTEX_INITIALIZER(kho_out.lock),
> > +     .ser =3D {
> > +             .track =3D {
> > +                     .orders =3D XARRAY_INIT(kho_out.ser.track.orders,=
 0),
> > +             },
> > +     },
> > +     .finalized =3D false,
> > +};
>
> There is already one definition for struct kho_out and a static struct
> kho_out early in the file. This is a second declaration and definition.
> And I was super confused when I saw patch 3 since it seemed to be making
> unrelated changes to this struct (and removing an instance of this,
> which should be done in this patch instead). In fact, this patch doesn't
> even build due to this problem. I think some patch massaging is needed
> to fix this all up.

Let me fix it. I Plan to send a separate series only with KHO changes
from LUO, so we can expedite its landing.

Pasha

>
> >
> >  /**
> >   * kho_add_subtree - record the physical address of a sub FDT in KHO r=
oot tree.
> [...]
>
> --
> Regards,
> Pratyush Yadav

