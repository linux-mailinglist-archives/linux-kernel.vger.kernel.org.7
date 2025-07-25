Return-Path: <linux-kernel+bounces-745715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE4DB11D74
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C765A4260
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD2F2E54B9;
	Fri, 25 Jul 2025 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yXXACg52"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED7A2459F8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442736; cv=none; b=mMwoU1/pIg5ea9rjLpFOPinr3W+6QCi8aOtHWTLQjKHKpxiKrLbG9L8wqN/hzyHIfMx9Y055MyUQLfRvqRlVrsXxAE5h1eLaROVGXm+gnOgl42+fw8J6XVfgsgmkuwToboi6CjOZG66zvSY6DixYiYjx0fkVcHm1zR99MFRg6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442736; c=relaxed/simple;
	bh=vXukAKvSPpxU//OveqUayIdA0h+YnOjUlPQwaaWsaE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m31RYAWIfhps3GjiV5pC+DuR11sromXEBddIR1h0BKxdWZHBmfLocTy7b2ZwkSp6D3kbzYPWZT2tVu6nxHcp2NwsVNwnTTzRcfj/lzKPQ61RZ8uX/DtCtm3Hc1ZuQGOHCRq0N9lM5PahE0h3SqQzU5hRIyEP53JCCBfn9EZcFkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yXXACg52; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso9156a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753442733; x=1754047533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7JKBcnXvS7c6EV81hpTMLSU1ROPxxQf8xvSxkWCs9E=;
        b=yXXACg52ZWQfn7SPUYrj4hAywUfN3zn5+n1Fxh1AmS8+f421fwUR/0sxwfChPHNcod
         zxagoLCpohA2UkxtjtgQiFCE2StunEjZm/jlSAw5JgAtyiqtDOqKzYNt63iVGejQPg7Z
         bqxauywHZwVW71pFl+mx/r2hqo33Zsz19i+YdZjfBV3e1ZWcspFwIBquOeVvU2bapMji
         NB01ZcVm9Yc4JPoJg9lQGr2Fnj1H+3BuT6CIeWQk7uGpdLKqs1FJezzN9iUvFSwGHMF9
         nHcRRKs0o6b6lhiIXBxP3JgbMBiBw4Ntt6vx/nkPlxGOKmupn/FRv9G2Lox01COTvcTd
         I9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753442733; x=1754047533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7JKBcnXvS7c6EV81hpTMLSU1ROPxxQf8xvSxkWCs9E=;
        b=qq2bKwkbkREo6PFbt8eODlZ9eg+mOKLkgP37aF7Q5/z/avFB5F493HtP/lkJnjQ09T
         WnT1aGOqs9EQTABaFwdUqaKzYadipeWLmafpgZIkwRsjPWa16qxmNo9CX1u/6+c+CI2C
         heFI3YL1uoa3YuketwczYqG1bXYMOR+la2E8s8Ubd1jPiQvFfmgMPaG4ehbhY4sg3P6F
         tZBp1bHLW7I1BsMk1LHaBXrrytGM4O1yGjrCkmmEXrEM+QyyOKPe53DhYOGcIbe/93Um
         wrMXpffWAlO2J/583U4OVkHy2EUyoMqDOvKjNyETB5SON4I05vj7KjjbihydVulklvuV
         Yxbg==
X-Forwarded-Encrypted: i=1; AJvYcCW4aQdgdYFr0HEzCwx1kdsz2QikuSg3OOeu+2gw47k42OtKGbeCdKimOhNVnUdKS0XhsNz/m2A2sdnRsvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/2OYCaKjuXDY3Q+Akva/QUFBIWmt2PUuVPJ86Q5ZXf55ucbN
	oEUeB0zhZFHrdxuQkPYsSkNQR4y0zdEMBCTmQX0v4g4FnZt2/WkGa5F6tiiljGRMLx5nE4lwiYU
	ojeU90y6NIJPxLAa0Aki+Op/PrrTgvmeKwakwL56u
X-Gm-Gg: ASbGnct7lCi679BCZV+3RwjmUb3nqWKItJv6GF8MTzIb625Hp6dCNrakGqxs3b/s65e
	Not4eN7URkzOHXaZ8M0RchVxPFglrABbIDH8dliemis4oHqSIAOcl5EBjjFwLoWGxcYtIMWl6CP
	PzBZ3IWgDLYfucVH3no6l4m+XKgguHSd0f6iw4kuvR4w5tdbeZdMai+K45AqeRUzsPQfT77k3Ri
	fwGqAma6KPLXazHbMEriyIVsEBh6km9e+U=
X-Google-Smtp-Source: AGHT+IHu/Jxe0tRupMk8sata71Dj4GlEaCewOSkFs48tGZQjsE22y5CxcO9LxASkhWClWF59p30fdxQ7Yp6zw9xnWhg=
X-Received: by 2002:a05:6402:26d1:b0:601:f23b:a377 with SMTP id
 4fb4d7f45d1cf-614e7ae014dmr87648a12.6.1753442732938; Fri, 25 Jul 2025
 04:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
 <85c4a092-14df-4478-811c-f3789610e4b8@redhat.com> <CAG48ez1O+7ciCNDVnh9MPh_1_1TLWd-=H9L6p90J_9AEbav27w@mail.gmail.com>
 <bf29d398-5f7b-449c-b142-cf9873a5b183@redhat.com>
In-Reply-To: <bf29d398-5f7b-449c-b142-cf9873a5b183@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 13:24:55 +0200
X-Gm-Features: Ac12FXwcKoerpomFAjOzM4_F9BiaBJ1IxkwRsdKpHovHfzexG6clt04_fcJZefk
Message-ID: <CAG48ez1=rd5W5SBAyyqu-=50AsRGg8pdYW5BZ4SFhHqFYOHbyg@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 1:12=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> On 25.07.25 13:08, Jann Horn wrote:
> > On Thu, Jul 24, 2025 at 11:56=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >> 2) We have a folio here, so ... better
> >>
> >> if (folio_test_anon(folio) && !folio_test_ksm(folio)) {
> >>          ...
> >> }
> >
> > Hrm, okay. It kind of irks me to write it as two checks when really I
> > want to ask "is it this one specific type", but yeah, will change it.
>
> Well, ksm is a subtype of anon.

I mean... not really? At least ksm folios are not a subtype of normal
anon folios. Normal anon folios point to an anon_vma, a ksm folio
points to a ksm_stable_node instead, and you can't treat a
ksm_stable_node as an anon_vma.

