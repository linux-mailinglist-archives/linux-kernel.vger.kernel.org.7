Return-Path: <linux-kernel+bounces-863955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A681ABF996E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DFC919C7517
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987FB16A956;
	Wed, 22 Oct 2025 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0AP2GnV"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695DC148
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761095737; cv=none; b=MObaONS9oqRoKjUyo3n7lf3kcMbkwvX7xqJ0mwJvBESodtRH4XkoOSjV9UfmZwZm6IPxYySFdG6cryLFRwmQM59tIZWJMoOUraoiR3Efv9raU2UlRdvw8RlZZkPsncRy85bHeokDvHZKRmv2gYiFA9v1Lc50vxey+PNyd5/pCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761095737; c=relaxed/simple;
	bh=Jr9o8Fe1cMM3n6Vlk+UfVvrS4X6V47Y9qhlCyKITm0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0myV6Iaq1tsoaqS5wEpMndRrTMxEM3k48MRnUWqWtcEAcrn5Vd9FGDEiDMr6+f7wBtu7bEqoKxNu6y8kyzwcI8ehlFSzfDfp0NJRg4eqIBvSelyMTt31qy7i7HDXXCyUBNwBMJAbJKwBzv5yjdNPWJ7fTR81eufdlDa3Z8k1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0AP2GnV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c12ff0c5eso1095475a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761095733; x=1761700533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woIbsdxyP3SY2orn275GN3OxfriuvKkh/5p7Czi2+bM=;
        b=c0AP2GnVK9voeE+G28kwj4ROp/PTI9+xZjKV/vF+4qKRWFyUGOortsuSSnt7I8I+Uk
         DPwfm3u5p/JL2LdEqVPu+/XyvfZb2oiw4r9jjLf3TKuUYIK+jWBtGX+CeNsaH/LmDz1m
         BPZEUaajJhlHOAzVi7cHc5puB3W+tAniv7D9eG6hmLEqa2cZlT+XtrHbPDfa7hFVZXLT
         AxiLVgPxenyGXvCSJx7OU7gUVL5+lz/wS2npNV2v+8BmKQvfL/wsNRk+AZiTBbD7dg84
         xJ4ezO8GwP9MT2QNzr+Le/TKAEGaPusjOsWygeikrtuPpgNOyFw+4R5FfWvCUqyWlBTm
         eITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761095733; x=1761700533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woIbsdxyP3SY2orn275GN3OxfriuvKkh/5p7Czi2+bM=;
        b=rbJpI0sBwwznDbEXxOaMhAjAmGgP0I2iGTzvXS+DirhUxFeW8K7r8y/GB4rKj9cHFU
         dqVDGr/WTMuMklJncI2QIFtSRioE6P3OEWckrMZLUUYp8CdIHQSyaM9iiqsrLNZeajRj
         r4e1HKB1taKdcPfvIQXocqaj4XVoAVf0Qifr6xP1F+oyzj8dyyRL3jHofjlA/e/gHhqf
         a96UnhF3HLRn7YnuVrOxxR+xP5ItWAg1EoUt4xXLUsjQ2wOo/+RUDY3wE44PxA2WiRFP
         4nQQUS5p+r2VuMEUDE+a6qnC+yHwKEX89iXLmHtn2GQF/L/mM9nYJvcqhG8KvoN7xiGc
         A30A==
X-Forwarded-Encrypted: i=1; AJvYcCX/Vl69t5sMbVT2VeucliFV6Sds56Z6Im1iX8EaDBb/T0EEeMiz4qCs+UnpoTwkbuY7WgwxnE+AoV+wEfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9uSqyCvsbfT1a08zRUlEY7B85ju6BP0rHWYcQxxSv27FRpIv3
	MTopHLEe/vHis7HotHE1vDeAF2n0dqz6M4rl3XwxCmltj2knGDhviYiCRXgkW/5QMXMh+gaDoM5
	C0aiJuA3sg1y2+fzoJOUET7iw4F2OHmc=
X-Gm-Gg: ASbGncvhAQhjYFpVPyayfF7i6aZwcN6vjtsIspvek4i1th55YN4Lip68k94uchyxWRt
	KxsPm1P/bV+ri1ytNrJfl8ZKXhm7QwPawt1MwCw3eV96AJdu3ix7+1N1STATiCGoGPn8ouNRp/s
	sSdARmhcv9fjlP+5PgvKE2CPbjHCkGFzmNywwL49Nojl9G6oZC3Pcr0zh2xuwVVmmkzKPIjm/yg
	kyX6GQgxbBpuyOXmIbz1VU4Kb41J0Br5ChDNwvpgdijF/M5pGgjNyqevPT1Qg==
X-Google-Smtp-Source: AGHT+IF8qT+3cQlutV2V5LKeFy+yWaAPEmk3Tmkf7M+saEzE2zSCWO8VFBs5h26E80tQEv0kG/6sg9DsaoP8ItQy+eM=
X-Received: by 2002:a05:6402:440b:b0:62f:4828:c7d5 with SMTP id
 4fb4d7f45d1cf-63e173c288cmr1721406a12.16.1761095733265; Tue, 21 Oct 2025
 18:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-6-dolinux.peng@gmail.com> <e8b8b84a-b132-44f0-827b-668f32755ff7@oracle.com>
In-Reply-To: <e8b8b84a-b132-44f0-827b-668f32755ff7@oracle.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 22 Oct 2025 09:15:21 +0800
X-Gm-Features: AS18NWBRkH6bTJXyB56Sq1g9RoN36lgLPFuPztF6E3otkDZ-f1rD7uN3XKCLono
Message-ID: <CAErzpmuSEfgih1-RDN1FAxB5Sd1phKr9Ntr9YmdDw2vXGgZ0Gw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] btf: add CONFIG_BPF_SORT_BTF_BY_KIND_NAME
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 1:28=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 20/10/2025 10:39, Donglin Peng wrote:
> > Pahole v1.32 and later supports BTF sorting. Add a new configuration
> > option to control whether to enable this feature for vmlinux and
> > kernel modules.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
> >  kernel/bpf/Kconfig   | 8 ++++++++
> >  scripts/Makefile.btf | 5 +++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> > index eb3de35734f0..08251a250f06 100644
> > --- a/kernel/bpf/Kconfig
> > +++ b/kernel/bpf/Kconfig
> > @@ -101,4 +101,12 @@ config BPF_LSM
> >
> >         If you are unsure how to answer this question, answer N.
> >
> > +config BPF_SORT_BTF_BY_KIND_NAME
> > +     bool "Sort BTF types by kind and name"
> > +     depends on BPF_SYSCALL
> > +     help
> > +       This option sorts BTF types in vmlinux and kernel modules by th=
eir
> > +       kind and name, enabling binary search for btf_find_by_name_kind=
()
> > +       and significantly improving its lookup performance.
> > +
> >  endmenu # "BPF subsystem"
> > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > index db76335dd917..3f1a0b3c3f3f 100644
> > --- a/scripts/Makefile.btf
> > +++ b/scripts/Makefile.btf
> > @@ -29,6 +29,11 @@ ifneq ($(KBUILD_EXTMOD),)
> >  module-pahole-flags-$(call test-ge, $(pahole-ver), 128) +=3D --btf_fea=
tures=3Ddistilled_base
> >  endif
> >
> > +ifeq ($(call test-ge, $(pahole-ver), 132),y)
> > +pahole-flags-$(CONFIG_BPF_SORT_BTF_BY_KIND_NAME)     +=3D --btf_featur=
es=3Dsort
> > +module-pahole-flags-$(CONFIG_BPF_SORT_BTF_BY_KIND_NAME) +=3D --btf_fea=
tures=3Dsort
> > +endif
> > +
>
> perhaps it's useful informationally, but you don't need to wrap the
> addition of the sort flag in a pahole version check; unsupported
> btf_features are just ignored. Also we're at v1.30 in pahole now (we'll
> be releasing 1.31 shortly hopefully), so any version check should be
> v1.30/v1.31. I'd say just leave out the version check though.

Understood, thanks. Will do.

>
> Alan

