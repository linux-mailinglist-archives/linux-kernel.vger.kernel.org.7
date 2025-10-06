Return-Path: <linux-kernel+bounces-842617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A0BBBD294
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 08:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C785F4E9830
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 06:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF99E253B67;
	Mon,  6 Oct 2025 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sdv2jzyS"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B244C63
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759733361; cv=none; b=FhF2ZEAYOpe197/9EB3+DLvViWcJANDoTwI12xoQvUHcznBX6acGzVk87DpjUlsqe0w/kcRfluslS/krOu7IGpNyPTR4tNYEIADUyj/ZjuGfjIsvW5oDS4/bWseruOa8zMfJ0vmsDPmAciKlGvUNDGcSSPAf1sOui5e7uxgow6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759733361; c=relaxed/simple;
	bh=KA2cCtw/giRS65DmoAoav+O5aOXSCY96ipIDt96NZ/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMMqeCfKKW2MfrB/G8Ev1VdeOVqoSZRJNf08j+qgR4Q6yQ0hjtHtoH8x0LI18csJQByxFTxOTciXfEbhfx9RDwzM6kqpcFNt28He2fwRV+mkUI2CfY9AV8an/5T1u79EmU+9Z9drPICB9BdPQsdiLYTunedInJJ8NLYI1n9i9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sdv2jzyS; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCW6vesnixN3sUZX9/4rlnGXAnlbDm9VYnwWQsAxkaC17QmsDmZwFtSxQSQ6Elaf2dt2kTl1G5/MGku0aEs=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759733354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zsEsH22kDW1H5QvOcVfkUjtWSR98Rm+2/OnZ+CB+v1A=;
	b=Sdv2jzySDkyhcXu40a3FFoK/fvsL1rmwp0YqG0e0M8zzoq0/+QOjjm5OAJdDbASTlJPjPv
	kC4UyTcJ/1fPjgmr7+5XATCWP5SRE0yF/3DqtfTUHlwaXWXZKh1p8AN67FcCuADKr3a7kY
	sBDzyATGlAjIlGGB+aA3jDLl5p986jg=
X-Gm-Message-State: AOJu0YzZa/5PnvLIk9sVg7sOW/7OGNFZ2p86jBmsz2qO1qG3wL3Py5UW
	aFXplz7QpYEzvuJOWi8Z80MXrBdo+gtZqyT8X91ejqNCxUVO1i4OWgG4DXhyoeLlaYhypSkftNb
	7vpbI2y9QPX9sYzMrzjgRpzXd56Xfp7I=
X-Google-Smtp-Source: AGHT+IH/gcahtyi1+R28TzwhM8PtxJZhWF/lZo0FhkNkmq0aCBod7bfx+312g6qjLNTYUImX2DAPVoxzuZOqqLk7Rho=
X-Received: by 2002:a05:6214:301b:b0:800:8e83:17ed with SMTP id
 6a1803df08f44-879dc77b870mr146020836d6.2.1759733351884; Sun, 05 Oct 2025
 23:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006055214.1845342-1-anshuman.khandual@arm.com>
 <4b513d32-7795-4998-98df-d398c3d5462a@arm.com> <1c948262-e201-4473-b156-8b90fedc9ce7@arm.com>
In-Reply-To: <1c948262-e201-4473-b156-8b90fedc9ce7@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Mon, 6 Oct 2025 14:48:35 +0800
X-Gmail-Original-Message-ID: <CABzRoya4kGWCFL95B2NEoLk4Qk9c3Vs1694NSWPFhiQiFHyomg@mail.gmail.com>
X-Gm-Features: AS18NWC1StCtK5OBsLdKS2Uo36btm8pgGL6VfozmsZHbDnUVCBhw4W8BmS1RLoQ
Message-ID: <CABzRoya4kGWCFL95B2NEoLk4Qk9c3Vs1694NSWPFhiQiFHyomg@mail.gmail.com>
Subject: Re: [PATCH] mm/dirty: Replace READ_ONCE() with pudp_get()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 6, 2025 at 2:28=E2=80=AFPM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 06/10/25 11:37 AM, Dev Jain wrote:
> >
> > On 06/10/25 11:22 am, Anshuman Khandual wrote:
> >> Replace READ_ONCE() with a standard page table accessor i.e pudp_get()=
 that
> >> anyways defaults into READ_ONCE() in cases where platform does not ove=
rride

Nice cleanup!

> >>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: linux-mm@kvack.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>   mm/mapping_dirty_helpers.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
> >> index c193de6cb23a..737c407f4081 100644
> >> --- a/mm/mapping_dirty_helpers.c
> >> +++ b/mm/mapping_dirty_helpers.c
> >> @@ -149,7 +149,7 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned=
 long addr, unsigned long end,
> >>                     struct mm_walk *walk)
> >>   {
> >>   #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> >> -    pud_t pudval =3D READ_ONCE(*pud);
> >> +    pud_t pudval =3D pudp_get(pud);
> >>         /* Do not split a huge pud */
> >>       if (pud_trans_huge(pudval)) {
> >
> > Talking about mm, why not also make changes for these READ_ONCE accesse=
s
> > in gup, hmm, memory, mprotect, sparse-vmemmap?

Yep, I agree with Dev on that one. Because the change is assumed to be a
no-op on all architectures for now, right?

> >
>
> Right, could replace all mm/ READ_ONCE() for pxdp pointers with the pgtab=
le helpers
> but that will create too much code churn in a single patch. Thought of do=
ing these
> replacements per file will be much more contained which is easy both for =
review and
> testing.

Emm... as pointed out by Dev, it would get the entire cleanup done in one
go, avoiding the churn of multiple small patches ;)

Cheers,
Lance

