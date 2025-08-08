Return-Path: <linux-kernel+bounces-760792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDF4B1F02E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 23:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE75F1C24688
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AB7261574;
	Fri,  8 Aug 2025 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p9xaqR+8"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA625C804
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754687495; cv=none; b=JFEtPz5cDYxr+vAfvvgjo41QycyUr9/Wl0EEq9VIDrlMa7XmhWjNhB9/qAxKKOyUI1M1K7AwspA8n42qOgcPsCvZ8kn1r5jooWDbUlM3S1cQDZy2oPzHTIYQGzCqap2o3XBW7ba5Vhk96UNgKDlwY8w9M5exazRoM13rC9PVg/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754687495; c=relaxed/simple;
	bh=jhF97vDz++8jIWHAzQbJeoiYqN5kXgsjhzGGekzGyq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+Kp1Q5xEdiod9UdiRYwISXhdW+ESF34dUX6TeN/10XJYKr3eA46VuQioonEP0yo08x2cT4LTa47xsf/czPPhF4lX61qw2Gwr0e3rK4Ng5ESJeHbFeJdUgDU43SIivkdIpxSJYO6TdK/UkYlZOOFdZlwyywwJ0FL9K4RbJn7AQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p9xaqR+8; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5392abfdaa0so873577e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754687493; x=1755292293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehKnkfmYV1CPBuFBvNcRdQv4DN/OCDrMMAnqBViNyms=;
        b=p9xaqR+83h0CCaxi0VfN2HH0j9XsI9thirJSCcuNwABJw+2jb09RaDnzXuuHXmHlHx
         t9F+DPNjSPjJAt4chjuedNlEvNA4ZG/RXqdrfgKtuP0yRG7WA6KRF0omSJT7QNpZEvpE
         OacDrKd2EPMK/ld0lhRx4+ysV1eTb73mzwoC9KVQxJeJxW+bKSy5kUNokq35rdq5TeZy
         u8Z88Osed61VdFX18yROkvZrY0hjLqA4eZ67zczlKM1eolkicCv2Of2AFi9lQWm8ZPBH
         WlGTqe/4mQKogx3a4OZWoDRYq0Yy4sQm/ZULZOf97zFpCqbIP6bt3L+mSQsIDlfJoe1t
         Qokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754687493; x=1755292293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehKnkfmYV1CPBuFBvNcRdQv4DN/OCDrMMAnqBViNyms=;
        b=Nw2ISNNXyxvTlRWjfh9U42fVcDa1m3faU1rtYiOeO1fFU0FoeriLr1Z3RMev5RrzQ2
         DD4h5IK3dxSD6htanOsjQBcvB8KTX0jKqRTkAzoV8CL5/7/AJjnJ2LQugYQ1fPxKK66j
         k9cCvQ6hDrKRWuQroHCxXkcmQvAkWFZclSD5uJw0o+uZxyRH0HoLMMIjPE+aEBb415KD
         hnXSDUX/g5ygekw8g6Ujl07jwSRxzV3iyiMEPcPh+BKcfEpDtN/QlEZ4QqD1953Blrmw
         yyK54ZGSBHrEOVAEluQpFD4B978HacKFZiKSsXHiSAcBNpmok0NWiEjii/DJIrYgfvMM
         d+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcDK2fWTBDTWD/TxawQPYjHh6p0x3jPSvUw93gQNSAmCvSUKvP/S0mRHUBjhcrsVTVMstCkCeHAvXXI7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCWEa5DNR0HXw1shMaFdS6V14kQtCz86FFGEGRQFDYrAKT+gEt
	GdjjVo7TLKJLOenDzI55rTBUJMLnKm9U178OKo9xZn/PPspa95QGqEjkZgzEhJDKsPk36XKxO5G
	SDS98BRgynNrvikLQcggfYjjYbwru8yf1uBrcx/LB
X-Gm-Gg: ASbGncvfx+ns2mXe22xefMqKmK3qNnhOgX71zrHhFHXn7Hf3RvpDVVSnX3imHI+/CIo
	a4sttrIGasSMz4ibNAIuoQWhHJnMeuPKQd697vvXzP0LX4X/VChXGA6y5uJ+tOfUNwGxqvM8yug
	jon3taxwd5WxnriXAW4CqKj03Ng1+RPnKUHETuTiy89Wawjgu3/5CYuruigDrRXx2yE4/DVLarl
	bXJM0OMiBUAQytyeAeUV2kiuTV5HA==
X-Google-Smtp-Source: AGHT+IE2KvKI2CvBT0FadlSYDRqABeGoePxhMGUXap+HsVWMK7ZUZeStgdlxM64AWKrgtdnHhv/ESJ17CItHcvhMQW4=
X-Received: by 2002:a05:6122:2026:b0:530:6bcb:c97f with SMTP id
 71dfb90a1353d-53a52eecdbamr2138142e0c.8.1754687492324; Fri, 08 Aug 2025
 14:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808142515.142058-1-ben.dooks@codethink.co.uk> <CAL_JsqJntD-o6zMo-vaCQ+f=QDuyEmUgBJqjztoriq4QF7=zEg@mail.gmail.com>
In-Reply-To: <CAL_JsqJntD-o6zMo-vaCQ+f=QDuyEmUgBJqjztoriq4QF7=zEg@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 8 Aug 2025 14:10:55 -0700
X-Gm-Features: Ac12FXzetJAzjjBU3znMOmqa4Yp1E0tMNtl4mkDvJgGow8ApSkTEnsF69RqbLDU
Message-ID: <CAGETcx99RE6=knBq75sMGUPKcuTKLXqJSo5NKyaZWRfXWEa7tA@mail.gmail.com>
Subject: Re: [RFC/PATCH] drivers/of: add debug for early dump of the dtb strcutrue
To: Rob Herring <robh@kernel.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 9:25=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Aug 8, 2025 at 9:26=E2=80=AFAM Ben Dooks <ben.dooks@codethink.co.=
uk> wrote:
> >
> > When testing for boot issues, it was helpful to dump the
> > list of nodes and properties in the device-tree passed into
> > the kernel.
>
> Shouldn't the bootloader be able to dump that?
>
> > Add CONFIG_OF_EARLY_DUMP option to dump the list of nodes
> > and properties to the standard console output early in the
> > boot sequence. Note, you may need to have some sort of
>
> s/may/will/
>
> > early or debug console output if there are issues stopping
> > the kernel starting properly.
>
> Seems to me this is giving the user the haystack to find the needle...

Completely agree with Rob.

Ben, can you give more context on what kind of issues this has helped
you (or anticipate it will) solve? Maybe there are better ways of
getting what you need.

-Saravana

>
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > ---
> >  drivers/of/Kconfig |  8 ++++++++
> >  drivers/of/fdt.c   | 39 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > index 50697cc3b07e..ed2c52c54a7d 100644
> > --- a/drivers/of/Kconfig
> > +++ b/drivers/of/Kconfig
> > @@ -126,4 +126,12 @@ config OF_OVERLAY_KUNIT_TEST
> >  config OF_NUMA
> >         bool
> >
> > +config OF_EARLY_DUMP
> > +       bool "Dump node list at startup"
>
> This needs to depend on OF_EARLY_FLATTREE.
>
> > +       help
> > +         This debug feature runs through all the nodes/properties at s=
tartup
> > +         to show if the dtb has been passed correctly from the boot st=
age.
> > +
> > +         If unsure, say N here
> > +
> >  endif # OF
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 0edd639898a6..ab40db0e71a5 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -1164,6 +1164,43 @@ static void * __init early_init_dt_alloc_memory_=
arch(u64 size, u64 align)
> >         return memblock_alloc_or_panic(size, align);
> >  }
> >
> > +#ifdef CONFIG_OF_EARLY_DUMP
> > +static int __init early_init_iterate_nodes(unsigned long node,
> > +                                          const char *uname,
> > +                                          int depth, void *data)
> > +{
> > +       void *blob =3D initial_boot_params;
> > +       int cur;
> > +
> > +       pr_info("node '%s', depth %d\n", uname, depth);
>
> Can you add indentation for the depth rather than printing the depth?
>
> I'm not completely sure if calling this is safe always. How early this
> will run depends on the architecture. So need to test on a variety of
> architectures. Or perhaps limit in kconfig to tested architectures.
> I'd rather not do that though.
>
> > +
> > +       for (cur =3D fdt_first_property_offset(blob, node);
> > +            cur >=3D 0;
> > +            cur =3D fdt_next_property_offset(blob, cur)) {
> > +               const char *pname;
> > +               const __be32 *val;
> > +               u32 sz;
> > +
> > +               val =3D fdt_getprop_by_offset(blob, cur, &pname, &sz);
> > +               if (!val) {
> > +                       pr_warn(" Cannot locate property at 0x%x\n", cu=
r);
> > +                       continue;
>
> If this fails, you should probably just stop and bail out.
>
> > +               }
> > +
> > +               pr_info("node %s: property %s\n", uname, pname ? pname =
: "unnamed");
>
> Can unnamed actually happen?
>
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static inline void early_init_dump_dt(void)
> > +{
> > +       of_scan_flat_dt(early_init_iterate_nodes, NULL);
>
> This way to iterate is left over from before having libfdt. Is there
> not a libfdt way to iterate thru all nodes?
>
> > +}
> > +#else
> > +static inline void early_init_dump_dt(void) { }
> > +#endif /* CONFIG_OF_EARLY_DUMP */
> > +
> >  bool __init early_init_dt_verify(void *dt_virt, phys_addr_t dt_phys)
> >  {
> >         if (!dt_virt)
> > @@ -1178,6 +1215,8 @@ bool __init early_init_dt_verify(void *dt_virt, p=
hys_addr_t dt_phys)
> >         initial_boot_params_pa =3D dt_phys;
> >         of_fdt_crc32 =3D crc32_be(~0, initial_boot_params,
> >                                 fdt_totalsize(initial_boot_params));
> > +
> > +       early_init_dump_dt();
>
> Use "if (IS_ENABLED(CONFIG_OF_EARLY_DUMP))" here instead of #ifdef.
>
> >
> >         /* Initialize {size,address}-cells info */
> >         early_init_dt_scan_root();
> > --
> > 2.37.2.352.g3c44437643
> >

