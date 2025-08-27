Return-Path: <linux-kernel+bounces-787534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B00B37792
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FED01B64A60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3231C248F72;
	Wed, 27 Aug 2025 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9NsJStQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845B286A9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260743; cv=none; b=QBhmVftxlwf6YUJt92oOSOIK8nJVuQb2AP2aqytHM92YooEUdN3ZVVuKve0d7dt8cVrqAKbhdTnR3POB+aHlSj/0YupY/6PoOZFa7wxIbOziEbu0+vUU2lNUjSp4Egjj/n0Fku2SZ6KxoerpblfeS52cTGUYhz0+q7AUGE1vbOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260743; c=relaxed/simple;
	bh=q3BHnTyprndOuKphk/986OLRZxR8Lf0Nb5L1CnkrEIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCXaJ1NBYcJ+aq0OPx//RpNwW2Vgf3NeNkM1AAZbiQwalXC8hSNStyFG/hdan6t0YZ/bCT1DdqQRRvgqWnzqphzvRC8hFAN32q7itCGnrZaI/T2sHClhRCXzpbTjgAvzBZy77I5gUs/wBqu+iFgc6ZcS+gG120JPKomqIZyNzdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9NsJStQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BA6C113D0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756260743;
	bh=q3BHnTyprndOuKphk/986OLRZxR8Lf0Nb5L1CnkrEIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O9NsJStQ4Q1w1TG2G5Ijni7Gm7CF8SUUTRJf0rDWlpomG0JQ5O6P5Cad9ZkqtQ2nD
	 C3PkIOCJfEDGFAbNSIj4FoRQPzR7xeyhZshY1D43Fu1q7EaT1R4IWp4cTg3AxP21C4
	 fKI1dfmDzGxjUXtEtS576GlgOItwJoR8ZwnEiM1+s+RYG1wuMWBU5MzirRKqiI7eUX
	 +jwW4ZYNibE+1wMTUF5DH47wakIeyv93bGMu6qxbngdV2jNzGBa3CgSRI33Tntawuh
	 GJzGf3VY/OG3q3QpONjsMO6N8JPhFy9S4sMOAgJlAS2NF1Q/dy62p1g8iOu3HPR5Ur
	 Ps7O4+2GbhWCA==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71e6f84b77eso51207857b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:12:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW31g1xoRNiZIXMLDckPqivDzrxQIsWVH/7R0sgBPnKQ3HKK9ebaMj+QEjVJYyXruPJYdTDOLRZEDqggS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkjLWv/Ie766rPgqcY0yQEvdM5EFPcFQpMLHAY5upfivyGTBtq
	NZ3xwfxxn8yZafZO5ubjxLtTdO4rnhDY6EV/0ac8kdm19qM6ql1TK71tCj2oAPxx/1Wv94FlI7M
	vX/Jg44OqOmOBDBG6prIrYEpaXw6UXBEsMc8Olx9FSA==
X-Google-Smtp-Source: AGHT+IEDyAmgqIwD4iHxr016hc/sN+CLBgPqqTEe+4xgcqDUeB/dlcmPyaawZhUoORiYlJxetixb6mEsNqqbhawFvw8=
X-Received: by 2002:a05:690c:d82:b0:71c:4091:3c61 with SMTP id
 00721157ae682-71fdc30b412mr220214347b3.22.1756260742402; Tue, 26 Aug 2025
 19:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826231626.218675-1-max.kellermann@ionos.com>
 <20250826231626.218675-2-max.kellermann@ionos.com> <BA16C3BF-C843-4976-8FCC-159324B2E477@nvidia.com>
In-Reply-To: <BA16C3BF-C843-4976-8FCC-159324B2E477@nvidia.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Aug 2025 19:12:10 -0700
X-Gmail-Original-Message-ID: <CACePvbW4AG5nyohmEMS1BrmJNm+Xtaz8_rCCGdSu9Y1iOG-nqQ@mail.gmail.com>
X-Gm-Features: Ac12FXyA8McbAPcgcSwRJ4XPhqPTQ1ZXjfdNh9v53BJi2bHEYOaY-70OWXZymKE
Message-ID: <CACePvbW4AG5nyohmEMS1BrmJNm+Xtaz8_rCCGdSu9Y1iOG-nqQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/swap: add BUG_ON(folio==NULL) to folios_put_refs()
To: Zi Yan <ziy@nvidia.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org, david@redhat.com, 
	lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 6:43=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -952,6 +952,7 @@ void folios_put_refs(struct folio_batch *folios, un=
signed int *refs)
> >       for (i =3D 0, j =3D 0; i < folios->nr; i++) {
> >               struct folio *folio =3D folios->folios[i];
> >               unsigned int nr_refs =3D refs ? refs[i] : 1;
> > +             BUG_ON(folio =3D=3D NULL);
> >
> >               if (is_huge_zero_folio(folio))
> >                       continue;
>
> We are moving away from BUG_ON. It is better to use WARN_ON_ONCE and skip
> NULL values:
>
> if (WARN_ON_ONCE(!folio))
>         continue;

+1

Chris

