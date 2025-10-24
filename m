Return-Path: <linux-kernel+bounces-868052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4F5C043C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4E43B88EA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F9A26B95B;
	Fri, 24 Oct 2025 03:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVTpZ9/P"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65983271457
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276014; cv=none; b=MRyL+pmJk1WMKvFeVJ5tTIobXLyh/gp9YKdvmIPnjVNnCPXyN7Y6rQToWp9llANo+ZL8yjpZNE/2OnASsv3wG/r5SesskHMlNnyyiknyAfnvDvXROWfsUV9ovAItMT5oyJHrUDLFIe5byXOPeuh6jUsB76+vemf7gYmgGB854Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276014; c=relaxed/simple;
	bh=vosHIbmXHUkjKFcSFtE8VAnh1l4a3kdW+/Z8WGM83mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bb3WOcmIAzYFA3mmCE7yroMDn+wijh3Nel5Ucv7f+0CPS5tLRIMRWQ8wce6FN5X/2nHbr1l6kwX5gegOj4/LRTUyzOqF+ynQsFZwC+2z5O7IY7c5HFIgEJgRECsX0cpjD/3fAgurB5nYEu+7UYWB/RA385O/ITd5AC3niDKcS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVTpZ9/P; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e89e689ec7so9833871cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761276010; x=1761880810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vosHIbmXHUkjKFcSFtE8VAnh1l4a3kdW+/Z8WGM83mc=;
        b=aVTpZ9/PJgMruRXJhXX6rESwt2hxLL1A+hZ62WIs6zV+y/YyEIYceTg9dGUconiVZE
         N0Z3ZSmnXOXoL3z4EsSMfSUsUIOeKRZhk58cFnN0g/YZ/SS8qlXWAJlh+oTtoXZetd4h
         ieSkjVuEan12faQQaOi7+Cza29YBA4K4KIkJA7w9fMR4/ZkWpREyPpk6Ih/OifGUqnXk
         63BOKhoWi8zvsTkKwc47asuOmpmeH7Q1Qiv40eaoL+bz+20Sepjse8HYt/FS8qGnjuYG
         ty2yJB8c9kc0tpIOt7IFbRfUOzmpn/yDgqQFNJYP5HfZgfnCSWUlWn0oHnWSlYNr13yj
         CDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761276010; x=1761880810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vosHIbmXHUkjKFcSFtE8VAnh1l4a3kdW+/Z8WGM83mc=;
        b=tLYNkiy/aR9lNmFUYeDhOU5AJxQpLE/eBqKa9D7Rg3YKFK0t2RHhNKLZsMztN2OJL7
         11FOxGgtCGDK7hbsAdOhzLPBzxtsxuUwcHAtRjaKY2yNFlQ/cc3g0/iFPhVeEIe2vOla
         SNHfROaK5TUsOeBY1MQjGB+oM7iazq06V6EHsUZZhF7Dfc2J0HABjUbb7TN0IO80u0Xy
         dHoylkCQMslM4LQqIF6rBcnyurJxdIruEcGeMmwDf/tBNMz38siEJn1wc819yyhRMVE6
         TdOnACJTuXfjzRPXZCENlVxn0mpIocs1ncnZNLPAU6meg6Mw4N3jRv3aM8n7EKXqE/3A
         Yt8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkIdxxKqPB3bngdlahvTc/AfOCdiwm+TLaQORea1S67U8ornsMqTm8TLvXT2Zi3R9ofnc8yUzboIDzVPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/PAtGpr4USKXvbuPyvKu4k1vJth1fFUQVlOjwhu7hN+jr2Ix
	09PzvM9x3j47dznQIOZn3saNbQ6YYzI5skjZMbPbZTTeN5VxNruzZoFivEstxLZfaqTZ8bGLrzk
	sLqogJhnbs18mjbXBdqWnpy9f/y3tJ70=
X-Gm-Gg: ASbGncvRE09HhL1Rs66FDmEP3WPxsKTiOS1zTjJgVAmxgLXFfFrpuP1K3Sc625KcQ99
	RO6x0Q2SInfSQCDphGLMRJOTMVQrEJUkJz17QRM3CsQh9s/uZOv1dMPpeEdihOGcMFIfDayhJfv
	NGP+zVptSc5uJOY3rTCrcXnWOIsrGYHA1BfYG7w0iKvXjI3k5VwEXBpsmk4U77pmprjiA9CvXt2
	pzTOtNITwefaIqOETy1QbvVy6iZYdE5ePU1xlPJDhZe0RQnM1ACpMmPIx5MNg==
X-Google-Smtp-Source: AGHT+IFuKLNzDHgyVnAc5upxNk6bZXC3pluBaw0VdoK1RNjYz8XToqqei8JPDhUGUEGNlSvEelgzXNgrEFpmvuP5MQs=
X-Received: by 2002:ac8:578b:0:b0:4e5:6c5e:430a with SMTP id
 d75a77b69052e-4e89d3a47c8mr340792321cf.64.1761276009998; Thu, 23 Oct 2025
 20:20:09 -0700 (PDT)
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
 <CAErzpmsCJAWVjWnV2LWAnYCouynYZbUupS08LUuhixiT2do3sg@mail.gmail.com>
 <7d9e373c7f0f3b7a50ee6a719375410da452b7ba.camel@gmail.com>
 <CAErzpmtJmj-ZX+uL_N9e5-r1iL+kD=0vwM9BeDL3t4C2re261A@mail.gmail.com> <f5cb8c37dc7a23beb0d83fe2aa0a4dc29bc40fd5.camel@gmail.com>
In-Reply-To: <f5cb8c37dc7a23beb0d83fe2aa0a4dc29bc40fd5.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 24 Oct 2025 11:19:55 +0800
X-Gm-Features: AS18NWDBZBREJwKmL2ehSlR-iVb6MBKxIurAqAr9cAYdqWHWbtf1c3KKSrtcx8g
Message-ID: <CAErzpmuY0miq0B5BSF8ueY+NOTGfvcUKPbO4_W3BKX74c5K4rg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:15=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2025-10-24 at 11:04 +0800, Donglin Peng wrote:
> > On Fri, Oct 24, 2025 at 10:32=E2=80=AFAM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Fri, 2025-10-24 at 10:23 +0800, Donglin Peng wrote:
> > > > On Fri, Oct 24, 2025 at 9:59=E2=80=AFAM Donglin Peng <dolinux.peng@=
gmail.com> wrote:
> > > > >
> > > > > On Fri, Oct 24, 2025 at 3:40=E2=80=AFAM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 23, 2025 at 11:37=E2=80=AFAM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 23, 2025 at 9:28=E2=80=AFAM Andrii Nakryiko
> > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > Speaking of flags, though. I think adding BTF_F_SORTED flag=
 to
> > > > > > > > btf_header->flags seems useful, as that would allow libbpf =
(and user
> > > > > > > > space apps working with BTF in general) to use more optimal
> > > > > > > > find_by_name implementation. The only gotcha is that old ke=
rnels
> > > > > > > > enforce this btf_header->flags to be zero, so pahole would =
need to
> > > > > > > > know not to emit this when building BTF for old kernels (or=
, rather,
> > > > > > > > we'll just teach pahole_flags in kernel build scripts to ad=
d this
> > > > > > > > going forward). This is not very important for kernel, beca=
use kernel
> > > > > > > > has to validate all this anyways, but would allow saving ti=
me for user
> > > > > > > > space.
> > > > > > >
> > > > > > > Thinking more about it... I don't think it's worth it.
> > > > > > > It's an operational headache. I'd rather have newer pahole so=
rt it
> > > > > > > without on/off flags and detection, so that people can upgrad=
e
> > > > > > > pahole and build older kernels.
> > > > > > > Also BTF_F_SORTED doesn't spell out the way it's sorted.
> > > > > > > Things may change and we will need a new flag and so on.
> > > > > > > I think it's easier to check in the kernel and libbpf whether
> > > > > > > BTF is sorted the way they want it.
> > > > > > > The check is simple, fast and done once. Then both (kernel an=
d libbpf) can
> > > > > > > set an internal flag and use different functions to search
> > > > > > > within a given BTF.
> > > > > >
> > > > > > I guess that's fine. libbpf can do this check lazily on the fir=
st
> > > > > > btf__find_by_name() to avoid unnecessary overhead. Agreed.
> > > > >
> > > > > Thank you for all the feedback. Based on the suggestions above, t=
he sorting
> > > > > implementation will be redesigned in the next version as follows:
> > > > >
> > > > > 1. The sorting operation will be fully handled by pahole, with no=
 dependency on
> > > > > libbpf. This means users can benefit from sorting simply by upgra=
ding their
> > > > > pahole version.
> > > >
> > > > I suggest that libbpf provides a sorting function, such as the
> > > > btf__permute suggested
> > > > by Andrii, for pahole to call. This approach allows pahole to lever=
age
> > > > libbpf's existing
> > > > helper functions and avoids code duplication.
> > >
> > > Could you please enumerate the functions you'd have to reimplement in
> > > pahole?
> >
> > Yes. Once the BTF types are sorted, the type IDs in both the BTF and BT=
F ext
> > sections must be remapped. Libbpf provides helper functions like
> > btf_field_iter_init,
> > btf_field_iter_next,
> > btf_ext_visit_type_ids
> > to iterate through the btf_field and btf_ext_info_sec entries that
> > require updating.
> > We will likely need to reimplement these three functions for this purpo=
se.
>
> I think Andrii's suggestion is to have btf__permute in libbpf,
> as it needs all the functions you mention.
> But actual sorting can happen in pahole, then:
> - allocate array of length num-types, initialize it 0..num-types;
> - reorder it as one sees fit;
> - call btf__permute() from libbpf and get all the renamings handled by it=
.

Yes, the first two can be implemented in pahole, while the last one belongs
in libbpf.

>
> [...]

