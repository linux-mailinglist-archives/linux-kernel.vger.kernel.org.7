Return-Path: <linux-kernel+bounces-867379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A0FC02728
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA12D4EAA24
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD712E2DDE;
	Thu, 23 Oct 2025 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l09m59LP"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B511B2D7DC5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761236928; cv=none; b=bAOl6QntF/zjZr1U50xTDeXxOs7DNp+hwAbqFso1RUTLo10oaWqX/EIHfgOpiS3bNIU3mNgrCN9NakldIDrPdbtRPmv9lMN/laF+odEACvJNDt1xBr1IFxBrQPzHGtFJAOdnxcArMn92os1njM3XWkdg1cuck3PQoWHVFMEZeVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761236928; c=relaxed/simple;
	bh=63NV+cUupyziu+omg8nqL0ixV1A3QIcHdqVlAw7Dagc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fExAcBHFK5iqWe9lJiapJQ/IFmlZJwomuMa6mkC6ZQju0puhkDAWCc2J/zxKynEyh1wRYPj8iJH6F8GKmWyFLcUZUpfrff22q9SZZ9UAjyU0Q9mRSJ4Djeoo/bYj0bKN4EdTO/OUWLJraX/0OYv2bPEjseAJdQ9NIATrHsrCWcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l09m59LP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3307de086d8so1119044a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761236926; x=1761841726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Em8aVnsPg6h7N7/uWYB8oyJdXyJBUaoBp3birjoLGA=;
        b=l09m59LPlMAblhcaxNMxYTk9aT/FbdRZ92+CkvrD6cCW4Dzp+WM7MjaJqVyojuZou4
         337/nFoNqWYbYPMISXs5LkwpzkXwD8CO45rLWL3pGhrcTfikbYPFBVV6FtneDEZ3oWBC
         T372xt6gM62Q6g44amFRyfZSBQF38jfOZz0QWqGpnqWdEuGZbQFJLgkCDmoxuvMylqnA
         qafr7oM6T1TLQqbnHZk+EYVNUfdO29AsSEX3qsD6TgACUfHDxxydXCCMrJNx8Q6fkjkk
         kjDhYJ/TBMxjNlLAsaNQHoR1acg+dyInebpj2e8TpBo69I+mMwqw0dDFFWQ8ET5RULdp
         ZPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761236926; x=1761841726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Em8aVnsPg6h7N7/uWYB8oyJdXyJBUaoBp3birjoLGA=;
        b=ovlUQXZ24Tp/BJ9r1EdDFGmdv/9O9Xbx08Flyb6Q+wCvAyBQR7Y22GkPfB+tGjE/K6
         XxmpWma0XAS0vaB5bT2OOVxpj0Kxy1cvqENAcJersx0rQr2uQTRtSLGivUu1IMVDf9j2
         qtQFZtZAAFpSiHZi69SOZ52GdJeViWlSD9Jlk4QfOFNrIc9lXnCGBUdcPI5mRXhfAF5n
         sBA4t95I6cCMbFhrW0Cn3CmXECvLy2Cg9u5pyOVaYaOFJDPQtZRLqvjAX4wOzxSDw7oK
         PS7KVUw6rkmpPv7+TR2Z0cfmMO4xcys83ujHkN3fq4LBvINbn4OeEf115+/dbXPiPpwD
         SAKg==
X-Forwarded-Encrypted: i=1; AJvYcCWhyrL+UWPbq+qB8dtD/t6m1LjDE07vFkJh3NYLPKJr+wDzCoqefFi3pfFnVyzXK5239im0uumv6QiL4QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZB0060e2YhqTqyrRoCIF7swr0sWoc4UqBONjRDTDeFoLOXM5D
	0JSctBkbfAdUxxwCWue+IeTPTEB4dD+rrxD3AZWpTFXEMa69x9Ee0ZLnTDfofS9syYdrzdhGKpf
	nwHZqG4Ruuyc4GoOXu3X5MESKjAERxck=
X-Gm-Gg: ASbGncvqxVTpQskA7Wji/zlcCb2XidNeTto6OqSTNC7/Vj/WgVrK63dRaRxeLDC6RQS
	HbAuiprI38SMV7jcTYMKc+3ePwiKpY5h2Lgtb0h9cNW0itOF1sAMd3sV+N3NGOkLsCd7Y/5ZG0h
	ilIA49mGrh08ORE63BgpeSoBkuUcwD6o4NPCUZw9Ovl87Q5DPuoetJPamlsFtI50FDn4JR18FSK
	/3bwQKBVkJ1p2Wk9ynvAzcHgfT4t2JppOfs0HjiqVHooQT0l4sql3qmmYh+TBZuRBVaFxvaDqDe
X-Google-Smtp-Source: AGHT+IFlAVTw+Jxi+v6C1/6Bf81dYfI+9RDj02EdZzIhjQpUiAelOtgUEgVhekEHrknrIsV5fyIhFUoBeT1x6+CMKoU=
X-Received: by 2002:a17:90b:3ec1:b0:33b:a5d8:f198 with SMTP id
 98e67ed59e1d1-33bcf90b791mr29528595a91.25.1761236926084; Thu, 23 Oct 2025
 09:28:46 -0700 (PDT)
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
 <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com> <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com>
In-Reply-To: <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Oct 2025 09:28:30 -0700
X-Gm-Features: AS18NWAlx_LP4MbVy4TD6faRRP3spZFTyP2d7dWDF5qL_JOwSX3QL17uG_zT1tA
Message-ID: <CAEf4Bzajdv3Rd1xAxm_UZWBxPc8M0=VuUkfjJvOFSObOs19GbQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 8:53=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 23, 2025 at 3:35=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Thu, Oct 23, 2025 at 4:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Wed, 2025-10-22 at 11:02 +0800, Donglin Peng wrote:
> > > > On Wed, Oct 22, 2025 at 2:59=E2=80=AFAM Eduard Zingerman <eddyz87@g=
mail.com> wrote:
> > > > >
> > > > > On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > > > > > This patch implements sorting of BTF types by their kind and na=
me,
> > > > > > enabling the use of binary search for type lookups.
> > > > > >
> > > > > > To share logic between kernel and libbpf, a new btf_sort.c file=
 is
> > > > > > introduced containing common sorting functionality.
> > > > > >
> > > > > > The sorting is performed during btf__dedup() when the new
> > > > > > sort_by_kind_name option in btf_dedup_opts is enabled.
> > > > >
> > > > > Do we really need this option?  Dedup is free to rearrange btf ty=
pes
> > > > > anyway, so why not sort always?  Is execution time a concern?
> > > >
> > > > The issue is that sorting changes the layout of BTF. Many existing =
selftests
> > > > rely on the current, non-sorted order for their validation checks. =
Introducing
> > > > this as an optional feature first allows us to run it without immed=
iately
> > > > breaking the tests, giving us time to fix them incrementally.
> > >
> > > How many tests are we talking about?
> > > The option is an API and it stays with us forever.
> > > If the only justification for its existence is to avoid tests
> > > modification, I don't think that's enough.
> >
> > I get your point, thanks. I wonder what others think?
>
> +1 to Eduard's point.
> No new flags please. Always sort.
>
> Also I don't feel that sorting logic belongs in libbpf.
> pahole needs to dedup first, apply extra filters, add extra BTFs.
> At that point going back to libbpf and asking to sort seems odd.

Correct, I'd also not bake sorting into libbpf. Sorting order should
be determined by pahole (or whatever other producer of BTF) after all
the information is collected. So btf_dedup shouldn't sort.

But I think we should add a new API to libbpf to help with sorting.
I'd add this:

int btf__permute(struct btf *btf, int permutation, int permutation_sz);

With the idea that libbpf will renumber and reshuffle BTF data
according to permutation provided by the caller. Caller should make
sure that permutation is a valid one, of course.

 (we can also extend this to allow specifying that some types should
be dropped by mapping them to zero, I think I wanted something like
that for BTF linker at some point, don't remember details anymore; but
that's definitely not in v1)

This is useful for sorting use case (pahole build an index from old
btf type ID to new btf type ID -> libbpf shuffles bytes and renumbers
everything), but can be applied more generally (I don't remember now,
but I did have this idea earlier in response to some need for BTF
reshuffling).

Speaking of flags, though. I think adding BTF_F_SORTED flag to
btf_header->flags seems useful, as that would allow libbpf (and user
space apps working with BTF in general) to use more optimal
find_by_name implementation. The only gotcha is that old kernels
enforce this btf_header->flags to be zero, so pahole would need to
know not to emit this when building BTF for old kernels (or, rather,
we'll just teach pahole_flags in kernel build scripts to add this
going forward). This is not very important for kernel, because kernel
has to validate all this anyways, but would allow saving time for user
space.

