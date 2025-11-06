Return-Path: <linux-kernel+bounces-889145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C0FC3CD5F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772983B9BAA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160A134E755;
	Thu,  6 Nov 2025 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Daa+0gan"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5CF2C0F96
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449700; cv=none; b=r2LmOpxmc4kJtdhhFhtV8Oiqp9UPQuvyeWk7o+0r2IEedVIm25ykxyCkDGpNho/HEMT5tkB+Wvo77dyDZoygXo2CLx+tZTrZMsCNCV7euLum9+W2A6PmhMieVnmmVXUiSNSDbZ2vHl9mMVUqc8/agpp93zgXWMxzTJ83dekoQcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449700; c=relaxed/simple;
	bh=PzxwidcpRKmiX3DX4tAzG0i0NtxO2/JUfbtpuy3uDBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGQKH0epdxAWLYVmI0Pn3J9sbQFtZkqvsdD+bkiVC3tVcw1qa2gL7LtHNBOzKM3drYiAKws9iyTtFtD3el/wJbehnzhwpjoYZASrQARoS0gI3HSSt6AWGUHz+uP2b9eRA1uzh60Pe1Hl/cW3GZbzBEcowRVPCHdbnRz6kzkpodM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Daa+0gan; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b98983bae8eso696888a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762449698; x=1763054498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53zv8pNCyy6msJMhTj0075bL9NHQagwwZyjRgZbLDrI=;
        b=Daa+0ganUcDr+ERcJZ01AS3zO7e8cjfZ88+zDzS24LMsskh7ZUdxZKozZ2I8rYjv3s
         wDMprDZikki/dcfp/MMoNIRc2bV9El20oZEMlOt5oESqCxw88fcZkjwy767lIYTr5f6x
         XyB9GSFXD8BveZlJZNuGiyz1phYmFuub4jAP6XXVQcci8ivPdXpMFa6CEEsaKeYgLGWw
         gIkzu2EjDseUmcSPiI4vi6p2L0mv6rBfz3fZJ3Lk4pmkSzpkqnuY3Mp0iy0W7HWiOpyE
         RoWmtGicKKWxdwHStFIJRYgv0yIWJ3ToGD6YfvyRjypMiAskF32A0uga2nLKy3xMu3dK
         oI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449698; x=1763054498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53zv8pNCyy6msJMhTj0075bL9NHQagwwZyjRgZbLDrI=;
        b=Yfg69iG7EP5B9JkQpZnS43LFFeID1kpy9/w9aLXi8RrVRnwjCZ/6VBxSSvAzH4buJZ
         fcrmcxgjmBgFIbDNKgGkue5Mc5p0os2Fj/4dHUQtusxWLpU1YxiTTEax5v/reN5o7ipr
         cx++as+l8Wj+GltH0v7tZ89bOcYXyNx0+TEWdKKDcDi2k+TC7Kz/m8aINOCWzONovIcf
         MRBsoxaR/ashoUZ+3MVmJUfDP6I3nz5Liwqx0bpUzQijwtsIkL+WZ2Te4YsWEEirFZ8b
         GSVDCgUIQYH9iCOXUF52+yuld189fdYliBtk7K5G3Gghnkw9OlECfh9pLZJv/20GMPzT
         g30g==
X-Forwarded-Encrypted: i=1; AJvYcCXNwbxz+BxVDoAtl/jxSpCfb5d0sssu/qgkGXS1dk50bwt3nadpqigbWD5wE4dMSAQ3b4tNw+NAnU3x2kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlOVAE1CouU5QOZqvZKgaZgtK6oPL1jWRTbgPwrREzEEwJFsDR
	6T277ItYNrGZUFebiER6B+gIKZF/KhC2EUX4HuhHLlA6NCF37VpFw7RtLsaN51SKIzUPS8by/6L
	S5nUPOeRZBJ5Axy8FOAGpp06jHrHur2g8NQ==
X-Gm-Gg: ASbGnctXX85evgzxejNJcOBvsOn38OS05Wxy8IfVT/vu36uXoZ2i28XWJMKqhHsRsO5
	K+y6jsni8NC9dZgaThyt8p2NwPj5Ote5ib1yf/k304VPJs+PHAOeWnfWqaxTfNNvFjy75sCMDan
	DhCIsB1wxR3S0XjsnL2G4aZ+qmihztKo1sbqFwTok0UDyMZmKwD8CCoIOgc9lpKuLo58/W+uyVB
	4JNwDyy2We+wMZ05t8pF2iEHwnuXpraTL6G5PYXdsgffk75iyy08KOzeDyY89i1rWNSfSt2np/i
X-Google-Smtp-Source: AGHT+IFFz28VA0fsRY/ApY2QzQHrwpupc3C+hhpavRdBz9KwVlIpzQweUT1XG0sLDRG9EhvbsQ3PISPJNt2yefr7Lec=
X-Received: by 2002:a17:902:ec8e:b0:290:b53b:7456 with SMTP id
 d9443c01a7336-297c038c8b8mr3218125ad.5.1762449697881; Thu, 06 Nov 2025
 09:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-3-dolinux.peng@gmail.com> <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
 <3986a6b863be2ec62820ea5d2cf471f7e233fac0.camel@gmail.com>
 <CAEf4BzaLmVuPRL4V1VKBmaXtrvT=oLwo=M7sLURgoYU34BkpMQ@mail.gmail.com>
 <627795f165b1e66500b9f032ed7474125938f33a.camel@gmail.com>
 <CAEf4BzbVU2sBw4aSOB1+SdKN0Qe-WEtDKo3wn21C6UjfSKiBdQ@mail.gmail.com> <2ba0561a653254254a0fa1709bffb3704488f33b.camel@gmail.com>
In-Reply-To: <2ba0561a653254254a0fa1709bffb3704488f33b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 6 Nov 2025 09:21:25 -0800
X-Gm-Features: AWmQ_bm0VOb1juuKhHSRndMF_hcmO1NhtZkArTt1h3GruxxQ843JSjs_Em1--2M
Message-ID: <CAEf4Bzb-mYfsBNi4NKSSiu6QQU3+5cs=uCn-8suOcFOuc-tG2w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:23=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-11-05 at 10:23 -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 4, 2025 at 5:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Tue, 2025-11-04 at 17:04 -0800, Andrii Nakryiko wrote:
> > > > On Tue, Nov 4, 2025 at 4:16=E2=80=AFPM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > > >
> > > > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > +static int btf_permute_remap_type_id(__u32 *type_id, void *c=
tx)
> > > > > > > +{
> > > > > > > +       struct btf_permute *p =3D ctx;
> > > > > > > +       __u32 new_type_id =3D *type_id;
> > > > > > > +
> > > > > > > +       /* skip references that point into the base BTF */
> > > > > > > +       if (new_type_id < p->btf->start_id)
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       new_type_id =3D p->map[*type_id - p->btf->start_id];
> > > > > >
> > > > > > I'm actually confused, I thought p->ids would be the mapping fr=
om
> > > > > > original type ID (minus start_id, of course) to a new desired I=
D, but
> > > > > > it looks to be the other way? ids is a desired resulting *seque=
nce* of
> > > > > > types identified by their original ID. I find it quite confusin=
g. I
> > > > > > think about permutation as a mapping from original type ID to a=
 new
> > > > > > type ID, am I confused?
> > > > >
> > > > > Yes, it is a desired sequence, not mapping.
> > > > > I guess its a bit simpler to use for sorting use-case, as you can=
 just
> > > > > swap ids while sorting.
> > > >
> > > > The question is really what makes most sense as an interface. Becau=
se
> > > > for sorting cases it's just the matter of a two-line for() loop to
> > > > create ID mapping once types are sorted.
> > > >
> > > > I have slight preference for id_map approach because it is easy to
> > > > extend to the case of selectively dropping some types. We can just
> > > > define that such IDs should be mapped to zero. This will work as a
> > > > natural extension. With the desired end sequence of IDs, it's less
> > > > natural and will require more work to determine which IDs are missi=
ng
> > > > from the sequence.
> > > >
> > > > So unless there is some really good and strong reason, shall we go
> > > > with the ID mapping approach?
> > >
> > > If the interface is extended with types_cnt, as you suggest, deleting
> > > types is trivial with sequence interface as well. At-least the way it
> > > is implemented by this patch, you just copy elements from 'ids' one b=
y
> > > one.
> >
> > But it is way less explicit and obvious way to delete element. With ID
> > map it is obvious, that type will be mapped to zero. With list of IDs,
> > you effectively search for elements that are missing, which IMO is way
> > less optimal an interface.
> >
> > So I still favor the ID map approach.
>
> You don't need to search for deleted elements with current
> implementation (assuming the ids_cnt parameter is added).
> Suppose there are 4 types + void in BTF and the 'ids' sequence looks
> as follows: {1, 3, 4}, current implementation will:
> - iterate over 'ids':
>   - copy 1 to new_types, remember to remap 1 to 1
>   - copy 3 to new_types, remember to remap 3 to 2
>   - copy 4 to new_types, remember to remap 4 to 3
> - do the remapping.

Eduard, from API perspective I very much do not like saying that "if
type ID is missing from the list -- drop it". I very much prefer "map
type you want to delete to zero". How can I be more clear about this?
I didn't even talk about implementation, I was talking about API.

>
> Consider the sorting use-case:
> - If 'ids' is the desired final order of types, libbpf needs to
>   allocate the mapping from old id to new id, as described above.
> - If 'ids' is a map from old id to new id:
>   - libbpf will have to allocate a temporary array to hold the desired
>     id sequence, to know in which order to copy the types;
>   - user will have to allocate the array for mapping.
>
> So, for id map approach it is one more allocation for no benefit.

On the libbpf side - no difference in terms of memory use. On the user
side, worst case, N * sizeof(int) temporary allocation for ID mapping.
400KB at most to resort 100K of BTF types, which takes megabytes
anyways. I don't even want to talk about the amount of memory pahole
will waste on DWARF information processing. And depending on what data
structures user code keeps for sorting indexing, this allocation might
be necessary anyways with either approach.

But this is all irrelevant. I care about the interface way more than
temporary 400KB of memory usage.

