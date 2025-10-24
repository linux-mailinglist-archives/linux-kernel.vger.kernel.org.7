Return-Path: <linux-kernel+bounces-868037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ADDC04353
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78BCF4F3690
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C12609C5;
	Fri, 24 Oct 2025 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr6iWYEZ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D9146D53
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275097; cv=none; b=XnI1Ihkl7UD80RbZKFe/+EgAs9m1NRSKNwjA6DA/x4m5w+ML0mlza8umQCcDEcw46ioI4zecre7v20NPn8j8Pa76fBDMZbiBIuxbFKGLcYqPo1gTzljO1rEB8WkZcYYcMOOymRX+RU6wN+8FYG+ozHV8C2et2FqLOorYjFGB3B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275097; c=relaxed/simple;
	bh=9qvwpdbG6zEDU8NOfGA49If3FN+HOu5UEImINHYPOas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYmIPg36GdlfAxD8SNhKfl1yX6FGLAgKAWzTkKkZ8hx5oJUtvJexV/2ZkJBR+Uf9DN1wSMotIXG2Rjyc7qDcAUOMVG59eGElAMtFWg77Xj8Mu7uZTfWgRzxFs8kslCSXzsvcM/1gdTkEgoUzrVg/shdirKtQn4ud8mDTaI9RxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vr6iWYEZ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso5169290a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761275094; x=1761879894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPUr1ujv1VAgrlSTn6U9qdaZAklVD4GTZntdmTR2xhA=;
        b=Vr6iWYEZE8b5YV0dX1KnHxllBWKxm8apBTWHtWJAVimTEhONy6ShRJFncZa4/SInfM
         vOrsZj+FnwbpOTfNMy2jFG8z4s/bnxkGZgj0X/bVifE4mGfsbIpFddrbOC+38QMoXTE2
         fCN4IyZDuBOj3DJ5D5BCSYf6N5iWtZdzYVcmrpEdvUows8nid3UzD1CJdJHP3vRUoosQ
         xLvalhb9XsiV5gfSXFYY8rrpZDpPqM+sv/cwuutcjeU62HZpek/WhyO6I5mXj8ljstBt
         tDwWyBDKpFRarjGvdFsMMWuYMqoZ1Vy4ZtBdc9mRxFHkEu5NDp0bd4xnfN8dCogWoG4h
         DIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761275094; x=1761879894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPUr1ujv1VAgrlSTn6U9qdaZAklVD4GTZntdmTR2xhA=;
        b=iQaaMY6c6uTsBsESu7q6srJ0YM31ZJPxz1Xlj+plXbzY42uwg/OXCENoW+b7ZNeFzn
         S+tqAThCB7P17mje6fsogI5RG5jQvpUmPgoOlPvB3Fhy7kO6F/38TZzoqjy5+xUj9F/l
         wWSG25VSu35rL1aCY6F5uDdAuPSLPXGPwNByJnMg7Y2IgFjNY9g/PuvERZC7xJLP1Qoj
         JSEPSJP75XDhaJf6iz6COE849jq+PYERJVLxLMzEHm6k/fTYE7aWfm1u1OHs47KnLSQR
         854cmgeu3w0KCQwyUKUbyDIJ9xSI7Q6m2PZSBixXEbA9NE/utdZFIMEgEDegnpwbpLoX
         4DeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFtoS+0hKkIBnIEJhl544+X2rDYNMZ0ENeKTPozzFqrOIm4AnWxLyjQG0YSL0KkUprXPQy/p+ArbzppoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQv+t1oTFoIcAAF8A7Nlr33Mz+6HdjCn2rohA9FlB3JQmhyV4
	yzM8GuiF6f/ujNLKNvrlKI5CMLtg2PsZtyUflas2g0uOcV37m2FkI8OHSxtfOrZyqWSNbN+pZE7
	DB6bvPcLzzGID972VtGoVdc9MMapsg70=
X-Gm-Gg: ASbGncvchB5pYYJkG9gVLDJZ4k5soqGGRfnqd0JlJEJIfyW0p1vekdCxK40UV8koqIq
	xK+qC6bd3yMBBro5VDJ+hhNCLnetZ2iSI1XJiNUAmgpctSEhKhDU9gExfX7KBcK0lZhoc25vG0G
	s9pHWCQaTjOZ7RPTUOVP1rPqmIm5YOHDaCqNVwn5DJJomVgEK4b57M5pKFoXhVzXnqSqtgGQbv8
	A/VWsD3nHE0pzrmnubes3wyaJXpXOtbvYWSn8sy/ukIWcrTIewsym7KiJVXdmc/gpc26v8B
X-Google-Smtp-Source: AGHT+IFLGx1bMWOEh+6E7cuvAEG/Y+JZKAjZastrcZR//d17jCwFzXukweVlGVe7meHeLU/xts4ZS4gYTnL5zJWAVJE=
X-Received: by 2002:a05:6402:2712:b0:63c:13b9:58b0 with SMTP id
 4fb4d7f45d1cf-63e5eb076cbmr1048162a12.5.1761275094270; Thu, 23 Oct 2025
 20:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-3-dolinux.peng@gmail.com> <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
 <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com>
 <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com>
 <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com>
 <CAEf4Bzajdv3Rd1xAxm_UZWBxPc8M0=VuUkfjJvOFSObOs19GbQ@mail.gmail.com>
 <CAADnVQJG_tK18oxmjW37cbrxF2zPKPk_dvqXUTnOjUue7J0tLQ@mail.gmail.com>
 <CAEf4BzYLyi6=Fyz9ziOAwkFOjUPyJmTj4c6g247XBwgwJ8m-qw@mail.gmail.com>
 <CAErzpmtMPuGBhisLOaZMyzM5u3=0QrmZcuWqNgbMrceEEPN3TA@mail.gmail.com>
 <CAErzpmsCJAWVjWnV2LWAnYCouynYZbUupS08LUuhixiT2do3sg@mail.gmail.com> <7d9e373c7f0f3b7a50ee6a719375410da452b7ba.camel@gmail.com>
In-Reply-To: <7d9e373c7f0f3b7a50ee6a719375410da452b7ba.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 24 Oct 2025 11:04:41 +0800
X-Gm-Features: AS18NWB4eCzmr0fFGv5HUOJe8WdIjkJQVvEoqeUUnF94s8F8X5qD_mJIkzaQnMo
Message-ID: <CAErzpmtJmj-ZX+uL_N9e5-r1iL+kD=0vwM9BeDL3t4C2re261A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:32=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2025-10-24 at 10:23 +0800, Donglin Peng wrote:
> > On Fri, Oct 24, 2025 at 9:59=E2=80=AFAM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > On Fri, Oct 24, 2025 at 3:40=E2=80=AFAM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Thu, Oct 23, 2025 at 11:37=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Thu, Oct 23, 2025 at 9:28=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > >
> > > > > > Speaking of flags, though. I think adding BTF_F_SORTED flag to
> > > > > > btf_header->flags seems useful, as that would allow libbpf (and=
 user
> > > > > > space apps working with BTF in general) to use more optimal
> > > > > > find_by_name implementation. The only gotcha is that old kernel=
s
> > > > > > enforce this btf_header->flags to be zero, so pahole would need=
 to
> > > > > > know not to emit this when building BTF for old kernels (or, ra=
ther,
> > > > > > we'll just teach pahole_flags in kernel build scripts to add th=
is
> > > > > > going forward). This is not very important for kernel, because =
kernel
> > > > > > has to validate all this anyways, but would allow saving time f=
or user
> > > > > > space.
> > > > >
> > > > > Thinking more about it... I don't think it's worth it.
> > > > > It's an operational headache. I'd rather have newer pahole sort i=
t
> > > > > without on/off flags and detection, so that people can upgrade
> > > > > pahole and build older kernels.
> > > > > Also BTF_F_SORTED doesn't spell out the way it's sorted.
> > > > > Things may change and we will need a new flag and so on.
> > > > > I think it's easier to check in the kernel and libbpf whether
> > > > > BTF is sorted the way they want it.
> > > > > The check is simple, fast and done once. Then both (kernel and li=
bbpf) can
> > > > > set an internal flag and use different functions to search
> > > > > within a given BTF.
> > > >
> > > > I guess that's fine. libbpf can do this check lazily on the first
> > > > btf__find_by_name() to avoid unnecessary overhead. Agreed.
> > >
> > > Thank you for all the feedback. Based on the suggestions above, the s=
orting
> > > implementation will be redesigned in the next version as follows:
> > >
> > > 1. The sorting operation will be fully handled by pahole, with no dep=
endency on
> > > libbpf. This means users can benefit from sorting simply by upgrading=
 their
> > > pahole version.
> >
> > I suggest that libbpf provides a sorting function, such as the
> > btf__permute suggested
> > by Andrii, for pahole to call. This approach allows pahole to leverage
> > libbpf's existing
> > helper functions and avoids code duplication.
>
> Could you please enumerate the functions you'd have to reimplement in
> pahole?

Yes. Once the BTF types are sorted, the type IDs in both the BTF and BTF ex=
t
sections must be remapped. Libbpf provides helper functions like
btf_field_iter_init,
btf_field_iter_next,
btf_ext_visit_type_ids
to iterate through the btf_field and btf_ext_info_sec entries that
require updating.
We will likely need to reimplement these three functions for this purpose.

>
> > >
> > > 2. The kernel and libbpf will only be responsible for:
> > >     2.1. Checking whether the BTF data is sorted
> > >     2.2. Implementing binary search for sorted BTF
> > >
> > > Regarding the sorting check overhead: if the runtime cost is sufficie=
ntly small,
> > > it can be performed during BTF parsing. Based on my local testing wit=
h vmlinux
> > >  BTF (containing 143,484 btf_types), this check takes at most 1.5 mil=
liseconds
> > > during boot. Is this 1.5ms overhead acceptable?
> > >
> > > Are there any other suggestions?

