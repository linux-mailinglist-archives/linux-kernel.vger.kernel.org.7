Return-Path: <linux-kernel+bounces-830588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3F9B9A0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDBF3B9535
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22952302156;
	Wed, 24 Sep 2025 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYMvsJgr"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531F218AD4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758720927; cv=none; b=qf6XNDyuHipl0evH5nPPmKH806+fL8Dvh/T4ngLkJpCjV1y3xwaST9sit228CTp3xH0BgEQrDWgmrnRrQ3ftymnMfllbX+7mAv0BFXHM0gDVtpEFJIwQpX87O5DacKbjmaSZzcHGh2d9BRjxyfFpLY048Po4ECh0Q5sevrJ3+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758720927; c=relaxed/simple;
	bh=KmA+ZlB3PPUevAH0ozfRwMtw7syrS0981/eiRP93wNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIjszgY3Mg8wg4pp9+sZ7/5dZmBvLIIB30oWJWTDw52pPJy1VxBMTpmMhzqB+2PqeMdx5Mslip+35uRzdTdXEgGsnhrbJODooHIFUHEQRbFjvOjUChjGnY1QIuKkaYW8ElvBbxCUp7jzL7nqwcAmWogcEcahMobG6q0rtAU/PoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYMvsJgr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24456ce0b96so12118705ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758720925; x=1759325725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe50O/RrUQLZAFgmjB7HU4D9kzr+KcVI1Eg33NkTII8=;
        b=iYMvsJgr0VUpKShL7Lzarsr9QpSlMltPrvw/kj3bCrhvafo6EDcUxoodaRsaUgbEvV
         oj83EyypeA4M/UheXO+Y3im0CxJlPGUTBQ5vrJ/3xlD6urZ4ymhmEwhAgrweSm3pLzjS
         wQUidfObTf+83peICbRmz2C06K/fzTAtZK7ZUtpG1enH8tL6UE4lTh6TnBB8UsjjEmYN
         P8fSO+LkUEfGBiU8P+MK8dWXWvVhTJ9Ta8ny6A4dl9cGxyuIAAGb4ixZioV/YC+Kf8Xf
         YrO9IXPn2S1PJn8eUlyfuoLfZ6J7ie66nSc03UL7bdUXm4nTQflcPhG9uBIu+sATCio8
         bV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758720925; x=1759325725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pe50O/RrUQLZAFgmjB7HU4D9kzr+KcVI1Eg33NkTII8=;
        b=HFTzSFUZnr32o1PMR2tcf4jJAhUhC3ZWIe33KDGrKk4zSnhKXD9ZzbSvehtFAjlGpt
         rjUZWSb/l1YnuOXQGK52ycVxJbYr5HKCUYYD8v81PL2fFUTfchigpXZ2vXuU/sjf2Bmz
         DX1XbpuNln2OchxO2otLcqw8tPWqd/3627KGq6DT5NN/CEQmeiAGEhS92i/QFmmdD8iz
         fHh9C0Lk43ZCNAtlZK8sifMhenaErr46qL8OdRua0VF72FdRFBxt7KEnfwKk+VxP74J0
         dQfE4sdayIKf6RwUSNPl7NVjs4rH19Pk/HowTk1DpccWoTOG3XXrVIIN+VRamTzql+vM
         b8Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWp2/Ibu+GLC9AkR+medj46sM81BadB0S2BkCESKrLb61Yj5aCoFiIhTddJQkGjgOkVvR06pnnrBLA60Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+G3mVe8ygRvFmC58ITxN49mcOKRgwk0mcO454lFCrd3EsBsp
	rvocoIdyQbSN1iWhhOkA2GpN5rHkCc5xdkKocyTnTGYu1siw7XLwDq0qlrM4pOCX6+P7VMizcyk
	GO8DbQa+8DwsEE61G8bC0+U3TJXwGgjQq2G2VQ9gdRuqfHUscHsi4yR2/
X-Gm-Gg: ASbGncvy+k2wRCKF/1AD6TYbQosI6NKL64G3xfiNFHGUcpVFu3NTJIkvfVrYP6P159t
	te5Ojl0x2nyYKIrz73wEu1bZbmJHXQOe1LmvaZ04w6rT7mvcw5s1UsCd9l2u2aQ63P7/sw9b27j
	P2JJg+5GsQZIolJheAyHEfOwBeir+kwNZe2EtGlPcPDmbbqqYIJjSksuQvtnF23B2hChkYLhDlZ
	ZSlKfS9/DZJDTttB4kaxWle2CQIvKgyb1zMobap7P1R
X-Google-Smtp-Source: AGHT+IEZB79FDy23Au1RBe1FRu0hDgBKlEfPABN0JOWEdfyHHG/R0n9grDY3ffSzMtedVDlArhR4HwkfTvUWJ+J5oOQ=
X-Received: by 2002:a17:902:f64f:b0:274:823c:8642 with SMTP id
 d9443c01a7336-27ec1199cbbmr30080495ad.10.1758720925041; Wed, 24 Sep 2025
 06:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924100301.1558645-1-glider@google.com> <8f0366c8-f05e-4687-817f-90a5b47922c9@web.de>
In-Reply-To: <8f0366c8-f05e-4687-817f-90a5b47922c9@web.de>
From: Marco Elver <elver@google.com>
Date: Wed, 24 Sep 2025 15:34:48 +0200
X-Gm-Features: AS18NWAZTmBr2I7oYM4SLQ_DoH6Vcj7XLTdfUyItYT_CFFhymyeJQEwdn2xWFgc
Message-ID: <CANpmjNO8J_cN-mCepSsqkG+az3QKbxZvD1zSKi29oi4prW9v5g@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memblock: Correct totalram_pages accounting with KMSAN
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Alexander Potapenko <glider@google.com>, linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	LKML <linux-kernel@vger.kernel.org>, Aleksandr Nogikh <nogikh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Sept 2025 at 15:23, Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> =E2=80=A6
> > +++ b/mm/mm_init.c
> > @@ -2548,24 +2548,25 @@ void *__init alloc_large_system_hash(const char=
 *tablename,
> =E2=80=A6
> > +unsigned long __init memblock_free_pages(struct page *page, unsigned l=
ong pfn,
> > +                                      unsigned int order)
> >  {
> =E2=80=A6
> >       if (!kmsan_memblock_free_pages(page, order)) {
> >               /* KMSAN will take care of these pages. */
> > -             return;
> > +             return 0;
> >       }
> =E2=80=A6
>
> How do you think about to omit curly brackets for this if statement?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-style.rst?h=3Dv6.17-rc7#n197

No - with the /* .. */ comment there are 2 lines in this block.

