Return-Path: <linux-kernel+bounces-760340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C2B1E9CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906FA1755E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF1527E05F;
	Fri,  8 Aug 2025 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YSHo12rd"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637BB20322
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661712; cv=none; b=Y0YzqUDBhwU4pt2DHmJwNldzKg3TPBoht08LVafkYsE5v8mxrN40GTay/5uo/V0/GgocXWQ4h1nVI/HtUpjh9qdTwm4TwOafrFSir4pz0biLvMY4zTmJUikqkCDoWzmDI5j6ef+9G0PkimDa/XYc7kE9f9eTS4QZdxPVR3IJj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661712; c=relaxed/simple;
	bh=XudJJd4XOmhk26ypsQpMMb/lzwssZiORriOrX5Ocrbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSiaoAEDmB70BPvxW8++RGziYUILRzPDEy5i4s0FIi/PGWUEyHQp/ve3SH3ua6emuSKbUyZnbbiGvLDiywAIyip8aDlfKr5UYac6dTZba+B63zMcpFZAt8tcQBPyMFPyDaBLWLffEcCelvdGGaJD528T4ymwaAp3lDVdTDi7rkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=YSHo12rd; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b08a0b63c6so24871181cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 07:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754661710; x=1755266510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cgf3Gf6pf2QyMmdIpvCgXWMeWxUvQmvcME2UoQnjQWw=;
        b=YSHo12rd43CZjqW43H4h42hhoZE0Xud+09tw6SvsSBoRb7hB8kynw5XuZmZEujxnso
         4dp4ibV/DHw38LS1oiLTtZR1H1mXcFQeUXB3STrQ9ls6TgB2p1kUPDsp2gVAjBcVo6MC
         ZY87Of0lUkgGaPCrGJRGNoDYDOvI8HJFkxolFIFdLpa0xqRXE31w2Rmmhj4heEjKwW24
         HGqi4f5bZXfFRGI/zJDr9kfPj86cZjfwHeXIEGou1GlTH15pBV/gMKkkAeeW2c11Sd8t
         Mck0ThFgWNTGZARQ3hlnbclT4AWvBW4nOJmnj5U+BAJEqOU9BRQ6pG4xnbHmdpHfTTpi
         mXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661710; x=1755266510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cgf3Gf6pf2QyMmdIpvCgXWMeWxUvQmvcME2UoQnjQWw=;
        b=kQ3yjASz19EFAHX5zAF8FDQujg9C7519eo/vHsxiNWFy9Bzjl1zyNWXCeWZcK4esuM
         icDIWzVtTJqIWwCD1BNk0j2+Vx4eV1rI5Y9NsRKlb7quZbH+yKmIlJolhKF6s3YGl7Ja
         Qfuc62/JD7dtchQNSs8tcnIN04BkHmRtHVfyrXU42Vdpod9dk2GzX0hZJBGmjs75wBN8
         4Y0P5kuKVYwbXTAiZwnrEN2dnFOu0AlGCSeX44V7WcAnG0dG9ubdp5z/ewMwOarz+tIC
         ta86wFVabnmqqve9ooZd0CiiOJNT/1uDpuyWmpDBTPGFunvdfA0TcvgUdqT5+aOvy/yB
         NXQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMXkkMUuFxwwIdY++sn4NcHX/MEty6vWRjwyPBoFWe4AbLJVkAg+idN6fifJhqfBmXchYTH+b3devDatk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhiivltxzhYIXmsEl0w+YJCbJ/LgxY3M3CoQg7lbgW6kjKLGlJ
	3KujKUL+fOVriCKYbhUtP6n/8kR1RX//bK/Efk4mMlkN+B635DvJD6d/e+LjyicJE2Zs3mGwD1l
	nopEZ6vyxwBPDftaHn7IS0stYXQKJt9WCMJ7q8ACsVw==
X-Gm-Gg: ASbGncsrH+g2/asL2nz1iy5godFGZ1WbwZaFxMPAbJEmT0K+J8vI2dsxH+++9lxM0mq
	dAezBOdpR9kSid19nIQWvx7DXseyxf011nHv6zwyT7fmhIk+awyTwBmnlCasHmB5E1FNWv1dkVo
	q8peSz6yq+jufay8iWncqOVFboD0zTbl5sL25kzbBWnd9tmth7AUq2pdYkPezBKEwCMKlU77Jxd
	laE
X-Google-Smtp-Source: AGHT+IEH1BqMSX1yIRX4eK9XjBPS6pkTO1kxH3JapIOH8TKb2ESrqoA/iZRqQ2exr79E4dgeMXF8CiLL82TWwqJhOYQ=
X-Received: by 2002:a05:622a:258e:b0:4ae:cc75:4703 with SMTP id
 d75a77b69052e-4b0aee5afb9mr42782921cf.58.1754661709835; Fri, 08 Aug 2025
 07:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-3-pasha.tatashin@soleen.com> <mafs0jz3eavci.fsf@kernel.org>
In-Reply-To: <mafs0jz3eavci.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 8 Aug 2025 14:01:13 +0000
X-Gm-Features: Ac12FXzfZzUeYL8qqgO-oYE8dxdNMTs6gp9itdpmGem1pHDL8sFl_NAXG2JwrAk
Message-ID: <CA+CK2bCqos=z0q+YsmFK_kFQ8PLyLQw32TkJB5SK2y4Y1kVErg@mail.gmail.com>
Subject: Re: [PATCH v3 02/30] kho: mm: Don't allow deferred struct page with KHO
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
	witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 11:47=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> On Thu, Aug 07 2025, Pasha Tatashin wrote:
>
> > KHO uses struct pages for the preserved memory early in boot, however,
> > with deferred struct page initialization, only a small portion of
> > memory has properly initialized struct pages.
> >
> > This problem was detected where vmemmap is poisoned, and illegal flag
> > combinations are detected.
> >
> > Don't allow them to be enabled together, and later we will have to
> > teach KHO to work properly with deferred struct page init kernel
> > feature.
> >
> > Fixes: 990a950fe8fd ("kexec: add config option for KHO")
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Nit: Drop the blank line before fixes. git interpret-trailers doesn't

Makes sense.

> seem to recognize the fixes otherwise, so this may break some tooling.
> Try it yourself:
>
>     $ git interpret-trailers --parse commit_message.txt
>
> Other than this,
>
> Acked-by: Pratyush Yadav <pratyush@kernel.org>

Thank you for the review.

Pasha

>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  kernel/Kconfig.kexec | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> > index 2ee603a98813..1224dd937df0 100644
> > --- a/kernel/Kconfig.kexec
> > +++ b/kernel/Kconfig.kexec
> > @@ -97,6 +97,7 @@ config KEXEC_JUMP
> >  config KEXEC_HANDOVER
> >       bool "kexec handover"
> >       depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FI=
LE
> > +     depends on !DEFERRED_STRUCT_PAGE_INIT
> >       select MEMBLOCK_KHO_SCRATCH
> >       select KEXEC_FILE
> >       select DEBUG_FS
>
> --
> Regards,
> Pratyush Yadav

