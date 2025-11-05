Return-Path: <linux-kernel+bounces-887101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38142C3746B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D933E34F745
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714AA27EFEE;
	Wed,  5 Nov 2025 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeWbahfb"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680E1F4615
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367000; cv=none; b=qPF/ULyx1JG7ZY9HQulJ7awcq71tn9JgC9irQC6cGXNt4M6NCt0qPNwckTa+he2+QTCJqJsryAkuW9f/+NzFwGK2F1CknqTM78uiAX8AIiKG9BAcAUQvMhxQKtrffWvR9sP4hy7YR0OloPjPFHOCdyy/D2eLlPaxvcrWL7zhzoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367000; c=relaxed/simple;
	bh=3KfdeDCkxPirJP5G8B+k+8dHJWpq87MLNsOmMJq+WiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggRJMcarbM3CdkjKEdfRWTYfjGSHdBZ/hN84EyNk5MjSQPxEbUBcebn6oNVK9dTCHxur91382sQcuRi286fkXhmUvNZuGux0IBj1eL3ajPu3w9zLEYjMjgUXO+j7Avb5t3g7ZD5TnbrUKUAXyGCzRgHISCOPytoeDUHWPQFrB60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeWbahfb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso160139a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762366999; x=1762971799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8L0EmVHhhJKGUNrk8uuznnTiiDeQRmwD90hsequsj8=;
        b=aeWbahfblLzQXXxcGtLunqn8q1jtm0afczP8RV/9tph67Dk1BlbM6iTDDn9ZJymIx3
         77tgd1NomMUsuY1EoWgD0yHqEhrpTERmUM0/8N8ZcFGpEALE/rnt621xboPT31H8GcQG
         zWvx1jx4AyyQH9YcjJf8PmqOC5BEAkKPBUtIar3yoM0iU8YUt5W2zlTjNo/qjN8oW8z5
         7FJUmHIVVBKo6dPrIUNMNb+ihjGgKKIP22YdQpAPb/g2tMCsRKU8WhVEEdwt9hwDBBsg
         cUjmdzFer3fMex61cj1mLIxHPop+9xD4UwFmOjQXuk6rCc+uKKcxJ1ztxCcO592SMNOd
         2yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762366999; x=1762971799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8L0EmVHhhJKGUNrk8uuznnTiiDeQRmwD90hsequsj8=;
        b=TzSyB8IeCvT8DwiIhIxDPuDPpCI6wL/se/G8/SDjUmc5uEnZgtx08+Ixl9jer2GjsS
         sr/brHZJbT4pUUIk3wU84Smi+q65uV8wdHpnPgSOPDlehQ5cMbIHJgNmGbbFM/auZA50
         okRele4Me63tqyOVRcHbULJHaI06HGsYufBGttLkvCkIgXoiN/2wnM3rvrB34IGJvEuY
         CZ8NnV/6H1+9KoUxD5trawWdO0eVesOxC+uql1VGIULpDiSfySac8z88E64MhPSrhjoq
         JxYnuPqLPxMMspL+aSVY+ngw27iCWPHM39Ewu4oIeVYRZmcSpXBFXeeO/9MsfWaqgP/K
         Y5bA==
X-Forwarded-Encrypted: i=1; AJvYcCV+XvacZYpMnByrmAy8YY5pKoaZygnyFpOpUsv3GhP9ABxOzrH18GRCoulaFKM31cuuNEn31O4eSWZksa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+nTaSHIA49QxeT4tR51uiWXaRhtcfsUsvOZolHPi5BidGTd7
	Hx7O+pe/5qtfE9SUJDfM0dXuDT8Fyr1ZKsYDZILZ7YL4JMt17q4qYS7b7nHY10qdcjghUwOq3UE
	yOuZPI5P3/FNcAn2YBUnASiy58RN3dkg=
X-Gm-Gg: ASbGncsbT5cdcjkCs17jH7vsw0+V/9KgvbBkTUZu9VlVxhzoeO+GpFwFa1nOoxDiKB/
	ynhkAqTx4PWts1IAWaUUmjtfT03WeyI9bFfSbiR7TGd0Pe78uqTjwIxG6523vzZw5kRSU+3vMOE
	3OTLnOIbHRp7ZHe0lsTPp9gHVvb/rBNKKwQXCLhirjQD0NjNTqWCe8Dp35cwHE0XLJoHsgYDpZg
	guGAk5VHwoIrlhnRU1PTf9iaT8CMIq8egx2iiHdegV+y7+puidw1aBM/y0Z
X-Google-Smtp-Source: AGHT+IGTdA9jA3vdzTOm4cTwDADd0hVqS0/EwfzpQKuYZQ4mf3xNIHY2fUJHUORnJS81UwEVNH8+AF0EN6DSpLzGXEE=
X-Received: by 2002:a17:90b:48c2:b0:341:8ab9:6882 with SMTP id
 98e67ed59e1d1-341a6ddeb10mr6100325a91.17.1762366998600; Wed, 05 Nov 2025
 10:23:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-3-dolinux.peng@gmail.com> <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
 <3986a6b863be2ec62820ea5d2cf471f7e233fac0.camel@gmail.com>
 <CAEf4BzaLmVuPRL4V1VKBmaXtrvT=oLwo=M7sLURgoYU34BkpMQ@mail.gmail.com> <627795f165b1e66500b9f032ed7474125938f33a.camel@gmail.com>
In-Reply-To: <627795f165b1e66500b9f032ed7474125938f33a.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Nov 2025 10:23:06 -0800
X-Gm-Features: AWmQ_bkPAHtnYydkcP4AkA4VMxCT-05StVeEbmBh-ZvkNDn-bJ0EZ0DUc5vlAP4
Message-ID: <CAEf4BzbVU2sBw4aSOB1+SdKN0Qe-WEtDKo3wn21C6UjfSKiBdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-11-04 at 17:04 -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 4, 2025 at 4:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
> > >
> > > [...]
> > >
> > > > > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> > > > > +{
> > > > > +       struct btf_permute *p =3D ctx;
> > > > > +       __u32 new_type_id =3D *type_id;
> > > > > +
> > > > > +       /* skip references that point into the base BTF */
> > > > > +       if (new_type_id < p->btf->start_id)
> > > > > +               return 0;
> > > > > +
> > > > > +       new_type_id =3D p->map[*type_id - p->btf->start_id];
> > > >
> > > > I'm actually confused, I thought p->ids would be the mapping from
> > > > original type ID (minus start_id, of course) to a new desired ID, b=
ut
> > > > it looks to be the other way? ids is a desired resulting *sequence*=
 of
> > > > types identified by their original ID. I find it quite confusing. I
> > > > think about permutation as a mapping from original type ID to a new
> > > > type ID, am I confused?
> > >
> > > Yes, it is a desired sequence, not mapping.
> > > I guess its a bit simpler to use for sorting use-case, as you can jus=
t
> > > swap ids while sorting.
> >
> > The question is really what makes most sense as an interface. Because
> > for sorting cases it's just the matter of a two-line for() loop to
> > create ID mapping once types are sorted.
> >
> > I have slight preference for id_map approach because it is easy to
> > extend to the case of selectively dropping some types. We can just
> > define that such IDs should be mapped to zero. This will work as a
> > natural extension. With the desired end sequence of IDs, it's less
> > natural and will require more work to determine which IDs are missing
> > from the sequence.
> >
> > So unless there is some really good and strong reason, shall we go
> > with the ID mapping approach?
>
> If the interface is extended with types_cnt, as you suggest, deleting
> types is trivial with sequence interface as well. At-least the way it
> is implemented by this patch, you just copy elements from 'ids' one by
> one.

But it is way less explicit and obvious way to delete element. With ID
map it is obvious, that type will be mapped to zero. With list of IDs,
you effectively search for elements that are missing, which IMO is way
less optimal an interface.

So I still favor the ID map approach.

