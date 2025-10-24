Return-Path: <linux-kernel+bounces-868049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266B2C043AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BFB18C1B79
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64D626B95B;
	Fri, 24 Oct 2025 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqXfVxtg"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414617BA6
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275727; cv=none; b=jxpktMYpJaPEURK6CjxM08JnCqRhqmqu4KUJy/XojhkTL5Ri8ltRb5CDxVuFkcPsx+/5EVq8N8P7zYvufgZ7q7c/c6AaO1XwiEwjC2mbRN2oW2pue00smYElYh8topZFWaFSBjRpQ+sTEvhEM03QfHYFdJH1G34MWUqF7b/H6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275727; c=relaxed/simple;
	bh=U/fQ9GO8LFn4u0AVU/CFCxO1RaC5xIwwnoSuDNwYWec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d2wIFQGEAmaWDY22c1aCQp7ERBc1DONEwa52Mebn3QtpSlt8MOn7iA4P2yaYTvlGP67uu6wyPchfVdA0x95lRcT60FtTvg/4YFeXm3DVrQ1yhamDSLDEYM1UWTcofNbMLsxBYVPaenGmq2IwsOzHXxB9felxZkDTaEZdpqtfnbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqXfVxtg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781010ff051so1066678b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761275725; x=1761880525; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U/fQ9GO8LFn4u0AVU/CFCxO1RaC5xIwwnoSuDNwYWec=;
        b=QqXfVxtgtZpRKzSYgcY0ejOO2UczABY2CgNGWLyIZdheKNKTdseiWwpOPgpOx/KIQI
         s4erM9jnl/NDq2TEzqhHKICxKCPhlMKoJs41GEvsxJX1qqGjAqGCldpryiCBDJLLf76F
         j8Xy/kKX02XSDSe87qs7DzRB1KpJP4MRQ9hRuibWcJbWgpVySf6a/FEArthSp3Zo7pqM
         7QIOe8ky3u7pE535XRps9GMLhTH5e5Heu8g2XSiYpzmT6qy/CAt9qtND/lzxZ/A05rMb
         cQxHPrQRpJ/8rt8XPSIqUMrV1XUVswtnCi98mhqXIouiPc4IYzoYeXVCDdpn+wCRfNqL
         psMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761275725; x=1761880525;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/fQ9GO8LFn4u0AVU/CFCxO1RaC5xIwwnoSuDNwYWec=;
        b=BvdDv4aMlfYP13Lmxrp8fi3iADvTfq+pzeFkMvC+cE8AU5Ls6VbePy2DqriVSa8NE5
         oBPOWm53A7LB7M9KlGw5DqOcUY4V11ozePAH0nzn8FupuxsSwB/AKh2d8ENDpN2E8PUE
         KFF0Eu8iNJl0JZoPCEA0+7da/iLJRVvaGu4DMHbRlaSkbQoBCIUjI1HV9KLpwf/K8Q5Q
         CwTIoIcsauxfPWV+vXXKeQA/omyFqHIodPTJIqc6JWZQEWvvIQ77lrWf4SgaCsJJMQJo
         q7l2Pe08mwAf3HuvlP0Aalq/dkjUaSAqaT83PMxzs1iGVqmuJz1OvYHMiyaTAi9qEtBE
         L4yg==
X-Forwarded-Encrypted: i=1; AJvYcCWqmgnwTDi7mKQNb4z1/9vAyr0aSk9+l7L/uS3c39NjWB+h7RaODmSusuj783cgtD2CTKYsLPA2kQ/3L+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdydS+jY2iiQU1zWQxzN0XSlD6Sxto6e4MFKBrdA2oH0A3zsV
	lDsQ6qA7cjzeIQp9ufziGJ3QEOMcV7drdcOY5ii7X6JqyQEZFXJ88FVz
X-Gm-Gg: ASbGncvxEshF1+PLGmQavjd9U+PNbZrJMObY85lUaYVdyDfWsEkZ7loUPJ/0pDfqqdo
	ULizRC0M4zT7k4xDgItiDtA7ncap3EANG3RvhlEOgf6w8WBoItUFD20LILxcUNZjQh2eWM2ZZEF
	cv13ijaPGeSbVYvvq50eWCInV1gF+sTbH8T9c5t21eE8KkV3kHepalyW2En+tewfPCoNoVZ/Rd2
	AcyEl+qHEGsTKjjg8fin5NCHVEl3BI1rb6aT63Wtpa9GgzXedcfeib5p7NideS0XjGuG8WrhGhA
	LlOQRJD83WtN4/wlLSs+CKkTgo1s+dECqE6obrKT7HQQBaJGehsxlLiDOgsL42a57C4FA0kpgjL
	Z+GcLmU5tIRzFScky2Ytksy6bi2K3E1NSuSKd7LdDu0zUPowgKrz8i7TKVJoovTEbXF0CQ2bt
X-Google-Smtp-Source: AGHT+IEIuHq7UcqS02TmVxJm8DIWd3Dpbf7GvUXrzylNp+X7NjpEw3KO3Ux4mjYeXFbE8THlmxGb9w==
X-Received: by 2002:a05:6a20:a104:b0:334:a180:b7a7 with SMTP id adf61e73a8af0-33c61fc0376mr6747573637.42.1761275724902;
        Thu, 23 Oct 2025 20:15:24 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c4d83dsm3598428a12.18.2025.10.23.20.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:15:24 -0700 (PDT)
Message-ID: <f5cb8c37dc7a23beb0d83fe2aa0a4dc29bc40fd5.camel@gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to
 enable binary search
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov	
 <alexei.starovoitov@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
 Alexei Starovoitov	 <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>,  Song Liu <song@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Date: Thu, 23 Oct 2025 20:15:21 -0700
In-Reply-To: <CAErzpmtJmj-ZX+uL_N9e5-r1iL+kD=0vwM9BeDL3t4C2re261A@mail.gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-3-dolinux.peng@gmail.com>
	 <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
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
	 <CAErzpmtJmj-ZX+uL_N9e5-r1iL+kD=0vwM9BeDL3t4C2re261A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-24 at 11:04 +0800, Donglin Peng wrote:
> On Fri, Oct 24, 2025 at 10:32=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > On Fri, 2025-10-24 at 10:23 +0800, Donglin Peng wrote:
> > > On Fri, Oct 24, 2025 at 9:59=E2=80=AFAM Donglin Peng <dolinux.peng@gm=
ail.com> wrote:
> > > >=20
> > > > On Fri, Oct 24, 2025 at 3:40=E2=80=AFAM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >=20
> > > > > On Thu, Oct 23, 2025 at 11:37=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >=20
> > > > > > On Thu, Oct 23, 2025 at 9:28=E2=80=AFAM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > Speaking of flags, though. I think adding BTF_F_SORTED flag t=
o
> > > > > > > btf_header->flags seems useful, as that would allow libbpf (a=
nd user
> > > > > > > space apps working with BTF in general) to use more optimal
> > > > > > > find_by_name implementation. The only gotcha is that old kern=
els
> > > > > > > enforce this btf_header->flags to be zero, so pahole would ne=
ed to
> > > > > > > know not to emit this when building BTF for old kernels (or, =
rather,
> > > > > > > we'll just teach pahole_flags in kernel build scripts to add =
this
> > > > > > > going forward). This is not very important for kernel, becaus=
e kernel
> > > > > > > has to validate all this anyways, but would allow saving time=
 for user
> > > > > > > space.
> > > > > >=20
> > > > > > Thinking more about it... I don't think it's worth it.
> > > > > > It's an operational headache. I'd rather have newer pahole sort=
 it
> > > > > > without on/off flags and detection, so that people can upgrade
> > > > > > pahole and build older kernels.
> > > > > > Also BTF_F_SORTED doesn't spell out the way it's sorted.
> > > > > > Things may change and we will need a new flag and so on.
> > > > > > I think it's easier to check in the kernel and libbpf whether
> > > > > > BTF is sorted the way they want it.
> > > > > > The check is simple, fast and done once. Then both (kernel and =
libbpf) can
> > > > > > set an internal flag and use different functions to search
> > > > > > within a given BTF.
> > > > >=20
> > > > > I guess that's fine. libbpf can do this check lazily on the first
> > > > > btf__find_by_name() to avoid unnecessary overhead. Agreed.
> > > >=20
> > > > Thank you for all the feedback. Based on the suggestions above, the=
 sorting
> > > > implementation will be redesigned in the next version as follows:
> > > >=20
> > > > 1. The sorting operation will be fully handled by pahole, with no d=
ependency on
> > > > libbpf. This means users can benefit from sorting simply by upgradi=
ng their
> > > > pahole version.
> > >=20
> > > I suggest that libbpf provides a sorting function, such as the
> > > btf__permute suggested
> > > by Andrii, for pahole to call. This approach allows pahole to leverag=
e
> > > libbpf's existing
> > > helper functions and avoids code duplication.
> >=20
> > Could you please enumerate the functions you'd have to reimplement in
> > pahole?
>=20
> Yes. Once the BTF types are sorted, the type IDs in both the BTF and BTF =
ext
> sections must be remapped. Libbpf provides helper functions like
> btf_field_iter_init,
> btf_field_iter_next,
> btf_ext_visit_type_ids
> to iterate through the btf_field and btf_ext_info_sec entries that
> require updating.
> We will likely need to reimplement these three functions for this purpose=
.

I think Andrii's suggestion is to have btf__permute in libbpf,
as it needs all the functions you mention.
But actual sorting can happen in pahole, then:
- allocate array of length num-types, initialize it 0..num-types;
- reorder it as one sees fit;
- call btf__permute() from libbpf and get all the renamings handled by it.

[...]

